Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EF9C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F1920847
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F1920847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeKDLtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:49:50 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:59958 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeKDLto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:49:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 002221438FFC4;
        Sat,  3 Nov 2018 19:29:00 -0700 (PDT)
Date:   Sat, 03 Nov 2018 19:29:00 -0700 (PDT)
Message-Id: <20181103.192900.1832032988138355597.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     pshelar@ovn.org, pablo@netfilter.org, fw@strlen.de, fbl@redhat.com,
        gfree.wind@vip.163.com, thierry@dtsystems.be, yihung.wei@gmail.com,
        eswierk@skyportsystems.com, Julia.Lawall@lip6.fr,
        netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openvswitch: fix linking without
 CONFIG_NF_CONNTRACK_LABELS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181102153705.1664786-1-arnd@arndb.de>
References: <20181102153705.1664786-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 03 Nov 2018 19:29:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri,  2 Nov 2018 16:36:55 +0100

> When CONFIG_CC_OPTIMIZE_FOR_DEBUGGING is enabled, the compiler
> fails to optimize out a dead code path, which leads to a link failure:
> 
> net/openvswitch/conntrack.o: In function `ovs_ct_set_labels':
> conntrack.c:(.text+0x2e60): undefined reference to `nf_connlabels_replace'
> 
> In this configuration, we can take a shortcut, and completely
> remove the contrack label code. This may also help the regular
> optimization.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
