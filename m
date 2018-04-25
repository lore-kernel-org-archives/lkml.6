Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653300-2-11321637975891447678
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653300; b=BRUHEP9p/MK4wvaDKWGd4E9+T8MBAtt8bFdNW0RmCZvOAMOuNO
    2q8XP6cnxNSb22ZYevvhzjGwUFiAZ+2BB3MrRaXPMTuniDGV7CzkcE/nLFXbuEQi
    pF8lnAJPafwmCagwgrNagZNL9WpS8m4VbgRT2Q70HEvhfk0p4eDbNiQD9OCGKx/d
    FL+QTUNqqza0cGNJxVxtCrbdH4+HrPVyr4/UKK6cbAi9H1NxUPTQFoVOnOQBjlLu
    ZPPOxljuLdQWl4vToh84g8Vs7oaCqxEzSTFJG3GGUeG4aTWy9Ip8WvKjq3GKIppA
    Mgu3M9bptFpwW+pqeUbJd7nnW+LutPgCO5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653300; bh=13SDJ5YJoqXHo0jCWqSfktge4if91Y
    Bn7RjHXDUeueo=; b=MPCbEG6uvHBMdMo0eHvmC2edP7HYf58uP6uf1Y6lEKJjYX
    K+P/7ooe8FoyUxtBG9T4RKhbdQwE3MZmFAIt+eM/HGjAJNY9Ei8QKGjnTNiKoICa
    9ly7u4deNjbpeedpj5xxSVim7dBF6uNih6SZxUUFqmTS/kgt+N+WEKte5wbxUCED
    QbAqGnRSeha2JXiiYGvzc1Yw4AKZVDhJvh5IC2lO1fMF1oIFIp2GXYANzaDTgZKz
    Y8IrkovKcUlqpzlgZwOWGyBIIFCEEgUuonlFkjWgBn5DyzajXyyCbyP+i5sXizf5
    ltppNstIftefSo7vhABl649sIXEN5n1psdjkFDsA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfNbX8F/GeEstHu2zqu3BK5nEEmrpM7iFr0KjZ05fpNmFZutVIfl9Mkx17BHcILzgw57xIOtZX7TPE887/IlBWSChDjIwCL+xg8ytDhYiWho4fWscQ9Nv
    Y+Pe5kM/hRJ/OZ1LLRjEYM5TL/bLX0fCpLZ9rlxVFiqtaproCGL3DL0krOxWbfqbZekt6JUIG0CGxMaXSU6gGroLtmp/qGsMM83N0LgvAsVE3U4zfNdj4UOO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=H94YMeAY_uT0aJD_LjIA:9 a=QEXdDO2ut3YA:10
    a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeDYKsS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:48:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53402 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754439AbeDYKos (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:44:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 178/183] netfilter: x_tables: limit allocation requests for blob rule heads
Date: Wed, 25 Apr 2018 12:36:38 +0200
Message-Id: <20180425103249.656900927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 9d5c12a7c08f67999772065afd50fb222072114e upstream.

This is a very conservative limit (134217728 rules), but good
enough to not trigger frequent oom from syzkaller.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -819,6 +819,9 @@ EXPORT_SYMBOL(xt_check_entry_offsets);
  */
 unsigned int *xt_alloc_entry_offsets(unsigned int size)
 {
+	if (size > XT_MAX_TABLE_SIZE / sizeof(unsigned int))
+		return NULL;
+
 	return kvmalloc_array(size, sizeof(unsigned int), GFP_KERNEL | __GFP_ZERO);
 
 }
