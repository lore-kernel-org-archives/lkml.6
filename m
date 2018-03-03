Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2878775-1520036554-2-7604199947349209113
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensvro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520036554; b=oXQAgGwerJi2hdL8zTxZ1/wkR9WryqOEWV32sgW7UfOrQj8
    72UUM0gNqiZIp3FWk0PslUNNyXdsTjrEVfMfmZiA/Q+hD5iSZuJwI3xdX5sBpK2O
    Wf/ugeOXK5Y/5NrwXqJK2KZ4ekHOw+AGwtYnezzPseeQkF1j/xe9zXHsiIp1U54v
    ht4LBq9YkwnRCYPM1KLQZcdmMNjajoFrPr/ZaOSGIIJwq0LSIpx0/zBfDwb4wFiM
    ++tLb32oBwTOdVQnj2XCpjie/Kq5ctnUly/QYVPf7Uy1RtJddLQDtNGpYGUltq5Y
    e8D9sNl8s8rQ1mCf7by8P8jp0UDbijnB2LyN87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520036554; bh=P
    qngSue6Nwl4LiAhjvanXmTmcSEtU+UFQnV/6r3QaSE=; b=qL+RkgItuPAXCXkIQ
    tAu5Ec4WJp6kOMg6MQBfJjvakRnbqlApkXr5LEQK+kUBZxdWvpXPwF60eDqNRfNz
    K1gP5oyGHoLKaSwQqFX4M61okjMwV9hj+6TDB09+SL2orqqD9qnM+cW/M7okrv8x
    wnR82E/KPB1oQ9TKnGAXdv+JAYlForwGsmrpny3cnlP+KQ48cYxoxTI9vYskypuU
    DgTmSFukkqR7A41gy6AFTXPABrWsjw38CILU0PBZGrXp785st3NZZLNUsIFtNxMp
    ttnxQHvBGJ7MOf5TvtKvkUTM9Q6FBZieoH2OCx8M4udWt4hFPF+M4fKrBvXYuNqG
    Kdmaw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OpNMBo26 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OpNMBo26 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Dexuan Cui <decui@microsoft.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan
 <kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: respect what we get from
 hv_get_synint_state()
Thread-Topic: [PATCH] Drivers: hv: vmbus: respect what we get from
 hv_get_synint_state()
Thread-Index: AQHTsoWwgUp447acKk+I3OE1dLwjhg==
Date: Sat, 3 Mar 2018 00:22:18 +0000
Message-ID: <20180303002155.20689-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.15.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; KL1P15301MB0054;
 7:AmB2cDRqIe2lbUm6xQAO6R6Mh+/WXWDttcnMUFBIj6yw4KUSptvlOc3OAB6J9xN3b/z0U96PaQWjvZKebMruvBZLgIhq6GRorCrVjXUSVEk62zbeozReUWq8ZP4FU4Mm+lnaz9IccvC7N6XgyyjNGMW2cABO69vum3Cc68qDoRbvH+KFBepm9Ro1bTd8Te3FgFkbfeZAtPqVY0uDvIxP8Dr9SaBNGoH+EcXRxYb10Ee1TtrZoJB1dIuG2oCsE6/S
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52550721-e9f4-4b25-c711-08d5809cd35b
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);
 SRVR:KL1P15301MB0054;
x-ms-traffictypediagnostic: KL1P15301MB0054:
x-microsoft-antispam-prvs: <KL1P15301MB00544F6EFDF50341ED3EEEB5BFC40@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
 SRVR:KL1P15301MB0054; BCL:0; PCL:0; RULEID:; SRVR:KL1P15301MB0054;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(5660300001)(2906002)(4326008)(6116002)(1857600001)(8936002)(86362001)(2501003)(8676002)(6506007)(2900100001)(6436002)(14454004)(3660700001)(86612001)(305945005)(36756003)(99286004)(316002)(97736004)(25786009)(110136005)(1511001)(102836004)(54906003)(81166006)(10090500001)(81156014)(59450400001)(3280700002)(26005)(186003)(77096007)(6512007)(6636002)(478600001)(3846002)(1076002)(22452003)(10290500003)(106356001)(66066001)(6486002)(50226002)(68736007)(7736002)(105586002)(53936002)(22906009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0054;
 H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: +08jM1Wc2rdBTiAu0PdG8OW3DbrxxkcESf5bjPGUMun7ke11JWnyB7BDRsnyEs65OZXv/xqIUN5B5DxG5rbcb6IUss2PvSRpCYrXmtDWjzB0cINHjBLmckHxtqOv0FsV/rQRV6McgMslxIYu5LadpeIlDXfnbLbYt40GzWhuUoI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52550721-e9f4-4b25-c711-08d5809cd35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 00:22:18.7780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 "driverdev-devel@linuxdriverproject.org"
 <driverdev-devel@linuxdriverproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I didn't really hit a bug, but just happened to notice the redundant line.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: stable@vger.kernel.org
---
 drivers/hv/hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index fe96aab9e794..2bdb2bba911e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -252,7 +252,6 @@ int hv_synic_init(unsigned int cpu)
 	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 			    shared_sint.as_uint64);
 
-	shared_sint.as_uint64 = 0;
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	shared_sint.masked = false;
 	if (ms_hyperv.hints & HV_X64_DEPRECATING_AEOI_RECOMMENDED)
-- 
2.7.4
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
