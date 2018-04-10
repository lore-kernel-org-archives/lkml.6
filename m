Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399089-2-8077892965458596943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523399088; b=gjDy/Z1mJ3mRmbOg+BI4zfs9OtrL5+/t/klvrEPdwxA/o/o+a8
    JdjYbovs016WAVWgWj2PANAQqyJak67Hop7aZi6JfQz3iCLB30Gki7rWKnEizTDd
    2ZnD4EdnBwQ8537qiQMErcFYTer8LdDmvgO8h32rvet3/+7IzPMr1qfPhnRuxJGS
    9PQc/g02KpsR0/SnBP9bz39ciT5e57WXxqGy/d2J1vYtnZuOmG/XFZaUS90kqw9N
    Dkw8Rx03b26yYkIqOtPXKc7dJ4F2ZNoQIzA612L0jmKp/fVTsGsZ/W9X/wf+eIvz
    25JwtboQCeyoA56QXun2nB3N506hOPIlVVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399088; bh=/B/JmvOwK9KCgZB2TFa2hc/NIf2Frb
    I9eEeai27P7+8=; b=riix4yUMdXl4uGd6Bkfgkva2Ax4FwjQmDdXg3HWng3xI8N
    YHgVhkDhHzPj7x0WY80lm/41aUHqZK18QIIBUVFs2ekcPedow86F4sh2i3ew5fNa
    FuraNnzDFeyfb71OIqdnSQ/agGfJG7u1ymFFlQUF45PAQpZC12melU3EjZBJ3Ao8
    9BQ8+3e9n2DwgqHrgUSCu97D2bDwCDgVdlamk2h+vMP7pgt7M78g3PTa/ugt3sC0
    bwTfpkn83GiJEzmGMXvSz5k/TdgVWrFa5l5v7JEyC60OJTriFPZzRzqXMSSZjgyI
    nvuq3R+kwIr2HIq1DIb0oSmIq+YNMMv+OL/64xsg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFUFT3yHdByBm03ERDrkvJCfxk25wduBmTXrcJLdf5mdIiNFBVD9wYbjioxHsy8fHrm/mJW3SEHHFHS0MgVs+OJDB16rnpfNsxudO+YGWkvaNPSxDLOS
    Ig+z7QgbT7Xl6Xo73RSa+pCE8pKN1GYFmiByY/cF+Oo+pfHXHuu7NVLiCt4kxWZtsDIQDZzJg7aL/Csql8Ji5PN5nm0yHtAoVhUjqsz60ux/5g9hlr1aED6e
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=0GEPkuIj_VExvju2vWAA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeDJWYq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:24:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36854 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeDJWYo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:24:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 11/18] net: fool proof dev_valid_name()
Date: Wed, 11 Apr 2018 00:23:46 +0200
Message-Id: <20180410212759.181800552@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit a9d48205d0aedda021fc3728972a9e9934c2b9de ]

We want to use dev_valid_name() to validate tunnel names,
so better use strnlen(name, IFNAMSIZ) than strlen(name) to make
sure to not upset KASAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1027,7 +1027,7 @@ bool dev_valid_name(const char *name)
 {
 	if (*name == '\0')
 		return false;
-	if (strlen(name) >= IFNAMSIZ)
+	if (strnlen(name, IFNAMSIZ) == IFNAMSIZ)
 		return false;
 	if (!strcmp(name, ".") || !strcmp(name, ".."))
 		return false;
