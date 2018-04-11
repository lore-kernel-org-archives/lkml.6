Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523472959-2-4101014040868902237
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
    1523472958; b=nmuQYXL9G5SuX8vMHWHmhR8RbuBKaONv4o51x2Xn0nKDmKDH+A
    SdO/NTg4SSrIWlu3W/C1I7KID63dt+a8I6+mXHr2PUP9AXvMeAyfpvVwb76ttWnr
    W8MppEkVfuR1yoLvulfg69wPw0k2L2/vD5z9OsFumbw5xuI88zdC2rdR6RM1BADP
    bMEOeYVxdBlf9elIFkKahF7oCdJLwqrF9BtB84/1Ve6dI5aFUhkhTXgQ9f0ugRHm
    3sv+xzfcPRX1Rqj2bqkcUziRDKvUzX4KPe8e/ygCpUHUkjMr6PQfj8ga3bpGfo0j
    d6ARUfhZdwm6ey1AqrORLd8CWsQFhpYccy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472958; bh=c2STYCbRPOaJyC/fDelx33Ab5mW9k7
    xkAr4ryrjneiw=; b=oeVkZidngjvwCjEcJi3Lb3l50aOlymprGTAnQoU/JywCML
    /wV3LabgKZozlau1RegKO9CN7/93ioFl/ZXdFyP1CMyhfJd+g++MTv6kFyaoL/AA
    Ypnllg3AoOEYtwMY/aM9MX2ZnvgiiBGxZFwEM7bnNoOeCn4eJtaiuAQ6cc664P7U
    ACVCDsejuj5+lEV8D46tUDqXSvkVVOvvdy85ZqRMV9OZhCBJjVl2E1W/qUHscCUv
    qnfTMnixOOLA94/++PjoSzDXB1Rv5hqsrP+IXWq6lC3CnmuOgmgGxVfO8vMctYHE
    w7VsdGNPPGY8FSgroGeUTZVzSa6572edyyly2ScA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFz8AIYaitSzuQu4WiF0WlyCmiINvZFS1HAVNK8mSfkMa+JNKalvop6LE0TxJxDJC+wSWC7O8YsomMzGdJQQA80Zz4Ly9km7DgQL7fm5WPDx02+yyaIC
    TZ7AUIymALWyNYclVqN8VYfQo8WfT9vdQsUvyYQa5Nb0ls/6SdH1NiVAzcqcucgumcJR00rqLYwEWHbWBWjemPXIdzqb1IyRmYsZEvnR0rAJMkD7Rd2rNP2g
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=ib1MwrrLFK8Sm5v9irYA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933800AbeDKSzx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933798AbeDKSzv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 076/310] mlxsw: spectrum: Avoid possible NULL pointer dereference
Date: Wed, 11 Apr 2018 20:33:35 +0200
Message-Id: <20180411183625.582544217@linuxfoundation.org>
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

From: Ido Schimmel <idosch@mellanox.com>


[ Upstream commit c0e01eac7ada785fdeaea1ae5476ec1cf3b00374 ]

In case we got an FDB notification for a port that doesn't exist we
execute an FDB entry delete to prevent it from re-appearing the next
time we poll for notifications.

If the operation failed we would trigger a NULL pointer dereference as
'mlxsw_sp_port' is NULL.

Fix it by reporting the error using the underlying bus device instead.

Fixes: 12f1501e7511 ("mlxsw: spectrum: remove FDB entry in case we get unknown object notification")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1448,8 +1448,7 @@ do_fdb_op:
 	err = mlxsw_sp_port_fdb_uc_op(mlxsw_sp, local_port, mac, fid,
 				      adding, true);
 	if (err) {
-		if (net_ratelimit())
-			netdev_err(mlxsw_sp_port->dev, "Failed to set FDB entry\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to set FDB entry\n");
 		return;
 	}
 
@@ -1509,8 +1508,7 @@ do_fdb_op:
 	err = mlxsw_sp_port_fdb_uc_lag_op(mlxsw_sp, lag_id, mac, fid, lag_vid,
 					  adding, true);
 	if (err) {
-		if (net_ratelimit())
-			netdev_err(mlxsw_sp_port->dev, "Failed to set FDB entry\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to set FDB entry\n");
 		return;
 	}
 
