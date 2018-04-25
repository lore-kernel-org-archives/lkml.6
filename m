Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeDYM0f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:26:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63327 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeDYM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:26:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,326,1520870400";
   d="scan'208";a="77603872"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "pmenzel+linux-block@molgen.mpg.de"
        <pmenzel+linux-block@molgen.mpg.de>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Topic: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Index: AQHT2/Iaokzl6JZ9+0atRxesfkEEnKQQLgAAgAANxACAACwEAIAAA7cAgACLu4CAAHIhAA==
Date: Wed, 25 Apr 2018 12:26:25 +0000
Message-ID: <df8a54d242adb7c26ceef57d6a0e7a51232f911c.camel@wdc.com>
References: <59ca6556-11a6-4f77-76e7-d51c7175eb32@molgen.mpg.de>
         <67ffdf0050a04bf3615c3d8a3a90b0c9c2aeb1ad.camel@wdc.com>
         <2cc5f0fb-4caa-9c28-7daa-68993d5cb41a@molgen.mpg.de>
         <14ff1ed06e36a372680872c227b5abe389c753da.camel@wdc.com>
         <a3a7f906-3681-15cc-67af-b96e4ac71b0e@molgen.mpg.de>
         <134955874b401e6764077393c75ab2d4549b940a.camel@wdc.com>
         <6a2162a7-5f48-c107-0b1c-5258089522c5@molgen.mpg.de>
         <19e19bc6b2fef11faf428fe75447b06e56af9ffd.camel@wdc.com>
         <d5e8823e-27bd-dabe-174f-b111a48b440a@molgen.mpg.de>
In-Reply-To: <d5e8823e-27bd-dabe-174f-b111a48b440a@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [174.23.138.65]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0289;7:DnGLm4vYz26Xqkixe/zAiPkvi2b3FVUjXD7IH5wrpx0Wp4xqbRyqMr0xdyzMZOV/x04U8mDbFtbMmlD0MM1PhpB45FF2VO/Lbcc0LSPMEYdNd/IzdzeOHXvUFYuK8YMKco4MPqXyxsshUvBuKJDo6cW9gB0uEetoDQcD6lXc4aYF9du8kYfC2atzW77v2eFg/Akk+jSvlNHW2L/379v6b3ujAy2PYWEJDKnUaVo9WO3u6B85pc80RdChyYn8CWK2;20:o1exIHPLz+8kl8H1QLaMyNU6DMJ/KA0EeXyFx7ORyKGZnZoguh+Kdtozx5NH52c/eC4L5x9/GNCRwF89LxLUjlCTKXzpHblsL1NUFCECLZ62ynkowjw7866OdhFpsEFWagETe1JQOhM0FGJbENUj9B8srcAOE8Dr4YZRNrQpXD4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0289;
x-ms-traffictypediagnostic: MWHPR04MB0289:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0289A6CD4F79FFD2EE931B33988F0@MWHPR04MB0289.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0289;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0289;
x-forefront-prvs: 06530126A4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(39380400002)(376002)(396003)(377424004)(52314003)(199004)(189003)(105586002)(6116002)(66066001)(106356001)(3846002)(97736004)(3280700002)(229853002)(6436002)(6486002)(118296001)(2906002)(8936002)(8676002)(81166006)(81156014)(7736002)(5250100002)(316002)(3660700001)(59450400001)(2900100001)(53936002)(6512007)(93886005)(99286004)(6246003)(86362001)(476003)(11346002)(2616005)(478600001)(486006)(446003)(186003)(102836004)(26005)(54906003)(68736007)(72206003)(14454004)(305945005)(25786009)(5660300001)(36756003)(4326008)(6506007)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0289;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cLZtMihDUaaqXnwhnJmKhOYcQPsYodmJ3tU7sDewgTv2pmanyhNmThNjCDYEj6G+bezU9amQC7tiMzMh+Vm9yU3OtiLT08k+SvRQGEWbmXd/AyI+PnfD8Hsj9vbsrYoXvv6nyLevFxmVM39FY08ofd8xWHsBRDMyWLPBs5S2Zju/h3ujardlTe7lJsF+4BAd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE91950BECF7584C87337527A29C55C6@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ec1880c6-cb26-4540-cc66-08d5aaa7c36c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1880c6-cb26-4540-cc66-08d5aaa7c36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2018 12:26:25.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0289
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3PCQgLP027748

On Wed, 2018-04-25 at 07:37 +0200, Paul Menzel wrote:
> Am 24.04.2018 um 23:17 schrieb Bart Van Assche:
> > On Tue, 2018-04-24 at 23:04 +0200, Paul Menzel wrote:
> > > I applied your change, and rebuilt the Linux kernel. Unfortunately, it
> > > looks like, it didn’t make a difference.
> > 
> > In that case I don't know what is causing the failure. Can you run a bisect
> > to determine which commit introduced this regression?
> 
> With `scsi_mod.use_blk_mq=n` the system resumes fine, so for to me 
> unknown reasons, that Kconfig option get selected in my Linux kernel 
> configuration. I remember having similar issues when this was enabled by 
> default in Linux 4.13-rc?, so it was just a configuration problem and 
> not a regression. Unfortunately, the Linux configuration files are not 
> under version control, so I cannot check, but it is probably my fault.
> 
> Sorry for the noise, and please tell me, what I can do to get the option 
> working on this old device.

Hello Paul,

Did the same system boot fine with a previous kernel with scsi-mq enabled?
Anyway, we would like to know what is the root cause such that this NULL
pointer dereference can be fixed. There are namely plans to remove the
legacy block layer in the not too distant future.

Thanks,

Bart.
