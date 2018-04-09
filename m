Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236007-2-14478543645948870144
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
    1523236007; b=OIhbgs81YQ7pQKyk+31fr/kUxqcfYZVtFpLXedqkhnSCesqmyl
    v++B4wWh17LhkjjXtWs9pJ7XQ60Q/aLhBI60d5lCyyq7yjMjRQzTchSn5h4Fgq+4
    zblgwT2BDjT/Yagvw3R4wK9szxY3w2bGXf428ELu5s6sh2vsKELeFJ/7veAAIHBl
    XTLKtun+4y5cHQbhUGOBAPe9ll4zFAiAXP3y4wuCVBuTK6ukPBKR/TVE2ihC4HN+
    Tdd5A0U19e2PPoHOO2Ei6RQTqmQ775hENKnectTwIA2v8Ohs7AS3DVizUztcIdVy
    R6QCdGLMvvax8gtPPS1tGR63hpD+PWjRW0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236007; bh=G50suyWCq4
    jrPJwrGRblhAqNnwoaTEAf5gIOmutCFlA=; b=LL7irPrlrIpta74xNptoZb7bIo
    k7YIp8ojWsdnrAQGTB8HRli2KV2Aw9RV3L1/KB+9FgTgenq3yIUT3eWbCZ08YDWc
    8ENKJr+oVHqNSbJaLM36HzzLP/bl6z+CCztI6qwzkteejKS+Maxg8k9CuEb4LJeY
    kryjmdOVgspKVlQfjyC5GkX9SA6kTkPX7ss8N5B4FpyvV/3G6VQ+ox9eJMaHD7kT
    tLr8mfEpUX7YqjzDjan1IWzyvabj609DVQDWT/wh97xpEpi4SLWO5jsX+W8DqC14
    xJNQtySDii/xPgrG2HH9IPhkwAjs9itk8ubhw6/lueZ4SQqxCNVafCW5UtzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mcIg8nOg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mcIg8nOg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4q2nH08VCxDcLRSBD6ZeTn2GPmlVPuqSlBhIm/MNTvShI1qjCm4b1zOBx2jiZOSnIHypucB5dqvWzhvqdPkSl/T7guho4zJvE1WocH9ywOlK2VIr5E
    Cgu8sC1NrsHZjnfXUXQdaJjIEmMSuawxSrCaxmfetZaO/IiiGRz83TOFcxk4kYqK+8UOs1VSBILi16sHYiJde8vJ9AfTRCp3yFp1Oie7CVp0aMoTzEibnGjF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=YF8PD-7RLpV57KenVnkA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756730AbeDIBGm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:06:42 -0400
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:37663
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932263AbeDIAjW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 154/162] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Topic: [PATCH AUTOSEL for 4.4 154/162] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Index: AQHTz5nf1BbOJSfLDkaVAZGgk0RNFQ==
Date: Mon, 9 Apr 2018 00:29:50 +0000
Message-ID: <20180409002738.163941-154-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:hhAw2Un+YuRgkfYz8yBvrRhygxR5qsIIDUVKKmjerLJAk7RspWM/pKIUOgSwPmRcYN6QtsJtgvLVgz0ajftvAQB/nmuI42jcVBaN4b6Z5OxQEyrxyM8Ehf5bt+CxQyv6H/JLRuAVEGji72M57sRy311L47LSJULAQD9vi/OdB8H34x7gsosZoqGJD5L7iDU3pQpeg5ZXxzJ7qmnBAeW1XPUMmptgt2gY30dYaaO4ypP+8ZLMfMZ44I39n7KcJJII;20:IVduZpkp7PU+4zpt9uR5OrfljT6zdUTLh8hUTD++J+b4md2UhWrbiIoi+tIJ8RHXTB4u7uZQsmcnX8h3qAvNJ2a2bmMipVeOrrAk5NQuVgKi+kgoBhwR7a1envTkD0mKnG5Xt7RTAp+WbYg+/gHtZs/qXapoESqD2c4Pa4kjaPw=
X-MS-Office365-Filtering-Correlation-Id: b8b37dbe-8fd5-4433-b68f-08d59db254d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11259531A468B449B869D2E6FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(39060400002)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4sfC7dAVR8hqJgKU70OVNg+mpwYCmxHL1ndWTiOV9RtC/emygY6gyuoEZj5SDDKndhoPRftoUTcnQKWsNmxfupe9G9z9bwBI1zA/p6gamK/ikoVYdUXfKzguGLg2/945ltiQvL4tKbFHFFFaqqW+JzjXa+pPtuStdXfef/kuN9MTYVaW5l4KmkIZ+KZGTMbqpM0xjpVjrHTQhx/xKnmCdHiPnFIlBXD4Tyqux/EWJ9RZVx+HdCDk0rG0yeeUvaXF63JC1PJ0h4mShfyXKmvxvltiq8CSGfwAo+WEQknfJjvyzxHJhAX9YOgMWcZMEnSa8a953L2p2HxZb5tXNtxLz8ru5lj9SdXBYC5z5cAF0APfS4uozXSV0QhgarZiUrrfBjF0s6/GTqmVyxbkevgBZAs98b/zvipnhTqp405tVVU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b37dbe-8fd5-4433-b68f-08d59db254d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:50.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 0c92af11f4f4..8632380d2b94 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6421,9 +6421,7 @@ SetEARetry:
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
