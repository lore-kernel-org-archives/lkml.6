Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793EBC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E069021486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 04:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E069021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ssi.bg
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeHVHe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:34:58 -0400
Received: from ja.ssi.bg ([178.16.129.10]:42998 "EHLO ja.ssi.bg"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbeHVHe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:34:58 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.15.2/8.15.2) with ESMTP id w7M4BfiW002518;
        Wed, 22 Aug 2018 07:11:41 +0300
Date:   Wed, 22 Aug 2018 07:11:41 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Cong Wang <xiyou.wangcong@gmail.com>
cc:     syzbot+30209ea299c09d8785c9@syzkaller.appspotmail.com,
        ddstreet@ieee.org, Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: unregister_netdevice: waiting for DEV to become free (2)
In-Reply-To: <CAM_iQpVM4wHkW4RKMuDj_Jjof3XbJmAsN0SdSRfneaf94CL0cw@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1808220603170.1734@ja.home.ssi.bg>
References: <0000000000007d22100573d66078@google.com> <alpine.LFD.2.20.1808201527230.2758@ja.home.ssi.bg> <CAM_iQpVM4wHkW4RKMuDj_Jjof3XbJmAsN0SdSRfneaf94CL0cw@mail.gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Mon, 20 Aug 2018, Cong Wang wrote:

> For the one I look into, dst_cache doesn't matter, because the xmit
> path doesn't even use tunnel dst_cache at all, and it is ip6tnl0 FB
> device, unlike this one which is tun device.

	Ops, of course, it is dev tun and not ip tun...

> For the one I look into, it seems some fib6_info is not released for
> some reason. It seems to be the one created by addrconf_prefix_route(),
> which is supposed to be released by fib6_clean_tree() I think, but it
> never happens.

	May be, it is not direct reference to dev but one
that is moved to loopback, like from dst, route... The repro.c
creates permanent neighbours and addresses.

Regards

--
Julian Anastasov <ja@ssi.bg>
