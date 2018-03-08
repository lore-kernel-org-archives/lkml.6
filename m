Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488430-2-7759882472811920604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488430; b=Ii9llMxXoQBXlHl1NDhqeZi/puYsZ8RJ0xohERRi2c+lolq
    TIzld3eipBoVJA5cHLC8QH+rLcY5qQpKROX0JlqOOEIu3XsGI4OcVWMj4Ct7J4GL
    6GrcpKjj2g+Sj3OrKFDnYpxgBYlHAJm/10A/UKs0fPtdw+mivqfswJMBHWiICHgB
    I/wm0Hjd32gV0eHGNveFW/6OBvEzPVmEDalzvCiGi2XCKIpzsehxyQRO5ZltOXUE
    qDrsZaRjRRv0NTlaFOg04G3PGXYjv/QJBJ9Rw7BdkANvHwT2w6soan4wUUps9ihI
    dDBQxBiDI2tanXzis3REubHmh7TEH/3J+x683NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488430; bh=C9Kusg
    LnLmzIs7t67du+9/mYMjLOLRmh9LpeKUK1/zQ=; b=P3byO2j7+WLL/GpcUI6lvb
    GUqMiyuFvltDnv8FR0GkTFPPo+7zAFpoAmTEo6eLasW876ntQqVNipyEzgdhbioe
    iUwCzmZDwDg9Ac7ywVQLhenoAwk4iCZF7JcG8B6K8Sd/qGwaQIk2H9rGuM1vfVcL
    QUxW0EIkmcHqfpCj0cbUSVcoPFvP/G+QIuTjjWwvjmm6/GB1TiHlajiBxWxPGwKo
    pZ+0mDYQ/kzvZjfuph1Sm+yyC1VmFk+APxNqw89dsv28Q/mcBxog5L3/7LSYY+R1
    uDUyNNYGvRKQpFecseXnmM+MUQ5M/eScVQUpPeSco/x2lPgvK27+z/60XKNKqSRQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UQVCJg4R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UQVCJg4R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965887AbeCHFxH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:53:07 -0500
Received: from mail-co1nam03on0090.outbound.protection.outlook.com ([104.47.40.90]:13700
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965792AbeCHFEG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
        Kedareswara rao Appana <appanad@xilinx.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 167/190] dmaengine: zynqmp_dma: Fix race
 condition in the probe
Thread-Topic: [PATCH AUTOSEL for 4.9 167/190] dmaengine: zynqmp_dma: Fix race
 condition in the probe
Thread-Index: AQHTtppToSyWA0+ciUa6ORKfptK5kQ==
Date: Thu, 8 Mar 2018 05:00:06 +0000
Message-ID: <20180308045810.8041-167-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:v9GEQentC3PMYNJtM0o/2l7TKRH8liPfGBHCv3cVxYf1a41CQsTHeo+k3+PCo+Yca9eRIyJ3TGYCs8Ae5MzfpH54qldlS55uOiElFvN5YyFNhA0xViLd1Uw1bJrVDyuUUxC8cOBPKKi+qly1Y8pYfM1QaJuYB5IqZfVLGquRh/SZnPiqgx8bpf2hXaGul3KcFOPwrCeUUfHk/U21px3Gm5cZ9qNuSu+ANYPDol9FG2/k9yDmX/5r9qQ6wtahARBm;20:tHhI+qtGfw6ER3ZC49ME5kcDz65+DgOPjEVdOKdRafTQeaszv4tuVnkqAUeM6BfhyKtlStvkGQXsG4wMzi9N1DT4eIfURwGlz/gGPMZ7hBeDvsFP0DJS89FwFxOOevpIqL3Ey6cOt/nu+ax6Ox07dPqPzJCdbAIXmVg7MBtmRtc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd31c572-f0b2-4db6-7249-08d584b2020a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919690CDE1138B2E1F99B11FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(192813158149592)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(8656006)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8666007)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: S9bODC/QhVVKuPV1KTydY3XM+I9TNtJdeWvH9klfxsoYocP78yv7V0NZcDEdNa3wZ7IJQzHDk6F5AHIWWVUHkmOmLK9ZeU40CuCd54d3ugm/ht9NrVluib818Ve1crybugLogtF+rwr9UsRDRihkEht92kfbNYNtyreKh8A5pGS6tM0NsapE/vGkPddqa1hpDDVKbNSD/zTLGok/gGRd+mUdXkPgLQojm18z/rS8j+svVFbk0Ns2czQrIwHc6SEujOY6bcC48X5AeZ8Jf7tpfn3rePbWtx3iIzDUUnBHdl2dnvc0tobNOoSdxaVP+7wkv0whgvw/3DDPUpNjxNMyHg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd31c572-f0b2-4db6-7249-08d584b2020a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:06.5140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kedareswara rao Appana <appana.durga.rao@xilinx.com>

[ Upstream commit 5ba080aada5e739165e0f38d5cc3b04c82b323c8 ]

Incase of interrupt property is not present,
Driver is trying to free an invalid irq,
This patch fixes it by adding a check before freeing the irq.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dm=
a.c
index 6d221e5c72ee..22658057fe27 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -933,7 +933,8 @@ static void zynqmp_dma_chan_remove(struct zynqmp_dma_ch=
an *chan)
 	if (!chan)
 		return;
=20
-	devm_free_irq(chan->zdev->dev, chan->irq, chan);
+	if (chan->irq)
+		devm_free_irq(chan->zdev->dev, chan->irq, chan);
 	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 	clk_disable_unprepare(chan->clk_apb);
--=20
2.14.1
