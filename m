Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC757C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B8020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B8020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeLNJtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:49:33 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:42600 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeLNJtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:49:32 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id ABE2B161688;
        Fri, 14 Dec 2018 18:49:31 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBE9nUF3025703
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 18:49:31 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id wBE9nU3i027752
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 18:49:30 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id wBE9nSLM027751;
        Fri, 14 Dec 2018 18:49:28 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Tamir Carmeli <carmeli.tamir@gmail.com>
Cc:     joe@perches.com, jthumshirn@suse.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        akpm@linux-foundation.org, axboe@kernel.dk,
        martin.petersen@oracle.com, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fat: New macros to determine the FAT variant (32, 16 or 12)
References: <1544470917-6443-1-git-send-email-carmeli.tamir@gmail.com>
        <1544470917-6443-3-git-send-email-carmeli.tamir@gmail.com>
        <906167f7ca975d437ff9868333d8bf1e86b934a7.camel@perches.com>
        <87sgz0dci0.fsf@mail.parknet.co.jp>
        <CAKxm1-G7WpJV0_3=TLyY_JMN=Wz1GkM2w6buc6ez+WUZ_tyEhg@mail.gmail.com>
Date:   Fri, 14 Dec 2018 18:49:28 +0900
In-Reply-To: <CAKxm1-G7WpJV0_3=TLyY_JMN=Wz1GkM2w6buc6ez+WUZ_tyEhg@mail.gmail.com>
        (Tamir Carmeli's message of "Fri, 14 Dec 2018 10:14:35 +0200")
Message-ID: <87efakcuaf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tamir Carmeli <carmeli.tamir@gmail.com> writes:

> I just want to make sure, is there a reason why I shouldn't delete
> FAT_FIRST_ENT, as Joe Perches commented?

FAT_FIRST_ENT() was used to check if fat spec compliance. But in real
world, there are too many implementations that didn't follow spec.

Well, so, now FAT_FIRST_ENT() is pointed only from comment. The reason
is only for this comment.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
