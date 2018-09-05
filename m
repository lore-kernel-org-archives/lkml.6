Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A59C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C5B206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Oj/+RqFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIEXlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:41:50 -0400
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:7360
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbeIEXlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHQTdXQFIXZQJNvJPoP8YZu74qbLRrq/PeIYygvt1KQ=;
 b=Oj/+RqFnTvyY4nHLoeEpnRepHbO/AjKB5Zqyc/Y79HQaE2Ckk5Y5lGsG793ohPQBHZI7hOZjYbchOkSVS2NMw9XQk/2Gndh8zeqGC97oLmeuCc3wL+3Ql12ptfi9tWjwq2Mro5Z3niLmUZ0uzYwbXpgYElbp/kgUjX05AHpZvVc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from tiffany.arm.com (217.140.96.140) by
 AM5PR0801MB1746.eurprd08.prod.outlook.com (2603:10a6:203:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Wed, 5 Sep
 2018 19:08:22 +0000
From:   Grant Likely <grant.likely@arm.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     olof@lixom.net, scott.branden@broadcom.com,
        catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        leif.lindholm@linaro.org, agraf@suse.de,
        Grant Likely <grant.likely@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] efi_stub: update documentation on dtb= parameter
Date:   Wed,  5 Sep 2018 20:07:50 +0100
Message-Id: <20180905190750.4566-1-grant.likely@arm.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: AM5PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:206:1::14) To AM5PR0801MB1746.eurprd08.prod.outlook.com
 (2603:10a6:203:3b::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0370c700-a457-43cc-87bf-08d61362f340
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1746;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1746;3:HC+NMsryCqVktYvve5VA33FgvjQNfqVNoF0r8WhIHMgwJ3ae+FxIOwEwnJJiSGnvQ55v5fomiLgTQB9KC1d76lbcbR2ZF48GytUGqh7HfIvEHBiANOLwOZmx+zAcXcV5b0nwh1yr/75GLLZNk/UccSK93UDitFcoX+s8aiaqTg/DcUMX5Al3bEMsjjMhcaOhvEP8s28dDvdRO8XQA93QO+oU0bWN6jI6jbGye16LiI64O1K+G9z5RTC3zjHEwzjA;25:Fabbhh1U+bmg2tTqIlipci2n467EfeG5z+t699Iym/3+kL3z1cEj2rdOt27afLTtehKbYNKdTY++wtrnk4Uc4y4+rfQZdBhwgqreIAAfvJk1cO+Pth9Rcd1E4/hSxd7K/j/RFVX9eoSnEgTCw8xjP8AQwZLJD+gQXEaT7+j/5IMXOEWtFKB1bCiW08JsRdcjUxg+RGBQty5PINu/9L/OlH50RRwhpGjVh7Uq/XbR2Ith4bJ2S9HY3jEjobfpKegCiptIOZLTvOQXCw4ztk3mOmyYOQTP2SrH9xlbnhq2Fcn85M0Dcx3saeCPjoLjvBv/AbVBvBgnT/DqTCSHo1+v+A==;31:MNCSRC/s4YTXLZwO7cvoH0R1huGio45g3PY6AXaRiqqwhm3OQzIvsfm0fT7AoGc+T8ZraRF6jZcho1dIoBWa05FdfXII//Po+M+mPnlCSmk4SUjj45/kVCB4mv63xIlBMjy6oW3epzZMyTHlCt5OoWL3u+Ol7VHh6RwSSxpkRm0xGchfln4KQBQyAl0SqvWiZcmpBZqB5jnXHKc2928aCL2pgFDUTW2wIU91w/MAHpo=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1746:
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1746;20:P7oStKk8lGny9VMpZdVy7ot0f1ChCabR2XBjrtM3Xf6ICYk43s97kLXJjbWt9WKjQCekP9q8nsq06OojhbF7Pj3mR9QaBuxnjp4j1QWgVEdGi6K62dPJGLQ7GzqKcS4PRbESFH4hi7rv/La8pDzT3x2UT0vV5d85oSWF08wBjo/YFsKXOm4ZzgusuiYQPWSasb8I307AkCTw5VAsDkjKUhQeuZOhB032DJcqxWR9IrgkByrqPqeyePoi4jlTIqlrYGTMNUq/ZeYErMBRAJ7L7DTVfmXB6MP0ooSoKGZr99amIFS9BarAsqEL18hvnGoGD6xJjtvhsgAKvqzS7KVLnks35XDhn4t/5+WNFfXwWwtJKvafKNwJnxPmtonBAZU3Gc2ZXLsyTH9WRcTzUUkeB4vHATfQV1Jke0hyayRLsQIfPcFYTgCs4f+FdQvICRa3j6qm54684MsYCXvTa1ohheR5V+DzmBWpcTRzpBKFywPor7WC90JR+1zxehOjcUi7;4:sgCuqApXXPBSCKEEXDhCQibfNnGfJy2zKYDc3qjjmEfGyNQLYRRcjOjiwckFoqblrUUr0ojSdgnqia3uz1RLOz1UgDqHZ4NHvUhdCxMSIMoCvwUA/0Rd+AVncpsxPIHjCR1HQb8rLUvZvpPCVpG/TRQDHfCz2c0bOBKhBYbOf8xwHGeTWuZacsN4URH3XQyJS3E+O0Nb+9KDCpuaS8Zg+xXmrJ1gvenOtXyCusLsTdMxfab8514CM6Q3im236ssiootJ/dkrazU9DEb/5t1KQVeVDnaH6/ygE3t1ElJ1MWLcFEfgUgTcLGiog1cmT/81ZnNH/HdVlGir4AV0PxoU7WX9r7Pw6k4jLjjYwoSBluE=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1746C4BE4427583CA8C5BF3095020@AM5PR0801MB1746.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(103651359005742);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:AM5PR0801MB1746;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1746;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(376002)(346002)(189003)(199004)(40434004)(44832011)(5660300001)(486006)(575784001)(6486002)(6666003)(7416002)(1857600001)(14444005)(5024004)(105586002)(68736007)(106356001)(186003)(305945005)(47776003)(7736002)(86362001)(54906003)(956004)(2616005)(476003)(16526019)(316002)(72206003)(53416004)(26005)(2906002)(50466002)(81156014)(81166006)(53936002)(15650500001)(386003)(97736004)(48376002)(8676002)(51416003)(50226002)(6116002)(36756003)(52116002)(66066001)(1076002)(4326008)(25786009)(3846002)(478600001)(8936002)(7696005)(8746002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1746;H:tiffany.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0801MB1746;23:Pk+cNiFdF0rZkRg5+2SraWEDaw+5riBAz3lcHlu?=
 =?us-ascii?Q?uAhb8z3IC63769wOqpfABC7qUHQe53ngP0+T9q+1r/OzdjjDLsraPff5Zwju?=
 =?us-ascii?Q?tGrT95ckZ19kURgvdjKc2K5fIfzcHcG8Qyvqd/WJ9D+cR5WR1Rrk0ZE/LTwA?=
 =?us-ascii?Q?VxluxwDHBgmxhfpHnIR3O19lQc6wO0ODpaa3F3dpSawgyo3pG5OGxt7yYMtt?=
 =?us-ascii?Q?LoFx6esVvFybgxLjBO1Ft9ecmk3ufJnZf+G45L2u+VgoeJ4DcKVyXa/+2EDH?=
 =?us-ascii?Q?Szk/FBhWGzRYcf2L8XwOBo7+aBzeDVmby/VhLIGkdAVOh00sBSahgMWhgTNw?=
 =?us-ascii?Q?jRdeAs/GWLHg3vj8p0qNVbGls9seHzyxoyfmH86a9BnHUPVmCJQUu6xARsKu?=
 =?us-ascii?Q?wtaW7q907MtEjaNWj383vMSyGROYRTFGCz2LgzPnIoopuaQirA/S5OrHXlfQ?=
 =?us-ascii?Q?E2kUJAARzP2GcQPebcsU4anWhG84DU+dIKGx3D6YoAWo9bvaRFDn1VZCMqKR?=
 =?us-ascii?Q?CVkThWL9OIx8UcKNyKKdBRipG2k5yfSk2Q6URycAL8drVfywkUmQ3me1MPCq?=
 =?us-ascii?Q?K+bYmcOWCKxRHx9rjDdA8e3tUV1uajcl1/QcLfHFGuoGHUQi7VzXuzzZs9cf?=
 =?us-ascii?Q?1TYi32yr7qMxPX4sI0s3icvGxytHG8ldj4KAMIVXT1hb6/bKDIapD/JuUI6A?=
 =?us-ascii?Q?o9kaPz2J4Xyqw4gILj/uojQ1g/2+dvGDzqBcz8uuWpFdG7axIW/4hpmMhc34?=
 =?us-ascii?Q?ZtQ1YsUQih/3f/7ciwbgl9yXRrCwF6kbOX4wbMT5IHdmOZonNGkUZMuwzaai?=
 =?us-ascii?Q?mtClsBz9Ud32LPw5HqviOlzEv3b3QUTHdL4l+fpytB1Ws8q9ue4wxNfkb1WC?=
 =?us-ascii?Q?rY3fK4pm8oxRNMJ59QrcJODXjgu67Ojdo74BVAuTVu1tnpOmf0LMrd/Gx9Mo?=
 =?us-ascii?Q?N6cwwaFq+xkjw/9bTPByVFXlDOOHJ7NCPT9rSTcHwzxnV4DUlut7x90uryFc?=
 =?us-ascii?Q?RnX/U8m+Tb3tTt7TeeMNwUD67WEWcO9DtUZOQp9/f4QxMnnortHuLa2sBidN?=
 =?us-ascii?Q?QSy58MNdCXWVsEOnNMfvdmjA8qqJfaRr+M38yTewnHG0/2lC6fvfCh8PPTsy?=
 =?us-ascii?Q?7i8xXSCnhnSBo7CPcFzC1ve88z+Dbh1z6JxeQXwRQHJ+tvJjYCQREp5takos?=
 =?us-ascii?Q?Xod/LazrPso+FpFcJaEIf04sJP0rwXxKwiBhtr6NBvKrBJRdCjh/GjAh07ws?=
 =?us-ascii?Q?z+xFz+hIdnCu0tMqPqPzTPK+ZH+Tw257QH2dHUjnhQcfaKTS5ksh3wFOWkpc?=
 =?us-ascii?Q?ai+2zXIOJnZ1NC3/Yd0R5eIXIYI50A51BjpbHMPcNUCex?=
X-Microsoft-Antispam-Message-Info: /NxM8jHkVIMFdZ9uJNZ6NqU4/ixJxyPh1FTQvJLRiJlUb/eDmf85NxXhRAx+yGcy08d5r1ktAGl/4iTgIYV2J85+NDsjv/Jvy5YgRNG+uvORlK2dK8/srE/FQOrNAY+UiqFPV1MWdevPb3O1K8F/TsUdtDGFJkGyLvAs/NYMedLzz8bIhf4cxDv0qGj87OHmigmU+02s/8DU+WYI5HhMSa7s+zEXwVWeFVv8aLVBVz+bnHWjO5lWiow7tVg3kJ7HhY523QnqXgeaxRjI6Jm6LLqpFGvlPOQ+IIRwervI/pobidmfaTbImTwbH+YMiVpmKTG15ntPCspoL8YKxumWW3XZ9I6fao1cD1dJ8ZFR65E=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1746;6:gyWJ3jh4ZJuAMmShETniJHAQnEsXT2xXDkxtAaIs7rhSQSCXS/OqDRG5UyjQ+d72UUv40pbd2blCDab6wTAJaJKYL6ox+WJygoKUAk1Bjl700AZwXStOiTr5q1+Yii3JCalsjKAeA15Yc9ruYs+h48TjEN7sSLFMbTNChwHdFIra68ewItRBccAUNQGPv6kzCLGu76MnRREqcO+LgaWSLNC91n8pX0kvQEheYwkkMKlZXympkRk+9gIPm6C4nRt/N07d8sqtCUWe3qGdLt4SnB6Cbqs+7JZJGJlqyn+OQ2u7358p3oExXGh1RGetr/mm8og2Kx8dTjkjwDaYqWQ1t8e5mr5fh/MwlwyajIysZGAep0BXka3MpHllUXovHdSzZpkGMUhms/FAB/DxiVGXBYGvBQbEOaj+nzWrXKf9kN2jwL8n0IbYOfVc2WSpuiqMMooxrdK89HLOBJwQtZO6iw==;5:0XNZMJYyPtkRgq7LJAc7yj0F5Qma5DyQQHSlaufxOeHw9gN7vp0BZZMIdJz23p0HjHf0vi3ZMBqg1jkMQYwPcRHS9WGxeJoPNwYoGVI67ZImSd63IiorFeEVeHUYhumX/dhohh9IPA3UzetDNFTHs8fD4p8o/R17ot865BBbeX4=;7:yG390Zkyg6RkgDQ2aXfBDff8mVp0jEeOuCmW0O/ttmoLp96fYlXcaB4mI3AbLy60MLxo7dqJIVOYwjEKyFxh4vIX1pdZak4EhzCk6s8I0hSZi6HsutEmHMcTON2XK5HbpRIa+PJ569RZTYdneXrvCmGQwMjGQwEciQWkdrkT/YGa0cNmOardy2UxtkYKp0Iba6ZaSWlbWoh3uAFeJEhbPifrkmizJWtFmxlLrW+6FpPQDeLcwXT6hVr0mFPTsClq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 19:08:22.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0370c700-a457-43cc-87bf-08d61362f340
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtb=3D parameter is no longer the primary mechanism for providing a
devicetree to the kernel. Now either firmware or the boot selector (ex.
Grub) should provide the devicetree and dtb=3D should only be used for
debug or when using firmware that doesn't understand DT.
Update the EFI stub documentation to reflect the current usage.

Signed-off-by: Grant Likely <grant.likely@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/efi-stub.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/efi-stub.txt b/Documentation/efi-stub.txt
index 41df801f9a50..833edb0d0bc4 100644
--- a/Documentation/efi-stub.txt
+++ b/Documentation/efi-stub.txt
@@ -83,7 +83,18 @@ is passed to bzImage.efi.
 The "dtb=3D" option
 -----------------

-For the ARM and arm64 architectures, we also need to be able to provide a
-device tree to the kernel. This is done with the "dtb=3D" command line opt=
ion,
-and is processed in the same manner as the "initrd=3D" option that is
+For the ARM and arm64 architectures, a device tree must be provided to
+the kernel. Normally firmware shall supply the device tree via the
+EFI CONFIGURATION TABLE. However, the "dtb=3D" command line option can
+be used to override the firmware supplied device tree, or to supply
+one when firmware is unable to.
+
+Please note: Firmware adds runtime configuration information to the
+device tree before booting the kernel. If dtb=3D is used to override
+the device tree, then any runtime data provided by firmware will be
+lost. The dtb=3D option should only be used either as a debug tool, or
+as a last resort when a device tree is not provided in the EFI
+CONFIGURATION TABLE.
+
+"dtb=3D" is processed in the same manner as the "initrd=3D" option that is
 described above.
--
2.11.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
