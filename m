Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84179ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313B2208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D+MglnhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313B2208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeIOGtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:31 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728374AbeIOGt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/C/m5kpwbaNgPGRW2fuejXcOyuPEen3be1IuF1bLaw4=;
 b=D+MglnhLuGcLsDUFQT+5AuLZv+Uk/fdwx/7uUK3c6SFwAllynHML/slrk29f/Zv7+k66WyQ9VsOh19mdc7SzdQzOo4fioIYxNRgqca7I0LsXtYmSVP4eYilhRfpm4sBddZ9NOea0wyGQV1o+OzIuz826G2nPpLUx+7Rp6Obz2jE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Noa Osherovich <noaos@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 02/57] net/mlx5: Add missing SET_DRIVER_VERSION
 command translation
Thread-Topic: [PATCH AUTOSEL 4.14 02/57] net/mlx5: Add missing
 SET_DRIVER_VERSION command translation
Thread-Index: AQHUTJP2AfpPRwWB6kySk8h5i+s5Mw==
Date:   Sat, 15 Sep 2018 01:32:27 +0000
Message-ID: <20180915013223.179909-2-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:W2eIyYou5LqLfwjxatkkVi9GQthy0pv6B5BZ9+J3K5UhrDmJ18/UAbt70F6iCjBWJmHHae0I3vAEVIc2V0VFzmH3ULIqyphtan8s99keu/97yiqY3QPje09AfSvUtgAY2v9M0KAEBi2GEar05+FpL7y3LU/+k7DRjYwqQsiqMHjIQDyuOAcEZLhmEWQhbwf2yIWry8sygSpXIc3m0QL6XV+Q3FDD7xzGaLQjE3sVlrSixYtteMlncDcMVDz5kLmlOOPAt+iFH6F1gq5R4XYzFSIt+djXoK+nI8eC4JUYKV/b4Tb/DuVQVCwEohts99EjgOW2H4m7L2Mt756Btzq6eCEDwzKDWwNvoAYGE0irbzR4d2tXnXr3KW9n1/MfyOYFpHdoWvmY/q7u0uCiO3k7qj/gxxUHZR/E8Sg78M4QLnnxzg84R+iB78LMaFhU4GdkYoSUnWZRS+Pitz7uV5SVdg==;5:NAHobI7hXkCjKqhjFwfdcC0Ulqu84cg88eWueOQ+noRY4odnSg6hjHwbuF4MrNtRn69DusI6e83ZWsBXmWeeDO+GnAQWg9jO+Ltc8grjHY94Bd42ELPl8HKOyxayUU1jlppGYIhGBwS6Nx7deq1lRX+Nj57e+B5aZpnNTq7f8aU=;7:CdFrYXEsbxfKLMNShboRuTtGEq3JYpZ5eHPps6VawIVgcwhwukawRGK7Kf8Z8gnj4U0G0zZc+9y6eCd/A3nX71P7+zEt4/aCPME2uKuJOHseLMSijh9PpvOHuCoBIpQTsaYK62T7SEHRf8MHCg6/fV4c1rp/ogMQtyQ/x9c5IpOlmD/eZN0wDcTvgMKJRBsx2XvhNN4ccs/HqPK8Vwf2vmwwN7UmQxHY7swvZatxYN5B6BFqPJq6uR2VkdpNqhMw
x-ms-office365-filtering-correlation-id: ef01ed82-4b31-43cd-5afe-08d61aab18b9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117F8F0C9A2FC638ACA4603FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(86362001)(256004)(186003)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YeSURcZQq4pfKCOjhPjxIl8J6WUl+ilmAzA8fox/aCPqSv3PlnCrxKWHZdR3M/hhzXy5EWo0G7ZmyDaK2ApLnthq3DUCbnMXT5gb6Jnp8j6SSMWWDXgGmbNB0cFoHOkztoQ3Xg3c1LwUlW+fiCT7CC9PCYd7Gjl8QQjxMmj+NgfOji/1lx4brwXwW02dAM5eh6awGvl9A3A+6FJYCrX5N7jIlOTKGYo4zAcceG/4j+VD85e7FhGkKBO6Mm7v8eBzAPB1GN8RMiQ4EFcrH66TXAKc8egkLH1EchhZpzeQuQILo5ioFFxQQkLcapLQjRszcgqF+1BOPzre055rwOR3RwF2+t4qu94qnoXu8vdbLec=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef01ed82-4b31-43cd-5afe-08d61aab18b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:27.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
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
index cf94fdf25155..c7654209668b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -449,6 +449,7 @@ const char *mlx5_command_str(int command)
 	MLX5_COMMAND_STR_CASE(SET_HCA_CAP);
 	MLX5_COMMAND_STR_CASE(QUERY_ISSI);
 	MLX5_COMMAND_STR_CASE(SET_ISSI);
+	MLX5_COMMAND_STR_CASE(SET_DRIVER_VERSION);
 	MLX5_COMMAND_STR_CASE(CREATE_MKEY);
 	MLX5_COMMAND_STR_CASE(QUERY_MKEY);
 	MLX5_COMMAND_STR_CASE(DESTROY_MKEY);
--=20
2.17.1
