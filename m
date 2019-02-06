Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C26C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE40D218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfBFW05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:26:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfBFW05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE53C89AF2;
        Wed,  6 Feb 2019 22:26:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9138B45A8;
        Wed,  6 Feb 2019 22:26:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
References: <754d6ccb4012fc11c7b9369e66ba7f3e816fdb57.1548400400.git.geliangtang@gmail.com>
To:     Geliang Tang <geliangtang@gmail.com>
Cc:     dhowells@redhat.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: keys: add NULL checking for key->type->instantiate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31394.1549492013.1@warthog.procyon.org.uk>
Date:   Wed, 06 Feb 2019 22:26:53 +0000
Message-ID: <31395.1549492013@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 06 Feb 2019 22:26:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geliang Tang <geliangtang@gmail.com> wrote:

> key->type->instantiate can be NULL, add NULL checking to prevent
> NULL pointer dereference in __key_instantiate_and_link().

Do you have an oops report or test case for this?

David
