Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE9EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16A221532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16A221532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390281AbeIUUqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeIUUqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:46:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D6DF80F88;
        Fri, 21 Sep 2018 14:56:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FE6B17D5A;
        Fri, 21 Sep 2018 14:56:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180920151214.15484-5-mszeredi@redhat.com>
References: <20180920151214.15484-5-mszeredi@redhat.com> <20180920151214.15484-1-mszeredi@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] fsconfig: parse "subtype" param for old internal API
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16465.1537541810.1@warthog.procyon.org.uk>
Date:   Fri, 21 Sep 2018 15:56:50 +0100
Message-ID: <16466.1537541810@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 21 Sep 2018 14:56:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> wrote:

> This subtype thing is specific to "fuse" and "fuseblk" filesystems.  When
> these are switched over to the new context API, the handling of this
> parameter can be moved from legacy_parse_param() into fuse.

I think do_new_mount() should do:

	vfs_parse_fs_string(fc, "subtype", subtype, strlen(subtype));

rather than setting fc->subtype itself.  I've made that change and folded this
patch also.

David
