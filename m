Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49446C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FBB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl6MOlJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FBB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbeIFUSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:18:09 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36383 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730165AbeIFUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:18:09 -0400
Received: by mail-it0-f66.google.com with SMTP id u13-v6so14884742iti.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPnMCM5D84M7mDIGoy83nNAxY6OZ7raWxix7f0OCLY8=;
        b=cl6MOlJWYmEhRevTtsc7RiEZFPdd5HCsZ9E09TEHEK8H1/VLF0fjkamuFp4x9QkEBx
         aWycAevqB5OxkJzPRt5GYaB4ixjCMIoYzLlHcRbfRrUonp/hW7gqLT4dhRXWvthjENgu
         d2/pytRXjQ48fY0ICugqlmZIRAQTd5Xe3M3TmyUnwl69zezGH1LCer7s0e3+k0utpa1V
         qnm2G7Dg0o+1gLmXykwfYa/Y35kw3MeTdJu47FF2hpGoUFaAaG6TUhbXEua9ZaT8dYZ4
         8AVlkYhYaNrYs9BFfFHo84ysb8sdeD29sDmpvbDydTKvQ0Kwr0gY4UItOnvwXlaeai5R
         CUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPnMCM5D84M7mDIGoy83nNAxY6OZ7raWxix7f0OCLY8=;
        b=GPoc2uCQFUll5TAaNlWj+QVpfPwSKfmQ043hDl1PcAUFr313Ui94fZ/6pNWCVLPamg
         LmavCTNc1VmqHMRuZToXIAXyZOJj+NTiRI63CQHru3YWQGWrQC1EgLDTUkZHvMkB3MNF
         eE7MkU1ri54UuP2FOihwGXiSwpFHQHGH8aGkWzKDUEtWSt6aaj0P3PAvt4k9Nei4h8kk
         FUkgg6DPJ+/LT049djVbHxXHTtwotte+aLTzrtu5D3yxRG59b4TUjKMvmQNsWqkR6Q0l
         isqOUvaPHErxrugVQPaF7JWahysUldtchW5TdoI0b/AX9AUVHCaR8PUQsfCoVteiNw3r
         Y6jg==
X-Gm-Message-State: APzg51BqO9tX1n3R36DxOmUPRep9r+1LDUMM2/2ps6K1SetoCYDVX4eD
        YHKd+ZzAflBKBg1Opk/m8DizgNSbh+SquOC9SRQ=
X-Google-Smtp-Source: ANB0VdaiNGUVXUmWkow5oCVV3uYyPgePoHZQF0sTJNPv/ymV4e31CsNYIivxNEKvN44dyk1iB5QAPwemSd2s9xNWBn8=
X-Received: by 2002:a02:410e:: with SMTP id x14-v6mr2677179jaa.78.1536248523432;
 Thu, 06 Sep 2018 08:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain> <20180906054735.GJ14951@dhcp22.suse.cz>
 <0c1c36f7-f45a-8fe9-dd52-0f60b42064a9@intel.com> <20180906151336.GD14951@dhcp22.suse.cz>
In-Reply-To: <20180906151336.GD14951@dhcp22.suse.cz>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 6 Sep 2018 08:41:52 -0700
Message-ID: <CAKgT0UfiKWZO6hyjc1RpRTgD+CvM=KnbYokSueLFi7X5h+GMKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to CONFIG_DEBUG_VM_PAGE_INIT_POISON
To:     mhocko@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        pavel.tatashin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 8:13 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 06-09-18 07:59:03, Dave Hansen wrote:
> > On 09/05/2018 10:47 PM, Michal Hocko wrote:
> > > why do you have to keep DEBUG_VM enabled for workloads where the boot
> > > time matters so much that few seconds matter?
> >
> > There are a number of distributions that run with it enabled in the
> > default build.  Fedora, for one.  We've basically assumed for a while
> > that we have to live with it in production environments.
> >
> > So, where does leave us?  I think we either need a _generic_ debug
> > option like:
> >
> >       CONFIG_DEBUG_VM_SLOW_AS_HECK
> >
> > under which we can put this an other really slow VM debugging.  Or, we
> > need some kind of boot-time parameter to trigger the extra checking
> > instead of a new CONFIG option.
>
> I strongly suspect nobody will ever enable such a scary looking config
> TBH. Besides I am not sure what should go under that config option.
> Something that takes few cycles but it is called often or one time stuff
> that takes quite a long but less than aggregated overhead of the former?
>
> Just consider this particular case. It basically re-adds an overhead
> that has always been there before the struct page init optimization
> went it. The poisoning just returns it in a different form to catch
> potential left overs. And we would like to have as many people willing
> to running in debug mode to test for those paths because they are
> basically impossible to review by the code inspection. More importantnly
> the major overhead is boot time so my question still stands. Is this
> worth a separate config option almost nobody is going to enable?
>
> Enabling DEBUG_VM by Fedora and others serves us a very good testing
> coverage and I appreciate that because it has generated some useful bug
> reports. Those people are paying quite a lot of overhead in runtime
> which can aggregate over time is it so much to ask about one time boot
> overhead?

The kind of boot time add-on I saw as a result of this was about 170
seconds, or 2 minutes and 50 seconds on a 12TB system. I spent a
couple minutes wondering if I had built a bad kernel or not as I was
staring at a dead console the entire time after the grub prompt since
I hit this so early in the boot. That is the reason why I am so eager
to slice this off and make it something separate. I could easily see
this as something that would get in the way of other debugging that is
going on in a system.

If we don't want to do a config option, then what about adding a
kernel parameter to put a limit on how much memory we will initialize
like this before we just start skipping it. We could put a default
limit on it like 256GB and then once we cross that threshold we just
don't bother poisoning any more memory. With that we would probably be
able to at least cover most of the early memory init, and that value
should cover most systems without getting into delays on the order of
minutes.

- Alex
