Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvrJL3Vq6GfGMUY5AUQvphrgfGT8tTx6pIjrF9br4W0eCuMeW5cd1OrdCejeTcGb9zeNlfz
ARC-Seal: i=1; a=rsa-sha256; t=1520116027; cv=none;
        d=google.com; s=arc-20160816;
        b=gsbmQwDw7ROwn/hWhpl3A2i27jOBg58fI3dn4WUsxsKJpc4Z3A4GkmqxAYtRPdUlNp
         hSijaBrnCaex2jXe0KQKxOBC2DLE2/VzISj4cMbmN3vi8cTbzwXNxyk8A5vnVk3y08j4
         IMS+HH1S7FfOrw8LSAsOuPbATfI558eGMmB6wrpu+t1qAiA7yXqBDevim4d9vq3ZM+Fr
         ashFLIMjiUduQvW+lRzxkupr5qtQ3tNLuh66L/8qdHMMaOVgz4epP3WD1gy54jMZHxl5
         dvCcbWYLN9wwQ1oM6/5UZTFo0XSfmaY8a0OAq/LD5Sx5M+CFI3GPTAAqjT0aaZkZD+gS
         JNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=GhOt77s6wyjP/Z4KBPN+gd6omDb811QcdJM5WM9igpw=;
        b=j2DXoJL8ky4mRW32/7LOEGCb+f3I/GWKiSrhqYBk7O8nEaUSlEcgqjHCvSg68mrokd
         7fUMlLb9MQGOmr6SMjo2R3if1XqZZmnfurdwGA6ynWw9gCnHjXkseXCkVfTK4H7ZYCgf
         cIZ3/2o0Q0JMIPkcQWk8U+WgF8yRg8mgpY8BpsDO6/lhLBlZVl1xwQIJgw/brLqXxMFa
         /DwW1NDGxgfCrmy4zsJQK2NeJAKOLEXfCkjuzU8X+gjyvI7+8aim5faY7AVPkzMS8pSn
         6RROaXcJXH6Y4HPrlM2wsqN0+43/1O9mdBiRvQxQAzQrzb5qemnBKY4RzdWVIYy0FMTz
         b3pg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=DXyZlL7X;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=DXyZlL7X;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ioana Radulescu <ruxandra.radulescu@nxp.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 078/102] staging: fsl-dpaa2/eth: Fix access
 to FAS field
Thread-Topic: [PATCH AUTOSEL for 4.15 078/102] staging: fsl-dpaa2/eth: Fix
 access to FAS field
Thread-Index: AQHTsz50VBzONfJUh0Sevg9kt4sYDw==
Date: Sat, 3 Mar 2018 22:24:54 +0000
Message-ID: <20180303222318.26006-78-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:u4Nr8jYuaCjqzWi0zZ4WFdOZIvYgQOHv/tptJZ7+ajQ8AcOIu28i9KzoQBhEmmWkJVFszKNy+aobsLAsMeLhFlNnoPUfR2pyvCPogFcA1gbQ1cIsmLhzplLWZis5zZhmkhQ3bQC0/Qi9ZGs1zo9T9IlsspRLvDHQV4tMitWlO82zp2N8aRhEXArxb0l4vGftAOcp0BKxziUHI6LUc4B3iwdx4DNyTcBNMX7C9uUJ9ovIEBvGG3RYRtl04qQOEmSR
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43b71309-5f79-46bb-32df-08d58155e422
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10672E3F11F24214D158595CFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(8656006)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(6666003)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(59450400001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: W1g9fGCaR0JcTgvetHsDfY9f4UhyQWD+9+EfE69iOmTiTjufpJIEVSvH0C6tuJFiHGpOiI4JXX4VpilBc1fYRpPipa0rOxoXMbx3qqXJRw8Y6AoICs7KMNU0b57Yi0kTvqhgC/c0B59WkqK0m+fQg9+Wv+MAim3G2XmZvYSLDNc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b71309-5f79-46bb-32df-08d58155e422
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:54.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957183142643823?=
X-GMAIL-MSGID: =?utf-8?q?1593957183142643823?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

[ Upstream commit 54ce891779888e85a2db04942dbaadd3f40fe223 ]

Commit 4b2d9fe87950 ("staging: fsl-dpaa2/eth: Extra headroom in RX
buffers") removes the software annotation (SWA) area from the RX
buffer layout, as it's not used by anyone, but fails to update the
macros for accessing hardware annotation (HWA) fields, which is
right after the SWA in the buffer headroom.

This may lead to some frame annotation status fields (e.g. indication
if L3/L4 checksum is valid) to be read incorrectly.

Turn the accessor macros into inline functions and add a bool param
to specify if SWA is present or not.

Fixes: 4b2d9fe87950 ("staging: fsl-dpaa2/eth: Extra headroom in RX buffers"=
)

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |  8 ++++----
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 13 +++++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/stagi=
ng/fsl-dpaa2/ethernet/dpaa2-eth.c
index 0d8ed002adcb..c8a8e3abfc3a 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -249,7 +249,7 @@ static void dpaa2_eth_rx(struct dpaa2_eth_priv *priv,
 	vaddr =3D dpaa2_iova_to_virt(priv->iommu_domain, addr);
 	dma_unmap_single(dev, addr, DPAA2_ETH_RX_BUF_SIZE, DMA_FROM_DEVICE);
=20
-	fas =3D dpaa2_get_fas(vaddr);
+	fas =3D dpaa2_get_fas(vaddr, false);
 	prefetch(fas);
 	buf_data =3D vaddr + dpaa2_fd_get_offset(fd);
 	prefetch(buf_data);
@@ -385,7 +385,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	 * on TX confirmation. We are clearing FAS (Frame Annotation Status)
 	 * field from the hardware annotation area
 	 */
-	fas =3D dpaa2_get_fas(sgt_buf);
+	fas =3D dpaa2_get_fas(sgt_buf, true);
 	memset(fas, 0, DPAA2_FAS_SIZE);
=20
 	sgt =3D (struct dpaa2_sg_entry *)(sgt_buf + priv->tx_data_offset);
@@ -458,7 +458,7 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
 	 * on TX confirmation. We are clearing FAS (Frame Annotation Status)
 	 * field from the hardware annotation area
 	 */
-	fas =3D dpaa2_get_fas(buffer_start);
+	fas =3D dpaa2_get_fas(buffer_start, true);
 	memset(fas, 0, DPAA2_FAS_SIZE);
=20
 	/* Store a backpointer to the skb at the beginning of the buffer
@@ -510,7 +510,7 @@ static void free_tx_fd(const struct dpaa2_eth_priv *pri=
v,
=20
 	fd_addr =3D dpaa2_fd_get_addr(fd);
 	skbh =3D dpaa2_iova_to_virt(priv->iommu_domain, fd_addr);
-	fas =3D dpaa2_get_fas(skbh);
+	fas =3D dpaa2_get_fas(skbh, true);
=20
 	if (fd_format =3D=3D dpaa2_fd_single) {
 		skb =3D *skbh;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/stagi=
ng/fsl-dpaa2/ethernet/dpaa2-eth.h
index 5b3ab9f62d5e..3a4e9395acdc 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -153,10 +153,15 @@ struct dpaa2_fas {
 #define DPAA2_FAS_SIZE			(sizeof(struct dpaa2_fas))
=20
 /* Accessors for the hardware annotation fields that we use */
-#define dpaa2_get_hwa(buf_addr) \
-	((void *)(buf_addr) + DPAA2_ETH_SWA_SIZE)
-#define dpaa2_get_fas(buf_addr) \
-	(struct dpaa2_fas *)(dpaa2_get_hwa(buf_addr) + DPAA2_FAS_OFFSET)
+static inline void *dpaa2_get_hwa(void *buf_addr, bool swa)
+{
+	return buf_addr + (swa ? DPAA2_ETH_SWA_SIZE : 0);
+}
+
+static inline struct dpaa2_fas *dpaa2_get_fas(void *buf_addr, bool swa)
+{
+	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_FAS_OFFSET;
+}
=20
 /* Error and status bits in the frame annotation status word */
 /* Debug frame, otherwise supposed to be discarded */
--=20
2.14.1
