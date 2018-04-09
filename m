Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235207-5-12838827171544207483
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
    1523235207; b=m2+WcbthHYdYg+qvwUg4gPnwn2oaJKQdnNClnzV/2nSXZrQgkf
    ZbpcXCqVKLdeHkJx0lML2zNkVuIkHOXFLo0V63QKrQYzvnDmThxP4t/n9mDbD39A
    T35OJOvdVTeIk9kD16yQLW9ZqFzNFVYap+xirQpalY16QYn5uokIfGI1k/Vn0Clb
    9O5yCcHRaEXmbr+Ya+lDXENEnV4kJLwtsApvMqNDr4Fs6/W5fPfbqyTVLiLacdBt
    vH/4hHND2AOjucCLz747N41U8cbIPltJBjeN9zshKMSdki9nCgFFmEAwI0XNXC/s
    xKaPhNhVcCDX/lg0RijZTG7Ry168zmrNMPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235207; bh=xFP1GXWY5u
    1kbokWDZdwcDWLqpw2bi3kEd9FOwHWmlU=; b=enJ7Br/gDG6C7dZLsOd5TEQeB2
    xnUvx3nYNJBGLSMM6Q1a1uVd5T6bDIbM9oPjBE73lgTQysoAy2xNtcaL3gChEmfB
    5kNzmVHsqQnUSjwDbnGh2S7bPkYoo62MCa0sp53wARUAhNx3VuknuPmolc0UdqfB
    bq5PXrHIQCztKdbZbdIBq1lBVeCxmuTbUP82TqNapjMugmf8qFmfr8YThK9+/x6U
    qTQSRAJNEusWnAZsjw+95fiNacy78jj8fKlrzPfDCWKiL1dFiXJsSNYyVn4mWug1
    +PJ4kxoq2MHIsx/QlOihpL3Lyn7zaIxvt5qd/01HHM3nW2jiWxWJ6AOwcABQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e1Q9ydAD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e1Q9ydAD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKtWeoGzlTCWjZDyuTmdowTSOOqeUg7z7HfrkN1BJs87pbHpc8QvPPU+0/GE3zC67BT27nfIkXZOyWfhz7miO0TTR5LDNN/3q/XhSDvIcqTXpA+Gbd96
    T6r2SZC6aMNKqWRimBuGYGVcOCZiPaStcuSASZeYqWEeV3Sgk/C15jaxPYjaJAvtaBYpPFoG0/yBcGvYEQxuhHYI2QsbL52jv+AgdiZhJgkizTXAxcuMLXtT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=Op-mwl0xAAAA:8 a=LpQP-O61AAAA:8
    a=yMhMjlubAAAA:8 a=CXCrUu0I3pTnwKueyNQA:9 a=wPNLvfGTeEIA:10
    a=_kNtSFdpYmJUICABlfa3:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeDIAxJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:53:09 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:29344
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933403AbeDIAlW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 053/101] libertas: Fix
 lbs_prb_rsp_limit_set()
Thread-Topic: [PATCH AUTOSEL for 3.18 053/101] libertas: Fix
 lbs_prb_rsp_limit_set()
Thread-Index: AQHTz5t5X62Tv4Qhn0Sb6O8hK6cJWg==
Date: Mon, 9 Apr 2018 00:41:18 +0000
Message-ID: <20180409004042.164920-3-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:O024y6eFMoygnTALcEXZ6fY12n7y7gZV4PCvrcYVfSe9i6Fjcxc8XJTJ1nHWXanPae0LYcAH1GhQv8sU6gwP8+ak3UWrQ5hX3H16CGrG6NX0hpG/zw+TBVJO4XDwqTdsO8AZT9zKYnVMKIHxhGr9Os7ffZH3KA4IV/BsxI5sAV5348p/tvGFPn1XeXjUrQMqZOGOCsoUcVbCiEcftzM2e7cV47trHMyvga/gy/XxPccCwjNMk2CN5wz9rR0+z/eW;20:7DqW+lJ42jIpwaAdighTrDbYl0e1qxQVXbSCdnjeCgVrEloZxs3bVSw4bWj0hGxEm68fbGVLHxILqSWqLSfKmrmfgJwC/nkv+3+nZxWIjl5aCe+pOVhsX6+YcR0itJhMN+VN1EDb5xHOQhqlXElRXDI9WbmrxLH0/ioSqbZXb7k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 533dd851-1ee6-4fba-fb58-08d59db29ccb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870E912C158E3775E980AE6FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(59450400001)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: VCaPOz7LJNVzA/0hFiB9PmSeW5aA2iUUI5jtgKQOdNLfLM1ah+tqsup2k/WTvXemdflS/bLG6GI78VkHGsZHqV6M2myr7JMow+BSFGH9F2mxmPaO683ea08NmAkkrnO1sd5txOJpVJZjilz6P4F33LQtzs7mbubeGrADbA7ZsjrN0h9nQ4Or4hkqkAez21+EivhdHd7VRgkvTVdCmBClPqJmTezWPALeQ2X2OvmQ9AND08tgq6ewnvaGLxWCvw+5CwOQPJk0DiXkzANOCVYMXY+s386GQ7GFoRNbeuP5k+po3jL33Du7atfDIxYyJuM/po9NB1Jg/r0He1nnEChLS8jSIzuK+mq4MLgAReZfHvqISIQ+qDmQnm++cX6cWGIyz2FfeE/NGRFgHohPGgk2AIlofb7mc+HxPliQ9CpfJrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533dd851-1ee6-4fba-fb58-08d59db29ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:18.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
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
