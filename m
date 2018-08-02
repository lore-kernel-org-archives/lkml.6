Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE60C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D92421569
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3MU8KMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D92421569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeHBWMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:12:18 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54656 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeHBWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:12:18 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so5381629itb.4;
        Thu, 02 Aug 2018 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BDzWzYrbN87EU1o3kLHX5huAyjqTOqAkoW4HYAVFBJQ=;
        b=e3MU8KMHVs2xip1GgvkXR/XcChSbdHPvAgTcStOjpymrIDJMF+a9eU+I1n9/fgex2q
         mBilSI13R6hZDtVrE8Gynq+NimlOyz8Ww9Ar4mKjfy8ikcDylqedtuCiGuoL4TiTgpgb
         X80eee5kr9jAAVCcxVgY+H39A/3IJo2H5q1+AOkI2WtH1tZOvY6DDP5EVolWgwmBqdGM
         ErczB3HK35gwwgpBlSiDlu9WWYAXl53aXlCl/dyld56wj3j/iDjEQuKXqnbbfySXfS/7
         wWPV/TBvd/kIOHECE7262tLMNd2j9R+JimnmXigl0r6OHLKOOfSeG7cZqjYsjgQT42oC
         8gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BDzWzYrbN87EU1o3kLHX5huAyjqTOqAkoW4HYAVFBJQ=;
        b=D7Ufh9Fnmc5UVhz8ZtjAyXgO/s9NSt4IKO91Ybd9TjxcAL8LbtVEDFOP9tmFPaJQ7w
         06B/4TDLzxqSR+MMvwqpAyc6d1cKiuSomHCWkkIMERRTnrVu+YaJtGCRQsVMc8law+39
         R1GvmeKs/KoiyyIo+1A/nX02XtriThlP10vS1aYbaVT5ly6Cnpme5EqO8zK6yJbFLM8H
         ob1RN21Y1S0usYj/gyLA/ZRI0RqSucpVMciQNUpYmNOZUDH5hB6qwCXZU9jiBBITfYbe
         6dZVQenQZgMRz38GQU5kT8c5/CzpaX+01GvROfeQjKtMJPH6gEIvIv8ZxKOmoGg1KzjV
         pLSQ==
X-Gm-Message-State: AOUpUlHYSE52oOiK56AKZ3Yv3jDxKOMLRULtXM6BivzusbRvXt7K2yLV
        tGzIdLmNz2Q8ruOi30sHLLm5hcPvgniVcZ5xT+A=
X-Google-Smtp-Source: AAOMgpdzGBYtZMy0hZkmEZqCPRlN5J0DaLxwSoYaCNsyw0OkwpY3BCpq0p5NjtK8liFN7VT41CIt1r7IUHCJ2Xx9e9M=
X-Received: by 2002:a24:54c3:: with SMTP id t186-v6mr4055252ita.55.1533241175178;
 Thu, 02 Aug 2018 13:19:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:bc4a:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 13:19:14 -0700 (PDT)
In-Reply-To: <CAJwJo6bmFZ+2wni1d-t2hh_RqYvnN2c+NJPNyrBLp9H=StTZFg@mail.gmail.com>
References: <20180731005615.GA2911@visor> <CAJwJo6bmFZ+2wni1d-t2hh_RqYvnN2c+NJPNyrBLp9H=StTZFg@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 2 Aug 2018 21:19:14 +0100
Message-ID: <CAJwJo6bzK1cxkA7Cf5cLFUpAexF=Q=9xWQNiF1XP=qH7W1a+Eg@mail.gmail.com>
Subject: Re: [PATCH RESEND] exec: don't force_sigsegv processes with a pending
 fatal signal
To:     Ivan Delalande <colona@arista.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-02 20:53 GMT+01:00 Dmitry Safonov <0x7f454c46@gmail.com>:
> Hi Ivan,
>
> 2018-07-31 1:56 GMT+01:00 Ivan Delalande <colona@arista.com>:
>> We were seeing unexplained segfaults in coreutils processes and other
>> basic utilities that we tracked down to binfmt_elf failing to load
>> segments for ld.so. Digging further, the actual problem seems to occur
>> when a process gets sigkilled while it is still being loaded by the
>> kernel. In our case when _do_page_fault goes for a retry it will return
>> early as it first checks for fatal_signal_pending(), so load_elf_interp
>> also returns with error and as a result search_binary_handler will
>> force_sigsegv() which is pretty confusing as nothing actually failed
>> here.
>>
>> Fixes: 19d860a140be ("handle suicide on late failure exits in execve() in search_binary_handler()")
>> Reference: https://lkml.org/lkml/2013/2/14/5
>> Signed-off-by: Ivan Delalande <colona@arista.com>
>
> +Cc: Oleg Nesterov <oleg@redhat.com>
> +Cc: Andy Lutomirski <luto@kernel.org>

Also worth to add to commit message an example of previously
user-visible message in dmesg:

[ 1545.889604] potentially unexpected fatal signal 11.
[ 1545.889614] CPU: 2 PID: 7462 Comm: grep Tainted: P           O   3.18.28 #1
[ 1545.889617] Hardware name: Celestica D4040/D4040, BIOS 5.6.5 08/18/2016
[ 1545.889621] task: ffff880011282280 ti: ffff880100938000 task.ti:
ffff880100938000
[ 1545.889624] RIP: 0023:[<00000000f760eb70>]  [<00000000f760eb70>] 0xf760eb70
[ 1545.889641] RSP: 002b:00000000fffa3454  EFLAGS: 00000296
[ 1545.889644] RAX: fffffffffffffff2 RBX: 00000000f7a5c3e8 RCX: 00000000f7a5c718
[ 1545.889647] RDX: 00000000f7a5b230 RSI: 00000000f7a5c718 RDI: 00000000f757c000
[ 1545.889650] RBP: 00000000f7a5c3e8 R08: 0000000000000000 R09: 0000000000000000
[ 1545.889653] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1545.889656] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1545.889659] FS:  0000000000000000(0000) GS:ffff88017fb00000(0000)
knlGS:0000000000000000
[ 1545.889662] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
[ 1545.889665] CR2: 00000000f77d7838 CR3: 000000010bb90000 CR4: 00000000001007e0

(which now will be suppressed if there was a fatal signal)

>
>> ---
>>  fs/exec.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index bdd0eacefdf5..6e8007edbb2d 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1656,7 +1656,8 @@ int search_binary_handler(struct linux_binprm *bprm)
>>                 if (retval < 0 && !bprm->mm) {
>>                         /* we got to flush_old_exec() and failed after it */
>>                         read_unlock(&binfmt_lock);
>> -                       force_sigsegv(SIGSEGV, current);
>> +                       if (!fatal_signal_pending(current))
>> +                               force_sigsegv(SIGSEGV, current);
>
> I would suggest to add something like:
> : if (print_fatal_signals)
> :         pr_info("load_binary() failed: %d\n", retval);
>
> It was interesting to catch that it actually segfaults during loading,
> probably will save someone a couple of minutes too ;-)

Not sure if it's easy to trigger, but it might require a ratelimit too..

>
>>                         return retval;
>>                 }
>>                 if (retval != -ENOEXEC || !bprm->file) {

-- 
             Dmitry
