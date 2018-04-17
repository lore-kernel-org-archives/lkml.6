Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2935924-1524004479-2-17472440289419976348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524004478; b=fEI6vK1ibGC3HM3KnEujKzHfMBtN00nzEN4h2SfW0U/b+cGw5/
    nqsZWuUy+NN3BJ2b34GwGyi2GlJhKgccbjB9RqzQxgpzNizvRRnwYOiFgRELRydT
    Q5CpnhDs6IXCqRJ5TXLA6iPLBzM9b/h+o2hkY2J5vcemlj4QJvRDA+uqTCb8gmF1
    jJvF6jC6Z4a5AMoDGyRIbG+w79Qw8LdzmD+oHMrOc6ZKG3yan8jXyqw/YePhsXCY
    X3QIgeeQPtauaq+6MMjcgyJQm1625mNiK9b0AT8BREJYBH9PvGbBGmaaGx1u8nzD
    noXxvXGrP7F28zKPAc/CUV5xgi1F680p2hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524004478; bh=LpXvF
    j7pDKkWuxM2pvysdTybEkYiNRCTmYBuiu6Ph14=; b=GaHTQiStZcWoso2/iZoSA
    AkOd4Z6aMCR7ccvxM/4XspSJ6ISEX1J+stu4XnynwjbsMulRNBJP935ITM2VsCA4
    IJ8cIQFn7ibKYZpXyGRj5VZ1fj1AF7iXKBh1H6DuUqD7pfjQErZZ9h9ZKZPtyQ83
    SFBUanGb+Awptdqv8LXxmR03NjYNPYc/n6Y0gTN9DyfebemWiYo0aw1LzNw1hGOx
    i+TcpgD+Klp5Diz9kJ4iP4UjqetFfSyvvYJLTqMepGdaCHsylpM4OfRU5PYKV6C3
    zTxXOflnpUmK13pYfIc1i/JaU/tV6PLQcDpom4UNnzXLZPZt5A92bSo/A44FdJ8g
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCbevFDuMoQHOuNXcsuIvCnWuDNc84PegyclVazVcrnJBqW/5afQEQcffrVg4bZ/Wl9jgjH3A6BuWO0XXN8s43krwKc3NtvLuPebqZX0mPdimgXh8x83
    VCnIPlk4zMAYO03BMBLg93EB8CQHrv25Qyckn00ASYd8IEO7s/Am8ZlB1VdREvj8XzfLEAz7yxDjPAsykLH2QSVkB+HDd58U7N8w9C0Fx6vN6PB+bQDH0Btb
    gvpsqjmXmBls2oKHHlVqZQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=tmS7JMM846u_rvfcd3cA:9 a=3XJmB7HQcNsqC2gN:21
    a=8Q0wdtAszfxOAoQg:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Add NetVSP v6 and v6.1 into version
 negotiation
Date: Tue, 17 Apr 2018 15:31:47 -0700
Message-Id: <20180417223147.23218-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfEe6UkpyTUNaFYtwVgxZWHSNRjD0ZUyRpSw6q+uaWOabXQz2lTjoavQaZ1uI7BZ3821GtEArwiCuhqAN/XACbo+3IqpqZ+hCyhsxamuXLeHepkkBKK56
 Evxw7ga6jiJaolB1+CUXrvgi9U6Lc4EPSVqwyzwWs8U/UoJbGQynoVGcChkWC6scQlUYZNvc4uMSJg2C3crDUhGKbkmmkLNgRAlhcf5IX/RykMfbL2o/pcFZ
 kS7msoaEQR0V1MSU0gokF9NQMJq1IGLis19/eZjvSxxGGH8FJ+F6Sklko6I+QBpgjkzlnYmplll28kHiaVqKovUNPtkh7YVPLYmnYdSMAuQt1NMuHtP+1OkC
 izKPjUySuwVE8v6zfoQAhBvzlCjQmGgOUrX8qPkCKLIBlS7k4usZobgpSqI7YMyYNpsCdYQopdb96lmvGOWsdiG11hH8AxDjVKavnonaDidmyMXjgCoMA0GD
 ZpVjb0Fsmt+2yJ9cx+NDC8Ue5Awjs9aRw6jpQg==
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: haiyangz@microsoft.com
Cc: olaf@aepfle.de, sthemmin@microsoft.com, haiyangz@microsoft.com,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
 vkuznets@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

This patch adds the NetVSP v6 and 6.1 message structures, and includes
these versions into NetVSC/NetVSP version negotiation process.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 164 ++++++++++++++++++++++++++++++++++++++++
 drivers/net/hyperv/netvsc.c     |   3 +-
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 960f06141472..6ebe39a3dde6 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -237,6 +237,8 @@ void netvsc_switch_datapath(struct net_device *nv_dev, bool vf);
 #define NVSP_PROTOCOL_VERSION_2		0x30002
 #define NVSP_PROTOCOL_VERSION_4		0x40000
 #define NVSP_PROTOCOL_VERSION_5		0x50000
+#define NVSP_PROTOCOL_VERSION_6		0x60000
+#define NVSP_PROTOCOL_VERSION_61	0x60001
 
 enum {
 	NVSP_MSG_TYPE_NONE = 0,
@@ -308,6 +310,12 @@ enum {
 	NVSP_MSG5_TYPE_SEND_INDIRECTION_TABLE,
 
 	NVSP_MSG5_MAX = NVSP_MSG5_TYPE_SEND_INDIRECTION_TABLE,
+
+	/* Version 6 messages */
+	NVSP_MSG6_TYPE_PD_API,
+	NVSP_MSG6_TYPE_PD_POST_BATCH,
+
+	NVSP_MSG6_MAX = NVSP_MSG6_TYPE_PD_POST_BATCH
 };
 
 enum {
@@ -619,12 +627,168 @@ union nvsp_5_message_uber {
 	struct nvsp_5_send_indirect_table send_table;
 } __packed;
 
+enum nvsp_6_pd_api_op {
+	PD_API_OP_CONFIG = 1,
+	PD_API_OP_SW_DATAPATH, /* Switch Datapath */
+	PD_API_OP_OPEN_PROVIDER,
+	PD_API_OP_CLOSE_PROVIDER,
+	PD_API_OP_CREATE_QUEUE,
+	PD_API_OP_FLUSH_QUEUE,
+	PD_API_OP_FREE_QUEUE,
+	PD_API_OP_ALLOC_COM_BUF, /* Allocate Common Buffer */
+	PD_API_OP_FREE_COM_BUF, /* Free Common Buffer */
+	PD_API_OP_MAX
+};
+
+struct grp_affinity {
+	u64 mask;
+	u16 grp;
+	u16 reserved[3];
+} __packed;
+
+struct nvsp_6_pd_api_req {
+	u32 op;
+
+	union {
+		/* MMIO information is sent from the VM to VSP */
+		struct __packed {
+			u64 mmio_pa; /* MMIO Physical Address */
+			u32 mmio_len;
+
+			/* Number of PD queues a VM can support */
+			u16 num_subchn;
+		} config;
+
+		/* Switch Datapath */
+		struct __packed {
+			/* Host Datapath Is PacketDirect */
+			u8 host_dpath_is_pd;
+
+			/* Guest PacketDirect Is Enabled */
+			u8 guest_pd_enabled;
+		} sw_dpath;
+
+		/* Open Provider*/
+		struct __packed {
+			u32 prov_id; /* Provider id */
+			u32 flag;
+		} open_prov;
+
+		/* Close Provider */
+		struct __packed {
+			u32 prov_id;
+		} cls_prov;
+
+		/* Create Queue*/
+		struct __packed {
+			u32 prov_id;
+			u16 q_id;
+			u16 q_size;
+			u8 is_recv_q;
+			u8 is_rss_q;
+			u32 recv_data_len;
+			struct grp_affinity affy;
+		} cr_q;
+
+		/* Delete Queue*/
+		struct __packed {
+			u32 prov_id;
+			u16 q_id;
+		} del_q;
+
+		/* Flush Queue */
+		struct __packed {
+			u32 prov_id;
+			u16 q_id;
+		} flush_q;
+
+		/* Allocate Common Buffer */
+		struct __packed {
+			u32 len;
+			u32 pf_node; /* Preferred Node */
+			u16 region_id;
+		} alloc_com_buf;
+
+		/* Free Common Buffer */
+		struct __packed {
+			u32 len;
+			u64 pa; /* Physical Address */
+			u32 pf_node; /* Preferred Node */
+			u16 region_id;
+			u8 cache_type;
+		} free_com_buf;
+	} __packed;
+} __packed;
+
+struct nvsp_6_pd_api_comp {
+	u32 op;
+	u32 status;
+
+	union {
+		struct __packed {
+			/* actual number of PD queues allocated to the VM */
+			u16 num_pd_q;
+
+			/* Num Receive Rss PD Queues */
+			u8 num_rss_q;
+
+			u8 is_supported; /* Is supported by VSP */
+			u8 is_enabled; /* Is enabled by VSP */
+		} config;
+
+		/* Open Provider */
+		struct __packed {
+			u32 prov_id;
+		} open_prov;
+
+		/* Create Queue */
+		struct __packed {
+			u32 prov_id;
+			u16 q_id;
+			u16 q_size;
+			u32 recv_data_len;
+			struct grp_affinity affy;
+		} cr_q;
+
+		/* Allocate Common Buffer */
+		struct __packed {
+			u64 pa; /* Physical Address */
+			u32 len;
+			u32 pf_node; /* Preferred Node */
+			u16 region_id;
+			u8 cache_type;
+		} alloc_com_buf;
+	} __packed;
+} __packed;
+
+struct nvsp_6_pd_buf {
+	u32 region_offset;
+	u16 region_id;
+	u16 is_partial:1;
+	u16 reserved:15;
+} __packed;
+
+struct nvsp_6_pd_batch_msg {
+	struct nvsp_message_header hdr;
+	u16 count;
+	u16 guest2host:1;
+	u16 is_recv:1;
+	u16 reserved:14;
+	struct nvsp_6_pd_buf pd_buf[0];
+} __packed;
+
+union nvsp_6_message_uber {
+	struct nvsp_6_pd_api_req pd_req;
+	struct nvsp_6_pd_api_comp pd_comp;
+} __packed;
+
 union nvsp_all_messages {
 	union nvsp_message_init_uber init_msg;
 	union nvsp_1_message_uber v1_msg;
 	union nvsp_2_message_uber v2_msg;
 	union nvsp_4_message_uber v4_msg;
 	union nvsp_5_message_uber v5_msg;
+	union nvsp_6_message_uber v6_msg;
 } __packed;
 
 /* ALL Messages */
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 04f611e6f678..e7308958b7a9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -525,7 +525,8 @@ static int netvsc_connect_vsp(struct hv_device *device,
 	struct net_device *ndev = hv_get_drvdata(device);
 	static const u32 ver_list[] = {
 		NVSP_PROTOCOL_VERSION_1, NVSP_PROTOCOL_VERSION_2,
-		NVSP_PROTOCOL_VERSION_4, NVSP_PROTOCOL_VERSION_5
+		NVSP_PROTOCOL_VERSION_4, NVSP_PROTOCOL_VERSION_5,
+		NVSP_PROTOCOL_VERSION_6, NVSP_PROTOCOL_VERSION_61
 	};
 	struct nvsp_message *init_packet;
 	int ndis_version, i, ret;
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
