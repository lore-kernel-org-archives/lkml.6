Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5522077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CQB+4b+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5522077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeIBRrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:47:51 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728336AbeIBRUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qveBxxdGKZd3HjBgurXoUok/b3M2OPxwDHuP0E4DKOw=;
 b=CQB+4b+vN+BetPGZiJ10lgSqWvXxegh70slNxzoCZjWlEnv/YHfjDyEXRsd3L9r+bcgzsccxfzCnYbXe+guAvGl7Xn5BtCwZwwprKdvI56KxDmzITY6RO8XM9QB6OgksJbbG2+UewDAj9WY/VjtFl59yyQHxzuzt2+QNmpDsLB8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 066/131] ath10k: disable bundle mgmt tx
 completion event support
Thread-Topic: [PATCH AUTOSEL 4.18 066/131] ath10k: disable bundle mgmt tx
 completion event support
Thread-Index: AQHUQr14qsDJLJyasEGA6I9Dl194NA==
Date:   Sun, 2 Sep 2018 13:04:24 +0000
Message-ID: <20180902064601.183036-66-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:rcRTUsxvXa5WQnEwbJzpmGw4DsskFZ9qiD0U7v4xo6ZLk+lctuul1JV9zqCM62NOFebRcVZOCSDlppNbzjv+XWmM9Qf9QqO4MGubc2i6zoHN84tbG/6/9No7fe05kjbEEXlbRUMvFJf1BB90WVCLK2Vu4rEY+dhnjCxFCPwfKlSS2a7w4zCcK/OGrrTg7L5ogmq4nVI/CH+hL/dUboF8d09H8TCMCM2fO1oEgRkv0Bm8sVC0R1Y/WvxUr8fFt2UrbHCM1x35qrTbkNq3JseEMwqAXF6nSYnXCISoP1nag8N12TE1+LPc+AHgDS7pdOhaBAX2xpYdYLntyCi7QSCeluDUJuF9Kff7nmC8mLXfgvrhpqmcakBUXT57GrqJp3Bmm/oJ2B1xGcO2GYp56QsQaOAz+MmBH7zm8n5UOkjrKCP5s+nNH1bYuhlLLdIWQAQjZLTDKROpV9Gu+yTlAtKAzg==;5:522za91XKm0FXJpxFYOmLQFy+L/melNwRlPMi34lcVgpPPeeP+TkCIKv0jSU00407W1F9HMBGAPDVz2Bw0SRS90uS9q3RAgmMqt4ZkLRROFH5Odfi311JItV/mY3tuxCdWsqnL4IihZtaWsdFHVmbQgLLsh1hLNSRBCPcuLyDHY=;7:8fA8o9D+RevnhEq4iB+XNjV+4Tm09T4JukTAXoPz5LyEkUHrNu8JF2zzpj6KBPXoo/6gMXsgIXdEHtj36X+bWk0uz4C+q6kBow0awM1tnKoAd707k5g50d5Dm4hjoszSf4y54HIX+wTQhMO6UCNx9ay/dd067s2o7rwD36WFhVI3n8EnDFd4TiufwAP7/42G7zN8mGhX7xS25VZXqKxScl/CSF8fhAQudn6I5rQOSHyNht3vd/pN+T5GTRtxiWN7
x-ms-office365-filtering-correlation-id: d51f0262-bc67-43fe-eca5-08d610d4ab2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120C460CF25AC99E4BECBB3FB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QKFQE7E2CwadeHp83ADhyz6Qtn/rUaF2LIH7oZ3wceipyr3zjlG67DZwN4H5XnFqZHPzYuWjQdKFfzdiOzLY8T9yIJmy4sH9b4G+8jPjoNDkv3YU2ktY7RAzOH0/pHxFpG7p83lEWmYcQUea3qxlv3g7PLDOfuU7dgFdIUov9zVJPdd5GW29rA4sEg2GiqQ+7b0ZTljsw03GB65J4uqAWoIl7LIxCXay+iHLACa9t7jqiOsOgbe1F6p+TRZo+HoX5XsomD195yM7Qn3uGMH2VST4TPTxUcg/gpRUQeiSGkCE58Vt+Ry6ExL8t/7XhTIrMJ46hQLKa4jp+MmB2UN+J2LtaWSFRG/gQCgtN/uUzLU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51f0262-bc67-43fe-eca5-08d610d4ab2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:24.5320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Surabhi Vishnoi <svishnoi@codeaurora.org>

[ Upstream commit 673bc519c55843c68c3aecff71a4101e79d28d2b ]

The tx completion of multiple mgmt frames can be bundled
in a single event and sent by the firmware to host, if this
capability is not disabled explicitly by the host. If the host
cannot handle the bundled mgmt tx completion, this capability
support needs to be disabled in the wmi init cmd, sent to the firmware.

Add the host capability indication flag in the wmi ready command,
to let firmware know the features supported by the host driver.
This field is ignored if it is not supported by firmware.

Set the host capability indication flag(i.e. host_capab) to zero,
for disabling the support of bundle mgmt tx completion. This will
indicate the firmware to send completion event for every mgmt tx
completion, instead of bundling them together and sending in a single
event.

Tested HW: WCN3990
Tested FW: WLAN.HL.2.0-01188-QCAHLSWMTPLZ-1

Signed-off-by: Surabhi Vishnoi <svishnoi@codeaurora.org>
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 5 +++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wirele=
ss/ath/ath10k/wmi-tlv.c
index 8c49a26fc571..21eb3a598a86 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1584,6 +1584,11 @@ static struct sk_buff *ath10k_wmi_tlv_op_gen_init(st=
ruct ath10k *ar)
 	cfg->keep_alive_pattern_size =3D __cpu_to_le32(0);
 	cfg->max_tdls_concurrent_sleep_sta =3D __cpu_to_le32(1);
 	cfg->max_tdls_concurrent_buffer_sta =3D __cpu_to_le32(1);
+	cfg->wmi_send_separate =3D __cpu_to_le32(0);
+	cfg->num_ocb_vdevs =3D __cpu_to_le32(0);
+	cfg->num_ocb_channels =3D __cpu_to_le32(0);
+	cfg->num_ocb_schedules =3D __cpu_to_le32(0);
+	cfg->host_capab =3D __cpu_to_le32(0);
=20
 	ath10k_wmi_put_host_mem_chunks(ar, chunks);
=20
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wirele=
ss/ath/ath10k/wmi-tlv.h
index 3e1e340cd834..1cb93d09b8a9 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1670,6 +1670,11 @@ struct wmi_tlv_resource_config {
 	__le32 keep_alive_pattern_size;
 	__le32 max_tdls_concurrent_sleep_sta;
 	__le32 max_tdls_concurrent_buffer_sta;
+	__le32 wmi_send_separate;
+	__le32 num_ocb_vdevs;
+	__le32 num_ocb_channels;
+	__le32 num_ocb_schedules;
+	__le32 host_capab;
 } __packed;
=20
 struct wmi_tlv_init_cmd {
--=20
2.17.1
