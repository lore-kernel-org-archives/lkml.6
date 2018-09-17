Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4868DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02569214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PTOR9cpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02569214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeIQIhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:37:17 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731275AbeIQIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjd3AgRp3GZfTzASIarIwQJQO2/IKdzmeSja9/1Y3Kg=;
 b=PTOR9cpJ6w7vheIXAWB3X8qE0JvFuC/xty0gFGaVJU9zD1B5vGsV0YaW0QS5vhy9dtCLmt03BMp4e3XHuzPs/VBDbqA3OhqWOarsEtCoGjSBM9pQPcTYBSpMDtnM4yWgogjpL8KmhmmrkUjQJXvsfKz7ghGM1gWfwsCCv6ylQxo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ethan Tuttle <ethan@ethantuttle.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 35/43] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Topic: [PATCH AUTOSEL 4.4 35/43] ARM: mvebu: declare asm symbols as
 character arrays in pmsu.c
Thread-Index: AQHUTjM/i7S68AnYgkGwrjS9PKXuuw==
Date:   Mon, 17 Sep 2018 03:05:11 +0000
Message-ID: <20180917030445.484-35-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:i/Y/6d6r62s604EFicniLy9nvxCEs4uf7hZFmGo/WJrnuNs6hri41A//8ypl8sj4hyMGe3FMCG6m5U4PGz50gL3FZ6IvT4/nV8xDfbD5/iD4cF1/Nq4go4YcQBQNN1PW3mCE7wnt52cdHbILpquZ8PWrGHOpiFy+MCdm+2zQ1J3EvA5tXYCjb8mrJ/wFPbmKvFSfNZ4BaMr/4VYBmUQD9cLnyWInI/6J13PR7EeRe225DuS7FT2JdVSjKYXF1z9k5eYh61hRTapwUihZZU7EDvoVPXDTWr0Ng9SKOkFsfzk5BMeT7WIn4j844hGRlZLqIRsivsEhq9X2+NyrynQ7eOIAs6L5vSZtmLGFmAZjbDO8+Y3zc5IXBgZAE2DIYbTMUmfafdrjbGBaTqJXBCL0ZPGxBDsiaG5hB65X+V8+oJxJi/yGa8AlGS0OewKiceuc+TFvhO4cTTqcZuu1xCwVpA==;5:PkR1STKW38rb/zbIWZbor+vtPkmMoAEU8quB5+sAmedUYk9kW8Vn4vLIDIC5QU4vAoy0JL/AS1hKtWFsCY2LH+hFTpzrDxeTPArPgRonnJ3xZiV91l1UYpKa+LeY2MqjfydbZG41bcSiPnY4jj+XJvbzywjMLZHKazVoshVmwSg=;7:K0/koKkISMzaggsi+L9MNNSc0g4ORDVk2Mz1FH0VJ8ml3QAKDzxtPZzuUGGKg2JqjtjeF26jy/uDrqNuLY6AiUbIN8hSDmtDt47ikO+axuZT6gOmFXC6zx1CP+WWIPUkPNxoq71FR3pw6ZKNN/f0K3WVLIYfrImSfLD+IDrp2pdVKVGSLLnHXhSbv4ZRxbcPaG2fwI+mD/UmtAFVw1hX4+ezvx5fhGHTI01JEztCTfsTlzgxhTrBd/O8eDtLl+op
x-ms-office365-filtering-correlation-id: d73612e5-af00-4859-ccaa-08d61c4aab38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB07597B1302D5C3966593F814FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(575784001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 449+DkVnGGPq5cpvFHw5pnIKlJD1DK1H5LjUoqbAA+g+1D6yWh+1D2DOPh6h+HDF5BACrCZomWCYN7koTw7RVnUCZ0hgg5cgJfZsi/OJyfiWEwy3kZJXfLNorXZ+IbISFWJQ/c+4KxNGHkbnt6vddTCcREaSo8qBDgnz2paWuU7ViRPoO8OlK1bAuWvqp/Bg07hsnUnP6txn/z7b9To7VrJqj31Pzq166g5PsILgIWLQOOZn/Xg8Y8QoBxFpwzh2RBsc5MDea+dq/0B9uvOdcQ4paVK4DP0eEYgCSC7E485lcstqvVJMJU+M/PqvHvfOM6CntzxRK+1FDYIqTh5ZVQrg9E/ukTac2V+Wa9yGFsU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73612e5-af00-4859-ccaa-08d61c4aab38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:11.1328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ethan Tuttle <ethan@ethantuttle.com>

[ Upstream commit d0d378ff451a66e486488eec842e507d28145813 ]

With CONFIG_FORTIFY_SOURCE, memcpy uses the declared size of operands to
detect buffer overflows.  If src or dest is declared as a char, attempts to
copy more than byte will result in a fortify_panic().

Address this problem in mvebu_setup_boot_addr_wa() by declaring
mvebu_boot_wa_start and mvebu_boot_wa_end as character arrays.  Also remove
a couple addressof operators to avoid "arithmetic on pointer to an
incomplete type" compiler error.

See commit 54a7d50b9205 ("x86: mark kprobe templates as character arrays,
not single characters") for a similar fix.

Fixes "detected buffer overflow in memcpy" error during init on some mvebu
systems (armada-370-xp, armada-375):

(fortify_panic) from (mvebu_setup_boot_addr_wa+0xb0/0xb4)
(mvebu_setup_boot_addr_wa) from (mvebu_v7_cpu_pm_init+0x154/0x204)
(mvebu_v7_cpu_pm_init) from (do_one_initcall+0x7c/0x1a8)
(do_one_initcall) from (kernel_init_freeable+0x1bc/0x254)
(kernel_init_freeable) from (kernel_init+0x8/0x114)
(kernel_init) from (ret_from_fork+0x14/0x2c)

Signed-off-by: Ethan Tuttle <ethan@ethantuttle.com>
Tested-by: Ethan Tuttle <ethan@ethantuttle.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-mvebu/pmsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index ed8fda4cd055..45fd4b173dac 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -117,8 +117,8 @@ void mvebu_pmsu_set_cpu_boot_addr(int hw_cpu, void *boo=
t_addr)
 		PMSU_BOOT_ADDR_REDIRECT_OFFSET(hw_cpu));
 }
=20
-extern unsigned char mvebu_boot_wa_start;
-extern unsigned char mvebu_boot_wa_end;
+extern unsigned char mvebu_boot_wa_start[];
+extern unsigned char mvebu_boot_wa_end[];
=20
 /*
  * This function sets up the boot address workaround needed for SMP
@@ -131,7 +131,7 @@ int mvebu_setup_boot_addr_wa(unsigned int crypto_eng_ta=
rget,
 			     phys_addr_t resume_addr_reg)
 {
 	void __iomem *sram_virt_base;
-	u32 code_len =3D &mvebu_boot_wa_end - &mvebu_boot_wa_start;
+	u32 code_len =3D mvebu_boot_wa_end - mvebu_boot_wa_start;
=20
 	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
 	mvebu_mbus_add_window_by_id(crypto_eng_target, crypto_eng_attribute,
--=20
2.17.1
