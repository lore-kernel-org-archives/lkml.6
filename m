Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-3751859-1517493946-2-154237079176287894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517493943; b=GqhDVmyswEdHmr2nN5I8463cS7fyATKbJIFVAOOB9Hd7VRl
    qedlGQw/lawEf6lPJzC/QE5MYqYpUqHUrofyGF7bZEBLfA2Yyr7gegGoh4Zqj2TJ
    Vrsax0EgLScF+6fwrl5oOQHqulvmsc3O2vOBguXhx00BYBTdlSeMZF+ckVqeuMM3
    OKMsOWVIGma/DhiU8gMbO6n59+tkJWmxw83AWBS5IKAUydXd2P+J7Ws7y4CqoTEU
    iP3SkoIDkQzOA+V8/BIDvNpQsyd1uW9ChK1uDq7MbfhRlr3ZenVq25RHaX1JLptU
    xqDuSIOMwPxxMhXKHjUs6gHEifQ/9lJFTClTeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1517493943; bh=p4kasTfK
    mSya54500BF1Cir+xHTxJ1s8NURLnh+KvHg=; b=wdWKI+ORmb/uqZ8/Oa8BeTKq
    TAwd3BoLGDBM0nH6PDR70AL7hBcy9VUHpcHCQDEHyOufFXoAjOZ9UTBlhahcPl2t
    Me/wxXIoVkgV896pSfPLfIsD0vsjPiLjwn0macUQ2DTrwiZWGZKMkdaLFyI1PyGE
    aW1ojnwS1ZmRcpme+eKUgF7zpTFVeCquVklHclhANvcT5EeI4rX+oHZT6n3mEmvE
    JkeUOOPWUnsnDQEDiR+jGr+5YbRAVq82TBzrpk19wbQoFU+jih3sVZPQr/0Ta5gL
    sSbohR1Z9ih+wPtUYnoj260mYryTKcRskePqffEMhEUbGAmbUb3lXxvsTR0Uxg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RNhRY+eT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n32mTR3M;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RNhRY+eT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=n32mTR3M;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227uXRWiMODyIj3lg2jNnHyAZLs4StRVyF1epfqOVy7wQAB2jBYx6em7hn28CGsf3lqgzFI/THL3ZrPJCXa3VKk=
MIME-Version: 1.0
In-Reply-To: <CAOuPNLjyjrqLT-sF29v2572bS=RtGsHSbDrGQBzeVBZc=mPoFw@mail.gmail.com>
References: <CAOuPNLiCbsPnkkpyJdBuCL4yCFZvhGBPMW5Xav45y8C838YHUg@mail.gmail.com>
 <20180129231723.524a8c32e1456358f7cb88ce@kernel.org>
 <CAOuPNLhZ4Ly3Ai2yCDOBqPpqgmUXv28KyPX2Kjrnb8fP6PE2kg@mail.gmail.com>
 <20180130144346.86307346478928ca872473b5@kernel.org>
 <CAOuPNLiKJRpQ4CkpXNoE0tWQKKb5doZPsjx6NdAo=M2E_DU11w@mail.gmail.com>
 <20180131123106.e48e89ab21cceee95f88f405@kernel.org>
 <CAOuPNLjyjrqLT-sF29v2572bS=RtGsHSbDrGQBzeVBZc=mPoFw@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Thu, 1 Feb 2018 19:34:24 +0530
Message-ID: <CAOuPNLhZr3aSO3fUU5uZ+XtBDuRods0unHq2ogb46Y7Y5FBJ0Q@mail.gmail.com>
Subject: Re: [perf] perf probe fails sometimes on 4.9
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Wangnan \(F\)" <wangnan0@huawei.com>,
 Alexis Berlemont <alexis.berlemont@gmail.com>, daniel@iogearbox.net,
 kernelnewbies@kernelnewbies.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org, acme@redhat.com, peterz@infradead.org,
 mingo@redhat.com, huawei.libin@huawei.com, naveen.n.rao@linux.vnet.ibm.com,
 quentin.monnet@netronome.com, maddy@linux.vnet.ibm.com, davem@davemloft.net
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

After enabling DEBUG_INFO in kernel I still get this error for BPF test.
Please help.

# perf test BPF -v
.....
Looking at the vmlinux_path (8 entries long)
Using /usr/lib/debug/boot/vmlinux-4.9.00-xxxx-amd-x86-64-00071-gd94c220-dirty
for symbols
Open Debuginfo file:
/usr/lib/debug/boot/vmlinux-4.9.00-xxxx-amd-x86-64-00071-gd94c220-dirty
Try to find probe point from debuginfo.
Matched function: null_lseek [105be32]
Probe point found: null_lseek+0
Searching 'file' variable in context.
Converting variable file into trace event.
converting f_mode in file
file(type:file) has no member f_mode.
An error occurred in debuginfo analysis (-22).
bpf_probe: failed to convert perf probe eventsFailed to add events
selected by BPF
test child finished with -1
---- end ----
Test BPF filter subtest 1: FAILED!



On Thu, Feb 1, 2018 at 10:50 AM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Dear Masami,
>
> Now I am stuck again with 'perf test' failure on 4.9
>
> # perf --version
> perf version 4.9.20-<product name>
>
> # perf test
> 16: Try 'import perf' in python, checking link problems      : FAILED!
> 37.2: Test BPF prologue generation                           : FAILED!
>
> If you have any clue about these failure please hep me.
>
> Here are the verbose output:
> -----------------------------------------------------------------------------
> 1) # perf test python -v
> 16: Try 'import perf' in python, checking link problems      :
> --- start ---
> test child forked, pid 24562
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: No module named perf
> test child finished with -1
> ---- end ----
> Try 'import perf' in python, checking link problems: FAILED!
> ------------------------------------------------------------------------------
>
> 2) # perf test BPF -v
> -------------------------------------------------------------------------------
> .....
> bpf: config 'func=null_lseek file->f_mode offset orig' is ok
> Looking at the vmlinux_path (8 entries long)
> symsrc__init: cannot get elf header.
> Failed to find the path for kernel: Invalid ELF file
> bpf_probe: failed to convert perf probe eventsFailed to add events
> selected by BPF
> test child finished with -1
> ---- end ----
> Test BPF filter subtest 1: FAILED!
>
> -------------------------------------------------------------------------------
>
>
> Thanks,
> Pintu
>
>
> On Wed, Jan 31, 2018 at 9:01 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> On Tue, 30 Jan 2018 19:20:36 +0530
>> Pintu Kumar <pintu.ping@gmail.com> wrote:
>>
>>> On Tue, Jan 30, 2018 at 11:13 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>> >
>>> > On Mon, 29 Jan 2018 22:00:52 +0530
>>> > Pintu Kumar <pintu.ping@gmail.com> wrote:
>>> >
>>> > > Dear Masami,
>>> > >
>>> > > Thank you so much for your reply.
>>> > > Please find some of my answers inline.
>>> > >
>>> > >
>>> > > On Mon, Jan 29, 2018 at 7:47 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>> > > > On Mon, 29 Jan 2018 13:40:34 +0530
>>> > > > Pintu Kumar <pintu.ping@gmail.com> wrote:
>>> > > >
>>> > > >> Hi All,
>>> > > >>
>>> > > >> 'perf probe' is failing sometimes on 4.9.20 with AMD-64.
>>> > > >> # perf probe --add schedule
>>> > > >> schedule is out of .text, skip it.
>>> > > >>   Error: Failed to add events.
>>> > > >>
>>> > > >> If any one have come across this problem please let me know the cause.
>>> > > >
>>> > > > Hi Pintu,
>>> > > >
>>> > > > Could you run it with --vv?
>>> > > >
>>> > > Ok, I will send verbose output by tomorrow.
>>> > >
>>> > > >>
>>> > > >> Note: I don't have CONFIG_DEBUG_INFO enabled in kernel. Is this the problem?
>>> > > >
>>> > > > Without it, you can not probe source-level probe nor trace local variable.
>>> > > >
>>> > >
>>> > > Currently I am facing problem in enabling DEBUG_INFO in our kernel 4.9.20
>>> > > However, I will try to manually include "-g" option during compilation.
>>> > >
>>> > > >> However, I manually copied the vmlinux file to /boot/ directory, but
>>> > > >> still it does not work.
>>> > > >
>>> > > > That doesn't work.
>>> > > > CONFIG_DEBUG_INFO option enables gcc to compile kernel with extra debuginfo.
>>> > > > Without that option, debuginfo is not generated with vmlinux.
>>> > > >
>>> > > >>
>>> > > >> I checked upstream patches until 4.15 but could not find any clue.
>>> > > >> Please let me know if there is any fixes available for this.
>>> > > >
>>> > > > Could you also ensure that you run perf by root user?
>>> > > >
>>> > >
>>> > > Yes I am running with root user.
>>> > >
>>> > > My concern is sometimes it works but sometimes it fails.
>>> >
>>> > What I thought was that your kernel enables kptr_strict(but maybe not.)
>>> > Can you also try to find "schedule" and "_etext" functions in
>>> > /proc/kallsyms?
>>> >
>>>
>>> Yes these functions are present in kallsyms.
>>>
>>> # cat /proc/kallsyms | grep -w schedule ; cat /proc/kallsyms | grep -w _etext
>>> ffffffff829328e0 T schedule
>>> ffffffff8293e751 T _etext
>>>
>>>
>>> > > I still needs to figure out, in which condition it works and which
>>> > > condition it fails.
>>> >
>>> > Yeah, it is important.
>>> >
>>> > > Usually I noticed that in fresh reboot case it works.
>>> >
>>> > So, after a while, it doesn't work again? If so, it sounds like a daemon
>>> > process changes settings in background.
>>> >
>>>
>>> Fortunately or unfortunately, now it is passing every time.
>>> Still not sure about the cause.
>>> If it fails again, I will collect info with -v and report again.
>>> Any specific info that I need to check when it fails ?
>>
>> OK, if you hit it again, please run perf-probe with -vvv option
>> (-v is enough usually, if it is unknown bug, -vvv will be better)
>>
>> Thank you,
>>
>>
>>>
>>> Thank You,
>>> Pintu
>>>
>>>
>>> > Thank you,
>>> >
>>> > >
>>> > >
>>> > > > Thank you,
>>> > > >
>>> > > >
>>> > > >>
>>> > > >>
>>> > > >> Thank You!
>>> > > >> Regards,
>>> > > >> Pintu
>>> > > >>
>>> > > >>
>>> > > >> On Thu, Jan 25, 2018 at 7:09 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>> > > >> > Hi,
>>> > > >> >
>>> > > >> > ** Changed the subject now, since these issues are related to general
>>> > > >> > perf commands.
>>> > > >> >
>>> > > >> > Following are the issues:
>>> > > >> >
>>> > > >> > 1) perf probe --add schedule - FAILED
>>> > > >> > output:
>>> > > >> > schedule is out of .text, skip it.
>>> > > >> >   Error: Failed to add events.
>>> > > >> >
>>> > > >> > what is the issue here?
>>> > > >> > Sometimes it pass and sometimes it fails...
>>> > > >> > Similar is the case of 'perf inject' as well.
>>> > > >> >
>>> > > >> > 2) perf test - 1 FAILURE
>>> > > >> > 37.1: Test basic BPF filtering                               : FAILED!
>>> > > >> > 37.2: Test BPF prologue generation                           : Skip
>>> > > >> > 37.3: Test BPF relocation checker                            : Skip
>>> > > >> >
>>> > > >> > bpf: config program 'func=SyS_epoll_wait'
>>> > > >> > symbol:SyS_epoll_wait file:(null) line:0 offset:0 return:0 lazy:(null)
>>> > > >> > bpf: config 'func=SyS_epoll_wait' is ok
>>> > > >> > Looking at the vmlinux_path (8 entries long)
>>> > > >> > Using /boot/vmlinux for symbols
>>> > > >> > Could not open debuginfo. Try to use symbols.
>>> > > >> > SyS_epoll_wait is out of .text, skip it.
>>> > > >> > bpf_probe: failed to convert perf probe eventsFailed to add events
>>> > > >> > selected by BPF
>>> > > >> > test child finished with -1
>>> > > >> > ---- end ----
>>> > > >> > Test BPF filter subtest 0: FAILED!
>>> > > >> >
>>> > > >> > Looks like both 1,2 are related.
>>> > > >> > Since, CONFIG_DEBUG_INFO is not enabled, I manually copied the vmlinux
>>> > > >> > to /boot/ folder.
>>> > > >> >
>>> > > >> > -------
>>> > > >> > Some more info:
>>> > > >> >
>>> > > >> > Kernel build dir is set to /lib/modules/4.9.20-sc-amd-x86-64/build
>>> > > >> > set env: KBUILD_DIR=/lib/modules/4.9.20-sc-amd-x86-64/build
>>> > > >> > unset env: KBUILD_OPTS
>>> > > >> > include option is set to  -nostdinc -isystem
>>> > > >> > /usr/lib/gcc/x86_64-linux-gnu/5/include -I./arch/x86/include
>>> > > >> > -I./arch/x86/include/generated/uapi -I./arch/x86/include/generated
>>> > > >> > -I./include -I./arch/x86/include/uapi -I./include/uapi
>>> > > >> > -I./include/generated/uapi -include ./include/linux/kconfig.h
>>> > > >> > set env: NR_CPUS=8
>>> > > >> > set env: LINUX_VERSION_CODE=0x40914
>>> > > >> > set env: CLANG_EXEC=/usr/bin/clang
>>> > > >> > set env: CLANG_OPTIONS=-xc
>>> > > >> > set env: KERNEL_INC_OPTIONS= -nostdinc -isystem
>>> > > >> > /usr/lib/gcc/x86_64-linux-gnu/5/include -I./arch/x86/include
>>> > > >> > -I./arch/x86/include/generated/uapi -I./arch/x86/include/generated
>>> > > >> > -I./include -I./arch/x86/include/uapi -I./include/uapi
>>> > > >> > -I./include/generated/uapi -include ./include/linux/kconfig.h
>>> > > >> > set env: WORKING_DIR=/lib/modules/4.9.20-sc-amd-x86-64/build
>>> > > >> >
>>> > > >> >
>>> > > >> > If you have any clue about these failure please help me.
>>> > > >> >
>>> > > >> >
>>> > > >> > Thanks,
>>> > > >> > Pintu
>>> > > >> >
>>> > > >> >
>>> > > >> > On Wed, Jan 24, 2018 at 8:23 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
>>> > > >> >> Hi,
>>> > > >> >>
>>> > > >> >> Thanks for your help.
>>> > > >> >> Yes it was a sub version issue.
>>> > > >> >>
>>> > > >> >> Earlier, while building the kernel I left the SUBLEVEL as blank.
>>> > > >> >>
>>> > > >> >> make -j8 bindeb-pkg SUBLEVEL=20
>>> > > >> >>
>>> > > >> >> After passing the correct sublevel now the test is working.
>>> > > >> >>
>>> > > >> >> But still following are failing:
>>> > > >> >>
>>> > > >> >> 16: Try 'import perf' in python, checking link problems      : FAILED!
>>> > > >> >> 37.2: Test BPF prologue generation                           : FAILED!
>>> > > >> >>
>>> > > >> >>
>>> > > >> >> This is the error I get:
>>> > > >> >>
>>> > > >> >> 16: Try 'import perf' in python, checking link problems      :
>>> > > >> >> --- start ---
>>> > > >> >> test child forked, pid 7637
>>> > > >> >> Traceback (most recent call last):
>>> > > >> >>   File "<stdin>", line 1, in <module>
>>> > > >> >> ImportError: No module named perf
>>> > > >> >> test child finished with -1
>>> > > >> >> ---- end ----
>>> > > >> >> Try 'import perf' in python, checking link problems: FAILED!
>>> > > >> >>
>>> > > >> >>
>>> > > >> >> Looking at the vmlinux_path (8 entries long)
>>> > > >> >> symsrc__init: cannot get elf header.
>>> > > >> >> Failed to find the path for kernel: Invalid ELF file
>>> > > >> >> bpf_probe: failed to convert perf probe eventsFailed to add events
>>> > > >> >> selected by BPF
>>> > > >> >> test child finished with -1
>>> > > >> >> ---- end ----
>>> > > >> >> Test BPF filter subtest 1: FAILED!
>>> > > >> >>
>>> > > >> >>
>>> > > >> >>
>>> > > >> >> Thanks,
>>> > > >> >> Pintu
>>> > > >> >>
>>> > > >> >>
>>> > > >> >> On Wed, Jan 24, 2018 at 6:39 AM, Wangnan (F) <wangnan0@huawei.com> wrote:
>>> > > >> >>>
>>> > > >> >>>
>>> > > >> >>> On 2018/1/23 20:37, Pintu Kumar wrote:
>>> > > >> >>>>
>>> > > >> >>>> Hi All,
>>> > > >> >>>>
>>> > > >> >>>> I am verifying all perf tests on Ubuntu-16 x86-64 platform using the
>>> > > >> >>>> kernel version 4.9.20.
>>> > > >> >>>> I have installed several others packages including: clang, llvm
>>> > > >> >>>>
>>> > > >> >>>> But, when I run 'perf test' I get some FAILURE.
>>> > > >> >>>> Specially, 'perf test LLVM' is failing.
>>> > > >> >>>>
>>> > > >> >>>> Please check the below error logs:
>>> > > >> >>>>
>>> > > >> >>>> ----------------------------------------------------
>>> > > >> >>>> # perf test LLVM
>>> > > >> >>>> 35: Test LLVM searching and compiling                        :
>>> > > >> >>>> 35.1: Basic BPF llvm compiling test                          : FAILED!
>>> > > >> >>>> 35.2: Test kbuild searching                                  : Skip
>>> > > >> >>>> 35.3: Compile source for BPF prologue generation test        : Skip
>>> > > >> >>>> 35.4: Compile source for BPF relocation test                 : Skip
>>> > > >> >>>> ----------------------------------------------------
>>> > > >> >>>>
>>> > > >> >>>> When I run with -v I get this:
>>> > > >> >>>>
>>> > > >> >>>> -----------------------------------------------------
>>> > > >> >>>> # perf test -v LLVM
>>> > > >> >>>> 35: Test LLVM searching and compiling                        :
>>> > > >> >>>> 35.1: Basic BPF llvm compiling test                          :
>>> > > >> >>>> --- start ---
>>> > > >> >>>> test child forked, pid 3304
>>> > > >> >>>> Unablt to get kernel version from uname '4.9-xxxx-amd-x86-64'
>>> > > >> >>>> WARNING:        unable to get correct kernel building directory.
>>> > > >> >>>> Hint:   Set correct kbuild directory using 'kbuild-dir' option in [llvm]
>>> > > >> >>>>          section of ~/.perfconfig or set it to "" to suppress kbuild
>>> > > >> >>>>          detection.
>>> > > >> >>>>
>>> > > >> >>>> Unablt to get kernel version from uname '4.9-xxxx-amd-x86-64'
>>> > > >> >>>>
>>> > > >> >>>>
>>> > > >> >>>> int _version SEC("version") = LINUX_VERSION_CODE;
>>> > > >> >>>> ' | $CLANG_EXEC -D__KERNEL__ -D__NR_CPUS__=$NR_CPUS
>>> > > >> >>>> -DLINUX_VERSION_CODE=$LINUX_VERSION_CODE $CLANG_OPTIONS
>>> > > >> >>>> $KERNEL_INC_OPTIONS -Wno-unused-value -Wno-pointer-sign
>>> > > >> >>>> -working-directory $WORKING_DIR -c "$CLANG_SOURCE" -target bpf -O2 -o
>>> > > >> >>>> -
>>> > > >> >>>> libbpf: 2129190-4a0 doesn't provide kernel version
>>> > > >> >>>> Failed to parse test case 'Basic BPF llvm compiling test'
>>> > > >> >>>> test child finished with -1
>>> > > >> >>>> ---- end ----
>>> > > >> >>>> Test LLVM searching and compiling subtest 0: FAILED!
>>> > > >> >>>> -----------------------------------------------------
>>> > > >> >>>>
>>> > > >> >>>>
>>> > > >> >>>> Basic BPF LLVM compiling test is failing.
>>> > > >> >>>> It reports that bpf could not able to read the kernel version from uname.
>>> > > >> >>>> Is it because of this that 'perf test LLVM' is failing ?
>>> > > >> >>>>
>>> > > >> >>>> My uname says:
>>> > > >> >>>> 4.9-xxxx-amd-x86-64
>>> > > >> >>>
>>> > > >> >>>
>>> > > >> >>> 'perf test LLVM' requires a well formed uname string (%d.%d.%d). Please see
>>> > > >> >>> tools/perf/fetch_kernel_version . If your distro uses another method to
>>> > > >> >>> report
>>> > > >> >>> kernel version number (from your uname string, sublevel can't be
>>> > > >> >>> determined),
>>> > > >> >>> please help us improve that function like what we have done for ubuntu
>>> > > >> >>> (checking /proc/version_signature).
>>> > > >> >>>
>>> > > >> >>>
>>> > > >> >>>
>>> > > >> >>>> My kernel version is: 4.9.20 (from Makefile)
>>> > > >> >>>>
>>> > > >> >>>> So, I dont think there is any problem with kernel version.
>>> > > >> >>>>
>>> > > >> >>>> If any body have come across this problem please let me know how to
>>> > > >> >>>> resolve this issue.
>>> > > >> >>>>
>>> > > >> >>>>
>>> > > >> >>>>
>>> > > >> >>>> Thank You!
>>> > > >> >>>>
>>> > > >> >>>> Regards,
>>> > > >> >>>> Pintu
>>> > > >> >>>
>>> > > >> >>>
>>> > > >> >>>
>>> > > >
>>> > > >
>>> > > > --
>>> > > > Masami Hiramatsu <mhiramat@kernel.org>
>>> >
>>> >
>>> > --
>>> > Masami Hiramatsu <mhiramat@kernel.org>
>>
>>
>> --
>> Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
