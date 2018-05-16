Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbeEPO4u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:56:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:7602 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeEPO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:56:47 -0400
X-IronPort-AV: E=Sophos;i="5.49,406,1520870400";
   d="scan'208";a="78334351"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com"
        <syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "alan.christopher.jenkins@gmail.com"
        <alan.christopher.jenkins@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin@lichtvoll.de" <martin@lichtvoll.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "hare@suse.com" <hare@suse.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: INFO: task hung in blk_queue_enter
Thread-Topic: INFO: task hung in blk_queue_enter
Thread-Index: AQHT3uN1vjf30+PzmEGU/VFOyUa326QwxqcAgAGolwCAAB8sAA==
Date: Wed, 16 May 2018 14:56:42 +0000
Message-ID: <43327033306c3dd2f7c3717d64ce22415b6f3451.camel@wdc.com>
References: <0000000000009b212b056ae6dbad@google.com>
         <343bbbf6-64eb-879e-d19e-96aebb037d47@I-love.SAKURA.ne.jp>
         <b9c33b04-08d7-87a1-3d93-d81a84e6af12@I-love.SAKURA.ne.jp>
In-Reply-To: <b9c33b04-08d7-87a1-3d93-d81a84e6af12@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0607;7:fxoIcmeARQrRdhQ+D1AznCY9EO62oW2QJp3ubfwNCh9AV+aMIaBJOFvSC+IPWoa+NKsC3gu4dwEJ1wVXRf1FdlnqQ10ottmvReEtlHinjxVJo8PIe6vvE/1rEBsjo+MImXAmNcA7q0P335gby5Dd1DegClWJ2c4uco0CBn7zLKx78+t+sZw05O6sSDPmFY/8FPFPs+ijcwlnKHXYFPy1bPEwYVnPHNSB1f1swbLTDOsg6zckVeO2EiRtHcknMiFe;20:ctqsGqNRKmNda8oK+Iz8n6YBjWCmU8/yX0bATFsGjUJh245amix5Ey8jvWKZ3xDmNW/lB1+NvxRvQoLx+b8kPS+cK++aQvQXUs5dOHvNMtih9CSwk/ZkvR/RWLEqWg4NEyk/I0cMdtEZlhI9XNULtQ2ceSmkd2QZD4U9jLYU1yw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0607;
x-ms-traffictypediagnostic: MWHPR04MB0607:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB06078F12BE778DCD742A3BFD98920@MWHPR04MB0607.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0607;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0607;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(39860400002)(396003)(366004)(377424004)(51444003)(199004)(189003)(446003)(66066001)(6506007)(11346002)(105586002)(25786009)(76176011)(59450400001)(102836004)(26005)(186003)(2900100001)(106356001)(99286004)(6116002)(3846002)(8676002)(68736007)(81166006)(8936002)(2201001)(5250100002)(36756003)(2501003)(478600001)(86362001)(7416002)(81156014)(6436002)(4326008)(72206003)(305945005)(6512007)(2906002)(5660300001)(6486002)(486006)(2616005)(476003)(7736002)(97736004)(229853002)(53936002)(39060400002)(118296001)(6246003)(110136005)(3280700002)(54906003)(14454004)(316002)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0607;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zccUOzRrCyyR758OMspND9Atg4pgapaebC17SFqFGMbePhY4/jeVYWudpjDD7kZ1XxYrmBPORmx5G+9ZIcPC6DLYcC/1MGREKIqY7MECaoRkZJoPwOsVqBnOE77GFMovyAKnfmZs/9TDirnMBw9x+zRwl1dfkUh+MW4CfNtkI9t9tGVI15WZSjpPFLHkBrU6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1CA9707F198184EA5F02F5680C69B6C@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8772c867-0e43-4492-c68e-08d5bb3d3ca7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8772c867-0e43-4492-c68e-08d5bb3d3ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 14:56:42.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0607
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GEuwFS012820

On Wed, 2018-05-16 at 22:05 +0900, Tetsuo Handa wrote:
> One ore more threads are waiting for q->mq_freeze_depth to become 0. But the
> thread who incremented q->mq_freeze_depth at blk_freeze_queue_start(q) from
> blk_freeze_queue() is waiting at blk_mq_freeze_queue_wait(). Therefore,
> atomic_read(&q->mq_freeze_depth) == 0 condition for wait_event() in
> blk_queue_enter() will never be satisfied. But what does that wait_event()
> want to do? Isn't "start freezing" a sort of blk_queue_dying(q) == true?
> Since percpu_ref_tryget_live(&q->q_usage_counter) failed and the queue is
> about to be frozen, shouldn't we treat atomic_read(&q->mq_freeze_depth) != 0
> as if blk_queue_dying(q) == true? That is, something like below:
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 85909b4..59e2496 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -951,10 +951,10 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
>  		smp_rmb();
>  
>  		wait_event(q->mq_freeze_wq,
> -			   (atomic_read(&q->mq_freeze_depth) == 0 &&
> -			    (preempt || !blk_queue_preempt_only(q))) ||
> +			   atomic_read(&q->mq_freeze_depth) ||
> +			   (preempt || !blk_queue_preempt_only(q)) ||
>  			   blk_queue_dying(q));
> -		if (blk_queue_dying(q))
> +		if (atomic_read(&q->mq_freeze_depth) || blk_queue_dying(q))
>  			return -ENODEV;
>  	}
>  }

That change looks wrong to me. Additionally, I think that you are looking in
the wrong direction. Since blk_mq_freeze_queue_wait() and blk_queue_enter()
work fine for all block drivers except the loop driver I think that you should
have a closer look at how the loop driver uses this block layer functionality.

Thanks,

Bart.
