Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A1C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74632084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCy893vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfAVTYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:24:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39624 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfAVTYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:24:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so11943019pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WvDB1UmY6P7Pi2/zWPPNgztIw2ztdKNOlQz8HoqixYw=;
        b=cCy893vNLB8VNw4FAWvddnCeADD/+H32ZpUIf/t2+Kvqrv7uauTrVYpP8XLTzcFGMo
         BwCU5sDXvinnIfComKNgKyh2Hh+gjLWgjpXU58CNSyFgBWoQfbOYfv/sYACJGvjoFHZA
         e1MFhjSNbN+u7jcId9imFvfFRh1ATravezyQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WvDB1UmY6P7Pi2/zWPPNgztIw2ztdKNOlQz8HoqixYw=;
        b=UKkaqu1SvMyXvLWxxLsyCYtKIVIk+Y0+JcWIxBWn+U1ARZSNAvkz7gMKO0dSX1F8ua
         mQ9c6YptSzbI31/JF1qedW4NaWWpkiQIinUEM+Ir1OmMvSP2n/l0EKHZ3VInstjT9p8w
         PBK9xDdKH0xy5cUEkKjL/GSNplKgjlljXndn2aHwOXyv6HOgf+b2UOE25Q2Aa1kmAqv6
         mjAPejL6ZO3foW9xtV3YsLSrdGOEMpySFHvip2dkuVAOnnycTDLidXDG08X6p6mEZpmR
         MDZl/NVvPVIwvA3wUdn59sODBsKHxAhjQl8mRwdcpnhiWsSyxKyzMBQkVgEIhy+iOBgh
         CC7g==
X-Gm-Message-State: AJcUukcG2T682re9FqqUMBZ9ps3jOIxhWk/C/YuURVi4BvIJYtL08Ybl
        NuycWf8tXYxNylWkoojKpGri0A==
X-Google-Smtp-Source: ALg8bN5tr2zYGHgKz6yefqrssxuEdUitJTh8IhIITdm8+HkLsb2AvYzA5Jy14jJIUvCYBc+Pe5MGAw==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr35398172plb.256.1548185047730;
        Tue, 22 Jan 2019 11:24:07 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j70sm22049196pfc.43.2019.01.22.11.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:24:06 -0800 (PST)
Date:   Tue, 22 Jan 2019 11:24:05 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region
 memory map
Message-ID: <20190122192404.GB31919@minitux>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-2-bjorn.andersson@linaro.org>
 <154818353130.20280.17905705223316470797@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154818353130.20280.17905705223316470797@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Jan 10:58 PST 2019, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2019-01-21 21:51:03)
> > @@ -103,10 +138,30 @@
> >                         no-map;
> >                 };
> >  
> > +               venus_mem: memory@95800000 {
> > +                       reg = <0 0x95800000 0 0x500000>;
> > +                       no-map;
> > +               };
> > +
> > +               cdsp_mem: memory@95d00000 {
> > +                       reg = <0 0x95d00000 0 0x800000>;
> > +                       no-map;
> > +               };
> > +
> >                 mba_region: memory@96500000 {
> >                         reg = <0 0x96500000 0 0x200000>;
> >                         no-map;
> >                 };
> > +
> > +               slpi_mem: memory@96700000 {
> > +                       reg = <0 0x96700000 0 0x1400000>;
> > +                       no-map;
> > +               };
> > +
> > +               spss_mem: memory@97b00000 {
> > +                       reg = <0 0x97b00000 0 0x100000>;
> > +                       no-map;
> > +               };
> >         };
> >  
> 
> What's the plan if certain configurations don't use all these carveouts?
> Can we mark the reservation nodes as status = "disabled", or the reverse
> and mark them as status = "ok" in all boards, and then reclaim the
> memory for peripherals we don't care to use?
> 

The code path that picks these up does look for "status", so I suggest
that we leave them all enabled in the platform dtsi and then let the
device's reclaim them as needed.

Regards,
Bjorn
