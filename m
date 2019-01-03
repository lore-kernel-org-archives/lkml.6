Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18726C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A382184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 19:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfACTcj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 14:32:39 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:55035 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfACTcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 14:32:39 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x03JVrD6006770
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 4 Jan 2019 04:31:53 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x03JVrqN032082;
        Fri, 4 Jan 2019 04:31:53 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x03JVrwa020740;
        Fri, 4 Jan 2019 04:31:53 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.136] [10.38.151.136]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-1172895; Fri, 4 Jan 2019 04:28:16 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC08GP.gisp.nec.co.jp ([10.38.151.136]) with mapi id 14.03.0319.002; Fri, 4
 Jan 2019 04:28:15 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     Lianbo Jiang <lijiang@redhat.com>
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
Thread-Index: AQHUmCarLJirG+8GGUKf+iqFxfsfO6WclVbw
Date:   Thu, 3 Jan 2019 19:28:14 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035656E1@BPXM09GP.gisp.nec.co.jp>
References: <20181220054044.30738-1-lijiang@redhat.com>
 <20181220054044.30738-2-lijiang@redhat.com>
In-Reply-To: <20181220054044.30738-2-lijiang@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.133.166]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

-----Original Message-----
> +=======================
> +What is the VMCOREINFO?
> +=======================
> +
> +VMCOREINFO is a special ELF note section. It contains various
> +information from the kernel like structure size, page size, symbol
> +values, field offsets, etc. These data are packed into an ELF note
> +section and used by user-space tools like crash and makedumpfile to
> +analyze a kernel's memory layout.
> +
> +To dump the VMCOREINFO contents, one can do:
> +
> +# makedumpfile -g VMCOREINFO -x vmlinux

again, this command does not dump the VMCOREINFO in ELF note section.
It converts the vmlinux's debug infomation into a VMCOREINFO-like data.
So I don't think this command is suitable to introduce here.

> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|
> +PG_hwpoision|PG_head_mask
> +-----------------------------------------------------
> +
> +Page attributes. These flags are used to filter free pages.

Some of these are not used to filter *free* pages, so

... used to filter various unnecessary pages.

> +PAGE_BUDDY_MAPCOUNT_VALUE or ~PG_buddy
> +--------------------------------------

then, this can be merged into the one above?

> +======
> +x86_64
> +======
...
> +PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
> +----------------------------------------

This looks not only for x86_64, and also can be merged into
the PG_* flags?

Thank you for your effort!
Kazu


