Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69946ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7E820693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7E820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbeGREfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:35:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeGREfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:35:30 -0400
Received: from localhost (unknown [172.58.43.84])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DC744100858FB;
        Tue, 17 Jul 2018 20:59:40 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:59:38 +0900 (KST)
Message-Id: <20180718.125938.2271502580775162784.davem@davemloft.net>
To:     dsahern@gmail.com
Cc:     xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
        nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to
 per-namespace
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
        <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
        <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Jul 2018 20:59:41 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>
Date: Tue, 17 Jul 2018 13:02:18 -0600

> I understand the concern about global resource and limits: as it stands
> you have to increase the limits in init_net to the max expected and hope
> for the best. With per namespace limits you can lower the limits of each
> namespace better control the total impact on the total memory used.
> Perhaps the defaults for namespaces after init_net could have really low
> defaults (e.g., 16 / 32 / 64 for gc_thresh 1/2/3) requiring admin
> intervention.

How does this work when a namespace creates another namespace?

Changing the defaults for non-init_net namespaces could work, but that
could be a surprise to some people.
