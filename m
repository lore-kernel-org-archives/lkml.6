Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755039AbeDTNhk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:37:40 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37920 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754879AbeDTNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:37:36 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: Dave Young <dyoung@redhat.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kexec\@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Indranil Choudhury <indranil@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        "stephen\@networkplumber.org" <stephen@networkplumber.org>,
        Ganesh GR <ganeshgr@chelsio.com>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds\@linux-foundation.org" <torvalds@linux-foundation.org>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "viro\@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
        <20180418061546.GA4551@dhcp-128-65.nay.redhat.com>
        <20180418123114.GA19159@chelsio.com>
        <20180419014030.GA2340@dhcp-128-65.nay.redhat.com>
        <20180419142747.GA30274@chelsio.com> <87lgdjnt72.fsf@xmission.com>
        <20180420130632.GA32304@chelsio.com>
Date: Fri, 20 Apr 2018 08:36:09 -0500
In-Reply-To: <20180420130632.GA32304@chelsio.com> (Rahul Lakkireddy's message
        of "Fri, 20 Apr 2018 18:36:34 +0530")
Message-ID: <87po2uhueu.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9WEH-00056t-I5;;;mid=<87po2uhueu.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/F3uoMN0sEfjpxAmjcsDSLiMD3u+eLsWA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4923]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 460 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (0.6%), b_tie_ro: 1.71 (0.4%), parse: 0.87 (0.2%),
        extract_message_metadata: 18 (3.8%), get_uri_detail_list: 4.1 (0.9%),
        tests_pri_-1000: 10 (2.1%), tests_pri_-950: 1.21 (0.3%), tests_pri_-900: 1.01
        (0.2%), tests_pri_-400: 39 (8.5%), check_bayes: 38 (8.3%), b_tokenize: 15
        (3.2%), b_tok_get_all: 13 (2.9%), b_comp_prob: 4.3 (0.9%), b_tok_touch_all:
        3.4 (0.7%), b_finish: 0.74 (0.2%), tests_pri_0: 380 (82.6%),
        check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 2.7 (0.6%),
        tests_pri_500: 5.0 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware logs in crash recovery kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Thursday, April 04/19/18, 2018 at 20:23:37 +0530, Eric W. Biederman wrote:
>> Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:
>> 
>> > On Thursday, April 04/19/18, 2018 at 07:10:30 +0530, Dave Young wrote:
>> >> On 04/18/18 at 06:01pm, Rahul Lakkireddy wrote:
>> >> > On Wednesday, April 04/18/18, 2018 at 11:45:46 +0530, Dave Young wrote:
>> >> > > Hi Rahul,
>> >> > > On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
>> >> > > > On production servers running variety of workloads over time, kernel
>> >> > > > panic can happen sporadically after days or even months. It is
>> >> > > > important to collect as much debug logs as possible to root cause
>> >> > > > and fix the problem, that may not be easy to reproduce. Snapshot of
>> >> > > > underlying hardware/firmware state (like register dump, firmware
>> >> > > > logs, adapter memory, etc.), at the time of kernel panic will be very
>> >> > > > helpful while debugging the culprit device driver.
>> >> > > > 
>> >> > > > This series of patches add new generic framework that enable device
>> >> > > > drivers to collect device specific snapshot of the hardware/firmware
>> >> > > > state of the underlying device in the crash recovery kernel. In crash
>> >> > > > recovery kernel, the collected logs are added as elf notes to
>> >> > > > /proc/vmcore, which is copied by user space scripts for post-analysis.
>> >> > > > 
>> >> > > > The sequence of actions done by device drivers to append their device
>> >> > > > specific hardware/firmware logs to /proc/vmcore are as follows:
>> >> > > > 
>> >> > > > 1. During probe (before hardware is initialized), device drivers
>> >> > > > register to the vmcore module (via vmcore_add_device_dump()), with
>> >> > > > callback function, along with buffer size and log name needed for
>> >> > > > firmware/hardware log collection.
>> >> > > 
>> >> > > I assumed the elf notes info should be prepared while kexec_[file_]load
>> >> > > phase. But I did not read the old comment, not sure if it has been discussed
>> >> > > or not.
>> >> > > 
>> >> > 
>> >> > We must not collect dumps in crashing kernel. Adding more things in
>> >> > crash dump path risks not collecting vmcore at all. Eric had
>> >> > discussed this in more detail at:
>> >> > 
>> >> > https://lkml.org/lkml/2018/3/24/319
>> >> > 
>> >> > We are safe to collect dumps in the second kernel. Each device dump
>> >> > will be exported as an elf note in /proc/vmcore.
>> >> 
>> >> I understand that we should avoid adding anything in crash path.  And I also
>> >> agree to collect device dump in second kernel.  I just assumed device
>> >> dump use some memory area to store the debug info and the memory
>> >> is persistent so that this can be done in 2 steps, first register the
>> >> address in elf header in kexec_load, then collect the dump in 2nd
>> >> kernel.  But it seems the driver is doing some other logic to collect
>> >> the info instead of just that simple like I thought. 
>> >> 
>> >
>> > It seems simpler, but I'm concerned with waste of memory area, if
>> > there are no device dumps being collected in second kernel. In
>> > approach proposed in these series, we dynamically allocate memory
>> > for the device dumps from second kernel's available memory.
>> 
>> Don't count that kernel having more than about 128MiB.
>> 
>
> If large dump is expected, Administrator can increase the memory
> allocated to the second kernel (using crashkernel boot param), to
> ensure device dumps get collected.

Except 128MiB is already a already a huge amount to reserve.  I
typically have run crash dumps with 16MiB of memory and thought it was
overkill.  Looking below 32MiB seems a bit high but it is small enough
that it is still doable.  I am baffled at how 2GiB can be guaranteed to fit
in 32MiB (sparse register space?) but if it works reliably.

>> For that reason if for no other it would be nice if it was possible to
>> have the driver to not initialize the device and just stand there
>> handing out the data a piece at a time as it is read from /proc/vmcore.
>> 
>
> Since cxgb4 is a network driver, it can be used to transfer the dumps
> over the network. So we must ensure the dumps get collected and
> stored, before device gets initialized to transfer dumps over
> the network.

Good point.  For some reason I was thinking it was an infiniband and not
an 10GiB ethernet device.

>> The 2GiB number I read earlier concerns me for working in a limited
>> environment.
>> 
>
> All dumps, including the 2GB on-chip memory dump, is compressed by
> the cxgb4 driver as they are collected. The overall compressed dump
> comes out at max 32 MB.
>
>> It might even make sense to separate this into a completely separate
>> module (depended upon the main driver if it makes sense to share
>> the functionality) so that people performing crash dumps would not
>> hesitate to include the code in their initramfs images.
>> 
>> I can see splitting a device up into a portion only to be used in case
>> of a crash dump and a normal portion like we do for main memory but I
>> doubt that makes sense in practice.
>> 
>
> This is not required, especially in case of network drivers, which
> must collect underlying device dump and initialize the device to
> transfer dumps over the network.

I have a practical concern.  What happens if the previous kernel left
the device in such a bad stat the driver can not successfully initialize
it.

Does failure to initialize cxgb4 after a crash now mean that you can not
capture the crash dump to see the crazy state the device was in?

Typically the initramfs for a crash dump does not include unnecessary
drivers so that hardware in states the drivers can't handle won't
prevent taking a crash dump.

I understand the issue if you are taking a dump over your 10GiB ethernet
it is a moot point.  But if you are writing your dump to disk, or
writing it over a management gigabit ethernet then it is still an issue.

Is there a decoupling so that a totally b0rked device can't prevent
taking it's own dump?

Eric
