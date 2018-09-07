Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C88C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723C720844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j61gzMLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723C720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeIGFOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:23 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728583AbeIGFOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPGyEk8LKE89Xs4GjH2SY7yzd/MMKpFUTZfnArkMxoI=;
 b=j61gzMLnt5zr+9EwT+1DearzawkxT1waqavhR2LeBnewsg7hfJwwEBBtbIQJIS6n5uwQDxPc4Rm9h8JOpwKwvzDcSkg9nFIE29rwWNm5fcvhH9NK896CHcDQUCIOShjAYBc2APY1s84/TDvBTpAqbqcAeEGqO8EsuuKXVtr594U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 10/88] ALSA: usb-audio: Fix multiple definitions
 in AU0828_DEVICE() macro
Thread-Topic: [PATCH AUTOSEL 4.18 10/88] ALSA: usb-audio: Fix multiple
 definitions in AU0828_DEVICE() macro
Thread-Index: AQHURkK/ST/IOpLHOUmfEtI6/mFipw==
Date:   Fri, 7 Sep 2018 00:36:00 +0000
Message-ID: <20180907003547.57567-10-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:A2XY469z516tmnDqF21FJCV0FvFqqdEi0bdFcdLJsb3Cz+U0ZMlfIXbxbrcNet2WnugIp9VBOreCRdiiJo5NwbFkkDJ9uoyRQyMOfYCi9oYWUwTUyaIqqYPaceETzSkXC7CzscCBaq4u5h3Cs2LdW3gBmsz/yX589gm/oWMJVnipw6onddVsMwcCwGWSPm4k14+K2BjMcpqCNnbZwvcM+fnzLP58u/nq/3/LursnQofGLgHdNmMQyRUKfpNliScfabzvmcM/rdFTPwsiRTTQktSy17zes9bPgwuFddhR5xeMpiM6TGdT/PK3q2eNbJrrdaohTJRJ+lU//TMPJeROhzkSqGTfG9H/ajkcqO660u0fw6Y6ovjDXfY/CzVEIvhZZkbgaXT0IpaBMFYyue8zhWsrYaj6hpLpOI+MfLYzv1uv5vkNebJlHucm5QZbVI7dAxiNI1ivIK2MQy9pwuXSUQ==;5:fsJcKEn5HVc6S47zWEm/bW7P572DRQJ2EYu05drHcBOn72PMjKDjxRo2b9rP+ceStj1fP4njSvp8Z0Zo6O/dnSvykmRctKElJlG59vQO9ggQk+SDD3nb6dH81A8MEgLycoVssZA5PY5VQhprBpfAV2H7XaqhPvupdhxCPquahMw=;7:Cc/Gtc9EJuSMuq+cVdZkJXV4S4dzELCg0aGivM8wzo1s3v9fJURQZlC+4dsvNwKZLRFBe0EgJj8FV39m7MnW8tjxeCMUxwfXbMSoqBIl9Up4oADd0qlHFGra+hgzONBD5J6YY3wdg3weG1TQLSqKEr4U/hIUn2J8aD2kHDNDvK7KWu3JHuHODRvAItoEPR+8JWH7AZBpZesKNl55ZwFNt26iHJGYUJwG+tI27upkOGM0q600clmqFHcz+LQZiT5m
x-ms-office365-filtering-correlation-id: 388a52da-5206-4306-ff22-08d61459e282
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07737444330D70287DABB104FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(14444005)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Lr10ErfiswEjDIz7OHLjZyWLvXCRGvkYpcTn5Amllsoug+eMIx6rP0b+zZGy5cCUHY6dw7A8nBOn80XYntwWBfAPPU9lVZRT3dbtoI8qkckuhKZZfcujaNlvWNv+O57W1n6GfLG9ZwkmIT0IosgCy7QEX8qcb6tjc2kK8ZonO2tI/6w5HMziqXVb5YVpHUlkIai/eWBqL0OAW1gouDe/8xofB/aQk6v/ASrk7FVuWKNHagf2KPUfILztTX14FyMOhrsKyyts/x0mD9NaXpJoBt69mM3LAF+Wr6L9I3OZwfAVWWVeLyWCLLtyvTVPRJTo7QniLipp4/D6ur5l8gJdo5CTpfl9ksFCREIQJ2oYhSY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388a52da-5206-4306-ff22-08d61459e282
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:00.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit bd1cd0eb2ce9141100628d476ead4de485501b29 ]

AU0828_DEVICE() macro in quirks-table.h uses USB_DEVICE_VENDOR_SPEC()
for expanding idVendor and idProduct fields.  However, the latter
macro adds also match_flags and bInterfaceClass, which are different
from the values AU0828_DEVICE() macro sets after that.

For fixing them, just expand idVendor and idProduct fields manually in
AU0828_DEVICE().

This fixes sparse warnings like:
  sound/usb/quirks-table.h:2892:1: warning: Initializer entry defined twice

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/usb/quirks-table.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 8aac48f9c322..08aa78007020 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2875,7 +2875,8 @@ YAMAHA_DEVICE(0x7010, "UB99"),
  */
=20
 #define AU0828_DEVICE(vid, pid, vname, pname) { \
-	USB_DEVICE_VENDOR_SPEC(vid, pid), \
+	.idVendor =3D vid, \
+	.idProduct =3D pid, \
 	.match_flags =3D USB_DEVICE_ID_MATCH_DEVICE | \
 		       USB_DEVICE_ID_MATCH_INT_CLASS | \
 		       USB_DEVICE_ID_MATCH_INT_SUBCLASS, \
--=20
2.17.1
