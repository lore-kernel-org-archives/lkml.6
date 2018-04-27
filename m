Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839566-2-2531588511550658789
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
    1524839566; b=Ws18JelR5XfZt4W9exafDgGsyIgLPjGEOuqbOwpeyd6U69D+04
    udK3poATAPYJZNsA3Tcv8VGWZw/Vqv1/Jd/BtQ72EG69BJbyKl/S2nfnMF/L3dAD
    owk3ZTjQK+1jqc3xKkAj+yAfYXK3Sdd01UgIwTk1xrckjg/TOa90MnH46uT8tvZd
    4g/bgJRK/ocTEiQjGqs1p0zPQYrBADQS1HaKInDDDsdm0kV2vkkDgRxOkiOKBKWj
    X4UoOvQdZkhLXwLzL8og5//KykcuMf/BekD6i8RZ/Zyz/PcHI1aiWXagPOpDVfLS
    Hu6IvTnvsXVNxwMZaEskzkT+ovrTeDnqrFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839566; bh=wANNzyLxbuXYrRPm+Gsc4zgxxeoT7G
    YhAyoA2UBT8ko=; b=LiU4vngTpE0oRp5xwW9u50WNmy9fZ+PSlpjLsmHsjSfq20
    +Ui9KjpfP5XcS094VGFN4Xh6LpokJ+yMYE+2HmpJbLUE/A0ABOyUIQhhqqQ+eZ6f
    5CiY/iqkCZHlP3dICQCyA0R5xpqkWCGf21ORi7GQiy4I+r66USIJ7S8++7BnY4TC
    eJ1MTTnHbxBfJ1PhAyHOc0RgHjhJ6Bdh1DZ/SJGUouh/LneTJyFEEUQ1Ick+q9VP
    dpSaWUREciJDM6q8NZGsvumAOnnZeBTAQ/lAXjoSmi2KzRLixSv6xIYugD/AFe2r
    OY6FnTh57GaPnho76mvGIL1fBTletRPn0qPMUgIA==
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
X-CM-Envelope: MS4wfDp83bv8ZgPJjYSs9743N4UaAgZq9TzSlLvTd/rk1zoVNSBSsX+XgXVzCUfwy6Dcig68OCmx8A9DXbEb/CstoFex18vMrFmVi9+ymbFebIwrOWhGFmBC
    yjXaMuZm+lF+anhbwlXx4FeBAxOLGyCFGWQc2K1KonIMr6N4bHeRtm0ehlKNjp6lGshQ4z65ZXCFDOF0EtDU7t2ly2iJp7NprhHM2lWVE7SLZmum7adiDIpE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=YlsH8J_LH8jvirUM1icA:9
    a=bkLrsNzI_9x0FqM4:21 a=LiUcdgOuSDnjtY_I:21 a=QEXdDO2ut3YA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934835AbeD0OKZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OKX (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8DC21895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doron Roberts-Kedes <doronrk@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 26/81] strparser: Fix incorrect strp->need_bytes value.
Date: Fri, 27 Apr 2018 15:58:28 +0200
Message-Id: <20180427135744.664373927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Doron Roberts-Kedes <doronrk@fb.com>


[ Upstream commit 9d0c75bf6e03d9bf80c55b0f677dc9b982958fd5 ]

strp_data_ready resets strp->need_bytes to 0 if strp_peek_len indicates
that the remainder of the message has been received. However,
do_strp_work does not reset strp->need_bytes to 0. If do_strp_work
completes a partial message, the value of strp->need_bytes will continue
to reflect the needed bytes of the previous message, causing
future invocations of strp_data_ready to return early if
strp->need_bytes is less than strp_peek_len. Resetting strp->need_bytes
to 0 in __strp_recv on handing a full message to the upper layer solves
this problem.

__strp_recv also calculates strp->need_bytes using stm->accum_len before
stm->accum_len has been incremented by cand_len. This can cause
strp->need_bytes to be equal to the full length of the message instead
of the full length minus the accumulated length. This, in turn, causes
strp_data_ready to return early, even when there is sufficient data to
complete the partial message. Incrementing stm->accum_len before using
it to calculate strp->need_bytes solves this problem.

Found while testing net/tls_sw recv path.

Fixes: 43a0c6751a322847 ("strparser: Stream parser for messages")
Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -296,9 +296,9 @@ static int __strp_recv(read_descriptor_t
 					strp_start_timer(strp, timeo);
 				}
 
+				stm->accum_len += cand_len;
 				strp->need_bytes = stm->strp.full_len -
 						       stm->accum_len;
-				stm->accum_len += cand_len;
 				stm->early_eaten = cand_len;
 				STRP_STATS_ADD(strp->stats.bytes, cand_len);
 				desc->count = 0; /* Stop reading socket */
@@ -321,6 +321,7 @@ static int __strp_recv(read_descriptor_t
 		/* Hurray, we have a new message! */
 		cancel_delayed_work(&strp->msg_timer_work);
 		strp->skb_head = NULL;
+		strp->need_bytes = 0;
 		STRP_STATS_INCR(strp->stats.msgs);
 
 		/* Give skb to upper layer */
@@ -410,9 +411,7 @@ void strp_data_ready(struct strparser *s
 		return;
 
 	if (strp->need_bytes) {
-		if (strp_peek_len(strp) >= strp->need_bytes)
-			strp->need_bytes = 0;
-		else
+		if (strp_peek_len(strp) < strp->need_bytes)
 			return;
 	}
 
