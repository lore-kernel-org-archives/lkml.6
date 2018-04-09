Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237414-2-21300567374416069
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
    1523237414; b=vpxeBipZaoSFsLy2baL8XFUX5lXV6c4QzAusmJJ8OX6ABAIA2Z
    xMo+/u7suH4j3Grua0ZJBIJ3l25Yu2vFIKWJU85k2FXxWFpEUsAROur3Qj4pmbWu
    GhC2oL91QYHPkz/r+DaZfDilWqJHl2mFGi1Sqy3z1oV0sAfIFF6irbOgAvNxXEcz
    acSzr9UQAr+akOyj0wPAm0hqlvDpRnp9JWGmdFr3kzQ8BuqGdQ80UYv7/TAm6a4p
    SsrtJofSETiYDnHQjUDo2Bk0bZkiNIcPwKE3ozxg5YG0cVMFKKVZMJurpzQnxmzZ
    6aNWaGXBDekCqJ4OMjafS1VQ5FrFEQ3ol30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237414; bh=qgnP49mPUV
    vMo2By5r2Itxrh5qrhJSdwq+YCOMre6vo=; b=gnSg4Yj8hUDg9zcqYeT4n1O2YP
    WwKUJ2ZlzV5UFC5LFMu1DYN69jkr+74JKDY3ao6HbdI7QadPqAbSKU0G32y8ETyN
    QJGb1afZ7WLK+xsqZshAOl+D0eu+8MAWh6MZ7w2pjJWIEELinwSWExZzcZS0/4bc
    HC3kXzLhG0NYUXoI5Mzg8VA7sPh58jvEfrJheaRJ7dACtOTXAHr6jY1arGgx9pqQ
    flrMNuDryHBK0HMlO+AHVNYcQutB1tsULet/qzSH6VRPPyHItOFA4PIzsoaX2Sbk
    xC/qHA8TR8Jqy1JVZ7GduzMCLCGiSnyvp1agFXoZv5KR3iPAegaxAKuLEuPA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XwrRJuIO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XwrRJuIO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLDz854oNgy120kTRFh/T/BIV54Ud0wz4TGT/mZ9Swzi94kg3dpKB5apoNZsSrrtgp0PsPv31XAmOuCwK4k8PRLLbpqWomlb3CDE0hmEr4tJAMN3RTxu
    JAtgyfCyv1VaYfhCg75vV7nR74L1if2QFHyrZpVzgyvTgJMWgDEehtXt18j0qi00byV1J6IMI1PmMMV/3TVn3RUSroIOlKKa1wUxyjT5Wsmc7wJ/eQwXdwDf
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=G3uK5HJVzsj6bgu_yqAA:9 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbeDIAf6 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:58 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756582AbeDIAfz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Liwei Song <liwei.song@windriver.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 041/162] i2c: ismt: fix wrong device address
 when unmap the data buffer
Thread-Topic: [PATCH AUTOSEL for 4.4 041/162] i2c: ismt: fix wrong device
 address when unmap the data buffer
Thread-Index: AQHTz5mkTOuIwq5x30yCh7mswGMMNQ==
Date: Mon, 9 Apr 2018 00:28:12 +0000
Message-ID: <20180409002738.163941-41-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:s9EhhHoLc1sAlnz4Klw+69RpD+A7Wp4d4iCRPI0gK2gTQg01/W56tt/JuGSIgYaqP9FmNhDoYBNSlTyZf/tsS8Ld37sBmkHnlH+J0Vwbrb8dt7abABM0azJM1ePdmG42aTRByYQgp3uJ30c/RMo68//jcOSIJUq6u9vXWyEsKMNjawdyzK59LkEIXHoB5S7X0PzXg/ZeOZtM7xUmJrA7Vpi3ioQ1/XqMdW1K70FVrLuTcxa7iD434H0YH+HNRyQe;20:YHKNqicSA+Z770DlciuroCxSefjKrDunpdE9sJeuryuMIBGNrdrd65OS8+RDW2vzKW4rPhdOP81kZUdp1qoPxSp9p+Pr2KepYeh3ysk1c1zWU9iqu2cxqUNovHheHxZBg535o2gKbLQfbcJ3YbWxzcrjDJpDSOnNMVMH6mfJCZw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39d22daa-cc72-4325-a71a-08d59db1da02
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07253CECA9B47472762A3212FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: C5R5yxAOm7YqbasWgsi4ppUUzolw9NWnqvTv3vkgwv0lg9fweYsfdiAoXjTZO/09E0D627h5eLeQLAQdGrLUOC6aj+UBefWhh26Y7fV3BQUQF1m61e1Rh/HHzJr9DJ9EKeeJIOtqmSJN6Fm1pxYNU3M1jpY6gN4EvL+onPDmviGaz7Uv9dn9uHkGwdIiNPPyIzN9HVBpQLkTjIZo/hj8Ti1F+iSX7fo1kowZrlljKN/1vBCHBFYnrDMEKy7ueeyzv+wrfs11lRtpWYmCkPJa/iwqKNBBfCFV5HwuypaCyAEiD4ZG97DXp7SaQgHmA90Ml/RjcpbJuTbbBZRjExLGX4KO62MUlUHn5SBjBSox16IR2Ck7og+x8WsNYGSrKwTQFn4CdWc0sZFDGLKkWak2+Z31yZPUvNZZyk82zxktvaI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d22daa-cc72-4325-a71a-08d59db1da02
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:12.6143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 1111cb966a44..fa2b58142cde 100644
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
 	if (unlikely(!time_left)) {
 		dev_err(dev, "completion wait timed out\n");
--=20
2.15.1
