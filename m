Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123937-2-408392003846042907
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520123936; b=ZMbnqvaXWRmlbphkdO+tbqJ6PiMglwrsvFR1/VS3sBjWLtW
    MREh+MHT//+LmdzTOy56rzJZc22I8ihEsAMe7mvgYRf/DIXYmiZeWGUb+VrTFlLd
    dswdpWEc5dKLW+pJV2dtLfeJxnhn9bTNTmTueXLo6eWhjbHRFalAQ6C1fpznV8IU
    YQNQiNvxqP9r31ad05HlqAxAdTKtRZP7b0XUAOPEjuRCHAV3WDgrNSK5C8zxmB53
    AKY0PunP4NFCwX++cSZ0sZzrOQQmO2yt/p4VxoC1vbxMH8KEW7JIVoQsw9xMsjFZ
    xahr+l2iSTKgTd+Uy5lD230u3USFCAVGAAeN2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123936; bh=X9N/LI
    PGy3l6CH1LZvhxwgIVAiXAEHY3vleXFs7luns=; b=JocJWYFf/JSiQtyt4Oz8NQ
    WfOUY7zkNcHd4V+jNpsBd/XszL8Y2MpRZ+GI8Pt8gk7STvcj3pLtVVOGe1vLz38B
    mwxaJEWPIgiKN2oWcJcLcN1zowUkVHTbPXnv1qYuqhM4d64DUKJ2Fyn16wJj+d9/
    3nJccnRQtFKhLZj03Shuv3gn1ScOu7J9kx6B7UzIQUoel/NYJVGhUpwtcqDqd3Qx
    jjsYhI5qznKCd+2zfv7rxLDmMWGcFRwaTizhrtQK9bqLOOIWX1LO/4BaC5sZ9ZR8
    eBnYe9vBiHbpbvsK4ggShw+ab81i9Rd9GENqMfyuFjDT4TnPsa53hXSsQE7ZXs1w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nOhEgFZf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nOhEgFZf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeCDAii (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:38:38 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:17369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932757AbeCCW0w (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 063/102] perf annotate: Fix objdump comment
 parsing for Intel mov dissassembly
Thread-Topic: [PATCH AUTOSEL for 4.15 063/102] perf annotate: Fix objdump
 comment parsing for Intel mov dissassembly
Thread-Index: AQHTsz5vYdfCYbxCf0q9p4TRavuR8g==
Date: Sat, 3 Mar 2018 22:24:45 +0000
Message-ID: <20180303222318.26006-63-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:IKzkG+og1faOkED0iHD4lRtStTK827eIY9qtFfuVJpJQpIJinUx4N4fvSOzPzXG2wrecAiD3DNV2ya3WbVkvZJkROXYoFF8zlbYuTrrB5079fHFUNfhQHLN45RIC57cHpbG17wxT2phjklRjRDwXepjIcMulrphmP/nONte2xTkOZi+FiOoRjb4VPu6fz9me4pEf0pfH8RuJ8pb1C3ng3b3ydPq7Aem0QYV+hU4CZdNLr2kSs5WH9tkRTCHgEsM1PJNvkYZtlhKsiy7i8Fj4JkJvVg9L9tdVku9rHdzck5Qs1w5m+FGlIAELr3jqZKFNB6+1K797EtfLlYpQ2ekoSK7jw26ImTfI8ODzRxhDKhlmyS/u2qMhm7sRm6j2K0mz;5:qajlH/dKdJvMUvUaaH9qKXUbtcuwRSi10PfTfIdP8e/l0Deo/IDbGI6dJLEBQgLMGp053Q/rNzG6iRth477kUiOOtUjXaDiZJwBnS86BsusZ1aiWKBkXNieW17a2GwCgaldQKB5lbiFyfTgBO0XMBH7Od3zkF74GfYKjhTApb4A=;24:fzb3akm/43OQ6nZf1Qo24DIeoDgK8A+F7fvC0+91LGIgnSDMt4bnZeAt/OVGEYAlBbiKWBNAmSc7msVPDgWFx0rd6Y0ix5VArNzLC36C3ew=;7:jeoTqjtOqg/Wdx79pebkZiD5I6yGqitcsuaAoCqx/OZPO5qXLRQG0IFtx6Ion+CDJIv1fQWvnQsAJbOynuIQizy2ZMobbwDf11HOJ+e5OnOcu1PLIyoAG6hIrHFrKkmixV1AL8vxI/lbDm8QiHTMQ+4KzlDkJH79V5TGjbLs8rPJ/XbO9cBPT4EkJPJsEYqvzyY4upnyj53XB5km1DRBSbieJ+MIsEqUY7Y/H/upN423r8++8AzE9/QEMjBPZrbs
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27ca6766-60eb-48ad-d44f-08d58155db65
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06D09A024552DAAE234DC8FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(966005)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(6306002)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ByEdejuth62aiZIKYVeVesHnq0i1WOk4vO53mpajuJ7DmNyFI0fV+lTMfN6BE0XD6OYVcvmgs8uCHYOTbXVQkBwBKm3Efd0aqJBiTm9mF3QxxIlO0BBSxtpmHl1e3ZSb6XwBzDN8KsKap7qiIJLWwATSGf3U1zlkzNYV+hiE5Wg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ca6766-60eb-48ad-d44f-08d58155db65
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:45.9940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

[ Upstream commit 35a8a148d8c1ee9e5ae18f9565a880490f816f89 ]

The command 'perf annotate' parses the output of objdump and also
investigates the comments produced by objdump. For example the
output of objdump produces (on x86):

23eee:  4c 8b 3d 13 01 21 00 mov 0x210113(%rip),%r15
                                # 234008 <stderr@@GLIBC_2.2.5+0x9a8>

and the function mov__parse() is called to investigate the complete
line. Mov__parse() breaks this line into several parts and finally
calls function comment__symbol() to parse the data after the comment
character '#'. Comment__symbol() expects a hexadecimal address followed
by a symbol in '<' and '>' brackets.

However the 2nd parameter given to function comment__symbol()
always points to the comment character '#'. The address parsing
always returns 0 because the character '#' is not a digit and
strtoull() fails without being noticed.

Fix this by advancing the second parameter to function comment__symbol()
by one byte before invocation and add an error check after strtoull()
has been called.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 6de783b6f50f ("perf annotate: Resolve symbols using objdump comment"=
)
Link: http://lkml.kernel.org/r/20171128075632.72182-1-tmricht@linux.vnet.ib=
m.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/annotate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3369c7830260..6a631acf8bb7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -322,6 +322,8 @@ static int comment__symbol(char *raw, char *comment, u6=
4 *addrp, char **namep)
 		return 0;
=20
 	*addrp =3D strtoull(comment, &endptr, 16);
+	if (endptr =3D=3D comment)
+		return 0;
 	name =3D strchr(endptr, '<');
 	if (name =3D=3D NULL)
 		return -1;
@@ -435,8 +437,8 @@ static int mov__parse(struct arch *arch, struct ins_ope=
rands *ops, struct map *m
 		return 0;
=20
 	comment =3D ltrim(comment);
-	comment__symbol(ops->source.raw, comment, &ops->source.addr, &ops->source=
.name);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target=
.name);
+	comment__symbol(ops->source.raw, comment + 1, &ops->source.addr, &ops->so=
urce.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->ta=
rget.name);
=20
 	return 0;
=20
@@ -480,7 +482,7 @@ static int dec__parse(struct arch *arch __maybe_unused,=
 struct ins_operands *ops
 		return 0;
=20
 	comment =3D ltrim(comment);
-	comment__symbol(ops->target.raw, comment, &ops->target.addr, &ops->target=
.name);
+	comment__symbol(ops->target.raw, comment + 1, &ops->target.addr, &ops->ta=
rget.name);
=20
 	return 0;
 }
--=20
2.14.1
