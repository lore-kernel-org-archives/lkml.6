Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D98AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CA1218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbeLXMER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:04:17 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:59370 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbeLXMER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:04:17 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 44F2D12B609;
        Mon, 24 Dec 2018 21:04:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBOC4Ev1009607
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 21:04:16 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBOC4EjQ029031
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 24 Dec 2018 21:04:14 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id wBOC4C0B029030;
        Mon, 24 Dec 2018 21:04:12 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
        sfr@canb.auug.org.au
Subject: Re: [PATCH v3 0/3] fat: Added functions to determine the FAT variant (12/16/32bit)
References: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
Date:   Mon, 24 Dec 2018 21:04:12 +0900
In-Reply-To: <1544990640-11604-1-git-send-email-carmeli.tamir@gmail.com>
        (Carmeli Tamir's message of "Sun, 16 Dec 2018 15:03:57 -0500")
Message-ID: <874lb3jflv.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carmeli Tamir <carmeli.tamir@gmail.com> writes:

> Along the FAT FS code, the FAT variant (whether this is FAT12, FAT16 or FAT32) is
> determined by checking the fat_bits field of struct msdos_sb_info.
> This is somewhat error prone as it forces the usage of magics (12, 16, 32)
> multiple times in the code.
>
> This series replaces the places in which the variant is checked with three
> inline functions - IS_FAT12, IS_FAT16 and IS_FAT16.
>
> The introduction of these simple inline functions makes a clearer API for determining the variant,
> rather than searching the code for some field in a struct, and therefore
> increases the code's maintainability and readability.
>
> In addition, minor cleanups around code that checks for the FAT variant,
> and fixed comments from v1 and v2.
>
> Carmeli Tamir (3):
>   Removed fat_first_ent
>   Moved and inlined MAX_FAT
>   IS_FAT functions
>
>  fs/fat/cache.c                |  2 +-
>  fs/fat/dir.c                  |  4 ++--
>  fs/fat/fat.h                  | 30 +++++++++++++++++++++++++++++-
>  fs/fat/fatent.c               | 16 +++++++---------
>  fs/fat/inode.c                | 26 +++++++++++++++-----------
>  fs/fat/misc.c                 |  2 +-
>  include/uapi/linux/msdos_fs.h |  5 -----
>  7 files changed, 55 insertions(+), 30 deletions(-)

FWIW,

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

for all of this patchset.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
