Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF46BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B7720834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GSjnmWfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B7720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeLCLch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:37 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:21376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbeLCLcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miQCNBo/k1TROTGVF7qusb7lSrk8zA+EMFUm/0Qewe0=;
 b=GSjnmWfFKN1DVoX5inKe5yFbkLRxuMuwaqVlFBK42QvCOzQMnVfa8sjLueEYVY12VEzImZJHkCzzM2gjxXNXdO442O9xl7qxkikpOq5v4pta4Qvsm3SzmUKjvcgPnxSYzURTSgVtpv8BZSmS8sZgxJp382F1c37T1zjZRhWNJvg=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:31:53 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:31:52 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC AFBC v2 00/12] Add support for Arm Framebuffer Compression(AFBC)
 in mali display driver
Thread-Topic: [RFC AFBC v2 00/12] Add support for Arm Framebuffer
 Compression(AFBC) in mali display driver
Thread-Index: AQHUivvJI76rFjfqHEqVm3VkdbqEvQ==
Date:   Mon, 3 Dec 2018 11:31:52 +0000
Message-ID: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:dqMBHHSj2hG7OYbuxMPmX+0B7w/DF8PasS3FCy9UsjTbxUcf9i9DRY+j8tNnxKmAIJsq7r7OUPe0POd+CPR3mO+dCMDgI+nPWJ5qpxecbflTAXtDb4hDEtfxttaGuH1fXz9TwykZXKAr+zvkQAux7xPNyLjpq5fnClCpr/S3A+XgyW16l2QRg7YwyI/u5GbLoUzzefGgUA1y6v/GvIC6did+Bbsd0BmuthVMvaV9NcNJe6vjbQBiQO9QZ3rwBY3r7IffY0tiU9yTKSp83YkvqWkgmKPsz2acXkTn0/FF3AgF9mgwt5RXSiRtCNK7wFhMnSAvooo+siINl+kZURsW/1n7LHkzYCChl+0cxH8LJuhR8Kd0P14UWpKA84IShxV+XU/yx6AKLOG+i60j/iLJGuG9loZ6rd9v5iZOErr9vGEiac5BFWSI8N/evg+Ef6baJRX2XpYG41bOX7Ezpzzn4w==;5:42dfAIYeFewAew3TktL/GkHIOz8JDl86OfdawXn7dGzLWe/roxcr9V4YuX6sg1K97EKwx0U/lF9dtoLwNT5k7I6WhP4l8jTn/yOnG3/p3EIMwPd9c51hHgzjkYWdT5UM2I25rOLC8XErlm6GHifq72DVqZxALO70M9qH39/KEF4=;7:BKFAAWrmI8I/6XuB0uyFpCXGP9ND2p98DxDcJWW5OtMolgoqP665KmBTuAUVHxFaZOaJw4lPy9MwWFOqf0YlOT3lpB+5QCIYerhOJUJUyWrAl/ghZYK/XuCZJqbSVcrEukMpHYqX6jw3wz9Y7ncfdw==
x-ms-office365-filtering-correlation-id: 0eec1234-fd12-45ed-fc34-08d65912ebfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3491C26073B6198343399C15E4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(486006)(2906002)(2501003)(8676002)(966005)(2616005)(44832011)(476003)(6512007)(6306002)(105586002)(217873002)(53936002)(52116002)(386003)(6506007)(86362001)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VPF33G5ivi4/M25VrGgTqaAbS9l6jHIU0CNCX26uPWg05j9eLg1ZdX5uRkKcZIyHlTDXP3B5w9CRz7lVW7idbLlGi1WrDbDDDgahZn7l4RPQirwzuB/m0hslnoRrQIyyYAUzKo40KPIANzb4UvD9pfIcVf+otoI1IeSAdgn461qh57JAd43i2WUrGOPGo3i5gVl6TR7TqVwBoRqK+qf9A+CLVknVQFYJVDgKFp4W3TSx77W4J7MyWtKWUFWar/jLZQ2YcEi+onRXIVePdHQidHRXjEApSh6nyKQeWEdvWEZhHgl5OeZgHn2RhnmzTBOGsW4gACJDhYJiQ7sNWS/5ztfWPdkSVljgRHomS3h+56Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eec1234-fd12-45ed-fc34-08d65912ebfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:31:52.9072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to add support for AFBC in mali display driver with
the help of format modifiers. AFBC modifiers adds some constraints to
framebuffer size, alignment, pitch, formats, etc

In the previous patchset ie
https://lists.freedesktop.org/archives/dri-devel/2018-June/180124.html

I had illustrated how to add support for one format (ie BGR888) with
one valid combination of AFBC modifiers ie
AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE

Changes from v1:-
In this current patchset, I have enabled the support for all AFBC modifiers
(which are supported on DP500, DP550 and DP650) with all the pixel formats.
Also, we have introduced some new pixel formats which are supported with
AFBC modifiers only as well some other pixel formats which are supported wi=
th
 LINEAR only.

Please feel free to let me know your thoughts.

Depends on :-
https://patchwork.kernel.org/patch/10460063/


Ayan Kumar Halder (10):
  drm: Added a new format DRM_FORMAT_XVYU2101010
  drm/arm/malidp: Set the AFBC register bits if the framebuffer has AFBC
    modifier
  drm/arm/malidp:- Define a common list of AFBC format modifiers
    supported for DP500, DP550 and DP650
  drm/arm/malidp:- Added support for new YUV formats for DP500, DP550
    and DP650
  drm/arm/malidp: Define the constraints on each supported drm_fourcc
    format for the AFBC modifiers.
  drm/arm/malidp: Specified the rotation memory requirements for AFBC
    YUV formats
  drm/arm/malidp:- Writeback framebuffer does not support any modifiers
  drm/arm/malidp:- Use the newly introduced malidp_format_get_bpp()
    instead of relying on cpp for calculating framebuffer size
  drm/arm/malidp:- Disregard the pitch alignment constraint for AFBC
    framebuffer.
  drm/arm/malidp: Added support for AFBC modifiers for all layers except
    DE_SMART

Brian Starkey (2):
  drm/fourcc: Add AFBC yuv fourccs for Mali
  drm/afbc: Add AFBC modifier usage documentation

 Documentation/gpu/afbc.rst          | 233 +++++++++++++++++++++++++++++++
 Documentation/gpu/drivers.rst       |   1 +
 MAINTAINERS                         |   1 +
 drivers/gpu/drm/arm/malidp_drv.c    |  45 ++----
 drivers/gpu/drm/arm/malidp_drv.h    |   6 +
 drivers/gpu/drm/arm/malidp_hw.c     | 245 ++++++++++++++++++++++++++++----
 drivers/gpu/drm/arm/malidp_hw.h     |  30 +++-
 drivers/gpu/drm/arm/malidp_mw.c     |   7 +-
 drivers/gpu/drm/arm/malidp_planes.c | 268 ++++++++++++++++++++++++++++++++=
+---
 drivers/gpu/drm/arm/malidp_regs.h   |  20 +++
 drivers/gpu/drm/drm_fourcc.c        |  11 ++
 include/uapi/drm/drm_fourcc.h       |  20 ++-
 12 files changed, 799 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/gpu/afbc.rst

--=20
2.7.4

