Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4766CC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 00:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C4B20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 00:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C4B20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeG3Buj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 21:50:39 -0400
Received: from nautica.notk.org ([91.121.71.147]:44396 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbeG3Bui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 21:50:38 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7FA92C009; Mon, 30 Jul 2018 02:18:15 +0200 (CEST)
Date:   Mon, 30 Jul 2018 02:18:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     v9fs-developer@lists.sourceforge.net, syzkaller@googlegroups.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH] 9p: fix Use-After-Free in
 p9_write_work()
Message-ID: <20180730001800.GA5960@nautica>
References: <20180729130248.29612-1-tomasbortoli@gmail.com>
 <20180729233336.GB28684@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180729233336.GB28684@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Mon, Jul 30, 2018:
> Basically, a more global view of the problem is a race between
> p9_tag_lookup returning a p9_req_t and another thread freeing it.

(just correcting myself here, p9_tag_lookup won't be enough for the
write side, but similarily you'd just need to increment the refcount
when you schedule work with it and decrement when the worker is done)

-- 
Dominique
