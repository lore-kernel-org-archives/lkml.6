Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599DFC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2AE2156F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2AE2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbeIVFzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:55:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725748AbeIVFzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:55:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FA64C059B7F;
        Sat, 22 Sep 2018 00:03:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7876187E53;
        Sat, 22 Sep 2018 00:03:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org>
References: <20180910150903.249031442dd7fe43e01812cf@linux-foundation.org> <0db6c314-1ef4-9bfa-1baa-7214dd2ee061@infradead.org> <20180909220018.GH13219@asgard.redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dhowells@redhat.com, Eugene Syromiatnikov <esyr@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH resend] uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19866.1537574620.1@warthog.procyon.org.uk>
Date:   Sat, 22 Sep 2018 01:03:40 +0100
Message-ID: <19867.1537574620@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sat, 22 Sep 2018 00:03:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> Are there such programs?  Do they reference the `private' field?

They would use the keyutils.h header from keyutils package probably.  There
the field was named "priv" not "private".  The kernel's UAPI header should be
amended again to match that.

David
