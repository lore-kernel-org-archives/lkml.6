Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD616C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A331220700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfBVUPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:15:04 -0500
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:37834 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbfBVUPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:15:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CA77E837F27B;
        Fri, 22 Feb 2019 20:15:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: paint60_4894735cdf02b
X-Filterd-Recvd-Size: 2158
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 22 Feb 2019 20:14:58 +0000 (UTC)
Message-ID: <e049375f676938b5ad64898ac928b27cd783dc2a.camel@perches.com>
Subject: Re: INFO: task hung in rtnetlink_rcv_msg
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     syzbot <syzbot+8218a8a0ff60c19b8eae@syzkaller.appspotmail.com>,
        ast@kernel.org, christian@brauner.io, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, hawk@kernel.org,
        idosch@mellanox.com, john.fastabend@gmail.com, kafai@fb.com,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        roopa@cumulusnetworks.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, xdp-newbies@vger.kernel.org,
        yhs@fb.com
Date:   Fri, 22 Feb 2019 12:14:57 -0800
In-Reply-To: <20190222120129.1f2f1c17@cakuba.netronome.com>
References: <000000000000c07a5805827e85d5@google.com>
         <20190222120129.1f2f1c17@cakuba.netronome.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-22 at 12:01 -0800, Jakub Kicinski wrote:
> Hi!
> 
> Seems like something funny is going on with get_maintainer.pl since XDP
> entry got added.  We seem to have been CCed on:

I suggest removing the MAINTAINERS line with

	K:	xdp

as xdp is a pretty generic file/patch content
regex match for the K: type

$ git grep --name-only xdp | wc -l
236

Rather more files than desired.

The N: match is dubious too.

It's generally better to have specific lists of
maintained file patterns rather than using the
K: and N: pattern matches.

---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7ad97b235ec..aa703e2cb882 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16970,7 +16970,6 @@ F:	include/net/xdp.h
 F:	kernel/bpf/devmap.c
 F:	kernel/bpf/cpumap.c
 F:	include/trace/events/xdp.h
-K:	xdp
 N:	xdp
 
 XDP SOCKETS (AF_XDP)


