Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB79AECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFC620866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PDaxHoXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFC620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeIOHEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:04:05 -0400
Received: from mail-dm3nam03on0137.outbound.protection.outlook.com ([104.47.41.137]:63496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728797AbeIOGsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iBoeh1TnmqdXpfYEw9HW0XXCxUiQ6sIDJ78oor1yU8=;
 b=PDaxHoXgpjsG3nzAHKnjA/jEtbo4GpDFs/VOGZjHVE8yO+JRm3nE95v/AAIijqKe7KD45E8y3rPtDskSBeIh3Vl9rd/vhiujaCI1p0wYuq3hDVgQ6CgPWX4GJOrW49pZr4nBBWjWVMInEwTv8gbAOb2ytP4apQwY69AXtAqfRMc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:31:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 84/92] IB/nes: Fix a compiler warning
Thread-Topic: [PATCH AUTOSEL 4.18 84/92] IB/nes: Fix a compiler warning
Thread-Index: AQHUTJO7A/kr5pCgEUSzFwgHvDjPrw==
Date:   Sat, 15 Sep 2018 01:30:49 +0000
Message-ID: <20180915012944.179481-83-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:BzHNP7gjDtBHjUmg/xWFdQvmIF9idvqXiSJkZ/LyVfsEsvUt+thAl0YbxYt9GcfpjJSM2OlnVWXMPh1Vwa4enW/ARVoXMMNDLDzl1F8ii3FzA7RYBXbnMnYPqlybL7JV4DtKU7bu+ro8jYFeO+CTCuZwgepOU6WE4m6484xSEkvmOG4+69Kv0UoFZDZySu0Kk4497v2SfoPCwj8ppW8hnnFVt/Ek6IdZjKC29VnpAoDAD6SuvSSJXw7EcNrL65nFjq8ytGz0fIShdD3EG1BFS8xSLR9bjRvETvph46Rhk+OMx0Jx66jp5WOOYqhOSjMphWh231Nodind9naV/uTyfkKbEZr15MpxU06jKRnCD0PXVNJ7NhkY++vlNrkWUrFi4XzDK8ObebQdIkH80PDjudMyR00zwScPcwHpxzozUlG5kDM2/MOSBZk40YT64X4J/3vR/IbnYG5vJUx5agxqug==;5:rHMIbJGkmYWca8wsZp8cawmvM1n96zkkJL4NdzVwxXNg+FhjfOonzlneJNNrQCb69VRSD5gv25ioM4+vnZmeiXdirvIJsL4bW+lA3qrIyv9YcLURTeifaWnEccnHV/IO562KsNyUzT47ch1qJ8+ZrrdS2uQ8NkOq+0/oh0BND4A=;7:WQjYdXSITS34AXG8pVXqNyplBI8iCsXTO8oEgJpHsuuM8WMufsZ66Y+iAoRE2ugM/JqGr2MUFUN3XhOwTANiYjSs4DxVJnIp2K0+WNtjvdHpPo2bN+4tY1uTgzYiBsFzDy1eyQYXQUg7+2lvWow8ELvVW+Rj4wb3rheZsa8R+LlQpYWmOYbwO+esr0V4/cdHeZI77FH8xXmjMkhvjUaftY+xMiObML5bZp5lJe5Q4DdqBekgW6qGvtxZvHghUM7M
x-ms-office365-filtering-correlation-id: b7b6bf7b-8923-4867-718a-08d61aaafcac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117CAD4E80B8A49865744C0FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0FdJxsBM2iiwtN0tioFxLwAh+5jBS+xUa3wPG3FvpGMwz+P+zh2DxI4eBQs9uirc3urbH85XUZEWrDFZ1RK/AgvEqt/MueCsqRR58X6ju3eFPpCmEA07Z69bAQ0VD8CmpJAUNT6/XLFKPNLmzXQGhOL4VscF2LbIttYeep2F764B0ai1XXQS8zceqYIiN+vnZrj5HojPm05CBfMbon2sXKi9+szr6xytBi+uWxuXxZkOcvxjRlGj2wcF+u7GxdnOoaJ9H1hCNMrEOLJlyYbETSPW5gegXKhktXASzlt0txEdLZ0+37BYeC5CPStrzI1Ylc17txzBblcirEiWDSltH0/lISl5Y2wUlytKKoUVQ5c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b6bf7b-8923-4867-718a-08d61aaafcac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:49.6979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit 4c5743bc4fe3233cecc1c184a773c79c8ee45bbe ]

Avoid that the following compiler warning is reported when building with
W=3D1:

drivers/infiniband/hw/nes/nes_hw.c:646:51: warning: suggest braces around e=
mpty body in an 'if' statement [-Wempty-body]

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/nes/nes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/ne=
s.h
index 00c27291dc26..18340942d75f 100644
--- a/drivers/infiniband/hw/nes/nes.h
+++ b/drivers/infiniband/hw/nes/nes.h
@@ -159,7 +159,7 @@ do { \
=20
 #define NES_EVENT_TIMEOUT   1200000
 #else
-#define nes_debug(level, fmt, args...)
+#define nes_debug(level, fmt, args...) do {} while (0)
 #define assert(expr)          do {} while (0)
=20
 #define NES_EVENT_TIMEOUT   100000
--=20
2.17.1
