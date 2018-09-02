Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B1AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A239520652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GLn4pehc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A239520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeIBRfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:35:10 -0400
Received: from mail-cys01nam02on0107.outbound.protection.outlook.com ([104.47.37.107]:15264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729771AbeIBRcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V8jMknaatsOYIQ/Yyj87VFZLl2qkLU9t77cBazBD9g=;
 b=GLn4pehcpHKikrDI32eu1c2FqlhUzLu7N9LzFNomPTeSz+eGdzUHKSOESmnRcXpwCxGHl7M+Tglke7eegHYDtdCUbcgwdLzZgeR6xj6b8Ax+7LHSYK+w9KXKbcvoGuhdWXlu8diJ7Ep6NcIwzeD9BgryQArZcHpDGZD/21PSl0A=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:16:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 20/47] ath10k: disable bundle mgmt tx completion
 event support
Thread-Topic: [PATCH AUTOSEL 4.4 20/47] ath10k: disable bundle mgmt tx
 completion event support
Thread-Index: AQHUQr8X8B5VDnmq7kC5X92DNwrbcw==
Date:   Sun, 2 Sep 2018 13:15:59 +0000
Message-ID: <20180902131533.184092-20-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:HKKGmP+U5/JG45zFmJNw21bVL8/9KHq6dLQhfiRCMylKs/t6rHyfy6W34IgjF/p9AIkVeNH8YeoENYQ+wLDHjl0BAvGyWQbpeqg0hynVF9Eb7oqD+LVOOikO5pofJnOiuj1qdgThpdf+Y4Rkyrohb1HT3eIt3tf+g/bS3mM6Qxt7oNJHubk0Ma7phTo4cwY6uvk5yy+a9AEp+ECQUwirfag+npo3DUmwztwAOzxoL4L1MEju25+GfdcubDngilcR5gPwJCWRo+RwutGTd0D/odI35ALB8DtSE+icsZKTI8wO8qFdJ7gXmfPmPlAnxkw+ljwgHgkyNpkWtFseSGCv3rBcU5XkaLd9oq0UiBZWV/QCgr3W8mnSflxOIVvC8uA9+K1Hj/3OaTUm111F68bn/J3Q+KjfD6VjKO2In1tBBGLbDhP5xfTjj44ASfDNd6gxrl3M02vZWsX8pjMCXf4rEA==;5:MZPhKCf1k3LoM1eg4H7H8XA4J5yeRnzpZg/H4TIl8/14iyOV3C0IGtfdO98qnrqm8tCBO4vA4d5Ofvg06fb1jA9efhnmCr7rWmvoq4HftavuOTVrMhZLmYohNsqrMRkmjAUXvjcl0tJmxR5nGQg/zS6dGYkP97AlZHRGCcXtAsM=;7:TpNuZ580k9jvhVz4kkfNRqM0jjXilPyh02AVwg7bPGCOaKqJfu1XZhK2CJYCgZwwmzMgilh5vB+uo2cL+MRVwc2+BOCS/HUyL3RvV3hGKO6b9PBBUbfGHEKm4oAYx20SK+MJqCrCWUS16jqdaMj/QFUusxXidbPiHSIysNVMJRZSskPGB17uye6cU/rzA/i0lcK1c8JrpTmqtjlLvsKZK/o9+fTJk2y2lgO84jG/mSWetsvVg/bxvlmL8b1QcAdG
x-ms-office365-filtering-correlation-id: 8fbee957-8ebb-4e14-cf55-08d610d647c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB062987052A23192BB06D2CDAFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(8676002)(478600001)(10090500001)(14454004)(10290500003)(72206003)(476003)(5660300001)(5250100002)(106356001)(110136005)(54906003)(316002)(105586002)(86612001)(102836004)(14444005)(26005)(256004)(6506007)(2616005)(6116002)(217873002)(305945005)(446003)(1076002)(3846002)(2906002)(11346002)(97736004)(6346003)(81166006)(81156014)(7736002)(6436002)(66066001)(25786009)(86362001)(4326008)(186003)(53936002)(8936002)(6486002)(22452003)(6512007)(99286004)(2501003)(36756003)(68736007)(6666003)(2900100001)(486006)(107886003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: cAKK0fbCfMaBTmqhHNs3gSiJuHLaX/OmNVSqfwiBsAq7gwhSk5TYGZu+xA9tHYNT9+wLzUrH9Qywqz4IHraU4I2ecdRwJRMliJgIDYJdlMchFpsRPsW9MFIJXKhkMcyNF1vlX1cjPc/+s1g0qmjnmpS5b3+NsfIZ8C00BpphoAxi7ssXSwC36nLht+9zu6vXVAsmFMHvzNMxLzB7qp2mQBDYXEZPBZLQevtujgaF+mDb8xvm1vyNV9s1KAV9nyUY+te/Lz4MF1whQK9WJ9kpftnPVFZwJEGfEb7e05iaXKYzc1P0hauJqncOawOS37MjIL2aRwCkuWOE6In1Zo9FWRYoBqfMN9lk2wMBb4od+dk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbee957-8ebb-4e14-cf55-08d610d647c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:59.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 02eea3c3b5d3..c72eb4464de9 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1424,6 +1424,11 @@ static struct sk_buff *ath10k_wmi_tlv_op_gen_init(st=
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
index ad655c44afdb..f5031f3965c5 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1209,6 +1209,11 @@ struct wmi_tlv_resource_config {
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
