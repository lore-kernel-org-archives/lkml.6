Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244204-2-2614434678887758778
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244204; b=jTCSopr64r87sCjNiAuW9dj7g6B8xOQqbSyI28U0a7w7MSef4R
    kQ3kkKpNkJNAhwDezDD827s6jEGsJ0Bb1zWktJKQ9EhBnkqTxq2pXBjVYqyDiqgL
    I0vSUPe+HfPvo3yvq14ZbP9Xs+rLvboxWDUbk4trf+O4Ya1yH03kr2+703npVjU4
    qvFZWPh25rQQZQLLBZh8zrDWNoLBOgcGiNcIkBdQx8ddvxLt62F6NSrKL7RmDlx8
    hFu5Cn6mfxBn11nbrH9DZEG8IOPdQfIN51gexifGf4ki6/AZ+hKtRAAhYIaI6x1A
    tWhlpjxSut2YhwCn4m6P4VdvhXF7G+LKNRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244204; bh=nldlfgQZSU
    y8/kXhF8R3udGjBiufIjwtdBn3lLE915A=; b=FeNPlW1TVUO8E4fs+BwQJ7AdCq
    G5HKZKdrJzpRPqTTm9eRWQHT9WXCzgW5dnckuypas2KscbP5PqLB6Z8lWWuvySJ8
    4bMJmQ6oLCy0wB4E3YZTADj5mVDkWuN+Fn36HlCBpXPprDKwnB9JLQZpya3Uxn7P
    86tWKF/7S3BL6G8vfiBqnMGsF7Q7GBMcJUiIvU4Om4DC7UzMtM0a8BLLbaMnZigY
    8XsKmfa3GRsafEX0EtdAAdXUa4pOi6hhpzdHT1h2fGLYGlY406amYbi/EODwYVUi
    xjzymsHmlcrrORQRo6HSDO27TENUe00791vjnxvtbY9/qN29NWnXl7wpMOnw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jxwTyESI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jxwTyESI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC+8k+zUl/dsD3jcMRqBufWw5tLhSbwWcpnhy/4W7//M+kcyieWzEUKKrllKLbRRvis0eab7l0XJ2qimFzvU3fAcAD7+JlwoZQb+nPz2dyFctSpDuMLc
    lkRRMhe1q45lZ7ul51bcokee35EWRhLhXoPWY5jJCtUsXlENvVY224PnyUFE1CVPKFMPrIEMSTnpgafaYIgtMmN7hwGCDKoL1YO271nygsBCp5PKPv3+Wevs
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=FN1NBjK983BEj7eZai8A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeDIDWl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:22:41 -0400
Received: from mail-sn1nam01on0134.outbound.protection.outlook.com ([104.47.32.134]:37792
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754746AbeDIAWx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 041/161] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Topic: [PATCH AUTOSEL for 4.14 041/161] MIPS: Fix clean of
 vmlinuz.{32,ecoff,bin,srec}
Thread-Index: AQHTz5iJ9Y0sPrTSZkWFGdTRSijEWg==
Date: Mon, 9 Apr 2018 00:20:18 +0000
Message-ID: <20180409001936.162706-41-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:YDJ58ZbH+HuOL5rUuWMFoLkTgMgmwcYjEDD9cvqnD4NoBkoUdkj1YCe+TYpQ1aPn64mqpyWJRJXnYbtdLl9macSyrNVpWRuErkkNV9Ti7tUUPDxJEb8MoWnDdVNUEY4bR6Io3c8uhpDlixJtvAfHV7h4r/QqNwAHPBNu9B8v9oyD0Of77gBlLqDaoO27xT74iE76eBs4EoonehMZ8q9Weu+SdonQwW/qwCDVX73fE7Y+0E1h4DnKHDNpYIbj5aZU;20:XDB1rFaTmfoTRkTZb+M7xV1rg+y2nl75zD4stImDt/mmUmiGEtdOHpLuXmN+mJigozAQazWG3D9XcP9lvPBGuDqNyCWH1wKwKX7SB9OcGDreHKpCpKsGA6KdMrMX7xHPogLTn0uWq01+26bjhhWqGm58tvDjLFe+rldtcnQ2WCU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 388ad588-72a3-4a8e-d2a6-08d59db007b9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10147C9F6E3C789901AFA398FBBF0@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(81166006)(81156014)(478600001)(6436002)(72206003)(8936002)(10290500003)(106356001)(99286004)(86362001)(2616005)(7736002)(2501003)(6666003)(446003)(476003)(8676002)(11346002)(105586002)(305945005)(5250100002)(6512007)(53936002)(68736007)(6306002)(107886003)(66066001)(86612001)(966005)(2906002)(14454004)(186003)(22452003)(25786009)(4326008)(2900100001)(486006)(36756003)(6486002)(3660700001)(59450400001)(54906003)(26005)(3280700002)(110136005)(1076002)(10090500001)(76176011)(6506007)(97736004)(316002)(3846002)(6116002)(102836004)(5660300001)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: QtIO/k2ikfxgzGUtw3pSDChzlyBP27J60j0EUqCHMprqnDMf+JZspHJD1NsLlh7HtAwf2zMK4SgJX88AVG8TRv9dPyAj9yUbOE98dTOf4t5QGh4C6t0q8Cm4dBmNAUNs1EnZyU7clpHp/ZYMsMc8AkGDj+HkBBrqCFUXLyLqUVo13QaLMXjcrJgY20Z6yUOMXB3zfwQpU510MSjrfreIKVnv9MFJ8K8mIrpwkBxAvFG1OZesTRa/eZzsUQnOD4HN7nb27FY0/Y/sATH7oFoj+QWD+uQbkQC6tx5eAquXg1W4QugVplnCjj+GXfgbcTc8qaMwBjmp+cHsuj8LzyY3v9pIL6h2jsyh2qC0e+1+qesdbSlVn9ngGyZrAQWlRkrcT8wFBtKT/hq3BOoiXZslM+SmiIJ3FeJN/de0vpKENc0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 388ad588-72a3-4a8e-d2a6-08d59db007b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:18.1289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Hogan <jhogan@kernel.org>

[ Upstream commit 5f2483eb2423152445b39f2db59d372f523e664e ]

Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
separate files, so none of these files get cleaned up by make clean.
List the files separately instead.

Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make cl=
ean"")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18491/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/boot/compressed/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed=
/Makefile
index c675eece389a..adce180f3ee4 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -133,4 +133,8 @@ vmlinuz.srec: vmlinuz
 uzImage.bin: vmlinuz.bin FORCE
 	$(call if_changed,uimage,none)
=20
-clean-files :=3D $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files +=3D $(objtree)/vmlinuz
+clean-files +=3D $(objtree)/vmlinuz.32
+clean-files +=3D $(objtree)/vmlinuz.ecoff
+clean-files +=3D $(objtree)/vmlinuz.bin
+clean-files +=3D $(objtree)/vmlinuz.srec
--=20
2.15.1
