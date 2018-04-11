Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473488-2-3805530180596415056
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
    1523473488; b=KvSwXVabSgP7GMbZgiQJbwi5m5COtuJYBzqTvetSkqRn41eTQf
    LjEU9IF1JTu4bPQxGbYn3d5AEqsvwUE/5ere7u8Mdl9iOvpIRPm0FPOJBnUeoAOW
    JaNJmqX3jIm4CZZ07G+5hMgN2VAcBBXwuFNCWusBZbkF3qndqbEjdP8tRWXxvN+E
    AG5hyftEjxhRZYNRlqg1egH40uptc+mh4DOFHsAwblCL/1OBrfJROUDxe5/eTeph
    U9zJVXVSX4OgGCvYthALCoeIT9AFvTP7F7hGJOiJfGObqv5xA7zdjsm2RZ9e6I+1
    HB58VWtAmMzHAMYJ2KU2+6k3AaraH0HfY8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473488; bh=N8lLnUqFr+GAYKw10PvGc8ZHtaEBcp
    FLFOyfZnEeUrY=; b=XM442o1ZcCDPmLXeCEVQCJIfoU8oAUbAPTxza1W5XfnKdv
    fqdgKV6of+PJB04MXfGgNNoLwfbsprp0epOs5ayutSqROhgkA0hin4FWeeCbJAyZ
    +pQlxo5US0ho97hCe4Fd7MiViSFOVZi+2vxCzZI2t+SPaNaA3kWRFbfE93/f5Vu7
    Nh3VUsIWHFXkunfXf6BQClbmivUvYeBWgdrHmEKU0r6q01cXDGPF8ivrBbQ7P+iI
    4X1+Je/Q+ZRie8rcc067T1eNeixfS6pZ69h217bzvFIqO2Wdc586HO9N6gf9cCzU
    m+EU4GxM9Q05J2D3rHExBQyxkiDwBBvM0TiNUU4Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAakaoWU9YOXwIEN28xkTyEAuq1xBxIGqo7P1nzIEP+dNjJSDkBj2BgreG+a0K8YgsrMlJs0kugRAvVvSiXVOcsxL/wUbg9rmFhtRiNEaB/Xkv8xNjoM
    6Ndc+bzAPm9y5Xgh8a0n4cqKFOV/LJC/cIBuKZ4SKNrQWOz+RtJyPWQdpHnhlCSG46bxiNGJzsvApLSssej400FX1fHuQpW71if2xIsabKES5fBX0aKHB0Em
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AGRr4plBAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=2LBmB76TW1u_f6CjTDoA:9 a=QEXdDO2ut3YA:10 a=bOnWt3ThIoLzEnqt84vq:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934153AbeDKTEo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:04:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934145AbeDKTEn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:04:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arjun Vynipadath <arjun@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 265/310] cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages
Date: Wed, 11 Apr 2018 20:36:44 +0200
Message-Id: <20180411183634.065795838@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Arjun Vynipadath <arjun@chelsio.com>


[ Upstream commit ea0a42109aee7b92e631c4eb3f2219fadf58acdd ]

We'd come in with SGE_FL_BUFFER_SIZE[0] and [1] both equal to 64KB and
the extant logic would flag that as an error. This was already fixed in
cxgb4 driver with "92ddcc7 cxgb4: Fix some small bugs in
t4_sge_init_soft() when our Page Size is 64KB".

Original Work by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/sge.c
@@ -2616,8 +2616,8 @@ void t4vf_sge_stop(struct adapter *adapt
 int t4vf_sge_init(struct adapter *adapter)
 {
 	struct sge_params *sge_params = &adapter->params.sge;
-	u32 fl0 = sge_params->sge_fl_buffer_size[0];
-	u32 fl1 = sge_params->sge_fl_buffer_size[1];
+	u32 fl_small_pg = sge_params->sge_fl_buffer_size[0];
+	u32 fl_large_pg = sge_params->sge_fl_buffer_size[1];
 	struct sge *s = &adapter->sge;
 
 	/*
@@ -2625,9 +2625,20 @@ int t4vf_sge_init(struct adapter *adapte
 	 * the Physical Function Driver.  Ideally we should be able to deal
 	 * with _any_ configuration.  Practice is different ...
 	 */
-	if (fl0 != PAGE_SIZE || (fl1 != 0 && fl1 <= fl0)) {
+
+	/* We only bother using the Large Page logic if the Large Page Buffer
+	 * is larger than our Page Size Buffer.
+	 */
+	if (fl_large_pg <= fl_small_pg)
+		fl_large_pg = 0;
+
+	/* The Page Size Buffer must be exactly equal to our Page Size and the
+	 * Large Page Size Buffer should be 0 (per above) or a power of 2.
+	 */
+	if (fl_small_pg != PAGE_SIZE ||
+	    (fl_large_pg & (fl_large_pg - 1)) != 0) {
 		dev_err(adapter->pdev_dev, "bad SGE FL buffer sizes [%d, %d]\n",
-			fl0, fl1);
+			fl_small_pg, fl_large_pg);
 		return -EINVAL;
 	}
 	if ((sge_params->sge_control & RXPKTCPLMODE_F) !=
@@ -2639,8 +2650,8 @@ int t4vf_sge_init(struct adapter *adapte
 	/*
 	 * Now translate the adapter parameters into our internal forms.
 	 */
-	if (fl1)
-		s->fl_pg_order = ilog2(fl1) - PAGE_SHIFT;
+	if (fl_large_pg)
+		s->fl_pg_order = ilog2(fl_large_pg) - PAGE_SHIFT;
 	s->stat_len = ((sge_params->sge_control & EGRSTATUSPAGESIZE_F)
 			? 128 : 64);
 	s->pktshift = PKTSHIFT_G(sge_params->sge_control);
