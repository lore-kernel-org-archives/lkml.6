Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D37C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA092086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA092086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeLNDQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:16:12 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:42496 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeLNDQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:16:11 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id A4735161688;
        Fri, 14 Dec 2018 12:16:10 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBE3G9ga019453
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 12:16:10 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBE3G9Hd018597
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 12:16:09 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id wBE3G7OH018596;
        Fri, 14 Dec 2018 12:16:07 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Joe Perches <joe@perches.com>
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>, jthumshirn@suse.de,
        sergey.senozhatsky@gmail.com, akpm@linux-foundation.org,
        axboe@kernel.dk, martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fat: New macros to determine the FAT variant (32, 16 or 12)
References: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
        <1544470917-6443-3-git-send-email-carmeli.tamir@gmail.com>
        <906167f7ca975d437ff9868333d8bf1e86b934a7.camel@perches.com>
Date:   Fri, 14 Dec 2018 12:16:07 +0900
In-Reply-To: <906167f7ca975d437ff9868333d8bf1e86b934a7.camel@perches.com> (Joe
        Perches's message of "Mon, 10 Dec 2018 12:09:31 -0800")
Message-ID: <87sgz0dci0.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

>>  
>> -#define FAT_FIRST_ENT(s, x)     ((MSDOS_SB(s)->fat_bits == 32 ? 0x0FFFFF00 : \
>> -	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
>> +#define IS_FAT12(sbi) (sbi->fat_bits == 12)
>> +#define IS_FAT16(sbi) (sbi->fat_bits == 16)
>> +#define IS_FAT32(sbi) (sbi->fat_bits == 32)
>
> sbi should be parenthesized or perhaps better these should be
> static inline bool functions

Right, rather this is the bug (not hit yet though) that should be fixed.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
