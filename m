Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE51C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B0720838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B0720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbeLGG26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:28:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeLGG26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:28:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 646F530821A4;
        Fri,  7 Dec 2018 06:28:58 +0000 (UTC)
Received: from localhost (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 657451001F52;
        Fri,  7 Dec 2018 06:28:56 +0000 (UTC)
Date:   Thu, 06 Dec 2018 22:28:55 -0800 (PST)
Message-Id: <20181206.222855.1688568512001921392.davem@redhat.com>
To:     pabeni@redhat.com
Cc:     netdev@vger.kernel.org, eric.dumazet@gmail.com, pjt@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: mitigate retpoline overhead
From:   David Miller <davem@redhat.com>
In-Reply-To: <20181206.222409.551374562843523036.davem@davemloft.net>
References: <cover.1544032300.git.pabeni@redhat.com>
        <20181206.222409.551374562843523036.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 07 Dec 2018 06:28:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 06 Dec 2018 22:24:09 -0800 (PST)

> Series applied, thanks!

Erm... actually reverted.  Please fix these build failures:

ld: net/ipv6/ip6_offload.o: in function `ipv6_gro_receive':
ip6_offload.c:(.text+0xda2): undefined reference to `udp6_gro_receive'
ld: ip6_offload.c:(.text+0xdb6): undefined reference to `udp6_gro_receive'
ld: net/ipv6/ip6_offload.o: in function `ipv6_gro_complete':
ip6_offload.c:(.text+0x1953): undefined reference to `udp6_gro_complete'
ld: ip6_offload.c:(.text+0x1966): undefined reference to `udp6_gro_complete'
make: *** [Makefile:1036: vmlinux] Error 1

THanks.
