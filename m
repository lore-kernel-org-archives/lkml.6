Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C1EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6717C21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfADPdo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:33:44 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:56068 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfADPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:33:43 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x04FX8Yu025100
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 5 Jan 2019 00:33:08 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x04FX8sh008206;
        Sat, 5 Jan 2019 00:33:08 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x04FX8LT020459;
        Sat, 5 Jan 2019 00:33:08 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-1186735; Sat, 5 Jan 2019 00:31:29 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Sat, 5
 Jan 2019 00:31:29 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     lijiang <lijiang@redhat.com>
CC:     "bhe@redhat.com" <bhe@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 v4] kdump: add the vmcoreinfo documentation
Thread-Topic: [PATCH 1/2 v4] kdump: add the vmcoreinfo documentation
Thread-Index: AQHUmCarLJirG+8GGUKf+iqFxfsfO6WclVbwgAFNzQCAAWiK4A==
Date:   Fri, 4 Jan 2019 15:31:28 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035657CA@BPXM09GP.gisp.nec.co.jp>
References: <20181220054044.30738-1-lijiang@redhat.com>
 <20181220054044.30738-2-lijiang@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035656E1@BPXM09GP.gisp.nec.co.jp>
 <bf26e868-9dfd-5344-df56-df8ff0442df0@redhat.com>
In-Reply-To: <bf26e868-9dfd-5344-df56-df8ff0442df0@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.133.161]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
> >> +=======================
> >> +What is the VMCOREINFO?
> >> +=======================
> >> +
> >> +VMCOREINFO is a special ELF note section. It contains various
> >> +information from the kernel like structure size, page size, symbol
> >> +values, field offsets, etc. These data are packed into an ELF note
> >> +section and used by user-space tools like crash and makedumpfile to
> >> +analyze a kernel's memory layout.
> >> +
> >> +To dump the VMCOREINFO contents, one can do:
> >> +
> >> +# makedumpfile -g VMCOREINFO -x vmlinux
> >
> > again, this command does not dump the VMCOREINFO in ELF note section.
> > It converts the vmlinux's debug infomation into a VMCOREINFO-like data.
> > So I don't think this command is suitable to introduce here.
> >
> 
> Thank you, Kazu.
> 
> As you mentioned, makedumpfile in 'devel' branch can print VMCOREINFO in /proc/kcore,
> can i add the following command to this document?
> 
> #makedumpfile --mem-usage /proc/kcore -D

I don't know whether we can add unreleased softwares to the document.
Any comments on this?

If it's OK, crash also can dump it, so
---
To dump the VMCOREINFO contents, one can do:

  # crash vmlinux /proc/kcore
  ...
  > help -n
or
  # makedumpfile -D --mem-usage /proc/kcore
---

or remove that for now and update later?

> 
> >> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
> >> +PG_hwpoision|PG_head_mask
> >> +-----------------------------------------------------
> >> +
> >> +Page attributes. These flags are used to filter free pages.
> >
> > Some of these are not used to filter *free* pages, so
> >
> > ... used to filter various unnecessary pages.
> >
> 
> Great. I will modify it in next post.
> 
> And also merge the 'PG_buddy' and 'PG_offline'  into the PG_* flag here.

Thanks, I think your "PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)" style is good.

Kazu

> 
> Many thanks.
> 
> Lianbo
> 
> >> +PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
> >> +--------------------------------------
> >
> > then, this can be merged into the one above?
> >
> >> +======
> >> +x86_64
> >> +======
> > ...
> >> +PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
> >> +----------------------------------------
> >
> > This looks not only for x86_64, and also can be merged into
> > the PG_* flags?
> >
> > Thank you for your effort!
> > Kazu
> >
> >


