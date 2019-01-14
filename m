Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9255AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6055A206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdW4nN+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfANRa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:30:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36696 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfANRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:30:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so10658914pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 09:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJSzlkW5Vkc19Rh6znhKJsama4nsJCCHrNm2OAli5ck=;
        b=hdW4nN+dqXXUyWzQBQfaCnF8M7ZOg+BA9kMSyh35cu7GzciLKwBC5O0iFDhnwAxow3
         1TGzPEmZRIe0UyZeVtOpSrKS8Z8LvGIuJYAVGn3t4G0GKO8e5r57mvGGuNOb1pf8ir/Q
         beqm5dWOQINILfGnyObCW+0vDUd/H1VV1obTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJSzlkW5Vkc19Rh6znhKJsama4nsJCCHrNm2OAli5ck=;
        b=X4yNF8UtyDpjXl05dbS4bB4lJUSA0djeLBW8Owu2TcPLs4qYidThGjjJRpscFhNTea
         DP1DwRlBv67cE+1J+FX/ukyYOLbIlFTTzTq9Y3QL32iN8ZqnNx1i+Jn8ypO1b2BkCyZu
         8MS54zc+cNvgtmybWWXeTPvc40OKN8HmodUxOTHnlprlwqeZlyQEhoNLXeUuehrWWMcI
         V5Z06nX1CtJgMM9/U7O0eHx80iI4aG5A/Ad9fi+ppC+Ce2RlGjCExSjhyOhRjEA+9vLg
         GhspAGdnCej7UXHhmKYhcCjjvTenzEftqTWW4UcnXBLtVrP1kMT8nQ0cEUoHlMX4VLwl
         VR8Q==
X-Gm-Message-State: AJcUukdW6XJpcUrC6McYtMFwSSoAmkn407YH2i+DGT7OlT7sL1AuZx2z
        2/NzM4DukR4h/5E50c6HyDILig==
X-Google-Smtp-Source: ALg8bN7d+mLHhSS1wEPdHERfi60Bb8f/7amdujcMI4wX+fPJo7UcKs7t1lvZKaq5BnaQQkuFPIztMA==
X-Received: by 2002:a63:295:: with SMTP id 143mr23106274pgc.362.1547487054348;
        Mon, 14 Jan 2019 09:30:54 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z8sm1169830pgg.62.2019.01.14.09.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 09:30:53 -0800 (PST)
Date:   Mon, 14 Jan 2019 09:30:51 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] scsi: ufs: Consider device limitations for dma_mask
Message-ID: <20190114173051.GA9278@minitux>
References: <20190111225402.6133-1-bjorn.andersson@linaro.org>
 <20190114111109.GA18673@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114111109.GA18673@infradead.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14 Jan 03:11 PST 2019, Christoph Hellwig wrote:

> On Fri, Jan 11, 2019 at 02:54:02PM -0800, Bjorn Andersson wrote:
> >   */
> >  static int ufshcd_set_dma_mask(struct ufs_hba *hba)
> >  {
> > -	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT) {
> > -		if (!dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(64)))
> > -			return 0;
> > -	}
> > -	return dma_set_mask_and_coherent(hba->dev, DMA_BIT_MASK(32));
> > +	u64 dma_mask = dma_get_mask(hba->dev);
> > +
> > +	if (hba->capabilities & MASK_64_ADDRESSING_SUPPORT)
> > +		dma_mask &= DMA_BIT_MASK(64);
> > +	else
> > +		dma_mask &= DMA_BIT_MASK(32);
> > +
> > +	return dma_set_mask_and_coherent(hba->dev, dma_mask);
> 
> NAK.  ufshcd clearly is in charge of setting the dma mask, so reading
> it back from someone else who might have set it is completely bogus.
> 

The problem here is that the capability bit states that the controller
itself claim to be able to deal with 64-bit addresses, which is probably
true. The thing that the struct device represents (the integrated
controller, on a bus in this SoC) doesn't.

The device model accurately handles this and carries a dma_mask that's
appropriate for the device in this system - the capability is not.

> You either need to introduce a quirk or a way to communicate the
> different limit so that it can be set by the core.

The system's limit is already communicated in hba->dev->dma_mask, but
the ufshcd driver overwrites this. I expect that this would make sense
if the device model claims we can do e.g. 40 bit addressing, but the
64-bit capability is not set in the controller - in which case ufshcd
would accurately lower this to 32-bits.


I'm not sure what to quirk here, but will look into this...

Regards,
Bjorn
