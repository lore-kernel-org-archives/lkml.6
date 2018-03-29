Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1456203-1522346960-2-16007362930189886120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346959; b=PG7RAvu4DAQao8h7s58Q3RDtU8Y5pT30Tz6gTH4FsCEZ81lvIL
    TWZh4JKiuDl7etMml/kopkhFWevTtK0rktICLJ0eA2FEeRnA28u1frvrRX9NmMJr
    OvAnlFnKOkqKjQ4SyjlpoKEp1rGIxe3rZGuLGmPd9seJO6nzJJKBv8gmmOJoehbN
    Oy7kQnxc6PTPy/E0qxq7yyavMQVYcmRdEyM7OP+MYUZcLsqsPedVA8E9wp1GUM8l
    GkceqWIp8Wnab/zvgDqb/r8g8RM+943rj8ER6awTjM1YZ4PyQsHb8Btlw/ZFNHJC
    IwDp7hP/3Qknrzh5sDteb2v18Y14IDx+kiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346959; bh=+xV2GPc2lSPYjWwzoSe4ozCdpcQXjc
    YdY2PFdkGA7qE=; b=fr1HIymfOyGq9ZbpV5n9k3R7Qad+VzGKTUX9ANzA3aZpKz
    66jeguRVi6hgKcMOfoSRZUkAlMq3a/ohy/ggD9qfO9a3gRnS9vE21Eb0h+CqVoM2
    bRNOgU5SqPq6oLv5V1EIA5GX99jyxGLeQJvBje4sdwfxA3h4CXc1UIcvaV5sfUET
    MdcfWN/4wSEmyZ29weMD/IAnSZNx41eZRGjZt+NtItOG4NIzksg/tRzWLOWX1nbt
    7KhVbxkGJFaEuVZzCF5mC3QFQ5mD7UsdYqspe4lBemBPnUQ4k39raA47oQSJ7ahD
    XBtqJyTTgOCcl86awqNTzkuUDPaX4XM3XXdl0tgw==
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
X-CM-Envelope: MS4wfJwzXzmOV88nMJ615EGVyzKM/lVnscI+v6rxX2INtYhoeDzF5VF4n+CU85vXq/qO//WfPn/t+SVj50Po/J38lBtMlSTqnhndDtjczyNfm2QNK3KaL4Vh
    8bl6iAz/ohgE1IBtQU3D86doujKYXZY/7FJ0p8569EteJ/ZC/DxeCKYhjnWw2bKgf+lyhw/MaqvcuJOEIP4B0MeD+5IE6VWqndadNd3JtmEQRB2vFCXPhrgM
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=vaY82krVgZPQqbDzlp4A:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeC2SJD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:09:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60644 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754316AbeC2SIa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:08:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arkadi Sharshevsky <arkadis@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 13/20] team: Fix double free in error path
Date: Thu, 29 Mar 2018 20:00:49 +0200
Message-Id: <20180329175742.449285547@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arkadi Sharshevsky <arkadis@mellanox.com>


[ Upstream commit cbcc607e18422555db569b593608aec26111cb0b ]

The __send_and_alloc_skb() receives a skb ptr as a parameter but in
case it fails the skb is not valid:
- Send failed and released the skb internally.
- Allocation failed.

The current code tries to release the skb in case of failure which
causes redundant freeing.

Fixes: 9b00cf2d1024 ("team: implement multipart netlink messages for options transfers")
Signed-off-by: Arkadi Sharshevsky <arkadis@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2380,7 +2380,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
@@ -2660,7 +2660,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
