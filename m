Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235491-2-14069759451346367314
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
    1523235491; b=tAIaPZhwJM4H4u9ug3OHy2KAf0OD4Cdapx73hIFhFANUP8tVMO
    zFLWcC8cW+lXko+jxpPa3Yn0wgYWXd4cz+kcqFRp4mo8Hc++p6pViIFG4QyQOShj
    JFGFESE5U2/1zPQSJ3JmEuEyL8yrRQiNHQZTNM3MtNlkLT1ubQjFvGeQMTHeOYvI
    UnQUrljTFxcuh8ffOhiNuxJ7phCaoFM07XcaQSM2+QpPUrZwqZgU3uHe4pVw1+s2
    FRc/Thq+vrdb5fv9kZ1mAk2js94EBRJkq440pPYh7Mqc+9mk/OdcS/9QcMk5NLnX
    9fkbZ6Fn1NRkOLeCV85rlqOXiKKqa+2vC1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235491; bh=LCo5t8PCvR
    oYoz2G3ccUj1tx9mc25bG24n386wp1Xpw=; b=JAF317/wA3FqhAAvjaoCjiAo1A
    WGi7/4ZL1FHriKcouRvnMck6LLXoP/ZVLQcYNWp33fKCiFygd7zpQQnRB+b/StG0
    DHlK+Ex1WeUtyRlBshr21OS9GcLQk1K58FQjkChAeES7bjAld5jH+VT1vcY6TV6J
    Kcfr14cDHrx6nteeVWF6fGjq3I08rAtyjgoVNqHnV0kWVTuQM4/T3LkeEwCRB//d
    ZiN4qabSMefvCJe1dBR19mGHkfrxa7XqwsuFa46ANJK/7uIxb4hWpNoK8ulHNFvQ
    AgseLsbHatOdNZ3IMAYckdaKFj3wwgtH+cP1EFW+DKZ+kGAKEU8n9roNhFig==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IOu51y0+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IOu51y0+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ4B6E+mJ5uP+IlyyDoYcF1QdOXyliL5g5LO6bK2z2jAebro0ZGKmUXilx3LyZ5N16gYgD2pMsi/5UlQNqJV0uSkP4DVtZh8VZ2qSnyqMVsk09FIWYmz
    CqO7vmFB7qYnt03WVL5lBlrvJ6RHsf76qhakZbgRWSnPjK2hPkf+0QRmQf8FNQqKPWPn7C5+fvj9G0ZhT/hVdPM3Ftkf+l2DB0W7g1gzF27V4TAOQcm3n0+G
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=G3uK5HJVzsj6bgu_yqAA:9 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932522AbeDIA5g (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:57:36 -0400
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:41805
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932930AbeDIAkR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liwei Song <liwei.song@windriver.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 033/101] i2c: ismt: fix wrong device address
 when unmap the data buffer
Thread-Topic: [PATCH AUTOSEL for 3.18 033/101] i2c: ismt: fix wrong device
 address when unmap the data buffer
Thread-Index: AQHTz5qwQ5DXss/WU0qRV4NK+mV9hQ==
Date: Mon, 9 Apr 2018 00:35:41 +0000
Message-ID: <20180409003505.164715-33-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:YQVS99YT+rE+If3M12FfKRZ/byjp6nW4FogmvCOcDQovwPUxBSIyw6ugGCfnzVT/DcnT+lINXjTHjnKF70Lm6U1O6yzIT6y07mVHEzcyRCd8hZFToYmXnt8tOSVw1GQNveae8KWcHlaMwNDv4z2ForuH9BAat+bBVhIOfiwxkbR+JBnXpcLj2PUMIZe1huROpqX7J5Of3shBMXbs28qj+VnNB9/vOckZk58NTllIpbErljgQmmi7ZoGqKmIFWcu4;20:M1/cfgnLnFg5tusDyuiclz+wpBM3Drn1kn+/C3jchZUS5JRrOhaaL6C2x42oDn6nt85hqGJdjdSLJiI6Vj/NshUGS0Vk5xT0dVS+t0+2N85JtMF/Rqoz5jyt5Z/7esBiXLtST2ZjOEFeyXk64/H6hkCTrwDiSQOlBOlSvIxAals=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20740fda-64e1-4df7-34a8-08d59db27604
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966ABCA96A7AD2E42A50688FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: a+nQ/oE5UL3ogC5PRySxwk3L/U9H9upxdlz5oUpeUcUqQ5nZ/ej7Szi4Bpp4oaBv+6c2+C8T3zIDm458zHBzh330knROebfpova+QEuO8Dq+7FyC6USpGqr2bfMw6rIeBGHrl83GxD0SIATSrHmNHWv0rVRtpSREi4tYtPuQLePER69ZbGsrcgQ+JATyf86+0geFuCQ8/FX5OA9vu3kJy3od34K9BRzTnHSEClwKEUZqcMNPeQenVq1XjymG/c2bIa60twKH3heghemsZDFN1dP3IKfZCVp8zWNvLhKZ62cnd1iNSIVjG1fD2YckgfqSlSafjJkawfqI4cgNTj/yYmIPWH3XpW/2VYTJv8eEPNKong+e9aDzFW+FLAxwf2XpVeX5bKY+4VeumW+wTBtznMOGTE5Wat2uD8/kuqb3z+Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20740fda-64e1-4df7-34a8-08d59db27604
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:41.7360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
index f771c6afbab5..beab499d182c 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -587,7 +587,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 ad=
dr,
=20
 	/* unmap the data buffer */
 	if (dma_size !=3D 0)
-		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
+		dma_unmap_single(dev, dma_addr, dma_size, dma_direction);
=20
 	if (unlikely(!ret)) {
 		dev_err(dev, "completion wait timed out\n");
--=20
2.15.1
