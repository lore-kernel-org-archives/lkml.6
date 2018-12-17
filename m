Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76314C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440902145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbeLQPAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:00:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732831AbeLQPAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:00:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EFDC80F98;
        Mon, 17 Dec 2018 15:00:07 +0000 (UTC)
Received: from localhost (ovpn-200-20.brq.redhat.com [10.40.200.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A76E360F8D;
        Mon, 17 Dec 2018 15:00:03 +0000 (UTC)
Date:   Mon, 17 Dec 2018 15:59:58 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        syzbot <syzbot+43f6755d1c2e62743468@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        netdev <netdev@vger.kernel.org>
Subject: Re: WARNING in __rcu_read_unlock
Message-ID: <20181217155958.2e9c4b24@redhat.com>
In-Reply-To: <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com>
References: <0000000000005e47a2057d0edc49@google.com>
        <20181216190412.GE4170@linux.ibm.com>
        <CACT4Y+b+mSs2FV3BY+MsHDTPPgvPaCdMmJONd9c4zEU67CdmOA@mail.gmail.com>
        <20181217112916.GG4170@linux.ibm.com>
        <1583d5fc-34bf-3a81-363d-01a1085a7363@linux.intel.com>
        <CACT4Y+aKn4XsGVgt3ELGnnJcg6H-m+dSdV018dLvJhrpshycWA@mail.gmail.com>
        <20641819-e4fb-f3bd-34c8-c68106cccd0e@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Dec 2018 15:00:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 06:57:35 -0800
Eric Dumazet <eric.dumazet@gmail.com> wrote:

> Might be cause by commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> fou, fou6: ICMP error handlers for FoU and GUE

Most likely, yes.

> Please Stefano take a look, thanks !

Started one minute before your email, thanks for Cc'ing me though!

-- 
Stefano
