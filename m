Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1021398-1520488694-2-9197139190720607718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488693; b=rbmsnTd9roF2v9kYwZZz68qq3j/QYgsEXPoKIRrduN/6P7A
    +JfedqxShG3gBSmUMuS0XcJ60egBbz+m1ueSh+NboNUV8+bZ87XI+oPAmnwCO2Ei
    ow5G5cvZmleZZDIeeMoG804Lv6kNyqTu8x4lSL3irBuOxRrDNhngXwOKeOfxpK5I
    x3QaBdTrLP5Ln0yGwxfYotGwv4vmVVNEQeOrkECo61eAAlWRf8Uhtl+lY9FP2LEu
    iNZYVNPbMl/0QeJuC4oGpu1t5BlApHBrZfPCsaZZ1srTuyDW378nwbaKcFrs5rcn
    GB2jyHhFIbt7/ckdE1ZSFuVPh/eFXq6Q0DoqKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488693; bh=MkI5en
    v9KO1XVHSp83prYALZnLTvWjVYcSYfBJLybC0=; b=KR+uq9O6qmhLa0SHY1BzTX
    w76PZiE/Hs+WEnkV1EF4wDiiHqi5KVHLz6gG6cjQfj53FU1IWYPYh9c6DiTzvTOa
    bUPbXTBWAa1ZHrR/0kY5dq9EbbBPqRUmYgMPxGw+BHlVehFl4O3nuDnQ0JQSyAv6
    Lc5Y+esC5bog+AegPl/dLb+UC5H9TvYDm8J/SXMbyYB+PAZdWtW/1ZRjG/HTLbsf
    a5qHedvPW/LixLDgNEAYRMx+BLhr1GgHNPRZ0jQrgerYATdP8kH+USCvhb+uvOZX
    8q0ZmZjGW+GhtbWXBYNXdlnOGzjiBky21LXLfdb9X9Lf7LDK9pzJfLtwf05SgOhQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BtTPDA5f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BtTPDA5f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965741AbeCHF57 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:57:59 -0500
Received: from mail-co1nam03on0114.outbound.protection.outlook.com ([104.47.40.114]:38578
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966009AbeCHFD2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Moritz Fischer <mdf@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 147/190] rtc: ds1374: wdt: Fix issue with
 timeout scaling from secs to wdt ticks
Thread-Topic: [PATCH AUTOSEL for 4.9 147/190] rtc: ds1374: wdt: Fix issue with
 timeout scaling from secs to wdt ticks
Thread-Index: AQHTtppN6OyaHCon3EiNArw2nLCDGg==
Date: Thu, 8 Mar 2018 04:59:56 +0000
Message-ID: <20180308045810.8041-147-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:tY9gq9D8HnuHMxayJ44zV6AemZD+7tlFcvLZF1c1seS5W2sl6r/x/faDZmCqgBi1w/KqZ0xjABQS/S8XThyOUZJtbIuJbvt3boC/4m4GE87cPiyyKboiy5WAhhUlaW/cfScFiV2xl49KF5zVEbQHwfkN/xr/yaYqJvVEVbcJF0fSotKWdTZ1vS7NZKxTdgJnJEySWxFWd08+ZyF8smg340TKSm0QXToMpRymVCJCVIysCjOBL5rBkmH/3fC8o5fg;20:vanmhrBpSR0M/crwHZbBzleK2I5IgwYkmReG89N3xHwx8gyPIpwDGZF3UaTZ4dB29yhARysX6Tgn6k8Z0dAdeYVBZ3e/wGSzbqQ8LKDjeLGuWu9Gh0jwtcIbgU8c2Nw5FOf4IsBK9prUjR69Q8ZjjNwds9qdiYwZVRgDOooPYvM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a04f01c0-5048-4744-6e90-08d584b1ea5c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090289AA5477BB310BFEB3E1FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(6666003)(2950100002)(106356001)(10090500001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(59450400001)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: n52SufaEIF1FyoTfpnwaSeT/RP4TVWDU3yUINulMVgL6MTIgK1At5xW9o2uFN+Me9IsweqFQjCLgaazt9Hb/WQo2+oDDSv3Mu8S9fTglvu1z07bWR4/IC9WKIxGFA1kNaLELCwK5bPjt8ai3AW+eE2cpnCdsYmz3W0X2aVKrsRIlkar8BswY+6RJ2YJu7RuEy+yXcA93gJl90NOED2uPtu2X7PwEstv1/vJsAQv2fJD9Y7VWZsKPbosF5ZiiltN3w7Mo3dXnfsnS6VOHg2sTttwpAZkvH487C1l56l2cGX/2yRTD++M073vzTWaVjBQonM4yyua86c51yrI7TbtsZg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04f01c0-5048-4744-6e90-08d584b1ea5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:56.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Moritz Fischer <mdf@kernel.org>

[ Upstream commit 453d0744f6c6ca3f9749b8c57c2e85b5b9f52514 ]

The issue is that the internal counter that triggers the watchdog reset
is actually running at 4096 Hz instead of 1Hz, therefore the value
given by userland (in sec) needs to be multiplied by 4096 to get the
correct behavior.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-ds1374.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 3b3049c8c9e0..5b5bc7dc3a1c 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -527,6 +527,10 @@ static long ds1374_wdt_ioctl(struct file *file, unsign=
ed int cmd,
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
=20
+		/* the hardware's tick rate is 4096 Hz, so
+		 * the counter value needs to be scaled accordingly
+		 */
+		new_margin <<=3D 12;
 		if (new_margin < 1 || new_margin > 16777216)
 			return -EINVAL;
=20
@@ -535,7 +539,8 @@ static long ds1374_wdt_ioctl(struct file *file, unsigne=
d int cmd,
 		ds1374_wdt_ping();
 		/* fallthrough */
 	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_margin, (int __user *)arg);
+		/* when returning ... inverse is true */
+		return put_user((wdt_margin >> 12), (int __user *)arg);
 	case WDIOC_SETOPTIONS:
 		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
 			return -EFAULT;
--=20
2.14.1
