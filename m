Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D88208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKXgx905"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D88208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeGOU7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:59:54 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:37051 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeGOU7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:59:54 -0400
Received: by mail-io0-f180.google.com with SMTP id z19-v6so35870783ioh.4;
        Sun, 15 Jul 2018 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dhhOemaisv3ox9q5NU82mLZuv3XMkIJetImFY5HVVOc=;
        b=rKXgx905Vf3vY1wUT+jKeWY6Zjw6nRSA8ZhC2pA0AUW5L/whRcCOHlaAH9EfYBo8ji
         nCtIPlMG8O/pbeMPiXXTNomRXP+3HgZH5ab23eXXc9roJoQvXagbnIQEGCAZJ9KjRCzc
         SjYJ20QaC+O//Ey0JCmm+x636xcimOZhks3OoK7/gCqZ89qxR82RnwBHBuI70anwWWld
         IAkWKIRzYlrPx+4gCv9g8y6ZnaVNDFalJ3kZrx4ywAFRbgtEPWCuknYh8lf0yLesEE5U
         mkl2lgiNCY5Og+WH9OFUmn83axUrrNI7njy0+t0HiKOK8wAEBhizn5A+ylgYSnc6whQB
         bE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dhhOemaisv3ox9q5NU82mLZuv3XMkIJetImFY5HVVOc=;
        b=iGDTvUeRDpxYSTpDySOGAkjm0X50/aKjO1wnUWFIej+5HPdxrMwQPtNCeG1GR9hlQV
         6fjTvGc8qHnAVuHPzpsnkeewPM/9WY2QtM2nWxvMxiisrhlQlNDNttuKbOO5G9UIkUpm
         9GhFC4Q92hooKerGerVVrPSXQgSn8O9xoBUBf17j1mHGlbMpvihUrQ8RoLUjGKN5VZ/C
         BiHvasKbbByj2SzXiYyLl4OKQL0DWiejM8qZb+XscQtF9yzz/zmM5rYbmXku0ou9lh56
         Tn0zTlEozQBeeCx2iC2dTXkuFwJJIe2nzuSn0ZOh3ruqCbmPQhQNs0yBMP/jyXIwI5FB
         XRYQ==
X-Gm-Message-State: AOUpUlHk7P4rfl+0JV4ZcHFD2JAuhwaz1ve+ZMIeOJfes8jNeU9zdXsq
        ZRoXKEgSPzhMtd5VHN+dwc6D2dr3ha0ab/Xmg6eLtWUL
X-Google-Smtp-Source: AAOMgpcwKHm4QOtHYDsNnfmHXlTCyyCw+F87wd4VdGklsk351e34dL+3LD3aFd3M+KPVSjfymANMxJZiApJPWrmsabg=
X-Received: by 2002:a6b:828d:: with SMTP id m13-v6mr14390356ioi.161.1531686946110;
 Sun, 15 Jul 2018 13:35:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:b845:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 13:35:45
 -0700 (PDT)
In-Reply-To: <20180713153318.GB3049@arm.com>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org> <20180713153318.GB3049@arm.com>
From:   =?UTF-8?B?Si4gQWd1c3TDrW4gVmVnYS1GcsOtYXM=?= 
        <agustin.vega.frias@gmail.com>
Date:   Sun, 15 Jul 2018 15:35:45 -0500
Message-ID: <CAGbRU0QLSpNEtcryuPPZE98zAo7peEmcDqcQiLi1zO6cfKML2A@mail.gmail.com>
Subject: Re: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor extensions
To:     Will Deacon <will.deacon@arm.com>
Cc:     Agustin Vega-Frias <agustinv@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Phani Pabba <pabba@codeaurora.org>,
        Richard Ruigrok <rruigrok@codeaurora.org>,
        Vijaya Kilari <vkilari@codeaurora.org>,
        Jeff Hugo <jhugo@codeaurora.org>,
        Rahul Ramasubramanian <rahulr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Jul 13, 2018 at 10:33 AM, Will Deacon <will.deacon@arm.com> wrote:

[snip]

> I'm mostly ok with this approach, but I have a concern with the way in wh=
ich
> the sysfs interface for carving up the config fields is implemented. If t=
his
> is intended to be a strict extension to the armv8 pmu architecture, then =
I
> don't think you should be overriding the attr_groups entirely. Rather, yo=
u
> should be taking the attr_groups from pmuv3 and then extending them in a =
way
> which avoids overlapping field allocations by construction.
>
> As it stands, you already have an overlap between the pcc bit and the
> chained counter bit which Suzuki has implemented and it will be very easy=
 to
> introduce API breakage if we don't enforce this as part of the design.
>
> Will

FYI, I left Qualcomm on July 6, one of my former colleagues will submit
new iterations of this series. I will continue to comment on this and futur=
e
patchsets as a courtesy to my former colleagues and the community.

Thanks for pointing out the sysfs issue. My suggestion on how to address it=
 is:

1. Reserve config and config1 for architectural format attributes and
   config2 for extension format attributes.
2. Add a struct attribute ** parameter to the extension init function so
   extensions can return the new attributes.
3. The extension framework code in arm_pmu_acpi.c can then allocate a new
   attribute array to contain the base and extension attributes and ensure
   all the new attributes are on config2.

Though a more elaborate approach can be implemented to find conflicts in
bit usage within config fields, it would require much more code for a
relatively simple problem. Thoughts?

Thanks,
Agust=C3=ADn
