Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492813-5-17445387640260573316
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
    t=1520492813; b=hq4JdFENBf9pvmEpjVpJ7jb2Y2NSNA2etjqVjROrM/fNt38
    DAGeEqOxu3RCsIYfljDJFvRV4sbvt12UtzDuGz7twQiWY5RrziP2U+eFstAp6Byc
    vM4ygRSOpjf5ETF1Ga4N0lWuSYOcCvSgahiDGrKXw4JAoUP865s4C8oQHRjvnd3b
    g9AX9+7rMKEZWnWF8ulfRPH2itIqhEVeP0ddY0cwlyORs2uOafsb6PrVFMBri+hw
    wMb5obPosF6lgJNV1PGoAlKz2h62wKxUzxMOl76CyYiwwTDAZeVhtpzWOquFl8Qi
    S6yWJkLMHG9oEpE4e+wvPWbOR1VzMNc1aSdgv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492813; bh=AkJhVf
    J1nAur6Od7PlwDuH0UJiq+I5seQQeV+TnQWkY=; b=Xi4+j6CTgKq3GJa9/cmR45
    jYkzwydUkyhFSVUL6DMRBDS11eKSVlTa2Tib1H5yQ9wxuFL5ZrN1x3RakckHYiZ9
    GqP4SsvVN2RWRuhZ+vf0509Tjz8/M8XO2GhITRPEwEwRbHJsk4ux5QvMoADK9Xwt
    fcnnoasCrKu+NN08HV/fI5U/kb32+pDA//2anEKm0K0quiZ/kzsyZ08Z3UJZQL9w
    FRpT3cJdgvG/AufeDiFRdab1hr5EZYsk7Gx0WnL1zuun5bJi8pZekRNKJvzZSyqh
    jNh3sxFoUmeSERSPwdkfnepi83uqH9dTeflSAM/GCcDooSxulFxDtIFeyBxqB7Lw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=buaclLtb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=buaclLtb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935211AbeCHHGs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:06:48 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:1475
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755242AbeCHE4d (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:33 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@chromium.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 27/78] cros_ec: fix nul-termination for
 firmware build info
Thread-Topic: [PATCH AUTOSEL for 4.15 27/78] cros_ec: fix nul-termination for
 firmware build info
Thread-Index: AQHTtpnINuqVhkibPEWrL5W0z5iSTg==
Date: Thu, 8 Mar 2018 04:56:13 +0000
Message-ID: <20180308045525.7662-27-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1111;20:VnUoaT3wO8ZAOXzW9F4jOV743E8yvAXnzwTIXmtaKeoAeIJVDi9PRqAi2UTTfz6QGn9ChKTtN06D/c5VnxB7SXT5iLfQVl7KP+aSCNfSHC52J4yzXeM1vQRnEAI20HcFWi1PRtz/k/e8N1QO5T8ChYO6KLqb33ObRP24C6jiBdM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3189a659-43d4-4ef7-2547-08d584b0f484
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1111;
x-ms-traffictypediagnostic: DM5PR2101MB1111:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11112214663F408D5DC89C5FFBDF0@DM5PR2101MB1111.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1111;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1111;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(86612001)(22452003)(99286004)(7736002)(54906003)(305945005)(86362001)(5660300001)(66066001)(6512007)(81156014)(14454004)(53936002)(2900100001)(10090500001)(1076002)(110136005)(107886003)(575784001)(6116002)(6436002)(3846002)(72206003)(36756003)(102836004)(316002)(3280700002)(3660700001)(478600001)(106356001)(6486002)(76176011)(6666003)(81166006)(10290500003)(4326008)(2950100002)(97736004)(25786009)(59450400001)(105586002)(8676002)(26005)(2501003)(2906002)(5250100002)(8936002)(186003)(68736007)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1111;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: p/FWpahbnoF9iordOLw/nxUieiasydh30YaZONdQ+cokKKnhmipbHFlBDGx+eSM/uc03x0zxAt6dgFBvWNLBwryMt4FfUxNKsOjRyZ4ZqA+pfXHKyTpvBgoK9aBn9sv13BNZNrnlXYvCQs25nzWTYmUBBkhsZAJLFkEudZRdIfolwtxnQQ9cQH4fOXJLZb9weH9JfNcLhNNb1r8OuuptDvXFTzc1B3li06HTF6RXZkz9s4wCSUDi2d7SKeitgtF9630ijZJIB3s/BHA1bW42zTWBu9vWfDpeB3rPWrLAMIviBiP333fId7a4v/sXAHTli5Q6hmyBnibcCIEuoFirLw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3189a659-43d4-4ef7-2547-08d584b0f484
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:13.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 50a0d71a5d20e1d3eff1d974fdc8559ad6d74892 ]

As gcc-8 reports, we zero out the wrong byte:

drivers/platform/chrome/cros_ec_sysfs.c: In function 'show_ec_version':
drivers/platform/chrome/cros_ec_sysfs.c:190:12: error: array subscript 4294=
967295 is above array bounds of 'uint8_t[]' [-Werror=3Darray-bounds]

This changes the code back to what it did before changing to a
zero-length array structure.

Fixes: a841178445bb ("mfd: cros_ec: Use a zero-length array for command dat=
a")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chr=
ome/cros_ec_sysfs.c
index f3baf9973989..24f1630a8b3f 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -187,7 +187,7 @@ static ssize_t show_ec_version(struct device *dev,
 		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    EC error %d\n", msg->result);
 	else {
-		msg->data[sizeof(msg->data) - 1] =3D '\0';
+		msg->data[EC_HOST_PARAM_SIZE - 1] =3D '\0';
 		count +=3D scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    %s\n", msg->data);
 	}
--=20
2.14.1
