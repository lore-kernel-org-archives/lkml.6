Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01941C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924C2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbeGaPUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:20:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732127AbeGaPU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 284F287A70;
        Tue, 31 Jul 2018 13:40:06 +0000 (UTC)
Received: from bistromath.localdomain (ovpn-204-30.brq.redhat.com [10.40.204.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4837215670D;
        Tue, 31 Jul 2018 13:40:03 +0000 (UTC)
Date:   Tue, 31 Jul 2018 15:40:14 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     syzbot <syzbot+41f9c04b50ef70c66947@syzkaller.appspotmail.com>,
        christian.brauner@ubuntu.com, davem@davemloft.net,
        dsahern@gmail.com, fw@strlen.de, jbenc@redhat.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        lucien.xin@gmail.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in rtnetlink_put_metrics
Message-ID: <20180731134014.GA32114@bistromath.localdomain>
References: <0000000000004fe2be05724ac084@google.com>
 <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8ffd001-8c67-19b9-7223-34ca8d436db2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 13:40:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 31 Jul 2018 13:40:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sd@queasysnail.net' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-31, 05:41:56 -0700, Eric Dumazet wrote:
> 
> 
> On 07/31/2018 05:31 AM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    61f4b23769f0 netlink: Don't shift with UB on nlk->ngroups
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14a9de58400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb4428fdc82f93b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=41f9c04b50ef70c66947
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
[...]

> Probably also caused by :
> 
> 
> commit df18b50448fab1dff093731dfd0e25e77e1afcd1
> Author: Sabrina Dubroca <sd@queasysnail.net>
> Date:   Mon Jul 30 16:23:10 2018 +0200
> 
>     net/ipv6: fix metrics leak

Yeah, I'm looking into both those reports :/

-- 
Sabrina
