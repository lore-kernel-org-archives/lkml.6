Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F83C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D212075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FH1QGklE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D212075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeIFXHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:07:39 -0400
Received: from mail-db5eur01on0085.outbound.protection.outlook.com ([104.47.2.85]:34469
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbeIFXHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeIf5Y6HVLIVw1Bgw07hUUgHgfUUF6dCW8c8SaOc5Wc=;
 b=FH1QGklEVggRXu4194UioogC3cAkNJdOiuJlhHkSDjAM7mpRUXDEYkDxAcCV0JqV4jXWhPiXn8anw33moxYb1BBC1/O08RSYHw3i8FIOD97PG6I3yX+Cn2f+JeaVF1Coi3j0HaF6ltO9Gh38rUwFgafiia7X05YRhcpiKM8hriw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Grant.Likely@arm.com; 
Received: from tiffany.emea.arm.com (217.43.126.139) by
 VI1PR0801MB1759.eurprd08.prod.outlook.com (2603:10a6:800:5b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Thu, 6 Sep
 2018 18:30:08 +0000
From:   Grant Likely <grant.likely@arm.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     olof@lixom.net, scott.branden@broadcom.com,
        catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        leif.lindholm@linaro.org, agraf@suse.de, nd@arm.com,
        Grant Likely <grant.likely@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RESEND] efi_stub: update documentation on dtb= parameter
Date:   Thu,  6 Sep 2018 19:29:27 +0100
Message-Id: <20180906182927.22318-1-grant.likely@arm.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.43.126.139]
X-ClientProxiedBy: DB7PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:10:12::23) To VI1PR0801MB1759.eurprd08.prod.outlook.com
 (2603:10a6:800:5b::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a391ed3-409f-4012-9f1b-08d61426c6a1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1759;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1759;3:FvbQo0GMwmYT2hPjQFPIABsnrTCdiV/hgQmiA231rUzljIt+X6oA65C/9GuWMmm4pGDOVp1lneSkPUsIBaeJMq6/AMJHIWiJ0UYNt/DUWL6p4adejkYJrwlMHbnWubY125jjXcgf8GmTwr7Vu0Z3cdAdG2sczun/wHptjMNjZditmMBLln2iU4grxmkLDNjbKec8zzN8QVY1zTVYw9Ik7vGxD0ALlbqfFsNssTrGMOGZZ/5vhppVztSsXfvanegv;25:COfJtd1cpnQugIK94ItJnRvvuRsVVpC2ojG0jjCWg1TzSeySDEyR1GtQEuP+pnAVvV7+O15p3Ox/slr8TSTZx2dDtG7u8V1SICUB8ipwFRXa375HN3AvNwGXWJPxzpf6CtrCLcEQEoStTidJsI8ZH/FEt3c/Z6jkUuPuuYGq0uUk9MIe4xgJxgSHBr/633AHhmQVbMNKGlIgj8F7VVY1AMPrCYPq1hnFWJm/j788atNm1RDQ237IOvUFjcntiBUF9lIJJ5kGZupz+3mj3sDrq2h2rQqNUTylpZ+kCmHoHyycOP+4TtuKy1Y5BFNncxbGy/AiMb/hMCCkSdfGVo5/3A==;31:kNcTfXqJefm54OC5vhHxuvpM1tc0bIfJHX9FERqGeR4eLQvE7W6HDn4i7g4aC15Zr9wAu5Q71H2GjPjd1uk3g5zH0wtapIgnlmhorJWSbAf0ScxiDyT8Yup53AgE69vgoDPZ3OpNL2rOxFolaJgjn0Jsp586hh7bjrHQUH1uzYhj4XFnBfUTGMEnRfd9ZmBUT4olueDniPxd2szw7QLLvQCP5+H2TWR2WOeYLJqMZ7E=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1759:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1759;20:El8/uezQGu4YHyX7S3i9w4M/qcQPW0neLVnxsnJl/3HWzaSWldjgOYM4z0JMJs7WJ7iU319yrUhIP7aFLJ5KFA/lRaboDUS+Zi1fLV0oEjNXyTnaC3pBJdO7r3OuWyXR44MhQjN0neU83+56l+h8nCTBJ71oWqZVrmlqo/MSBsdbstqWU1MY/jp2j4NieB0rnRqUVb+HgSqeWzJYTjZ+WKKm4iyiBPoxoitHtMYrOtm3Z7vzkzxjqjClv6wMI2JnoU0VMjNByxmafyhZhlsdBZgfIDk6l7Gw9okNC8TvfV65IuNbDGmldLcWahwEDLOKJZTZC8Nhgirik1/kDn7UiGHYPcx/aFZLQOLUwnnPwfcPDHAC6J3Y+7ueMZ47Z+HhonI0ZqKmIbARctpqxknmn67DDUBBicYvH0dyGPIBFq8=;4:Ml5R7zW0ohyAnEm/A+pfY48ap2/bUWFKIqVFCLUXhTjgDBMWXN4yhl8xL+EP9+b8w3agQOBQzmsgWe4T1396DsRVzZ0Ul6KXGmspjIxvvw1FJFV/sTX1Yt/eYgXM2qZxpDTOOfMj4++OtmDuyauHY0P+rMkHFKlLk42zgsmu0YrTY+7grSOji6FeYyAiJXp3q9zZ+bnwrus7exQGivfi7vQSHqsQf8mvR77dA3lQqR7k/VmKk3rN8oPW6rxwZiPMBysk3KLp5jf9TmmpjKGnDfYdJ5VUs+V4V8zyLiKBfPeCQK5XHWuK8Ycf0gAPvhDw
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1759A831C32A3AFFE994263E95010@VI1PR0801MB1759.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR0801MB1759;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1759;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(2906002)(8936002)(106356001)(54906003)(1076002)(6116002)(3846002)(476003)(6666003)(50226002)(316002)(52116002)(44832011)(7696005)(68736007)(105586002)(16586007)(51416003)(14444005)(2616005)(305945005)(7416002)(16526019)(575784001)(8676002)(86362001)(5660300001)(81156014)(81166006)(15650500001)(36756003)(7736002)(478600001)(956004)(186003)(486006)(48376002)(58726001)(25786009)(97736004)(6486002)(386003)(47776003)(26005)(50466002)(53936002)(66066001)(4326008)(72206003)(58736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1759;H:tiffany.emea.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1759;23:KZLRqkgrwuVAuCTO3ui0Fund5cm06wr9dKWeGEn?=
 =?us-ascii?Q?Ocb2txIONUH9cWn6xnf2SgtbfD7RAF8h1HUtgmGdLfVZyL5e4g9L9hD44+X7?=
 =?us-ascii?Q?gLzUlgoMq1irUtZ+1FJd6HFgfFJ9XYYsB0hTh2tzBEETZkHlOAEyzwsGXN1R?=
 =?us-ascii?Q?pg7yYgNeCaqWsoya2HslEpV8bB+o4OoXDwFWFnQItET5APrVwQp4/78HkGUD?=
 =?us-ascii?Q?spsBcqS7XJHipA0Dlh5A3xk8+oepvCIs71HHfxPqBWBJe2Owl8sRvzIcTzid?=
 =?us-ascii?Q?aNSeG0BUDyUzICyEUAS0yMI+wfraweqw2YjDpIVr37lGy0g11l1TvspHUhTb?=
 =?us-ascii?Q?yD4x6KSmIwaDG+/Frv26lWI7oqV8kA0ZL3wLZ65d1zgNUc4C3NDTWwMq7oqL?=
 =?us-ascii?Q?E1Gn3B38XmeRV3kwOJQ07zl7xP2jDaJ4AqLyT7LduvPDaYJtvwT/XYJgHto5?=
 =?us-ascii?Q?nh5i+Om4k1LvHyx0xJ4kzy/v5YnN9BnEgsdf47NTMo40rbxiRWB3SO23JfNS?=
 =?us-ascii?Q?6lUnIDhi0vrF0nDJ/Dz2PP9XesTuNCp+k/RzNjLQPoJ5pxCV/WERRAvIYxCx?=
 =?us-ascii?Q?P3BOejsIllTxeQ8HoLaVvDwW6bLIXrVPYCTE0QeJ3wWHAv2TXZMwLQopTtfI?=
 =?us-ascii?Q?IrTVYyUQxtsVNOUzsZ6yVUfkXsQFlXSs0xOM8p4M8f2tNVqvzrSQwCPP4y1G?=
 =?us-ascii?Q?jMglEldmnm6bDZiEiSK90Qc5pw21P9iRrSg4CUtiqLC5ZnF7JeDLwpLUTrFh?=
 =?us-ascii?Q?f2bbD0hPWnM4gIV1dhEGVvm3VoeqmY4BRvXL1ynO7eLgTrDTlbFWTIx/F2PM?=
 =?us-ascii?Q?AEzkKVPALBb5+G9hLorvlqgM1/YxHWCSnqfIkwTbZiuhU9f0viQ0Hey9kRls?=
 =?us-ascii?Q?Va42Bab/QFyAxrNvfda4aJ6jfPNP8aECZMdoBtKex9F7wASJMRNJdOK9NXJx?=
 =?us-ascii?Q?LdE2LgnMgxfHhrsvAqrt8J0qVJbl4WJN/gJD2dEySjvDqB63cuf+15xgg0mh?=
 =?us-ascii?Q?NGSpVc3dcobTMF+MXd5MMtabWT2Cyd0nqe4EU+wP9xp4mHPsgsVRCd7Zk2OB?=
 =?us-ascii?Q?j5l5eOYMfWtht1rCJuVVCQZtEebsLOLXhYVwDZESwNospxZALFRyvAF8YPhj?=
 =?us-ascii?Q?2AOLrN6wusI9dImUHLH3mV4L+8w9AO8b8/2KncBdYB0L94+FSce02r0PzGjq?=
 =?us-ascii?Q?G92QxAsSzTceFt1vsyzrwNHGZX7CaV8JDAJOZGBnnuoJT7tkx/X3TVVgqZih?=
 =?us-ascii?Q?Dp6InSMcHOCeu2LfVE/jKwGNWyQp6u1fivNcwTEc2sG7LjATh6eO3Mp2RfgC?=
 =?us-ascii?Q?3Wg=3D=3D?=
X-Microsoft-Antispam-Message-Info: CiP9sSa9/v+kI6M6pXlUV2DUpoD42KlPEf/2751Mt//bSzg1zE2P64DEdKAHSAPzjlalF0lk8SXMhw2OE0pPMD3fTyyvKDacm8Ra7QGVAmojgTS51TLWYf4haWggqG5F/cOUHQlocUrlzAs7WX8hSgt3TeGfnZdIrPm98Ho71wiVhAcg1ZCd2aBsixCo8yCmPAT2U8kXdItBWOVQLnGS1LislesYtgTA5yZulfq5qdR1xPgrvaU8T9Y8lZj0ZNIgSEwnoo7f6Gmjs8VxplCd140HXbOHb6lGCBBdKfV8CiI2um4FyOtGW+cTKxbJx3nGkguUdvt5jxGTcLDZlcbBQte1TX09ivzaXJfpwFsuD3g=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1759;6:skLM2OrdlT2xUINEsG7plNgFFcgUWoDMAt/1wggxGVZnzkMng4KaN+VghweVOIoHIONOmzg+o3jz/fCydvAZSHUE3hMxwMu+EH8MYCd8IZFuctOnMW03V6Gzy+IpG/V8h+Loi7kDdJAwkjvCXSVZJ+PJPQaU8gQpuKh8cscRAaDpKkwuEsQNZeNVpeb8xEgvBVYfdHrpmPM5xX0wMDMfw8KfN7PT9M34eifW1KnOTmj/1TXStBLr2UuE3DC1pmH9wVY/rrPl5Pk0XmC7KY57AGyaP9If8w5Shvc1A2bZGHsTfFBfMV+T0Cw288A1XapNNT9hRUhnnNMAxpL8Y0CyRoeqRHbzZ3/Z/rDCHmBCvsG+sHOOVQeWYcpBEaKeEgdfQwVxW0/Y7KpJf1Uj3+XzSJ9CdskTmeRoIncCPdNf+q5xem8V4CUIToVt4Gadpk+HntHgb2ocWAc1OzAGNFjd9Q==;5:KmymMcvn8KSXbRRFoQinuEdWpR2PKc8CpIDennzWUau8Fi2TIAKzanhNcYl01xgyZVmc78nbN+1RtZOIIJ9U6CCgx9E2p360jhWpLyek8TBSvb0LhPH9dPcxj/j4r+xv0Dn8/iHwyuwZZ9lHgzVM1m8jRv/pMrYjPsvO7uPom4Y=;7:DprwknPWJmqIHZj+5UeaB54Iz8i7ot1vjNtpFZOuK1o0jSbWCbyHszBSBoKurMovRbTvhrv0mo+P6K7e19HqzeYQhBsUAZGDbm34wkKwUg6dmSkzbPXvc0Zr4S3kBpQxaBEYCus1RZHXEdECI7wKxTAFe9umhxBq4qxUHzap0GwoFGU8Sc0psLPHBUQgqs9qc44gF1A23jW2gs6Ta7iVMglixVxDJX7SJkbNy3rXIJU8j3QX2smdBcva5ZvoFmzq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 18:30:08.2778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a391ed3-409f-4012-9f1b-08d61426c6a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtb= parameter is no longer the primary mechanism for providing a
devicetree to the kernel. Now either firmware or the boot selector (ex.
Grub) should provide the devicetree and dtb= should only be used for
debug or when using firmware that doesn't understand DT.
Update the EFI stub documentation to reflect the current usage.

Signed-off-by: Grant Likely <grant.likely@arm.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: Olof Johansson <olof@lixom.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---

Resending because original post included Arm corporate disclaimer.

 Documentation/efi-stub.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/efi-stub.txt b/Documentation/efi-stub.txt
index 41df801f9a50..833edb0d0bc4 100644
--- a/Documentation/efi-stub.txt
+++ b/Documentation/efi-stub.txt
@@ -83,7 +83,18 @@ is passed to bzImage.efi.
 The "dtb=" option
 -----------------
 
-For the ARM and arm64 architectures, we also need to be able to provide a
-device tree to the kernel. This is done with the "dtb=" command line option,
-and is processed in the same manner as the "initrd=" option that is
+For the ARM and arm64 architectures, a device tree must be provided to
+the kernel. Normally firmware shall supply the device tree via the
+EFI CONFIGURATION TABLE. However, the "dtb=" command line option can
+be used to override the firmware supplied device tree, or to supply
+one when firmware is unable to.
+
+Please note: Firmware adds runtime configuration information to the
+device tree before booting the kernel. If dtb= is used to override
+the device tree, then any runtime data provided by firmware will be
+lost. The dtb= option should only be used either as a debug tool, or
+as a last resort when a device tree is not provided in the EFI
+CONFIGURATION TABLE.
+
+"dtb=" is processed in the same manner as the "initrd=" option that is
 described above.
-- 
2.11.0

