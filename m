Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238220-2-15026976522041161333
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
    1523238220; b=jdhIUPbmzkHseH7wvR+VnO/Oa/nNwup4M71WQDKOqyQ4YoFczi
    P2BABvFIA1hVEXixb3CEKLvGG8F8MLGmFsazuegzwgOndhqA9/YcreZDBCnIF1PF
    MYxxrhhCwgHVsAlcbZPrtN3HtSYjMTBfmoQVME8ybQsOarzHt3jFXz4dHVCTQw+z
    cjYmIpOuszRru5WlN7p/BbANcM7bjMhqfn3kbR55UFgyS7814pIJIaFC+3BRmkqr
    us4mGAboP9N/c1jNhk4ZDOz3pXxdMx6G87arGgQsk0SRM0OuuWytTMI0/Ew2prlP
    qfR6p7Dfl0ye8yyEUBmxlp/UkpwCiHXsbNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238220; bh=g9g/TxhqKX
    IUz/9Oe+mVQjol7voaRQktGXND25O/39U=; b=S83uHGw49RC6f5q6FiXgAZETrp
    pPCgDAokP4YC1bnQplJW8hzznhxjeq0dcVYTH70swkiHQ6NPo92g+VFdEJsw5qY/
    C7hu//AczIkERND++FRBbUwrdzYLZhTyT3ULtwW9N2vW+njo5SIhISD0XlxJM6+N
    vCTekIOpRsKBIOtVCYNEA5JTHyBAGEJmUEWgz+htbxTlZ57wW1Mb+Ey1Q4buXAcj
    +re6WN8XXwQF0lT2bs3gZw1x7Cqt4fvZi5vxBkilVK8YVkI72NBmQivtGbYpa5Z2
    nDlEZx4BWRKZdzmQETK0+VyN/sAkpmjd9PhNx4FDU0vnmZxTJiWRK/Iky3yQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h9p7OIqn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=h9p7OIqn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM2cVEKJer6WsgjIA7X+sJWZfWnet0lRBYFK0VZrdxE+QcI7KES/VCsGQAqjvxHbxohDjCjQU63VONCfxUC7xNwRZSzFF83vbVIXzuSEbXTu0wC93Ohx
    PnHo7nkFKzO1Jj8T6eAbe6GMw7Qupf5Fmz5wZkXiamgYq2zNA6s+2/yVquOcu8oTx0EoUYTv+JrtA/yggeXhN9yav49za9zoOlxn+RRkZ09iWu6Wm6BPwcp1
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=YF8PD-7RLpV57KenVnkA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeDIBnd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:43:33 -0400
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:51004
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932258AbeDIAep (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 280/293] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Topic: [PATCH AUTOSEL for 4.9 280/293] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Index: AQHTz5lqbFn/rkDrrUG/fAEsCrDBFQ==
Date: Mon, 9 Apr 2018 00:26:34 +0000
Message-ID: <20180409002239.163177-280-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:7bVvhwOvewK/TQw/XtKDdM4t5E8FjLgF32fEEJ0SaikMZcm1eDPz3s60UpC4HrumT0LZQbAhEnVKYy5Y8np4XKIS3ZL7fVFPbkakLCJgyyWfc60pCk5Wqo8nnHQkS/M3AZq2Ktv6R2yjbYPkIo0jg990YmyMQmRLVq8UmFiTdWzFzuItozHv68uATTOlpk5dKXV9cAhjhdX2VAcJ4miOVsa8IdkYu/9WuNTgmsgTt/zhZBTh9MufcIpe/fHiWzM7;20:kMli92Rk1nsskw20nY9xkRiwGEk2AZijNTGz5RXnW9fqE/ukMzuhOZ9Xk4gVjzTKVkHCtMq7N+E/fjHyhICg98RfiOl1YDi+n+l07mJ8fN3qa2G+40h7nML43nXRSye/9eCUIXgDZNX6SwUGadKnlqy9lvMZh8YVwCpNdBuOfHc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: acac5e02-07da-4b87-df52-08d59db1aec6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984328E49EC09F0FF19E984FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(39060400002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LL/Q00NUMuir/oVHjZAF/X++6UfPONwJL6KWDyVBM5LjecQm/ujieEmTbAjf8lTx3k+wM7fYcATC9yM4v6fQZPMhz4x0tBeMg83DeYry/3k/i2gPt+JPCIQY0WUhq4UnLAGE+qYPzUfYUYBJTuhoMdEWTcpv+ZnZ0AzAhiu95H9qe0fMgaq+I754X3qHIbOmY7ua+/fs+ZTTpxyrLPgYVIKLuZPcI0M9xwBJ97O7pntpZLAkyodNG0hUkY5TS7AQhfom7PhSpvsXzOh3F3+IpIUleeu0h6PPVYzY2PyfjHFhNreg0B0sHncFPTKtLcoUux1TpHoADMpjO0Hp692ziH7CsScVF/BJLQ/Ssz/S2aFSsIH+c5dReupOynMuCIiJF2Nf7jElyVMPd8+YrMxGvDLu3mF0fKy8F5rI34ZkdV8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acac5e02-07da-4b87-df52-08d59db1aec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:34.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index cc420d6b71f7..d57222894892 100644
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
