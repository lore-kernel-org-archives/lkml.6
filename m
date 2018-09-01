Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA810C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9535420835
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9535420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIAFZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 01:25:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42150 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeIAFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 01:25:49 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5DE10142D15E8;
        Fri, 31 Aug 2018 17:58:48 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:58:47 -0700 (PDT)
Message-Id: <20180831.175847.339882322459287210.davem@davemloft.net>
To:     nicolas.dichtel@6wind.com
Cc:     christian.brauner@canonical.com, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
From:   David Miller <davem@davemloft.net>
In-Reply-To: <ba6a1b18-959e-e307-45fa-e0da9d6f0b0f@6wind.com>
References: <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
        <20180830144544.tpross4jd6awou4u@gmail.com>
        <ba6a1b18-959e-e307-45fa-e0da9d6f0b0f@6wind.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 31 Aug 2018 17:58:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Thu, 30 Aug 2018 17:49:12 +0200

> Maybe I would choose a more generic name for the attribute,
> something that can be used in other netlink families (xfrm,
> netfilter, ...) also.  What about IFA_TARGET_NSID?

Agreed, let's at least try to think ahead about potential future
uses :)
