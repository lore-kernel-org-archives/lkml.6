Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ACEECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E742083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WFYzIfRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E742083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeIZCt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:49:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45686 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbeIZCt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:49:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id l2-v6so14930242qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RDQ3xx80SRyQFwywcrombnQRB2XWBbCFo3YhVjtFhAY=;
        b=WFYzIfRXCpIjdM0nNU/APzW3QxHrvqka2SAgCRv/Fb49iaPar+TZzcp+LI2nDW/BjZ
         mAnkW8kuacoTFaCytqjx1uSqH4b0pi2K2ecRhhxw4Uw1m1ky2DqW0xhhq7PmWvZokFgD
         bT1cXbHHTmKAv0XpiuOZ2C45LQPrmc2Q4mNVHBoXU2OD71q7TkJGV8MSCi5D7Ss3kdq+
         ZRrwWRdjZckbLmX008LNmi8VQi1Y+3wJDq6JHBV56zJXmNQZ/ALkxgg1Eyw89Fb2Ja0g
         isBSQsJXBELFw6Rd0fMQm2JG2TLXu/y3N39rhywqYF2yjiQl9CrIvZ55qd3gJuRl1dSd
         Kckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RDQ3xx80SRyQFwywcrombnQRB2XWBbCFo3YhVjtFhAY=;
        b=l91xyJHJ0jsAlPTnwd2EkJo61a47TOzYkjw266wJbqUqvTDKGLzi5GfEHu+DATq9r2
         gjDmAQlcKWeeFFGb+jn/Ogphrj+e3Vkkwc4REz1LlwqXFaOfFuW7BFDG/M4DKhsff/n9
         QBciPR9jyg1iugzbev5+YU4/gUEmub5j3E4t5NAs9va6Z4/E8KIjEhhaOGxBgWZqgTtp
         FFwXPOVRJ5nl/OxqJGQOGoyaBInYQ7P9++qc2pdgy+2hKq/CiLFoqUNi3p8tsqsR0hVj
         FdjN19+pJqHrL4RZjRzDUnY75Vv5iJ8WtGnrrivzPhcIk1AGf4d8XqJDs9dPKUkcWZKx
         jybA==
X-Gm-Message-State: ABuFfohoXmnyYSK3eK9Qn6C8WvzzHiWn87wmfhEQRqeIIvVkYBmjknhR
        iNXUpW1/50efckdWwwDQTTxnfSSWjp3m+u2p6vJcCg==
X-Google-Smtp-Source: ACcGV63sYsMuZMK7nj4DGxpEXplMsv0FvvZjEDbH1vX/SDon/vRNsi5XCSselWL/nGgHLSVx5ZlEYGG/eiBfmFP9GwM=
X-Received: by 2002:ac8:248c:: with SMTP id s12-v6mr2217259qts.116.1537908004234;
 Tue, 25 Sep 2018 13:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:2abb:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 13:40:03
 -0700 (PDT)
In-Reply-To: <CAJWu+oorTRschpgLODgVv50S57U6Su9SM57WVrVKiQBSXEVC9w@mail.gmail.com>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <CAEXW_YRXQwKvnahv5X1F_Bu_98vMg=w1xpo8PZ+aNT02vBrwwg@mail.gmail.com>
 <e8fdef37-afcd-24b3-1005-e707b73f20b1@codeaurora.org> <eb686156-95d2-2468-21be-13bfd97d5a58@codeaurora.org>
 <CAJWu+ooTi+9Hp6xWpje-zoFOdRpZPLMvTzTDEk8Vf-y4TicvUw@mail.gmail.com> <CAJWu+oorTRschpgLODgVv50S57U6Su9SM57WVrVKiQBSXEVC9w@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 25 Sep 2018 13:40:03 -0700
Message-ID: <CAJWu+orL63-qfDL7B_Fs_Vx_rUr4fwn+DXK1mosmyM4jhj_BSw@mail.gmail.com>
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

On Tue, Sep 25, 2018 at 1:39 PM, Joel Fernandes <joelaf@google.com> wrote:
> On Tue, Sep 25, 2018 at 1:37 PM, Joel Fernandes <joelaf@google.com> wrote:
>> On Sun, Sep 23, 2018 at 8:33 AM, Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>>> On 9/22/2018 10:07 PM, Sai Prakash Ranjan wrote:
>>>>
>>>> On 9/22/2018 2:35 PM, Joel Fernandes wrote:
>>>>>
>>>>> On Sat, Sep 8, 2018 at 4:28 PM Sai Prakash Ranjan
>>>>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>>>>
>>>>>>
>>>>>> +
>>>>>> +       trace_seq_init(&iter->seq);
>>>>>> +       iter->ent = fbuffer->entry;
>>>>>> +       event_call->event.funcs->trace(iter, 0, event);
>>>>>> +       trace_seq_putc(&iter->seq, 0);
>>>>>
>>>>>
>>>>> Would it be possible to store the binary trace record in the pstore
>>>>> buffer instead of outputting text? I suspect that will both be faster
>>>>> and less space.
>>>>>
>>>>
>>>> I will try this and come back.
>>>>
>>>
>>> Hi Joel,
>>>
>>> I removed trace_seq_putc and there is some improvement seen: 203 MB/s
>>>
>>> # dd if=/dev/zero of=/dev/null status=progress
>>> 12207371264 bytes (12 GB, 11 GiB) copied, 60 s, 203 MB/s^C
>>> 24171926+0 records in
>>> 24171926+0 records out
>>> 12376026112 bytes (12 GB, 12 GiB) copied, 60.8282 s, 203 MB/s
>>>
>>> This seems good when compared to 190 MB/s seen previously.
>>> If this is Ok, then I will spin v2 with changes suggested.
>>
>> Sorry for slow reply, yes that sounds good and a worthwhile perf improvement.
>>
>
> Well so I think you should still not use spinlock to synchronize and
> split the buffer. You could expand pstore_record to have a ts field or
> introduce a new API like ->write_percpu instead of write, or
> something. But I strongly feel you should lock. For ftrace function

Aargh, I meant you should *not* lock :-)
