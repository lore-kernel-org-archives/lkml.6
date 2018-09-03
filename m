Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C323C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274EC20857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274EC20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeICFgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:36:51 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:14454 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICFgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:36:51 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 8F8EE41336;
        Mon,  3 Sep 2018 03:19:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id g9SryOsd1zEH; Mon,  3 Sep 2018 03:19:00 +0200 (CEST)
Date:   Mon, 3 Sep 2018 03:18:32 +0200
From:   Christian Brauner <christian@brauner.io>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        ktkhai@virtuozzo.com, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com, jbenc@redhat.com,
        nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 4/5] ipv6: enable IFA_IF_NETNSID for RTM_GETADDR
Message-ID: <20180903011829.t3yzsomjvcjwxakz@mailbox.org>
References: <20180828231859.29758-5-christian@brauner.io>
 <201808310127.xJh9cWoD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201808310127.xJh9cWoD%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 02:41:45AM +0800, kbuild test robot wrote:
> Hi Christian,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on net-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Christian-Brauner/rtnetlink-add-IFA_IF_NETNSID-for-RTM_GETADDR/20180830-194411
> config: x86_64-randconfig-s1-08302022 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "rtnl_get_net_ns_capable" [net/ipv6/ipv6.ko] undefined!

Fwiw, this is triggered when ipv6 is built as a module. The first
version of my patch did not take that into account and left
rtnl_get_net_ns_capable() unexported. The second version will export
that function and fix this issue.

Christian
