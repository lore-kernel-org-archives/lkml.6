Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56665C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066F22083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066F22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeGaXg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:36:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59908 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeGaXg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:36:26 -0400
Received: from localhost (unknown [172.58.43.50])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC89D100A7F15;
        Tue, 31 Jul 2018 14:54:02 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:53:59 -0700 (PDT)
Message-Id: <20180731.145359.1627616080052338066.davem@davemloft.net>
To:     sd@queasysnail.net
Cc:     eric.dumazet@gmail.com,
        syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com,
        christian.brauner@ubuntu.com, dsahern@gmail.com, fw@strlen.de,
        jbenc@redhat.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, lucien.xin@gmail.com,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180731134014.GA32114@bistromath.localdomain>
References: <0000000000004fe2be05724ac084@google.com>
        <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
        <20180731134014.GA32114@bistromath.localdomain>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 31 Jul 2018 14:54:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>
Date: Tue, 31 Jul 2018 15:40:14 +0200

> 2018-07-31, 05:41:56 -0700, Eric Dumazet wrote:
>> Probably also caused by :
>> 
>> 
>> commit df18b50448fab1dff093731dfd0e25e77e1afcd1
>> Author: Sabrina Dubroca <sd@queasysnail.net>
>> Date:   Mon Jul 30 16:23:10 2018 +0200
>> 
>>     net/ipv6: fix metrics leak
> 
> Yeah, I'm looking into both those reports :/

Please get me a fix for this soon, because as you can imagine this is
going to hold up the 4.18 release.

Thanks.
