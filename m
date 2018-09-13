Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ECEC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7021F20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHX7Hu0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7021F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeIMLTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:19:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35480 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeIMLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:19:52 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so8329827oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 23:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H1JNbMfwbESozImo8DPIHl1nzsZDhdGy6DOG//hFizs=;
        b=WHX7Hu0nHHEm2k+Embws5gMordF26EQqCUPy02x4lYbyPHlvfWFznfJQVOwJAqsum+
         A/A58WEhooragib8oo8HJeY6FBBb6PtRVE86PCsdRikVO11NL9ZLfjyCj+7c2QWclqsa
         VCOBkmGoR4aR81x4ukbOTPi7GUxLDOGgeunbY3o0ZHcmPYX+vh6NcSm2au4Ij0jUUlu7
         /TE7g63A/E1pexTHydGJ6XxPqR7nFogQpgEyLVYwIkPNq83mauTOwB29oExn2lFG4+sE
         iFR6Cv769v5HLo543pafjBm7jLL55Ny6QYBLSsZwObQpUih+ajVyGUqFmPLt/WkbRfns
         TZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H1JNbMfwbESozImo8DPIHl1nzsZDhdGy6DOG//hFizs=;
        b=uQASahvcbLzwQnfdJhmuou45VopL8sZZxsC0FsJZqaGpvqxBsxS9fk4KJwR/htHkvS
         iF+RpxmOE3sR521XPz7H168kmvJqA2PtKY3ODIpT0g6P/HQIxPMOsDTPT1+7VO12hzqe
         dZAVsWOEbliDuZte0PXBEez22G9CnpRBUoj/ClqPYU+HlXe0NfbAqn280jpL3JdF58Bo
         diEDq6EJ5K4qT/feoCmB8hqGwxEHCYM7q62aKTi+L5K0IUngQnoC2LlfrEGqXMls8q0O
         tlUiS26qW6cFRTidd6v4/oZWBTM/4rHfJ9STTbxjNJnRITAkjEr8sPwYa4jjDNUjFk6N
         Y8AQ==
X-Gm-Message-State: APzg51DsAvGzuHASUNJrSAxA+NzAJxkJx5IuB4dCzZBbGO6/o28llLsa
        ouPFmGD45GlotDAG0NLI0edfy/26zMxeaTV+4Pg=
X-Google-Smtp-Source: ANB0VdY9+cTOuANQn8lGkqU7HTehomdKLlZF/hrZfRRvfYr4ffDYcAKdt461w6pt+QRlj6AUgbY9uixHcpiycJMYGEU=
X-Received: by 2002:aca:2cd3:: with SMTP id s202-v6mr5081352ois.253.1536819110506;
 Wed, 12 Sep 2018 23:11:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e12:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 23:11:49
 -0700 (PDT)
In-Reply-To: <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com> <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
 <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com> <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
From:   Juerg Haefliger <juergh@gmail.com>
Date:   Thu, 13 Sep 2018 08:11:49 +0200
Message-ID: <CADLDEKsxx=MSFu=4_4JLX1afUMr3GVjNxSQ-726NrbLn8KQaQg@mail.gmail.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     Julian Stecklina <jsteckli@amazon.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        deepa.srinivasan@oracle.com, Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 5:37 PM, Julian Stecklina <jsteckli@amazon.de> wrote:
> Julian Stecklina <jsteckli@amazon.de> writes:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> On Fri, Aug 31, 2018 at 12:45 AM Julian Stecklina <jsteckli@amazon.de> wrote:
>>>>
>>>> I've been spending some cycles on the XPFO patch set this week. For the
>>>> patch set as it was posted for v4.13, the performance overhead of
>>>> compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
>>>> completely from TLB flushing. If we can live with stale TLB entries
>>>> allowing temporary access (which I think is reasonable), we can remove
>>>> all TLB flushing (on x86). This reduces the overhead to 2-3% for
>>>> kernel compile.
>>>
>>> I have to say, even 2-3% for a kernel compile sounds absolutely horrendous.
>>
>> Well, it's at least in a range where it doesn't look hopeless.
>>
>>> Kernel bullds are 90% user space at least for me, so a 2-3% slowdown
>>> from a kernel is not some small unnoticeable thing.
>>
>> The overhead seems to come from the hooks that XPFO adds to
>> alloc/free_pages. These hooks add a couple of atomic operations per
>> allocated (4K) page for book keeping. Some of these atomic ops are only
>> for debugging and could be removed. There is also some opportunity to
>> streamline the per-page space overhead of XPFO.
>
> I've updated my XPFO branch[1] to make some of the debugging optional
> and also integrated the XPFO bookkeeping with struct page, instead of
> requiring CONFIG_PAGE_EXTENSION, which removes some checks in the hot
> path.

FWIW, that was my original design but there was some resistance to
adding more to the page struct and page extension was suggested
instead.


> These changes push the overhead down to somewhere between 1.5 and
> 2% for my quad core box in kernel compile. This is close to the
> measurement noise, so I take suggestions for a better benchmark here.
>
> Of course, if you hit contention on the xpfo spinlock then performance
> will suffer. I guess this is what happened on Khalid's large box.
>
> I'll try to remove the spinlocks and add fixup code to the pagefault
> handler to see whether this improves the situation on large boxes. This
> might turn out to be ugly, though.

I'm wondering how much performance we're loosing by having to split
hugepages. Any chance this can be quantified somehow? Maybe we can
have a pool of some sorts reserved for userpages and group allocations
so that we can track the XPFO state at the hugepage level instead of
at the 4k level to prevent/reduce page splitting. Not sure if that
causes issues or has any unwanted side effects though...

...Juerg


> Julian
>
> [1] http://git.infradead.org/users/jsteckli/linux-xpfo.git/shortlog/refs/heads/xpfo-master
> --
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
>
