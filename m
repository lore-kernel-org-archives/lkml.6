Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE40C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA5E20821
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5qJBwjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBHC6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:58:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38680 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfBHC6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:58:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so985853pfi.5;
        Thu, 07 Feb 2019 18:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Hfh8mP4TGkhcZeINaDG2VTUX9sdaEwr+jHs5k8fnAs=;
        b=f5qJBwjC0HnMFbga9nfS6F+ciQCOBXJILpBczSsVdxOkWCYo+HYsovCm0JqdDXhX1l
         +HAw5ZHs/2J56kQ1O4ZOW9UEEVyCJtY/1NFJJHwOnMZ9YnB+xiemanBEv0Q6CWZgiW36
         /7AITBwD26k85nrF4qt28zZMzjiHDnZMPoYver9S19fWfL2iMVs6i66GO+s7jLULE7iw
         9UjkoKJhh0q1xok+FrLa74REQphJGCu86L5ckxptnlDl7OTqBjxixdXUhuXif7vHZpMG
         laCkbdv/7sVHHFX3kRKm+BKhEwg5PjZEDRsldgbNHOufpjPGggL05o83DS/cgVwVTueT
         pFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Hfh8mP4TGkhcZeINaDG2VTUX9sdaEwr+jHs5k8fnAs=;
        b=HwXXuSoHOLaY/h7zcigQAH2Y/Rp1Rzu2SKasVUHh112i3pgPDvKYLvvfJpPD6x6Znf
         Y1YeTxoEk68uEr8vzbjykVJn7lfhlGgPc6GegsnF0FB42QQQ2+0moKE3m+UbF3EqRLqb
         APokHh6pzenj4zk6rhLVdVArUozZ/ljKgY7qTHZyOel4gOOpnXIybDHYf5ClQNGuh2P9
         yEDoCQKjVvb+HskBXOUjbWK+IYeJ5bJqA/dA7uMWoFDrKf+jy/rdTx42zMmE0aI1sknA
         uSKUjEafUCwCa6PPh2t4sr4VGLZz91J+HWzHE+b/VEi05WKaZhM/ld2crUQ7BUluLL2o
         71Fw==
X-Gm-Message-State: AHQUAuYIMR0iFXGxKmrlz3MaSWlDveQD/lY4qqPg2+9hT9oQhq6+2c+U
        jbNPbEBL4BCvGVh19h3cvfK7m4SQ
X-Google-Smtp-Source: AHgI3IaCNJNXKxXsyZptFnv9C6z71ctJEIbg7LdJ9b6YJftz2z7u2PJi+hhhNfi5S7TomOSPaWxBwg==
X-Received: by 2002:a65:4049:: with SMTP id h9mr17940400pgp.304.1549594727448;
        Thu, 07 Feb 2019 18:58:47 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id n68sm726695pfb.62.2019.02.07.18.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 18:58:46 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
Date:   Thu,  7 Feb 2019 18:58:28 -0800
Message-Id: <20190208025828.30901-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to:

 - current implementation of l2cap_config_rsp() dropping BT
   connection if sender of configuration response replied with unknown
   option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)

 - current implementation of l2cap_build_conf_req() adding
   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
   the Linux host.

devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
controllers, will get stuck in endless connect -> configure ->
disconnect loop, never connect and be generaly unusable.

To avoid this problem add code to do the following:

 1. Store a mask of supported conf option types per connection

 2. Parse the body of response L2CAP_CONF_UNKNOWN and adjust
    connection's supported conf option types mask

 3. Retry configuration step the same way it's done for
    L2CAP_CONF_UNACCEPT

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Cc: Florian Dollinger <dollinger.florian@gmx.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Everyone:

I marked this as an RFC, since I don't have a lot of experience with
Bluetooth subsystem and don't have hight degree of confidence about
choices made in this patch. I do, however, thins is is good enough to
start a discussion about the problem.

Thanks,
Andrey Smirnov

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 58 ++++++++++++++++++++++++++++++-----
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 093aedebdf0c..6898bba5d9a8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -632,6 +632,7 @@ struct l2cap_conn {
 	unsigned int		mtu;
 
 	__u32			feat_mask;
+	__u32			known_options;
 	__u8			remote_fixed_chan;
 	__u8			local_fixed_chan;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f17e393b43b4..49be98b6de72 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3243,8 +3243,10 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = 0;
 
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
-				   (unsigned long) &rfc, endptr - ptr);
+		if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+					   (unsigned long)&rfc, endptr - ptr);
+		}
 		break;
 
 	case L2CAP_MODE_ERTM:
@@ -3263,8 +3265,10 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		rfc.txwin_size = min_t(u16, chan->tx_win,
 				       L2CAP_DEFAULT_TX_WINDOW);
 
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
-				   (unsigned long) &rfc, endptr - ptr);
+		if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+					   (unsigned long)&rfc, endptr - ptr);
+		}
 
 		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
 			l2cap_add_opt_efs(&ptr, chan, endptr - ptr);
@@ -3295,8 +3299,10 @@ static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			     L2CAP_FCS_SIZE);
 		rfc.max_pdu_size = cpu_to_le16(size);
 
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
-				   (unsigned long) &rfc, endptr - ptr);
+		if (chan->conn->known_options & BIT(L2CAP_CONF_RFC)) {
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+					   (unsigned long)&rfc, endptr - ptr);
+		}
 
 		if (test_bit(FLAG_EFS_ENABLE, &chan->flags))
 			l2cap_add_opt_efs(&ptr, chan, endptr - ptr);
@@ -3550,11 +3556,47 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 	void *endptr = data + size;
 	int type, olen;
 	unsigned long val;
+	const bool unknown_options = *result == L2CAP_CONF_UNKNOWN;
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
 
 	BT_DBG("chan %p, rsp %p, len %d, req %p", chan, rsp, len, data);
 
+	/* throw out any old stored conf requests */
+	*result = L2CAP_CONF_SUCCESS;
+
+	if (unknown_options) {
+		const u8 *option_type = rsp;
+
+		if (!len) {
+			/* If no list of unknown option types is
+			 * provided there's nothing for us to do
+			 */
+			return -ECONNREFUSED;
+		}
+
+		while (len--) {
+			BT_DBG("chan %p, unknown option type: %u", chan,
+			       *option_type);
+			/* "...Hints shall not be included in the
+			 * Response and shall not be the sole cause
+			 * for rejecting the Request.."
+			 */
+			if (*option_type & L2CAP_CONF_HINT)
+				return -ECONNREFUSED;
+			/* Make sure option type is one of the types
+			 * supported/used in configure requests
+			 */
+			if (*option_type < L2CAP_CONF_MTU ||
+			    *option_type > L2CAP_CONF_EWS)
+				return -ECONNREFUSED;
+
+			chan->conn->known_options &= ~BIT(*option_type++);
+		}
+
+		return l2cap_build_conf_req(chan, data, size);
+	}
+
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
 		if (len < 0)
@@ -4240,6 +4282,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 		}
 		goto done;
 
+	case L2CAP_CONF_UNKNOWN:
 	case L2CAP_CONF_UNACCEPT:
 		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
 			char req[64];
@@ -4249,8 +4292,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				goto done;
 			}
 
-			/* throw out any old stored conf requests */
-			result = L2CAP_CONF_SUCCESS;
 			len = l2cap_parse_conf_rsp(chan, rsp->data, len,
 						   req, sizeof(req), &result);
 			if (len < 0) {
@@ -7067,6 +7108,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	hcon->l2cap_data = conn;
 	conn->hcon = hci_conn_get(hcon);
 	conn->hchan = hchan;
+	conn->known_options = U32_MAX;
 
 	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
 
-- 
2.20.1

