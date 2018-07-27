Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D25C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743D520671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMK5Q4/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743D520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeG1AR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:17:28 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:47061 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbeG1AR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:17:27 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so11789555oie.13;
        Fri, 27 Jul 2018 15:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3BgeFYh/QqpjDNJ6OZvU8snSZIdxZzWRCLuJKJ/i3bM=;
        b=VMK5Q4/T+VXJNswVtYTYwMhkyc3n1dA4opJQqi5s79EzCAF7umuboUpYIcOt/GFo+R
         R1MSbJCffgARllr5kKHFwLtO/Rgdag+WQ+DqBvCUfIdVQU+edPIcn2mKRCPVCkUp2cKw
         tzP/IfwNoDKIytcUCDLj9RcGG8YdhX2yDyMIZ+yO2H//2047OyxCvoOngtSioFIS9pEC
         LExy2LTF1tTP1moaT1iATbkxJnJFksBEppc+rmU+KT4D4wjoD5X9Cy650nsSJnNqrthU
         749vWTJCFrwoFNzKTdaNCW0hJMqqfix6f0EMece+qGqvQzXWSHtJ2XAtWodko/A48/i3
         VBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3BgeFYh/QqpjDNJ6OZvU8snSZIdxZzWRCLuJKJ/i3bM=;
        b=S6avn2pWf4j1A0ANOW0s5iq4/XrdHw8cs9AhyI3IK/MhOOb+c0jGG92C1pztIOMbDs
         /Z9UlKR4kRA2kgTJLoSZKMBPs0LHBLyWSjsNaTchWe7BsbXMxGh1xVLlU8hG0AzdOyXv
         XNOQVOZw5MuAiWyqgzj5Hta0me7jtY/chmubsfwzV66AEjVD7pVKbi21EXfzbD0qLfZc
         57MvOMu2bV+NHRENO2+UCK7pSRD0IpjA2czgdJbOenyDoY3oVNd0Mv4cPV+gCoJnIEN0
         cIp6n50HtoQZxoGhmodeZdRZjOCRYo5GKhsGVWPtzC90rsx76U1kNJO85u5dpV47eWB1
         Ztyw==
X-Gm-Message-State: AOUpUlGdmGLJs5XgpT6+hv0zDOee4cJ7HjV+exG3NlsyGR1as64bhdOW
        SnPxsp2yiGSNLpLxexBo+2s=
X-Google-Smtp-Source: AAOMgpfTWv5XMOESI42Xi+IkAymsCNtXCywaP8WqTR3dcWZB0ALrIIlRsu5Ay4eXu+lGM5v7ctcLCA==
X-Received: by 2002:aca:7517:: with SMTP id q23-v6mr7897952oic.352.1532732005562;
        Fri, 27 Jul 2018 15:53:25 -0700 (PDT)
Received: from localhost.localdomain ([12.251.228.178])
        by smtp.gmail.com with ESMTPSA id q124-v6sm5738075oif.8.2018.07.27.15.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 15:53:24 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:53:22 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: thermal: samsung: Add SPDX license
 identifier
Message-ID: <20180727225321.GF4450@localhost.localdomain>
References: <CGME20180718200318epcas3p16aed6c1725d6c1e63ea6b1ad209c5756@epcas3p1.samsung.com>
 <2442216.oppRSGRAaL@amdc3058>
 <20180724200312.xs6u4nvhjckukkig@kozik-lap>
 <2385592.z8yee4uxt4@amdc3058>
 <CAJKOXPfTBE-tW81tocCfObb-pAwNmDjjv-BY6kHNkEuazm0pAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPfTBE-tW81tocCfObb-pAwNmDjjv-BY6kHNkEuazm0pAA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 06:27:59PM +0200, Krzysztof Kozlowski wrote:
> On 25 July 2018 at 16:43, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On Tuesday, July 24, 2018 10:03:12 PM Krzysztof Kozlowski wrote:
> >> On Tue, Jul 24, 2018 at 06:46:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >> >
> >> > Hi,
> >> >
> >> > On Wednesday, July 18, 2018 10:02:50 PM Krzysztof Kozlowski wrote:
> >> > > Replace GPL license statement with SPDX license identifier (GPL-2.0+).
> >> > >
> >> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> > > ---
> >> > >  include/dt-bindings/thermal/thermal_exynos.h | 12 +-----------
> >> > >  1 file changed, 1 insertion(+), 11 deletions(-)
> >> > >
> >> > > diff --git a/include/dt-bindings/thermal/thermal_exynos.h b/include/dt-bindings/thermal/thermal_exynos.h
> >> > > index 0646500bca69..642e4e7f4084 100644
> >> > > --- a/include/dt-bindings/thermal/thermal_exynos.h
> >> > > +++ b/include/dt-bindings/thermal/thermal_exynos.h
> >> > > @@ -1,19 +1,9 @@
> >> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> >> >
> >> > This code should be GPL-2.0 only, original license statement is most
> >> > likely result of using wrong file as the source of copy-paste. So I
> >> > would like to have the license fixed first before doing conversion to
> >> > SPDX.
> >>
> >> If you think that's the case, then it makes sense and please go ahead.
> >> As fair as I remember this required signed-off from all contributors...
> >> so probably just Lukasz and Eduardo?
> >
> > git blame shows just Lukasz so his Ack should be enough.

You probably want to have his ack yes.

> >
> > I'm also fine with doing it in one patch like i.e. in commit a80ea4cb944e
> > ("pata_bk3710: clarify license version and use SPDX header"), if you are
> > also fine with it could you please re-spin the patch (+Cc: Lukasz)?
> 
> I do not have interest in changing the license, I do not want to deal
> with possible legal issues so I'll skip it.
> 

:-)

> I am fine however with abandoning this patch if you or someone else
> sends license change + SPDX.
> 

If that is the case, I am skipping this patch. Ping me / RESEND in case
you still want this. :-)

> Best regards,
> Krzysztof
