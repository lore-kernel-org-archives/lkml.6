Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17701C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51822085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWUbIqgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51822085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJJNyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:54:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52524 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJJNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:54:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so4129233wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 23:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFhgT1aIynJbNgyyhKCIvpd7ev0i1fMikHAii9gEtmA=;
        b=QWUbIqgOeAUS98ETXEv2U9a8FUJKORgkQlympOpjLhjMAPs6jU05bJYSTA6+UfQRfo
         5gIgEnsIPJUwX58iYnqfUgrtU0f7VFj9TCld4kVjP7aqlfVRguwuhHDMKmkc95BSKIp9
         /fNgW8Njx2toDPvtri6mzDAnSmWqmpfC6pWXAyGb6YJ/bNE604XMhOKQES/ijAgW+ka9
         AWYw+gt9udpBwnFTMqcWcxoi7o49ADJEXOJz52bMpSQZsOdUG4Xp2K0yzjQb8Q4rmr//
         5lSn0afGUxKFX4Dmy7zx9pUqw3rvPTD3ogV0FnhHaNsydLUtjyGbd5QcxRdmtAhxUu+y
         q/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFhgT1aIynJbNgyyhKCIvpd7ev0i1fMikHAii9gEtmA=;
        b=rKWVnSgBGru1AcLiMPvYsoUOvZ2zZ26Qc1xMswXDk0FTYBLFPtrGWVw+i1jVhIfh56
         Yeb3og5qSjaC1ds4SOKFSweEOHkVGpofBi+RBtcbvTyr2Zk3sONlMszjUSJKH2eUnLVY
         GnXemUSpCLETtCGxKkusPVKRDR8AYThebY8IEpZqsbqJiQdA3d9LVDDkUILV50lkYbUI
         6QLGDYTq/r+kE4lQfOYaXm7WQeTomVDWTg61a9W9/kVH0+wV/CLN1PXiKP/Dwkcl5n1U
         /fn5rxa2M4fIcZFM6lvsLSY697tbjcJDXL3Mhh3atAhRNqzzG8sBgbYR/KxGi5FXU9UR
         edFw==
X-Gm-Message-State: ABuFfojcM7u7SxWue5gbo44NY4X/7ThCDxl01r9BXoc7yDbO+Died/UA
        ir7cdtNr6fx0c1RbUHd3DjjKjhKV
X-Google-Smtp-Source: ACcGV61zkOTB5HKJqyF5MUR3tbTJo/nM2299wIUaG6TS0DGVbJfoATPe8oS0CT8osu160tpkpNuRog==
X-Received: by 2002:a7b:c187:: with SMTP id y7-v6mr4229847wmi.136.1539153220015;
        Tue, 09 Oct 2018 23:33:40 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id m143-v6sm14005833wmd.29.2018.10.09.23.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 23:33:39 -0700 (PDT)
Date:   Wed, 10 Oct 2018 08:33:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3 0/3] mm: Fix for movable_node boot option
Message-ID: <20181010063336.GA57677@gmail.com>
References: <20181002143821.5112-1-msys.mizuma@gmail.com>
 <20181009151433.p5aqcyrzrv7gfpyh@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009151433.p5aqcyrzrv7gfpyh@gabell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> Ping...
>
> >  arch/x86/kernel/e820.c   | 15 +++--------
> >  include/linux/memblock.h | 15 -----------
> >  mm/page_alloc.c          | 54 +++++++++++++++++++++++++++-------------
> >  3 files changed, 40 insertions(+), 44 deletions(-)

If the problem is fixed then the e820 revert looks good to me:

Acked-by: Ingo Molnar <mingo@kernel.org>

The other patches need review and acks from MM folks, and the series (assuming all patches are 
fine - I only looked at the e820 one) is -mm material I suppose?

Thanks,

	Ingo
