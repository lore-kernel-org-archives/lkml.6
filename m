Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C9ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3FE2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3FE2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJSXmC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:42:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJSXmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0727300DA38;
        Fri, 19 Oct 2018 15:35:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 380FB6AE94;
        Fri, 19 Oct 2018 15:35:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20181019122049.27121-2-mszeredi@redhat.com>
References: <20181019122049.27121-2-mszeredi@redhat.com> <20181019122049.27121-1-mszeredi@redhat.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Florian Weimer <fw@deneb.enyo.de>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 2/5] uapi: deprecate STATX_ALL
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16381.1539963322.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Fri, 19 Oct 2018 16:35:22 +0100
Message-ID: <16382.1539963322@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 19 Oct 2018 15:35:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> wrote:

> +/*
> + * This is deprecated, and shall remain the same value in the future.  To avoid
> + * confusion please use the equivalent (STATX_BASIC_STATS | STATX_BTIME)
> + * instead.
> + */
> +#define STATX_ALL		0x00000fffU

The comment is misleading.  STATX_ALL is *not* equivalent to
STATX_BASIC_STATS | STATX_BTIME, even though it might be numerically the
same.  You would need to update the comment when you add STATX_ATTRIBUTES
to mention that also.

Apart from that, I'm okay with this.

Further, please provide a manpage update also.

David
