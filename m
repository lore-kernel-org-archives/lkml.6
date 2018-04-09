Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244996-2-8537284490571276259
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
    1523244995; b=UQiFfX5aDRcFNWsZwVg3g/970BHWaQ6cpII3pDzuDpyFVsyZcS
    B5XCMSsF3a1sytMIjnz1qAhd76VY3q0REB2kOuqOUzrHTS2dRLoWWppVR02YGXfI
    gYrWt7+Pz9TBTc0j/wiBj/EE6DC+GPh+9yaxESgPEOYihqGGPnTNWCF9Voo/CxxX
    +3A917q/2mqQgy59GE1MkY3EQCAs0Wr06Cr0SM9mqRPhFOqktSe7wbz87+wgNfiY
    M+Ci0euuVtLeISPqaghFFwnl/UqggxZLDltbrkFfJMNoBNdpAeTTJGh/CAQogVdr
    i76xhn+Oa0QJKZy0UyOEL2M6bWp9UHQfNoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244995; bh=1mmgCQVKYJ
    8unkZxMp+zJXj6A4XQ1G7IVwhrwBSjv8Y=; b=qrRj2FTdZ1rBJuOyv0D290evEx
    ukhsawQX+/K6/Kb2CImjgnRSvpsMSULFKRf9vInx55fTSH5r72wlp2utmwYBUEML
    VRHliF6TkYF0vzviM20XSbP3bJWPsgulSG6dNyaH86DCJmutQzPq6FXNaciR9/rD
    6jN6wk+N8NiClkorlrb29ZI5KFZBY6AgHUoP8DHP3ZyQ9A2NhPZLQJ/IJGQN1+Yp
    HVIaAfYODb+L3VyROtgdslTC4ScmxBomK6efpvguolhlWgUlL+yLQrzEmbKhAdzc
    P4J1t+r6JytngB+XhG6o3C55WhrDCXiMqNhP6jpnaKIF+nYfTux9Be++AWbA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J3wIFTqg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=J3wIFTqg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFNihFy4zqQmMa+rZew4fjLbybymuTBhkqYyifW6ICUnMzQvOyfzlibeJPt8bXJnLvL/yKveJQBId4QP5YrYrqq8U5Itq5NlzkNUQ7E1yeFsj1gJ94om
    Utxm54fKNRbfEatPJTiVvKc02uFvY2Gr7DDAuW8agM2zkglNgBhVdqkz6vXGcnG2wGukntdAAEUYgkArMCHBECrpZUONVlyxb37ADcNKYWBVTePBdPYcAGGo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=YF8PD-7RLpV57KenVnkA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754395AbeDIAVN (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:13 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:12752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754377AbeDIAVI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Steve French <smfrench@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 159/189] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Topic: [PATCH AUTOSEL for 4.15 159/189] cifs: silence compiler warnings
 showing up with gcc-8.0.0
Thread-Index: AQHTz5hYHpe4hC8FsUadgqu6qzkleA==
Date: Mon, 9 Apr 2018 00:18:55 +0000
Message-ID: <20180409001637.162453-159-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:hnHfhlcAon90pbvBsJEtOLN8lYyz5bocm7CLZImq++McFaHEREM/l5YX8vx/WgVhxK5VD6I17t+eMg5bRVzg5qkdJ5HmYgRa+WrfuOd2aickamUfedPAm5I6H1Q9XTR5epyNyHopnBkNEzrdkU34warHHFS3XQoh+4n9PxvrCHaa3FGuaRh9mQprSgzLIamyg6H7sM+9KuiLnKw/fsHAPG5iHIbOZaPz5Jf/mfxGossUW5VW3vM2aWWa2pwobg4d;20:iCSPUSajuOjXeoW1BplAPRIfRSf1coMVHhWXJfZe8Y4Kt2/07zzwu+drlctbSiD9+Ryje0VRnEU++qEuZULba5op6BuMmPasSQc+gW7+/yjGlW0t5A36HfIToEAMU+larTAwN8vNkalnqT5sjcT4P7ndtR/uBOVVdpgvFxHlx04=
X-MS-Office365-Filtering-Correlation-Id: 56aa3c62-77ee-4823-284f-08d59dafc75f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920EF662B86616430648975FBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(3660700001)(3280700002)(25786009)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(39060400002)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: AZzfJG4eXV98LwH7Wivx6I/ytChC/IyLmw1LgTef0W9xnuOQc8ndrAErG4QwFREKIjzRhVtEJL4XvMS72Ijl13Y/7A8/rI6u+5azdzIkEsQz17PVsiYycME+tFuuxCkVpuAEZ5DCK6UZ3WG9i5+uc6Byd28zfRmTtZLtqTnX/G1nn/NyMfHoEoSIqaUM9FQBzah/3CSq+keeOoi1ZiJo6c89lO9/FP7B1tt24KCvz2GVTOESyTJxd5p3PDXCtPevdufxofAE5mT9UaNssgZO0U5lcxTcij7baZ5Pghl160pYBfp3a+od8HCuEtc2FxqU08kn2/+nmC5qHR7yCSIOfGiOXhJnTsaHnWMGT1lPfZKdJyliaitUNncCmjyPDpWNGlXanweqlKi31i6Y2LnbErjMK4TXuj4ty6tHNkp8en0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aa3c62-77ee-4823-284f-08d59dafc75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:55.9401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 35dc5bf01ee2..7fd39ea6e22e 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -6331,9 +6331,7 @@ SetEARetry:
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
