Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839970-2-2899372467958211432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839970; b=Y+E6TqFSut0T2mTCHakPT9fq1JUENENM7k2VB2O/GwLPW2sjuM
    irXUcYZrJ/uexp0hfqxoeArcecYfxMZLW5M4ssEkD4jHzlj6zhuukMUc/Tb8aNT8
    Ioc9pXIUjVZ+u2KOgaGvn7icXORR+3HZgimKOvn2EPBAcPm7dNXNkkmOKVUEZTJr
    ++85+3cL31Ux3svulvrlMvCtSxkiEiF7bpPB150cwSFVZMI9nEocUbW/00JPOxLH
    g0Z+wYNkSox7T0YQFj7i+xuUQ6fMnpCpdShOpDqGXBz+Dl3T7C/5W89mNSv97MHp
    hz07HLV8+D9nfj/YTkFSXGt3b167iA04D+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839970; bh=vioIWAzm5tRF+B4KNS/NGVs78XuX1n
    6qe0Z52nRLcP4=; b=CEi98s83By9rsb9QFgv7aY2dsyQidI3tUCAO1DYiDU4Gzo
    qLWn/OrbtnEWuUJWUglOgRyjtZ60FWIXdUEDhKaYSPwFgFRM9R5n2HMUDgmlxPtZ
    ujT4/j4hjTws4W75Muz+ng9rrBAeAoAC+MPtEisWiQ2jDmEM0wr0OzYpLzhu4DF1
    GIOJST6apBk3xCLVf8RtFlDOAACrApiYriEytCuoZs5ecnZZZ6wSXdV37S/S9dDc
    MSxsgATxyA36splcUDhvcvQSJ3/KyEqUX1U67fVnbz6FouOMpUsJ4KlMwR/goIh+
    yoT8ULjd4IqsbWKz+pF9TEEgB8ZJi1VK+s03BdEw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfIlwyYhg4Ujk9qeN1ohLe2BJKI4mYivjGy+ht0XJzMnvmaO89wDtUOx9nkrZkUgUWdb8Y69tZnbNB6oucIY3ny46PHlKJuIP76lZpw42ACrRhRPsHdDW
    m4VfHXUPxht26dVoUy6VlYnAo3PexsKg2is1WK87RyRIpfn0HigXyzGyNGxOeCiSY2tu70Mwfu58TYSVogk1tzEyIuNnfDccwwAPS3IfXv+XJQ9V9IOjuZCT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=A7XncKjpAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=HgRWMwyma_7RdmeyeYYA:9 a=qKJGtR8alvylRcXI:21 a=FI88rCbzh_qPL0bP:21
    a=QEXdDO2ut3YA:10 a=R9rPLQDAdC6-Ub70kJmZ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934663AbeD0OjD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934337AbeD0OJF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A701E21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>,
        Yotam Gigi <yotam.gi@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 34/80] net: sched: ife: handle malformed tlv length
Date: Fri, 27 Apr 2018 15:58:27 +0200
Message-Id: <20180427135734.704177687@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Alexander Aring <aring@mojatatu.com>


[ Upstream commit cc74eddd0ff325d57373cea99f642b787d7f76f5 ]

There is currently no handling to check on a invalid tlv length. This
patch adds such handling to avoid killing the kernel with a malformed
ife packet.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ife.h   |    3 ++-
 net/ife/ife.c       |   35 +++++++++++++++++++++++++++++++++--
 net/sched/act_ife.c |    7 ++++++-
 3 files changed, 41 insertions(+), 4 deletions(-)

--- a/include/net/ife.h
+++ b/include/net/ife.h
@@ -12,7 +12,8 @@
 void *ife_encode(struct sk_buff *skb, u16 metalen);
 void *ife_decode(struct sk_buff *skb, u16 *metalen);
 
-void *ife_tlv_meta_decode(void *skbdata, u16 *attrtype, u16 *dlen, u16 *totlen);
+void *ife_tlv_meta_decode(void *skbdata, const void *ifehdr_end, u16 *attrtype,
+			  u16 *dlen, u16 *totlen);
 int ife_tlv_meta_encode(void *skbdata, u16 attrtype, u16 dlen,
 			const void *dval);
 
--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -92,12 +92,43 @@ struct meta_tlvhdr {
 	__be16 len;
 };
 
+static bool __ife_tlv_meta_valid(const unsigned char *skbdata,
+				 const unsigned char *ifehdr_end)
+{
+	const struct meta_tlvhdr *tlv;
+	u16 tlvlen;
+
+	if (unlikely(skbdata + sizeof(*tlv) > ifehdr_end))
+		return false;
+
+	tlv = (const struct meta_tlvhdr *)skbdata;
+	tlvlen = ntohs(tlv->len);
+
+	/* tlv length field is inc header, check on minimum */
+	if (tlvlen < NLA_HDRLEN)
+		return false;
+
+	/* overflow by NLA_ALIGN check */
+	if (NLA_ALIGN(tlvlen) < tlvlen)
+		return false;
+
+	if (unlikely(skbdata + NLA_ALIGN(tlvlen) > ifehdr_end))
+		return false;
+
+	return true;
+}
+
 /* Caller takes care of presenting data in network order
  */
-void *ife_tlv_meta_decode(void *skbdata, u16 *attrtype, u16 *dlen, u16 *totlen)
+void *ife_tlv_meta_decode(void *skbdata, const void *ifehdr_end, u16 *attrtype,
+			  u16 *dlen, u16 *totlen)
 {
-	struct meta_tlvhdr *tlv = (struct meta_tlvhdr *) skbdata;
+	struct meta_tlvhdr *tlv;
+
+	if (!__ife_tlv_meta_valid(skbdata, ifehdr_end))
+		return NULL;
 
+	tlv = (struct meta_tlvhdr *)skbdata;
 	*dlen = ntohs(tlv->len) - NLA_HDRLEN;
 	*attrtype = ntohs(tlv->type);
 
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -639,7 +639,12 @@ static int tcf_ife_decode(struct sk_buff
 		u16 mtype;
 		u16 dlen;
 
-		curr_data = ife_tlv_meta_decode(tlv_data, &mtype, &dlen, NULL);
+		curr_data = ife_tlv_meta_decode(tlv_data, ifehdr_end, &mtype,
+						&dlen, NULL);
+		if (!curr_data) {
+			qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
+			return TC_ACT_SHOT;
+		}
 
 		if (find_decode_metaid(skb, ife, mtype, dlen, curr_data)) {
 			/* abuse overlimits to count when we receive metadata
