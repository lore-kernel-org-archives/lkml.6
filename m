Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeEPPhd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:37:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55636 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbeEPPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:37:31 -0400
X-IronPort-AV: E=Sophos;i="5.49,390,1520870400";
   d="scan'208";a="78338203"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dvyukov@google.com" <dvyukov@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "alan.christopher.jenkins@gmail.com"
        <alan.christopher.jenkins@gmail.com>,
        "syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com"
        <syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com>,
        "penguin-kernel@i-love.sakura.ne.jp"
        <penguin-kernel@i-love.sakura.ne.jp>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "martin@lichtvoll.de" <martin@lichtvoll.de>,
        "hare@suse.com" <hare@suse.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: INFO: task hung in blk_queue_enter
Thread-Topic: INFO: task hung in blk_queue_enter
Thread-Index: AQHT3uN1vjf30+PzmEGU/VFOyUa326QwxqcAgAGolwCAAB8sAIAABZYAgAAFyQA=
Date: Wed, 16 May 2018 15:37:24 +0000
Message-ID: <6db16aa3a7c56b6dcca2d10b4e100a780c740081.camel@wdc.com>
References: <0000000000009b212b056ae6dbad@google.com>
         <343bbbf6-64eb-879e-d19e-96aebb037d47@I-love.SAKURA.ne.jp>
         <b9c33b04-08d7-87a1-3d93-d81a84e6af12@I-love.SAKURA.ne.jp>
         <43327033306c3dd2f7c3717d64ce22415b6f3451.camel@wdc.com>
         <CACT4Y+ZJwvROpBmKWF08fTd2AH=dO-a5+dzCzZua_vVFjiCRBw@mail.gmail.com>
In-Reply-To: <CACT4Y+ZJwvROpBmKWF08fTd2AH=dO-a5+dzCzZua_vVFjiCRBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0927;7:nGqN1YCSlM6WStDZ36WLZxiYtbIfL0bsdcEyjaqoqyhQAGF4IToKNwHea8P/9M5MKyCZiNvGDXAGz4+V7Bph2jl6qQOttPrAy2RjDFwBgLXVoljO0cDEmDioa58+tjSdgqQztaM5kaI3OyQIUwyw2KHrNeHCGLHhp4Kz15UPwfSp3KlN7uSce48vONc1zOBu17WeBuZzLgq0QwzMFpgKw2rTHXw5WGX+Chm+in0LJ4XcrB2uK9L0rZf3y8WvJP6R;20:2EmVy5GIskGL+RaTl9C/ezrluU3zj+0Ow1Ri2ZQgByuVb3cHIfZTAb00QrU2gXY81E6kcz0lvnHsYy/y+3+84gkws5HHojVUCwm0jR/2XJ8QSifzhR1OYAT4+OAPiNOvzI+DYF99qAv8BEmILUgD+0bSyd7Dm13/GG396c0YMHA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0927;
x-ms-traffictypediagnostic: MWHPR04MB0927:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0927E9ABFD42D4EE120D724998920@MWHPR04MB0927.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0927;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0927;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39380400002)(39860400002)(396003)(51444003)(189003)(199004)(377424004)(6436002)(446003)(6246003)(68736007)(6512007)(36756003)(7416002)(305945005)(7736002)(3660700001)(53936002)(97736004)(2351001)(66066001)(4326008)(11346002)(3280700002)(8676002)(2906002)(86362001)(99286004)(26005)(81166006)(14454004)(1730700003)(81156014)(2616005)(8936002)(186003)(118296001)(93886005)(476003)(486006)(6506007)(53546011)(478600001)(2501003)(106356001)(102836004)(54906003)(229853002)(5250100002)(39060400002)(316002)(25786009)(6916009)(59450400001)(5640700003)(76176011)(5660300001)(2900100001)(3846002)(72206003)(6486002)(105586002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0927;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: s1JUgUq23NDjCzVfY30X6JQHO36755Mm71dp0FPSeoJbFTjuetArdGoDRQlFYTJ9Hr2nWtzv1146gGXxGpQ1iYfjqnDJJUISb/iccnmbU0k3SLLATqUzVhS0aueGQwFQhWBdv5IrsOhnr7I65XlpwKVWSXnyc+kr3u1sl+tdNCgs2rl8yAtS+AszdeabAjDZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <75B75C59F0955A40B067930C3A7573DD@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f6692df5-b71b-489f-e365-08d5bb42ec5f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6692df5-b71b-489f-e365-08d5bb42ec5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 15:37:24.8704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0927
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GFbd99013249

On Wed, 2018-05-16 at 17:16 +0200, Dmitry Vyukov wrote:
> On Wed, May 16, 2018 at 4:56 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> > On Wed, 2018-05-16 at 22:05 +0900, Tetsuo Handa wrote:
> > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > index 85909b4..59e2496 100644
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -951,10 +951,10 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
> > >               smp_rmb();
> > > 
> > >               wait_event(q->mq_freeze_wq,
> > > -                        (atomic_read(&q->mq_freeze_depth) == 0 &&
> > > -                         (preempt || !blk_queue_preempt_only(q))) ||
> > > +                        atomic_read(&q->mq_freeze_depth) ||
> > > +                        (preempt || !blk_queue_preempt_only(q)) ||
> > >                          blk_queue_dying(q));
> > > -             if (blk_queue_dying(q))
> > > +             if (atomic_read(&q->mq_freeze_depth) || blk_queue_dying(q))
> > >                       return -ENODEV;
> > >       }
> > >  }
> > 
> > That change looks wrong to me.
> 
> Hi Bart,
> 
> Why does it look wrong to you?

Because that change conflicts with the purpose of queue freezing and also because
that change would inject I/O errors in code paths that shouldn't inject I/O errors.
Please have a look at e.g. generic_make_request(). From the start of that function:

	if (blk_queue_enter(q, flags) < 0) {
		if (!blk_queue_dying(q) && (bio->bi_opf & REQ_NOWAIT))
			bio_wouldblock_error(bio);
		else
			bio_io_error(bio);
		return ret;
	}

The above patch changes the behavior of blk_queue_enter() code from waiting while
q->mq_freeze_depth != 0 into returning -ENODEV while the request queue is frozen.
That will cause generic_make_request() to call bio_io_error(bio) while a request
queue is frozen if REQ_NOWAIT has not been set, which is the default behavior. So
any operation that freezes the queue temporarily, e.g. changing the queue depth,
concurrently with I/O processing can cause I/O to fail with -ENODEV. As you
probably know failure of write requests has very annoying consequences. It e.g.
causes filesystems to go into read-only mode. That's why I think that the above
change is completely wrong.

Bart.
