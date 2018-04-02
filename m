Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbeDBV4r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:56:47 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37604 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeDBV4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:56:45 -0400
X-IronPort-AV: E=Sophos;i="5.48,397,1517846400";
   d="scan'208";a="178122998"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Thread-Topic: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Thread-Index: AQHTyrUNkNkjnUv7yk+FmjLOLTu6JKPt+B6AgAAAm4CAAAzSAA==
Date: Mon, 2 Apr 2018 21:56:41 +0000
Message-ID: <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
         <20180402190120.GD388343@devbig577.frc2.facebook.com>
         <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
         <20180402211047.GF388343@devbig577.frc2.facebook.com>
In-Reply-To: <20180402211047.GF388343@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0734;7:lilsHSw4AGk3D6Z+Az2pH02KY4p9ER7gDxp+tORNRjAPATcJKzh8rpqglYIHqlKNYnxmXdSypFAhHGKdA3nsxY1837gddTr8JIR9T1/mztFDJGe4HJgWppO1sgW8qO8edV3S8U3WXyfSBqQJYlzw8ZebJc02N5aGgI88QNTEkEVjvu/TyVmxNIEX9xTer6tw/R348Kms8wK4LotLJkU+KlYAi1bg2ur5UJAgvjeGYbdJCsf3S4OvdB+GhDyEmTEF;20:mA/UXv/Hkx+sWbl8uM7XKP5GuiYRa4riFFdqcCFEdHBHrtbcujbzKILQvVXoyE00kaAXlc6wEXvbD4CXOkTB4vaneXBGEmFWu9v8AHSHLlbN/q5+ThX6gpbQ68z7Hsh0g0cvbC1h7JMLSj6la74mAzzX3MBeoIpWLj+B1Rxik80=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a4c2ac6-367f-4f33-9a5c-08d598e49e1e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0734;
x-ms-traffictypediagnostic: MWHPR04MB0734:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0734D3D61357D5C6B2C5467398A60@MWHPR04MB0734.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0734;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0734;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(377424004)(4326008)(68736007)(5250100002)(186003)(7736002)(305945005)(6916009)(8936002)(54906003)(106356001)(2501003)(76176011)(486005)(446003)(5660300001)(2616005)(11346002)(6506007)(486005)(53546011)(59450400001)(476003)(97736004)(26005)(105586002)(72206003)(478600001)(86362001)(229853002)(3660700001)(36756003)(6116002)(316002)(99286004)(102836004)(3846002)(6486002)(66066001)(93886005)(1730700003)(81156014)(3280700002)(2900100001)(6246003)(8676002)(25786009)(81166006)(6512007)(2906002)(5640700003)(14454004)(2351001)(6436002)(53936002)(118296001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0734;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8Ocnzt/TE9G/FS10MXoYgBJIIwPHHpSNBS7TepYDAIresIxjPjNdsNL62UOVsghlJNnd0ky+XusAqWbvMoqerxF1+nJs8pkoZt28u7CxlCRuPPmTH6Kt372HXfTmfF5FInZ29jZxHfc/TmfCgJfvyfQhF009kG2xVL6nBtawACYKfSdDPtb+C+9pn165DczUeVAgU0vrMOO2keC/v8RQA/O1SP6FRo6HY9qDp+85C9sVqmb+w97/A+lmDmLLFVjmagECOg56tNhO539rp4OUb+F89AI/HvVMCArTh3qynluenZnt0ZQxLIZxt4WIvFirlFQC1WMPM4TVFv9drmvUNIsLFVs54rNuVFw+Xdf73GqpDtQs4cAMAOB4t3fEr4oRhGACnYDBJLpIxqG6RmF4nHQ5HqUx6fagcRM+wbHjOpE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF87A6CFC3764B42BAE47080A3AA6338@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4c2ac6-367f-4f33-9a5c-08d598e49e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 21:56:41.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0734
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32Lurpq021715

On Mon, 2018-04-02 at 14:10 -0700, Tejun Heo wrote:
> On Mon, Apr 02, 2018 at 02:08:37PM -0700, Bart Van Assche wrote:
> > On 04/02/18 12:01, Tejun Heo wrote:
> > > +	 * As nothing prevents from completion happening while
> > > +	 * ->aborted_gstate is set, this may lead to ignored completions
> > > +	 * and further spurious timeouts.
> > > +	 */
> > > +	if (rq->rq_flags & RQF_MQ_TIMEOUT_RESET)
> > > +		blk_mq_rq_update_aborted_gstate(rq, 0);
> > 
> > Hello Tejun,
> > 
> > Since this patch fixes one race but introduces another race, is this
> > patch really an improvement?
> 
> Oh, that's not a new race.  That's the same non-critical race which
> always existed.  It's just being documented.

This patch increases the time during which .aborted_gstate == .gstate if the
timeout is reset. Does that increase the chance that a completion will be missed
if the request timeout is reset?

Thanks,

Bart.
