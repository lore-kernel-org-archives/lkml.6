Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523240934-2-2846112778120380328
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
    1523240933; b=u5nTMEDIRJLhvRhNibGNHvUr9QmzShkoAkHsbt5GJQbLU6xWEE
    ZleqMye+1QF4n3oHFYGUJ4Pz4flbh+gTWOk+yXEgJIYs2HtRLvaV4rgwwWq9oJcr
    8pMNJeizmSNpD1fnpSACcBqXhJ4DYq2TBey7fYnIRDBWBTxq7N1hlEvQxIA52L4W
    JCVTeTxUfTEjbV32dpk02SHlsGfUJcLl7r0IP3i5aEcq0doBUIHTXoAretc7f7sW
    BAwIuu9hjEEBMEqETq3JFvST0/rtycTL6pA4Wf78sVzKHxEatQ4t/odPLVNRDW9U
    EvtY/Us3PTUSVgGBmmEf9T5ZBo/dImKVf1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240933; bh=o06LXp4ulC
    StsE9JtPb0mt1uBbDT3Y+S4AxHBUjmxus=; b=ndWENWwGAJJjaHV/xwWKKhj+52
    ABwmRohoJEOcnh0uu7UPxrW3HiYUBoNEO3khMRtiwvitjK2xTevqGxz9r/Gz10vj
    zPcbHd+bqAoXp01oiVXAeczaMBMlvAfOGTdXlfxgDlYueab/OFUT2N8H6xfzzKFY
    o00f1L0jtQwqSjubkJG4RQjaQx+Doxxi4FmM36oMtY6uIXyv7Nj67UO7wYYbkOMr
    6eLAa7Du1/90qhKIXAKKhTFLLy7ztmnjDFqlwW4Phi3I2rlMQjOoZVv3JMlEIKzQ
    juaZw4sV7JAvJjvR0V4m5ifVAhiv6aS30U1huVzbsYj4dmVsR/q05RX+ppvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSmYplcU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSmYplcU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKIpmxyltM6MdDGIVPSmTu0ZHW5dURkfaug+s4HtsVCI2VwSvAqPje6idflVyeCLvPVDAlzvDy4H+KbUxA6zzwuwVIHt+0TOOeELd7czlDWrIxOItFnQ
    G5KBM+2tsbP58PdX6qYhboxSc4E0jmMlLt4BtU9c2y+OegWCLbXeY+LxiJKnIOj206Y9Exl/2zuYCd2B0VHajdqP+fE+xSOVtucaYJqIf4UH5Q2YMpNwmCWy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=G3uK5HJVzsj6bgu_yqAA:9 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757624AbeDIC2a (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:28:30 -0400
Received: from mail-bn3nam01on0096.outbound.protection.outlook.com ([104.47.33.96]:38912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754339AbeDIA2i (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liwei Song <liwei.song@windriver.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 081/293] i2c: ismt: fix wrong device address
 when unmap the data buffer
Thread-Topic: [PATCH AUTOSEL for 4.9 081/293] i2c: ismt: fix wrong device
 address when unmap the data buffer
Thread-Index: AQHTz5kM6TXLk5UEgEqHe0qn1PMEig==
Date: Mon, 9 Apr 2018 00:23:57 +0000
Message-ID: <20180409002239.163177-81-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:SMPQU/HdEVi14qj8D/MKuFZyQg0cPDNQWGnbOKpcwo3n1S2+u2i42F04bBV6yYlvTZL9CZeV9ck24EKTU4V0RLo022Ef9J+wz7axVohfHTzv5jx8S6u/gg4fdTTIamdk7t7lAfeDSo2NCWpFUH8vZsAHVuXXqiNY5NnFlA16FrgC/diU9anj4L7amE4Teb64rGk4okeR0ybqM1tCObeqTCYC2ySSj3mreVic79fl20jJrJWzOI6L/2puOFZYsQoG;20:Mtf+sEy/tSq7opHmRYySodsy2ILglxdhB4FMCw8l/QK7P2ciofY2ZIfdzp85aLE0ckcJcMsuKf7HaOp9X/9G+gKFs12sX6HTYwyxooTz4ChPQwYcQdYsMK3XhMC2jKKQG0hAWnCh/XphMs++wW6gMx45xpgoUuupXyh+Nu1tfV4=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fae34608-8803-4d23-2deb-08d59db0d2c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807DBF9F87FADE68E96FA4BFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: hDaFe5Z7AKZpiFM3yADg3jdbiJ8GWfAXrr2bUWtnpvMxRCJLGJpCFFCYajP9YVBLWmENJ7TXO4Ter/gdg88wggfhEorNkP3hNEtiVtN6dcLgppwGcSNPUwhsRRUyFBF3+gO/GkPkOGU5NeEVz0uRRrQo5bTk8pKI7D1eLTrwAvybt4wPNcsqLgxxEvsg1HqdK7zoI7oQL19ml94bp/OYtTCU36WazZGIrlbAAPAZdeSPAzwY4SHO4LIfWRMusxl4WlcKmvRsze+yCz4+ubOjEFtIGa6/+XLO53vKa6Qoc5yu1kRbem1WD30+bPex58U2bCzs//KclwoZLInV3xIS7W/kWHt9QhO93aZIOoPW2ZsPCiCZK28gcbqi9jiZcRqVFkLPgE+Aujprwp2Aly2OryCYFUDsjjn6SshEXi9YLZ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae34608-8803-4d23-2deb-08d59db0d2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:57.4249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liwei Song <liwei.song@windriver.com>

[ Upstream commit 17e83549e199d89aace7788a9f11c108671eecf5 ]

Fix the following kernel bug:

kernel BUG at drivers/iommu/intel-iommu.c:3260!
invalid opcode: 0000 [#5] PREEMPT SMP
Hardware name: Intel Corp. Harcuvar/Server, BIOS HAVLCRB0.X64.0013.D39.1608=
311820 08/31/2016
task: ffff880175389950 ti: ffff880176bec000 task.ti: ffff880176bec000
RIP: 0010:[<ffffffff8150a83b>]  [<ffffffff8150a83b>] intel_unmap+0x25b/0x26=
0
RSP: 0018:ffff880176bef5e8  EFLAGS: 00010296
RAX: 0000000000000024 RBX: ffff8800773c7c88 RCX: 000000000000ce04
RDX: 0000000080000000 RSI: 0000000000000000 RDI: 0000000000000009
RBP: ffff880176bef638 R08: 0000000000000010 R09: 0000000000000004
R10: ffff880175389c78 R11: 0000000000000a4f R12: ffff8800773c7868
R13: 00000000ffffac88 R14: ffff8800773c7818 R15: 0000000000000001
FS:  00007fef21258700(0000) GS:ffff88017b5c0000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066d6d8 CR3: 000000007118c000 CR4: 00000000003406e0
Stack:
 00000000ffffac88 ffffffff8199867f ffff880176bef5f8 ffff880100000030
 ffff880176bef668 ffff8800773c7c88 ffff880178288098 ffff8800772c0010
 ffff8800773c7818 0000000000000001 ffff880176bef648 ffffffff8150a86e
Call Trace:
 [<ffffffff8199867f>] ? printk+0x46/0x48
 [<ffffffff8150a86e>] intel_unmap_page+0xe/0x10
 [<ffffffffa039d99b>] ismt_access+0x27b/0x8fa [i2c_ismt]
 [<ffffffff81554420>] ? __pm_runtime_suspend+0xa0/0xa0
 [<ffffffff815544a0>] ? pm_suspend_timer_fn+0x80/0x80
 [<ffffffff81554420>] ? __pm_runtime_suspend+0xa0/0xa0
 [<ffffffff815544a0>] ? pm_suspend_timer_fn+0x80/0x80
 [<ffffffff8143dfd0>] ? pci_bus_read_dev_vendor_id+0xf0/0xf0
 [<ffffffff8172b36c>] i2c_smbus_xfer+0xec/0x4b0
 [<ffffffff810aa4d5>] ? vprintk_emit+0x345/0x530
 [<ffffffffa038936b>] i2cdev_ioctl_smbus+0x12b/0x240 [i2c_dev]
 [<ffffffff810aa829>] ? vprintk_default+0x29/0x40
 [<ffffffffa0389b33>] i2cdev_ioctl+0x63/0x1ec [i2c_dev]
 [<ffffffff811b04c8>] do_vfs_ioctl+0x328/0x5d0
 [<ffffffff8119d8ec>] ? vfs_write+0x11c/0x190
 [<ffffffff8109d449>] ? rt_up_read+0x19/0x20
 [<ffffffff811b07f1>] SyS_ioctl+0x81/0xa0
 [<ffffffff819a351b>] system_call_fastpath+0x16/0x6e

This happen When run "i2cdetect -y 0" detect SMBus iSMT adapter.

After finished I2C block read/write, when unmap the data buffer,
a wrong device address was pass to dma_unmap_single().

To fix this, give dma_unmap_single() the "dev" parameter, just like
what dma_map_single() does, then unmap can find the right devices.

Fixes: 13f35ac14cd0 ("i2c: Adding support for Intel iSMT SMBus 2.0 host con=
troller")
Signed-off-by: Liwei Song <liwei.song@windriver.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-ismt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 7aea28815d99..b51adffa4841 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -589,7 +589,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 ad=
dr,
=20
 	/* unmap the data buffer */
 	if (dma_size !=3D 0)
-		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
+		dma_unmap_single(dev, dma_addr, dma_size, dma_direction);
=20
 	if (unlikely(!time_left)) {
 		dev_err(dev, "completion wait timed out\n");
--=20
2.15.1
