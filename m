Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBC4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD742493D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWKzM8lQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD742493D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965438AbeF1P2t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:28:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38530 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753390AbeF1P2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:28:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id a5-v6so5428668edt.5;
        Thu, 28 Jun 2018 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aTt1Cb5ofpN+7UGkRkwxqnhfncC46uAIKB12UtV93ZU=;
        b=SWKzM8lQ9I1pTXSF/GnYfLpVVvvT2pEvMt9siigbSVDpXsCDB8+oTtDQ7Y+5beZAVJ
         /9dKhDmruEuY8FRcjYhHMsw5uzdQZbFaB6AWw8TvzBTxSJ/e24gRkxwZ4xN/mUqyfkKo
         QmijOrs8RuxHAMo+VYRxkZfI92ZyDrfbn04SbTQGeHd1aMabL6gZTG+hbmNMoFja2bbv
         EF7vrJrXT6eFcJf32Zuk+lUUkU1Sv6Dgg3gyZR7uOGzBcEg+MENBib94ZdrAnekX4yDT
         4UZnUCRuEzofya/J2JW9BFhxBzWwsOKqpJJR1UyHBjs7b/CH3AnhrQo/yPJdmSeq88cc
         uxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aTt1Cb5ofpN+7UGkRkwxqnhfncC46uAIKB12UtV93ZU=;
        b=eezJbnATB/rAWAfowR9oviOhlPbV+yWkHYM5odrupL8ujeS3xM3gEpMD3/HxjmVG11
         DC7/FP+8ziIpJv6Z1ftg6Mtro+taPexJzj/aFffkxtQXsOg4Woy2oGbckTfkksGCL3oT
         9D7T8veCjRzfuOHbzioNPhyZRgNs5mWY80E4ti4VAXP99N5FeSuZKYlQnCxYOYIgCdWn
         GSU8kpzIrurT4Jv8F5jF8heZeeD+6z2EE2NZ0K1V5Ke/1Rk2SYt3UNPNzLedjCM23VJG
         Roi+cUL9Qtzj0u0VqKKTrXOEKGLmSwM12ppMmGYPeFReKLkz7OAEexsKTl8UUtLyWK9b
         K0iw==
X-Gm-Message-State: APt69E1dA15eeNyQNkSu5qkXOLFBw9BJZYAOkWMtRrHvF0ABsOlUsG4Z
        PpMnlJ/3g9fRcQvBUfjCLPqCyYu3
X-Google-Smtp-Source: AAOMgpeJODZ/2dH1tjdWFTF7uj3oeyviKbSObiv3yotJUzaDhcuUr2Va/Yn22xPUk+bCLQfJGqi6Og==
X-Received: by 2002:a50:cc8c:: with SMTP id q12-v6mr9434050edi.98.1530199724849;
        Thu, 28 Jun 2018 08:28:44 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40dc:3d00:cc54:7de1:e161:def7])
        by smtp.gmail.com with ESMTPSA id y32-v6sm2985234eda.38.2018.06.28.08.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:28:44 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:28:43 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180628152841.rgc62aqqckcuecaf@ltop.local>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
 <20180628061758.j6bytsaj5jk4aocg@ltop.local>
 <20180628102741.vk6vphfinlj3lvhv@armageddon.cambridge.arm.com>
 <20180628104610.czsnq4w3lfhxrn53@ltop.local>
 <20180628144858.2fu7kq56cxhp2kpg@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628144858.2fu7kq56cxhp2kpg@armageddon.cambridge.arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:48:59PM +0100, Catalin Marinas wrote:
> On Thu, Jun 28, 2018 at 12:46:11PM +0200, Luc Van Oostenryck wrote:
> > On Thu, Jun 28, 2018 at 11:27:42AM +0100, Catalin Marinas wrote:
> > > On Thu, Jun 28, 2018 at 08:17:59AM +0200, Luc Van Oostenryck wrote:
> > > > On Wed, Jun 27, 2018 at 06:17:58PM +0100, Catalin Marinas wrote:
> > > > > sparse is indeed an option. The current implementation doesn't warn on
> > > > > an explicit cast from (void __user *) to (unsigned long) since that's a
> > > > > valid thing in the kernel. I couldn't figure out if there's any other
> > > > > __attribute__ that could be used to warn of such conversion.
> > > > 
> > > > sparse doesn't have such attribute but would an new option that would warn
> > > > on such cast be a solution for your case?
> > > 
> > > I can't tell for sure whether such sparse option would be the full
> > > solution but detecting explicit __user pointer casts to long is a good
> > > starting point. So far this patchset pretty much relies on detecting
> > > a syscall failure and trying to figure out why, patching the kernel. It
> > > doesn't really scale.
> > 
> > OK, I'll add such an option this evening.
> 
> That's great, thanks. I think this should cover casting pointers to any
> integer types, not just "unsigned long" (e.g. long long).

Yes, of course.
 
> The only downside is that with this patchset the untagging can be done
> after the conversion to ulong (get_user_pages()) as that's where the
> problem was noticed. With a new sparse feature, we'd have to annotate
> the conversion sites (not sure how many until we run the tool though).

I've done a lot of hacking on sparse and as such I run a lot of tests.
What I see with these tests is that a lot of annotations are wrong or
missing so I'm very reluctant to add another attribute. Even more so
one that would be only slightly different than an existing one. OTOH,
if it's something localized or a one-shot and there is a need, ...
why not?

What would you ideally need?

-- Luc
