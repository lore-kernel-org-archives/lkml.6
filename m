Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683537-2-12047776149467337116
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683536; b=EbEG6nODJcqlidYc5oPcYRMqvpWLOLur4rQ2mBWg5L0MKWj
    T8t9SmYtMT0S2JrEBooxZrzUkM+yDqjDnoZFGxHbaLvf+E4DsuqCv9WU9b0sRa0Q
    FoNbav0S2uxTHP6ugk3xHolF6pxtovs6bYr+guyS5LetAQexbDI0nkvph7ZDw6va
    6gUHtL/ra1ERG5JmUTQ3De7W+HNtmVy7OzTOaxr0IxdftU45iJZ+KEGUYGb431nL
    kJ/5zk0j7CCmF4MQdonqQnqUa3UmBpv+Z0OUPo65p1d7gqSv9T04FOiXSBssgn2p
    yCo/7XyejqwOmHeYR1MLkhfa+2JC9hHWJ3fKhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683536; bh=RwLl4i
    CFLSFHW2Ydm8X23T4pnr+ILjQcfj9nOf7XaLI=; b=ahnPiADyMMlV3nmocEkyBL
    GeBhgEuTbFrf7DvG5VNPd3BUeZK8G7OdwclwbMzoM1+NSFtOJNNJx49AW5QZWShj
    gxceLJqtlAha20glkq7arDT6c89WQG0XAUJ+c+7I5O77i6MNV8mX8v8zaJQNz7Ml
    Lrrp+E6poxVp6lLUUI9qKNiKOlqDwat/IsNGMU8E4zCOldgnP7bpsGoKwQZ7S3Wd
    43poASKhNJbq6c3iBGNOBLvYvSaMV5aC24BN6YvdieQBEUj+Q4j/2coOJYn6fB2o
    CHLoMFsuNjjlBQ1Shk2+GCtrV0j1MhE84LJS+loB4NEoco9zYWAGX7ZEKjKJMcFg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AW7FVa9A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AW7FVa9A x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755252AbeBCSpc (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:45:32 -0500
Received: from mail-by2nam03on0097.outbound.protection.outlook.com ([104.47.42.97]:1354
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752816AbeBCSCk (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:02:40 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 063/110] bnx2x: Improve reliability in case
 of nested PCI errors
Thread-Topic: [PATCH AUTOSEL for 4.14 063/110] bnx2x: Improve reliability in
 case of nested PCI errors
Thread-Index: AQHTnRjx+R5CpkqpjE6CIbsdmneITg==
Date: Sat, 3 Feb 2018 18:00:58 +0000
Message-ID: <20180203180015.29073-63-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;6:4D0U2rbjSFslJVTEe47Nl5+J9mye+9hSiJ+5UaKaISfeytKhUXQKPLJCoFltGsYYpqOlKqBpxe+8KZ/ZPlBPYk5wWzHWdDQh1SdLY9sDOcfqbEal0+mOCG3bKNlyMdz1mfbyNxaM44UHo+v2TYxFW9yfJ0dKJMLnfHDuposH+/Aq5Oq/aMFfaPDiqNkhzYPCHXtQiDCfTPCcrTvE3AQu040iJazUTssVZlVeTVYs3SOFevTwwmx9Eh4V0IdrSAeOmTY7sDmYkA4n6zcVFnXH99kBZ7QuKbsfCO8OWU70M3Ko/9usU69TU3lFaUiRBUh0XHGdtm1YtG4l6oPeHhp7iEkiFe+2CVDZAChX/cy0sjcj9Kbst1BX348PNBdyavvG;5:wV1DrrSyV4vBh7NKER8HDnCMod7oHNoBSbR7g0MOMNZNh9dA5H75RdwA05AEP575KaNNNHPrOx03Gdlj7m+Uz74DrfvfN4CrKztUsVN4V4e9L9/8CD95Hj3pz5aFLTz8KA07AXRr6q0oPqTR/flDGuFq6ZMsHQ7jbnnFUx8bql0=;24:KaNmiA4eRBkpMi/oXsI9Z0LZ/c/PC6CSlD3OX+t0K4LOD6HszCeIQZa7SHE573F8O/kbRKaYFrIoLSC5ihPcwnRTOrrQQA9/HcbTX1pGwvk=;7:JTncwpRecp+Y2EpYZRB9yw+/zoHkz3MTuh7Ocnum0huRXlv+9t1F7f0feFbN2KgKFyg8v8SSeuEcLwb0Bz+tvPEOvZYLLvgiva5VAt/7Fctn4D3dl9KDKuEV/9L1hjYXEpuAkrXxiH4tITshL3RQppafo7V5eptV1VvM3COWHwxr8CDTcBqhPMza64eW9YQlRGmvO30nPDzUV/VSMJNorLE2dGislfbpVzPfOalwNi4S3Xl++sEzpyZNrzxOxp2G
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9220970a-0677-42ad-cf7f-08d56b303b03
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB11055E8807B85B2B1D7C2B6CFBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(190756311086443)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(59450400001)(6486002)(6436002)(106356001)(6506007)(551934003)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 0XnXqmEXOgRgbw9W+IQ9h2x+KpUfR7X3b65yPIZwQ3v6i2EJonqEyie6uXIB2Zvs1znRQdQQ2Ul5zAhwlaBDbQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9220970a-0677-42ad-cf7f-08d56b303b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:58.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>

[ Upstream commit f7084059a9cb9e56a186e1677b1dcffd76c2cd24 ]

While in recovery process of PCI error (called EEH on PowerPC arch),
another PCI transaction could be corrupted causing a situation of
nested PCI errors. Also, this scenario could be reproduced with
error injection mechanisms (for debug purposes).

We observe that in case of nested PCI errors, bnx2x might attempt to
initialize its shmem and cause a kernel crash due to bad addresses
read from MCP. Multiple different stack traces were observed depending
on the point the second PCI error happens.

This patch avoids the crashes by:

 * failing PCI recovery in case of nested errors (since multiple
 PCI errors in a row are not expected to lead to a functional
 adapter anyway), and by,

 * preventing access to adapter FW when MCP is failed (we mark it as
 failed when shmem cannot get initialized properly).

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Acked-by: Shahed Shaikh <Shahed.Shaikh@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/=
ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 1216c1f1e052..6465414dad74 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3030,7 +3030,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
e, bool keep_link)
=20
 	del_timer_sync(&bp->timer);
=20
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |=3D DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3116,7 +3116,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
e, bool keep_link)
 	bp->cnic_loaded =3D false;
=20
 	/* Clear driver version indication in shmem */
-	if (IS_PF(bp))
+	if (IS_PF(bp) && !BP_NOMCP(bp))
 		bnx2x_update_mng_version(bp);
=20
 	/* Check if there are pending parity attentions. If there are - set
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net=
/ethernet/broadcom/bnx2x/bnx2x_main.c
index c12b4d3e946e..e855a271db48 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9578,6 +9578,15 @@ static int bnx2x_init_shmem(struct bnx2x *bp)
=20
 	do {
 		bp->common.shmem_base =3D REG_RD(bp, MISC_REG_SHARED_MEM_ADDR);
+
+		/* If we read all 0xFFs, means we are in PCI error state and
+		 * should bail out to avoid crashes on adapter's FW reads.
+		 */
+		if (bp->common.shmem_base =3D=3D 0xFFFFFFFF) {
+			bp->flags |=3D NO_MCP_FLAG;
+			return -ENODEV;
+		}
+
 		if (bp->common.shmem_base) {
 			val =3D SHMEM_RD(bp, validity_map[BP_PORT(bp)]);
 			if (val & SHR_MEM_VALIDITY_MB)
@@ -14315,7 +14324,10 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct=
 pci_dev *pdev)
 		BNX2X_ERR("IO slot reset --> driver unload\n");
=20
 		/* MCP should have been reset; Need to wait for validity */
-		bnx2x_init_shmem(bp);
+		if (bnx2x_init_shmem(bp)) {
+			rtnl_unlock();
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
=20
 		if (IS_PF(bp) && SHMEM2_HAS(bp, drv_capabilities_flag)) {
 			u32 v;
--=20
2.11.0
