Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF039C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA362082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA362082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLDJ6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:58:03 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:51110 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLDJ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:58:03 -0500
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
From:   Meelis Roos <mroos@linux.ee>
Subject: Compiling with old gcc breaks when CONFIG_RETPOLINE is off
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <6eeee8da-82ac-f527-9278-7ebcc8756ea1@linux.ee>
Date:   Tue, 4 Dec 2018 11:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just tried 4.20-rc5 on an old K6-2 PC with gcc 5.3.1, got an error about non-retpoline compiler,
turned CONFIG_RETPOLINE off and retried.

To my surprise, compilation still breaks with
arch/x86/Makefile:224: *** You are building kernel with non-retpoline compiler, please update your compiler..  Stop.

As I read the Makefile, it should error only when CONFIG_RETPOLINE is enabled, but it still breaks.

$ grep -r CONFIG_RETPOLINE .config
# CONFIG_RETPOLINE is not set

$ grep -r CONFIG_RETPOLINE include/
include/generated/autoconf.h:#define CONFIG_RETPOLINE 1
include/config/auto.conf:CONFIG_RETPOLINE=y

So the headers have not been updated yet, maybe?

-- 
Meelis Roos <mroos@linux.ee>
