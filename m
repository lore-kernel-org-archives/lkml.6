Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805155-2-12737253501965574755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805155; b=bHloONql+k4z0WEWIjvVvEIaZiz1nUtxd+DUPGYbk9QD23u
    uPwVXHJC92DYcnHjTIgsVGeOXrcaitBsYw7/eBSdse6TU8AbdJkmFO52Hf5Lo3Qf
    N7ypn3mbpj1/unqbGrMYwiWdLJqBGc+ghwNn2peqj3NyIKCXFFtlimM3iCMyPb9C
    EY4kRqrrsryI0CWjl0OfQt2sZSnDC3taLeRZ3O3Hf/WLrjaBeuEAasTtneZcFtL2
    0cxf2S/hKh3JX0Z+4L6dqdC6/VtDEGvLs/OuVqrE7ZpPDz+l80FkfpUt0tpSIDCG
    WT8eqrToN6Wd11PFUTkGATH6wGPswZtqBAukc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805155; bh=rEaBll3wrqgfWDtAUplfjxczH0
    ikYQjUdTf55zmBNZY=; b=ekqT3g/iHpuT8jLbPB1+M5JLlYce9pmEyZpo+k9IgD
    UnxJ1DhvYlbRfvzC/pB/o9eDb9lZaTdCtZJZkdyPFwbecnPDSLKvmKQXbewOxBRK
    vTfYmId4t3mAljp9tHOff7qUIGfvnSD1W3UOjCwFqWBMX0HaVyqypOSY/9/o4ZAC
    v7ULEuoNSfNTX6ncXNnpKVrGEKTykqggE8HfRCv/YW8BZkE2pBg6MMD6c5vzo8NT
    8cqDIYcGfVfqbBN0tW2q9QUwFbCu9jhN+kLzKbKzYGHFG75HNtWxJnVLJO43IL5B
    1HZC4PgZ/hjGCNl8aF4x1Aua/FWLiT3q5YgXMtGLU4Gg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbeCWKEe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbeCWKEb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 009/177] bonding: handle link transition from FAIL to UP correctly
Date: Fri, 23 Mar 2018 10:52:17 +0100
Message-Id: <20180323094205.626457350@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Bandewar <maheshb@google.com>


[ Upstream commit fb9eb899a6dc663e4a2deed9af2ac28f507d0ffb ]

When link transitions from LINK_FAIL to LINK_UP, the commit phase is
not called. This leads to an erroneous state causing slave-link state to
get stuck in "going down" state while its speed and duplex are perfectly
fine. This issue is a side-effect of splitting link-set into propose and
commit phases introduced by de77ecd4ef02 ("bonding: improve link-status
update in mii-monitoring")

This patch fixes these issues by calling commit phase whenever link
state change is proposed.

Fixes: de77ecd4ef02 ("bonding: improve link-status update in mii-monitoring")
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2067,6 +2067,7 @@ static int bond_miimon_inspect(struct bo
 					    (bond->params.downdelay - slave->delay) *
 					    bond->params.miimon,
 					    slave->dev->name);
+				commit++;
 				continue;
 			}
 
@@ -2104,7 +2105,7 @@ static int bond_miimon_inspect(struct bo
 					    (bond->params.updelay - slave->delay) *
 					    bond->params.miimon,
 					    slave->dev->name);
-
+				commit++;
 				continue;
 			}
 
