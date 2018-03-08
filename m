Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520484967-5-9665953197925436520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520484966; b=VIwDtlmjMdfi+nserQQ869urhiF0bWKorN7RdN9VxEjMYiJ
    fsrE071fHD3rRyg8597ZLqGOkXHFZb7TJv12n7yyzpX1pMuK8kNadQ+yV/IgGtY4
    AObSGo8GLZdbKAArugKHgzaiUC3B0oeeDwVMH/4ddObNhM2EIROpngTHKsSDCKqB
    ZdZIVejhPryZVWYT+AdmmGhngm8BEz+wt1PFUmrPYShe9VruEfLiZEB5vuKeJI0M
    1LHWJwGC4P8vL11iZlfnOxX9y9E0cBdlJLqBUmpPml97gpKsyfLu78/bHpa8tW/c
    RcsyU8XW5F4bSPWPn1BIFTvaBiVnzKQ/iEauNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520484966; bh=OhmnnOTaa9e9fU5MRcReaNYh0W
    91I0DZrbsLG+whs4o=; b=S4wwTzcHYIkQzURHblKDw9Uxe8+YcGD3zfU+6+QaHD
    oiL9O85PJpyRLtVwmH49cGfWL23RQGuHD8OuRbvV80F1Dyx/zkuaZbsEvQzIqpJt
    kcU6vJr1PL53bNoM0kC18sJKO9n6/biNrO4h5wlTO3BYXP5NQ7POWahVU7Up/477
    HLJotkR5kEt1k1AJwDq1yZEresTgngDbMBCP8Qzxraw2sDifcpjYHVPrmxxQTDdA
    +cBo2AR9uNnDkUK/dnP8P56zN9BNrzp7KW+iyTFaRWkT/JWvOwpygkOXiaHh/bER
    T6B2kbcKGzYPmahmmMW3p/K9GD27P1OwHbc2TE1CQD9w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ie3D+u5i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ie3D+u5i x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeCHE4D (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:56:03 -0500
Received: from mail-by2nam03on0095.outbound.protection.outlook.com ([104.47.42.95]:43489
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754570AbeCHE4C (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 01/78] ipmi_si: Fix error handling of
 platform device
Thread-Topic: [PATCH AUTOSEL for 4.15 01/78] ipmi_si: Fix error handling of
 platform device
Thread-Index: AQHTtpnAUeZbEvl8XEOMf3gT0CPi9Q==
Date: Thu, 8 Mar 2018 04:56:00 +0000
Message-ID: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:ZuJOZ+T7rlC/ErGPvZzMFCKTA/RaZpxQQKVt+l6L7TGRKjRFjggDEgjx13+7U18vi3xB/eeKkhRjghon1v8ozAFqf1XlDsX3TZQDbhR5p5ZFhsOy/j5a96lytEnkGjyZ31zO+6JGRKRvMhUV9bRkDafolBjZ/iUQ0jjnzCCW8t6v68Dn3raqN5byXE4dsjfmFXSwuYV4AHSLBjfEFl02L1qE+62yU421ZDONE0ADxiekXy8Ml/CDqRVZJR8y/da/;20:+hq91d9gMc8YDfkINgHyKkMsrHX2bpihf9pDvrfT0OUv6iNsorGac2TbdrEqJuzRT4aBZXM4JkwaYpLR9JpywBnDqM3+ZyLoo7Ko3H8ud5XdpJzsLrOpVmo9A48iCPgm6gCXxf/CLUUy0rdPXhjmqtbALo8l8nJ2CMVAX9eqF9Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49cb4b75-2c99-410f-82aa-08d584b0e379
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902F99CB57FC003A8E833E8FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130873036417446)(194151415913766);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: i+QaHnoDdEHiKrqXf7PQPZnO/nHZKs/ZVnhKb7P8ylpkcGNmIV+s9R/TULRncOzFiuU7VrWAGqWXSuamnMZpDfTqFOTjbBaLvo+kpKJholQg8kXOFsDeZ58UvnxayQ5ZJsmjY0QkacWBBKmiMCTeagiZikCNVAG6HOdDdEBgA3ipTUCfQU+YzG9ufHqDq9swL/fy3jbG82nqhX3hV6FxDdsXvfBmi48mKYQCTLY87weRtpVbetFgX4Qqcx+whNFGdXXEHPb7xuICFMu/J982LBpSg4cabGXiaQUh5dmWTgFd9ILStTaUStFlT3LuYRWSaxzFqIOypogY5w5JUSZlsA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cb4b75-2c99-410f-82aa-08d584b0e379
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:00.6804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

[ Upstream commit 174134ac760275457bb0d1560a0dbe6cf8a12ad6 ]

Cleanup of platform devices created by the IPMI driver was not
being done correctly and could result in a memory leak.  So
create a local boolean to know how to clean up those platform
devices.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_i=
ntf.c
index 71fad747c0c7..7499b0cd8326 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2045,6 +2045,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	int rv =3D 0;
 	int i;
 	char *init_name =3D NULL;
+	bool platform_device_registered =3D false;
=20
 	pr_info(PFX "Trying %s-specified %s state machine at %s address 0x%lx, sl=
ave address 0x%x, irq %d\n",
 		ipmi_addr_src_to_str(new_smi->io.addr_source),
@@ -2173,6 +2174,7 @@ static int try_smi_init(struct smi_info *new_smi)
 				rv);
 			goto out_err;
 		}
+		platform_device_registered =3D true;
 	}
=20
 	dev_set_drvdata(new_smi->io.dev, new_smi);
@@ -2279,10 +2281,11 @@ static int try_smi_init(struct smi_info *new_smi)
 	}
=20
 	if (new_smi->pdev) {
-		platform_device_unregister(new_smi->pdev);
+		if (platform_device_registered)
+			platform_device_unregister(new_smi->pdev);
+		else
+			platform_device_put(new_smi->pdev);
 		new_smi->pdev =3D NULL;
-	} else if (new_smi->pdev) {
-		platform_device_put(new_smi->pdev);
 	}
=20
 	kfree(init_name);
--=20
2.14.1
