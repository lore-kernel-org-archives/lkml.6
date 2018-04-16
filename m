Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AIpwx484FpCGIT+iPIOBP+egFNO9ccyjcBzrhVs6a++QMEtTlsHSSGjoN7NCplIX4Ti3m8Jq0y0W
ARC-Seal: i=1; a=rsa-sha256; t=1523896415; cv=none;
        d=google.com; s=arc-20160816;
        b=RoJ53M1/ItLpmpLbXQdUbvKqr2/TW7+eG3KZDfJKArpgLcBSmVKOCaghHKgTikYunf
         mVVASgEd1HzCwXkb11u7M2FwgDyiDS7pgV4NeAhbbJVnYp6qWun+88TLunnaVGAp0dDa
         HpAq6UEXtuc+qYu0Fc0vdrTxMpL1Qui+ucBpkYNSXoqgkJxfxLNkxeeeMIyLqsNEz9jj
         FXErztu7T6j/6l7dg6fqwH7zb66IIiTzyGfqER0VxdH40Tx/EcVPNMmxw+cLGhlXVmd8
         oHqLy6E/EG0XqI4MH8b4ZtyaV193dwgtU83YLd2pN0540yLIsA8tjrCIpZA/WVW+5UQg
         dZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=6+VmqL3OrYwXaShbEIdf8a1uYJu20IbXmLOURacvjME=;
        b=lm32h9UIycgDQafj2e0bayL0raTRdytrRNYTn66KO1dRmnDBRovBvQ3jDnsSAWXORp
         47Je8Q35iLQcmuSiBRtIc1syJgxbLp4YYLs5F7v4naYrunE9KrzeWW42f1n2yIhaRI29
         sLaZcnShA5FCuRLBe7swtag43triTOSwh7cuGcI+lkURWBxCErVSbsa1vFXyVFUIbwaJ
         mk1S/ftMf6juQPjwMk84+0zHJkABRdHEoiQdJWzZ3YElCqt8dwqpypr/4ycj+Xqmb5nZ
         DZk8vry5PU/Kiwy+ecurgk2F0daUO0hYWPXrsmx7TY2EHNoR0a7K1lgBG+ZOCKO0ricA
         WKvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for plug
 and unplug events
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Li Zefan <lizf@cn.fujitsu.com>,
        Li Zefan <lizefan@huawei.com>
References: <20180413130719.22921-1-maier@linux.ibm.com>
 <20180413130719.22921-3-maier@linux.ibm.com>
 <20180415083154.GA12254@kroah.com>
From: Steffen Maier <maier@linux.ibm.com>
Date: Mon, 16 Apr 2018 18:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180415083154.GA12254@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 18041616-0012-0000-0000-000005CB799C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041616-0013-0000-0000-00001947BEDD
Message-Id: <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160149
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636500726736984?=
X-GMAIL-MSGID: =?utf-8?q?1597921207973657254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 04/15/2018 10:31 AM, Greg Kroah-Hartman wrote:
> On Fri, Apr 13, 2018 at 03:07:18PM +0200, Steffen Maier wrote:
>> Complements v2.6.31 commit 55782138e47d ("tracing/events: convert bloc=
k
>> trace points to TRACE_EVENT()") to be equivalent to traditional blktra=
ce
>> output. Also this allows event filtering to not always get all (un)plu=
g
>> events.
>>
>> NB: The NULL pointer check for q->kobj.parent is certainly racy and
>> I don't have enough experience if it's good enough for a trace event.
>> The change did work for my cases (block device read/write I/O on
>> zfcp-attached SCSI disks and dm-mpath on top).
>>
>> While I haven't seen any prior art using driver core (parent) relation=
s
>> for trace events, there are other cases using this when no direct poin=
ter
>> exists between objects, such as:
>>   #define to_scsi_target(d)	container_of(d, struct scsi_target, dev)
>>   static inline struct scsi_target *scsi_target(struct scsi_device *sd=
ev)
>>   {
>> 	return to_scsi_target(sdev->sdev_gendev.parent);
>>   }
>=20
> That is because you "know" the parent of a target device is a
> scsi_target.

true

>> This is the object model we make use of here:
>>
>> struct gendisk {
>>          struct hd_struct {
>>                  struct device {      /*container_of*/
>>                          struct kobject kobj; <--+
>>                          dev_t  devt; /*deref*/  |
>>                  } __dev;                        |
>>          } part0;                                |
>>          struct request_queue *queue; ..+        |
>> }                                      :        |
>>                                         :        |
>> struct request_queue {  <..............+        |
>>          /* queue kobject */                     |
>>          struct kobject {                        |
>>                  struct kobject *parent; --------+
>=20
> Are you sure about this?

I double checked it with crash on a running system chasing pointers and=20
looking at structure debug symbols.
But of course I cannot guarantee it's always been like this and will be.

>>          } kobj;
>> }
>>

>> The difference to blktrace parsed output is that block events don't us=
e the
>> partition's minor number but the containing block device's minor numbe=
r:
>=20
> Why do you want the block device's minor number here?  What is wrong
> with the partition's minor number?  I would think you want that instead=
=2E

No change introduced with my patch. I just describe state of the art=20
since the mentioned=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D55782138e47d.
It (or even its predecessor) used request_queue as trace function=20
argument (plus mostly either request or bio). So that's the currently=20
available context for these events. My change is consistent with that.
But then again, it's not much of a problem as we do have the remap event =

which shows the mapping from partition to blockdev.

blktrace, hooking with callbacks on the block trace events, has its own=20
context information [struct blk_trace] and can get to e.g. the dev_t=20
with its own real pointers without using driver core relations. But I=20
had the impression that's only wired if one uses the blktrace IOCTL or=20
the blk tracer [do_blk_trace_setup()], not for "pure" block events.
> static void blk_add_trace_plug(void *ignore, struct request_queue *q)
> {
> 	struct blk_trace *bt =3D q->blk_trace;
                                ^^^^^^^^^^^^
>=20
> 	if (bt)
> 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, NULL);
> }
>=20
> static void blk_add_trace_unplug(void *ignore, struct request_queue *q,=

> 				    unsigned int depth, bool explicit)
> {
> 	struct blk_trace *bt =3D q->blk_trace;
                                ^^^^^^^^^^^^
>=20
> 	if (bt) {
> 		__be64 rpdu =3D cpu_to_be64(depth);
> 		u32 what;
>=20
> 		if (explicit)
> 			what =3D BLK_TA_UNPLUG_IO;
> 		else
> 			what =3D BLK_TA_UNPLUG_TIMER;
>=20
> 		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, NULL);
> 	}
> }

> struct blk_trace {
> 	int trace_state;
> 	struct rchan *rchan;
> 	unsigned long __percpu *sequence;
> 	unsigned char __percpu *msg_data;
> 	u16 act_mask;
> 	u64 start_lba;
> 	u64 end_lba;
> 	u32 pid;
> 	u32 dev;
             ^^^
> 	struct dentry *dir;
> 	struct dentry *dropped_file;
> 	struct dentry *msg_file;
> 	struct list_head running_list;
> 	atomic_t dropped;
> };



>> $ dd if=3D/dev/sdf1 count=3D1
>>
>> $ cat /sys/kernel/debug/tracing/trace
>> block_bio_remap: 8,80 R 2048 + 32 <- (8,81) 0
>> block_bio_queue: 8,80 R 2048 + 32 [dd]
>> block_getrq: 8,80 R 2048 + 32 [dd]
>> block_plug: 8,80 [dd]
>>              ^^^^
>> block_rq_insert: 8,80 R 16384 () 2048 + 32 [dd]
>> block_unplug: 8,80 [dd] 1 explicit
>>                ^^^^
>> block_rq_issue: 8,80 R 16384 () 2048 + 32 [dd]
>> block_rq_complete: 8,80 R () 2048 + 32 [0]

>> diff --git a/include/trace/events/block.h b/include/trace/events/block=
=2Eh
>> index a13613d27cee..cffedc26e8a3 100644
>> --- a/include/trace/events/block.h
>> +++ b/include/trace/events/block.h
>> @@ -460,14 +460,18 @@ TRACE_EVENT(block_plug,
>>   	TP_ARGS(q),
>>  =20
>>   	TP_STRUCT__entry(
>> +		__field( dev_t,		dev			)
>>   		__array( char,		comm,	TASK_COMM_LEN	)
>>   	),
>>  =20
>>   	TP_fast_assign(
>> +		__entry->dev =3D q->kobj.parent ?
>> +		container_of(q->kobj.parent, struct device, kobj)->devt : 0;
>=20
> That really really really scares me.  It feels very fragile and messing=

> with parent pointers is ripe for things breaking in the future in odd
> and unexplainable ways.
>=20
> And how can the parent be NULL?

I'm hoping for help by block layer experts.

I suppose block device unplug/removal could be a case. But I don't know=20
the details how this works and if object release is protected while I/O=20
is pending and new I/O is rejected beforehand. That might make my=20
approach safe as it would not call the trace functions while the parent=20
pointer changes.

> I don't know the block layer but this feels very wrong to me.  Are you
> sure there isn't some other way to get this info?

No, I'm not sure at all. But I'm no block layer expert either. This is=20
just an idea I had which did work for my cases and I'm looking for=20
confirmation or denial by the experts. So if it's not safe from a block=20
layer point of view either, then I have to ditch it.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
