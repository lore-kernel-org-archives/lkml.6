Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0352C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DC620823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 06:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNqghkty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DC620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeKSRSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 12:18:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36868 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeKSRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 12:18:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so13397431pge.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 22:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8N5KPdeuLrJ2oX5+LNZRUJIrjO04cY2/r7WrlkDx5L4=;
        b=dNqghktyOKaixevZYPOnjnzf1Kbk/s90iSnUjzsKUWaKt46wCbki6UOk9YHK77XaH4
         nhq6P3tw71eXDMO0Rrp4Sv1XZKv+KUaSMDeVx/BNQ1BpPRifIMblg1pubc9UC0ARiOQU
         PHoeFFrPrpZyiUbKW0XzJNPjjPG9O46FEs3aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8N5KPdeuLrJ2oX5+LNZRUJIrjO04cY2/r7WrlkDx5L4=;
        b=qCmCWOMwIAxQnD9wPYpEaQE5/BJ/8sfKCqCgvNuAeXjEoLsaw2HLtCH8kOi8PAyB1E
         w/IQo13KtqLgsHgh+tMEZ3aFaL9RBX0BHb09MYqoqOMUTPLDCNlN7a+YxkunjCIR5XrG
         gOdHqXq8MQSo+rT+4B0uPnTBS88F3YZtKRn+4995zg9TQiNqug4dbdYH336fGFyMSee8
         JhXvllNPGjSGjkc/pdlckRvNmjF0i10OMpQmSXJ2ptYLjlbaGfDwywDQC94QTHTKVi1l
         2in6DuGXkb09Y19I0Up0uKOkLvJQcnhdp0PN/ucQiVSFimoyl4crT+/dVOGIgpcW5qM/
         zSmg==
X-Gm-Message-State: AGRZ1gIOsNg1jq3jDLRP0O0muA2ime1BhQLObuNdvA3EvtIGnq+gbxzu
        TszOU6YjgPlwQ/HbxX92fhYcrg==
X-Google-Smtp-Source: AJdET5d33cpcBKvZsVddskI3F1pPnC5Wb30BcSxx/c/tbMa2o2O/Tt9j78wpIEwvXVu7gnm4HI2NcQ==
X-Received: by 2002:aa7:8254:: with SMTP id e20-v6mr21997444pfn.164.1542610527665;
        Sun, 18 Nov 2018 22:55:27 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id p62-v6sm45098407pfp.111.2018.11.18.22.55.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 22:55:26 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:55:06 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Qualcomm Synopsys High-Speed
 USB PHY binding
Message-ID: <20181119065503.GB10788@dragon>
References: <20181108070449.23572-1-shawn.guo@linaro.org>
 <20181108070449.23572-2-shawn.guo@linaro.org>
 <5bea0ed8.1c69fb81.8715.38b2@mx.google.com>
 <20181113034200.GD20049@tiger>
 <CAL_JsqKu3kf-zrKNtrtZsQEPi0LN_3jqs08i3-8vbSQDVxuRkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKu3kf-zrKNtrtZsQEPi0LN_3jqs08i3-8vbSQDVxuRkA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 09:13:38AM -0600, Rob Herring wrote:
<snip>
> > > > +- qcom,init-seq:
> > > > +    Value type: <u32 array>
> > > > +    Definition: Should contain a sequence of <offset value delay> tuples to
> > > > +                program 'value' into phy register at 'offset' with 'delay'
> > > > +           in us afterwards.
> > >
> > > If we wanted this type of thing in DT, we'd have a generic binding (or
> > > forth).
> >
> > Right now, this is a qualcomm usb phy specific bindings - first used in
> > qcom,usb-hs-phy.txt and I extended it a bit for my phy.  As this is not
> > a so good hardware description, I'm a little hesitated to make it
> > generic for other platforms to use in general.  What about we put off it
> > a little bit until we see more platforms need the same thing?
> 
> I'm not saying I want it generic. Quite the opposite. I don't think we
> should have it either generically or vendor specific. The main thing I
> have a problem with is the timing information because then we're more
> that just data. Without that we're talking about a bunch of properties
> for register fields or just raw register values in DT. That becomes
> more of a judgement call. There's not too much value in making a
> driver translate a bunch of properties just to stuff them into
> registers on init. But then just allowing any raw register value to be
> in DT could be easily abused.

Rob,

I agree with your comments.  Honestly, I'm not comfortable with this
'qcom,init-seq' thing in the first impression.  The similar existence in
mainline qcom,usb-hs-phy.txt makes me think it might be acceptable with
the timing data added.  Okay, I know your position on this now.

@Sriharsha,

Seeing that 'qcom,init-seq' is being configured with the exactly same
values for both HS phys in SoC level dts file (qcs404.dtsi), I think
such settings can be moved into driver code as SoC specific data.
Unless you have a different view on this, I will do it with v4.

Shawn
