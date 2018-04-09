Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523241555-2-4111403815551411351
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
    1523241554; b=YoFsXQzp2v4+UbgHVEvSWg0wTSzSA4bifTWRBjgefa1r/sw3hU
    LffNFZHpZMHk+MseTfuoOMFhqCPKF71QcQ62qsrqw8tzd/Hin5v6LwIkeJm6A1NO
    BzGoBP+o04MjrpO4ap5+noaeHf7fP8g8FD5xIN5tmVTBObhK7y/aJ3llPEFXcDRm
    r8Kj86noVmmSOTKkVmg/En9oE4+7t0Y0wM5GC5Kv5LXtyKvKHc6t1iQStzSaqJwX
    3DYEuTPVGIT+S/2zuM7MN5L31UOrLlD16J8WKs7sybCW1hscZdK0Vfmfzz39qCag
    BIuQuE8j3IjZzOCQkyWXjh+2qYjTTbYouX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241554; bh=zs9eTyeT53
    DblVHA1Ugdw/a3MhPN3DHqqnZ59JYhiIM=; b=kUn8FnZ0FY8YxDJEFNn+gRJCws
    eSCSqio+Y1yHOGMu4HL22/EvwWqHXb4N+gx1WLLkaicqKG84jHJj6X4zb3Sx80EP
    p2Ixu/wjT1lqIZ7vkUom2tww+fylQTjJQ8iEkn+y8NVjMRQrHItsZjStWGwwVM8d
    O+NVopoCSsxIZzF4BO9PmCvfNhOCZLHRbt2v2XGSRAu4Wke5rMgWqfvf5cBu4Lda
    ktXOABeY+flA8GiVBLeod6ix5mSoxucpQsNGB0hiHsOSBqJH4RS1RarM2sMvWX05
    qDJAk99UNlxKiUNbCmHz3XNXitLhFNHQeYH3DTj3TruOv32tS2Z2qHSJlVCA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cIEOKfFE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cIEOKfFE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJNbasjGdhMINLyFGuEJ8fc5kNZIdJz3+NJhdBJaKt9xkJ4uXLoAfLd/Y6Igq1pzHnbpFj4+Ej/6DrU20yRXbHK4PRuHh1/QmA/+9O4rqYbZlBj1/v4s
    ydsEVgcV8aS0dxAG2XupfI9GMtoQvTYM3mjB8ETwtEN6UckbQl+nUi0fUYNp4v/wGvR+TD2flzJ6JS5drp0u/q7prPiQcLpv/BiC1xAn2ZGupV29rUBlP8xI
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=vggBfdFIAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=Cy5JhgiZmkjYT0Wq0WAA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754664AbeDIA12 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:28 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:22752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753174AbeDIA1Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Netanel Belgazal <netanel@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 036/293] net: ena: disable admin msix while
 working in polling mode
Thread-Topic: [PATCH AUTOSEL for 4.9 036/293] net: ena: disable admin msix
 while working in polling mode
Thread-Index: AQHTz5j1OKCacigDx0OOOZ5rS5L/Gw==
Date: Mon, 9 Apr 2018 00:23:18 +0000
Message-ID: <20180409002239.163177-36-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:rsZVc+ECW3ZBYURwLIlka3MvwH/69ewEyArgPIVX1P6Sma6GDtEOVQW95EqlGXLx3g0tODzjt+D3nt9CJme0qpRhMmgs6VAYKxtLJ+RpvkkChR1t2iTCRJthnkwZ/fPRaED57LlL7uhTuA5AepOPkSTjADhdlai0QVera3b1ioaw1gPduEYiRenpnIbzgF7QhgRIV2K5o6N+XWN22BCjTeefwPDixB+zg5HW5RXm2MdquZJW4Ps9ri6/GrQWX/+e;20:ltZiYVPGt5LLGIX3dtkyuflQRZ4bza4rgKcEjRNduuVN0NxIukbZjwlgihc9LPkg8BASUysJQifpzJHzn6EgBAe9QJ9etzFz5ZtdMXbuqNuqWMPJuHEcY4y+tHwZul4+5CGlh1FdJ4UR2vgOC4BawIYL4dkDE9OCUU8DEfnxmGE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33206f44-4498-4f8d-1bc8-08d59db0a85a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031A78C9568C79804C832DBFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(33061846794335)(47284530071512);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: VJl2zR7yVjThtm2J/WX0TCiGRUt+vSkRkLKimdvEbqGMn706b5ZSt7pEXiYonVLfEvsDF1XSrmpK+2x1UN6bMfY49btxKAWndapZV30OSuqSXjFqOKV9OxZV4RqQ88VfOkIc+s6u5YWDobSDCNo1LX0zEUCnakaxzkLZyoNXi4YMNDeBlybi5bKZwfp4BqcotD24IT2ODg+VNJ1J5jSCvNE3F3fMoFU6L2YH67/Ha/Ajs1kPh7jG12UmhC8LvvTTWsFZXWKkzk4+lFmQ/LP/I+RVqSAsf1GU3yiSMGdYQiLu1yPDzyNpkBJOkWO3u0eOEC7S5Vfge5B4VGatWFhqm7aTgaL6npCmRFeMjbV5eZceb4uWBxiOoG+ABsZb4iZbxXHFaSUoFlDiiLRMH0gPzplBtaiKekQtnK+kZtGY9U4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33206f44-4498-4f8d-1bc8-08d59db0a85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:18.1279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit a2cc5198dac102775b21787752a2e0afe44ad311 ]

Fixes: 1738cd3ed342 ("Add a driver for Amazon Elastic Network Adapters (ENA=
)")
Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethern=
et/amazon/ena/ena_com.c
index f4c107b66af4..e13c9cd45dc0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -61,6 +61,8 @@
=20
 #define ENA_MMIO_READ_TIMEOUT 0xFFFFFFFF
=20
+#define ENA_REGS_ADMIN_INTR_MASK 1
+
 /*************************************************************************=
****/
 /*************************************************************************=
****/
 /*************************************************************************=
****/
@@ -1448,6 +1450,12 @@ void ena_com_admin_destroy(struct ena_com_dev *ena_d=
ev)
=20
 void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool poll=
ing)
 {
+	u32 mask_value =3D 0;
+
+	if (polling)
+		mask_value =3D ENA_REGS_ADMIN_INTR_MASK;
+
+	writel(mask_value, ena_dev->reg_bar + ENA_REGS_INTR_MASK_OFF);
 	ena_dev->admin_queue.polling =3D polling;
 }
=20
--=20
2.15.1
