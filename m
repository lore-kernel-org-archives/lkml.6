Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488955-2-14825153582263942956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488955; b=ZLAo/f9OZzNECo8wO1+mbgMG1t2KY/LqBscDjF6JoZRD41q
    crzA7c8kpKPXul9AZSgVopqHTVqr2mGHM6Tczc0PR9Yz726urJcxgr5JPigE3HfE
    BXrA7xDw2WHlCIe9IHvYnBRI0HkGWiTohjI2peTZZWacrZbbgMlgQ8yZDUsopAhi
    Gm0XFhgJ+CA3Yx9H/gAEYp7syQb0aMCRbw2g9FodujuJBkwoEQu8q6JIxeraFm7/
    mNqMc81vJNG+/tIH3ce0vGmJiHuWQYi4vnujouO91fU+mE8iPMzleg4HkJ7/SMld
    8AO9+FJqM4oO+5cHzOaTJvVrEz3NZjQPy9M47vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488955; bh=d8xCH8
    xJOoLoow7LqPmHtWUsPzRY46Biv+e80IQl/jA=; b=khe8IX5Q6ZF8Md/tdJmS1U
    6GXDlTCanagzSJqlKU5jOE//OuQoP0eTWYJwzfmPDscIq8D8LW3x0xGwmP1lUdtx
    jKjd+bF0Jchxc7+lfYMq3a8rogTfRt6LDDlo/PCyuukwmsSrLsWJ6DPJQ887sV5Z
    Qes5Zk+8smCHRKozzysDpRKQtpalwU8k3thLdyZSrc3TaXFEG4Yk4YpsGzm9/oiQ
    4hRPUUMGvr+KicdX2VcdvbxQfhO24aZL9wmqIjaDk7cQDgVP9HgP5pAQ1kAxKTgL
    mzMEjsYNtne8fHFy87T72hlc7NOjIMAts03eWuTiHuQiRmSuBh6L57G7zc0QXUow
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PfCPK10L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PfCPK10L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965685AbeCHGCV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:02:21 -0500
Received: from mail-by2nam03on0118.outbound.protection.outlook.com ([104.47.42.118]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755380AbeCHFCf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:35 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Emil Tantilov <emil.s.tantilov@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 120/190] ixgbevf: fix size of queue stats
 length
Thread-Topic: [PATCH AUTOSEL for 4.9 120/190] ixgbevf: fix size of queue stats
 length
Thread-Index: AQHTtppGMrgFns7PskW2NG0FnqY9qg==
Date: Thu, 8 Mar 2018 04:59:44 +0000
Message-ID: <20180308045810.8041-120-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:KwE+0SakCDvQ5qGKeYpYJj81iTqmHWoQageQ+7joPVWdgXe9c7IarmykAqgTa/fXP9OkrPvp9ugk807yWx7ZdA7n8FRJXUyn1KfwSo+nU7TFn+lCNRf04cnFlUHLq4T8gt651J2atj1JNThRhVjAjti033jVFugRNOxGCybZbOU2COEij8oP9+jmX4oB8RQUGQ5SyVRrFeaNNE8vWAtoE14K2aUEN763J0V6cqHFgdrMVFRTvnMs2pOjpEmygAnB;20:Y/K65pjgaipLkLWxxFkObI5diRhdB5Rlmu0iTwT/9+/yZYCzoE32Vd+Gwb7V8rXFCTJ0m0HUKiki2yzRI/IPMTAMaeaaYqUiRj+p2K1f3y8vZcB/aVIAg5MMsRt5qPr4V8Xp9kgw17LXEp5aOH3F3pOV+2UQmOvqA3CQpC6O/K8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69f8266c-7a1e-4e8f-2d29-08d584b1c5a3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099709B6BBD0DA563EB2F5BCFBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: punvuJOLMdV7CuqjE56qffhmRWdbED5f3dlgetO8Rty66c44NPQAt8HUdaVMS/XmwJSgwWp1m9JzRD1hm6uQSLZP3eMXjzfCruGXAotlV3jlGU+KfT8EmMFadEXte/5fXQ1X271c9YJXAGQubdDTtssJX1hQKHvhb4rKsHKHmr8SpreOcFyM23LlR+0C/uQavhZEBiIUWnqmaMUFQXGiryKL+zCev0Yyto/ZhoXdZTtgxr+VI6B/4sVMJa+K6AIJDyiifn8NxkafhGDOxx85ra+6StSLVLqHSwtRljmy0PvMP4/58JlVKGbcf1YtTFbntVmTwCO7fGzylgnQj5ol5w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f8266c-7a1e-4e8f-2d29-08d584b1c5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:44.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit f87fc44770f54ff1b54d44ae9cec11f10efeca02 ]

IXGBEVF_QUEUE_STATS_LEN is based on ixgebvf_stats, not ixgbe_stats.

This change fixes a bug where ethtool -S displayed some empty fields.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ethtool.c b/drivers/net/eth=
ernet/intel/ixgbevf/ethtool.c
index 508e72c5f1c2..d665de8849a2 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -80,7 +80,7 @@ static struct ixgbe_stats ixgbevf_gstrings_stats[] =3D {
 #define IXGBEVF_QUEUE_STATS_LEN ( \
 	(((struct ixgbevf_adapter *)netdev_priv(netdev))->num_tx_queues + \
 	 ((struct ixgbevf_adapter *)netdev_priv(netdev))->num_rx_queues) * \
-	 (sizeof(struct ixgbe_stats) / sizeof(u64)))
+	 (sizeof(struct ixgbevf_stats) / sizeof(u64)))
 #define IXGBEVF_GLOBAL_STATS_LEN ARRAY_SIZE(ixgbevf_gstrings_stats)
=20
 #define IXGBEVF_STATS_LEN (IXGBEVF_GLOBAL_STATS_LEN + IXGBEVF_QUEUE_STATS_=
LEN)
--=20
2.14.1
