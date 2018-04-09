Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242970-2-1828685858221894052
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242970; b=wpOzS21x+bImTibJAOSmKuMCb5TFdd5RpIp0Njdz0RMWyPYKHQ
    n8KVyHp3vlQLfVmAFhygzOLBLVE2EGN7DszfSfEh8CZyxrRfZj3Mx+1goLhFBTRO
    JuLbvFLd2LzFrOXnooFAu5j99ddkt2gBlQUBHu4KcozJlcBK070s4eRMiJMvfyde
    dq2wTIA30ezi+x9J4uNAQHw3ECi5DEJloq7atsb1FTAmjFLQdCthS2/YYKTAe5bH
    mydwVdpErK1K94BxPbsKq3eVCI2fHRamkuZu/GPAv0NytYNN+V9bVEHilbBFCXVj
    hrBD2fuvbbtRvm4HHfErCfPCVu+zEzOh5LGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242970; bh=E4KuhBtCSi
    CllYd8KmLMLfcNLbxocbqyDrOnotZABsE=; b=YGT+bGOkHj2X6AX/ScHe+UNnIp
    Ww+Dy1TgqYyZeuM6Lj9XlGGMVV1y/DifeRgxnA8ZChlSfzZmRB+6ZchJ8AeJCiPa
    0v8RA+/STuF+k0g0oVtmcPVRvHPnm3hN9QA9gozD5RJsw53+/BzXPc42HNZOVFJA
    rVtzoOvckwUjcrEP77XYj+QiMIWV/C4BDVasuHAaDORvYir38+nK+nP46zwLkRt9
    62BLgJJY1eSjha8oUt+mzwzqsDNcSGwO7c0YhiiW+jFiMqHhvktZTx3UJ60QElD0
    C+i8/A9J7Z5zxkgFHxZc/0xpCXvlaXvgmV2pgfeyctHkYZsNHXkZ5dZ1RA4g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TVr0XcCZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TVr0XcCZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKPPOELTdwn1+LuRDOqLolqh6+4uVnMY40Wt4aeQNPr90DYQI/OTEtW+y6t6ohnsHYvhAZxA2Xtmh8BzFVJ08VUJ1e0Wvk/sXHKkC2eqnaUz5ThlrZIk
    LZCWFVNT+Y5hFjUiA0Cv5iGYeyyNp5qk5rbaZPbumzGJ6vThC8GT/Aj4Z7gftvZRk0hjHQDIJ/aJVdvMEGj0YYRWPDLffRGdvqbv0MJKy5VUOHHtaJgwuuFc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=R0T72MmZjkIic9apZRoA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754334AbeDIAZX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:23 -0400
Received: from mail-sn1nam02on0138.outbound.protection.outlook.com ([104.47.36.138]:39392
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753172AbeDIAZW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 113/161] s390/eadm: fix CONFIG_BLOCK include
 dependency
Thread-Topic: [PATCH AUTOSEL for 4.14 113/161] s390/eadm: fix CONFIG_BLOCK
 include dependency
Thread-Index: AQHTz5iyVcUibW7Qk0W82TGFrFDGig==
Date: Mon, 9 Apr 2018 00:21:25 +0000
Message-ID: <20180409001936.162706-113-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:cho0j7EPIX7lClZOpX+LYCebV3xzJAyKbLHV1RWsgozZGDmOiSMgAJgwobKms6Hg3kz52kiaCq1JF5XUGH8qMNOWWEyaEaC6+SnKTh0V/F417dLtC/8TZkHIHE9m7dR1Tv+jahYch4rVv7DuTFM2Y3zdTRPNqBMxvRzqNP5BcKhymQSP89X8ctRJRao/hpo3TBd1j4Cqrw4+kOYH2clsk3JV9pEwp+xuwOCM/DOWdAUcVzZuuo9AU0m91M86BdT4;20:jsorWCDPtRHVyw/cow7atv+UWDuLxAD6SHXKDTEUvffIopfycMkzYEz3qTEa6NpGeLGeAnUpfesPazC1hIW8LWK5xhtNqaYreFabCybcTCopkl0g+T16HxlSETuPnusb6St2v3XS4deus/1Io5kbZdFpTvqn4olOjlQYgy3GYIY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fceea94d-66c8-4cd5-63ad-08d59db060d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983A02AB77C2B2565088535FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YeO0tmaqKKBJq9n1pDR9Q+ugcCyK37v217nnJo415Q+0BmIn1njx7OxcH/qEHa1Gqv2crWj55qCele+Zklt5HcvgbQw8IcfiZB+iTw98Iq/Cmwnr+D0lzqUBa4bRwbQKMXqKZUlxrlsObp1KsdjGBULGOdUkwmsUc+g1CiURxrzeCUSyG9FUidJgjWMb1LTP7mKBOftVn17S3XERgwvEUNdRv311YBHmqROcXDFgQtyIZD17DcsLSnavBevQH+DQ84aSGGVm/Zzf7fzXPnJu+23GN9SfOdXII6jQAheJ+X/569s7WAGUdn+5sL43IO/eYla242uEcyBLWwgAHWUcTX9qGzV0DdgN1pMlqfwJBZ0kzekdsh/cg2pSmRcY0p0XEHexgGcpAIuR5be0Qmdq7T/AE8z9JBazQIvm8LLk1ZM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fceea94d-66c8-4cd5-63ad-08d59db060d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:25.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

[ Upstream commit 366b77ae43c5a3bf1a367f15ec8bc16e05035f14 ]

Commit 2a842acab109 ("block: introduce new block status code type")
added blk_status_t usage to the eadm subchannel driver. However
blk_status_t is unknown when included via <linux/blkdev.h> for CONFIG_BLOCK=
=3Dn.

Only include <linux/blk_types.h> since this is the only dependency eadm has=
.

This fixes build failures like below:
In file included from drivers/s390/cio/eadm_sch.c:24:0:
./arch/s390/include/asm/eadm.h:111:4: error: unknown type name 'blk_status_=
t'; did you mean 'si_status'?
    blk_status_t error);

Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/s390/include/asm/eadm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/eadm.h b/arch/s390/include/asm/eadm.h
index eb5323161f11..bb63b2afdf6f 100644
--- a/arch/s390/include/asm/eadm.h
+++ b/arch/s390/include/asm/eadm.h
@@ -4,7 +4,7 @@
=20
 #include <linux/types.h>
 #include <linux/device.h>
-#include <linux/blkdev.h>
+#include <linux/blk_types.h>
=20
 struct arqb {
 	u64 data;
--=20
2.15.1
