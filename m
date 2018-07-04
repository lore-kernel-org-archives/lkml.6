Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E5CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1865241E0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfktFPEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1865241E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeGDVfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:35:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44068 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbeGDVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:35:08 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so3509214pfh.11;
        Wed, 04 Jul 2018 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NKXD883n718kF5Xm2ZdgDKBvSWTXu3/Z6BRpq5dd5WI=;
        b=FfktFPEs3mflM5mVDIkzjMLsOusz2L6LGu6TwEy/RR7xePDUMsz8BgeABy4ECSw/a+
         I9JvsvHF+g5spG+vnU6Hk6kWMEY1Gj/X79W7m3LOWHpSPj4/uMsYxunD2ZesVgZUm3Ff
         zGNrh9bfYnTHtotU3BvjyzsQyq/I/iCNPRMMG2i5f+h79Ze28tPxnZfEznddFlUQeNrk
         2iyFhsB94vi6GrjzW8Ejo4LzenfuiiF1Y52mQ8PqHtvwlovxuBPRe4E7nSf9rwyz2CjT
         EzVgJsr3Qst3N2SDCWFzlyGM0dfdyKVmdZnO0efUmAcQMJ4TlEUti+OnfAcJUJ8OquCJ
         oPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NKXD883n718kF5Xm2ZdgDKBvSWTXu3/Z6BRpq5dd5WI=;
        b=iGBVBNo4DY3D8VI5edlAFHg8leWJvN/MomLJ+RkMq7lT5f9D2hdnGo+01e7lXtl9Oc
         SPI9TjMnEFLaUhefekbq5PMSiMWg2oj40YX1/GeZ6tYCtW97O41FfUhjVcmrudb3xP6q
         Mi+OP9diij0r8MDbG7mzjLGlnmVWAFSOwhHUxXWTclpcYz/y40ZG//jiMRsGARxWFrxO
         IV/uk9NLjitmCGSmYNDGGx7siwCZvWM5j8KH6kH39a9FTJXyzxSQSIsaAySo435Dwolf
         xndyQCLy9rlruhxGNS7Q3VJg5t8i930V3nJJg8qBl4bcBSK1U4OHQRFqKsseSaKhHCQf
         1G2g==
X-Gm-Message-State: APt69E2v8D8GUyaenxelrLlm1e2pzz6qctZizoU7G2pk0gsABWfko1Cg
        cBEGTLHaYYV3EAtJLaVxoPc=
X-Google-Smtp-Source: AAOMgpevOExVQunOwGBFH7b7f596uXSnvE4bP6X9YBy1RsmE+6veAtKLZV1Ov/G6Yu8cQSnPGZlYLg==
X-Received: by 2002:aa7:81d3:: with SMTP id c19-v6mr3734468pfn.224.1530740108114;
        Wed, 04 Jul 2018 14:35:08 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id v5-v6sm7765497pfm.14.2018.07.04.14.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 14:35:07 -0700 (PDT)
Date:   Wed, 4 Jul 2018 14:35:06 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Cc:     syzbot <syzbot+b51c77ef956678a65834@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in rds_ib_get_mr
Message-ID: <20180704213506.GH725@sol.localdomain>
References: <089e082ce58896ad350567ee4825@google.com>
 <20180513211058.GE677@sol.localdomain>
 <27665604-6a26-36e2-3a58-9c8b3d9eab80@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27665604-6a26-36e2-3a58-9c8b3d9eab80@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 10:46:37PM -0700, santosh.shilimkar@oracle.com wrote:
> On 5/13/18 2:10 PM, Eric Biggers wrote:
> > On Wed, Mar 21, 2018 at 09:00:01AM -0700, syzbot wrote:
> 
> [...]
> 
> 
> > Still reproducible on Linus' tree (commit 66e1c94db3cd4) and linux-next
> > (next-20180511).  Here's a simplified reproducer:
> > 
> Thanks for the test case !!
> 
> Regards,
> Santosh

Ping; this RDS bug is still unfixed.  The same reproducer I gave earlier still
works, even when run as a non-root user.  I tested upstream commit
fc36def997cfd6 (v4.18-rc3-113-gfc36def997cfd), and linux-next commit
bce40927669338 (next-20180704).

- Eric
