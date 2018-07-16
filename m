Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E57CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E2F208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E2F208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGPWPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:15:10 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPWPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:15:09 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3129B13EA8047;
        Mon, 16 Jul 2018 14:45:50 -0700 (PDT)
Date:   Mon, 16 Jul 2018 14:45:49 -0700 (PDT)
Message-Id: <20180716.144549.1700210071419801130.davem@davemloft.net>
To:     ubraun@linux.ibm.com
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com, lifeasageek@gmail.com, sbrivio@redhat.com
Subject: Re: [PATCH net V2 1/1] net/smc: take sock lock in smc_ioctl()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180716115652.72331-1-ubraun@linux.ibm.com>
References: <20180716115652.72331-1-ubraun@linux.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Jul 2018 14:45:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>
Date: Mon, 16 Jul 2018 13:56:52 +0200

> From: Ursula Braun <ursula.braun@linux.ibm.com>
> 
> SMC ioctl processing requires the sock lock to work properly in
> all thinkable scenarios.
> Problem has been found with RaceFuzzer and fixes:
>    KASAN: null-ptr-deref Read in smc_ioctl
> 
> Reported-by: Byoungyoung Lee <lifeasageek@gmail.com>
> Reported-by: syzbot+35b2c5aa76fd398b9fd4@syzkaller.appspotmail.com
> Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>

Applied and queued up for -stable.
