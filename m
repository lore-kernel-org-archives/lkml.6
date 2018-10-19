Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C789ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A91B21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A91B21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJSXv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:51:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbeJSXv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:51:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E4A23091742;
        Fri, 19 Oct 2018 15:44:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B36F194BC;
        Fri, 19 Oct 2018 15:44:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181019122049.27121-5-mszeredi@redhat.com>
References: <20181019122049.27121-5-mszeredi@redhat.com> <20181019122049.27121-1-mszeredi@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>
Subject: Re: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17056.1539963884.1@warthog.procyon.org.uk>
Date:   Fri, 19 Oct 2018 16:44:44 +0100
Message-ID: <17057.1539963884@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 19 Oct 2018 15:44:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> wrote:

> As per statx(2) man page only clear out flags that are unsupported by the
> fs or have an unrepresentable value.  Atime is supported by NFS as long as
> it's supported on the server.
> 
> So the STATX_ATIME flag should not be cleared in the result_mask if the
> operation was requested on a MNT_NOATIME or MNT_NODIRATIME mount.
> 
> This patch doesn't change the revalidation algorithm in any way, just the
> clearing of flags in stat->result_mask.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Fixes: 9ccee940bd5b ("Support statx() mask and query flags parameters")
> Cc: Trond Myklebust <trond.myklebust@primarydata.com>

Reviewed-by: David Howells <dhowells@redhat.com>
