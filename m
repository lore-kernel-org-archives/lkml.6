Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738F5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1626220652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VKAxPCxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1626220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbeIBRdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:33:39 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729340AbeIBRc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/syL/sL8H8qmwlFTlLi6vDTU9NVmDBut+MrcwxKmCw=;
 b=VKAxPCxKlSaFlGMXh7x5pDHF8WT84xtu4F+wWDK8PNhdl9Z4+XZyVIJziUQ0YTn9VWvFd0HZrKRWt7TU7OnzjLeOs5DcrQMKyA+7MIztiSy0oyOs/uy9iIwg9QmLQF/1tC4zX5v/PdikDEGszwwIO7+P9GP9TCPr6rXo015cdEg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:30 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:30 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 37/47] ALSA: riptide: Properly endian notations
Thread-Topic: [PATCH AUTOSEL 4.4 37/47] ALSA: riptide: Properly endian
 notations
Thread-Index: AQHUQr8l3xmJvN6uE0WpZmBBKHlNnA==
Date:   Sun, 2 Sep 2018 13:16:24 +0000
Message-ID: <20180902131533.184092-37-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:abeASDs1fcFTEuTdmC1ASYNKKDEYk7qLu1E/AAz9Pp8cjbDnGHzqEGRrZ1EBs+BS7gtfyTfJJqvjXdsfqbKRPvqAIuEI7E3XMm+utW7ZhrywRPbMKfgB/44mEdLA60FLZz4C5u1/yh7kfOy6GJUi6N7ZzDUNZAcRmKUbPyBWlKRM/NckhnfcQylfxx+erIUad7roWfAzaQTPc5K4PTrH7B6RfiBUurnZF2ZT3bzJQixVB5x8xkfOepa0/xHJAcXmuZolKNTw0h06tTVPKsZyuaNVN13v/xdIVIt3D/jET1B2yC6db6XnmXb5Z9LqbeINpfWe6xZv7gEwJDWJ354nhzGpfd2Wq5Gv4Yr6WGCCoc6xcjGijl5yAu3UXi3HSNBfRvJ0vJAo557IVLervguNTPruKb2NKUFWsf2MPde18PknxxMzQNqwf+fK0gUoF0XkMZNB7zgz+bN43dzYAdNzSg==;5:4o/LxWOqb6QKoG/hsjLRF2i8WVnKreqrUx0yUBXRj2TGgK1eLsEqAErwxlB98ByQnegXaxYTdvSOaN+GN7G5tFnS5KdboqScITk14jqRWbTsjA15mYFyGLJnaWMj/m0nQ4hIsIxjqLxtA9hqJs35+nxLNAXWHfL00MWrJ9c+t4g=;7:reNcZOFtOpybR9JT3Covg1XQdtF2SWD+5l1mrDzabjkblV5f+bWBWcr/ldZAXCHi2qaavPbcjPFAB7g1Vc4H34iXNLJrWsOP64IxRPqG/ACMpY4tBjKEIUrx1Su/XUajUp9p0emL2NJ55KNvtG4GVuSVGcuxoU1uxM9ckGun3ZBxXWpI4fJAMBl1wttkTR3owvhKfiYy1US2adkKKw5SW8wLBH/IfrTHaP2/4wpIXpd0jhNHLeJbIw4xKe9hGrHG
x-ms-office365-filtering-correlation-id: 1f6d31aa-5702-4913-ecf0-08d610d64c01
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167A42507D543DAD45140CEFB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(86362001)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ZH3xLMec3dWeNHv0bNehi2rAPJ7MTTBsxJlI8SQ5QI8B1JuBUNgr6PXellBjuiR/SORfU4kv/Nt5KNGEzRxiySr7zodzwa4NAgkdXRlTVZcPqnfwh/XhOQhAip7yDfqYfbwKJBiX3zBdiaRjiLZv2GS7iIgotMwhBxy0/qKbT46E7zauv2T1YjljwNL+cVvlFjVtc0fg+1xJr5JnxoWDzHH8TTeyeAdMkLztSi6qFQiZhB3zLzlAhGGFimyNcuTql4LlRuZQwoqHaGMzY5hEIWWuFKGJg3njeS3wEGUgYIcXTYqy1sHmvgKDd5AlZlY8VQDrou9ZB8FG4aXa9PDkTqyWQN6ad9AH/W7Fgcu0xT0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6d31aa-5702-4913-ecf0-08d610d64c01
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:24.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit be05e3de3a933156d472127f659d4473c461dcc5 ]

The SG descriptor of Riptide contains the little-endian values, hence
we need to define with __le32 properly.  This fixes sparse warnings
like:
  sound/pci/riptide/riptide.c:1112:40: warning: cast to restricted __le32

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/pci/riptide/riptide.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 94639d6b5fb5..38c01cc061a0 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -470,10 +470,10 @@ struct snd_riptide {
 };
=20
 struct sgd {			/* scatter gather desriptor */
-	u32 dwNextLink;
-	u32 dwSegPtrPhys;
-	u32 dwSegLen;
-	u32 dwStat_Ctl;
+	__le32 dwNextLink;
+	__le32 dwSegPtrPhys;
+	__le32 dwSegLen;
+	__le32 dwStat_Ctl;
 };
=20
 struct pcmhw {			/* pcm descriptor */
--=20
2.17.1
