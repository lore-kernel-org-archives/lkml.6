Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8262C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBA420865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V00dRRtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBA420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbeJLXl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:41:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34476 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbeJLXl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:41:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id f18-v6so6158301plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ez4SRIglukkf5nltCWJKGGJlZNrR6iJIm8371lpCNVQ=;
        b=V00dRRtIC7xIV4NxKDxNk6SxgUZwzcyRYYhEQaxcWWGdNXWhz0Jfy6tin6r2ac2VT4
         bzz9c/Op2W1MLN5t4+IeXnthPx9Qkr6Dk4qg4fBMLtVQgR6pOD3eMau4hBJAEZDeeEt9
         jAorwFSErbKQItJPxgoaooNCffe+DPzR1NSpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ez4SRIglukkf5nltCWJKGGJlZNrR6iJIm8371lpCNVQ=;
        b=tTV6XHTjw8b2d7z5F4GQ8uO5NOPnU0cmKaIrrVRK8rfk7lOgbSrcEWugA3eH4bNs+J
         PBhWLZCOxlBTswEkC6nPwvTpWEU4Etb/hzDYSqO/lKSF3odROr2KxPXxNbiLqiwM8TZX
         b2qdNiaagzlV+g27EnbQPSGePwN4JZ8Gxo81xokHa4Tl4n1s5M6rPAAyhQ9LDLwDB1mt
         86EL+CuBH5uXdd5lpfx3PYBUmX+mS7p91R29gCMrBgrsBzJXPaihCMdJU7riAuYWVZf6
         32mYCsFLsn/28tJ+deNC20iQ+ITuvCi6lRduS/ury+1R+USaaCdOynHu5/xT3zOe5xgZ
         IGMQ==
X-Gm-Message-State: ABuFfog2WWGTff1iwuofcmxaxJPoFel+dAna+lD3UtD5Xw+BreRDLbCx
        xNMHU6rlDTD08lbSM8weFU4K
X-Google-Smtp-Source: ACcGV60jAx5MebsVCQXP2v0kvSOh+vFe7K3Jfj+MR1f9DDvfpiS1rXKu23w/i8I3/wrLAxuhG7eEeA==
X-Received: by 2002:a17:902:d908:: with SMTP id c8-v6mr6392862plz.227.1539360527179;
        Fri, 12 Oct 2018 09:08:47 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:99a:7af8:5434:2d24:93e3:3797])
        by smtp.gmail.com with ESMTPSA id p84-v6sm2989091pfi.22.2018.10.12.09.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:08:46 -0700 (PDT)
Date:   Fri, 12 Oct 2018 21:38:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, xuwei5@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/4] Add clock support for Hi3670 SoC
Message-ID: <20181012160837.GA11560@Mani-XPS-13-9360>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20181012033857.GA5438@Mani-XPS-13-9360>
 <153936020982.5275.4942701350789062401@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153936020982.5275.4942701350789062401@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:03:29AM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2018-10-11 20:38:58)
> > On Thu, Sep 20, 2018 at 11:00:59PM -0700, Manivannan Sadhasivam wrote:
> > > This patchset adds clock support for Hi3670 SoC from HiSilicon utilizing
> > > the HiSi common clock code. While adding clock support, let's remove the
> > > fixed clock for UART and source SoC clock on HiKey970 board.
> > > 
> > > This patchset has been verified on HiKey970 board.
> > >
> > 
> > Hi,
> > 
> > Any update on this series?
> > 
> 
> Can I merge the clk driver part by itself? Are you looking for an ack
> from clk maintainers?
> 

Yes, please. I'm not sure about the maintainer for this clk part and it
is best if you can take a look and merge if its ok.

Thanks,
Mani
