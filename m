Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878B4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FDC208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="d7KaCVw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FDC208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbeGaCwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:52:37 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:45669 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731699AbeGaCwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:52:37 -0400
Received: by mail-qk0-f172.google.com with SMTP id c192-v6so9186041qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 18:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Rdov3LZJn/RsGXQnTVSFmr+gE/xBPk1a7HArormB/i8=;
        b=d7KaCVw5eVw3/8TU5bRukoGVxu9o030hD8zFqiSGSPmXihvShtBR/xTxyXvv8tkc2R
         2W+WbNwYolZtcqFw6LemIvKR5j5tU7FopWqRgihy2RLazWatwD8z2Adf54YMxwbinfIR
         xhGpzUFVSpK8hdBVli7GjJBwEr88GeG2zZwY1aTtlDHow+oVag+K43ppkiHLixm88he9
         ICOjFORoXpdcUshB9oF6rDA+BGUVDrlapyfOMU04x2DUgqbv4LB4WbID4Hvr8pGyRw9g
         Z+tfeuhZF25Svwk/qvCFscK7H9l00VX786TLesnCv9i6HaGQp3z4+OOjurv7S/nDu0MR
         PaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Rdov3LZJn/RsGXQnTVSFmr+gE/xBPk1a7HArormB/i8=;
        b=UrjEWgGtSanrRPFcA+rTigQJ7Xi7uz92Hg2VBqFFzM+7QXlTvISEPmYlJZ2F24gnyP
         regWTk+TLwEelpIuyhAjZiMrxe5l0+ZLUJe6aypR6hvoiYttFebFwtwRqDiad/EMfrYW
         cr0BrbXu42raizAOdz96L/ePXYerO8+YJrg/4S2l8GAnVFL5f+y5W/XanqhvF3mHgRSe
         XT/3/5HoIVokxLzGngCUH3wiNUpVJ2AkYazpnox022pcft+JR6qQf75ZVfhCUqDwY/BL
         2MNPOQtS/SoGUfn9BRzkuQSloYloD/Qi+rinZ7z36Noq/LGhkp0N4Bt2OP8s1HN6gnl6
         bzAQ==
X-Gm-Message-State: AOUpUlGLudJ6Ixk7ZNWpzgO1ypwDFJLkzhxSTeo79gMxQYT6Jxt9uUyx
        w1p+P0xzkYHJh8g5XFkIpLZ4Lw==
X-Google-Smtp-Source: AAOMgpePZfODfERUoGxLKR+N/8NIMzSgvGgk7dhwWuzWJvHi0++e7FTFk3rd/Cm8uXwRSeACPqV2ug==
X-Received: by 2002:a37:209:: with SMTP id 9-v6mr18005223qkc.267.1532999695453;
        Mon, 30 Jul 2018 18:14:55 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id h51-v6sm10801969qte.17.2018.07.30.18.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 18:14:55 -0700 (PDT)
Date:   Mon, 30 Jul 2018 18:14:50 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
Message-ID: <20180730181450.4e0e1df8@cakuba.netronome.com>
In-Reply-To: <CAKOZuev_fRPjH6PWRnDpWo0OjOo2EF+at_Uw4JXs25mwKoWF1A@mail.gmail.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
        <20180729205835.34850-1-dancol@google.com>
        <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
        <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
        <20180730172641.7d516231@cakuba.netronome.com>
        <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
        <20180730174532.20010e0d@cakuba.netronome.com>
        <CAKOZuev_fRPjH6PWRnDpWo0OjOo2EF+at_Uw4JXs25mwKoWF1A@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 17:50:15 -0700, Daniel Colascione wrote:
> > Tangentially it would be really useful for us to have a "the map has
> > actually been freed" notification/barrier.  We have complaints of users
> > creating huge maps and then trying to free and recreate them quickly,
> > and the creation part failing with -ENOMEM, because the free from a
> > workqueue didn't run, yet :(  It'd probably require a different API to
> > solve than what's discussed here, but since we're talking about syncing
> > things I thought I'd put it out there...  
> 
> Yeah. What you're talking about is what I meant upthread when I
> briefly mentioned a "refcount draining approach" --- you'd block until
> all references except your own to a map disappeared.

I don't think so.  The ref count goes to 0, work gets scheduled to call
free, work runs, free gets called, device memory gets freed.  Now the
memory can be reused.  As long as there are any refs we can't free
memory, unless we want to make the semantics really ugly.

But as I said, only superficially related to this patch.  Perhaps
solution will naturally fall out of an API to query the device
capabilities and resources, if we ever get there.
