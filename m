Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD72ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4485B21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AzAKSYkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4485B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbeIOGs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:56 -0400
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:54496
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728952AbeIOGsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPkcE8dMUtdmhJDWLY1eyh8SusnzCr/3TcHwF7yoavg=;
 b=AzAKSYkqkbWws11aQRugi1snZKySuXuBKNNGwnPKOWDAP5Ui2C+qTz/k5Cp86tU8M42AdNiyewqPfNhKS9VqSX1edLiOMzLzZzv2pOrxaYw7Nl2h9PIFpjOUfwpW2pkVh9ulXeDEcSbOnNYuktgIvtjqjWDCUxM+jv3bYOvxxwQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 81/92] dmaengine: idma64: Support
 dmaengine_terminate_sync()
Thread-Topic: [PATCH AUTOSEL 4.18 81/92] dmaengine: idma64: Support
 dmaengine_terminate_sync()
Thread-Index: AQHUTJO6odciNGLM5keGEAZTvfzyUA==
Date:   Sat, 15 Sep 2018 01:30:47 +0000
Message-ID: <20180915012944.179481-80-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:bhff3keotjKhtgT9SjZyJGp6HLH0MhAP8XBv6ZDBUwRew0/sqnnC841ubzxjBWssnvx6jQ4vZSsYps9ysO/TL3NBHI75RpwwpBqXOfjUcHNxXzjWRQo6h1e3Uc0Ijr9LYjwmtU8hzadeioY15g2W7PurgLCGiFm84BSDnmaPm6hbIX7vhnlyP/FLD7yAjhZg8ZJet8jM1BSdUBPgZte4Jzk2+lycXn9xlU2Y2su7TKwkGppFbak4Pj8uOqsZh+HMeMQtJMfz3mTqDM6aMSO9ytqrUZHuY7Iw0Y90GmhZ6Bab/oech5iVN4FwXVS9j/Qzx/R7fU9fEuP//ZX/3mysUEyazeSPouC1YhaKMPplWd+500ZgVF+tFMbOX21W2A/T1e9oIv2YzR3WH7EfcD8gUWfwZ4EV+M7S8qjJk86V6PCwtnhmd9e7lBAoMivaCcM/iEoC4TWoPi608ReTTK4SLw==;5:PdIEfbvIkqh6n1fEOpsYa18Z8hU7tTxVZbdrVLUNp82sxO4lrdEZxHiynd8EeDrgHsRHGHIBCH2nKjPKcQ/mzLYpam7toizLhs96iz/H/3mmiCtf9yBGiazA43m57k0zeNXHOO2r8JIEkUFw5gPkliae24XP4XHTnNaUfyc3yqQ=;7:FT1mXfpHuIIStqXkATxPPhq4+MiU2MfuhENQ3RXf2XGRY+KAqnyPNiOXwtHufeijlPUNxKqXjuPwGAdrpGuBvsl+rmgUDIMO0myv+hyi37/O9MJuorZctqYNGvJuaAtDj8xazK/whHPBJhp8XKm2Al36DdkDKt52lqykzY9qMyvvNcr4d6z8LCmggsyvxSPc4FtypjX/hOoHBiQ9AtHl4vGLSz52lAz08R+hezKpK93QNMqd48Q8BIJOtNoF0T/w
x-ms-office365-filtering-correlation-id: 5b692d9c-4d31-49af-de38-08d61aaafbd5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470316AAFB9A155812F10F4FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wG2HAWfM00G6mybdjPXAeLEGgzEJQv9dqXSZg5uRe9muXcIn/VKcMrqa3LJx5xJmL1vaLjOzix/qCSMXv0l32HhHryejjJrv7sFeKFe+/H1eVvY9GKkHTxkJJQ3OToySaRqV601PVNsnG98Sa0Vnmvaa+WsNfrEvy3NnjhT5eDeLL1cjjp/Tl+4qys/u9BRw3kwE/uL/MWlqR6Aysx/tlqIqsntN/EJzEqGwoU5PzT25U7dvE/231ZxYatY69jnuYGTZ6m8WZKRjQXRapJ1JR6nwnUao9ZIs26YsCxJNwu6K/Pt+PeBQ+RdxqQRaGMTOCVnhRx+l1dS7U1CBfzk3kAmPFF20aetRQNg6TcS0qeM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b692d9c-4d31-49af-de38-08d61aaafbd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:47.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit bbacb8e78a3b29ebdbb6af7d54fcf25d3f1c248f ]

It appears that the driver misses the support of dmaengine_terminate_sync()=
.
Since many of callers expects this behaviour implement the new
device_synchronize() callback to allow proper synchronization when stopping
a channel.

Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization s=
upport")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/idma64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index e5c911200bdb..1fbf9cb9b742 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -496,6 +496,13 @@ static int idma64_terminate_all(struct dma_chan *chan)
 	return 0;
 }
=20
+static void idma64_synchronize(struct dma_chan *chan)
+{
+	struct idma64_chan *idma64c =3D to_idma64_chan(chan);
+
+	vchan_synchronize(&idma64c->vchan);
+}
+
 static int idma64_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct idma64_chan *idma64c =3D to_idma64_chan(chan);
@@ -583,6 +590,7 @@ static int idma64_probe(struct idma64_chip *chip)
 	idma64->dma.device_pause =3D idma64_pause;
 	idma64->dma.device_resume =3D idma64_resume;
 	idma64->dma.device_terminate_all =3D idma64_terminate_all;
+	idma64->dma.device_synchronize =3D idma64_synchronize;
=20
 	idma64->dma.src_addr_widths =3D IDMA64_BUSWIDTHS;
 	idma64->dma.dst_addr_widths =3D IDMA64_BUSWIDTHS;
--=20
2.17.1
