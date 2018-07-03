Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5255EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D0624704
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D0624704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeGCV6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:58:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45470 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbeGCV63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:58:29 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1faTJa-0002Cl-2r; Tue, 03 Jul 2018 21:58:26 +0000
Date:   Tue, 3 Jul 2018 22:58:26 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 10/32] VFS: Implement a filesystem superblock
 creation/configuration context [ver #8]
Message-ID: <20180703215825.GX30522@ZenIV.linux.org.uk>
References: <20180703183325.GA210265@gmail.com>
 <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
 <152720678933.9073.11201500538963619904.stgit@warthog.procyon.org.uk>
 <14124.1530654802@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14124.1530654802@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:53:22PM +0100, David Howells wrote:
> -				if (s) {
> -					up_write(&s->s_umount);
> +				if (s)
>  					destroy_unused_super(s);

static void destroy_unused_super(struct super_block *s)
{
        if (!s)
                return;
	...
}

IOW, all of those should be unconditional.
