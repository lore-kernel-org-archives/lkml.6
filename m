Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523242499-2-3334467391692318827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242498; b=Cep/YoQSXN+GLi4guJGxxZAqIlgajI4PLEnAmjcHMg0r+pInE+
    uEVkk//Sg7wAjJnEVTpWckTLWB454j3TH4al8oURqr5mkQVxB5cvyZCYZm5W7McC
    qiZBn/PrgZEIX1u2psYtwRnFnjqBdR0VqNavfZfD0rPKOB2L5BvWd8vWKu2WC7MB
    Qq7M/6cptR+CBxZwyacLqrcgBT9XcLsBXn78Ufi8uVgT9Fucde1ZxTcwkT910dvy
    AVnkLoAHCMe1K4IkHKfyvEdoA2662/78utmqBssrjCxccLIAaqXme9oAYwHRXcD4
    70nzTwSvau2Vr8vzKivdHRKdUhlN+aA/98Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242498; bh=1mmgCQVKYJ
    8unkZxMp+zJXj6A4XQ1G7IVwhrwBSjv8Y=; b=th/h10nvdkY2d3lVeuA6A2k1kD
    CM6bb0+JTG7HNeymhZi9XquKxxa4H7eIaxaOjaVk2YFLmtXsSra49IdXSFLqPpFj
    aYGUMr9RM/iESTZN28KCylD4ub6P6c1QpO2KMZhu0fmp/T6u9Eo3BIwOUFfmV2Tr
    kwJlVXOovJj+yLRHHutsr3VWTn5Ilqd2AxEV4IspjJEjyDQq+TMJ9NIoiXXKMHKy
    HK15R5l2F88/B8fvv7JxChs4i781rsx6ZpPEmGlnZq4hzW0bF1k58WSAYBvXkrKi
    l7rLgk70/ZNV87gE4TTY8jsKjNkHL/D4WHzazKcXf8q0m9G0zk8izyvk0ROA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kWS1rpxt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kWS1rpxt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCQpCGcN9iiE5z/WtY05t2SU9gY0EUTsirByKVjzsyJOewExAffdTHaai13nQ/wEgTNQXbbJeI+ZNtT3aq1F42JruDHhKkBjINoEewHX4/I7nx8jX4HD
    kChwDclxEML5r8xjRJ3k4UljRsXFNO3/xKASVUtCwwCJfJcv9lvWhgcqhlG1zYt2mgXavJ74L4Zv3VYWU9XYxKjEs7zzHCJJOB7p6MF0Pg/JG3k+hugFaFS3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=YF8PD-7RLpV57KenVnkA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbeDIA0R (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:17 -0400
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:42561
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755262AbeDIAZt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 135/161] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Topic: [PATCH AUTOSEL for 4.14 135/161] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Index: AQHTz5i9G1xFGP1bU0qf/biXd0eR6w==
Date: Mon, 9 Apr 2018 00:21:43 +0000
Message-ID: <20180409001936.162706-135-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:agcs5cjZrIZRBWhey2G+ilXRQ4UKGT9D38ecx3CDfFClk5H1Ge5BSt3B4a5+DDFJTmsqd/sI3dDwxHIzzZ9CgIwI7vSpdjtxtLxZTb+t8PAhq61V/yX32Ijl2vDKtoRp0prMdmAvwOS4rNLHo+G8ENWqkkMoq1TEgPpyP/YmNfBnuWFwDqYbcIleKyTMQUqSNk5Ed5GNJbUIjvFfHkbqx9hcebDwCCtscRhkgNChn4HPJ+ZHBgWZpVSFEzGbrc4s;20:a8fHW5Z8rRCB46eRBEz+6mCKRguoxVYoATOFhXZ0k7iJv4CxfjpMTWa1PlhqhJIfFRtWKXjek3tXzV+5JkM4lFMzAem5SwgO4/WcOZPIf5Wgbip80Mp4DdFlTYlNHhKk1SPa3/dV16BE6jBmjHh3QTUqRR0kPiUuwfighQstqAE=
X-MS-Office365-Filtering-Correlation-Id: cdb78d27-07df-40b6-3094-08d59db06c62
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10132E555D06374A10390F20FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(22452003)(110136005)(39060400002)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: x4CETqKwm/b88bAjVh5bKSxs86rbDaAyDRbKS0Zc/eX3sfEFegR0t7ieKzZ+0Sh7LhnmVuFuVJS4rYi/P3h1PPKeztxQMPpmdQW2Zwj9H5Lfzu+uT4+ucq9V63YVRUOcQdNw/dzK6QiqCnz+Yoh8yHAuUm0F7ZixAREFLcZnDPUyTYryrUQpvwWBRTjcCAI3x4OK6zB1Kn0Dm8PWZ6RFrGOYWNLU6VOwEtmcD9Upaip9AV/qxed4kKEEdQh9rMi1qNx4oekOWylimMkvKwYkJ4kRBdMrrZiGW0hplWnplOmur934TJtTbVNLkdfZin2tmsyeijJwKpfq6n/gm/hlFY8KleivhZB6etkmwmggR1h+TVOl1sKHCJpRjNgYRGkj78/omSi52WHEPkqXRyT7QSv6cMHrmtWP7SfFeFU9x7A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb78d27-07df-40b6-3094-08d59db06c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:43.8936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ade7db991b47ab3016a414468164f4966bd08202 ]

This bug was fixed before, but came up again with the latest
compiler in another function:

fs/cifs/cifssmb.c: In function 'CIFSSMBSetEA':
fs/cifs/cifssmb.c:6362:3: error: 'strncpy' offset 8 is out of the bounds [0=
, 4] [-Werror=3Darray-bounds]
   strncpy(parm_data->list[0].name, ea_name, name_len);

Let's apply the same fix that was used for the other instances.

Fixes: b2a3ad9ca502 ("cifs: silence compiler warnings showing up with gcc-4=
.7.0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/cifssmb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 35dc5bf01ee2..7fd39ea6e22e 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6331,9 +6331,7 @@ SetEARetry:
 	pSMB->InformationLevel =3D
 		cpu_to_le16(SMB_SET_FILE_EA);
=20
-	parm_data =3D
-		(struct fealist *) (((char *) &pSMB->hdr.Protocol) +
-				       offset);
+	parm_data =3D (void *)pSMB + offsetof(struct smb_hdr, Protocol) + offset;
 	pSMB->ParameterOffset =3D cpu_to_le16(param_offset);
 	pSMB->DataOffset =3D cpu_to_le16(offset);
 	pSMB->SetupCount =3D 1;
--=20
2.15.1
