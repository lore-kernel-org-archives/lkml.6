Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238904-2-3268955759177040397
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
    1523238903; b=l/994vNA3Jh+e1QZjieBdRMAnPKLwHZUGNBg6i3CDxadB+zeIJ
    Qk9FhuRMj18feJokpNIMBNXwW2Cdf3fHCr5ue7w6mW3q048N7BNLp6sHbrEJ6u2d
    G2OJz5uA47MmZfGijkOc+u/1KYpexUzJ89RlI1XYA6GqVyp+3NDL3XPlKuqxpcfM
    +/+xSalfwy6+rEfRMkwRinIYnNVwC2kQE54EWDhmenvlBSAARdaEa+KC+MaTu4xQ
    fc2Mscjc/t3SWAm5/SZ9Zj7PKMt84yfwKe9x9BNtL/CRyV4n3a4ISJU8N6tsASbZ
    1lEPz3B6x9Jft/zHG3bOWfT9gvBozXQY82SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238903; bh=PgB3nQNheT
    O+n2hNSbOP+bHl7pwilIW9rNRcSd/Bggs=; b=fVoGgCsbJCkl596XMb7fm2SJ0I
    nYkioCcdm1cqraiLEZ/YH3mHTo5mTGAPjCJGLCI8RdzXOQAHKB7Yaa9HHTLn6XFQ
    HJzvWbSz2cFH75k7gcv+p1HuZTqLI0LzVRDnYqxbt5qxZCQ85hUPWG85BNxhZQ1l
    htKI6XnPIGEVBzpNPTJ9/x9FhO4J1nmBXDeq1axDrjg1G3x56XYS/lLqqI1V3RsH
    8iX3jCHThIbwXzRqJMVTXeW0lHj8hQABUdqrNKsCSxQmQJ5QkYkt1XmShDkspX2n
    3XyIHeU8nU8WEwsogctEVAXS+/fziNcPb3H3zEDMfov1YNoNQ4TnXUCcE9Mw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gz/wFsaA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gz/wFsaA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG6aSRI5z+6MpdIDuzKX7ISdagmLNwv7lUcV+UNChFLQ7DkCccgb08OSJ8/uLemx6SCxYjCQBcg4UYhXkCO0tDsourRVHBJ7DDUCOtn2MHAiTDCwgU6D
    wbcPapShvJ1RKskRL64uqvuzUWpylYFO+TSbHyqBMpB8O4b2E7nOIiOtmdXKKCSBITOmCWfchZLP10T55CVZBcMAWQ3gNE166kfaLBfR+FMsNtLQ0qaXjBWM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=NzN1MpvFrResoN3T63oA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeDIBys (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:54:48 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932224AbeDIAdL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 234/293] kconfig: Fix expr_free() E_NOT leak
Thread-Topic: [PATCH AUTOSEL for 4.9 234/293] kconfig: Fix expr_free() E_NOT
 leak
Thread-Index: AQHTz5lTtcWk+j+ob06riIQzDxMbbg==
Date: Mon, 9 Apr 2018 00:25:56 +0000
Message-ID: <20180409002239.163177-234-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:7Tbro8JoGbpQOil+tHstQ+vCa905yH1kP1cvJG3yh6Z4X6/6r8BqWAZR2zC9LHMS8Kc5i6jQZZtSu8k50Ag3Yg4e4UIrzylSlwMWgsgu2bHSFQpZ3FoTifm4xCfAKLpWnYydL8u36gzBJWtXGpkvt1ofiFF1dmExHi9Y+7g1dj/yMqF5NM4lbLp2ObC6vSdt9qkWDWNXyE1Fk4GkUplVLzHkt3hVeC8sYdBn1RnPmq/deA6UX1QePBhgX8rQq4Fy;20:8VpsQ0YLVcMdTY98ivOMlCCx/Ky7REqGCyl6/O3h/ztecdVx8Jm4PewtIm04YkrFazrgyTKZ7Kaz30lMNgQJ0UpeC3Xy2xjbwkp2/EOmPo4uakkqqm/bXTmjSHiyMc1Ntk3CdYlFlFBPuNUl5/3IqoEW5Izb7m5qD2+lPIM0MJA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c9ad99f-ab55-43ca-07c8-08d59db17677
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090219F559AF8F8246B40E2AFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(39060400002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: x87PUTnM5528vpJR+F8wkTpYBD7mbStmAB5L9A6W6xxCXqeb6wUjYUzu2lSwf6jDMA9GC6gbDyQ7T9N2R0PobS4ggoyw4RhYDLVhNjJbYcvjsMZx73vpWt1yr8mtW/BNrsw38Rcax0kWin1ThhUqLemTvrTAZvjG7GEQOjFa0VYPsRUnPppuuWUagTH5Ds58Z4uZrHpR+zvQRj01EN/jYobRWIoXirCUmGj+dfEmmmgxMFeglxMsYJclsN18qw8rRCYPOVdRc0EhDlaoq+TSG/6ru/EcZyfzma77+j/snQBOjLaT1HrE9UnDG++G0HEGFqzfQ3VMzTNcwFi1iCfl1VP5GS+ZCDO+RluP1FIngpUS8S9pS1WXaZmquY05YJPK4X+KyY+KrSgh2GglABRNR9eS8dAzo04c3Eq0J/evVbk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9ad99f-ab55-43ca-07c8-08d59db17677
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:56.0817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ulf Magnusson <ulfalizer@gmail.com>

[ Upstream commit 5b1374b3b3c2fc4f63a398adfa446fb8eff791a4 ]

Only the E_NOT operand and not the E_NOT node itself was freed, due to
accidentally returning too early in expr_free(). Outline of leak:

	switch (e->type) {
	...
	case E_NOT:
		expr_free(e->left.expr);
		return;
	...
	}
	*Never reached, 'e' leaked*
	free(e);

Fix by changing the 'return' to a 'break'.

Summary from Valgrind on 'menuconfig' (ARCH=3Dx86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 1,608 bytes in 67 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/kconfig/expr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index cbf4996dd9c1..ed29bad1f03a 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -113,7 +113,7 @@ void expr_free(struct expr *e)
 		break;
 	case E_NOT:
 		expr_free(e->left.expr);
-		return;
+		break;
 	case E_EQUAL:
 	case E_GEQ:
 	case E_GTH:
--=20
2.15.1
