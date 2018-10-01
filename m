Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5203621476
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/n9KFQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5203621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeJAXRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:17:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34425 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJAXRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:17:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id v69-v6so4405534oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KhTcfpLGn0eMyXPsK757drELarbtFUbS9NqFGBVYh8=;
        b=k/n9KFQJWGQ4kdAoZiADr1x7a9yGw2DVWzfNX2DZdlK+dQ78x90wdFtmvC+uLbCFhx
         GaSNjoKJHBBK7OKixNdvc0HRGGYN5HOgKL0R80Pp0MEFU0Um6FhSs8XgrcMZlLqo1EOC
         b2ugWJXeTqB2Zde97ApBRbHst7vsltNVUEjJuuE0QFGb1hantl+Iv6khKKVxy1UVyXri
         XISluzQXDNLFp5pca0rRxL4rPeWU7hvE99WZSb6YlgQUQtROy08pog3N39xHPlo9WfXh
         KDhuh3hINi35uMg9MJbdz2L/e0Kygm4edgD9pzh4Sxk/VyH3URym1zw/9Oqt76w077Sf
         pXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KhTcfpLGn0eMyXPsK757drELarbtFUbS9NqFGBVYh8=;
        b=IIqSafds5Towf50hFER6CWHuygScE6aq+z/1+9m0RyANecZVr3PMeFwbu+/GbN5Xc1
         BHte0PzNnnNthDHP3xtMPszjr6+v2Qy6bCaTEvPZdc5v1uIo//KUT+dOwy/vi1K3Q7Gm
         0jmSc3YR8lngtTFZAzmgZixNseH4Kd970XElLYmGeiz4+DyJVDM5zDrGP4H+m6ebdPI5
         l/CvwqljxTmum1CJD/xaXu6kf3Rj3uRkaq7ZJDsF2mWzKEFsvDR6ecVi/hPfxFRdMosx
         omzoV5euW+ueafFl2ZWeasPlbvoohI02HxYn9JNbfnJfQbURl+P7ZXZ9CKitC8/mpmfH
         46IQ==
X-Gm-Message-State: ABuFfogJyTcYamHpJAhrFK7yigXaMU2wIA0d09TccIzwzM6zTwLYjbXg
        JcFTyfBXYi4FCx7biU/CWUsrt7C+DSSQE7atICY=
X-Google-Smtp-Source: ACcGV62aGlhO+dSJ7RaY975ZfJQmJIqHRcKTYYmC+HzFIYaUbkwx8vW0D3glMRXJs+XPkBBAOLvSs0+L8cBFILurQwM=
X-Received: by 2002:aca:bec2:: with SMTP id o185-v6mr5708555oif.22.1538411952830;
 Mon, 01 Oct 2018 09:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181001100707.16840-1-ganapatrao.kulkarni@cavium.com> <20181001142914.GD9716@arm.com>
In-Reply-To: <20181001142914.GD9716@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Mon, 1 Oct 2018 22:09:01 +0530
Message-ID: <CAKTKpr6SQUc9EgdYL2N32a=szUmSs82Mbb4y89htbVQhTPp2rQ@mail.gmail.com>
Subject: Re: [PATCH] arm_pmu: Delete incorrect cache event mapping for some
 armv8_pmuv3 events.
To:     Will Deacon <will.deacon@arm.com>
Cc:     Ganapatrao Kulkarni <Ganapatrao.Kulkarni@cavium.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Oct 1, 2018 at 7:58 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ganapat,
>
> On Mon, Oct 01, 2018 at 10:07:43AM +0000, Kulkarni, Ganapatrao wrote:
> > Perf events L1-dcache-load-misses, L1-dcache-store-misses are mapped to
> > armv8_pmuv3 (both DT and ACPI) event L1D_CACHE_REFILL. This is incorrect,
> > since L1D_CACHE_REFILL counts both load and store misses.
> > Similarly the events L1-dcache-loads, L1-dcache-stores, dTLB-load-misses
> > and dTLB-loads are wrongly mapped. Hence Deleting all these cache events
> > from armv8_pmuv3 cache mapping.
> >
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > ---
> >  arch/arm64/kernel/perf_event.c | 8 --------
> >  1 file changed, 8 deletions(-)
>
> The "generic" events are really implemented on a best-effort basis, as
> they rarely tend to map exactly to what the hardware supports. I think
> they originally stemmed from the x86 CPU PMU, but that doesn't really
> help us.

This works fairly well for DT based boots, since almost all SoCs have
added remapping using custom dt object binding.
However we have concluded in the past to drop SoC specific from the
ACPI mapping and use json to add SoC/micro architecture specific
events support.
At present ,  When we boot with ACPI,  it is misleading for these events.

In fact, this has been pointed internally from benchmark team and
reported it as hardware bug!
IMHO, it would be much simpler to delete these misleading events
mapping rather explaining to perf tool users.

We already have proper mapping for these events,
armv8_pmuv3_0/l1d_cache_refill/
armv8_pmuv3_0/l1d_cache/
[core imp def:]
l1d_cache_rd
l1d_cache_wr
l1d_cache_refill_rd
l1d_cache_refill_wr

>
> I had a discussion with Ingo back when we originally implemented perf
> because I actually preferred not to implement the generic events at all.
> However, he was strongly of the opinion that a best-effort approach was
> sufficient to get casual users going with the tool, so that's what we went
> with.

thanks for the background info, these generic mapping fairly works
except these events.

>
> Will

thanks,
Ganapat
