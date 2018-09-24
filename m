Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6589ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF3E20877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF3E20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbeIXSCZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58671 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbeIXSCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:02:24 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5C3430026BF;
        Mon, 24 Sep 2018 12:00:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05DD430918D4;
        Mon, 24 Sep 2018 12:00:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180924094723.487697-1-lkundrak@v3.sk>
References: <20180924094723.487697-1-lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26183.1537790420.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 24 Sep 2018 13:00:20 +0100
Message-ID: <26184.1537790420@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 24 Sep 2018 12:00:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> wrote:

> This changes UAPI, breaking iwd and libell:
> 
>   ell/key.c: In function 'kernel_dh_compute':
>   ell/key.c:205:38: error: 'struct keyctl_dh_params' has no member named 'private'; did you mean 'dh_private'?
>     struct keyctl_dh_params params = { .private = private,
>                                         ^~~~~~~
>                                         dh_private
> 
> This reverts commit 8a2336e549d385bb0b46880435b411df8d8200e8.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: <stable@vger.kernel.org>

Can I stick your Signed-off-by on it?

David
