Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A31C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0CD20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx/m/PhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0CD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeICTbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:31:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54082 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:31:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id b19-v6so1535990wme.3;
        Mon, 03 Sep 2018 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBXk9LfSk2rzR+02HunmKWC22g9u1K2qTiC55tmSV/U=;
        b=Hx/m/PhQl2ObRiumf7sdeHhyGRuOCwOt++13PXUIs+KuspSimS4HFbw/veyR9+/vtf
         d1iIA+8edBk9BdCNe7/N0pVjiSDvLQY1ENHEFKYqTwZ6QmwORGIV+b92hxmhp+ETWH2f
         NOeKRIhBaUxsW+p+5qrU22PjCek95EO1cRkKyOyPaNVRwkdJGcaoYSsPXCI1XmMsVxn/
         +elj1XhiPY29pC9CLGSqvvW67bUJ4UOSAY/QJIvpyPtlDjEi2rx+Yg4ktcdC9HR2NOMF
         b/CvVtCQZ1VU2x4aqYVSGsnKZE4qCTPjzpWUAmCFUXPgl8jSPVCHEs5ba70vv7TNyKDA
         EOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBXk9LfSk2rzR+02HunmKWC22g9u1K2qTiC55tmSV/U=;
        b=WNTl9WVsL1T+PZZXyNOpZPvuutXE8rgSHR3bIOTYynrM0dBel5LnyWGxeUf2DRFxih
         lSNd5Kz/atH2pWCU38rYNZQ7z4uNBL81gneWO8DRqf58t/xNgn84gLsri7u35nIRVWIh
         /09RJeSjWAT1ExjQ3AZmJvltdGdIqCM1+ct4KI1W/1eccgKgv3FRDuDjfOyhYVOpLxhe
         ivmOn4CyLnGiuoHeUojKSkPuLQCFKSRn289UrZuMjQES6OHmXXyiJtebWswmvdMwPsgo
         n0Stm33THFMmz8CVENE0yPXmde5GR1hUP+ki2A5ZNN4bP27ZHvH/CXc+iLMkRXY7ip6X
         mivg==
X-Gm-Message-State: APzg51AzBJ1eq1pDP3ocq8V/oukPOWImdKSIMaN6ep4DnPEecnxTFN5r
        frmLuvCE2lFcWnkvZ1OUYuI=
X-Google-Smtp-Source: ANB0VdYzzGu72Lwq9prC544xqTcfBUpv3OV9gn8QXk20TTwlWqgfwQxEJJBYhiB42UR926ZJEDcqQg==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr5788614wme.125.1535987431534;
        Mon, 03 Sep 2018 08:10:31 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4006:df00:113f:adbd:9f65:1637])
        by smtp.gmail.com with ESMTPSA id 204-v6sm17256494wmh.25.2018.09.03.08.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 08:10:30 -0700 (PDT)
Date:   Mon, 3 Sep 2018 17:10:27 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        linux-kselftest@vger.kernel.org,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch@vger.kernel.org, Jacob Bramley <Jacob.Bramley@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
Message-ID: <20180903151026.n2jak3e4yqusnogt@ltop.local>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local>
 <20180831134244.GB19965@ZenIV.linux.org.uk>
 <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
 <01cadefd-c929-cb45-500d-7043cf3943f6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cadefd-c929-cb45-500d-7043cf3943f6@arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 02:49:38PM +0100, Vincenzo Frascino wrote:
> On 03/09/18 13:34, Andrey Konovalov wrote:
> > On Fri, Aug 31, 2018 at 3:42 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> On Fri, Aug 31, 2018 at 10:11:24AM +0200, Luc Van Oostenryck wrote:
> >>> On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
> >>>> This patch adds __force annotations for __user pointers casts detected by
> >>>> sparse with the -Wcast-from-as flag enabled (added in [1]).
> >>>>
> >>>> [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
> >>>
> >>> Hi,
> >>>
> >>> It would be nice to have some explanation for why these added __force
> >>> are useful.
> > 
> > I'll add this in the next version, thanks!
> > 
> >>         It would be even more useful if that series would either deal with
> >> the noise for real ("that's what we intend here, that's what we intend there,
> >> here's a primitive for such-and-such kind of cases, here we actually
> >> ought to pass __user pointer instead of unsigned long", etc.) or left it
> >> unmasked.
> >>
> >>         As it is, __force says only one thing: "I know the code is doing
> >> the right thing here".  That belongs in primitives, and I do *not* mean the
> >> #define cast_to_ulong(x) ((__force unsigned long)(x))
> >> kind.
> >>
> >>         Folks, if you don't want to deal with that - leave the warnings be.
> >> They do carry more information than "someone has slapped __force in that place".
> >>
> >> Al, very annoyed by that kind of information-hiding crap...
> > 
> > This patch only adds __force to hide the reports I've looked at and
> > decided that the code does the right thing. The cases where this is
> > not the case are handled by the previous patches in the patchset. I'll
> > this to the patch description as well. Is that OK?
> > 
> I think as well that we should make explicit the information that
> __force is hiding.
> A possible solution could be defining some new address spaces and use
> them where it is relevant in the kernel. Something like:
> 
> # define __compat_ptr __attribute__((noderef, address_space(5)))
> # define __tagged_ptr __attribute__((noderef, address_space(6)))
> 
> In this way sparse can still identify the casting and trigger a warning.
> 
> We could at that point modify sparse to ignore these conversions when a
> specific flag is passed (i.e. -Wignore-compat-ptr, -Wignore-tagged-ptr)
> to exclude from the generated warnings the ones we have already dealt
> with.
> 
> What do you think about this approach?

I'll be happy to add such warnings to sparse if it is useful to detect
(and correct!) problems. I'm also thinking to other possiblities, like
having some weaker form of __force (maybe simply __force_as (which will
'only' force the address space) or even __force_as(TO, FROM) (with TO
and FROM being a mask of the address space allowed).

However, for the specific situation here, I'm not sure that using
address spaces is the right choice because I suspect that the concept
of tagged pointer is orthogonal to the one of (the usual) address space
(it won't be possible for a pointer to be __tagged_ptr *and* __user).

OTOH, when I see already the tons of warnings for concepts established
since many years (I'm thinking especially at __bitwise, see [1]) I'm a
bit affraid of adding new, more specialized ones that people will
understand even less how/when they need to use them.


-- Luc

[1] Here are the warnings reported on v18-rc1 x86-64 with defconfig:
    469 symbol was not declared. Should it be static?
    241 incorrect type in argument (different address spaces)
    186 context imbalance - unexpected unlock
    147 restricted type degrades to integer
    122 incompatible types in comparison expression (different address spaces)
    117 context imbalance - different lock contexts for basic block
    102 incorrect type in assignment (different address spaces)
    101 incorrect type in initializer (different address spaces)
     82 dereference of noderef expression
     79 cast to restricted type
     74 incorrect type in argument (different base types)
     72 bad integer constant expression
     68 context imbalance - wrong count at exit
     65 incorrect type in assignment (different base types)
     44 cast removes address space of expression
     38 Using plain integer as NULL pointer
     20 Variable length array is used.
     14 symbol redeclared with different type - different modifiers
     14 cast from restricted type
     13 function with external linkage has definition
     12 subtraction of functions? Share your drugs
     11 directive in argument list
      8 incorrect type in return expression (different address spaces)
      6 cast truncates bits from constant value
      5 invalid assignement
      5 incorrect type in return expression (different base types)
      5 incorrect type in initializer (different base types)
      4 "Sparse checking disabled for this file"
      3 memset with byte count of ...
      3 incorrect type in initializer (different modifiers)
      2 Initializer entry defined twice
      2 incorrect type in assignment (different modifiers)
      2 incorrect type in argument (different modifiers)
      2 arithmetics on pointers to functions
      1 trying to concatenate long character string (8191 bytes max)
      1 too long token expansion
      1 symbol redeclared with different type - incompatible argument (different address spaces)
      1 memcpy with byte count of ...
      1 marked inline, but without a definition
      1 invalid initializer
      1 incorrect type in argument (incompatible argument (different signedness))
      1 incompatible types in comparison expression (different base types)
      1 dubious: !x | y
      1 constant is so big it is ...
