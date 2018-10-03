Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A25BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED082083F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED082083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJCX07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:26:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34520 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbeJCX07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:26:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1c06::30d2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7D7681466B4E5;
        Wed,  3 Oct 2018 09:37:50 -0700 (PDT)
Date:   Wed, 03 Oct 2018 09:37:49 -0700 (PDT)
Message-Id: <20181003.093749.18891556425491580.davem@davemloft.net>
To:     vdronov@redhat.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: arp, ipv6: handle special case of tap device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <2058134821.17788321.1538573112620.JavaMail.zimbra@redhat.com>
References: <1615981257.17285278.1538393552487.JavaMail.zimbra@redhat.com>
        <20181002.222540.1948082296309410659.davem@davemloft.net>
        <2058134821.17788321.1538573112620.JavaMail.zimbra@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 03 Oct 2018 09:37:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladis Dronov <vdronov@redhat.com>
Date: Wed, 3 Oct 2018 09:25:12 -0400 (EDT)

> Otherwise, we can just to remove the TUNSETLINK ioctl.

I bet that is the best solution unless we can find a real user.
