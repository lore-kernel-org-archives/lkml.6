Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1666C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2A721773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbeLTQgj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:36:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLTQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:36:39 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6648C0BEAA5;
        Thu, 20 Dec 2018 16:36:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com [10.10.120.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0938C5EE03;
        Thu, 20 Dec 2018 16:36:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CADYN=9KNL=6juu0WuHYPLu3bMNpVimUMWfFqmr5GbTrKPyOfVg@mail.gmail.com>
References: <CADYN=9KNL=6juu0WuHYPLu3bMNpVimUMWfFqmr5GbTrKPyOfVg@mail.gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754768644.17872.4707695831889551662.stgit@warthog.procyon.org.uk>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mszeredi@redhat.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 34/34] vfs: Add a sample program for the new mount API [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Thu, 20 Dec 2018 16:36:36 +0000
Message-ID: <6151.1545323796@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 20 Dec 2018 16:36:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Anders Roxell <anders.roxell@linaro.org> wrote:

> In file included from /usr/include/x86_64-linux-gnu/sys/stat.h:446,
>                  from ../samples/vfs/test-statx.c:28:
> /usr/include/x86_64-linux-gnu/bits/statx.h:25:8: error: redefinition
> of ‘struct statx_timestamp’

Yeah - the problem is that statx has now made it into glibc, but the sample
program doesn't deal with it turning up in the system headers.  I've passed a
patch to Al already.

David
