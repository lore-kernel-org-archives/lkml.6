Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116347-2-9611239480891784244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520116346; b=M7USusNrPbgfmpQRrVRIQ/LEthxSfx7phNw6C8jtLhI/Gfu
    yZ6N/R9BQDqXB0x/5lTtrRS0asz6Kn4Z2JD6r+QnPe8aF5hfG2r0nyPiIiII99bF
    zbXNk9QuLia1Lti0mvjLD5bOLzhtjvJ/AhPsDBp3spLd/18nU6fIcq3zyHucgkzU
    qSrcCgs9t6jXbzuhegrPKvX7nYK+VIJza2Cn9QNJ5LxNt5rSRJEZKj7ZSgbuLhR7
    Yw60iGAA71yr8dHy1Lk6BhW3SLOjBmk+BGge/oBf9zZH68gybZjIKdJ3NJP1UxYt
    HTqrR/GleExz6i3w8AqIkoQdz2AI1XRE0sSDFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116346; bh=RofD87
    lIIa0tLo8MvPY+6QSOGr3B67WPkFrpkfBotGU=; b=mhqfyF2yVOJU9ETonwnsSt
    D7cGPm4wSfAr5rcJ6Nb88FPwBUIR11P367bqOMX3tj99j3UfQSBzsVwa91i+TfnM
    caCqid1NQ3GcMiWEDOaOtRvp2cHPlUa2sEjzx7aW46PvZdU6qMRoPjKLks6+ZYUD
    ZbDefgAj+Im2SrUzjG/6exTydgF8ac8ZbH9qroB7reXfpqGt2BYHeenzz/SvZVyb
    4dj+/Ow/K9rp5owXVl8mX9QX/akPrIXarL8qtlF5ABzp1TRpnkeqehRiTyXO+uUr
    rkXSUwSwisY1NkUJWk+OPk/iW79wx1M3w8aWUZPP1Ml+phYFRd6zxF35OwNab+fw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dvgQY8hG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dvgQY8hG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933774AbeCCWcF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:32:05 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933765AbeCCWcD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Wahren <stefan.wahren@i2se.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 038/219] ARM: bcm2835: Enable missing CMA
 settings for VC4 driver
Thread-Topic: [PATCH AUTOSEL for 4.9 038/219] ARM: bcm2835: Enable missing CMA
 settings for VC4 driver
Thread-Index: AQHTsz7tUlzQ4fnLhkuyZLIR6Z18gQ==
Date: Sat, 3 Mar 2018 22:28:17 +0000
Message-ID: <20180303222716.26640-38-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:LchnkmIoa6W6Klo5D5ovYJwF3zK2hdHIf4KNCT6Ijtd7JzgUig/G141lmdHfQGS0Sw3ncYz46ssZLJPcg8jaj5pGOri96/PtcZuH2kHYlj0Kts3CdlZaHTZqFHlNfg8QnNdTTlBpM6lVYVYt7zlystW62h57k8Y9usCBr/YrrzD7/jvpPgnfVH2RpNn6aQWu04IsVqE5cGHs2WD/2vhZOzvHNsQMRL89j6SEheA1SdhxC/T5ILUn/QETNhLrHW37
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 36ce84a0-85e4-4047-86e1-08d581569484
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083FCE9C669CFDC3432DF80FBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: wIauE6bo61G2JoOWZYb3zGci8L3FSwLIOmNKgtvmInkyAcbIQ5WFIhSbYeusEUtwg/nyayQ3zPc3NkPXcYAkKiqFzMyKQP18nrj9IkGzSjDJmgCjzVasafGhuziEkiwP0BbRdUDi+QQwpFknpxcTMlfRnCOjQHviPl5KfzMA7Po=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ce84a0-85e4-4047-86e1-08d581569484
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:17.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit bdd3c25423cb42171446940bca0946e0443e1a84 ]

Currently bcm2835_defconfig has CMA disabled which makes the
HDMI output on a Raspberry Pi 1 stop working during boot:

    fb: switching to vc4drmfb from simple
    Console: switching to colour dummy device 80x30
    [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 0
    [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
    [drm] Driver supports precise vblank timestamp query.
    vc4-drm soc:gpu: failed to allocate buffer with size 9216000
    vc4-drm soc:gpu: Failed to set initial hw configuration.

So enable CMA and DMA_CMA in bcm2835_defconfig.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 4400d9ac05ee ("ARM: bcm2835: Enable the VC4 graphics driver in the d=
efconfig")
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/configs/bcm2835_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_=
defconfig
index 79de828e49ad..e32b0550a338 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -1,6 +1,5 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=3Dy
-CONFIG_FHANDLE=3Dy
 CONFIG_NO_HZ=3Dy
 CONFIG_HIGH_RES_TIMERS=3Dy
 CONFIG_BSD_PROCESS_ACCT=3Dy
@@ -32,6 +31,7 @@ CONFIG_PREEMPT_VOLUNTARY=3Dy
 CONFIG_AEABI=3Dy
 CONFIG_KSM=3Dy
 CONFIG_CLEANCACHE=3Dy
+CONFIG_CMA=3Dy
 CONFIG_SECCOMP=3Dy
 CONFIG_KEXEC=3Dy
 CONFIG_CRASH_DUMP=3Dy
@@ -52,6 +52,7 @@ CONFIG_MAC80211=3Dy
 CONFIG_DEVTMPFS=3Dy
 CONFIG_DEVTMPFS_MOUNT=3Dy
 # CONFIG_STANDALONE is not set
+CONFIG_DMA_CMA=3Dy
 CONFIG_SCSI=3Dy
 CONFIG_BLK_DEV_SD=3Dy
 CONFIG_SCSI_CONSTANTS=3Dy
@@ -62,7 +63,6 @@ CONFIG_USB_NET_SMSC95XX=3Dy
 CONFIG_ZD1211RW=3Dy
 CONFIG_INPUT_EVDEV=3Dy
 # CONFIG_LEGACY_PTYS is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=3Dy
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
 CONFIG_TTY_PRINTK=3Dy
--=20
2.14.1
