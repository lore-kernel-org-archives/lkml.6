Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3493453-1522953818-2-11931264288349082500
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522953817; b=dRix0R2RpMo1xGvnVmxEq4cuM2qYterGtERDCPqQtJ3PfamekY
    n0syy2P7R0pLo6Q2Fvm5tUwnWY3uFiremUX/icskI2AO9wZggt2fe2kgjYnjslCR
    thGtVRAi0rT3FG0IsPHvhjNmxOMoKQTewNzqn+kkGDs13UbCqsan7R/eJMaPpqic
    RWbArs74HAm++g+GsvnXTS2OHKAzR/HwaML2OL15UdWoQWxnMow7/wXGaF8t9xBw
    41JDrM6MWBBAoWcvMD0x2vbmgAdSDGkTeCIXJXcyH9JLkFSR27vHCMkwUNCds2lu
    FPmgDkw+R26A4IiGBQ1LyGlR23Y1pLhDCE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:reply-to:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522953817; bh=NlKdA
    xFsVFrpfU7FROwWT+e/b2CPa1xnMTtDaMDJBsA=; b=l7LoU1kA6yis7RhG6HYqy
    DIYjTSAerxKwMma6eRA7fMS3faYn5piAk6g4Ti4bM+nsIlLz9SK9oBLUTpZpp5OZ
    YhHonJx2QYAexiBgXdgCvi+NixXEBhj7Xbwq3uy2zNgFr0zA889SHGbNIkltz9K8
    eyl64PPmvpE7b2vHR7meQCUwPr13YlD/jSbqvbyM+c1K2eXXTW6r6GbsAheDgOct
    JZOfeYSacVx1iiwHugsw1lBQafmhi7V7RP1kMqeKQLPfzayAEsXI8S50WMlFoRD9
    yUjKvur6P+AsPaR7wRjwbr7gHksA1mJGTO0I4WnGMtKY0efX4Zd8NxrTECxFIi8O
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN5yplDdcEe5aCAZ0UU2/kkJaOo0Vaa4ETEciZTOgAaKuHiStFTcUDoQZdGlhU5Y4b+6dAUfyMhWBJb5vyVQf6PUPhU2QE9hYb2Cd6dmKwA4veMG9lhc
    4mP6DY7xOn20cHtG1GJyiNUC4q0DANvFRFm+7VpZFuPVXQRE66Y+xb5yF2CqchtLmjiPMA1+zwqFAGika3C2zuIuJo9XtcdmEVhB5xMRE8U1J2LtYF0MhjNH
    RzCURt1HEuf7Pcq1I9pY1g==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=9aGaaWWcRqLSD-AsCxsA:9 a=r64DhC7N7av9EmB9:21
    a=hM4izMFPWzW2k3MR:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
To: davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next] hv_netvsc: Add NetVSP v6 into version negotiation
Date: Thu,  5 Apr 2018 11:42:22 -0700
Message-Id: <20180405184222.3167-1-haiyangz@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
X-CMAE-Envelope: MS4wfHHztkJcut50WMojePS2WQDb9Xong97Labg3DgXlz9NVJkoQEGUXVIHQ74V4f/FiqSQngfEm3KT7e+SIakRZyuXdrvdUwgCXoyvtK9MMHQt+bxI0mpYx
 zUleDuoRVpxeuwtfXYH6x13b/ZHGNrTluOS90Z7wnf+YFgMD1HEhQX7Nb9KUr5MAyt0hYpeSp2M1LurUtlo0onLOzNB4ADm1PDUcE7VBh+n58Xs5RM8RxL7N
 hSIPgbhViA6VPvoSCTYsAqq0cWobkIBEiDtcOO0Iy5OIyZautseVgcujPxJqgEQlSmtIPM6jb81uWUvnn0fllFCGATVkMsj9VvZr6hCK7KyintwV0rs1oNFs
 hyhnQcRVRLUMTy72uf605gEVBJgX2TiA1BSQUpQKQ5Fenip+K9SmTMNtMkcvFdAWF/kiaAoPfPY1fJfqBk4VsA6m0uVA4tbK5+qWEq5LNcQpbzbhmjdM7tdn
 807oCUKkh2d/OdcBUgp4z9PCKplrxCSIvaYocg==
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

This patch adds the NetVSP v6 message structures, and includes this
version into NetVSC/NetVSP version negotiation process.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 33 +++++++++++++++++++++++++++++++++
 drivers/net/hyperv/netvsc.c     |  3 ++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 960f06141472..036cd55c66fe 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -237,6 +237,7 @@ void netvsc_switch_datapath(struct net_device *nv_dev, bool vf);
 #define NVSP_PROTOCOL_VERSION_2		0x30002
 #define NVSP_PROTOCOL_VERSION_4		0x40000
 #define NVSP_PROTOCOL_VERSION_5		0x50000
+#define NVSP_PROTOCOL_VERSION_6		0x60000
 
 enum {
 	NVSP_MSG_TYPE_NONE = 0,
@@ -308,6 +309,11 @@ enum {
 	NVSP_MSG5_TYPE_SEND_INDIRECTION_TABLE,
 
 	NVSP_MSG5_MAX = NVSP_MSG5_TYPE_SEND_INDIRECTION_TABLE,
+
+	/* Version 6 messages */
+	NVSP_MSG6_TYPE_PD_API,
+
+	NVSP_MSG6_MAX = NVSP_MSG6_TYPE_PD_API
 };
 
 enum {
@@ -619,12 +625,39 @@ union nvsp_5_message_uber {
 	struct nvsp_5_send_indirect_table send_table;
 } __packed;
 
+enum nvsp6_pd_api_op {
+	PD_API_OP_NOTIFY_VSP = 0,
+	PD_API_OP_CONFIG,
+	PD_API_OP_MAX
+};
+
+struct nvsp_6_pd_api_req {
+	u32 op;
+	u64 mmio_pa; /* MMIO Physical Address */
+	u32 mmio_len;
+	u32 num_subchn; /* Number of PD subchannels */
+} __packed;
+
+struct nvsp_6_pd_api_comp {
+	u32 op;
+	u32 status;
+	u32 num_subchn; /* Number of PD subchannels */
+	u8 is_supported; /* Is supported by VSP */
+	u8 is_enabled; /* Is enabled by VSP */
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
index c9910c33e671..3abe57bd85bb 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -509,7 +509,8 @@ static int netvsc_connect_vsp(struct hv_device *device,
 	struct net_device *ndev = hv_get_drvdata(device);
 	static const u32 ver_list[] = {
 		NVSP_PROTOCOL_VERSION_1, NVSP_PROTOCOL_VERSION_2,
-		NVSP_PROTOCOL_VERSION_4, NVSP_PROTOCOL_VERSION_5
+		NVSP_PROTOCOL_VERSION_4, NVSP_PROTOCOL_VERSION_5,
+		NVSP_PROTOCOL_VERSION_6
 	};
 	struct nvsp_message *init_packet;
 	int ndis_version, i, ret;
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
