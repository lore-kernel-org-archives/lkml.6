Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C473DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F280205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vm1YCc6A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F280205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeIBRaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:30:25 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729731AbeIBRaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aIahDZcdtm35Bvvc9YFUGo3+iADJvjvJ5JK8H9pyIk=;
 b=Vm1YCc6A7OoqZCdnUY9jLVqtyeKS43yX9PMsgo7MCWUxjDv+O38AAX01cOp2f1J6Y7TDcLyNFbyu5xxEk+G+qVG2631RrWV01PRFOzc8iXH0o3+qevnqkbmQE0wQwAipQVXvEdI0DD8oeWc5CoxwbBlptYoh1gzxgsLO1wcmbpY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 25/62] ath10k: disable bundle mgmt tx completion
 event support
Thread-Topic: [PATCH AUTOSEL 4.9 25/62] ath10k: disable bundle mgmt tx
 completion event support
Thread-Index: AQHUQr7iLGgyT3I37E2yVIbebMkvXQ==
Date:   Sun, 2 Sep 2018 13:14:31 +0000
Message-ID: <20180902131411.183978-15-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:6ZoMYL3uTtDfxG8YKL6/jJ0prBcA+Ust+BITT+6CYe/3sWxHfeA7e/ScRwQfdFy88VtEMLQiLUDFlRukH0UCXFTHgq3eT+tGlrouK5zgStCs1hPWLTBEObGa8T+/5F7iLPKg9lCHbJunYZaq30/ESYO8BM3cjLmnBwFNovjaRs9RP6lz9/IhAG7iCwhE+XmhR5LqIox8Is5CpvkwBNOSTahMgFRmQFWuMK2Z6Xd572d6hXLq8BS2uGTNWJLpe7RucSDyCWBTPU77yYTVS5UUlocGTszs12v6aPsbEIHYkwxBIIRxEj9zceCF/JfY8YTEGfVmHQEF8ulYS+Vvjx4oUGX9Yw1G9I0pERtxpB6HTP/8mJ9dRcgn+Z49HAPy4Iq8TVsZbUCKS+nxYwoKH/AKLpSFfWl6NT1VpEChJqNqPUPXgbFc/r0Hv5e2p17ZZ2BEFKwrhhhvqQ6OiDCJReA21w==;5:GLZRgvHs3ZhN9C9aAb8S/Ui51E84g4wA77D7LkUM8R1CBl9bYbhSRAJTDcbuHoVyGCaBL1dXkyvMzayl7FQPGnka3VJENYhook8Bv4OY+bwrLoqrfpA9fRPXlNOXhjGjh5XnF3QiwtPUgLYfQohmZqwGA8XUzG+NcnDGcuP8xcI=;7:EBezDLdVlfquv+uD155os5SemngITPAOXtkn9E+ynrzWuLtOztGFYqQAqIaMmNxy2W0HP5b49AzPRJoi+odkrhQUnuDw4lgIPJrzUPN2l+k8TRUEXxk8dQRme8BI7uH2ChHWfJTijfG09d63Z8KkWah2/P2KtjpulfRaR44biRKg7XNx2qBc+Ssc8RmQhZzPsHE/0a192tOm4XmLD975AUIcH+BG3N69xMwgnIXbHFAmaGZrr6JeKsVJW/WOhnSx
x-ms-office365-filtering-correlation-id: 86ea8d74-a380-4997-6527-08d610d6052c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0120104F23919F957681C4AEFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VLMoEOHWl3KKpwPl/02ChxVbBVfxeRAhuLdI0dTnUuFUOzcZ5HQzlim3yAS68yXrxKRdPobWB4Rv7s8x5mKkSybNaL2Bf3NO0S12FT/+sDaTbu47F46ZnEVhISL5+QILh2NInto9e/EsanLqP4TuMqNQ0SPmYW1BWcCMuJR4iYB43wpa9pNrRofcREt0GlEDw1yYMY/7+osu6dcHhHSuxPO51PLh8Q+mqgHCyi7+dUUMUOGukG9QKab0BWMS6p/yvxrySJXEWxyG3NhutYII2tYDpTIZEbOEp6P0k6HGMqW7ZXaTJ90i9vOjvFKGm1qqTyRDXD0oAsTLMFGDHl5RfkM80MGsELyu96yF5vYBSyM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ea8d74-a380-4997-6527-08d610d6052c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:31.3243
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
index 0e4d49adddd0..f69b98f4276b 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1451,6 +1451,11 @@ static struct sk_buff *ath10k_wmi_tlv_op_gen_init(st=
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
index b8aa6000573c..2c94fe370bb8 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1227,6 +1227,11 @@ struct wmi_tlv_resource_config {
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
