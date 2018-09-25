Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1601CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D732083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSUsMNGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D732083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbeIZCsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:48:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41595 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:48:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15-v6so8792180qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jdwEDaNGEcKie4P8pUE5aD6mgyefsr8E5wPGeo8cxUw=;
        b=jSUsMNGqgQI2kKUplsWmD7xwc+f2IqGQUeKZH/8dPJm7gw3dm2YkK7jugmxAR6Z6RV
         Ib6RPTzI2xSgayRqY2XvV7h3bpm/HCtzGKd+ls+wuo0xNBDDb79jM7YLAHS0HJIBN2wv
         rTF81x2g2FFYISIjn7tUIff/jbhMh5SucgCzoGIRz26Ho3HAfIDt+iUP6VXpmyv1uUui
         ovmmi1MRFEZ0PKN5bUhv11fEWpnAK2h6W/CNTJpFUDsjvGJKt453uByQeeu3lRdb6adn
         chSl3olw4BJk8ajj5QeNIjZJW6LJSBiWGdAoDKMy8ezgtr0C5VjkXt2o+gidJ4b/51y1
         qNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jdwEDaNGEcKie4P8pUE5aD6mgyefsr8E5wPGeo8cxUw=;
        b=P5LpaAut1RdrofBpKqKL5oalTv+Ndph/9vwkZoB4tH6qLlysN93RPfNzArpsGxbhTO
         jtLDNb+/0ICusOue282wNo73r8snDhSn/uXj6bR8JBprcM6Sc8zBPx0O/Zgy337m4Htf
         Yl1qhC/Nrv4BGOPNcXvSm71n7Xu3sVh3+0zJFOyMVjR4wOTZ+Ctbrz2wR6jADjb62hUU
         fhGANbyHW2EKyRBK3E4UtnLJxaEJpH36dkZxT1iPfet+ptB4fNkTpGl4qBKRQro8dYlc
         fguaeuECUHFvFLLgJl1ZJ2ycUTEh4CoUTLQvtqKbtCWy6K22/jDS4F2S5K6IIYxlpvjq
         Rh/g==
X-Gm-Message-State: ABuFfog4IM8otyZkofn2mjsRP25LKpZW2ZZTv6kjj/6P1e1v8xCekl++
        nEknbZ2psxrm8OD4REUd2dTNs42p/VQfKpFt7LdGoA==
X-Google-Smtp-Source: ACcGV63ksyqVXCqAmdbj7hNA/1VQTZ9li6ytDRc8iQZoIEsGfmwD2tZaBiepTJ4pnK7vkQTNsmfYGAFx/kms+i8vDX0=
X-Received: by 2002:ac8:33da:: with SMTP id d26-v6mr2153868qtb.313.1537907970357;
 Tue, 25 Sep 2018 13:39:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2abb:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 13:39:29
 -0700 (PDT)
In-Reply-To: <CAJWu+ooTi+9Hp6xWpje-zoFOdRpZPLMvTzTDEk8Vf-y4TicvUw@mail.gmail.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org> <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
 <CAJWu+ooTi+9Hp6xWpje-zoFOdRpZPLMvTzTDEk8Vf-y4TicvUw@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 25 Sep 2018 13:39:29 -0700
Message-ID: <CAJWu+oorTRschpgLODgVv50S57U6Su9SM57WVrVKiQBSXEVC9w@mail.gmail.com>
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

On Tue, Sep 25, 2018 at 1:37 PM, Joel Fernandes <joelaf@google.com> wrote:
> On Sun, Sep 23, 2018 at 8:33 AM, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
>>>
>>> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>>>>
>>>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>>>
>>>>>
>>>>> +
>>>>> +       trace_seq_init(&iter->seq);
>>>>> +       iter->ent = fbuffer->entry;
>>>>> +       event_call->event.funcs->trace(iter, 0, event);
>>>>> +       trace_seq_putc(&iter->seq, 0);
>>>>
>>>>
>>>> Would it be possible to store the binary trace record in the pstore
>>>> buffer instead of outputting text? I suspect that will both be faster
>>>> and less space.
>>>>
>>>
>>> I will try this and come back.
>>>
>>
>> Hi Joel,
>>
>> I removed trace_seq_putc and there is some improvement seen: 203 MB/s
>>
>> # dd if=/dev/zero of=/dev/null status=progress
>> 12207371264 bytes (12 GB, 11 GiB) copied, 60 s, 203 MB/s^C
>> 24171926+0 records in
>> 24171926+0 records out
>> 12376026112 bytes (12 GB, 12 GiB) copied, 60.8282 s, 203 MB/s
>>
>> This seems good when compared to 190 MB/s seen previously.
>> If this is Ok, then I will spin v2 with changes suggested.
>
> Sorry for slow reply, yes that sounds good and a worthwhile perf improvement.
>

Well so I think you should still not use spinlock to synchronize and
split the buffer. You could expand pstore_record to have a ts field or
introduce a new API like ->write_percpu instead of write, or
something. But I strongly feel you should lock. For ftrace function
trace, the perf reduction with locking was dramatic.

- Joel
