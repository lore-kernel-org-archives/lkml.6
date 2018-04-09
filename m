Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236926-2-3938810427961586673
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
    1523236926; b=VWZjCucHrLkg0gw1jluw7FGg5+KrF7899e1wSE3nlJWnYEhnOV
    lluCTNzvp1XKhcJ93r9L01rQbmc6yE8Yu0qVI75AByEYNq/l18s+5P8t11KgTDIx
    KXjkP0+5txeku/ASTc0J/zLdLrQ9vQq4nCj0RY9jq3q8/5GboB4kLmQYNrmsd9d7
    zeOMM8mjpqYl+2OCD8YwfiL8E1BfbfJMzKE9Y67MpWPxQ9PSdJurcXY2p2ut6KIH
    8NZCnC9Xe3PuaZBWSxJi88ATtznTlra5xfZQkRZRgiymNWM7LhMGd9zRv1IFa+ZU
    9iPWVYE6gdK/Lk2zRozCG7NtGpNJtRXAwNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236926; bh=xFP1GXWY5u
    1kbokWDZdwcDWLqpw2bi3kEd9FOwHWmlU=; b=rwHnP8x/KP9rQ37uKcS47oP8Bx
    UqLLee5Xauudc/beTQHpqPgResuVQrGq6by052d6sU4iy5k4rTozpV+472BNqvfQ
    4b7jOcVKdhCrbnuiw47av95XR/aKLdACSmsXrx72u7BcdVmPAvkAyhCMCO1DnU+/
    Ush8INDjizR4qEgTvGEP2HpWzzyxgfyLw5XBPaBj/R2CuFvM6bAdk2fooaikOHsh
    K6mwskUwwhs3qH1jMyx2NMKFMPQzL8GosqHyU9HFKi6wIzRkc1sIu4vEJkIZEdgv
    fxcoaGwx0pwCZLglQo+qUpP9rRE8r4mVP0i52NIk3OLEgMMkIAZAYnxP44Sg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L/LWjzhn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L/LWjzhn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLeuKt5zPmizbbJB+k3z4E7hL5NT5hjtbBraOVfbkroGF7CM5no0pUNGRKq/siYyWpJDuuP/gnsqfUfYF+nXp0z0DjvmVR+mxPJgUuJKkEBfCYD3YCNJ
    SHM/HS0heq8KqbB/N+FBBWvO0edOm7UQrsNgw5KevblUfNw0yT5Jub/FsgUlArR2JwuEaiF5p20euMmAkxWUNiBrZgemTEMrq296qv3UX8Xu1aBMuhhwofbR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=Op-mwl0xAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=CXCrUu0I3pTnwKueyNQA:9 a=wPNLvfGTeEIA:10
    a=_kNtSFdpYmJUICABlfa3:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756167AbeDIAhJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:37:09 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:14488
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932748AbeDIAhH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 083/162] libertas: Fix lbs_prb_rsp_limit_set()
Thread-Topic: [PATCH AUTOSEL for 4.4 083/162] libertas: Fix
 lbs_prb_rsp_limit_set()
Thread-Index: AQHTz5m3TEj3QmD4UEi98lkM0VkSUg==
Date: Mon, 9 Apr 2018 00:28:44 +0000
Message-ID: <20180409002738.163941-83-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:qnsDLPnEr94H753hxTtJ+3e4atHgv/QFzd8hVo8bEZFu7cfVGeeLNkX7ETGHo6uSvwRwaTJ3bmlxzmgNkmL0YuxIrMqiH8TashpOQFUs/K689IF0F8ZNN16oOYAYxUt+WqLFAcbS5XXiv0E2ihIDMhvRyC87HlEnmgZ7nR2vrOG28lbeeL9bWqLK5fDE0Au6MjK1Kwq6u4cavvEirYIBzqU2DhoT0wM/+CplhGG8oyE5a8VT/gqX4Rpqp4uWRamc;20:vZiwi3Fis+HMFR+brwMvz/AI8NoV8kluzL76DHce9fZ0yLuUNuOahVEZjsTsaNSchmicV4vNWtDgu710hDBUNr30Bh2PMBuZkn1tkqGHVoqKNcI9V5v1fADZnw0z+OKtGH/glPE/zxzVPTLPdcNUMhGWgppVn5la/i5BNki3wL4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fba81a7f-beff-46c3-26bb-08d59db2041b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031B1679360D06BE0F76BF0FBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: uHPCyAT8eiOhwwEDtdlSMK07oJROCzA3JhnDsBdYHjoN+6KtLSYQJeT+cK+bnBABQxMPefnFJbUnoijr/hZ5UIrRh9dcOehmkcMDcHzi6SROhIIB7q1X34vBaODsjWOkDyuJrDpA6MLjKJ4TIQ419HhqYwAToY5vy46PDx1zl4klaaa9IquaOeTN4uyw057M50c99lk0vs82QLDv041rk/QhNWsJF7qVDxfHpF7BKIxJT3HSjNsRyRYa8RlpUgqOccLI9yqWUMis46mD913FM3qE9G1Rdi8JYgS6d0/N+7ROnOVrgnBWyW3gWtzr8C07K3y25VLm9y2LxWQz0pbChLzjcC76FbKjpZrtPZTm15GIwUHoDzLoXlkESc/pjYAfwRN+mC6JvuP66tadohrQZFSPvKuqqfx/nkzTeB/NEpM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba81a7f-beff-46c3-26bb-08d59db2041b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:44.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 69551f5f370cc20342fab17ca54716b6ec7e332d ]

The kstrtoul() test was reversed so this always returned -ENOTSUPP.

Fixes: 27d7f47756f4 ("net: wireless: replace strict_strtoul() with kstrtoul=
()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: James Cameron <quozl@laptop.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/libertas/mesh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/libertas/mesh.c b/drivers/net/wireless/li=
bertas/mesh.c
index d0c881dd5846..a78c4d18fe4b 100644
--- a/drivers/net/wireless/libertas/mesh.c
+++ b/drivers/net/wireless/libertas/mesh.c
@@ -239,8 +239,9 @@ static ssize_t lbs_prb_rsp_limit_set(struct device *dev=
,
 	memset(&mesh_access, 0, sizeof(mesh_access));
 	mesh_access.data[0] =3D cpu_to_le32(CMD_ACT_SET);
=20
-	if (!kstrtoul(buf, 10, &retry_limit))
-		return -ENOTSUPP;
+	ret =3D kstrtoul(buf, 10, &retry_limit);
+	if (ret)
+		return ret;
 	if (retry_limit > 15)
 		return -ENOTSUPP;
=20
--=20
2.15.1
