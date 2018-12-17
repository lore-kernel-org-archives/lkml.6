Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F30DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2D3206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbeLQTed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:34:33 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:52857 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbeLQTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:34:32 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43JWYx1jKfz1qvvp;
        Mon, 17 Dec 2018 20:34:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43JWYx15V8z1qvRR;
        Mon, 17 Dec 2018 20:34:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 0N_GBkQzssUp; Mon, 17 Dec 2018 20:34:28 +0100 (CET)
X-Auth-Info: CBr/x682nBcBhYsisQEGczJSeTtkAUCsCGm3YQgyed54S4JM0xNbIzksAnkCa5Jq
Received: from igel.home (ppp-188-174-154-208.dynamic.mnet-online.de [188.174.154.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Dec 2018 20:34:28 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id CF5812C171A; Mon, 17 Dec 2018 20:34:27 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     rppt@linux.ibm.com, Michael Schmitz <schmitzmic@gmail.com>,
        Sam Creasey <sammy@sammy.net>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] m68k: Fix memblock-related crashes
References: <20181207165011.31497-1-geert@linux-m68k.org>
        <CAMuHMdXj67QnqeMHGr_TiEaJr6gUw5qzWFvaJvoVkm89Kiuq_Q@mail.gmail.com>
        <87o99pmib8.fsf@igel.home> <87a7l4rnb3.fsf@igel.home>
X-Yow:  Yow!  I just went below the poverty line!
Date:   Mon, 17 Dec 2018 20:34:27 +0100
In-Reply-To: <87a7l4rnb3.fsf@igel.home> (Andreas Schwab's message of "Mon, 17
        Dec 2018 20:00:16 +0100")
Message-ID: <875zvsrlq4.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 17 2018, Andreas Schwab <schwab@linux-m68k.org> wrote:

> On Dez 13 2018, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
>> I'm now getting this Oops:
>>
>> [   65.390000] Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
>> [   65.390000] Oops: 00000000
>> [   65.390000] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat virtio_rng virtio_blk virtio_ring virtio xfs btrfs xor zlib_deflate raid6_pq libcrc32c reiserfs squashfs fuse dm_snapshot dm_bufio dm_mod binfmt_misc loop sg
>> [   65.390000] PC: [<00211544>] blk_throtl_bio+0x10e/0x592
>
> And the crash does not occur when I revert commit 1008a11590.

That is not true, so this is an unrelated bug.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
