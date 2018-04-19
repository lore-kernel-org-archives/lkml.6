Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753054AbeDSOzF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:55:05 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58378 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeDSOzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:55:03 -0400
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
        <20180419142747.GA30274@chelsio.com>
Date: Thu, 19 Apr 2018 09:53:37 -0500
In-Reply-To: <20180419142747.GA30274@chelsio.com> (Rahul Lakkireddy's message
        of "Thu, 19 Apr 2018 19:57:48 +0530")
Message-ID: <87lgdjnt72.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9Axg-0005XB-HN;;;mid=<87lgdjnt72.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/DW1VwMSQg+YqqKiOb2UTWiufyjnffp4s=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3623]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1122 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.8 (0.3%), b_tie_ro: 1.88 (0.2%), parse: 1.53 (0.1%),
        extract_message_metadata: 34 (3.0%), get_uri_detail_list: 7 (0.6%),
        tests_pri_-1000: 16 (1.4%), tests_pri_-950: 2.1 (0.2%), tests_pri_-900: 1.67
        (0.1%), tests_pri_-400: 57 (5.1%), check_bayes: 55 (4.9%), b_tokenize: 22
        (2.0%), b_tok_get_all: 15 (1.4%), b_comp_prob: 7 (0.6%), b_tok_touch_all: 4.6
        (0.4%), b_finish: 2.1 (0.2%), tests_pri_0: 989 (88.1%), check_dkim_signature:
        0.93 (0.1%), check_dkim_adsp: 4.6 (0.4%), tests_pri_500: 12 (1.1%),
        rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH net-next v4 0/3] kernel: add support to collect hardware logs in crash recovery kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Lakkireddy <rahul.lakkireddy@chelsio.com> writes:

> On Thursday, April 04/19/18, 2018 at 07:10:30 +0530, Dave Young wrote:
>> On 04/18/18 at 06:01pm, Rahul Lakkireddy wrote:
>> > On Wednesday, April 04/18/18, 2018 at 11:45:46 +0530, Dave Young wrote:
>> > > Hi Rahul,
>> > > On 04/17/18 at 01:14pm, Rahul Lakkireddy wrote:
>> > > > On production servers running variety of workloads over time, kernel
>> > > > panic can happen sporadically after days or even months. It is
>> > > > important to collect as much debug logs as possible to root cause
>> > > > and fix the problem, that may not be easy to reproduce. Snapshot of
>> > > > underlying hardware/firmware state (like register dump, firmware
>> > > > logs, adapter memory, etc.), at the time of kernel panic will be very
>> > > > helpful while debugging the culprit device driver.
>> > > > 
>> > > > This series of patches add new generic framework that enable device
>> > > > drivers to collect device specific snapshot of the hardware/firmware
>> > > > state of the underlying device in the crash recovery kernel. In crash
>> > > > recovery kernel, the collected logs are added as elf notes to
>> > > > /proc/vmcore, which is copied by user space scripts for post-analysis.
>> > > > 
>> > > > The sequence of actions done by device drivers to append their device
>> > > > specific hardware/firmware logs to /proc/vmcore are as follows:
>> > > > 
>> > > > 1. During probe (before hardware is initialized), device drivers
>> > > > register to the vmcore module (via vmcore_add_device_dump()), with
>> > > > callback function, along with buffer size and log name needed for
>> > > > firmware/hardware log collection.
>> > > 
>> > > I assumed the elf notes info should be prepared while kexec_[file_]load
>> > > phase. But I did not read the old comment, not sure if it has been discussed
>> > > or not.
>> > > 
>> > 
>> > We must not collect dumps in crashing kernel. Adding more things in
>> > crash dump path risks not collecting vmcore at all. Eric had
>> > discussed this in more detail at:
>> > 
>> > https://lkml.org/lkml/2018/3/24/319
>> > 
>> > We are safe to collect dumps in the second kernel. Each device dump
>> > will be exported as an elf note in /proc/vmcore.
>> 
>> I understand that we should avoid adding anything in crash path.  And I also
>> agree to collect device dump in second kernel.  I just assumed device
>> dump use some memory area to store the debug info and the memory
>> is persistent so that this can be done in 2 steps, first register the
>> address in elf header in kexec_load, then collect the dump in 2nd
>> kernel.  But it seems the driver is doing some other logic to collect
>> the info instead of just that simple like I thought. 
>> 
>
> It seems simpler, but I'm concerned with waste of memory area, if
> there are no device dumps being collected in second kernel. In
> approach proposed in these series, we dynamically allocate memory
> for the device dumps from second kernel's available memory.

Don't count that kernel having more than about 128MiB.

For that reason if for no other it would be nice if it was possible to
have the driver to not initialize the device and just stand there
handing out the data a piece at a time as it is read from /proc/vmcore.

The 2GiB number I read earlier concerns me for working in a limited
environment.

It might even make sense to separate this into a completely separate
module (depended upon the main driver if it makes sense to share
the functionality) so that people performing crash dumps would not
hesitate to include the code in their initramfs images.

I can see splitting a device up into a portion only to be used in case
of a crash dump and a normal portion like we do for main memory but I
doubt that makes sense in practice.

>> > > If do this in 2nd kernel a question is driver can be loaded later than vmcore init.
>> > 
>> > Yes, drivers will add their device dumps after vmcore init.
>> > 
>> > > How to guarantee the function works if vmcore reading happens before
>> > > the driver is loaded?
>> > > 
>> > > Also it is possible that kdump initramfs does not contains the driver
>> > > module.
>> > > 
>> > > Am I missing something?
>> > > 
>> > 
>> > Yes, driver must be in initramfs if it wants to collect and add device
>> > dump to /proc/vmcore in second kernel.
>> 
>> In RH/Fedora kdump scripts we only add the things are required to
>> bring up the dump target, so that we can use as less memory as we can.
>> 
>> For example, if a net driver panicked, and the dump target is rootfs
>> which is a scsi disk, then no network related stuff will be added in
>> initramfs.
>> 
>> In this case the device dump info will be not collected..
>
> Correct. If the driver is not present in initramfs, it can't collect
> its underlying device's dump. Administrator is expected to add the 
> driver to initramfs, if device dump needs to be collected.

That makes sense, as most people won't have that need.  Still if we can
find something that can work automatically and safely without the need
for manual configuration people are more likely to use it.

Eric
