Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620BC2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XhJZnz8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620BC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeIZCqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:46:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39176 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZCqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:46:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id c25-v6so9194234qtp.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ue1uZmXuEY6XUKgX5OB/meOjDtBRr20firpe0FbVqLM=;
        b=XhJZnz8vtR6qSj57/0/SU0gqtTksYhO9g7+rgfNFppMW32iPXfbFp6FTFQ5eF0FIND
         h4QWOBZ+xIjsd1/TKYOrBeF+ntdHLAU2sYRcrHfBMvhOJjoxWR6iyRPKLZvq7AasgtEF
         bOZoGcdKMcABzaQDVBG/dyAppNRHnZBMm7zB0Ms+9ogtsH0kXV/6r+dvuB/XwW3UgOUs
         iNwn9oQ6NJlSIiPQk5k/wG8ThMsuWbNQueQB/DTq8r04O6F2J3TpBHXIGS+JK64ylFDy
         Hu2KK47pUrELIV7+4oiwLfbGrRUp3Y3M/f1Tr3ZoDuwW1mH6pk0PFd++bvujblEtIIUu
         W31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ue1uZmXuEY6XUKgX5OB/meOjDtBRr20firpe0FbVqLM=;
        b=nZ50bhQAb9H5cmB8EoWYSn9xrUv8YVYf+XCFBZTDK7KsfS12Pg166vf3junadqqbLC
         OLG7/8J/RacDcDfiyXOv4d0LgxRyRfEbO5FLg5FS71d9myUqrEYu6hpuA2Y26sEG0ZUM
         exIS7os6A3czOAL7uG3INea5p7P3fn/dId1xGAZGwkIYMzna9cljH950+pS904Im+8S4
         U8lmizdZCGYF44jw9RMrnElUbSeS3UKSp+YrxNp9QVVPK5dH0QL7NEFcfJzkCv+6bRBW
         WVbSPUdEXEUh1+uoDAm5eoST4VodrxXrEFH+stb/ZBw/2uR9OLeplFX3VzqM8C7SrFrP
         GKJw==
X-Gm-Message-State: ABuFfoiA6+mTmwFVV3PIv634ev/wXj/xAnhSP7wtV/ZEIc52SJgKKpJe
        0Dp00T5iPQuunW9gd17i9b4BjBGeOA4Js9FwmmJVwA==
X-Google-Smtp-Source: ACcGV60xYuvpYhVHVbeZ0+P0kDcQ44KH0IZdqUWpiBC+CwsF0DojvipzdkGEI4OyNnh51cTPtgwqz6hZ5hA7folDlEQ=
X-Received: by 2002:ac8:248c:: with SMTP id s12-v6mr2209149qts.116.1537907835227;
 Tue, 25 Sep 2018 13:37:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2abb:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 13:37:14
 -0700 (PDT)
In-Reply-To: <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org> <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 25 Sep 2018 13:37:14 -0700
Message-ID: <CAJWu+ooTi+9Hp6xWpje-zoFOdRpZPLMvTzTDEk8Vf-y4TicvUw@mail.gmail.com>
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 8:33 AM, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
> On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
>>
>> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>>>
>>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>>
>>>>
>>>> +
>>>> +       trace_seq_init(&iter->seq);
>>>> +       iter->ent = fbuffer->entry;
>>>> +       event_call->event.funcs->trace(iter, 0, event);
>>>> +       trace_seq_putc(&iter->seq, 0);
>>>
>>>
>>> Would it be possible to store the binary trace record in the pstore
>>> buffer instead of outputting text? I suspect that will both be faster
>>> and less space.
>>>
>>
>> I will try this and come back.
>>
>
> Hi Joel,
>
> I removed trace_seq_putc and there is some improvement seen: 203 MB/s
>
> # dd if=/dev/zero of=/dev/null status=progress
> 12207371264 bytes (12 GB, 11 GiB) copied, 60 s, 203 MB/s^C
> 24171926+0 records in
> 24171926+0 records out
> 12376026112 bytes (12 GB, 12 GiB) copied, 60.8282 s, 203 MB/s
>
> This seems good when compared to 190 MB/s seen previously.
> If this is Ok, then I will spin v2 with changes suggested.

Sorry for slow reply, yes that sounds good and a worthwhile perf improvement.

thanks,

 - Joel
