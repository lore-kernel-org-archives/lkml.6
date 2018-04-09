Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245767-2-18082026802392631271
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
    1523245767; b=LUtA7XCK/UjHvy/gDUEKh8XJI10JUsLq7I010LtEIf7zAOGAfz
    6xHY8Z3YX5JUMPN256oLUTFDHoBbngjokPfdXlsR8hB/PMnRCrh5Z9qOdFsov/Ld
    jyx9Xie6x4U+rZmcJMqP0MNFNToFHscaWsZCHQxWN7eNbcM8Dw4N5hC67ym/hLmo
    ClAKsm8wlYwEg0KorTeHmdREptQui3zBTP9bmF++v0s9Y2oTrCG3wa+7wOu/edzA
    hvMYSH5fyq09NfzVN527ss6YA6bxnMy1FEEZcwqJdeL5pLRsWspz8fUhT8fuTSkh
    mwElcwZ3dTSXo9SgLd/bTkvjzwANdNZFrRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245767; bh=DmxEhCYZd4
    RGO08GTDVOAh+sM6Ycff6It5U9dlr0EY0=; b=u5RpIA3iLs7V2AMyjIva3RolCW
    qGQbO26ZPKK/6Om3H/VZ5QkNhLOX94TH030ySi/lSEnR9DCjxiqD6O7yxbOb+qNo
    8ZKSnXyFY2HyJ5cHMEX1ZaobR+Iln1UYxI6R0pJaKYF90zrycAsfQzpuU/v9INUE
    1+b5Wp904QcgezTBeB02u+LulV2wR3utdZ/9NihaK/k6rHn0hltKYyUAATwN2wb/
    ObsT4r4WpnqWQ1UseHe2GXHJ8hqfqTorbAw/O/b6NO/MT+4YoJoheyWfqAuTIqDT
    emZDxCfB6SYPztqGNZYtMznEIImpqVMoY7tgjCWDOZVwYyShoOee9Tes7HMQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PwH4BPdc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=PwH4BPdc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfANoJGK46/n+99Y/j3VVbGp+8a4fkGOTVTole2aQSEE9KMqI3xuQiG9lnaYAIQzR6YoDUEpMRSfY1I2cBg5AER0hX1Cp75a2rzrMc7yWlZa6hkzqkkwi
    /3R6D302f7rhep4TdJ8ygJTipzzfYh27chA07lO7Jleq9OmDyMVdvemDe7JLux1vg7AfOzHGJAF4cypuZLYn5wfB1QLSk9YQCup5ZvIToPnyJ6Hom+apha8J
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pFyQfRViAAAA:8 a=yMhMjlubAAAA:8 a=SmiJZe1Tek8jb6qnnVkA:9
    a=iwWnhPSIv5rQQBxf:21 a=7Xb5lxL9i_YMrfAL:21 a=wPNLvfGTeEIA:10
    a=oJz5jJLG1JtSoe7EL652:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeDIDtM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:49:12 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754064AbeDIATb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 110/189] riscv: disable SUM in the exception
 handler
Thread-Topic: [PATCH AUTOSEL for 4.15 110/189] riscv: disable SUM in the
 exception handler
Thread-Index: AQHTz5g/xo90ID6+0UGf0YFrIE8+dw==
Date: Mon, 9 Apr 2018 00:18:13 +0000
Message-ID: <20180409001637.162453-110-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:40G2cevw1GIzcXrJXhL2U9sBLcpBErTz37L8zIposRjb0HBSuw1MuLBRY+VQPX+qy5s4KXoZw6uLF+jVCaYn3p2zrrg9tvfaQcuoVc3I58PzVNbKDXk3yitxBQXb3xbKhlSThemwsN61xX3bzAOZc8Z6VpQfqFwB2tUyqH3QafUwhwGdh4oeOgETG7N4n7jBCm36JchF/1Zv7ScZDGON0ROle67cxSGtEdBiAsRgAmsTJWBU+pRyH80nyr2e8TS+;20:/1iw9l7OvqsBjr+o97zbxONkbr7dwJKYU7qoIqcbJi8MW/PlbmceVjIGLSU7CT77+HYDTnwvDjBXTQiTI7nvnIWf/7l0DJnSg/JDH6Nzb+7zIZzhBdUqxznnugevqRE7e4D6eteB6DZimV45zkTqIMecxIAaZsjvGbMagYLAFP4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2832af2a-fc41-4d0e-ba3a-08d59daf8ceb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063537CF061EF0EE377243FFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: VIP7CAy98ceYcJF62IE/GH9CVNi0qP0hHQlpejAMQTV+jEASv3pQXAlr+48Htdt0no0ZlDerIhpPTehBKHOThGv9sEynTBDf9y564hGNxL6cGcprUZeXUDRtuM1ZhN/N4t/kemVFS83YD/pYd1w74k61/jzgpw/+OkWAhoFCEp7MiwSw+yMYTL7UXEEt5ZvMUvMgwyl/0oC0i+dvBFsnvHiBSSV/stJ893w3v+zFQ5zX3bYW8Ios5aeJ4sDY3UqhT6XT4Q710rxjfDH4W4p5Cap7/NrfhBrQs2uiATPXt6zBphtmzVPCm78/jGjhCay/PIaOzmQ4MP9GTuGQ3klzTXWv9up5Zy3bMDG7s/TRRXjhLW+JjSN9NC32AGa3sxro95nafFJG0HQ12Vl06gDExG/P/8sbQq1+NHfooq7Gtc8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2832af2a-fc41-4d0e-ba3a-08d59daf8ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:13.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit fe9b842f72921fb18b93cf47a255f374289ef242 ]

The SUM bit is enabled at the beginning of the copy_{to,from}_user and
{get,put}_user routines, and cleared before they return.  But these user
copy helper can be interrupted by exceptions, in which case the SUM bit
will remain set, which leads to elevated privileges for the code running
in exception context, as that can now access userspace address space
unconditionally.  This frequently happens when the user copy routines
access freshly allocated user memory that hasn't been faulted in, and a
pagefault needs to be taken before the user copy routines can continue.

Fix this by unconditionally clearing SUM when the exception handler is
called - the restore code will automatically restore it based on the
saved value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/riscv/kernel/entry.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 7404ec222406..87fc045be51f 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -78,10 +78,13 @@ _save_context:
 	REG_S x31, PT_T6(sp)
=20
 	/*
-	 * Disable FPU to detect illegal usage of
-	 * floating point in kernel space
+	 * Disable user-mode memory access as it should only be set in the
+	 * actual user copy routines.
+	 *
+	 * Disable the FPU to detect illegal usage of floating point in kernel
+	 * space.
 	 */
-	li t0, SR_FS
+	li t0, SR_SUM | SR_FS
=20
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, sstatus, t0
--=20
2.15.1
