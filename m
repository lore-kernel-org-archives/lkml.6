Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527155566-2-17927218338939379590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155565; b=MOEv20QaKkMZcnjU6Z4fZok41Y7XyNt8BWNydysMHRRqJSSGE1
    9xGluNxKRflNpSAyCC0T47rz7vNAI6dFERHPkZQbbwIJENu7UC6x+SR1JK56DmdI
    tqin8tZOfweA1YbVVV8bZbQlRSia9FVmlerckGxAd+WE6MHeStsTV64cnmWxlWxH
    xzeed+cFBXB03WMJS8MYttJqM1oRkiTfWqPv2+SS7s2QMklqAVsqHhybcMe5NVNU
    x4FuCdpgFrYGCe80a4y0/VhIydKXo4d4HSaYutiuy/XFmH+cFDnqFiUlhUBfJjpM
    t4ZyVROCd6KKtQ6SM+rKPrpTEii86NXNPaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155565; bh=VkQ6/uEbsEwajpQMLIbwrAzWjlD2SK
    k8EXgVGyZwISY=; b=RLCmsd59TCvD895RSauPar/dsjQ236eU/DgCtDjgu2nCFC
    /WoeGFi7NEr5SUol43mjcEK5XijruT/A1tX99OTR8Fum288rgWfGyyIpC/j2tPen
    zz4IklL26rW0nbzapnxjzW281Sy+LCSgqNKZe0ntsQcywHPmG4+Dv3sxyW9FYUxD
    xlWo8YW2+j0rRKATlLcPrTTLr1/FQIH3mgt1ePMnraFn3ZROB8UmLS+AXS+BEfhc
    pajeLR/e8jn8CH1XYeGLuE/iOeDRAlHzQN+cuhc1VHT2lQBzAJEbyd8C0WnI5Pky
    WiqhAAYRzdou6hKSzaK2l3mwgdbye1P7T1KfscUA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=o5YpE3X3 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=o5YpE3X3 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJXzLSPOuFOzP7o55TKGjjTmYwawE9VLqdUfUFxRY8knPVmAoDHDiVUtLY71jfiSKVWGFi0c7DKdOvhdbOpUkTi7uOOqkvqWm5GHwyv2cqZHZBtCClYQ
    mKxwmzjfmn7RL0SONw+T4zdmJ94glCtG87MY7Aj5xI5ubkrDAxG9TSoEdDXEs0Qw8PqYhVZhKoX3dzWAzDlQSxLA1tXjkQs0ckB0ZeciHWbvkrBaP3mmwhzK
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=lNAUDuUphGAgTuL2Sc8A:9 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967611AbeEXJwk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967908AbeEXJwi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 005/165] net/smc: check for missing nlattrs in SMC_PNETID messages
Date: Thu, 24 May 2018 11:36:51 +0200
Message-Id: <20180524093622.192569496@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit d49baa7e12ee70c0a7b821d088a770c94c02e494 ]

It's possible to crash the kernel in several different ways by sending
messages to the SMC_PNETID generic netlink family that are missing the
expected attributes:

- Missing SMC_PNETID_NAME => null pointer dereference when comparing
  names.
- Missing SMC_PNETID_ETHNAME => null pointer dereference accessing
  smc_pnetentry::ndev.
- Missing SMC_PNETID_IBNAME => null pointer dereference accessing
  smc_pnetentry::smcibdev.
- Missing SMC_PNETID_IBPORT => out of bounds array access to
  smc_ib_device::pattr[-1].

Fix it by validating that all expected attributes are present and that
SMC_PNETID_IBPORT is nonzero.

Reported-by: syzbot+5cd61039dc9b8bfa6e47@syzkaller.appspotmail.com
Fixes: 6812baabf24d ("smc: establish pnet table management")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_pnet.c |   71 +++++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -245,40 +245,45 @@ out:
 static int smc_pnet_fill_entry(struct net *net, struct smc_pnetentry *pnetelem,
 			       struct nlattr *tb[])
 {
-	char *string, *ibname = NULL;
-	int rc = 0;
+	char *string, *ibname;
+	int rc;
 
 	memset(pnetelem, 0, sizeof(*pnetelem));
 	INIT_LIST_HEAD(&pnetelem->list);
-	if (tb[SMC_PNETID_NAME]) {
-		string = (char *)nla_data(tb[SMC_PNETID_NAME]);
-		if (!smc_pnetid_valid(string, pnetelem->pnet_name)) {
-			rc = -EINVAL;
-			goto error;
-		}
-	}
-	if (tb[SMC_PNETID_ETHNAME]) {
-		string = (char *)nla_data(tb[SMC_PNETID_ETHNAME]);
-		pnetelem->ndev = dev_get_by_name(net, string);
-		if (!pnetelem->ndev)
-			return -ENOENT;
-	}
-	if (tb[SMC_PNETID_IBNAME]) {
-		ibname = (char *)nla_data(tb[SMC_PNETID_IBNAME]);
-		ibname = strim(ibname);
-		pnetelem->smcibdev = smc_pnet_find_ib(ibname);
-		if (!pnetelem->smcibdev) {
-			rc = -ENOENT;
-			goto error;
-		}
-	}
-	if (tb[SMC_PNETID_IBPORT]) {
-		pnetelem->ib_port = nla_get_u8(tb[SMC_PNETID_IBPORT]);
-		if (pnetelem->ib_port > SMC_MAX_PORTS) {
-			rc = -EINVAL;
-			goto error;
-		}
-	}
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_NAME])
+		goto error;
+	string = (char *)nla_data(tb[SMC_PNETID_NAME]);
+	if (!smc_pnetid_valid(string, pnetelem->pnet_name))
+		goto error;
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_ETHNAME])
+		goto error;
+	rc = -ENOENT;
+	string = (char *)nla_data(tb[SMC_PNETID_ETHNAME]);
+	pnetelem->ndev = dev_get_by_name(net, string);
+	if (!pnetelem->ndev)
+		goto error;
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_IBNAME])
+		goto error;
+	rc = -ENOENT;
+	ibname = (char *)nla_data(tb[SMC_PNETID_IBNAME]);
+	ibname = strim(ibname);
+	pnetelem->smcibdev = smc_pnet_find_ib(ibname);
+	if (!pnetelem->smcibdev)
+		goto error;
+
+	rc = -EINVAL;
+	if (!tb[SMC_PNETID_IBPORT])
+		goto error;
+	pnetelem->ib_port = nla_get_u8(tb[SMC_PNETID_IBPORT]);
+	if (pnetelem->ib_port < 1 || pnetelem->ib_port > SMC_MAX_PORTS)
+		goto error;
+
 	return 0;
 
 error:
@@ -307,6 +312,8 @@ static int smc_pnet_get(struct sk_buff *
 	void *hdr;
 	int rc;
 
+	if (!info->attrs[SMC_PNETID_NAME])
+		return -EINVAL;
 	pnetelem = smc_pnet_find_pnetid(
 				(char *)nla_data(info->attrs[SMC_PNETID_NAME]));
 	if (!pnetelem)
@@ -359,6 +366,8 @@ static int smc_pnet_add(struct sk_buff *
 
 static int smc_pnet_del(struct sk_buff *skb, struct genl_info *info)
 {
+	if (!info->attrs[SMC_PNETID_NAME])
+		return -EINVAL;
 	return smc_pnet_remove_by_pnetid(
 				(char *)nla_data(info->attrs[SMC_PNETID_NAME]));
 }
