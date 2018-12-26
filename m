Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C248C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4D821741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAjSoCts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeLZU2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:28:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35326 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbeLZU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:28:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so8228451pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KhirqufjEAKM5oH8ZTyukCbgwkV6FFyPZD8bGeSML24=;
        b=CAjSoCtsEBEMhbX+rpcbvaBDg0ZarjdOLhgnuWklQqwVw1XfEHw3nu9tYePgBowsWz
         UGQ7Il42en7LcAVd49cFQbwwmZ+Js4iILVBujMumYltW7e5CLXsJijLNeF1jGnDK6l+j
         4MYYdCnefotmODedzmNDKcIc8JbUrCjgQCEWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KhirqufjEAKM5oH8ZTyukCbgwkV6FFyPZD8bGeSML24=;
        b=UNjcqSi8SGdr6kbyfa0GUDZi8PE+cPa/wkVBxmxZEmIJCs1IURvYuBDh/6nUezgvj6
         CnB6Uib/cVZFRMWXlTNpnNNzk8SbcTfb7KOe2XpljPc+cfg22LIuSpCSKQezSeP30cXM
         4yniTAGAuO3BwSIFE/UjnSNFzr85kAZg005hyLnKsERoUpQJuge0UK34HY2hduD3Jd63
         Q4f6PPjaP5N9d0sqBrmiUIZDzUDebnckdSmR11RyvvPoa7CRODcIV1D00sBa2YhJiYl3
         7IFPFlnbV9sQjKyEOoGhIUJ0PVW/BQqvRHftnxlTb0AwOYx5+0aPniD8Y6NAaokfHjzd
         1JWQ==
X-Gm-Message-State: AJcUukeqY9xr3cwJ0b3DeM2BuaWE4KvvcCKdN/0ONUUQEFHekh8AsAL6
        WZ6j8JtqfpLPnuKbLS+XR3WNQb8IxN8=
X-Google-Smtp-Source: ALg8bN4KLTWbvLD06MTk5aueksHt1ABYy6Ly983prjyGXqWp7TxJdkO0MpU4foql+UhW41W4rLhRLw==
X-Received: by 2002:a63:4c4e:: with SMTP id m14mr20339753pgl.173.1545856113565;
        Wed, 26 Dec 2018 12:28:33 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m9sm41818013pgd.32.2018.12.26.12.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 12:28:32 -0800 (PST)
Date:   Wed, 26 Dec 2018 12:28:30 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] soc: qcom: Add AOSS QMP communication driver
Message-ID: <20181226202830.GE9704@minitux>
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
 <20181112080557.22698-3-bjorn.andersson@linaro.org>
 <ce0d4d55-464c-1502-9dc1-b3a495c86aee@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0d4d55-464c-1502-9dc1-b3a495c86aee@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20 Nov 04:22 PST 2018, Arun Kumar Neelakantam wrote:

Thanks for the review Arun.

> On 11/12/2018 1:35 PM, Bjorn Andersson wrote:
[..]
> > +int qmp_send(struct qmp *qmp, const void *data, size_t len)
> > +{
> > +	int ret;
> > +
> > +	if (WARN_ON(len + sizeof(u32) > qmp->size)) {
> > +		dev_err(qmp->dev, "message too long\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (WARN_ON(len % sizeof(u32))) {
> > +		dev_err(qmp->dev, "message not 32-bit aligned\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(&qmp->tx_lock);
> > +
> > +	if (!qmp_message_empty(qmp)) {
> > +		dev_err(qmp->dev, "mailbox left busy\n");
> > +		ret = -EINVAL;
> should it be -EBUSY ?

That makes more sense.

> And qmp_messge_empty will be done either by remote if it process the data
> else by this driver in TIMEOUT case, so does we need this check for every TX
> ? I think we can just reset to Zero once in open time.

Didn't think about that, should we really make the QMP link ready again
when we get a timeout? Can we expect that the firmware of the remote
side is ready to serve future messages?


Should we keep this check and remove the writel() below?

> > +		goto out_unlock;
> > +	}
> > +
> > +	/* The message RAM only implements 32-bit accesses */
> > +	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
> > +			 data, len / sizeof(u32));
> > +	writel(len, qmp->msgram + qmp->offset);
> > +	qmp_kick(qmp);
> > +
> > +	ret = wait_event_interruptible_timeout(qmp->event,
> > +					       qmp_message_empty(qmp), HZ);
> > +	if (!ret) {
> > +		dev_err(qmp->dev, "ucore did not ack channel\n");
> > +		ret = -ETIMEDOUT;
> > +
> > +		writel(0, qmp->msgram + qmp->offset);
> > +	} else {
> > +		ret = 0;
> > +	}
> > +
> > +out_unlock:
> > +	mutex_unlock(&qmp->tx_lock);
> > +
> > +	return ret;
> > +}

Regards,
Bjorn
