Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CF4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CFF2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Buk+qnMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CFF2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbeJKRIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:08:38 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35519 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeJKRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:08:38 -0400
Received: by mail-it1-f193.google.com with SMTP id p64-v6so12249787itp.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 02:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bGzsUcWNDOV9dRKwvQJ+5Y5gyBgMHERzdvQ3lpPV4a8=;
        b=Buk+qnMIyTOu47/n1uelFqb/lGybDO2PmlVYjjhQ8Uc/LH6EPqhAuiHxVI/FYfXRQ8
         J4Hk8HSPTpr/MrlLch1fie0jTmJToV+tQwNKfCR274hXHwIsRTaqkYPpUkcftSOmJ33D
         m8A74MUMjkBZFhriH9BJj6hu+MS9nyfM+OsOmX0xvW/SP5Lysg3ksZUX+pxuKSXUxdco
         Hvy8z/19jx8qAuUCHCK8vWgKUeFGwrYQMWquVLiJ2yyDR4Ufimfmo+rXBkc2lKBmnw0d
         SXP9YnlwDTcmonOlIFNC3HfTOdOYq7/91LsSZLFrf6xn3Q5FVENh1NQNrgu/k853gqfh
         o9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bGzsUcWNDOV9dRKwvQJ+5Y5gyBgMHERzdvQ3lpPV4a8=;
        b=m0szoxX1pCJeUJD/470wtuLCzcDct89Z1e3o/pFNeC/aWHAuAZvqpyihfOPB4hAqv6
         u6EWA6FhWoGaKe2FetaKwYCynRMrfku3PkJSyj8UGvAEMOtynRDwJ9jIe6FOqecg61IA
         tlVB6T97ULiZg0arEA8QR0o3i+OcS1iJw9iZ5KYX9hrbGBswiiHxy8zCKfyoKnwNeTt3
         jtnH7BV7zV99pz1bPKBiRSObd/SpZrqai2RCCgIxBqQbumLiELsnuz2Wzvuhb4fw68Kd
         9qz7YOUNPn14D2LdkFWiNyGr4yC3cj7ReLelAKA9VL2nlN8GG5BCTzPRSY0L9CrZ+bid
         nrcg==
X-Gm-Message-State: ABuFfojGeJeH+MF8o0LYkUUXTs1RWvnDgMqcbaBX8OC0HNf+f+/KIGeo
        ZyDsAUxH+1LYEhcgOX2IMehDBgLVu6YnU3uN068Es5SxNfY=
X-Google-Smtp-Source: ACcGV61JTRrJuKnX4fVwFZioGjwZhaCs7qdyfPTvj2yrP0wB0lG05bsA9BMFWj2DSQfy0rihnTEh5KjWAS74EexIKR4=
X-Received: by 2002:a02:9716:: with SMTP id x22-v6mr607441jai.82.1539250928291;
 Thu, 11 Oct 2018 02:42:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:1003:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 02:41:47
 -0700 (PDT)
In-Reply-To: <CACT4Y+aiSXsyFqXueRGXeVeY6KAJ4M2Oy6RZWFnNS_d9Z9pAnw@mail.gmail.com>
References: <CAPhKKr_XFzGcBBuQ51w7HjZd_Kq3nTOB6uAFG2vP5JH+Vx_eng@mail.gmail.com>
 <CACT4Y+Y+6arxj4=72DZSj45u5kjKRksJZ7c6pBLeFDxUSBFwOg@mail.gmail.com>
 <20181008142300.3aacaabe@gandalf.local.home> <CAPhKKr8QvK3bkT6gQB9jc31Cx+gLmZwRnKuRUD_1xaidwL14Dg@mail.gmail.com>
 <CACT4Y+aiSXsyFqXueRGXeVeY6KAJ4M2Oy6RZWFnNS_d9Z9pAnw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Oct 2018 11:41:47 +0200
Message-ID: <CACT4Y+a6stTxMritOizwvcbkQAJoGF3MbBmBFu-8x3o13Vxc5g@mail.gmail.com>
Subject: Re: [Announce] LPC 2018: Testing and Fuzzing Microconference
To:     Dhaval Giani <dhaval.giani@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alice Ferrazzi <alice.ferrazzi@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        gustavo.padovan@collabora.co.uk,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, knut.omang@oracle.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:54 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>> On Mon, 8 Oct 2018 19:02:51 +0200
>>> Dmitry Vyukov <dvyukov@google.com> wrote:
>>>
>>> > On Wed, Sep 19, 2018 at 7:13 PM, Dhaval Giani <dhaval.giani@gmail.com> wrote:
>>> > > Hi folks,
>>> > >
>>> > > Sasha and I are pleased to announce the Testing and Fuzzing track at
>>> > > LPC [ 1 ]. We are planning to continue the discussions from last
>>> > > year's microconference [2]. Many discussions from the Automated
>>> > > Testing Summit [3] will also continue, and a final agenda will come up
>>> > > only soon after that.
>>> > >
>>> > > Suggested Topics
>>> > >
>>> > > - Syzbot/syzkaller
>>> > > - ATS
>>> > > - Distro/stable testing
>>> > > - kernelci
>>> > > - kernelci auto bisection
>>> > > - Unit testing framework
>>> > >
>>> > > We look forward to other interesting topics for this microconference
>>> > > as a reply to this email.
>>> >
>>> > Hi Dhaval and Sasha,
>>> >
>>> > My syzbot talk wasn't accepted to main track, so I would like to do
>>> > more or less full-fledged talk on the microconf. Is it possible?
>>>
>>> Hi Dmitry,
>>>
>>> Note, microconfs are not for full-fledged talks. They are to be
>>> discussion focused. You can have a 5-10 minute presentation that leads
>>> up to discussion of future work, but we like to refrain from any talks
>>> about what was done if there's nothing to go forward with.
>>
>> Dmitiry,
>>
>> Can you clarify the scope of what you want to discuss during the
>> microconference? Further to what Steven said, we don't want
>> presentations (So 3, maybe 4 slides). We want discussions about future
>> work.
>>
>> Thanks!
>> Dhaval
>
>
> Hi Steven, Dhaval,
>
> Acknowledged.
>
> Then smaller topic that would benefit from discussion are:
>
> the main one being:
>
> 1. syzbot: developer process; unfixed bugs; bug triage; what's
> working? what's not? why? how can we make more parts work? collecting
> feedback

+Paul as Plumbers committee representative
And +Greg is already here as Kernel Summit representative

Re syzbot talk (around process and feedback).
I've submitted this as proposal to Plumbers, it did not make it to
main track but it's in backlog (I am a reserve speaker).
Sergey suggested to submit this as proposal for Kernel Summit TECH
TOPIC. It would probably benefit from more kernel maintainers in the
room.

Now I am somewhat troubled, if I submit the talk for Kernel Summit and
then suddenly I materialize as speaker on Plumbers too. It's not a
good idea to do the same talk twice, right?
The questions are:
1. Is it a good fit for Kernel Summit TECH TOPIC?
2. What should I do if I suddenly accepted to both Summit and
Plumbers? I probably could prepare a second, different talk for
Plumbers then (it wasn't announced yet).
3. If the talk is accepted to Summit, what should we do with Testing
MC part? Withdraw?


> 2. how to increase test coverage/find more bugs, in particular:
>  - adding manual spot KASAN/KMSAN checks into kernel codebase
>  - stubbing hardware/external inputs to kernel for testing
>  - description of kernel interfaces (again)
>
> 3. dealing with kernel console output mess
>  - intermixed/split lines
>  - understand when/how kernel crashed
>  - and where is that message
>  - crash identity
