Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC89C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF70C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF70C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeLMAp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:45:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42372 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeLMAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:45:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C257E149B37A8;
        Wed, 12 Dec 2018 16:45:26 -0800 (PST)
Date:   Wed, 12 Dec 2018 16:45:26 -0800 (PST)
Message-Id: <20181212.164526.189502766995329983.davem@davemloft.net>
To:     alexei.starovoitov@gmail.com
Cc:     sfr@canb.auug.org.au, daniel@iogearbox.net, ast@kernel.org,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next
 tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
References: <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
        <20181213094820.62d26354@canb.auug.org.au>
        <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 12 Dec 2018 16:45:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Dec 2018 15:39:10 -0800

> But this approach doesn't scale.
> We do rebase our trees when we need to fixup or drop patches and
> at any given point a number of commits will be committed by me
> and another set by Daniel. When we rebase we cannot keep adding
> our SOBs to the other person SOBs.
> Then comes the next rebase and we get to the point of
> double and triple SOBs ?

If you use "--signoff" in whatever commands do the rebase you will
get exactly one signoff for yourself and Daniel at maximum.  If it
is there already, git will not add a duplicate one on top.
