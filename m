Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F71C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3AF21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqzdjxtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3AF21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbeIXTpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:45:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55371 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbeIXTpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:45:03 -0400
Received: by mail-it1-f193.google.com with SMTP id c23-v6so2401346itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MTQ1NShy3bxgeWoHM3ppxoyzRgZbW/MIott7aAlB6Nk=;
        b=XqzdjxtZctxlHUWndXjitFY+KxuBLGHVOV3w1Hn92FPxkYs8EXAS7oNbr7E95zLt20
         hoDAMDbhQNAL5D9bJ9WczMhgGyoYPfwR90a3bjk7JBWOiQB93wH1Kx4TNX2VBeo0N2aM
         kNS7Fp+KcCt+VYIwVDOWd0tjntsJlhBG1et/RNjCKKS1l0/kJU38cLhFbbL4OF0yQiy8
         ykFgCvSHnnjpQ2KS16kvzrfBheq1iAHQaoyF7A8RdK9qA6rJaCa9jyxUgTea/2kQ4S77
         h3V2EVB6Vo6KO7SJ7Rzo5XnbFPtfXyezy6IabRLaI5wzKWO7HZDGRTTK7ZqhSvxgOJQ+
         q90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MTQ1NShy3bxgeWoHM3ppxoyzRgZbW/MIott7aAlB6Nk=;
        b=FGDvWI8CqZoaP0iZUG5rPhAdDWPqJEO9ltSmSj/JEV2tJUj7tiNCr/ccT9cnlpJOWu
         05PD9Cx8RS5sxo3ASTIb11kodcyK6aeezZk0sP84hhe8LcRYSoO17bdmBNPeE/3/1mg1
         xMqwJQXI7r3DfviWYeTALZTM+eDcWem6SU5Q/xnUnT5ZRXr2rYdl1unrAquFsoY1Nx23
         yPOdPEXbpPK+xWw+CqXb4howXwSAScubUxgxepOxPIAPcEOjo8KmjeRBTxFnbqb7vnAn
         GIT5EqTwNOPL0q/L6MhXGAcCtYMSu2NdYDoR5l38S9n4Pywhxya9XAoL41Jx5anS+aJF
         IvZA==
X-Gm-Message-State: APzg51Ai74jIK6QivgYhVdC/Ecwe4Rhlyl9pPm1Xy3gKdDoHIMuejN+P
        ghBxsGITITE7OLh1aK/mHqnxws688Sz8631MigSyxw==
X-Google-Smtp-Source: ANB0VdZtTkmTCddzy4tgHZCIa9QH+38g0xtg7UGEYOzinxCc4VDX7+U2VeNdQX4KoTKzPBoiJ3VOj5XGfDzwaxypaX4=
X-Received: by 2002:a02:c04e:: with SMTP id u14-v6mr9503177jam.110.1537796568200;
 Mon, 24 Sep 2018 06:42:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ab8c:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 06:42:27
 -0700 (PDT)
In-Reply-To: <20180922125256.GB14042@bombadil.infradead.org>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
 <20180922125256.GB14042@bombadil.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Sep 2018 15:42:27 +0200
Message-ID: <CACT4Y+ZN0OcTkY0ahvF0CGZv1bbLHGH2aEbCFuQzpC498cNojw@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alice.ferrazzi@gmail.com, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 2:52 PM, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Sep 19, 2018 at 10:13:15AM -0700, Dhaval Giani wrote:
>> Sasha and I are pleased to announce the Testing and Fuzzing track at
>> LPC [ 1 ]. We are planning to continue the discussions from last
>> year's microconference [2]. Many discussions from the Automated
>> Testing Summit [3] will also continue, and a final agenda will come up
>> only soon after that.
>>
>> Suggested Topics
>>
>> - Syzbot/syzkaller
>> - ATS
>> - Distro/stable testing
>> - kernelci
>> - kernelci auto bisection
>> - Unit testing framework
>>
>> We look forward to other interesting topics for this microconference
>> as a reply to this email.
>
> I would like to talk about the IDA test suite that was recently merged.
> See lib/test_ida.c.  It can be built as a module (CONFIG_TEST_IDA=m),
> built-in (=y) or built in userspace (as part of the radix tree test
> suite for historical reasons) along with the current kernel code.
>
> Being able to build the test suite in userspace allows for much more
> rapid development.  Building it in kernel space offers testing across
> a wide range of configurations that I don't have access to and can't
> necessarily simulate well in userspace.
>
> My userspace implementation of kmalloc() simulates failures (in a rather
> heavy-handed way; every non-GFP_KERNEL allocation fails).  That's rather
> harder to simulate in kernel space.  I'd like there to be a way for a
> kernel space test suite to ask for kmalloc failures so that the failure
> paths can be tested.

Hi Matthew,

kmalloc fault injection is already implemented with
CONFIG_FAULT_INJECTION. For original fault injection, you more-or-less
ask to fail X% of allocations at random. It's great for testing
servers for stability, but not so well suited for testing. Recently
I've added so-called "systematic" fault injection
(/proc/thread-self/fail-nth) which is perfect for unit testing. It
allows to ask to fail N-th allocation request in the current task. So
a unit test for a syscall can do:

for (i = 0;; i++) {
  write(/proc/thread-self/fail-nth, i);
  syscall_under_test();
  if (read(/proc/thread-self/fail-nth) != 0)
    break;
}

which allows to examine each failure site one-by-one systematically
(without making random processes on the machine fail too).


> I think the idea of building parts of the core kernel libraries in
> userspace and testing them there has greater generality than just the
> IDA, IDR, XArray & radix tree and might profitably be adopted by other
> parts of lib/.  The userspace simulation of other parts of the kernel
> may well need to be extended.

This would be great. Besides providing faster turn-around time, this
allow us to finally have something like:

make test [subsystem]

which will run all tests for the subsystem locally (in parallel,
giving final OK/FAIL). This is not possible to in-kernel tests,
because they require a machine and an image, and it's not possible to
support everything that people use.
