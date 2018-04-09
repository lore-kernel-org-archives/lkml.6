Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233999-2-7839007289073352629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233998; b=DOwvMSW5AmEj7P5PZ2q059JTBk/6BzqRAJXEGk+TJ3zp9wC/C0
    H9XhpzCL7LYhV9L8HiMQSZ4RLmjQDx6/oCJvmqzMYrHbQLHgugaAOhCOyNxjAKvo
    3fFXh8sfsz67EhhcZtly71YqpzViN13xHjHWCMCSzFCNe1118Tvjb/lEdj1wegaf
    mvZ3WBUW023S7i5FlboRYxeMdKbGNQViqDy5pr0MIY/fkL5hifKvp9iWhek2h0e6
    tsdJc27UsZ/HWED9HQ1YpZsqwDzXy+qRrEp3d7CEvyC9AfhU4VmROi3t7Un/2/zv
    HkuIzOFkFD0bqJiK2QOu2Re3ZDi8fTxuAUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233998; bh=r7mkdapx0/
    O++TAvu2cUZ1OmDCkILFYNQz2Dl2DcPo0=; b=JqHdz/dshZk7SogHBadvmtA2ao
    4n1uZp5b+Gk1DH/qNQ/kMOeDmzgT0Ehq69debHUFddBz5eYZD3KMHq/GjEoPebzy
    aF0YRVCTw8fkCUiBZLLMFvxVEDS2Ef+qn9UY9BkHfn3y16okthongdgHwsh9KY46
    un43FcVWMvCBzIDN1nWV0uDeANPM4xp6hOXf7fIfNoA1t1RUk4ZfqJSQ/X46p/fM
    nxk1LjvphHBZALHuF2gKWRsZa7jgM8vsL2A970UamuV3zJE8o8F3K1mRaahEbK8b
    6XjCbEJa2pk74N9wWwohkH9OCE9VrhVhC6rESWKjb4A8vh6jISHbqf5TYAlQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ICi1x/sG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ICi1x/sG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGKXST/a3A6La+UeL7/WFsFFrGnHYYh2DTuqf1cGQ8FwebPHv1l2tVNbucZotNcTHmaP1LfXO2EcAOj2swEGHwCUdeanYeo0PmrrRtsMNiAM9YZXM5YG
    9MYZEknBkme5QN5WfBF/7TkBZuuHR/luI8BWJpUAlzhiKQHjAQfDNreWwdVrq1eacHENzCavajBiqkYqhfamyMsqiSF3wcF1zDgYtkVaKkuFKAp92iS/MV6Z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8
    a=gZW_3bEixuK0yuQyb0QA:9 a=wPNLvfGTeEIA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeDIAdO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:33:14 -0400
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:49836
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932267AbeDIAdJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:33:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 233/293] kconfig: Fix automatic menu creation
 mem leak
Thread-Topic: [PATCH AUTOSEL for 4.9 233/293] kconfig: Fix automatic menu
 creation mem leak
Thread-Index: AQHTz5lTgD6CTPYQrEekGUR5DJuBEw==
Date: Mon, 9 Apr 2018 00:25:55 +0000
Message-ID: <20180409002239.163177-233-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:Swz68mu2EdG1aOnd0m3YvOB27u7m/ferBtw1w8llsmDpH1KkidtAJPkmo22Y7kBofrjgXekRpvWdNwr4YGeP9rBFmuglRU8LK7sQkiIgv3Q2DM5uzQLRkDrKaC599FF/34sBFOCQ1eAJpk1rD5DOUrK1Chc8KcPjpexHOw5Gx4RunK3hqu0vC4lG0TKBj0X8dNZSHPhlkTRveIaEFt947pQXt7nbslxyMZeWp6VxaKyx/3MwWIiJGXAOtK4U4Coc;20:tyOQLYCbsi6172LXnCXUyVlheoCL7NuFOg8N8vxIq1WyEj8ooouzPODvFaP0s5aSLFYpbhwRSvtDAV5N5+2L8VRiB6Qp4c5w62rjBsAvFAoo6scZH3RByycK562+eGgDVB7uMcqfZV8af5NodO5XpcPNvBTZpXtvE+wIHZEQr5c=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc355f05-cb7c-488f-d08f-08d59db1761e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902984FDAEFA7A10236963EFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(39060400002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ekvznAfgRxUcwUgnWkCQt+G23Z8nRzNeZILDkvumHN1uS2HH+3/7BQb4gupyV8TDpjMhozTpnhh7fH3AH8MShwcztT/g6HRxt0c9hwU35CpxQhbRU5cR2v0LHkqccbXhkWsTwcydYSSSGbl/8Tl+sFmX33ky/pjk6hp4WvFVDDBVqaPRV00nxnJ1D4m/etKNYWQx4ikMQygrRTB9qSgLTZK3mpt4olwujuyLhJbT1TbxJkKoJlaHJIxihJ4ixdD3pTp2AmVJnQFBBTG0VcN8mtVbfv6+sDfMjjiEperzh1EEtvFR7LxmpXTz6+R9zN0lCSqS6GpgFRUY4MR6fvYyLAAGHrPYPD3cImOEp+myBUSNqvsQMR1k3YVuLOqvZTOT8O5qLB3OifQA4tUwGChT6dj+acU5DMDIG2KR9m+ZDgs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc355f05-cb7c-488f-d08f-08d59db1761e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:55.4255
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

[ Upstream commit ae7440ef0c8013d68c00dad6900e7cce5311bb1c ]

expr_trans_compare() always allocates and returns a new expression,
giving the following leak outline:

	...
	*Allocate*
	basedep =3D expr_trans_compare(basedep, E_UNEQUAL, &symbol_no);
	...
	for (menu =3D parent->next; menu; menu =3D menu->next) {
		...
		*Copy*
		dep2 =3D expr_copy(basedep);
		...
		*Free copy*
		expr_free(dep2);
	}
	*basedep lost!*

Fix by freeing 'basedep' after the loop.

Summary from Valgrind on 'menuconfig' (ARCH=3Dx86) before the fix:

	LEAK SUMMARY:
	   definitely lost: 344,376 bytes in 14,349 blocks
	   ...

Summary after the fix:

	LEAK SUMMARY:
	   definitely lost: 44,448 bytes in 1,852 blocks
	   ...

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/kconfig/menu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index aed678e8a777..4a61636158dd 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -364,6 +364,7 @@ void menu_finalize(struct menu *parent)
 			menu->parent =3D parent;
 			last_menu =3D menu;
 		}
+		expr_free(basedep);
 		if (last_menu) {
 			parent->list =3D parent->next;
 			parent->next =3D last_menu->next;
--=20
2.15.1
