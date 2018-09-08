Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD155C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59919204EC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59919204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeIHUM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 16:12:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbeIHUM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 16:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 150AF40776DB;
        Sat,  8 Sep 2018 15:26:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02EB5104946D;
        Sat,  8 Sep 2018 15:26:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
References: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org> <153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk> <alpine.LRH.2.21.1809061007140.23269@namei.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     dhowells@redhat.com, James Morris <jmorris@namei.org>,
        Denis Kenzior <denkenz@gmail.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12100.1536420374.1@warthog.procyon.org.uk>
Date:   Sat, 08 Sep 2018 16:26:14 +0100
Message-ID: <12101.1536420374@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 08 Sep 2018 15:26:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 08 Sep 2018 15:26:16 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann <marcel@holtmann.org> wrote:

> so I have reviewed and tested this code. In addition, we have test cases for
> it in ELL (embedded linux library).

I wonder if there's any practical way to add a test for this to the keyutils
test suite.  I'm guessing it's quite tricky, given the extra bits you need to
emulate the TPM.

David
