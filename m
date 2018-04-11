Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2791443-1523464115-2-3808896364638072525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523464115; b=sYRC6sB+3VelZxR9Vjrb0jolzNUgyRuFEK0bQgL+69nEI4Si3k
    A8iPoNOgVJQfu1MXimXtCA/nNhhKusCE6TtaK6zztQr//NczylptiGkEp28Fds98
    +8gFpXqyh96++f+gWR/OEnjvKLpIjkKUnIghvqLsNfqAPw7aEFZFSmR1TfQSFsnn
    VDXIoAcffY8ERhKQkPctZDTZrVEQwZTikdlqIXm/bCIY4Mxmy6XywYMf2pmsSLoz
    IU+w/xtI9lXuF0frK74f0R7RJfkX12Qc2qxrUZq9jsHe5joB9k0+5tS+7XvekfHE
    1f0PNgJCYy4iUrPR3CrD5X93P2Cio0QWeOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523464115;
    bh=flaiMCJ9rmDTm1uZng3ThTwwH+LWlos+ykRaEdU8I30=; b=YmQhSfwl3eVk
    kV9ZgBk2zbhzNauVKQo3ZGQUgR+gkmdw9YlKVNbzw6u2Tp3dtft5LmvMBc7FD47y
    sn1oPAsyHZcsM+lwh/M3lC2aA/clNA9FIbB1mRs8R48MA1i1XIVFVJFPoYLxxx6P
    CzIx7D0YzrIcuuua/X6hD+WgVPOhYG5EksEDq8xKTPFt4tI/NkvCGsBfCT7iUCPc
    SuoCo+46tMC9QFukRhQWXsB6wAkiWvuMN2sUqfp7+59Vq9Pw+3cHFwJX1XjFzbCA
    mX2epXmXfNSVSnHNd5InQDnV7IMD+pldHd6967CYg7sPMDxkxEXXjRWbC46Lja1D
    wpH7pDOYAA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPgcHX7HPUWUlTJoADc9g1/B7gqCc8M+oOq621yQz5ZfJMw/zlRNeGnEMEd0LmIY5PJFVjoLtmMPxxs361tUcgfFmp8o6Wsgi3rbtUjdA9Z6IZ7/dk+j
    SajrK0Ei1yWDd7NQBkCxdQvD9bHsTDmJ7lSPPcYcXA6Z9H9Qc4tTtEkFmvYw7Y804M+JqdjrLm+v1mSzQhTnTbVLXKrlucIDHM4pciSgGL1JB2Vt+0DTYUQ4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
    a=u2UjoQUut8GRazC8gaUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbeDKQ0f (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 12:26:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754248AbeDKQ0b (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Apr 2018 12:26:31 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/24] Lock down TIOCSSERIAL
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 17:26:29 +0100
Message-ID: <152346398983.4030.3726814688073404489.stgit@warthog.procyon.org.uk>
In-Reply-To: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Lock down TIOCSSERIAL as that can be used to change the ioport and irq
settings on a serial port.  This only appears to be an issue for the serial
drivers that use the core serial code.  All other drivers seem to either
ignore attempts to change port/irq or give an error.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jiri Slaby <jslaby@suse.com>
---

 drivers/tty/serial/serial_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0466f9f08a91..360f8e4416c4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -829,6 +829,12 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if ((change_port || change_irq) &&
+	    kernel_is_locked_down("Using TIOCSSERIAL to change device addresses, irqs and dma channels")) {
+		retval = -EPERM;
+		goto exit;
+	}
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||

