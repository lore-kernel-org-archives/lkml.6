Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C51ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A112124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 19:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKrLjoXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A112124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGLUEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:04:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40548 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732204AbeGLUEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:04:15 -0400
Received: by mail-oi0-f66.google.com with SMTP id w126-v6so58027920oie.7;
        Thu, 12 Jul 2018 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rFH8P876Vl2E94mklJe34lGBbiVYKqYfk0DpwQ0FUK0=;
        b=JKrLjoXI0tbP+SQX/D9NcBYGdkyqVOxyIomy9yvtcSbVyeNbr+bAG9RLoATno8rkfS
         YV/9+lo6wG9AMjI296zN/uy9z8s3GL/jfczF6YclDcpArgOQ3tqVHs8bHygzVhq+VQDy
         bj8yaDOwwIYVwGhpKiIywyTEwfznCC+vtfeUz96F9Y/PeSrt2jtVu6UZF12j9VO+Nync
         ShYgDa/vORnhaVEHtHED2bBISwpfb6ReJBYtD6Q0zW/8vlv2WixLb0/o9v4KgKs44FoD
         yXkWbAyjJJIIyvy+iwI19qBNpx4P5MpYdNJ4R/Cok7q1YhfUrt7Pr82fbsyZKvz2Whbe
         Kj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rFH8P876Vl2E94mklJe34lGBbiVYKqYfk0DpwQ0FUK0=;
        b=AMMZo0TtgrKrjDv2I8xKD/bXUS/p0MFM2ULcvaEQyrb69ubBqMqIo93ffk+1EI8sqC
         3TzCpocYnNdrBlnpt7XxY7bpmH1vaCBQcOYuREXO0trgj4laLewBtshiNsESIl+N/+PU
         OFNmas4wk485+3gvzYf97KZdonu6nqWfZkSjcFh4u2RRKA8JEYWztYQZu/BplUlLjv69
         gu4XkNRqX9f61ykI8ljCm2J9Vm7C39FRhm+pZEgdTB4kLqfZnL/upMPpkZGmCPnTF4Z6
         yRH+1RncSdTnsVgloYRZP2dF2HBQW/uACWXxSUV7b4jHl4MgbjS3jX+lNGJblVObLUUa
         IiZg==
X-Gm-Message-State: AOUpUlFSx9dpPPYNrq1BOpoe2TUMknCt6NQfWqIGbTOWTiZeWmW/0HwZ
        MqA630bGc06/NY6IvQtl88CkCX7BktOoDJSMlAY=
X-Google-Smtp-Source: AAOMgpcf0DTWbJP4wZXMlpjHY0oG8Pp/hBgvCt3IpuoFgZDSbMeHt8TebBd/HA1g6p4+OTuy4nj6ieuBiLHnEHlZrRM=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr4047569oia.229.1531425192244;
 Thu, 12 Jul 2018 12:53:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5e0c:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 12:53:11
 -0700 (PDT)
In-Reply-To: <20180712145849.GB15265@redhat.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com> <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com> <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com> <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com> <20180712145849.GB15265@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 12 Jul 2018 12:53:11 -0700
Message-ID: <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, open list <linux-kernel@vger.kernel.org>,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess I got to the party late. I found this thread after I started developing
the same feature...

On Thu, Jul 12, 2018 at 7:58 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/11, Ravi Bangoria wrote:
>>
>> > However, I still think it would be better to avoid uprobe exporting and modifying
>> > set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
>> > I'll re-check...
>>
>> Good that you bring this up. Actually, we can implement same logic
>> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
>> in uprobe_write_opcode(). No need to export struct uprobe outside,
>> no need to change set_swbp() / set_orig_insn() syntax. Just that we
>> need to pass arch_uprobe object to uprobe_write_opcode().
>
> Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
> arg to uprobe_write_opcode(). OK, this is fine.
>
>
>> But, I wanted to discuss about making ref_ctr_offset a uprobe property
>> or a consumer property, before posting v6:
>>
>> If we make it a consumer property, the design becomes flexible for
>> user. User will have an option to either depend on kernel to handle
>> reference counter or he can create normal uprobe and manipulate
>> reference counter on his own. This will not require any changes to
>> existing tools. With this approach we need to increment / decrement
>> reference counter for each consumer. But, because of the fact that our
>> install_breakpoint() / remove_breakpoint() are not balanced, we have
>> to keep track of which reference counter have been updated in which
>> mm, for which uprobe and for which consumer. I.e. Maintain a list of
>> {uprobe, consumer, mm}.

Is it possible to maintain balanced refcount by modifying callers of
install_breakpoint() and remove_breakpoint()? I am actually working
toward this direction. And I found some imbalance between
     register_for_each_vma(uprobe, uc)
and
     register_for_each_vma(uprobe, NULL)

From reading the thread, I think there are other sources of imbalance.
But I think it is still possible to fix it? Please let me know if this is not
realistic...


About race conditions, I think both install_breakpoint() and remove_breakpoint()
are called with

   down_write(&mm->mmap_sem);


As long as we do the same when modifying the reference counter,
it should be fine, right?

Wait... sometimes we only down_read(). Is this by design?

Thanks,
Song
