Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29550C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6A521473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fXQyyy7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6A521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeJFApx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:45:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42182 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbeJFApw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:45:52 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95Hi8j6000840
        for <linux-kernel@vger.kernel.org>; Fri, 5 Oct 2018 10:46:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=oQy/nTyswYbGEbWljBxaqBJv7nu9YVJZ4bXIzOJfKCk=;
 b=fXQyyy7E2cWcJ8iH78xdJdbCj2A7KRTJlPkmWcSCnaKHzJWEQ0StjDo0FE8yt/HWM2jN
 /iGeyKViB42MIVRUFZO2WZK7Cloe5Ft5DF4i3wUekRtJ5YCWgky5g/Or135UgJOwbMcR
 MWXVeErbS6F9ly2yYhSQ8vyyF4SEPLTE65M= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mxads0gh6-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:46:06 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.15) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 5 Oct
 2018 10:46:05 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)  id
 01F1423A960F; Fri,  5 Oct 2018 10:46:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
        "Justin . Lee1 @ Dell . com" <Justin.Lee1@Dell.com>,
        "joel @ jms . id . au" <joel@jms.id.au>,
        "linux-aspeed @ lists . ozlabs . org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "christian @ cmd . nu" <christian@cmd.nu>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH net-next] net/ncsi: Add NCSI OEM command support
Date:   Fri, 5 Oct 2018 10:46:01 -0700
Message-ID: <20181005174602.828803-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds OEM commands and response handling. It also defines OEM
command and response structure as per NCSI specification along with its
handlers.

ncsi_cmd_handler_oem: This is a generic command request handler for OEM
commands
ncsi_rsp_handler_oem: This is a generic response handler for OEM commands

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
Reviewed-by: Justin Lee <justin.lee1@dell.com>
Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
---
 net/ncsi/internal.h |  5 +++++
 net/ncsi/ncsi-cmd.c | 30 +++++++++++++++++++++++++++---
 net/ncsi/ncsi-pkt.h | 14 ++++++++++++++
 net/ncsi/ncsi-rsp.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 8055e3965cef..3d0a33b874f5 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -68,6 +68,10 @@ enum {
 	NCSI_MODE_MAX
 };
 
+/* OEM Vendor Manufacture ID */
+#define NCSI_OEM_MFR_MLX_ID             0x8119
+#define NCSI_OEM_MFR_BCM_ID             0x113d
+
 struct ncsi_channel_version {
 	u32 version;		/* Supported BCD encoded NCSI version */
 	u32 alpha2;		/* Supported BCD encoded NCSI version */
@@ -305,6 +309,7 @@ struct ncsi_cmd_arg {
 		unsigned short words[8];
 		unsigned int   dwords[4];
 	};
+	unsigned char        *data;       /* NCSI OEM data                 */
 };
 
 extern struct list_head ncsi_dev_list;
diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
index 7567ca63aae2..82b7d9201db8 100644
--- a/net/ncsi/ncsi-cmd.c
+++ b/net/ncsi/ncsi-cmd.c
@@ -211,6 +211,25 @@ static int ncsi_cmd_handler_snfc(struct sk_buff *skb,
 	return 0;
 }
 
+static int ncsi_cmd_handler_oem(struct sk_buff *skb,
+				struct ncsi_cmd_arg *nca)
+{
+	struct ncsi_cmd_oem_pkt *cmd;
+	unsigned int len;
+
+	len = sizeof(struct ncsi_cmd_pkt_hdr) + 4;
+	if (nca->payload < 26)
+		len += 26;
+	else
+		len += nca->payload;
+
+	cmd = skb_put_zero(skb, len);
+	memcpy(&cmd->mfr_id, nca->data, nca->payload);
+	ncsi_cmd_build_header(&cmd->cmd.common, nca);
+
+	return 0;
+}
+
 static struct ncsi_cmd_handler {
 	unsigned char type;
 	int           payload;
@@ -244,7 +263,7 @@ static struct ncsi_cmd_handler {
 	{ NCSI_PKT_CMD_GNS,    0, ncsi_cmd_handler_default },
 	{ NCSI_PKT_CMD_GNPTS,  0, ncsi_cmd_handler_default },
 	{ NCSI_PKT_CMD_GPS,    0, ncsi_cmd_handler_default },
-	{ NCSI_PKT_CMD_OEM,    0, NULL                     },
+	{ NCSI_PKT_CMD_OEM,   -1, ncsi_cmd_handler_oem     },
 	{ NCSI_PKT_CMD_PLDM,   0, NULL                     },
 	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default }
 };
@@ -316,8 +335,13 @@ int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca)
 		return -ENOENT;
 	}
 
-	/* Get packet payload length and allocate the request */
-	nca->payload = nch->payload;
+	/* Get packet payload length and allocate the request
+	 * It is expected that if length set as negative in
+	 * handler structure means caller is initializing it
+	 * and setting length in nca before calling xmit function
+	 */
+	if (nch->payload >= 0)
+		nca->payload = nch->payload;
 	nr = ncsi_alloc_command(nca);
 	if (!nr)
 		return -ENOMEM;
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index 91b4b66438df..0f2087c8d42a 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -151,6 +151,20 @@ struct ncsi_cmd_snfc_pkt {
 	unsigned char           pad[22];
 };
 
+/* OEM Request Command as per NCSI Specification */
+struct ncsi_cmd_oem_pkt {
+	struct ncsi_cmd_pkt_hdr cmd;         /* Command header    */
+	__be32                  mfr_id;      /* Manufacture ID    */
+	unsigned char           data[];      /* OEM Payload Data  */
+};
+
+/* OEM Response Packet as per NCSI Specification */
+struct ncsi_rsp_oem_pkt {
+	struct ncsi_rsp_pkt_hdr rsp;         /* Command header    */
+	__be32                  mfr_id;      /* Manufacture ID    */
+	unsigned char           data[];      /* Payload data      */
+};
+
 /* Get Link Status */
 struct ncsi_rsp_gls_pkt {
 	struct ncsi_rsp_pkt_hdr rsp;        /* Response header   */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 930c1d3796f0..d66b34749027 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -596,6 +596,47 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 	return 0;
 }
 
+static struct ncsi_rsp_oem_handler {
+	unsigned int	mfr_id;
+	int		(*handler)(struct ncsi_request *nr);
+} ncsi_rsp_oem_handlers[] = {
+	{ NCSI_OEM_MFR_MLX_ID, NULL },
+	{ NCSI_OEM_MFR_BCM_ID, NULL }
+};
+
+/* Response handler for OEM command */
+static int ncsi_rsp_handler_oem(struct ncsi_request *nr)
+{
+	struct ncsi_rsp_oem_pkt *rsp;
+	struct ncsi_rsp_oem_handler *nrh = NULL;
+	unsigned int mfr_id, i;
+
+	/* Get the response header */
+	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+	mfr_id = ntohl(rsp->mfr_id);
+
+	/* Check for manufacturer id and Find the handler */
+	for (i = 0; i < ARRAY_SIZE(ncsi_rsp_oem_handlers); i++) {
+		if (ncsi_rsp_oem_handlers[i].mfr_id == mfr_id) {
+			if (ncsi_rsp_oem_handlers[i].handler)
+				nrh = &ncsi_rsp_oem_handlers[i];
+			else
+				nrh = NULL;
+
+			break;
+		}
+	}
+
+	if (!nrh) {
+		netdev_err(nr->ndp->ndev.dev, "Received unrecognized OEM packet with MFR-ID (0x%x)\n",
+			   mfr_id);
+		return -ENOENT;
+	}
+
+	/* Process the packet */
+	return nrh->handler(nr);
+}
+
 static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
 {
 	struct ncsi_rsp_gvi_pkt *rsp;
@@ -932,7 +973,7 @@ static struct ncsi_rsp_handler {
 	{ NCSI_PKT_RSP_GNS,   172, ncsi_rsp_handler_gns     },
 	{ NCSI_PKT_RSP_GNPTS, 172, ncsi_rsp_handler_gnpts   },
 	{ NCSI_PKT_RSP_GPS,     8, ncsi_rsp_handler_gps     },
-	{ NCSI_PKT_RSP_OEM,     0, NULL                     },
+	{ NCSI_PKT_RSP_OEM,    -1, ncsi_rsp_handler_oem     },
 	{ NCSI_PKT_RSP_PLDM,    0, NULL                     },
 	{ NCSI_PKT_RSP_GPUUID, 20, ncsi_rsp_handler_gpuuid  }
 };
-- 
2.17.1

