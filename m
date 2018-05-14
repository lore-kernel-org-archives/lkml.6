Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281111-2-8480429703213401592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281111; b=GeTWiYJu8c9x0QPvEzL/GdzzuLYhDPaIAB9VQeAUrglGEFLwSa
    +8exEF+K62xbLT3BVfPAW7sKpg2tWeFb4Rt1TD/pdgPoDg+xAsHONPnodoTlt1ws
    vRlMCQ51mGMeu4J4RWtPu442J8KQDos0KBtWi6D4H8Se406xBnA4qvaw4gYbggHf
    HRdemzXT+2VrVYXdveqgwogveWxry5B2SBSlcwbKlsIIEhNaMk6xfd2Hy7iC8eU7
    i7zvJcr3meG1T+6Vaiu6iWZBMEfAySquKnKgYRC1xNlFTa/Q/rR7zOuVnqJgI6Zu
    GnTlN+mycqbXGTS9/FVCF13H6XlJnUC8SZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281111; bh=ptU+cK1KIIV7cus5nkXKRxLOlTL8QN
    tcG6GYwKIZd28=; b=NkGbzkwRfhbUwSq5/KvupwqkCj+EYWBNyBtc1twFPZFVm2
    moStwwl7hXN9DxgbM7zoOdr9FrWMeTPCToUxabFqXM3qRIcrk5Sezbk0zx7itpNQ
    hP5tKe8jsAeNnZBUyyaaj+rTU4Z+3OliEaJ0o7mMljRztrGAbsakT1zE46lf8poj
    tMLetjiP6Ccgb9EbM0ggCglNB/J2hLbZrIzAzX2yBnV47XlBvZghB+Wp8DOFsURd
    xGSvN81oOSIYn1+wtFF6U6W3YxInSyNAhr2vZycrz8eBL3D4/wRbcAiVbrFTs4Jr
    0ivuA6s9R2I6C8mifFDBy425P630/rmFRHgKFsUA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=DlnY+X7w x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=DlnY+X7w x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPk4W/kLT/6PMsyLEZrlt5ltbzxnNg2IR3PsWvGIf3HpA4av/IbjHRIWVuGyLxy+5JoNMSFolaatESl13PhcBNtemdZ26B7sjX3HJosfuxVLi/b0N8Tb
    SfGjtFOJ2SnuiqBCl2ZwYne+ftJfkQRSNHwVy8W4ny9L/ki4qizZfVKt7qg2FbIky0nrqE/e8Omh8EOVpiFdVzhxjMIDm1T+3ePB0izrderf06k9RJD/7eKL
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=-VdXvefH80P9s4iJRHEA:9
    a=QEXdDO2ut3YA:10 a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeENG61 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753843AbeENG6Z (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:58:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 02/72] netfilter: ebtables: dont attempt to allocate 0-sized compat array
Date: Mon, 14 May 2018 08:48:19 +0200
Message-Id: <20180514064823.134961370@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit 3f1e53abff84cf40b1adb3455d480dd295bf42e8 upstream.

Dmitry reports 32bit ebtables on 64bit kernel got broken by
a recent change that returns -EINVAL when ruleset has no entries.

ebtables however only counts user-defined chains, so for the
initial table nentries will be 0.

Don't try to allocate the compat array in this case, as no user
defined rules exist no rule will need 64bit translation.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: 7d7d7e02111e9 ("netfilter: compat: reject huge allocation requests")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1821,13 +1821,14 @@ static int compat_table_info(const struc
 {
 	unsigned int size = info->entries_size;
 	const void *entries = info->entries;
-	int ret;
 
 	newinfo->entries_size = size;
-
-	ret = xt_compat_init_offsets(NFPROTO_BRIDGE, info->nentries);
-	if (ret)
-		return ret;
+	if (info->nentries) {
+		int ret = xt_compat_init_offsets(NFPROTO_BRIDGE,
+						 info->nentries);
+		if (ret)
+			return ret;
+	}
 
 	return EBT_ENTRY_ITERATE(entries, size, compat_calc_entry, info,
 							entries, newinfo);
