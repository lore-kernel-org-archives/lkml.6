Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907919-1521498407-2-3425023975920421930
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
    t=1521498406; b=TaEr+H1S40w876sYJ7BKGiha3prS0y57uJkFd1DpFu29xda
    aLlfgnI6sfmhCUl+xl75thHaZ/5ynPvYBLNjub4OUrxSFQafe2rLTWAv+bZmldPK
    e8xxAfmyexZVS/6lwDGtp88hl+ket6LOTg9nKbIbhjrseyWcBxjvLsQmUfkSFKtF
    ++GS0n+iQ4N51/gV6VDZ0MFhiwPwFOMELIBxyJexFofvPCLteaVnr90EzgPw053b
    cv6QhnvuMhp0auleMe/fZEGEuZJc/FAvhD6s3m3EYIBD+xTfVO1KCGBga26dPFy6
    OH/hlzMEss2QKEjo9gksHaI4jftxqYJqPVBHwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498406; bh=AVjhkr
    looSa49j/77yrXTC8OSQlvKkwhhpXo5rXiWmA=; b=R+/WKR+3S+0Gt6hJeRBTPd
    QH8H9KIu787BTIWfmuTwaNFUxAmKfMdwaMB/8a45siRlSK5qeDneVCWKpeQ7/bQU
    A/wtw6T/599DO5lCqXmdMjvdeqMA8J14NijrRoFto23/Tq+VUxvH/aMves6No6Q6
    PuKRmrRRlZZJdatQvEn1aP7WgT1+R6/ViUXvhnpbHiic3DQREfbkE+ye+VfARiWp
    Xv14GJxcRygIqsT4jcYDNO7O/WomkPLDdVfJdy9nRV2H0UQjPlD5haLRDCGrjkr3
    bM/D4+5IkJaObdmlHQmz47r3BxW9JITWdZQoujT8lf3f66vkTkn4AqhgFoP8I1tg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VshvgB8q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdelheenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VshvgB8q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdelheenucevlhhushhtvghrufhiiigvpeeg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970009AbeCSW0V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:26:21 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com ([104.47.36.103]:38940
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933866AbeCSPs7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:48:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 066/124] iio: imu: st_lsm6dsx: fix endianness
 in st_lsm6dsx_read_oneshot()
Thread-Topic: [PATCH AUTOSEL for 4.15 066/124] iio: imu: st_lsm6dsx: fix
 endianness in st_lsm6dsx_read_oneshot()
Thread-Index: AQHTv5mv4RunrjTsbEuVUeIo/U5Kzw==
Date: Mon, 19 Mar 2018 15:48:12 +0000
Message-ID: <20180319154645.11350-66-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:splcnU+hIySVeQYT7SXADarnQjLN8s20hP7q0F1B/aTlNjkK7jYZmGQ987NJdDEv9mGATvhmBfyPMvNFqdTlcnW8xICGNBSTDzIXCjaF5noLooMyWS7smd0BZJSD11QShrJvoLTlE+7NDlYaZz6e21Kkh53CoJBHxEnUYay1LJIqr/ecGC6p9DokyoeCgKEsHWUEDNUWSXqhHT5LX0mkEce2CvA3FrCIdBdgQPxDlbhp1m4Nbl6MEIDa+gUnLfIu;20:pKadT4LP/32mTsO746ia8+1in14dCKL/tINr3nZX1emySCuPXG6uOoo1+jRDHfKmeowiw1H3xtjcCfLRJ4Zafa4tWF7thknzGHcbiHxazyxbfpoJ9j36zkbAQiBhWPjjT+MmHFPMH+mBRaSoVJHLGuftx5F8Vii9YglC3LjXa6s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1b9054a-776c-4573-7385-08d58db0ea02
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-microsoft-antispam-prvs: <DM5PR2101MB09362E2EE5079B073BE1D2FFFBD40@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(2900100001)(3280700002)(2950100002)(10290500003)(66066001)(106356001)(76176011)(86612001)(6666003)(478600001)(5250100002)(6512007)(6486002)(107886003)(36756003)(97736004)(72206003)(25786009)(6436002)(53936002)(7736002)(2501003)(54906003)(110136005)(105586002)(10090500001)(2906002)(86362001)(305945005)(5660300001)(316002)(8676002)(6346003)(1076002)(3846002)(3660700001)(81156014)(4326008)(14454004)(26005)(6116002)(102836004)(8936002)(81166006)(6506007)(186003)(22452003)(59450400001)(99286004)(68736007)(15760500003)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: FVW98AKdPa2xmDodXD527riZOWCm+iBIzwE8QHFJvMWPlOPkpOR/mV9PIPSdRNRAZZpmk8Ksgs96kC1hUyc/M/2yU3rZuZtUH8B2sB0v9R2B+fzFeJemDDMvSE2oR8ee2MJLBUsnE2KAuJFENOoRuUXj4jgeSPV3VjLGonhmwGjIN1GPyk0eVnrwVHSqVTuqWsG1jox9ZXbrKcXjfcmzVUfuXWYCw62z9OwcZZXd7znkS0MG3OaMIgtiJmnAhpA7CM+hsDbuFrrl4RGSBnfw8IQ/vejE8ZR5PJ3kIcelqoa3hb30343Uu7FWl7fmlfW5kEEi0Snm5qytAdMIwKuE3w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b9054a-776c-4573-7385-08d58db0ea02
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:12.4694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 7b9ebe428266fb7e0a6d769bb3ff3fcb6044b15e ]

Apply le16_to_cpu() to data read from the sensor in order to take into
account architecture endianness

Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu=
/st_lsm6dsx/st_lsm6dsx_core.c
index 239c735242be..812cd25f284e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -448,7 +448,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_se=
nsor *sensor,
=20
 	st_lsm6dsx_sensor_disable(sensor);
=20
-	*val =3D (s16)data;
+	*val =3D (s16)le16_to_cpu(data);
=20
 	return IIO_VAL_INT;
 }
--=20
2.14.1
