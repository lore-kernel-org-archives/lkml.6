Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B30C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1E52168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4DwZhwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1E52168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeI0Xgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:36:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41980 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeI0Xgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:36:39 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so2456680iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zb6LHi+FvjIQDGgKJlWbS8EePaue+YRWWkZ5bo/1YOE=;
        b=J4DwZhwTI3XsmynMzOde2gwxzhy0+gTi10rg5dL45kXTusD9SuGkPRkdm29xznEz1N
         FVLXCvyMk+Nvqke3yD0gYg44TIh4whtLzU9Fqsday5kGyyg3eppdSQy318/HMAMyyuJ7
         mCkXXRj0HE7JtiKil9fjLMn5vAAnYdfTfYktMFChK97mG4w0H9DzzDCHgDwcCt/tH4q7
         YWOFXY1HQ5lDz9hZWvfJtHrCKBjZL9Q4WLoPRZfd1WfG0MZTwEx4FnAgJYDDKoCmZDPX
         4vDqHH4NpodDVJ+GV+7sFy22nWRzY91NVkisxmd6mTH2y5YODY5rVYOVAJBdW/FQ4mcb
         98tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zb6LHi+FvjIQDGgKJlWbS8EePaue+YRWWkZ5bo/1YOE=;
        b=aiNes8mbZpRX5hxRS8Gcz6KmDan3dfYHKQG5WYRG0IHWtdwW7I7tPpGXLpEvoiJmIT
         cFlme3oVaNFUsjNN+GanB9vJbyQ76MwbCfM7PMZi6OkaKqXphr/sjTRFe0PMfDgGz2OY
         +24zJsPbtVSsd8wYAh2jurJVHnnDWFc/T9LX9yjwTXysv5f5EiktfA6mqCIbkwues56k
         p2WILIbehBamuJuD3nhFh5t3bE3SlNrV7yT/A9x+RWqgv4nBPo/AFlc9NLht27EkBDEW
         qSE0O6rMEkzqtfqutOFZWZxh92qOC/x4m7m0Dl87P7QU8nZqW+sodc2JjW5mVzOcGD6G
         tYow==
X-Gm-Message-State: ABuFfoj2rd0AtRHnSxr99Z6v/K9Ref4b68FxssZ8xVdYWRmKI/n2Of8J
        CkdMPHzYFT8hNFnvftkaOQKv6lUnW173E1PBIDV+vQ==
X-Google-Smtp-Source: ACcGV63hxBMqrvKzNGWJIPjyH6COkey2cfw8gsqjckVsEeITl4NRHYcILgIz5kjsHG151dekgeaSo//Tbuo0lBojdPs=
X-Received: by 2002:a6b:f316:: with SMTP id m22-v6mr8865087ioh.271.1538068641657;
 Thu, 27 Sep 2018 10:17:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 10:17:01
 -0700 (PDT)
In-Reply-To: <010001661bba2bbc-a5074e00-2009-414a-be8c-05c58545c7ec-000000@email.amazonses.com>
References: <20180927130707.151239-1-dvyukov@gmail.com> <010001661bba2bbc-a5074e00-2009-414a-be8c-05c58545c7ec-000000@email.amazonses.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Sep 2018 19:17:01 +0200
Message-ID: <CACT4Y+atu0Fz0Bhqn+7qpRowySEVWXV+vwVbBZ5y3Z+NnSpLsQ@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn about large allocations for slab
To:     Christopher Lameter <cl@linux.com>
Cc:     Dmitry Vyukov <dvyukov@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 5:51 PM, Christopher Lameter <cl@linux.com> wrote:
> On Thu, 27 Sep 2018, Dmitry Vyukov wrote:
>
>> From: Dmitry Vyukov <dvyukov@google.com>
>>
>> This warning does not seem to be useful. Most of the time it fires when
>> allocation size depends on syscall arguments. We could add __GFP_NOWARN
>> to these allocation sites, but having a warning only to suppress it
>> does not make lots of sense. Moreover, this warnings never fires for
>> constant-size allocations and never for slub, because there are
>> additional checks and fallback to kmalloc_large() for large allocations
>> and kmalloc_large() does not warn. So the warning only fires for
>> non-constant allocations and only with slab, which is odd to begin with.
>> The warning leads to episodic unuseful syzbot reports. Remote it.
>
> /Remove/
>
> If its only for slab then KMALLOC_MAX_CACHE_SIZE and KMALLOC_MAX_SIZE are
> the same value.
>
>> While we are here also fix the check. We should check against
>> KMALLOC_MAX_CACHE_SIZE rather than KMALLOC_MAX_SIZE. It all kinda
>> worked because for slab the constants are the same, and slub always
>> checks the size against KMALLOC_MAX_CACHE_SIZE before kmalloc_slab().
>> But if we get there with size > KMALLOC_MAX_CACHE_SIZE anyhow
>> bad things will happen.
>
> Then the WARN_ON is correct just change the constant used. Ensure that
> SLAB does the same checks as SLUB.

Mailed v2 which adds the checks to slab.

I think the warning is still slightly wrong. It means a bug in slab
code, it has nothing to do with user-passed flags.
