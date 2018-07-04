Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAB0C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DA423BFB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je+Uo0vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DA423BFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933328AbeGDKOg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:14:36 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46907 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbeGDKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:14:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so9715491oie.13;
        Wed, 04 Jul 2018 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GI5wcSvqBXmZ0BmtLYfgniYZD3kywOiC87Rlj0Yaj4I=;
        b=je+Uo0vy0CdcA687up4NDjuC03WYn3sKc6ZnqPF+XlDQrHzzJ0PtKKcVXSjxwXxAgs
         JKSTUmUWPJmVXU8222YJI7jpLcyCZRAFT4XvVTDLaxCJV0fBtWORN2QVtHbJsjoOO62G
         XC4ged4arHX6odYYuxgKFjZj4sCHx3GvGBcoA/d1VOM1dAM/a4dxeNM+MZbxIue3Y2gP
         4FWv1Zh6fVyx7QckBTONnrL9DJUJBKjS/RaplfnnKGeQjXnJeDiDNJBQmxE3F2VmBRHh
         fN978iJHcDhG/wVyEhXRkBQr7Fy7Fs2fV/Yti3MHDLHJG7kSvazxQqV2hlYOEdyo3Fqx
         QUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GI5wcSvqBXmZ0BmtLYfgniYZD3kywOiC87Rlj0Yaj4I=;
        b=pGN1faGKWpnxeTVRhOSTq5G3VYVcg0EfhsLdNkwHTGEXLuzVa7Wg8bEkWzx8WxcOgl
         8qcb724f8xY/7G2NsLnZfTirqiQaev6wLg+5BoXF3Q63lTClZ2LDfhd9E/p9UxUVUrAm
         wOQgg3REqQB404BApYXHPBdAs/TExNrwyiormzGM3bCk8+NLzuuXHp/iG4Xdrr69M/aX
         BdA57QljA8TQ4BD/cxPDSbfPP+iH49acpB+o+wgoB4u5l73oK5Oz2s0aTzYuMmEpEB0k
         HkENaJvFTllSxiy+4f5PUaKTsqMxh0rAtarFC0q/gSbA364q2A3cDtfGzBeXUR0rm//g
         kcMw==
X-Gm-Message-State: APt69E3fkgzsp2800guuGsvLaYNg3aGdAEIFkTz+tXQv3CgdGi0N3lJ3
        XZpB8xJDje1zbwRtnuiNVY67Z2gv8FL/EkikTvc=
X-Google-Smtp-Source: AAOMgpc35Sutor6BfOxDEip2nw5A6L8VDta2PPUa7r3pxxrv5upKu1yWoq+LXbcdjTJBCNbrFeytBWiLi7AtEC4bDgY=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr1568373oif.9.1530699272414;
 Wed, 04 Jul 2018 03:14:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:d37:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:14:31 -0700 (PDT)
In-Reply-To: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Wed, 4 Jul 2018 15:44:31 +0530
Message-ID: <CAKTKpr5bNdo2oXb=Vsm4QytHN1Aw=n_oP7kJHV6yLHuKL-Udkg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

can you please review this patch?

On Thu, Jun 21, 2018 at 12:03 PM, Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:
> This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> The SoC has PMU support in L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
>
> v6:
>         Rebased to 4.18-rc1
>         Updated with comments from John Garry[3]
>
> [3] https://lkml.org/lkml/2018/5/17/408
>
> v5:
>      -Incroporated review comments from Mark Rutland[2]
> v4:
>      -Incroporated review comments from Mark Rutland[1]
>
> [1] https://www.spinics.net/lists/arm-kernel/msg588563.html
> [2] https://lkml.org/lkml/2018/4/26/376
>
> v3:
>      - fixed warning reported by kbuild robot
>
> v2:
>      - rebased to 4.12-rc1
>      - Removed Arch VULCAN dependency.
>      - update SMC call parameters as per latest firmware.
>
> v1:
>      -Initial patch
>
> Ganapatrao Kulkarni (2):
>   perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
>   ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
>
>  Documentation/perf/thunderx2-pmu.txt |  66 +++
>  drivers/perf/Kconfig                 |   8 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/thunderx2_pmu.c         | 949 +++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h           |   1 +
>  5 files changed, 1025 insertions(+)
>  create mode 100644 Documentation/perf/thunderx2-pmu.txt
>  create mode 100644 drivers/perf/thunderx2_pmu.c
>
> --
> 2.9.4
>

thanks
Ganapat
