Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D249C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9982B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="XOXjHF+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeLNTLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:11:54 -0500
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:34040 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730123AbeLNTLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:11:54 -0500
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.22/8.16.0.22) with SMTP id wBEJ7ali013937;
        Fri, 14 Dec 2018 11:11:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : sender : date : from : to : cc
 : subject : message-id : references : in-reply-to; s=20180706;
 bh=wkU3KERiZzJG3Qh7No4Q785Xo9m0kDnlKMp0M9msAVk=;
 b=XOXjHF+n3RBKjvmqWdDvett+i/ZHZZdvR6MvTXvaK1ZNZMSPEA9TyzWxwMJu46ixkWAo
 V09G4foo4H2a6Qmj8TNBKz2y32lHfNQLV0LXS4Nufy6nFn6Lj22Z0IlIt1CfpKoWonnu
 cI4Tl5L2fEeMGUJNTlJyvsZaSw6O3ncQMeczB/W1uX6BGbVSlKq9hbnBdsHBAVWE8ZaQ
 rkjKJwP1o0dXPYSzKIMU26ozBas+4WJqSA6SG3nRRTMhVp+GkLijTbKAi5GtKp79D8t9
 3v5WLGRT6fWdJFHJuQzaXFh6xmdsiGQf3RCO6qKW9AENIYMVsUtZES+Yx6lmFXO2qYqQ yw== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com [17.179.226.135])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2p8bcd0vg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 14 Dec 2018 11:11:45 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-type: text/plain; CHARSET=US-ASCII
Received: from nwk-mmpp-sz09.apple.com
 (nwk-mmpp-sz09.apple.com [17.128.115.80]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PJQ00BE0QNKYTD0@mr2-mtap-s03.rno.apple.com>; Fri,
 14 Dec 2018 11:11:45 -0800 (PST)
Received: from process_viserion-daemon.nwk-mmpp-sz09.apple.com by
 nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PJQ00200Q5MZS00@nwk-mmpp-sz09.apple.com>; Fri,
 14 Dec 2018 11:11:44 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 3261cd830d760c0410952f995736816b
X-Va-E-CD: 4323c9cb7650976afee1876783f7d85e
X-Va-R-CD: d885efb23def6dc3d7fbf3a036d898ad
X-Va-CD: 0
X-Va-ID: d4cdeba3-f7ab-4053-8f59-2b0954b11efc
X-V-A:  
X-V-T-CD: 9282bafb218900537fab2921e7776c7e
X-V-E-CD: 4323c9cb7650976afee1876783f7d85e
X-V-R-CD: d885efb23def6dc3d7fbf3a036d898ad
X-V-CD: 0
X-V-ID: 46ab1bc1-9bbd-467a-b89b-4c03a9607b38
Received: from process_milters-daemon.nwk-mmpp-sz09.apple.com by
 nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PJQ00D00QNBLM00@nwk-mmpp-sz09.apple.com>; Fri,
 14 Dec 2018 11:11:44 -0800 (PST)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-12-14_11:,, signatures=0
Received: from localhost ([17.192.155.217]) by nwk-mmpp-sz09.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPSA id <0PJQ002KQQNKMV40@nwk-mmpp-sz09.apple.com>; Fri,
 14 Dec 2018 11:11:44 -0800 (PST)
Date:   Fri, 14 Dec 2018 11:11:44 -0800
From:   Christoph Paasch <cpaasch@apple.com>
To:     David Miller <davem@davemloft.net>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, bhole_prashant_q7@lab.ntt.co.jp,
        tyhicks@canonical.com, eric.dumazet@gmail.com, edumazet@google.com
Subject: Re: [PATCH 4.14 09/89] net: Prevent invalid access to skb->prev in
 __qdisc_drop_all
Message-id: <20181214191144.GP41383@MacBook-Pro-19.local>
References: <20181214115729.658859279@linuxfoundation.org>
 <20181214115730.135586551@linuxfoundation.org>
 <20181214155226.GJ41383@MacBook-Pro-19.local>
 <20181214.110530.1362956449531434869.davem@davemloft.net>
In-reply-to: <20181214.110530.1362956449531434869.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_11:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/18 - 11:05:30, David Miller wrote:
> From: Christoph Paasch <cpaasch@apple.com>
> Date: Fri, 14 Dec 2018 07:52:26 -0800
> 
> > I don't think this patch needs to be backported. I haven't hit this panic on
> > v4.14.x (although, I only have been using v4.14.79 for now - not yet the
> > latest one). And the commits that seem to have introduced the issue haven't
> > been backported either AFAICS. That being said, I don't think a backport
> > would cause any side-effects.
> > 
> > Or have you seen reports of this panic in the stable branches?
> > 
> > (same for the other stable branches v4.4,... - cfr., the other mails
> > regarding this patch here)
> 
> I was being ultra paranoid when I decided to submit this to 4.14 too,
> and as Eric says it does not harm.

Sounds good to me. I just wanted to point out that I didn't reproduce the
issue nor tested the patch on the older stable branches.


Christoph

