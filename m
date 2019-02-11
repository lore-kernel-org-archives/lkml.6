Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD710C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD0020823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549874746;
	bh=aNjOHNDg94ZkKvA1xr9xCksj4QuuBPIf/hPN1+P9Vu4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DxS8BdmpCHC3/HYilp1rYzrjwueHxkj+jvS/Q3EFkCKpqii3i19MJKF0uNXhtlzS4
	 cMr5bvLC1R+zKW2uLmnUGsTQATOTY37dmDyeDMcPo0srVgV98GRN2rL9qRhd3fAPD0
	 DgXOrpgQvSfGzaTWwpbl9x+UP5dar49F4sXntzW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfBKIpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:45:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKIpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:45:44 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98FF52173C;
        Mon, 11 Feb 2019 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549874743;
        bh=aNjOHNDg94ZkKvA1xr9xCksj4QuuBPIf/hPN1+P9Vu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wX2AA0uS56qLBfOdFDt+r/4X2GOU8Vf/rOr7bs38Pasr2nOruy3VQ5TXmUl9oDrOM
         xPF/hDpnw4A/dv11LaXtqMxLPDcDgg5h4y4hJDMpf+mMn1LNA2oSxf/Ord6SlnNjiI
         VzQASpXz0W9d+Dojai2X79ALMYO3rKescBCL18TY=
Received: by mail-lj1-f179.google.com with SMTP id r10-v6so8027583ljj.4;
        Mon, 11 Feb 2019 00:45:43 -0800 (PST)
X-Gm-Message-State: AHQUAuaXy6v3CXGFfq+Zq5DNcqlJ90CPetNwKv52rArPyaN6CaDcisrg
        Qq6DRWMf22F/gdN5N8+FeZUGQv5B9CsMlrDlOVI=
X-Google-Smtp-Source: AHgI3IbzeKeYkKpuAfCg0dy/z/dT38QKh18bso1sBal8m+g0p0o2lxo+lLo4eccrdIB8UXtjJABSI3/qlbQRij3PWoQ=
X-Received: by 2002:a2e:81da:: with SMTP id s26-v6mr21000889ljg.183.1549874741764;
 Mon, 11 Feb 2019 00:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
In-Reply-To: <20190210225114.20110-1-stuart.menefy@mathembedded.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 11 Feb 2019 09:45:30 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe+G_gPNLQcaE5kvXFLFzhXo538w8-34k3gcK7yNL8txA@mail.gmail.com>
Message-ID: <CAJKOXPe+G_gPNLQcaE5kvXFLFzhXo538w8-34k3gcK7yNL8txA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Subject: [PATCH 0/2] clocksource: exynos_mct: Clear
 timer interrupt when shutting down
To:     Stuart Menefy <stuart.menefy@mathembedded.com>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 at 23:51, Stuart Menefy
<stuart.menefy@mathembedded.com> wrote:
>
> When debugging suspend problems on Exynos 5260, I had a large number
> of debugging prints going to the serial port after interrupts
> had been disabled but before the timer interrupt was shutdown. This
> was long enough for a timer tick to occur, but as interrupts were
> disabled the ISR didn't run, and so the interrupt wasn't cleared.
> Later when the timer was shutdown the interrupt was left asserted and
> so the wfi at the heart of the suspend code didn't wait, causing
> the suspend to fail.
>
> Currently the code which stops the timer when it is on one-shot mode
> and the interrupt occurs is in exynos4_mct_tick_clear(), meaning if we
> called this from the shutdown code exynos4_mct_tick_stop() could be
> called twice. So first restructure the existing code, so the check for
> one-shot mode and stopping the timer is moved to the ISR, leaving
> exynos4_mct_tick_clear() just clearing the interrupt flag.
>
> Once this has been done simply call exynos4_mct_tick_clear() from
> set_state_shutdown().

For sending the corrected version. This is second revision of the
patchset so please remember to add v2 to the title and changelog in
cover letter. v2 can be easily added with format-patch (-v2).

Best regards,
Krzysztof
