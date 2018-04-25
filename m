Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584447-1524656077-2-7840071297575763492
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
    1524656077; b=kAl1tHxV9mDT45qCyKIhxDTE8V5PtdY4Vu/QGmVk7XvoSjE9zP
    rDTjL+FhVjrmTQx8iVupUg6U7e3V86EpcdCNYNW3MUPLKSsWocbIafThoLa4CgUa
    tpfhvaHHY1j5IX46tTYBZJwkilaB+3RLJgYDAtLLojtEPVel6lXhIsjUe9hEx23U
    AB7nuHNMtayLGVqJIquAtnuDcp37EYKl5/WlcWkMdkvN6wAiA4Bv6c1bRYmAz1Pf
    B/Fevpw80+sQVgbecuW+3EYO7JzsGbXAD8OHZdj8smnn15wH4e2JxBSXkmQmdRoz
    QkB+bVj4t95kb2i6hV4SZB49ZGCmYBMoK4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656077; bh=ul8VM9DVGl35A5MAhGRWZQm4lFfKAY
    fSdqK3qxCIf40=; b=Mkrio8GH7Us2RtiMY8wtYqJKX0YPlt0ULoXIAM3zrYYlZ8
    MU3KB4nFX/Ga0LDDqRtkLaMnn2sHSFZ/XRMklNy+o75R3bF1lJ28GiZ8LKeHx9r4
    RqNzrI2sSKnjbdoMawb9j64zKpoMCUJLZ6LrNuYn7tc+bHOi/xm8SWPCrkftMYH8
    yYXCZylPn3QgmxjeabRel0nWK63PUaUd14fZ/2KMwE7tMRN1Zs6/C0Qs8Kge0pxz
    kRXA4ZpFuHnhOZ69hobaCR6qY2aXeyk9ZE5PRbWucSP2G+TPbZc3e8stdkTCb/2E
    2IsUYbGoX+U47DM8rGkUEaqJ6MvXsdhhxdItG3ig==
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
X-CM-Envelope: MS4wfMCLmn4rPjnbVracwpu7ibwpj+wjuPcHJwZqw72E7HEz0+JxLVGFOC0VFdaDAe0JuLJ+Xpdw/b5mym+L02rmUCm4OlNJ29taTTrmwJFxxIb5pmMKN1O2
    QNWKnGvX52VEhBSMn73PAmvpOcl6eX6CkVZBp6L9fojRXIhjEx6Pa3g8R1Pwv/1CJZcXrd/ncand3evWuCQ8Bw4U0AQnhHs20FfD57TYZSIMSguPnBp811xs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=ASSrVY6R4Z5thguM-UYA:9
    a=wLLODOkoTfmzFx3P:21 a=2F1lxfiQ1TvUpIAn:21 a=QEXdDO2ut3YA:10
    a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeDYLeW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:34:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeDYKe1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 21/26] netfilter: compat: reject huge allocation requests
Date: Wed, 25 Apr 2018 12:33:30 +0200
Message-Id: <20180425103315.691904897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

commit 7d7d7e02111e9a4dc9d0658597f528f815d820fd upstream.

no need to bother even trying to allocating huge compat offset arrays,
such ruleset is rejected later on anyway becaus we refuse to allocate
overly large rule blobs.

However, compat translation happens before blob allocation, so we should
add a check there too.

This is supposed to help with fuzzing by avoiding oom-killer.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -554,14 +554,8 @@ int xt_compat_add_offset(u_int8_t af, un
 {
 	struct xt_af *xp = &xt[af];
 
-	if (!xp->compat_tab) {
-		if (!xp->number)
-			return -EINVAL;
-		xp->compat_tab = vmalloc(sizeof(struct compat_delta) * xp->number);
-		if (!xp->compat_tab)
-			return -ENOMEM;
-		xp->cur = 0;
-	}
+	if (WARN_ON(!xp->compat_tab))
+		return -ENOMEM;
 
 	if (xp->cur >= xp->number)
 		return -EINVAL;
@@ -606,6 +600,22 @@ EXPORT_SYMBOL_GPL(xt_compat_calc_jump);
 
 int xt_compat_init_offsets(u8 af, unsigned int number)
 {
+	size_t mem;
+
+	if (!number || number > (INT_MAX / sizeof(struct compat_delta)))
+		return -EINVAL;
+
+	if (WARN_ON(xt[af].compat_tab))
+		return -EINVAL;
+
+	mem = sizeof(struct compat_delta) * number;
+	if (mem > XT_MAX_TABLE_SIZE)
+		return -ENOMEM;
+
+	xt[af].compat_tab = vmalloc(mem);
+	if (!xt[af].compat_tab)
+		return -ENOMEM;
+
 	xt[af].number = number;
 	xt[af].cur = 0;
 
