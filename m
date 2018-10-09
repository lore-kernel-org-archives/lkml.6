Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEA120644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEA120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeJIW6s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIW6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5A22308FC51;
        Tue,  9 Oct 2018 15:41:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56A157E10A;
        Tue,  9 Oct 2018 15:41:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <nycvar.YFH.7.76.1810021622320.11696@n3.vanv.qr>
References: <nycvar.YFH.7.76.1810021622320.11696@n3.vanv.qr> <153616290368.23468.7806230605345568524.stgit@warthog.procyon.org.uk>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] UAPI: bcache: Fix use of embedded flexible array
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Tue, 09 Oct 2018 16:41:06 +0100
Message-ID: <17992.1539099666@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 09 Oct 2018 15:41:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@inai.de> wrote:

> """it [the array size expression] shall be a converted constant expression of
> type std::size_t and its value shall be greater than zero."""
> —http://eel.is/c++draft/dcl.array

Interesting.  You're not actually quoting the full sentence:

	If the constant-expression is present, it shall be a converted
	constant expression of type std​::​size_­t and its value shall be
	greater than zero.

This suggests that:

	__u64 ptr[]

is actually valid since:

	D1 [ constant-expressionopt ] attribute-specifier-seqopt

suggests that the part between the brackets is optional.

David
