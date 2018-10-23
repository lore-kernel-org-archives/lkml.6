Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4964AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B6D20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqKtQQot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B6D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeJXAdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:33:18 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39940 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJXAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:33:18 -0400
Received: by mail-ed1-f44.google.com with SMTP id r1-v6so2167114edd.7;
        Tue, 23 Oct 2018 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Fgm4tFmb3aCVBUqVRe/lYD1am1ANjqT3rkKG73BHrA0=;
        b=ZqKtQQotqtvSi/BvgAxSrFvgRLYJqUDOhA0kxHrEufBXnxNntz5BcbEzjTuayF1q7a
         0ysmOTlaBB+WHtnpemnIlA/t4rb5kqzUEHJKk8CNYvwvzcCKhGTFPlmpi7sx84OdpqwC
         8Fpj9q7UjGZ/wYOAuDU9+6mJbyiLfEuTMUjmIZl6oa/KzgyoVhV0KXZfEXwxBk9qRxva
         2nvc5uYKDSHXh7VZgFQnqdkjztLS1KwAd3u+xOoLi8XEiuibW+jHKfdffMlOJ2mAqS3k
         poLVZH36Cf8KMyHe0E0lQX+sMTVMvywClNw5s+LZUK1BP1hGZV03qVj6QhIr7CPb8nLh
         AnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Fgm4tFmb3aCVBUqVRe/lYD1am1ANjqT3rkKG73BHrA0=;
        b=nEOH4P8eHIV41o/Vs54+uOJwBzlMBcCBXWTOcRLpftHMY4XatDz6oHrheoiYsAhXWR
         7oesevhLc29XFwCPJ9vCmULAGLc21DJdW2ZbZKK3rEG3z20Q1ShLbZMMGXjqblj0gxcY
         QnOZMfSPNGTaYjbsY616B+drPcLvLkUUkyc6S4WpBKZufFL1hpmDR7F+jAwQm3lAJYEb
         n9UNTxd+gtEhwriro97j0nWu6rawJA7pKZ5RpMlbJr1WQsMJ4XYj34RAsod6V24LMNzy
         BMVX1/rIL4YaFYM+ROB5cJ3cpaCCj7HZtm5cQZwwSWNw34Na1TKR6m6tA+iQSMve6jdo
         ksGg==
X-Gm-Message-State: AGRZ1gKshCgNcit6BeEFAOe3bvyfyBsHl4UtbNTRh7aoUFhbwyLXqcSZ
        iB1L70xEEFlSFHrqIPzIJE+B7bAA2/hUw9suW0M=
X-Google-Smtp-Source: AJdET5cA8XFEIPAVLNXUQDLOTgLU+IQR0nqHRB7dwN54oHZh1dnf3t7UuSqyd+xtjgXNOUzWcfCM2gmhjtpvPjD9LEc=
X-Received: by 2002:a05:6402:12c8:: with SMTP id k8mr9185770edx.143.1540310956010;
 Tue, 23 Oct 2018 09:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com> <20181017161958.GT270328@devbig004.ftw2.facebook.com>
In-Reply-To: <20181017161958.GT270328@devbig004.ftw2.facebook.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 23 Oct 2018 18:09:05 +0200
Message-ID: <CAKgNAkgEeHSYCFGdXOBQHBALg0KgWP_1=dEFYD_R6wCaV99MJg@mail.gmail.com>
Subject: Re: Cgroup v2 thread mode oddity: "domain invalid" cgroup with
 threaded controller enabled
To:     Tejun Heo <tj@kernel.org>
Cc:     "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun
On Wed, 17 Oct 2018 at 18:20, Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Michael.
>
> Sorry about the delay.
>
> On Thu, Oct 04, 2018 at 09:40:57PM +0200, Michael Kerrisk (man-pages) wrote:
> > This seems odd. x/y is now of "domain invalid" type with a controller
> > enabled! This feels like a violation of the rules, since we can't
> > in other circumstances do anything with a "domain invalid" cgroup
> > except convert it to "threaded". In particular, we can't create
> > child cgroups under a "domain invalid" cgroup, or add member processes
> > to the cgroup, or *enable controllers in the cgroup*. In fact, when
> > doing the
> >
> >     # echo threaded > x/z/cgroup.type
> >
> > I had expected a write(2) error because the state of x/y should
> > (I thought) not be permitted.
>
> So, both the interim (before turning x/z into threaded) and final
> (after) are completely fine - the cgroups are empty and whether
> threaded controllers like pids are enabled or not don't really change
> things that much.
>
> Maybe it is a bit inconsistent to then deny enabling threaded
> controllers on invalid domain cgroups.  We can lift that restriction
> but I personally can't see why that'd be clearly better.

So, I also can't see anything that seems harmful in the scenario I
described; it's just an odd inconsistency, and I supposed it was
unintended/overlooked behavior, and I wanted to alert you to it, in
case it seemed problematic. However, as long as you have no concerns,
I see no reason to change the existing behavior.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
