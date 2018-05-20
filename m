Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeETXLA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:11:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13595 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeETXK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:10:58 -0400
X-IronPort-AV: E=Sophos;i="5.49,423,1520870400";
   d="scan'208";a="175252169"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AIADm3GAgAAAdgCAAANfAIAAASwAgAAHHICAAALJgA==
Date: Sun, 20 May 2018 23:10:54 +0000
Message-ID: <f9fa245d2788081e68d2d6d9337256fd21283897.camel@wdc.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
         <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
         <20180518090636.GA14738@kmo-pixel>
         <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
         <20180520221733.GA11495@kmo-pixel>
         <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
         <20180520223116.GB11495@kmo-pixel>
         <b0aa2a8737b2d826fea58dc0bc113ddce50f018a.camel@wdc.com>
         <20180520230055.GD11495@kmo-pixel>
In-Reply-To: <20180520230055.GD11495@kmo-pixel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [67.180.189.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0766;7:QXL3rFcUMsvVF8wyFG1GAEwVyeQVRWuAz+aAM0cCh/eQkgIFB30BnMN1FfWijmfVb+orqsSMjKH939qx+eKGRXaxa4XwL9jBMkA6+Z9jkgUyqxcaMFLY3UsR/Qnc5Krc/KiL+J8MndXGouSNo7/rcGcypjqhOtmcY5i7ZHCrQOTqD6q/eoeQamV2Emc6pAfmt6hvBe5sRbUHGnENwEuV1KE0RmSvl0y4hqfVsuRKXlqwoI6FtM3NAGt2cvAgTMLR;20:Yqsy/XoxnZnyIHDxO9Q+MiZrp+dIbYLohcGNg51MIk6pLcAB67EawLWm7OkUDEO7uauWlfdx6PQmtkuoQOa2k3KNv8/VwQJ7dZggQNICshLN1wXW3a4982/DOeAaKm7i4jZ2RtC7YoPk9jFB03pQQX6UzdH4IgYzaqsh2cZAWMw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0766;
x-ms-traffictypediagnostic: MWHPR04MB0766:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07667C88D40182D89BC6F36098960@MWHPR04MB0766.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(111885846020525);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0766;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0766;
x-forefront-prvs: 06780E24F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(396003)(39380400002)(366004)(377424004)(199004)(189003)(2501003)(316002)(2900100001)(229853002)(4326008)(39060400002)(6306002)(54906003)(5640700003)(6486002)(14454004)(1361003)(3846002)(53936002)(966005)(72206003)(6116002)(478600001)(66066001)(68736007)(5660300001)(305945005)(93886005)(118296001)(6436002)(86362001)(6246003)(5250100002)(7736002)(186003)(486006)(26005)(106356001)(102836004)(2616005)(476003)(99286004)(6916009)(105586002)(2906002)(81156014)(25786009)(3660700001)(6512007)(6506007)(8676002)(76176011)(81166006)(36756003)(3280700002)(59450400001)(11346002)(446003)(97736004)(8936002)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0766;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: egURi8qxSnqyD8IXvS9O3EU9wcaRaTy3Alam9NgW9qw+ABfRoDa5eXMTxALRJjy2ycX7X9siffxgveHceCGDCE6FwfGCulqoxWsfjimrMybwcOZKnEETdzAKLwtG82iN7gkOka6Y5OlGCQ8oT5xDQxX+ZRpcyY7oxLXiZYb9ucMGuZtjqfIz5wlRTGHMn91w
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C8959F83E50944CAA72E3305A7EE54F@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: da940363-a9bd-4f4e-7f0b-08d5bea6f002
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da940363-a9bd-4f4e-7f0b-08d5bea6f002
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2018 23:10:54.2399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0766
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KNB530019903

On Sun, 2018-05-20 at 19:00 -0400, Kent Overstreet wrote:
> On Sun, May 20, 2018 at 10:35:29PM +0000, Bart Van Assche wrote:
> > On Sun, 2018-05-20 at 18:31 -0400, Kent Overstreet wrote:
> > > On Sun, May 20, 2018 at 10:19:13PM +0000, Bart Van Assche wrote:
> > > > On Sun, 2018-05-20 at 18:17 -0400, Kent Overstreet wrote:
> > > > > On Fri, May 18, 2018 at 03:12:27PM +0000, Bart Van Assche wrote:
> > > > > > On Fri, 2018-05-18 at 05:06 -0400, Kent Overstreet wrote:
> > > > > > > On Thu, May 17, 2018 at 08:54:57PM +0000, Bart Van Assche wrote:
> > > > > > > > With Jens' latest for-next branch I hit the kernel warning shown below. Can
> > > > > > > > you have a look?
> > > > > > > 
> > > > > > > Any hints on how to reproduce it?
> > > > > > 
> > > > > > Sure. This is how I triggered it:
> > > > > > * Clone https://github.com/bvanassche/srp-test.
> > > > > > * Follow the instructions in README.md.
> > > > > > * Run srp-test/run_tests -c -r 10
> > > > > 
> > > > > Can you bisect it? I don't have infiniband hardware handy...
> > > > 
> > > > Hello Kent,
> > > > 
> > > > Have you noticed that the test I described uses the rdma_rxe driver and hence that
> > > > no InfiniBand hardware is needed to run that test?
> > > 
> > > No, I'm not terribly familiar with infiniband stuff....
> > > 
> > > Do you have some sort of self contained test/qemu recipe? I would really rather
> > > not have to figure out how to configure multipath, and infiniband, and I'm not
> > > even sure what else is needed based on that readme...
> > 
> > Please have another look at the srp-test README. The instructions in that document
> > are easy to follow. No multipath nor any InfiniBand knowledge is required. The test
> > even can be run in a virtual machine in case you would be worried about potential
> > impact of the test on the rest of the system.
> 
> Your readme refers to kernel config options that don't even exist in the current
> kernel

That's probably a misunderstanding of your side. From a quick look it seems like all
config symbols mentioned in the srp-test README.md exist in kernel v4.17-rc6. The
following command does not report any non-existing Kconfig symbols:

$ cd linux-kernel
$ sed -n 's/^\* CONFIG_//p' ~/software/infiniband/srp-test/README.md |
  while read f; do { git grep -lw "$f" | grep -q Kconfig; } || echo $f; done

Bart.
