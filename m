Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2998EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB897217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="drdfA6Ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfBRNoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:44:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42400 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRNoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:44:11 -0500
Received: by mail-ot1-f67.google.com with SMTP id i5so28252708oto.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 05:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFz5T/gKS4sQKCfoA+LnrdX7HOe7jBqNz1iE1oIU+e8=;
        b=drdfA6UxeMOkGPRrukDac0Pfot+RfjI7X4llH+DqvnrjuMY14f/nJfGe9lu88QsPA/
         ZG+V3FrYSD0bDqmCdl24m/ZWWYDoA8rp728t/jWwPlfuS1GTSCKeidWlo71ssgQE47iL
         PyKI7cSnwttBv0anKgfK/L5qrEGekLuWaV3xKcgGv89ZcatVbOQzWTF6QNJU/4+vqlxb
         O/3Tq4j8ZHvn4VTXW7JRzwh54XLEo4u5JwT6MXn4ZfgH3jH8ch+uDCje+Fxe2Q1OR5+d
         sGz9crjI6+erc0Q9MNo0UseeJgH+u4Y8TnhOL5l7m1g9FRAnZr7PmPvs6//v8lcxwust
         sTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFz5T/gKS4sQKCfoA+LnrdX7HOe7jBqNz1iE1oIU+e8=;
        b=IIkzohsr2Qa0gMpIQ7zkW/4DdcLRdROUAeMd0ZDEJIV6vb4t6DixvWzAzL91ZWCc2d
         VV5cxr3Jo0NGpXia/OkuwHCKlCYcsqATPMbYhORsfd5udHc5VRuLjotEAB/6agLRAEgz
         O8tWdgPgFNfezYFwArtZ0N3v7+KNBRkyhQ6LX9VlRFLBTftpSAOHSxDBMiEbl3ZeX0ov
         tFthAII05jwSkJrchisIvk0DhqwAMiSIFg7JHLFGMu1f+Am+2WwLa7rZV/EEfCmdUo4J
         CO/KNUpJh8TT4OwHptFbygaL4QSaAAp784FoHpD2Hs68wqXmneeFYCb4uAbzwGljXIHU
         G2NQ==
X-Gm-Message-State: AHQUAuZY9Yj5smiAS9qeTdOXRoEmmYVFbX282ExkNm38ZsGmS+uf1Kj9
        Wl1tGp0G4vcTMpzuNMvrZnjM/1v5S4mVWQmGYtJXLA==
X-Google-Smtp-Source: AHgI3IZdX+BaKD9r8NSRj2jb9ncPlX8I5T5KiNHlt3XTaZjkEcj2TuEK74CefWHQLOWud5almRRl1Nk45eigelx5Kck=
X-Received: by 2002:aca:fd4c:: with SMTP id b73mr14874883oii.33.1550497449575;
 Mon, 18 Feb 2019 05:44:09 -0800 (PST)
MIME-Version: 1.0
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
 <CADnJP=vsum7_YYWBpknpahTQFAzm7G40_E2dLMB_poFEhPKEfw@mail.gmail.com> <997509746.100933786.1549350874925.JavaMail.zimbra@redhat.com>
In-Reply-To: <997509746.100933786.1549350874925.JavaMail.zimbra@redhat.com>
From:   Lars Persson <lists@bofh.nu>
Date:   Mon, 18 Feb 2019 14:43:58 +0100
Message-ID: <CADnJP=t25=AcVq7z3w8iG1+ywnSNN4Vbow3-7tOai+qnyD5ACQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge or THP
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, lersek@redhat.com,
        alex williamson <alex.williamson@redhat.com>,
        aarcange@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, mhocko@suse.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 8:14 AM Jan Stancek <jstancek@redhat.com> wrote:
> Hi,
>
> are you using THP (CONFIG_TRANSPARENT_HUGEPAGE)?
>
> The changed line should affect only THP and normal compound pages,
> so a test with THP disabled might be interesting.
>
> >
> > The breakage consists of random processes dying with SIGILL or SIGSEGV
> > when we stress test the system with high memory pressure and explicit
> > memory compaction requested through /proc/sys/vm/compact_memory.
> > Reverting this patch fixes the crashes.
> >
> > We can put some effort on debugging if there are no obvious
> > explanations for this. Keep in mind that this is 32-bit system with
> > HIGHMEM.
>
> Nothing obvious that I can see. I've been trying to reproduce on
> 32-bit x86 Fedora with no luck so far.
>

Hi

Thanks for looking in to it. After some deep dive in MM code, I think
it is safe to say this patch was innocent.

All traces studied so far points to a missing cache coherency call in
mm/migrate.c:migrate_page that is needed only for those evil MIPSes
that lack I/D cache coherency. I will send a write-up to linux-mips
about this. Basically for a non-mapped page it does only a copy of
page data and metadata but no flush_dcache_page() call will be done.
This races with subsequent use of the page.

BR,
 Lars
