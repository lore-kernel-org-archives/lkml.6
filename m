Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38994C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098BD222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBPGht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 01:37:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbfBPGht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 01:37:49 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42D998F757739CCB52EA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 14:37:45 +0800 (CST)
Received: from [127.0.0.1] (10.57.71.8) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 14:37:38 +0800
To:     <sergey.senozhatsky@gmail.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
From:   Yao HongBo <yaohongbo@huawei.com>
Subject: possible deadlock in console_unlock
Message-ID: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
Date:   Sat, 16 Feb 2019 14:36:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.71.8]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, sergey:

As shown in that link, https://lkml.org/lkml/2018/6/6/397

On the linux kernel 5.0-rc6, Syzkaller also hit 'possible deadlock in console_unlock'
bug for several times in my environment.

This solution fixes things for me. Do you have a plan to submit patches to
solve this problem.

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
	__printk_safe_enter();
	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
	__printk_safe_exit();



Best regards,
Hongbo

