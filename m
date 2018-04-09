Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234701-2-17012572849336670559
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234700; b=AWcDg4lymWFfq5OlPqc498pyv2g7jH05i3zOxKIOXXNOpvu0PM
    t5hAcedPNz6WFCs1g5Bfm7Z58aHTaZZnliaMccl3r69s1/B/i/8YxD5zHn3VG8z8
    6zp2HVfXUoqQU9SewVk1MJwpL7wuflxFtZalKGz74S6tlD8YOSrALzkRSZijx3OV
    zOzGrQz8dS8f79fLf6wH6eaV5r9+b0CkcwwiihWNre8PQAz4iQMsRG+QkdE4B4wg
    vIyjKrchseXF4lOKKJkmIfpdLUxYPsleLImeF3+99r8YoQz9UFaC3wMjkp6DPbAi
    zJUsCUx1uKLpU0UrL+GPShLjhbmX36K6l4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234700; bh=80knjo4JrZ
    2kR0bo6U335lpJnIlnKb6mr7cMXu/15SA=; b=LfB5xqNnNYjxC6vQd35DwBUFPS
    Hg2QQu3BcmNQyzUpXhGBujoEelc1v/wkp8MnAt+wNmXpi8U65cuHW0gjGiSQGKn/
    bTu8zWZsfNwaRUTcraPmAT6jcBANAglxnwWrAv+B5mflAgwB13+WUevc3eLzwwvO
    UgArkI2IxUZE7MPGQ0fASAtZ7QpeYL9uLyErj8IhOk4mtynVZIxMDR5i3sAq9XhG
    uPRjWNkUd1k0C4LSB1PCUg4eL9Vvg2jIZR7kR00o/HelYjDxi3ONdrDrDO7lkX9b
    oBVeAD3jMr1/zGdNvfeOpSweGWx9Ea+QGEL1eX4nmkMKKQMcS/udMABeQGxg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=pAQ2A8Wh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=pAQ2A8Wh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK7GiEheMp7pfEgz5KR6R2r1astiXM1BrQ2vDO3GfuJBnDLRxmcpnz7w4Q84Wy4p6csa2kdHHiknkRzukSuM489hFmavDtkItd9YOaBqvqN1aabsdaUt
    QqML2xSrxze4uJCg/9SoRGMfxJymAdOBph5bi+Bvi5I4RPuFeIPidTwX7iByBhBUuUaiy170gyhVKBIkGwlsG+Rq1peP2vWf0boYva5qivpHzcxfwsKuUj4X
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=YF8PD-7RLpV57KenVnkA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756782AbeDIAmc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:42:32 -0400
Received: from mail-sn1nam02on0120.outbound.protection.outlook.com ([104.47.36.120]:45955
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756772AbeDIAm2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 095/101] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Topic: [PATCH AUTOSEL for 3.18 095/101] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Index: AQHTz5uN7jhZmXFu4kyyf9DFqut6EQ==
Date: Mon, 9 Apr 2018 00:41:51 +0000
Message-ID: <20180409004042.164920-45-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:+FsWjYw6p5js8zKoa76Q8s0JVWG8rZiO0ymeAevv9Gop0ju1cvYvaEhlpiOOC6GKrpfC1QjHrjYYXzLtWWgGMq+kVT5begTPT4vkfxzLBbFQmbKZdTtgo9RRb0Mp13fhyWJfNSRMyWsInKPPDTIfL0dZKMLzz8JaBWiN3VpoeWXAcf5BfVpaCZpuvSh1EMCufyJ1uxrNBroo++1gtggbYzOWZUoVSMhaGd2qIFDo66cACnzimdt/p3HP80LeDz5r;20:87b075yejGuqd8PUJOR1QfxHgsH577eXLR8hC6P/DDpRxvsNPt94brr2x4iJVcftIDiW4tEhxvqeSVvOu96Fv2tjmJwOtlglXz5oYGLok/busyjCx6/UIh76f4qKXt0ST2tksjZCu+B/mB+mcgbxbEjxJC7OYZixhhGrppqBS/k=
X-MS-Office365-Filtering-Correlation-Id: 8d75604a-2ff7-454e-bdd9-08d59db2c3f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10305BB7C621512B02EFD233FBBF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(39860400002)(376002)(189003)(199004)(7736002)(5250100002)(53936002)(66066001)(97736004)(99286004)(6506007)(68736007)(186003)(26005)(22452003)(86362001)(11346002)(6486002)(486006)(305945005)(316002)(3280700002)(110136005)(76176011)(476003)(102836004)(6666003)(446003)(3660700001)(5660300001)(2616005)(8936002)(8676002)(6512007)(81156014)(81166006)(2906002)(36756003)(6436002)(14454004)(86612001)(10090500001)(54906003)(39060400002)(2501003)(105586002)(25786009)(4326008)(478600001)(10290500003)(1076002)(3846002)(72206003)(6116002)(106356001)(107886003)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: zNLyMufk2vhEkwhMS1fdGPX2yULWRqdgxjGMAkbQwM5FRaEtefo3xV+wAwrDbf3F8e7Etn6bf8B/cC8OfLarEkAvxQH+uJSqHhxtvoo8IlyAc9VoTd63NjGlChQa3bcQ2J2vOgGl/wJXpJrcAa56gc2GuuN0UiYaA4XfVMrd7/6eQyTdLEjQp4BRA7cddsPLkeqhN6kZeHaxVRE8EZljSULeRzNb9z0s7li80oJ4FrtLLy7iplFe0gt5HXxd8jMwxlvDPzYb+TJL0ZhBI8m284NahvAP38u8Hxm5DFgnlevZYavhSPzIKHxYAoqZJZUVvpo2hTiGOgiTTDeoc/QnOgTp64ft7+7zMSHvwrPF4kMduozGiKdVTZAPEh6yw1VySmPdmrDabzAhB/WKyJHAgPstdm2SI4aTRFb7UohgU9Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d75604a-2ff7-454e-bdd9-08d59db2c3f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:51.7366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index b2218b755dab..fdb72e4dc776 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6413,9 +6413,7 @@ SetEARetry:
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
