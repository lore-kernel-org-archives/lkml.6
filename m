Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeDXS1J (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:27:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31808 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeDXS1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:27:05 -0400
X-IronPort-AV: E=Sophos;i="5.49,324,1520870400";
   d="scan'208";a="77533562"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "pmenzel+linux-block@molgen.mpg.de"
        <pmenzel+linux-block@molgen.mpg.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Topic: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Index: AQHT2/Iaokzl6JZ9+0atRxesfkEEnKQQLgAAgAANxAA=
Date: Tue, 24 Apr 2018 18:27:00 +0000
Message-ID: <134955874b401e6764077393c75ab2d4549b940a.camel@wdc.com>
References: <59ca6556-11a6-4f77-76e7-d51c7175eb32@molgen.mpg.de>
         <67ffdf0050a04bf3615c3d8a3a90b0c9c2aeb1ad.camel@wdc.com>
         <2cc5f0fb-4caa-9c28-7daa-68993d5cb41a@molgen.mpg.de>
         <14ff1ed06e36a372680872c227b5abe389c753da.camel@wdc.com>
         <a3a7f906-3681-15cc-67af-b96e4ac71b0e@molgen.mpg.de>
In-Reply-To: <a3a7f906-3681-15cc-67af-b96e4ac71b0e@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [198.233.165.212]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0912;7:aHeRBYo53CwPpwf/WuTllgOChRSTaG/VaSyxitoMhB3f3FegZeXE8GNuHKED3kFrRrwwK9hRwPyxy04AvVcbk9vzuKgkx6VJKHRDqeYN94RvREM0PUkDbe45Wa2cu5GVM2nsS5e2gwkLrPV2dtTAbV2VDuuIemFYEHJkwjQe6xyjeu2VCfR9GMn0SqLF7PHRAKrWOlzx666kLeH2l0sCdiGz0mf5Z8oc2TZ2bG1XMIN5YulUeg/FIVNjBz99kcMF;20:iw7ZATwhqokGOXC79O0vkftS5H5wgjS55yTIpyH7/NjlJNTxDboaeYHQeRJv9BaNm0nW88jfyGImMphXmw6OqcYeHwIatmZpIlCL6EeacWnf7Axdl/gfAJ6++ZXzb9tLyp1ay+fllZmtEJbeMT/Un636dtbJAJ16Y64XMVVqvN8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0912;
x-ms-traffictypediagnostic: MWHPR04MB0912:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB091211C4CD9A638FE0DBFE4B98880@MWHPR04MB0912.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0912;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0912;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(39860400002)(376002)(366004)(189003)(51444003)(377424004)(199004)(575784001)(446003)(476003)(2616005)(2906002)(478600001)(106356001)(105586002)(305945005)(2900100001)(59450400001)(11346002)(72206003)(86362001)(118296001)(66066001)(486006)(229853002)(5250100002)(54906003)(2501003)(6436002)(316002)(25786009)(6486002)(4326008)(102836004)(76176011)(6246003)(53936002)(5660300001)(93886005)(110136005)(97736004)(7736002)(186003)(14454004)(3846002)(68736007)(6116002)(26005)(6506007)(36756003)(81156014)(53546011)(3660700001)(6512007)(8936002)(3280700002)(8676002)(81166006)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0912;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: duuGK4qKaQw5jcnT1UAeKksxF8PsbwNBF8fkv/CHWDgKHqgvdlGo43f8ydZRDbMkBK6DGTNE3gCzYYnPY9dNle2EWgLX4UtAjmZWwwmHzlBUhla5cbypWln1BDr2diSIvgKwumTo7/8jL9cf1pniJWwWrFKz6n72NVEGTMUFEdsdAmPzAq97yC6CEzKwbwMX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <00C2865DF868434DBD0A303CCF8BD2F6@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4e869bc1-03e8-46b9-4f63-08d5aa10f848
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e869bc1-03e8-46b9-4f63-08d5aa10f848
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 18:27:00.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0912
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3OIRDWf024087

On Tue, 2018-04-24 at 19:37 +0200, Paul Menzel wrote:
> On 04/24/18 19:31, Bart Van Assche wrote:
> Here it is, pasted as citation, as otherwise Thunderbird would wrap the 
> line.
> 
> > (gdb) disas blk_set_runtime_active
> > Dump of assembler code for function blk_set_runtime_active:
> >    0xc1518610 <+0>:	call   0xc106ac9c <__fentry__>
> >    0xc1518615 <+5>:	push   %ebp
> >    0xc1518616 <+6>:	mov    %esp,%ebp
> >    0xc1518618 <+8>:	sub    $0x14,%esp
> >    0xc151861b <+11>:	mov    %ebx,-0xc(%ebp)
> >    0xc151861e <+14>:	mov    %eax,%ebx
> >    0xc1518620 <+16>:	mov    %gs:0x14,%eax
> >    0xc1518626 <+22>:	mov    %eax,-0x10(%ebp)
> >    0xc1518629 <+25>:	xor    %eax,%eax
> >    0xc151862b <+27>:	test   %ebx,%ebx
> >    0xc151862d <+29>:	mov    %esi,-0x8(%ebp)
> >    0xc1518630 <+32>:	mov    %edi,-0x4(%ebp)
> >    0xc1518633 <+35>:	je     0xc15186b3 <blk_set_runtime_active+163>
> >    0xc1518635 <+37>:	mov    0xfc(%ebx),%eax
> >    0xc151863b <+43>:	call   0xc1a4b920 <_raw_spin_lock_irq>
> >    0xc1518640 <+48>:	mov    0x150(%ebx),%esi
> >    0xc1518646 <+54>:	xor    %eax,%eax
> >    0xc1518648 <+56>:	mov    0xc1ca7d20,%edi
> >    0xc151864e <+62>:	mov    %eax,0x154(%ebx)
> >    0xc1518654 <+68>:	cmp    $0xffffff0c,%esi
> >    0xc151865a <+74>:	mov    %edi,-0x14(%ebp)
> >    0xc151865d <+77>:	je     0xc15186a5 <blk_set_runtime_active+149>
> >    0xc151865f <+79>:	mov    %edi,0xf4(%esi)

The e-mail at the start of this e-mail thread shows that %esi == NULL at
the time of the crash and also that the crash occurred at offset 79 (0x4f)
in this function. I think that means that the crash occurred in the following
code: pm_request_autosuspend(q->dev) and also that this means that q->dev ==
NULL. Can you test the (untested) patch below?

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 57cae47ab1c2..b029a94a1e66 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3272,7 +3272,6 @@ static void sd_probe_async(struct work_struct *work)
 		gd->events |= DISK_EVENT_MEDIA_CHANGE;
 	}
 
-	blk_pm_runtime_init(sdp->request_queue, dev);
 	device_add_disk(dev, gd);
 	if (sdkp->capacity)
 		sd_dif_config_host(sdkp);
@@ -3390,6 +3389,8 @@ static int sd_probe(struct device *dev)
 	get_device(dev);
 	dev_set_drvdata(dev, sdkp);
 
+	blk_pm_runtime_init(sdp->request_queue, dev);
+
 	get_device(&sdkp->dev);	/* prevent release before sd_probe_async() */
 	WARN_ON_ONCE(!queue_work(system_unbound_wq, &sdkp->probe_work));
 

Thanks,

Bart.
