Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653875-2-17148094790811902761
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
    1524653874; b=YnVHmlEAPud7K40CKcBAEigWqDdXfXcy61r41s1qLYMjATiqMM
    QgffpDxgL1RzfRQNy3tmyQl0fkFPFVP7EcefaYrXVMrpQGxqcBhxcexzdvtwx0HM
    5IRTzkaE0n3yCbFFYG83x+uAU8VEm/1VB89MnTzYwIPHxuCNjA2JNU4mZ5mVCfuU
    SLCu2XEGbptCquIRlvLbiandV9XlZMP3NDvXquYC9cDUTiybuYKg0mCzIYyvopWV
    BfX2YBBuxfiPIUB56/CBXr9k+9fgqT2ukJZWuKfwBmjhrxJevmPGALfnzLho6Tpd
    QN3jRxrfsGUxqY9wXr1DOCnJV4ecMoGw43qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653874; bh=tyTqlYbChRG51IK8KnlabYLefUNASl
    XdJq8mbeK8Yrg=; b=VWFakUZXR9Mlsrj1DCkSPGPk0RuRERvCoE3rE6lgkXSM+s
    wPiEkAKQ+cbo9mOASzevR5LRCoZ7kQvnyu2zHeqA/SuM+FDW35zmZZ76lR07Q3xF
    W3H/y/BuWgD+26RzuZuorMGfqoBZcLJdHtf9f8yJP/sZejl48/2OhFYnxvwqKseH
    mLSfwrtEKlOB/MEYwVS9D3jST3nZjZpcDA+7aEt5sIX+enDT7Ft7E2KVDA7R7zlM
    whnDYnaVzs/9QYF6FWo3GGKwRu6z6cBNJmkID7653jbfXAnZ5ZmmGkTYW+FlTBYy
    3dyBO3ZRTQdoUwObB0KaA/zdz/UuxZYcZuwsD4bQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfMygbWcrzCVXX0kLzjegcmS9+76fskZfSuEPZTTPwEdRE1sMldElLX2jIysWjSoSrtrvwOMTLJRI6eec8zhS0DDRCV8AEVkkXbPrWQr9B3lyy+8TbnWx
    umbD0fbtN/JCAuAn1CABw3Y09pAVzi32SYMd97leI6etGzbAMNe49LJuGfMYCNyt3tAGToFVCY+4LEnk93gdEP7clymmGttQE3ActTaPe2y4JiOx4sD125k3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tHz9FfFoAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=43XURk6w0g5GeypUxR4A:9 a=QEXdDO2ut3YA:10
    a=Z52K5TbU17EcDgFyT5Ki:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeDYK5e (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:57:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754170AbeDYKnD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Lagerwall <ross.lagerwall@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 140/183] xen/grant-table: Use put_page instead of free_page
Date: Wed, 25 Apr 2018 12:36:00 +0200
Message-Id: <20180425103248.173790853@linuxfoundation.org>
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

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit 3ac7292a25db1c607a50752055a18aba32ac2176 ]

The page given to gnttab_end_foreign_access() to free could be a
compound page so use put_page() instead of free_page() since it can
handle both compound and single pages correctly.

This bug was discovered when migrating a Xen VM with several VIFs and
CONFIG_DEBUG_VM enabled. It hits a BUG usually after fewer than 10
iterations. All netfront devices disconnect from the backend during a
suspend/resume and this will call gnttab_end_foreign_access() if a
netfront queue has an outstanding skb. The mismatch between calling
get_page() and free_page() on a compound page causes a reference
counting error which is detected when DEBUG_VM is enabled.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/grant-table.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -328,7 +328,7 @@ static void gnttab_handle_deferred(unsig
 			if (entry->page) {
 				pr_debug("freeing g.e. %#x (pfn %#lx)\n",
 					 entry->ref, page_to_pfn(entry->page));
-				__free_page(entry->page);
+				put_page(entry->page);
 			} else
 				pr_info("freeing g.e. %#x\n", entry->ref);
 			kfree(entry);
@@ -384,7 +384,7 @@ void gnttab_end_foreign_access(grant_ref
 	if (gnttab_end_foreign_access_ref(ref, readonly)) {
 		put_free_entry(ref);
 		if (page != 0)
-			free_page(page);
+			put_page(virt_to_page(page));
 	} else
 		gnttab_add_deferred(ref, readonly,
 				    page ? virt_to_page(page) : NULL);
