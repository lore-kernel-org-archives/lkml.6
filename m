Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525981159; cv=none;
        d=google.com; s=arc-20160816;
        b=CzLcDpijoBAvLc4PuBMfBorA5yXyTmpkMcAD2PYQujcAdzjspwxqw38MTq/QwDiS1d
         NudyJ1JupgXs8EoqIyXiwTnqPR29xysRQJb1MM2GHV0b0rrsWneb/Xt/RbKtK0TaHBC4
         UMSJ57LbAOyNyso3bsxEWJhMf+/ayDA3X6QVpBY6Y3/XuTP19juezKHeX3ue/yjzRWJe
         OyjZPODHkiCWLAhIA/34GezQx9megWW4zWLOiGxaXHAmZbcMsN7s0EXBqlJWXEc9DdQ8
         KaOetla8zGbciMtxT771svqMjqrOntbBC9+sMukaCdjq4O2CL1droqzC2YVFnRHjXlMr
         I75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=oO6qaI55dEUUM2kIZvKJCHvkN5YxqgjKqtx0MUvbKCU=;
        b=QqgKiJouSyqXuhzKIes58O6BLu82h+e3g1CntUwiRsAOCRBw2ragNme940PHLQ07GY
         OCI3aOFisVLk6GxpDHHY0gAgMHuOcFUxXcjxKjMH76COWTGH9XQ9FPuq1gXkpaHADVvi
         sf9QAz0VAEOGu7CD1hGhAZ1rZL2FCTJHEmMjiFGcBjqLI6Vc7yPie0m7WyCPMjl3f+qm
         +vcKHxqilw0mfC4R3xKUD95TyzUm0Qlu+/DGtMXVl2VNePpS1x8P4x8Za/Oby6jF1kMQ
         Rv+37P9V6yXl/qx7/BETPqL5MyLQV/Otd4KK6P7SJO9LSL3/iK59gIsOpRMQOXAxVICW
         tdZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hEtdyg0i;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hEtdyg0i;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZp2a00an9RrhGV0A9sz+ojjU7bkjy1lE0lhL5RmNRi5LGAuzqspm8hn7zs3NbyOSqop7jXkFoW4J7UPKgitxvA=
MIME-Version: 1.0
In-Reply-To: <20180510084057.GT16141@n2100.armlinux.org.uk>
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com> <20180509152505.GA25559@xps15>
 <87k1scs0f8.fsf@xmission.com> <20180510084057.GT16141@n2100.armlinux.org.uk>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 10 May 2018 13:39:18 -0600
Message-ID: <CANLsYkwaNmZCUjwJXK0X1ia+RnzumfbpB8EvZJ-HDtOHj8rafQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: Export find_task_by_vpid for use in external modules
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Kim Phillips <kim.phillips@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
	Gargi Sharma <gs051095@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923977519130436?=
X-GMAIL-MSGID: =?utf-8?q?1600107220602607555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10 May 2018 at 02:40, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> On Wed, May 09, 2018 at 09:35:07PM -0500, Eric W. Biederman wrote:
>> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>>
>> > On Tue, May 08, 2018 at 11:59:38PM -0500, Eric W. Biederman wrote:
>> >> Kim Phillips <kim.phillips@arm.com> writes:
>> >>
>> >> > This patch is in the context of allowing the Coresight h/w
>> >> > trace driver suite to be loaded as modules.  Coresight uses
>> >> > find_task_by_vpid when running in direct capture mode (via sysfs)
>> >> > when getting/setting the context ID comparator to trigger on
>> >> > (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).
>> >>
>> >> Aside from my objection about how bad an interface a pid in sysfs is.
>> >> The implementation of coresight_vpid_to_pid is horrible.
>> >>
>> >> The code should be just:
>> >>
>> >> static inline pid_t coresight_vpid_to_pid(pid_t vpid)
>> >> {
>> >>    rcu_read_lock();
>> >>         pid = pid_nr(find_vpid(vpid));
>> >>    rcu_read_unlock();
>> >>
>> >>    return pid;
>> >> }
>> >> Which takes find_task_by_vpid out of the picture.
>> >
>> > Many thanks for pointing out the right way to do this.  When Chunyan added
>> > this feature she broadly published her work and find_task_by_vpid() is the
>> > function she was asked to used.
>>
>> Clearly no one was thinking through the implications of a sysfs file
>> which does not have pid namespace support on namespacing.  I am quite
>> upset at this mess of an API.  It is not a maintainable way to do things.
>>
>> >> But reading further I am seeing code writing a pid to hardware.  That is
>> >> broken.  That is a layering violation of the first order.  Giving
>> >> implementation details like that to hardware.
>> >
>> > This is how the feature works - as Robin pointed out tracers are designed to
>> > match pid values with the CPU's contextID register.  The input value has no
>> > other effect than triggering trace collection, which has absolutely no baring on
>> > the CPU.
>>
>> So please tell me how we make the tracer pid namespace aware.  Or is it
>> guaranteed that only the global root user will use this functionality?
>>
>> As you are taking a vpid it looks like users with lesser privileges are
>> able to request this.   From the other reply it appears this is the
>> value the tracer returns to put in logs.  Perhaps I missed it but I
>> didn't see anything that translated from the global pid to something
>> else.  Which would make using this feature in a pid namespace confusing
>> and a problematic information leak if I have understood what has been
>> said so far.
>

Hi Russell,

> Let's look to see what's placed into the context ID register - this is
> done by arch/arm/mm/context.c::contextidr_notifier():
>
>         pid = task_pid_nr(thread->task) << ASID_BITS;
>
> This is documented in linux/sched.h as:
>
>  * task_xid_nr()     : global id, i.e. the id seen from the init namespace;
>
> So, what ends up in the context ID register is the _global_ PID, not a
> namespace specific PID.  This means the hardware deals with global PID
> values.

Correct.

>
> It seems quite logical to use the global PID value for the hardware,
> because that is a globally unique value - especially as the hardware
> uses this for filtering events.  So asking for a namespace's pid 1
> gets mapped to the global pid value, which won't match some other
> namespace's pid 1.
>
> The problem comes _if_ the event stream delivered to userspace contains
> the global PID values and the event stream is being looked at from
> within a namespace.

Correct.

>
> This does not leak information from other namespaces because of the
> uniqueness of the global PID.  However, what it does leak is the value
> of the global PID which is meaningless in the namespace.  So, before
> the event stream is delivered to userspace, this value needs to be
> re-written to the namespace's PID value.

Unfortunately that can't be done.  The trace stream is compressed and
needs to be decompressed using an external library.  I think the only
option is to return an error if a user is trying to use this feature
from a namespace.

>
> Things get more yucky with this when you look at the ctxid_masks stuff
>  - which looks to me like it implements a mask on the PID value.  Masks
> on the pid value are irrelevant from within a namespace, because the
> mask is applied to the global PID value, not the namespace's PID value.
> You can't really define how a set of namespace PIDs will map to global
> PIDs, so masking the context ID PID value in the presence of namespaces
> is pretty useless - and potentially ends up being an information leak.

Also correct.  Since there is no point in trying to use contextID
tracing from a namespace (see above) there is also no point in trying
to apply a mask to the contextIDs.  Once again I think it is best to
return an error when using from a namespace.

Thanks,
Mathieu

>
> As for the sysfs file thing, I think the simple solution to that is
> the sysfs file should accept a PID value in the current namespace,
> and translate that to the global namespace - and the global PID value
> should be stored.  When reading, the global PID value should be
> translated back to the current namespace, or an error/empty given if
> the PID doesn't exist in that namespace.  The current solution to
> store the vpid and simply return it irrespective of the namespace is
> just nonsense.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up
