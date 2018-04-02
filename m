Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754457AbeDBVbl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:31:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40794 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754304AbeDBVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:31:39 -0400
X-IronPort-AV: E=Sophos;i="5.48,397,1517846400";
   d="scan'208";a="75771925"
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
Thread-Index: AQHTyrUNkNkjnUv7yk+FmjLOLTu6JKPt+B6AgAAAm4CAAAXNgA==
Date: Mon, 2 Apr 2018 21:31:34 +0000
Message-ID: <e23487ab30cfe5337a4321ad10ddbd6514be9ab9.camel@wdc.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0206;7:aKkCUPHFz+rPhC3uWc4ykP2ozLAXHvXMz1MLO+h8BbM253bYkCzxIAvctLUkBbJ3NeVDxsLYnCrrVR2/PEh/nVTrNKPFnk0JRxekN35z02Ff6MQmj43P79tYr38Tj4OMg/cG6f1aMl5mBGNyzUwnd403EVdg5XwIsKDdYbaLvkH++7E0HEIe+8oRoVJV4pCgOWchKaHil3yGs0oJnNPuG1u9PQZrrLYcx4tvm04Pc08cquK4UFhOxaaTpZKe/UaC;20:iEUKJcK6HCUkcfg3bjhVJ2YXFANRf9sEC8x4qNsxsE/cGgTfYVlokto0OnZMbI+LV+SCjFO5rVaBU/shQlJYUXz+p43HnsRfQKlgCtDCUHtd7xvSdx4l5zqVmNGzv7xfpYjhAAO95Gcn2Qs9ywi9okuXscQez8wdcNw3KfARX14=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 018f1339-4835-4a9d-8420-08d598e11c29
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0206;
x-ms-traffictypediagnostic: MWHPR04MB0206:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0206CBD312EB4BF157DF26FA98A60@MWHPR04MB0206.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0206;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0206;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39380400002)(39860400002)(377424004)(199004)(189003)(3846002)(316002)(86362001)(106356001)(36756003)(2616005)(5660300001)(81166006)(81156014)(486005)(486005)(54906003)(4326008)(93886005)(8676002)(8936002)(1730700003)(25786009)(476003)(2351001)(6116002)(11346002)(59450400001)(76176011)(446003)(6486002)(2900100001)(53546011)(6506007)(229853002)(26005)(118296001)(2906002)(6512007)(72206003)(3660700001)(186003)(5640700003)(2501003)(305945005)(66066001)(6436002)(6246003)(5250100002)(3280700002)(99286004)(6916009)(68736007)(102836004)(105586002)(14454004)(7736002)(97736004)(53936002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0206;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: INV8DxuvSfsvfyJH/i2kwu//KC0YV7MGAr33gbYIPFkznX9thbz/q/YxHATJqDGHWkFH7nPjUbhXkACuqkUt2RMDKfrnpD0uTAOxLQpFT6L6wE89UcaP0HBIPmYfn0hzzjIJ2RsfJOzpMurmWQtMJmSzgOmWdaFQaDbToZU9YKGEWvWI4/eTPOhcVNsqzRm7lTzHWkt8c1dBf8rTsAn5PJZAoAz7bCo6Q84r49Poe+/SRw8ZIlYyPua6gsU0VBuhWHKcjmGb79Moxg0SvKQUBiptTh2hMeFtgp8Jh7UcGsHYdlB04Zn3xtq3b6Q5KuMUJ4FiGhpz+ZlefseG5K7cWdBeL5fQmr56o5zpPoheLkZBKfJ8XuvFIIHF59k0Ly7+dJ/4nXtDJ+uPhPKr8dfYq9vsjw0zCkZLX82cuNDerPE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CCC02CFBA2FA042BBE6B5EE5B201EA1@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018f1339-4835-4a9d-8420-08d598e11c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 21:31:34.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32LVxqj018298

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

Hello Tejun,

I think it can happen that the above code sees that (rq->rq_flags &
RQF_MQ_TIMEOUT_RESET) != 0, that blk_mq_start_request() executes the
following code:

	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
	blk_add_timer(rq);

and that subsequently blk_mq_rq_update_aborted_gstate(rq, 0) is called,
which will cause the next completion to be lost. Is fixing one occurrence
of a race and reintroducing it in another code path really an improvement?

Thanks,

Bart.
