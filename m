Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC34C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE21D20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=LenovoBeijing.onmicrosoft.com header.i=@LenovoBeijing.onmicrosoft.com header.b="S1EYaEVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE21D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lenovo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeIHCu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:50:56 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.213]:38315 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbeIHCuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:50:55 -0400
Received: from [67.219.246.198] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-east-1.aws.symcld.net id 0E/4C-25673-7B6F29B5; Fri, 07 Sep 2018 22:07:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSW0gUURjHPXNrMifGVfPLSw+b9WDN4iqVQqQ
  PBhYERYJZgY457S7ursvOSNpDbRCUiiGLG7hmqd289GIFm6YYlnmJ2FxJvFRiKeUmXiqL7s04
  2+3l8D/f73/+5zuHj8Y1HiqKFoolwW7lzVoqmDC+mcQ4z0fnoYThBiz5+byHTB5qv0ClYRmL0
  2NExvub6/ZiB0mTNa+wOJc0dpUOULZxpvj8OQfuQI9WlaFgWsP6EQyN1RLq5gGC27WtmLIh2E
  Yc7s23kio5h0G590xg8wLB/Y7P8pmVNMVuAN/pflzR4ew2WKy/TCoaZ49C7dNBStFhbBY87pi
  iVM9hWPC8xFStg87JStlPy9fFQd1oqFJmZMun6v7leMSugU8DNzA1MhLGpi4ta2BZuNLhxVUd
  ATOvfpCqPxPezTmQWtfCvdoRUtWx4LtUjpT+ga3AYeJs+QoVcLDgcgWC9kDj4BNCNfUiKCt7G
  DDFg/+nJ5C0HXpe1xGqLoDBgVOBjlLgrG8kUF8HzRWTgaAmHJY6JygVxEBze30A3CehcdxLVC
  Kd+5/nqXoz1N19R6l6E1yrf4u7l78mFPqrp4g6RDSjLXl2k8EoWXiTmdMnJHB6fSK3hUtM0vH
  HuSO6IpETeFHi9Dr+mKgTSyxHzPk6qyDdRPLg5NvIyDuopczQjdbSmDaCmVlyHtKszivMLzHy
  ojHHXmQWxG4UQ9NaYEoVFmoXDELxUZNZnr7fGOgQbTgz+0HGjGjjLaLJoKIBlEJfbHI6cXqux
  yWv3+blVUNYC61CVCTzTMljlQPGIuufuN/z7EOxUWEMCgoK0oTYBLvFJP3P/SiSRtowRlJSQk
  xW6c+t8iTLbwlnhtsqlYYk/i+KciCs4u3aR1VtqetbMoc83bM17KmTuzP40tj24If7DDsa4mM
  +9y3tQt/rr6e4hF3fdeI0fqLLuxj9xdt79da1pI1fc9olgxmfHt3akx5mSfVn556gMvsOZLsa
  4kzpp7M608R8w86G5Gz3otPgKMGrLr8vcEefDJm3xy2klrbsL6rREqKR18fjdpH/BU1IzVjKA
  wAA
X-Env-Sender: masbock@lenovo.com
X-Msg-Ref: server-19.tower-406.messagelabs.com!1536358070!277760!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13852 invoked from network); 7 Sep 2018 22:07:51 -0000
Received: from unknown (HELO maesmtp01.lenovo.com) (104.232.225.2)
  by server-19.tower-406.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Sep 2018 22:07:51 -0000
Received: from HKGWPEXCH01.lenovo.com (unknown [10.128.62.30]) by maesmtp01.lenovo.com with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-SHA384)
         id 5877_ddd2_f939dd2b_cbc2_425b_9e4a_6d562ef1b715;
        Fri, 07 Sep 2018 22:07:45 +0000
Received: from APC01-PU1-obe.outbound.protection.outlook.com (65.55.88.18) by
 HKGWPEXCH01.lenovo.com (10.128.62.30) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Sat, 8 Sep 2018 06:07:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector1-lenovo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/1gOdaFWjN6M48R3KGdZLzQlKhSIU2Mf7Kscojtg7A=;
 b=S1EYaEVbAX3wx3Dtepp+1CXo11IWILiIZUDJjF/k1sZjQ/wiS0GoY2hqQJYcWWza9jSfk+PfILcvTQzbXJL2G1CpobnlTFZgNxIffKvN7fn1DVOsaeKun4eRsYfnSWs2ne/XP60SVOvuZaxaHhrp+6eCns3vtCvgIcSzG8blyOs=
Received: from TY2PR03MB3519.apcprd03.prod.outlook.com (20.177.20.212) by
 TY2PR03MB4032.apcprd03.prod.outlook.com (20.177.157.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 22:07:39 +0000
Received: from TY2PR03MB3519.apcprd03.prod.outlook.com
 ([fe80::5cd7:c270:6666:a805]) by TY2PR03MB3519.apcprd03.prod.outlook.com
 ([fe80::5cd7:c270:6666:a805%5]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 22:07:39 +0000
From:   Max Asbock <masbock@lenovo.com>
To:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chris McDermott" <lcm@lenovo.com>
Subject: [Patch] acpi_power_meter: remove 'ignoring unsafe software power cap'
 message
Thread-Topic: [Patch] acpi_power_meter: remove 'ignoring unsafe software power
 cap' message
Thread-Index: AdRG8eXC1bQxsZZWTi21UkZ04whQPw==
Date:   Fri, 7 Sep 2018 22:07:39 +0000
Message-ID: <TY2PR03MB3519C32A5BC640BA41356CBEDE000@TY2PR03MB3519.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [71.237.254.165]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR03MB4032;20:y54PHk3GB6Jp3jdBSLJH/N5x4cpvUqmU3qmXhb7CuTuQQrLSLUeJFiyvuYorGY3YFJWNAsOrZISn9En8yBbLWeCuyJe9vH7xXi/HTc1AatCBt/V/DM5BBdtCpJoyfXnn172BaP10C2M/m1wiF5CMdcq7pbDziPj12Q9H7K8T01wB6iPgRUZUJeHtPOGVonSBx0r/7qvyhkoWyW+kn5UXuMsxYcxfA6rafPY6JI20q2fJ19MIl7CLEkRDi/Jh8tGPf2b8rRAzqVL3pd5UDSNFIwOq+LZmBa0xLWBrMmALgwQHPuzn38wPrkVGCN+quK3FhQzaFR19nBDGi9DMpdthTg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 05c6e8a0-214e-44b8-794c-08d6150e5383
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR03MB4032;
x-ms-traffictypediagnostic: TY2PR03MB4032:
x-ld-processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
x-microsoft-antispam-prvs: <TY2PR03MB40328CCDC39C624442B67B03DE000@TY2PR03MB4032.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:TY2PR03MB4032;BCL:0;PCL:0;RULEID:;SRVR:TY2PR03MB4032;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39850400004)(376002)(346002)(136003)(189003)(199004)(106356001)(74316002)(86362001)(305945005)(105586002)(6436002)(99286004)(6916009)(5640700003)(5250100002)(2501003)(25786009)(2351001)(5660300001)(66066001)(2906002)(316002)(54906003)(107886003)(2900100001)(55016002)(4326008)(33656002)(6116002)(3846002)(14454004)(15650500001)(97736004)(9686003)(8936002)(102836004)(81166006)(7736002)(1857600001)(6506007)(256004)(186003)(26005)(68736007)(8676002)(81156014)(478600001)(476003)(486006)(53936002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR03MB4032;H:TY2PR03MB3519.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (HKGWPEXCH01.lenovo.com: masbock@lenovo.com does not
 designate permitted sender hosts)
received-spf: None (protection.outlook.com: lenovo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qg9WrewC+oWL6gTP9UNwYVQaGz1YTB9oNu+Rkk75/Hs/0fEFW6/Se7JvTVZ8k/L1iwR435Kazqeu8BmzLFI8HHE4xdkvtWQ5V3fd4E399IN/BGY17+m9pOSn1ihdtPxIfknmH0b0k//raasKRLchwtl3iiCAavlBuVfb16pXuDa12PI1AqCagcLer3D1J0zsiA5wWKBu/iDM4P0r/RzXXp2xaTGZmbll+wyJSbYfaSsGuGkx7+0F6D0ZuGsEnVYCGN/o0+fBtVbY8gKVNPFdxQEEe8sV8MmtxXwpFmFwhnoWHj4xZ7kIY/ihLOeFUjS+QQJFjXTUesZf3lluucfZdpAKS5zgqJovdSVamW/aAYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c6e8a0-214e-44b8-794c-08d6150e5383
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 22:07:39.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB4032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time the acpi_power_meter driver greets users of non-IBM systems wi=
th the message:=20
=09
"Ignoring unsafe software power cap".=20

This message is generally interpreted as meaning: The system is operating u=
nder an unsafe power  cap and Linux is ignoring this fact, thus living dang=
erously. It, or its presumed origin, has been blamed for system crashes. Pe=
ople spent time writing knowledge base articles which explain that the mess=
age doesn't mean what users think. I now have to write another such article=
 telling people to ignore this message. To avoid future confusion and unnec=
essary work, I think the best solution is to remove the message.=20

Here is my translation of the 'ignoring unsafe power cap' message:
'The acpi_power_meter driver discovered an ACPI object that would in theory=
 allow software to set power caps. The driver could now create files in sys=
fs to expose this interface to user space, but it chooses not to do so'.

Patch: Remove error message because it is generally misinterpreted. A repla=
cement
for the message is not necessary.

Signed-off-by: Max Asbock <masbock@lenovo.com>

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_me=
ter.c
index 34e45b9..578e886 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -693,11 +693,8 @@ static int setup_attrs(struct acpi_power_meter_resourc=
e *resource)
 	}
=20
 	if (resource->caps.flags & POWER_METER_CAN_CAP) {
-		if (!can_cap_in_hardware()) {
-			dev_err(&resource->acpi_dev->dev,
-				"Ignoring unsafe software power cap!\n");
+		if (!can_cap_in_hardware())
 			goto skip_unsafe_cap;
-		}
=20
 		if (resource->caps.configurable_cap)
 			res =3D register_attrs(resource, rw_cap_attrs);



