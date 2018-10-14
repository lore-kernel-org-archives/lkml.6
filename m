Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9576EC6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F6D2064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F6D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeJNOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 10:47:16 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:58938 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeJNOrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 10:47:16 -0400
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Meelis Roos <mroos@linux.ee>
Subject: Relocation (type 4) overflow on alpha for big module
Message-ID: <5bc11e00-258d-a6ea-fe63-ddcfdb847071@linux.ee>
Date:   Sun, 14 Oct 2018 10:07:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I decided to try btrfs on one of my alphas and got a surprise - btrfs module does not load:

modprobe: ERROR: could not insert 'btrfs': Exec format error

dmesg has

module btrfs: Relocation (type 4) overflow vs btrfs_attach_transaction_barrier

Happens both natively on alpha:
binutils 2.30.0 (Gentoo 2.30 p2) and gcc version 7.3.0 (Gentoo 7.3.0-r3 p1.4)
or in cross-compiling:
binutils (GNU Binutils for Debian) 2.31.1 and gcc version 8.1.0 (Debian 8.1.0-12)

btrfs.ko has size 2939856. Build-in btrfs initializes and tests itself just fine.

This seems to have happened in the distant past:
https://www.redhat.com/archives/axp-list/2005-March/msg00060.html

Do we have a similar binutils problem again with big modules?

-- 
Meelis Roos <mroos@linux.ee>
