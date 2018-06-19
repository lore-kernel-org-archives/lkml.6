Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBACC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E897320874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E897320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937451AbeFSIBF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:01:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937437AbeFSIBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:01:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA88887A7C;
        Tue, 19 Jun 2018 08:01:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-111.rdu2.redhat.com [10.10.121.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE8F32026D68;
        Tue, 19 Jun 2018 08:01:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180618174210.b8348d35bce35b2277cab660@linux-foundation.org>
References: <20180618174210.b8348d35bce35b2277cab660@linux-foundation.org> <152891539958.23512.10618044594537218194.stgit@warthog.procyon.org.uk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc: Make inline name size calculation automatic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20013.1529395261.1@warthog.procyon.org.uk>
Date:   Tue, 19 Jun 2018 09:01:01 +0100
Message-ID: <20014.1529395261@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 08:01:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 08:01:02 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:

> Please cc Alexey on /proc patches.

If Alexey is responsible for procfs he should declare this in MAINTAINERS.

> What are the user-visible runtime effects of this change?

Memory usage only.

David
