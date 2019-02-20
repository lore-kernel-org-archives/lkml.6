Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE31C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E38B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfBTOJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:09:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51463 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbfBTOJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:09:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76A3C81250;
        Wed, 20 Feb 2019 14:09:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1A1317B15;
        Wed, 20 Feb 2019 14:09:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6bf441ffc1a54d06ad27ed01c6d06a58@AcuMS.aculab.com>
References: <6bf441ffc1a54d06ad27ed01c6d06a58@AcuMS.aculab.com> <155066953188.21038.12015964986007814182.stgit@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, "jmorris@namei.org" <jmorris@namei.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: user: Align the payload buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16011.1550671795.1@warthog.procyon.org.uk>
Date:   Wed, 20 Feb 2019 14:09:55 +0000
Message-ID: <16012.1550671795@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 20 Feb 2019 14:09:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> I'd make the 'datalen' field 'unsigned int' at the same time.
> It will use some of the hole you've made and generate better
> code on most arches.

Most arches?  I though most, if not all, arches had a load-word instruction.

Do you want to send me a patch for that?  I'd rather not alter this patch at
this point.  I can pass the additional patch to James for the next merge
window.

David
