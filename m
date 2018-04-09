Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235401-2-5509219068424649743
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
    1523235401; b=a5WHIkUgWIZDjes8UriGBCygXs6UvD5ka44BY/ewQYsonI1peK
    TI1Opbe5YCLPg1C63g4rtpQi2aIf6SHwu7JGlNc5LBLb6S7MNO4zWjFbn9K46zpv
    39z90T3eAsxXM+FPY3R5NXRshM2gluxdoWlVmVObtbMacxpi1kGqnID+jne9SeD4
    O/y79fYDhTpjgSVmQIJ1MnYS6ctaz0kfMZH0rLnDvWDmZQjx/iF1XZ1Sfrg9oDzB
    WAnk3QDp0JebHxr4a3pkWMJmibeAk6Qy7eJ0A18gm9JmDY30H2Ye8UwCczHEY9am
    8ZV/DT2WgO/zd0izkWjNGDGdcAitcyLhaRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235401; bh=vbXH2WGSWU
    c0YGknpOZziAtTRj9DlpDGFks5/qhXuj4=; b=IA2FeE7L/43hFpsQkXCvnQHCME
    al9LVKKToDVcFGmg/5MZoGsQnwYSwjxxEs1cakVtDtOJkG7hJfXDbfXP8gD9mTOv
    BjadBtZ+g6wsoRirMVZabNe2BU+NKjUXy5wZe3CRCqhvSQRVWRu0sQeioq1drGkH
    /OXSYO0Otk2Id3ZmPIeaFn2O1JGvpM9hGxPZGNG8ParAxFmKymd9q1ybQ1LLJfCi
    Mj5yPY1EEfvVteRcxtOdwCPr5xLn1pTQ6wakf58zARU8AotRlEp5bvcjv7CrAbK8
    9pomVH+n/SQQL3B8o/xr00Fk3CsOl00he+nS+fAXfxGxyOTHndmTPosA+umg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SRstj7cs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SRstj7cs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCfR12Ai7RZEwdLAw81xCulu+d7U1JR8aKDCRQI1XcTZsDL65Td7TR+SPD1BiF998Jxm92InYGl9eDzG84S6lacVl2lkfOk3IQKqjMnRUr8aMTspD2uf
    qgpxv79FNUGMFz04C4Efk7A+WdgDE/pO0ILSzF54qo1ZhepKIxOGraeB9uiu6arli+BeFSSL5WlWx9FPBX8C5Ciqbn0cW8DcfImJ0FnUZpuhnN1O54S4vwG6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=90DHhu6yl-ZiAArKOCIA:9 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933353AbeDIA42 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:56:28 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933277AbeDIAkX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 040/101] arm64: pass machine size to sparse
Thread-Topic: [PATCH AUTOSEL for 3.18 040/101] arm64: pass machine size to
 sparse
Thread-Index: AQHTz5q0fvV7F/b4TEeyN3wl+hLkDA==
Date: Mon, 9 Apr 2018 00:35:49 +0000
Message-ID: <20180409003505.164715-40-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:QTSh2VzS7jOnIWaUcnPXH07DrotesHf7fVvUwU55YN0bsAYgO0YHyeOMonwegNmbpsiwSxeoQB/2lwzbCTmsJbepZA/Pq1bw2D1wnrG8xJCUyhOr0Vqm7i2Dv09TDyGxVrlSqUlJjkwBIXOlpB3oawAod641yJ2ZjsPPbqkWjcnwiRQuNA2jh0aKZqVN003r/0vsGPYhtCH88SSy9Vf6PyMW9nXkreYKtEegDOFi38H8hZPWI+7yL3sAJspTlcCJ;20:dYHilwRoG2Yu2EyUpS2Z5UytjO15MmHWnXgOxelL0zSXuE+kyKAwFGQeuXdmXOun0DrZurQY3/+i319GlFQdUfxKBHREWa2wmfogi2HU33cqYJ5QMdy+tgR5Uc+epPValnWr6sA4+YGkxZfdXV7vc56QumvsA7QJlpcsoo5KTLs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 36568074-57c1-41f4-b07a-08d59db278e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08705F9D54D7C2E4BF8CE298FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(575784001)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(39060400002)(486006)(59450400001)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NyXPqufwRC6CJORoQBGhYdVz6YM3fGN1eai5t6IoxBRa/7Tbp+FDfdHUayFyNABBL0pv6fXz7egwMBGN1apKwY+n4ubqhVB6bI/oWOMxP/PqsRxY06ypvZwqAPJiejr2dt7FDpUm4YCg97BqovzHJCcqhSLplfRy4VFm4wbvVVfpB3lFA7DR/ygwfgUNETHWkxJpdBIDz9++PRSYRWHLZkPJXebnhKQYOIACIoNCfwweF7Bi+2GROUhLTPPN0SlzY8sX5/N8Ih6xRRKsF+aVJSeJYAM7jQMDGn+GfpJLf6hgQZYYBju/UFZiPUGA+8ZD0PKlM9+w+J5iY53fhhyx3NhIldTR4Uj8o8x5MQfV+ws/mZLfupvJ41aCiYTE+rg4Mz53sxAkUhCEjLdcmuLmkBQGSpyqhcGWjNs+6tztJLI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36568074-57c1-41f4-b07a-08d59db278e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:49.2672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit f5d284900c0f960e318a063f4c40826b6e3aa6a8 ]

When using sparse on the arm64 tree we get many thousands of
warnings like 'constant ... is so big it is unsigned long long'
or 'shift too big (32) for type unsigned long'. This happens
because by default sparse considers the machine as 32bit and
defines the size of the types accordingly.

Fix this by passing the '-m64' flag to sparse so that
sparse can correctly define longs as being 64bit.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 37c4fd6aeb7a..3e2f6590666a 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -32,7 +32,7 @@ AS		+=3D -EL
 LD		+=3D -EL
 endif
=20
-CHECKFLAGS	+=3D -D__aarch64__
+CHECKFLAGS	+=3D -D__aarch64__ -m64
=20
 ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
 KBUILD_CFLAGS_MODULE	+=3D -mcmodel=3Dlarge
--=20
2.15.1
