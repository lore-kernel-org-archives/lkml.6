Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121550-3-16100178659479705545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121550; b=vAX903hL1UrQb3gsfXT6aJ69wqmMAGxHE8mFCnsJuWI3nuP
    NazRfxnZf7U8TLsXrNljj80Rn16FTKQ2Lc7nDWp09YLnMttccdsr5a9lUMXlsGfM
    9fXtyTQufG1MOh0Z1uI3nG4BQlwsjBWYizNJ/FTioTHTmfxytT7mn8GShr3gngYU
    qEWTzPIyLlBIvU1wjINry1jnsTvPq19fIcd8+pkysmHJB0wX7LOGDJ505It/d2MQ
    Z4lj55WCstJmJQsXM31x0mB2BnKndTZwBOkuFehoM3TEu5sGaFznf78gEucd364T
    ltXEfqiaNLtnLnCC81KJzZXxYuyO4y3RP+CAFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121550; bh=c+zycK
    3ZznsfgFMyCWuoRln33M1zLNVbkIM0HFF7L4g=; b=gIasTgsmseKHZhmIFSrr2/
    ZQ9ZWauF1OowT3hw89WW30IkTWppdVNzYCGZ8zcOcTm4JsCXQSfG7ONZYSG0rPfS
    X8s0XZPPf/xTf4ZWkPqkjo808c6Nq+Ilg0hYGGb5eLGHsFdBwn/9clSSV3b8kCTz
    NyZucDrd4YSSr/njXXBmzSe3x2K27nLezh54ZwmFu6TaBi4ujV1AqInZ1/gp0Q3d
    N6hx0672mdmIiAMY1XUWwml5KcIVaZJc7qeO662/Bh1TQG+i1HjAvnsmsF+S31cD
    5XrYgus0QR6P+VMWn5brJRYD9/obTAdhNTL1REU1/1ueKYN9sLD7npqYcmZH+4yQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pe4SIXju x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Pe4SIXju x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeCCX7G (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:59:06 -0500
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:54496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933533AbeCCWcP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 049/219] s390/topology: fix typo in early
 topology code
Thread-Topic: [PATCH AUTOSEL for 4.9 049/219] s390/topology: fix typo in early
 topology code
Thread-Index: AQHTsz7xX+847DJP80mvo6dArSKddQ==
Date: Sat, 3 Mar 2018 22:28:24 +0000
Message-ID: <20180303222716.26640-49-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1036;6:9vr/GBwy2kdwjZjQ9u5Ml21xWy9smM1Fjtj05SE/OJkcbnU0WqhMIqQGI4fcEUxqgTIFqsqhgdUlyW2+MSyQUFah3qtQaE6r39NaGQxmmGfqaDR3r9FHBA37wklHrIo6Di3EY9uZlaS9Dli7UYKr40Bsl+D7dZDtE4YXulmPmtCf23B6MJS/xwsUqoLTTfybT5aOR3Sjqq6lc4+EuHsqlQRgzQMk8oHn1ik1qoghhjtoAUlshlah2Sb8dFKs8O8s1AowvAMI5JBEpBiyk8RZKprZnAYsivUZlOIp15jMg/NGdZS2a+bm6a3ov0mgpOLn0kHq6F7G57WuGJmnnLgg9p4G2kJx3VsDb7NYkN1L2rC7Y0e+EeEWuJpiAMInbD8a;5:9xN2HxYBNLf8zTXYcLwANnqHrshOhe4I6PqrFLoPhnvFyAphBLh77YzEKQTS2VsIogefY2CaXBytsZuweiyZA77gFxAMmJZvso5dvtbOv6w0/m24lmC6Ba6DGGC6pYjpJO9i1G40odRSvcsg8qo8l8oEHvb3BiqYpX/KCOug6bw=;24:OQ/GC7nrNSuXz6AlMSxFbr7SkmwIEmH9vxowJHqPbVK+/ugY744ppEmsP/VUrXYFjqEogGu4rl2nu4zvgSpC2enRPp04DwB5rGjF9wczBUk=;7:+hp8Ab2VWOIOoph8dwfTf/vlsDrNgJxJgE3+5c5GL+mYm0eR2jujFZkWwlVTPR2ZiTAIcrydDTVN3wY3vC0nqBlCC9PXA5WtzjtPZmyOy18TjgbN8Iv5Cmj+9xBnA3kdnpEApl3GP1WpqCucCzcV/wSvehxtq9ps219j+Aw0yetaP4WIjG2I7Zn3YLSDjlVODJFn0oJe45gNwpU2VGKra5esJde+ZopT5dKB94xGgxQuK3qzngICp9YvKOO6hZC0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cfffcf7-e3dd-481f-92cb-08d581569be9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1036;
x-ms-traffictypediagnostic: MW2PR2101MB1036:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1036992D56FD1C4E68A07459FBC40@MW2PR2101MB1036.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1036;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1036;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(199004)(189003)(10290500003)(81166006)(5660300001)(107886003)(8936002)(81156014)(3846002)(6506007)(2906002)(8676002)(3280700002)(59450400001)(72206003)(76176011)(4326008)(478600001)(6116002)(6486002)(53936002)(1076002)(68736007)(6512007)(102836004)(2501003)(66066001)(3660700001)(5250100002)(6436002)(105586002)(86612001)(36756003)(316002)(7736002)(97736004)(26005)(186003)(110136005)(305945005)(22452003)(575784001)(86362001)(99286004)(6666003)(25786009)(106356001)(2900100001)(14454004)(54906003)(10090500001)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1036;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GuLWExXGIBfw+r1q8ZsUQG0IF+ucXfBNqxRjyoMAoE8uL6ODbqPcOQI1+TPSEaBf8yBFIjkZPYWcC8jAfBd1MSbVd0S8Znzs2GZY76U0fnVlznVt2dK+FnyMvBo/3u3qyXNYxv/c32CbaWDEAUCD7UWVr5R9tsT5thC4AprUrCc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfffcf7-e3dd-481f-92cb-08d581569be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:24.3694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1036
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[ Upstream commit 4fd4dd8bffb112d1e6549e0ff09e9fa3c8cc2b96 ]

Use MACHINE_FLAG_TOPOLOGY instead of MACHINE_HAS_TOPOLOGY when
clearing the bit that indicates if the machine provides topology
information (and if it should be used). Currently works anyway.

Fixes: 68cc795d1933 ("s390/topology: make "topology=3Doff" parameter work")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/kernel/early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 29d87444a655..62578989c74d 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -372,7 +372,7 @@ static int __init topology_setup(char *str)
=20
 	rc =3D kstrtobool(str, &enabled);
 	if (!rc && !enabled)
-		S390_lowcore.machine_flags &=3D ~MACHINE_HAS_TOPOLOGY;
+		S390_lowcore.machine_flags &=3D ~MACHINE_FLAG_TOPOLOGY;
 	return rc;
 }
 early_param("topology", topology_setup);
--=20
2.14.1
