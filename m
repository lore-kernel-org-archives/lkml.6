Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4BFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008C521852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 01:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXggc9Ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeLSBIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 20:08:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46917 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeLSBIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 20:08:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so8616464pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 17:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xF+qhuidQxISFMYFLIn3TALsBb5TiRIiVQQ3YBPs5VQ=;
        b=gXggc9HtiZg8WqIX9jM00BcSReFdfAeMQmV5HEFx3qhz8+ZMhCDoXcKJ/D6hlTmqqK
         qBT4i44pZ1IjDTq/jirH8R7FCkRD8h8QqTeILZIA2UQGQYyO9JZCfriGmX4K97Z9OlVE
         0h0FgwbHIlUtbsn6bF9OD4tGAvglef+CcXcTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xF+qhuidQxISFMYFLIn3TALsBb5TiRIiVQQ3YBPs5VQ=;
        b=ZnAesxFmLCM3ET07xXQIIpJbpG4XGBnBpL/zfvlPjlNGzAehH1TgYRk2dgKr0KT8zl
         tSYjgykGqkM8FdLDOdOAiiCBhNPeLnirSubF7VmBzQv7G1b+SF9duqKdCQhRv7gm1kpC
         2wlKLTHJQ4XOr4F5fuQ8VlkmaMjdfbwNWFFkd+ttCU88WzkpBG7rp7sBdg2jiSrJHW/Q
         qHanfp64ZPDBGe3BWEyrn7b6nnwpQNhLji6MgDqlHovb64ieg7NFqB2KIBHLYAxVY2/F
         dJyHS890+2OeSINJwEE+t5lel6LugloVhUfu/3ABWFDFSr7tWtDYVFj3BV2X5t7MdvqI
         rDvw==
X-Gm-Message-State: AA+aEWaEsggIgMXZbjMC+8QghgzXCGxdtlvuXMyb/A8xrXpDSZY7RnCH
        reMBCkHw8L5TsU6cTQkin1BTVg==
X-Google-Smtp-Source: AFSGD/WrJj7D8HoE6E18NQXaKeWrAJk2g6tUxJEBMrnR3pBNkTFWjvI6f9NO/+iriO5KoikSEwUbSA==
X-Received: by 2002:a62:32c4:: with SMTP id y187mr19394306pfy.195.1545181727512;
        Tue, 18 Dec 2018 17:08:47 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id t12sm24540991pfi.45.2018.12.18.17.08.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 17:08:46 -0800 (PST)
Date:   Wed, 19 Dec 2018 09:07:36 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181219010733.GA13489@dragon>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
 <b0d02b1c-cc44-69fe-0765-84caf76eaea1@ti.com>
 <20181204060104.GA11391@dragon>
 <20181217003434.GA7208@dragon>
 <c5ccf173-d0f3-70f4-f8e3-777fd3339b68@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ccf173-d0f3-70f4-f8e3-777fd3339b68@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 07:46:13PM +0530, Kishon Vijay Abraham I wrote:
> 
> 
> On 17/12/18 6:04 AM, Shawn Guo wrote:
> > On Tue, Dec 04, 2018 at 02:01:07PM +0800, Shawn Guo wrote:
> >> Hi Kishon,
> >>
> >> On Tue, Dec 04, 2018 at 10:38:19AM +0530, Kishon Vijay Abraham I wrote:
> >>> Hi,
> >>>
> >>> On 27/11/18 3:37 PM, Shawn Guo wrote:
> >>>> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> >>>> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> >>>
> >>> Is this Synopsys PHY specific to Qualcomm or could it be used by other vendors
> >>> (with just changing tuning parameters)? If it could be used by other vendors
> >>> then it would make sense to add this PHY driver in synopsys directory.
> >>
> >> My knowledge is that this Synopsys PHY is specific to Qualcomm SoCs.
> >> @Sriharsha, correct me if I'm wrong.
> > 
> > Kishon,
> > 
> > Do you have any further comments on the patches?  We are close the 4.21
> > merge window, and I really hope they can hit mainline with 4.21 release.
> > Thanks.
> 
> Aren't we waiting for feedback from Sriharsha?

I think no correction means that I'm right :)

Shawn
