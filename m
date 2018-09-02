Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4538EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E9A205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lvQJODUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E9A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbeIBRXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:10 -0400
Received: from mail-sn1nam02on0115.outbound.protection.outlook.com ([104.47.36.115]:45032
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728145AbeIBRXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OZuQ32sHckbJuoP1daJWmunMnxyHxG9zcKiS3jlXRU=;
 b=lvQJODUPNuw4lkM8H6ErnRpgOT6BsShGuytjTZOyLMpu3iONsPOk5g/fsO9YtJ70ySEFxR3iXpnN5su3mSVg58PxjrFLoS6gtm5HFP2m0+eTkL+dGObfXpRtT8FJwCDM10bOTtssFYKDrG+y2V2QodgtbwR/KD1q4VIZGB9cMpA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Surabhi Vishnoi <svishnoi@codeaurora.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 45/89] ath10k: disable bundle mgmt tx completion
 event support
Thread-Topic: [PATCH AUTOSEL 4.14 45/89] ath10k: disable bundle mgmt tx
 completion event support
Thread-Index: AQHUQr3WID1Kh8eH+kySgJKJ4R9RvA==
Date:   Sun, 2 Sep 2018 13:07:01 +0000
Message-ID: <20180902064918.183387-45-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:pYb9W14QFt8W9DAM5uw7p7Zad8lQk5iIDO+vyYytU3mH4W2LX1hhI/044jK62ws+Bm7JN1eQ4yzPErnKNglkreOglYYdSxjRfo+lMs/w5ZSnqbhvga/9Ys0hDkoKRA3Zy3pY01nhgkjTVGEsT/McefBh7f233z1Vt0e6T3S+4/r0IDn/TNDa9MJCY3iSL31lSJRFS7SjXGxkq5Zs6MGWGo5L0rsvjN8mVIz39K7iNYSjWajoVvUXqKgRJ1G1GFsHbUiOuW3R2fHUat3uk5mX/cW4xN5j2lENT54z9ODfR1R0Q5/Ra+2aGtxr57qMIgaTHNf5t0vxef+vYnZVjn8g4Uw+dmwsLcOJaSRlYfb6WJhzy9Z58lnhoP1IIZRd0QDaGTssIkHBe6JImSbENHN6kVK/SJgtvUwMhWA36965I1RPUzA3glAcwg2mVqEwP3GdPjPS/zwCYmDEotQ+S5gBxQ==;5:iAaGO4RppZqmYSnGdbBCg7xI8ES0VPgNt8R8S2dn2DSEvKcDgq6oDuL9IRWX3T5E6+xvm55SpJuVR4JlAzJ12j5272TI9w+zPukLNIepcRzaIRiObssVqZt1aSuaBMReaYGpEXz8SmXaP0vwhLO5iGfls5rxLdYNx4T6CAxbVJs=;7:9B72WaxwVKc3rvt3gcVGGjp0CuHkTXpAJ+PCa2fre+EZsxEwaii1o5TY7updZHVeRdB8eT61Eki4L9GDHbPA/aR8QklbGO8FUjjZZlEWL4QPKfh5dNHNaNEjx+Jn5EORGnTUCpAHnX9N4CfD8v2FLY2UljGpMhWdTES4WoTsNnIZUAaBcz0jaq1Ef5RyhsnnCj8INlabRVsrr8wLo5JnShlLt2Gyk+RXcOnzzruHQemmhiGtWJphg0hpYkmuUbOW
x-ms-office365-filtering-correlation-id: 15c49d80-1afe-40e5-b624-08d610d4ff95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB050354CC112B88E7A8DD06F5FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(575784001)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2IwMMduHYBxWbR5doCbelActfNBbVN1jMnsiqxEhKWRcUBscUsaeg5GeaLcOWfycJvMAtBeEgDMlDxtoHakEnGffK6qaEYTCQfcA1T5SP/VVgrrti7sXI6uCM919q+oT0XlKA03WqzwQqxG0tSn5CEp9+xGXFupAw3pgG5PYIfhB24U6XXu7IZk8RxmbILeHsMLiOzuihgvozuXVdlWy5x88j+NrBGJjKwd5/Kp+H8WCXYmQ3aaoVqTnCfG3Vv+3RiFW+lfgpb5GtnKMLikc9lun7E1vI4pj3djY6IhDFKmRxhHGhd7nwCyR056K+x17lidykSFBuDu5RoSKC59vfPxm9FM8c08OPEkYv+YBUMs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c49d80-1afe-40e5-b624-08d610d4ff95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:01.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
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
index 7616c1c4bbd3..baec856af90f 100644
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
index 22cf011e839a..e75bba0bbf67 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -1228,6 +1228,11 @@ struct wmi_tlv_resource_config {
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
