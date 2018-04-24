Return-Path: <maier@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZpUD5SmgVJItIoVGhr5Sb6kC4NcGlaJ8HVWqTsYRNR1peqZ79DVGnn1xoWwUM4nDRFJALnw
ARC-Seal: i=1; a=rsa-sha256; t=1524581413; cv=none;
        d=google.com; s=arc-20160816;
        b=bK1au1R1xzMYzwGtDYrghNpFKnOKlvYPUJ8SuDaMwYuwq1RNEYZBJPPoHwZX+hu3sv
         QI07CBO23BrYsdhkm7CvN7ZHNWoK2nwBxpcHWyx4J17ri3rTRfM4Xc7d+2jr84PqEFK6
         X9xxoOdjj+aedF2V7j2CUyXe5Vo3BHVbOebWqQ3jtpMxp97MmkcNDa+E2aav6z/4jY9T
         WesrLHJTPuOzz1mGQPvpgAKYoj8CT7IGpmo5HlXL23poZiM+xfbOTnweRHCiVWZLNy1I
         9R9DrfY3JKJKliBQZi8QOG2HNBfLwkhjUP/d+sUVJZIlQ1QzjIBhuWiHSzWs7zPqLktf
         KYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:references:cc:to:subject:from
         :arc-authentication-results;
        bh=y2e9TFDHdYDeqJnljTD9dGnKu8j3rOuo6sdGkQOD27I=;
        b=kIEG83wTXBYvrO6pOMjweETCn2jOb6oeYsYud9zKvTmno4N5Vz8x4Z5RqeDOJ5mxZG
         1HNdGqf/PGxvQBYwa8mueAQ5Ez4zFBh/3u4z86jcg2skPBZbHTR0GoN86dfwyz7b9F26
         xmXqTt5ugs0TU4mcYNlmekZwIZ1byZu4AuNF6BgVyKG5gFNZQmJqZPnu75DF+UM9V/U7
         913InuMQKKPMt3FDiADeMpilORsXdhMSOFr81Cqh4PXi99ZNntAZA+yJUMmKjj/bycyd
         Yq4uq0eIU25pb8YVjhlLVRwJgTvdkTkETX/90K7uWb1HM7YujWzHcXMeqAmAaAdK8spd
         VIQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maier@linux.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=maier@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Steffen Maier <maier@linux.ibm.com>
Subject: Re: [PATCH 2/2] tracing/events: block: dev_t via driver core for plug
 and unplug events
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "osandov@osandov.com" <osandov@osandov.com>
Cc: "lizefan@huawei.com" <lizefan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20180413130719.22921-1-maier@linux.ibm.com>
 <20180413130719.22921-3-maier@linux.ibm.com>
 <20180415083154.GA12254@kroah.com>
 <59186bf6-abf1-87b0-914d-eed1b40ef4a8@linux.ibm.com>
 <20180419192341.GC20941@vader>
 <8624e2bec853f0bb195966ab54bc42bf15eda0ec.camel@wdc.com>
Date: Tue, 24 Apr 2018 16:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8624e2bec853f0bb195966ab54bc42bf15eda0ec.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 18042414-0040-0000-0000-00000450F0B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042414-0041-0000-0000-000020F5621C
Message-Id: <056d8ee9-5e1d-8219-c24c-9130d6c1dcbf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240142
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636500726736984?=
X-GMAIL-MSGID: =?utf-8?q?1598639479998442900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 04/19/2018 10:56 PM, Bart Van Assche wrote:
> On Thu, 2018-04-19 at 12:24 -0700, Omar Sandoval wrote:
>> We quiesce and freeze the queue before tearing it down, so it won't be=

>> NULL while we're still doing I/O. Cc'ing Bart in case I'm lying to you=
,
>> though ;)
>=20
> blk_cleanup_queue() waits until all I/O requests have finished. Since t=
he
> block layer tracing code is triggered from inside the code that process=
es a
> request it is safe to access the request pointer from inside the tracin=
g code.
> But I think the question was about the parent of the request queue kobj=

> instead of about the request queue pointer, the device structure that i=
s
> embedded in struct gendisk? I think that parent can disappear at any ti=
me.
> Most block drivers call del_gendisk() before they call blk_cleanup_queu=
e().
> Unless I'm overlooking something I think the request queue will need to=

> obtain a reference to the gendisk device from inside blk_register_queue=
()
> and drop that reference from inside blk_cleanup_queue() to make it safe=
for
> the tracing code to access struct gendisk.

Got it, thanks, makes sense.

I did some research, tried the refcount approach, and failed.

Experiment Preparation:
Stopped any udevd and lvm services to avoid additional I/O.
Used the following debug/tracing setup:
modprobe sd_mod
echo -n 'module core +pt; module kobject +pt' > /sys/kernel/debug/dynamic=
_debug/control
trace-cmd start -e block -f "(dev >=3D 0x800000 && dev <=3D 0x80000f) || =
dev =3D=3D 0" -e scsi -p function -l "*_gendisk" -l blk_alloc_queue -l bl=
k_register_queue -l blk_unregister_queue -l blk_cleanup_queue
echo "blk_alloc_queue_node:stacktrace" >> /sys/kernel/debug/tracing/set_f=
trace_filter
echo "scsi_execute:stacktrace" >> /sys/kernel/debug/tracing/set_ftrace_fi=
lter
echo "blk_register_queue:stacktrace" >> /sys/kernel/debug/tracing/set_ftr=
ace_filter
echo "blk_unregister_queue:stacktrace" >> /sys/kernel/debug/tracing/set_f=
trace_filter
echo "blk_cleanup_queue:stacktrace" >> /sys/kernel/debug/tracing/set_ftra=
ce_filter

Experiment:
modprobe scsi_debug num_parts=3D1
sleep 3
echo "HOTUNPLUG" > /sys/kernel/debug/tracing/trace_marker
echo 1 > /sys/class/scsi_device/0:0:0:0/device/delete
echo 0 > /sys/kernel/debug/tracing/tracing_on

Also tried a similar sequence but hotplugged & hotunplugged
a DASD disk (non-SCSI) incl. mq for comparison.

The object life cycle seems to be:

(1) blk_alloc_queue() also creates gendisk kobj
(1a) SCSI does LUN probing I/O
     most of that is blktrace RWBS field value 'N' i.e. non-R/W with dev_=
t=3D=3D0
      since q->kobj.parent is still NULL we cannot get gendisk and thus d=
ev_t
     near the end is the first regular read block I/O with dev_t!=3D0
      as bio!=3DNULL and bi_disk or rq_disk are non-NULL
(2) blk_register_queue() also creates queue kobj with gendisk parent
    now we can follow q->kobj.parent to gendisk to get dev_t,
    e.g. for RWBS 'N' such as implicit SCSI test unit ready on blk dev cl=
ose
(3) optionally "regular" I/O
(4) blk_unregister_queue() called by del_gendisk()
    does kobject_del(&q->kobj) which NULLifies q->kobj.parent again
    the last put of gendisk reference releases gendisk kobj
(5) blk_cleanup_queue()
    the last put of queue (/mq) reference releases queue (/mq) kobj

The patch set would have made dev_t meaningful between and incl. (2) and =
(3)
for (un)plug and even for other block events with RWBS 'N'.
I noticed that I missed one more spot in block_rq_complete [PATCH 3/3],
which explains why I had missed some rq_completions while filtering
block trace events for specific (non-zero) dev_t.
It still wouldn't have been perfect as (1a) events still are dev_t=3D=3D0=

even though the gendisk exists since (1).

I tried the same but increased scsi_debug/delay to a huge value
and made one I/O request pending with "dd" before the hotunplug
to see how flushing would work. For SCSI, at least,
all flushing including a full (and unsuccessful due to eh TUR tmo)
scsi_eh escalation for several minutes happened between
'block' kobj release during (4) and gendisk release during (5),
i.e. before the gendisk was gone but q->kobj.parent was already NULL.
The 'queue' kobj was released last finally.

Since I cannot prove it's always like this, I followed Bart's suggestion
and added another refcount get at (2) blk_register_queue().
However, when I want to put that additional refcount at (5) blk_cleanup_q=
ueue(),
we only get a queue pointer argument as context
and q->kobj.parent=3D=3DNULL since (4),
so I don't know how to get to the gendisk object for the refcount put.
Probably the additional refcount would not help either as (4) has the
unconditional kobject_del(&q->kobj) NULLifying q->kobj.parent anyway...
I guess I came full circle.



Side notes:
The existing code holds a reference on gendisk, but between (2) and (4).

Apparently block trace events can easily observe parts such as (1a)
which are difficult for traditional blktrace to be started via blk dev io=
ctl
(or for ftrace 'blk' tracer which can be enabled between (2) and (4)).



Independently, I started to wonder if there is a refcount leak in the ear=
ly error out if kobject_add() failed:

> int blk_register_queue(struct gendisk *disk)
>         struct device *dev =3D disk_to_dev(disk);
>         struct request_queue *q =3D disk->queue;
>         ret =3D kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "q=
ueue");
>                                     ^^^ref+1
> 	if (ret < 0) {
> 		blk_trace_remove_sysfs(dev);

Above kobject_get already did its side-effect to provide the second argum=
ent when calling kobject_add. Even if kobject_add failed, we still have t=
he refcount on the gendisk but don't put it?

> 		goto unlock;
> 	}

> 	if (q->request_fn || (q->mq_ops && q->elevator)) {
> 		ret =3D elv_register_queue(q);
> 		if (ret) {
> 			mutex_unlock(&q->sysfs_lock);
> 			kobject_uevent(&q->kobj, KOBJ_REMOVE);
> 			kobject_del(&q->kobj);
> 			blk_trace_remove_sysfs(dev);
> 			kobject_put(&dev->kobj);

In contrast, this early return seems to do the pairwise put.

> 			return ret;
> 		}
> 	}

> unlock:
> 	mutex_unlock(&q->sysfs_lock);
> 	return ret;
> }



--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards
Steffen Maier

Linux on z Systems Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
