Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367E92070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="EEWRiHhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfBVUBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:01:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40193 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfBVUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:01:38 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so3913623qta.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=fl7nYC6cpTkbZxzDWiP81NBImurl1YaeYaX9+LA2u3M=;
        b=EEWRiHhO256XhZN7BmbLqMqueGOPhb08GxFibM4b+5Nf97h/2XmNzDGALkq4g3e9kS
         hIX1S2rMUwBNn8XQ4orDxVAJbvBEqCfEHIe7eLU3cTiTzuANNMd5ypZ2EoPKvXSj+vIb
         xu+K3QPhLMBoLc5pBT3w7s0EoXLJxLTxUL7XM0I4R8MHM/J9QaP3EO4sb1bXLcSUzmqB
         vUP7uLhLwsIWq63n/I9GxxiEzEpHRh2WuKWGeYxGpevJUokNJO9MoMLn5b1dSIEisZwH
         nZmNvy1x72dJcI+GlRsTc0SoKhCE0p6oVEESVtEMc0xMmS5gpml5M/JYH4Zr8E+Nf1Na
         xQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=fl7nYC6cpTkbZxzDWiP81NBImurl1YaeYaX9+LA2u3M=;
        b=bSeeoLQrFSJ/uofCkGsMxJ1hmblP1CGcbk4fwbp5IZzGR8irQf5BXHOTdQ4ggx27ZE
         WvcsffLZYoHlOWe/o6HjQu3lRB1HCG1WDe/Et/C9NXJqKuRlOJdGcYBd0bJ7MIg8iaC2
         4is+NGlTJ3RZC2iDTJvaEtyBn3rkGN9TrQfIzpGK4Wrdp0WTkJ5RTorF/6Wyk++NB0uQ
         4+/rHqmuWTyNDq9XN4QqT3JtJYV5QS4pL65P+VEDjYOnrf+C+Bzud1qpka2ydSLZ7S2X
         OeZpBtuYedSRDQbWgD4WXvu3Jf9l4n9eXpqxpuVJgCJcU3Blq//RWY8qwp3doxYJ1pvZ
         Jxxg==
X-Gm-Message-State: AHQUAubIw7D5BILaNCXoJNvRr8pc39JP7uZNiPorY55gqwyC1AH9yLOr
        +c9zIFzbqtsPMIzeJIM82AE9yw==
X-Google-Smtp-Source: AHgI3IYuBVcxDmawpdFOZhM6nCp1PRuMMr8R5XZmwMQdBKmiuyiKQ9R/tmGyARNRjP1dg1bYmzBX9A==
X-Received: by 2002:ac8:3872:: with SMTP id r47mr4603634qtb.364.1550865697012;
        Fri, 22 Feb 2019 12:01:37 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id n2sm1729448qtc.13.2019.02.22.12.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:01:36 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:01:29 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Joe Perches <joe@perches.com>
Cc:     syzbot <syzbot+8218a8a0ff60c19b8eae@syzkaller.appspotmail.com>,
        ast@kernel.org, christian@brauner.io, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, hawk@kernel.org,
        idosch@mellanox.com, john.fastabend@gmail.com, kafai@fb.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        roopa@cumulusnetworks.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, xdp-newbies@vger.kernel.org,
        yhs@fb.com
Subject: Re: INFO: task hung in rtnetlink_rcv_msg
Message-ID: <20190222120129.1f2f1c17@cakuba.netronome.com>
In-Reply-To: <000000000000c07a5805827e85d5@google.com>
References: <000000000000c07a5805827e85d5@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Seems like something funny is going on with get_maintainer.pl since XDP
entry got added.  We seem to have been CCed on:

net: ns83820: code cleanup for ns83820_probe_phy()
veth: Fix -Wformat-truncation
INFO: task hung in rtnetlink_rcv_msg

I tried Florian's veth patch myself and it does indeed produce:

"David S. Miller" <davem@davemloft.net> (odd fixer:NETWORKING DRIVERS,commit_signer:9/15=60%)
Alexei Starovoitov <ast@kernel.org> (supporter:XDP (eXpress Data Path))
Daniel Borkmann <daniel@iogearbox.net> (supporter:XDP (eXpress Data Path),commit_signer:6/15=40%)
Jakub Kicinski <jakub.kicinski@netronome.com> (supporter:XDP (eXpress Data Path))
Jesper Dangaard Brouer <hawk@kernel.org> (supporter:XDP (eXpress Data Path))
John Fastabend <john.fastabend@gmail.com> (supporter:XDP (eXpress Data Path),commit_signer:2/15=13%)
Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> (commit_signer:11/15=73%,authored:11/15=73%,added_lines:1027/1055=97%,removed_lines:180/195=92%)
David Ahern <dsahern@gmail.com> (commit_signer:2/15=13%,authored:1/15=7%)
Li RongQing <lirongqing@baidu.com> (authored:1/15=7%,removed_lines:14/195=7%)
Michael Walle <michael@walle.cc> (authored:1/15=7%)
"Gustavo A. R. Silva" <gustavo@embeddedor.com> (authored:1/15=7%)
netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
linux-kernel@vger.kernel.org (open list)
xdp-newbies@vger.kernel.org (open list:XDP (eXpress Data Path))

Even though it only touches:

 drivers/net/veth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

And XDP entry is:

XDP (eXpress Data Path)
M:	Alexei Starovoitov <ast@kernel.org>
M:	Daniel Borkmann <daniel@iogearbox.net>
M:	David S. Miller <davem@davemloft.net>
M:	Jakub Kicinski <jakub.kicinski@netronome.com>
M:	Jesper Dangaard Brouer <hawk@kernel.org>
M:	John Fastabend <john.fastabend@gmail.com>
L:	netdev@vger.kernel.org
L:	xdp-newbies@vger.kernel.org
S:	Supported
F:	net/core/xdp.c
F:	include/net/xdp.h
F:	kernel/bpf/devmap.c
F:	kernel/bpf/cpumap.c
F:	include/trace/events/xdp.h
K:	xdp
N:	xdp

So no relation to drivers at all... 
