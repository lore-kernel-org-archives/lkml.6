Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeCHQmC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:42:02 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33786 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbeCHQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:42:01 -0500
X-Google-Smtp-Source: AG47ELvQ3TkqhmzX0jERQvBUu02wjQP6ugvw2+OGuEi6WePxzoIRvpg7I58qrQnlplQwtl4jdafiHsI28JW12xO9gZo=
MIME-Version: 1.0
In-Reply-To: <382abcdd-5264-0c0c-282f-d1f52ecff8e3@linaro.org>
References: <20180305234309.233226-1-dianders@chromium.org> <382abcdd-5264-0c0c-282f-d1f52ecff8e3@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Mar 2018 08:41:59 -0800
X-Google-Sender-Auth: SLORXc4tvcBvG-kReuCATlW0wK0
Message-ID: <CAD=FV=X4_AQFBxWpinDj5F9DUckC02dQ_2QPFQRs34e5_b00bQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/debug: Fix registers on sleeping tasks
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <briannorris@chromium.org>, evgreen@chromium.org,
        swboyd@chromium.org, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 8, 2018 at 8:19 AM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On 05/03/18 23:43, Douglas Anderson wrote:
>>
>> This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
>> registers on sleeping tasks") but for arm64.  Nuff said.
>>
>> ...well, perhaps I could also add that task_pt_regs are userspace
>> registers and that's not what kgdb is supposed to be reporting.  We're
>> supposed to be reporting kernel registers.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
>
> I hacked together a (still very immature) kgdb test suite[1] around the turn
> of the year. Whilst its not quite solid enough for me to recommend others
> deploy it except out of curiosity... so I haven't yet started yelling about
> test suite failures except in the privacy of my own head.
>
> However I can confirm that this patch fixes one of the test suite failures I
> haven't had time to blame allocate yet!
>
> So...
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks for your testing!  ...I'll have to check out your test suite soon.


> BTW is this something that should Cc: stable?

It wouldn't hurt if this made it back to stable on a best-effort
approach.  The problem has been there since the beginning, so it's not
like it's fixing a regression that cropped up in a specific version.
...but it does fix a bug, so probably Cc stable makes sense.  I guess
I'd leave it up to the maintainer that applies the patch?


-Doug<div class="gmail_extra"><br><div class="gmail_quote">On Thu, Mar
8, 2018 at 8:19 AM, Daniel Thompson <span dir="ltr">&lt;<a
href="mailto:daniel.thompson@linaro.org"
target="_blank">daniel.thompson@linaro.org</a>&gt;</span>
wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class="">On
05/03/18 23:43, Douglas Anderson wrote:<br>
<blockquote class="gmail_quote" style="margin:0 0 0
.8ex;border-left:1px #ccc solid;padding-left:1ex">
This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix<br>
registers on sleeping tasks") but for arm64.&nbsp; Nuff said.<br>
<br>
...well, perhaps I could also add that task_pt_regs are userspace<br>
registers and that's not what kgdb is supposed to be reporting.&nbsp; We're<br>
supposed to be reporting kernel registers.<br>
<br>
Signed-off-by: Douglas Anderson &lt;<a
href="mailto:dianders@chromium.org"
target="_blank">dianders@chromium.org</a>&gt;<br>
</blockquote>
<br></span>
I hacked together a (still very immature) kgdb test suite[1] around
the turn of the year. Whilst its not quite solid enough for me to
recommend others deploy it except out of curiosity... so I haven't yet
started yelling about test suite failures except in the privacy of my
own head.<br>
<br>
However I can confirm that this patch fixes one of the test suite
failures I haven't had time to blame allocate yet!<br>
<br>
So...<br>
Tested-by: Daniel Thompson &lt;<a
href="mailto:daniel.thompson@linaro.org"
target="_blank">daniel.thompson@linaro.org</a>&gt;<br>
<br>
BTW is this something that should Cc: stable?<br>
<br>
<br>
Daniel.<br>
<br>
[1] <a href="https://github.com/daniel-thompson/kgdbtest"
rel="noreferrer" target="_blank"
data-saferedirecturl="https://www.google.com/url?hl=en&amp;q=https://github.com/daniel-thompson/kgdbtest&amp;source=gmail&amp;ust=1520613443900000&amp;usg=AFQjCNHzh_tGdP65DdFEQo-ofF_LCI5XBQ">https://github.com/daniel-thom<wbr>pson/kgdbtest</a><div
class="HOEnZb"><div class="h5"><br>
<br>
<br>
<blockquote class="gmail_quote" style="margin:0 0 0
.8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
<br>
Changes in v2:<br>
- Init cpu_context in one line<br>
- Explain that task_pt_regs are userspace<br>
<br>
&nbsp; arch/arm64/kernel/kgdb.c | 21 ++++++++++++++++-----<br>
&nbsp; 1 file changed, 16 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c<br>
index 2122cd187f19..a20de58061a8 100644<br>
--- a/arch/arm64/kernel/kgdb.c<br>
+++ b/arch/arm64/kernel/kgdb.c<br>
@@ -138,14 +138,25 @@ int dbg_set_reg(int regno, void *mem, struct
pt_regs *regs)<br>
&nbsp; void<br>
&nbsp; sleeping_thread_to_gdb_regs(un<wbr>signed long *gdb_regs,
struct task_struct *task)<br>
&nbsp; {<br>
-&nbsp; &nbsp; &nbsp; &nbsp;struct pt_regs *thread_regs;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;struct cpu_context *cpu_context =
&amp;task-&gt;thread.cpu_context;<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* Initialize to zero */<br>
&nbsp; &nbsp; &nbsp; &nbsp; memset((char *)gdb_regs, 0, NUMREGBYTES);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;thread_regs = task_pt_regs(task);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;memcpy((void *)gdb_regs, (void
*)thread_regs-&gt;regs, GP_REG_BYTES);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;/* Special case for PSTATE (check comments
in asm/kgdb.h for details) */<br>
-&nbsp; &nbsp; &nbsp; &nbsp;dbg_get_reg(33, gdb_regs + GP_REG_BYTES,
thread_regs);<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[19] = cpu_context-&gt;x19;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[20] = cpu_context-&gt;x20;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[21] = cpu_context-&gt;x21;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[22] = cpu_context-&gt;x22;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[23] = cpu_context-&gt;x23;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[24] = cpu_context-&gt;x24;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[25] = cpu_context-&gt;x25;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[26] = cpu_context-&gt;x26;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[27] = cpu_context-&gt;x27;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[28] = cpu_context-&gt;x28;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[29] = cpu_context-&gt;fp;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[31] = cpu_context-&gt;sp;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;gdb_regs[32] = cpu_context-&gt;pc;<br>
&nbsp; }<br>
&nbsp; &nbsp; void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)<br>
<br>
</blockquote>
<br>
</div></div></blockquote></div><br></div>
