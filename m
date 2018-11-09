Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E34FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D8D20827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY4j2kNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D8D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeKIUBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:01:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34670 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeKIUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:01:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id i138-v6so1063388oib.1;
        Fri, 09 Nov 2018 02:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpRANswVNHpyNPwFfYNwt/nNsTidoxb+fl9md3xzbG8=;
        b=MY4j2kNt3b/R3QVHSKikT/NlPb/xbLA/5ZfCI474xzsinGv84GkGzuH9WLxTz3oYFD
         ykNtLck0e5nrKzDYwTtRNiDxOiL+iXBh0tXf96AyalFbGTlG2YxMhryZeTa6w/94V8C4
         ElWNR1MflYKb3SCke349ehTCIgy5L0B0N0WeUNKmn9lgetUxVC3MKDa4PFns4C2VdEEW
         z29u85iU5xUrtPt52pRkZoqnvCUIQiJY4uxNRuPwyuOJbgU/TpT5aeaHoJ0mMGMRlIsa
         xJPFccET2u8/+6DNfOgaGFk3pGTJogVhg6edj6tlfuWYS9nWl7/1nQQ1TO+Ucam/unpi
         nz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpRANswVNHpyNPwFfYNwt/nNsTidoxb+fl9md3xzbG8=;
        b=V4mx1rbO4PwZSkwy9qD/3K2REfoEnAxNB1cIiS8h6xmto4xOKkqxQ8fEbAaL6QY8sq
         05w10RBimd7DLy1BTMxvUP6UHXSkprnoJ+t8+5MniATDI+uql1tsWLC1jxPnmgu+xwBc
         oVCA4L6F8r2SoYlIPMAQyWm95v+jogsJywsgpftnIO+Md6FAihGEqowObj1xlUvhFhLU
         DxwWLBTNFqPwoxImI5/6eXaSe5xvgHyj5hek+ePHB+vAie5kByG19K2viwAxsJOXM+kJ
         ZAiYmywakcwfpvvDQ/OGvycpBzR+Kyo4sVJIK8rhf91Zo+3BbIcnwUGl+oglVlmBgfN+
         ya+Q==
X-Gm-Message-State: AGRZ1gLw4aZyT3P5A05glMtz2iwlBdJOFbxut6AmXwcM1qpk4vxgeH3v
        WepVjxkoFVgiG8RudFPVNEf76P8pyfp507jljmQ=
X-Google-Smtp-Source: AJdET5c5oUNNY+5cPy4b7IT3Z53iiO3l3OwbCYuCBmdlY2VgupESARsAx92JXDlcsxniz7Jbr9QtVrDtbQkJE/ecGnU=
X-Received: by 2002:aca:59c4:: with SMTP id n187-v6mr4363540oib.279.1541758886894;
 Fri, 09 Nov 2018 02:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20181025055833.28471-1-ganapatrao.kulkarni@cavium.com>
 <20181025055833.28471-3-ganapatrao.kulkarni@cavium.com> <84978a48-bd25-eede-519a-a4e9991c5c3d@infradead.org>
In-Reply-To: <84978a48-bd25-eede-519a-a4e9991c5c3d@infradead.org>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 9 Nov 2018 15:51:15 +0530
Message-ID: <CAKTKpr5mtSuRLfaGe+nQOsEYSP7MghsxhjtVgKmR=jAnrAn1Kg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ThunderX2, perf : Add Cavium ThunderX2 SoC UNCORE
 PMU driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, suzuki.poulose@arm.com,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 9:42 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/24/18 10:59 PM, Kulkarni, Ganapatrao wrote:
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 08ebaf7cca8b..c1956b1af2bb 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -87,6 +87,15 @@ config QCOM_L3_PMU
> >          Adds the L3 cache PMU into the perf events subsystem for
> >          monitoring L3 cache events.
> >
> > +config THUNDERX2_PMU
> > +        tristate "Cavium ThunderX2 SoC PMU UNCORE"
> > +     depends on ARCH_THUNDER2 && ARM64 && ACPI && NUMA
> > +        default m
> > +     help
> > +       Provides support for ThunderX2 UNCORE events.
> > +       The SoC has PMU support in its L3 cache controller (L3C) and
> > +       in the DDR4 Memory Controller (DMC).
> > +
> >  config XGENE_PMU
> >          depends on ARCH_XGENE
> >          bool "APM X-Gene SoC PMU"
>
> Please fix the Kconfig indentation.  Use one tab (not spaces) for each of
> tristate, depends, default, and help.  (yes, some of them are tabs and some
> are spaces.)

thanks, i will update.
>
>
> --
> ~Randy

thanks
Ganapat
