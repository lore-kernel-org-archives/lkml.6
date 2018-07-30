Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3FF13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969BE20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969BE20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeG3Mws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:52:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbeG3Mws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5991A8151D42;
        Mon, 30 Jul 2018 11:18:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4D8EFF5B;
        Mon, 30 Jul 2018 11:18:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <b4645de1-a58f-7615-4f47-7a3fd8c7e056@huawei.com>
References: <b4645de1-a58f-7615-4f47-7a3fd8c7e056@huawei.com> <559c49b8-9d58-e242-20c2-fe1b491664dd@huawei.com> <20180730161622.3837cb15@canb.auug.org.au> <2379.1532944057@warthog.procyon.org.uk>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: Re: linux-next: build failure after merge of the staging tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15566.1532949496.1@warthog.procyon.org.uk>
Date:   Mon, 30 Jul 2018 12:18:16 +0100
Message-ID: <15567.1532949496@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 30 Jul 2018 11:18:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 30 Jul 2018 11:18:18 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gao Xiang <gaoxiang25@huawei.com> wrote:

> struct erofs_mount_private priv = {
> 	.dev_name = dev_name,
> 	.options = data
> };
> return mount_bdev(fs_type, flags, dev_name, &priv, erofs_fill_super);
> 
> 
> However, I have no idea if it is safe to do so in the future, so I also
> change it into a more stardard way.

Hopefully, in the near future, you won't do it like this at all, but rather
create an fs_context and then your filesystem would be able to munge that
directly before calling mount_bdev().

David
