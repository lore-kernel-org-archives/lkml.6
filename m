Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE58C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED872145D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgVhUp2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED872145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752970AbeGDX0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 19:26:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34068 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752881AbeGDX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 19:26:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id e10-v6so3685592pfn.1;
        Wed, 04 Jul 2018 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2KLFC75M4siEtt8eWsx8jM/QdSvtfAit+Y049fcjGg=;
        b=RgVhUp2RT1WJ32xF4S6BKaYPhuB1KJrcW6GwP1NP2jHNlquz7tcQkBSyvtYzmTOh/D
         DT+ZrBr3+d52ESFdYjGFQZM9UNRxDXkKEXSypoCZezm0iE+D8+1JwBTKGl3cHfzAJR1G
         06Oewx+/Z7TcVaNINMLe5i6eX/J/pg6UedZ9449GxlcqSFlTwU2XxS3Lfdj14PM4yybx
         34p6oPzOG5ouZB2j/Sgs3XYuodzvF3JXXi5fXQ7Ug0x3Oa1pRQ9wkx099CkGKxQkI+p6
         mtYdllkKNt42j0W69jfIw9RxrwPeQ15bsJvBUAW6PoS8z/ckZdi9Vc+599hfkTwWBGEk
         gbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2KLFC75M4siEtt8eWsx8jM/QdSvtfAit+Y049fcjGg=;
        b=b12UlkKztmbPKgrwWmJ5VNDNx21lnO4+26QdduyLs6P3y/hsn1aSC5GPm3VjlVgx6p
         UEyK20w4z1QF6aYVlS+8xmmor43Fs8+ZlabavpMdW3gBNpx/FN+CQaUlzKkdGqQkWaxE
         jZ3Qn4cSJMn6MGma5cnQ1rJwh8fIxmjw9RfPobEogU14IWGVUV57q7WeKk8nYjj9F3SI
         CogCK2M/ALcpLpP1rVr7oRDzO83j1DRFUnLY+lX5sOjgNHNLhpImnDK+jpAMd7rcoSji
         Ajf0OGiT68EqYLeJd1ne7GaLtrLgITJfB0Epj8gRTm3pS8/mZHA7P6LiQ/IKMh6XW1Mz
         I3Eg==
X-Gm-Message-State: APt69E0av75CCJTlhe/wmdvHuT9LMDSbJ+Tn+OOo9Rc++6dtyuOVC7vH
        WbSk6Gg06rweevEUlBnP3vk=
X-Google-Smtp-Source: AAOMgpexqxuYi2naDLmS95cl4gO4uedcvZC4Z1s7+kEdmA9eqmfUDtWYEokU6Vj+k+pzhEOPF4pb4Q==
X-Received: by 2002:a62:bd03:: with SMTP id a3-v6mr3955979pff.138.1530746791411;
        Wed, 04 Jul 2018 16:26:31 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id 67-v6sm9478456pfm.171.2018.07.04.16.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 16:26:30 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:26:29 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Roland Dreier <roland@purestorage.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, rds-devel@oss.oracle.com,
        syzbot <syzbot+db1c219466daac1083df@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in __list_add_valid (5)
Message-ID: <20180704232629.GJ725@sol.localdomain>
References: <089e0825fc78410eaa056845781e@google.com>
 <20180513230237.GG677@sol.localdomain>
 <CAL1RGDVNaJ8OG+4ajmCZN1GnvsZUAqY3LXMRPv57mGSPJyhwAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1RGDVNaJ8OG+4ajmCZN1GnvsZUAqY3LXMRPv57mGSPJyhwAQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:49:23PM -0700, Roland Dreier wrote:
> > Still reproducible on Linus' tree (commit 66e1c94db3cd4e) and on linux-next
> > (next-20180511).  Here's a simplified reproducer:
> 
> Thanks!  That's a fantastic test case.
> 
> The issue is a race where rdma_listen() sees invalid state in the
> middle of an rdma_bind_addr() call that will ultimately fail.  I'll
> send a proposed patch shortly.
> 
>  - R.

Ping; there's still no fix merged for this.  The reproducer also works as an
unprivileged user.

- Eric
