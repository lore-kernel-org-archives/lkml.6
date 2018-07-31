Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0878CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C56208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4q93Y6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C56208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeGaLQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:16:09 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34899 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbeGaLQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:16:08 -0400
Received: by mail-io0-f193.google.com with SMTP id w11-v6so12428353iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=85TeqeXnlQijhRhmSXHYFUyoSms6CWO9ewd8YQdrlzk=;
        b=S4q93Y6s7UFrG8UJGPAoolFC8DWugF6wH1JyNoUi9eeit9cQmDLgtks8O9PAlMQg2p
         6/f+qhQwWsPswsdrSs8o2aoGXNiqsvnq25cfLl3S8xqUbiLquzhosMomPbAuEekwexNi
         AKg83W2XGMPJxoe9p4SMEF+z/gkHMaMIVddSeVbuIsVTtuK6TmtToCqcHBI0fBNi3t+g
         Bl7nsUFks1d6argU0VTBhQITd5Y/kMP777YJjenCP/aCja+M9uwUkQm/7X2myLowvJ4Q
         xq6XzmuyoTYKT1kIPAQd4ixBpkJCvdf5UrGPJykJeFpDiPYZcQzkZgbdGMNu/DwTFtcN
         WZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=85TeqeXnlQijhRhmSXHYFUyoSms6CWO9ewd8YQdrlzk=;
        b=KxQbCIBo4GJAE8F0IvN6+tkWKhNq57H3dVnYfDUpFy0X6zDT1o/u8b8v+/mv8I9nkx
         A/nmnpfCC12EcVOpJcOeAh3V3lX3cMqGJMRxo/e/Y/DMa0BiO5RGNtZZ4VKMGY2QPScO
         brLXM6f/njiRq9UstiSSIoMl3NmZrhLnutkezmwNDqwXK0YAb+4ejFxFt9xaZMd5AEat
         biffoeztRzSppqUJkrCKrFHNtrLHfaQSTKT51f3XcDZMmzXRni36sMVAic+ME46PpPgM
         W91/jzDRH21ZbrZBpcDA8T/FU5FNVSZXG9AiKV7GHhMBlqGqCtyR9KrtJM2e3QCeUAco
         wJ5A==
X-Gm-Message-State: AOUpUlEyTMg/OJWQQiK0j42rSrcHoxTqJXHu78HJZrhwkqqZHOWQKMa6
        vnPtCSfrSf5pWM4Llu7sUqlr2xiJmxaYWVxKN6JYqA==
X-Google-Smtp-Source: AAOMgpfTroYsQFwz8fMAs0uHa9xW/My+FCCbZJ9S9FewSOyzTlUOjL/NNKwYqQ956vzIM4xxQG5vd/h0mmUySRvqt5Q=
X-Received: by 2002:a6b:b010:: with SMTP id z16-v6mr16432926ioe.206.1533029799948;
 Tue, 31 Jul 2018 02:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:ba01:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 02:36:39
 -0700 (PDT)
In-Reply-To: <67423232-be56-fd47-06e6-394812c2b918@iogearbox.net>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com> <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
 <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
 <20180730172641.7d516231@cakuba.netronome.com> <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
 <67423232-be56-fd47-06e6-394812c2b918@iogearbox.net>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 31 Jul 2018 02:36:39 -0700
Message-ID: <CAKOZueu5VdzCEkEv_nR4D0CtYi5r9XOdKOfpKvYWDGPnQGqMHQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2) command
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 1:34 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 07/31/2018 02:33 AM, Daniel Colascione wrote:
>> On Mon, Jul 30, 2018 at 5:26 PM, Jakub Kicinski
>> <jakub.kicinski@netronome.com> wrote:
>>> On Mon, 30 Jul 2018 03:25:43 -0700, Daniel Colascione wrote:
>>>> On Mon, Jul 30, 2018 at 3:04 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>> Hmm, I don't think such UAPI as above is future-proof. In case we would want
>>>>> a similar mechanism in future for other maps, we would need a whole new bpf
>>>>> command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
>>>>> the underlying map may not even be a map-to-map. Additionally, we don't have
>>>>> any map object at hand in the above, so we couldn't make any finer grained
>>>>> decisions either. Something like below would be more suitable and leaves room
>>>>> for extending this further in future.
>>>>
>>>> YAGNI.  Your proposed mechanism doesn't add anything under the current
>>>> implementation.
>>>
>>> FWIW in case of HW offload targeting a particular map may allow users
>>> to avoid a potentially slow sync with all the devices on the system.
>>
>> Sure. But such a thing doesn't exist right now (right?), and we can
>> add that more-efficient-in-that-one-case BPF interface when it lands.
>> I'd rather keep things simple for now.
>
> I don't see a reason why that is even more complicated.

Both the API and the implementation are much more complicated in the
per-map ops version: just look at the patch size. The size argument
isn't necessarily a dealbreaker, but I still don't see what the extra
code size and complexity is buying.

> An API command name
> such as BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is simply non-generic, and
> exposes specific map details (here: map-in-map) into the UAPI whereas it
> should reside within a specific implementation instead similar to other ops
> we have for maps.

But synchronize isn't conceptually a command that applies to a
specific map. It waits on all references. Did you address my point
about your proposed map-specific interface requiring redundant
synchronize_rcu calls in the case where we swap multiple maps and want
to wait for all the references to drain? Under my proposal, you'd just
BPF_SYNCHRONIZE_WHATEVER and call schedule_rcu once. Under your
proposal, we'd make it a per-map operation, so we'd issue one
synchronize_rcu per map.

> If in future other maps would be added that would have
> similar mechanisms of inner objects they return to the BPF program, we'll
> be adding yet another command just for this.

And that's why my personal preference is to just calling this thing
BPF_SYNCHRONIZE, which I'd define to wait for all such "inner
objects". Alexei is the one who asked for the very specific naming, I
believe.

Anyway, we have a very simple patch that we could apply today. It
addresses a real need, and it doesn't preclude adding something more
specific later, when we know we need it. Besides, it's not as if
adding a BPF command is particularly expensive.

> Also, union bpf_attr is extensible,
> e.g. additional members could be added in future whenever needed for this
> subcommand instead of forcing it to NULL as done here.

We fail with EINVAL when attr != NULL now, which means that we can
safely accept a non-NULL attr-based subcommand later without breaking
anyone. The interface is already extensible.

> All I'm saying is to
> keep it generic so it can be extended later.

Sure, but no more extensible than it has to be. Prematurely-added
extension points tend to cause trouble later.
