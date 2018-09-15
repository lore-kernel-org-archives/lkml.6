Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4099ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABED621476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZhYVxTwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABED621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIOGqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:46:51 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:36298
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbeIOGqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9GmMH9oABKiut4Dw0WnVj1FnJJOHRuP1YHuffJyzgA=;
 b=ZhYVxTwH5qtxHBNQOLBBeJQJntjYyikMq3Qjt1ri9w4vwxbfPFEyKoA1G1Se5KeMFO5MxaK5W3BnnIL+Cb6EI+aATr/RdNTdCGWjxAtBBDYFUOTmOoAA7/gfevLSxc+LxJWvYWelAbRvLg5aUFIUXmz/5Du9bkaN1iPPVUKBJAI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Sat, 15 Sep 2018 01:29:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:29:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Noa Osherovich <noaos@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 02/92] net/mlx5: Add missing SET_DRIVER_VERSION
 command translation
Thread-Topic: [PATCH AUTOSEL 4.18 02/92] net/mlx5: Add missing
 SET_DRIVER_VERSION command translation
Thread-Index: AQHUTJOX5I5OsDFTiU2u7oMG1PbDIw==
Date:   Sat, 15 Sep 2018 01:29:49 +0000
Message-ID: <20180915012944.179481-2-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:PYpyCspNVL2atK+qE05lE8FtC9+joQFcQH0vlWS9kpyMG+qluexK4MbMjuS+DbhnG1ioskAQ593pO+6Nf7M+XJFhFX97vMBcd/wAeqqIk8x3Kj8BkGN7WaaCuXgQV+FBymBo5ti/vxwCm0/E1vI/WkzRCAVbVBSdZs3xlaQOEXyk75ApLUmmyodJqtaDkgZS3U5b8gp03RJNhJvdNwNjsv6od0Veuq54NFRHPAkUBUcmGINvqbTSVPO0KpbqjKaIuz1X90znQQV/iJ4CpwJegxB7u7ezpWtOstQEM6/PHRHMrK6WYXU98rPduBvETYnmF5cGUvP3wfBmmgb9IuAAe7WY2sRLBCyqkgXOn6Lw71h9ENOhn9awlZ/AlNSPcOMS8L3btwHVXaBuT82rlI2gTbPoYsa/HsMhx24+VtWlclZXUnIoj2k/iuktk/97Lpex5/rVruW7l+WVbH/QX+BMyw==;5:4eejNfcIFj4iSR0VmoDgVAP6agEEmtmtZlyjTXBj9gO7le4b7FyhcwbSi83YKtDuP5gnT87pTWGGKHxAYQpSxG0xg2T8idHDTR8vXpY3OtCB8h5tm/70PXwNHTiIdmezuDhW26PKKlqXV8rh+Q074uytzso9vHuNbWu/td/p3eI=;7:HqTmDSYK+H4LrKiBtZBniZ6pa3XqQv3Ssn660xlkP8RK9zmbsEWnNguFbecVQ5h+JgD2+ag0yzC/3VCmOOaV2l47VsJgnDMHKU9B/yLWwOCfp0UgDOxw9YT+WtCvT2tnggCweoAO7pNqhdY7QBpOhmZC+hJtnBACsqrr+w9sqLdWcTx1+EDLkoFbZgGIAVksvuplCIBi9TYJgI50Nq4HfM/1pZCcjSDjBEnRXhuP7llcl+jiLEea557EAkjZnkN6
x-ms-office365-filtering-correlation-id: b71ced6a-097e-49d9-b999-08d61aaaba61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840DC51C51F9AC7D9043B43FB180@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(6116002)(81166006)(2906002)(446003)(478600001)(3846002)(8676002)(106356001)(105586002)(10090500001)(22452003)(8936002)(486006)(2616005)(72206003)(36756003)(11346002)(81156014)(186003)(26005)(14454004)(6506007)(217873002)(4326008)(25786009)(256004)(107886003)(102836004)(6346003)(476003)(1076002)(10290500003)(86362001)(66066001)(6436002)(6486002)(86612001)(53936002)(54906003)(2900100001)(97736004)(7736002)(6512007)(305945005)(76176011)(99286004)(2501003)(5660300001)(316002)(110136005)(5250100002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ENoVK0LWHNM5lDKqw484t26v5eyOGSnZ9AifjayA27rV23OWiPGJ9wbvJjUFwX41EizdHP1U4fTSsW7YT8ohRqZS4+58o3Ra5uKkeqDAfysXQVYIfnq/WqHTaiaXOSrsWe2a9VbequYaPICpX86n80Xw7b5EUP4l7GiGSDeSjmUE89/Kowt/Ic0dffHQRqU548br97LX7gEIdqMp6RRefD6uz6niKizfPioOKQUkx+KFc5auye9KVI9AwBYjYIxpSiwKuzQ+gHx7+17RBU3VKaXFpkyYf4khvUh8F6U199qomHEUw4mHy10ANscwNnbh+6Y7+/7xFManWHvUo0oWs+ng326EmF4GbY5hzaW4xsc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71ced6a-097e-49d9-b999-08d61aaaba61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:29:49.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noa Osherovich <noaos@mellanox.com>

[ Upstream commit 0f4039104ee61e14ac4771a2181c2a20572f4ec9 ]

When translating command opcodes to a string, SET_DRIVER_VERSION
command was missing.

Fixes: 42ca502e179d0 ('net/mlx5_core: Use a macro in mlx5_command_str()')
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/et=
hernet/mellanox/mlx5/core/cmd.c
index 384c1fa49081..f167f4eec3ff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -452,6 +452,7 @@ const char *mlx5_command_str(int command)
 	MLX5_COMMAND_STR_CASE(SET_HCA_CAP);
 	MLX5_COMMAND_STR_CASE(QUERY_ISSI);
 	MLX5_COMMAND_STR_CASE(SET_ISSI);
+	MLX5_COMMAND_STR_CASE(SET_DRIVER_VERSION);
 	MLX5_COMMAND_STR_CASE(CREATE_MKEY);
 	MLX5_COMMAND_STR_CASE(QUERY_MKEY);
 	MLX5_COMMAND_STR_CASE(DESTROY_MKEY);
--=20
2.17.1
