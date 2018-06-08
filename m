Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id azTBD3OiGlvRcwAAmS7hNA
	; Fri, 08 Jun 2018 15:38:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E3972608C1; Fri,  8 Jun 2018 15:38:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72F08608BA;
	Fri,  8 Jun 2018 15:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72F08608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeFHPiE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:38:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751141AbeFHPiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E23237D843;
        Fri,  8 Jun 2018 15:38:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-245.rdu2.redhat.com [10.10.121.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64C821C730;
        Fri,  8 Jun 2018 15:37:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180607191201.97080-1-ebiggers3@gmail.com>
References: <20180607191201.97080-1-ebiggers3@gmail.com> <0000000000009c221d056e0cf53a@google.com>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: dhowells@redhat.com, James Morris <jmorris@namei.org>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] dh key: fix rounding up KDF output length
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17594.1528472278.1@warthog.procyon.org.uk>
Date: Fri, 08 Jun 2018 16:37:58 +0100
Message-ID: <17595.1528472278@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 15:38:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 15:38:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Commit 383203eff718 ("dh key: get rid of stack allocated array") changed
> kdf_ctr() to assume that the length of key material to derive is a
> multiple of the digest size.  The length was supposed to be rounded up
> accordingly.  However, the round_up() macro was used which only gives
> the correct result on power-of-2 arguments, whereas not all hash
> algorithms have power-of-2 digest sizes.  In some cases this resulted in
> a write past the end of the 'outbuf' buffer.
> 
> Fix it by switching to roundup(), which works for non-power-of-2 inputs.

Applied.
