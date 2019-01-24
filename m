Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9F0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA39217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sempervictus-com.20150623.gappssmtp.com header.i=@sempervictus-com.20150623.gappssmtp.com header.b="mYkCa61B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfAXUTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:19:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40074 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbfAXUTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:19:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so6409560lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sempervictus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kqLTHpGTg26EbzlDb5ZAMlzfyHR1I/Ps2bSboMJPg0=;
        b=mYkCa61BgzRBhykCcV8+ku6kUrC6GlK8WfO5YxrUvhdpBhzIwupE1gfWU3edgksiM5
         dThjInYtHiy8f2a/uRwrdFZ8mChL0xAqk4ZFHkdbb7jBNtHkzkRP1Yfl+nLGhN5e7GJx
         lSFh2SdwIhhCbnaihWjT13J3bDKOfAwn7NIpCMQQxNcolZ5/G0Tf4H+UAYJRKDo4GUmV
         oZ/W7vPTb+h/cl16w3KxQ5K0NWhh30SgdXTyhktnkwlpQr84dLUJbRnWh2m9FGKK+sl/
         i4WsUtpopqju8Qv+w0cfv8/OEime/6sqPSv9t8kwKVsv+lTl4+QbfbORKKQkWlzQnIBj
         fjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kqLTHpGTg26EbzlDb5ZAMlzfyHR1I/Ps2bSboMJPg0=;
        b=eDRe7VGjve1qmnUqXDBDIi9M+T9zOLA01XCywi4JfUxFhUu7AIzBRbrdQwqOvtzIIm
         sy27xOV86scgqyQwoB6aKqzRgndSRyCGrvvn90GDCkpotK/uCkJcPylFnQg018pUw8+5
         VmC+LNiZTVJ1vjRlyHsQ5F48ldJoSiVq8vXtcplmXB1+gjBb4SNsMVVTW8B0fimTUCla
         OTygRslV3wrna3RgUQ6BwALO1T7ksX26+cslon51BJLmvueHP/6lgs5AUcCKnBHgCelq
         g0RvHdp01j1zFUUTphNJ+b5PgwwU4ct54X3YhsW84WrI3CAc5ZNxRtWJM1E1JdjgRRty
         KPHg==
X-Gm-Message-State: AJcUukdj4BeChsQbeIXDp9eUp6VWtGVH9W/qMi7BOVQN9TqGd29NO+ED
        A8+FyVKCo2teAUnpsNrUv4sWN4sf/jXI/x0daak4kGXi
X-Google-Smtp-Source: ALg8bN6+HnYqOZvNtLML9+Wu0RDcH/qoydcqMYcSrSh4pSoMTJ4Vb8Ac63ZIDjPtzRNW1HCOZeQqmG3RbRyd7+Z8TH4=
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr6569600lja.44.1548361139683;
 Thu, 24 Jan 2019 12:18:59 -0800 (PST)
MIME-Version: 1.0
References: <7bdd68b2223ea30da821b37a68d940a7@redchan.it>
In-Reply-To: <7bdd68b2223ea30da821b37a68d940a7@redchan.it>
From:   Boris Lukashev <blukashev@sempervictus.com>
Date:   Thu, 24 Jan 2019 15:18:48 -0500
Message-ID: <CAFUG7Ce87ALJNgOSY5SZYFy4YWnOLdGx_+L-M+BTERBToD9GbQ@mail.gmail.com>
Subject: Re: GRSec is vital to Linux security
To:     linuxgpletc@redchan.it
Cc:     Ivan Ivanov <qmastery16@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sue to what end? Force them to freely distribute their work/give up
all those hours of backports/integration and actual invention? The
only thing a suit could achieve is to prevent them from doing any work
at all as you cant force someone to work for free (in the US, under
most circumstances). No contributor will be able to prove quantifiable
material damages, and the outcomes are between destruction of the only
Linux vendor who puts priority on security or a waste of money and
time in the lawsuit. Only the lawyers benefit, everyone else loses out
directly or indirectly. Are you a lawyer, acting on behalf of someone
interested in slowing the progress of defensive technologies, or just
miss the days when being as script kiddie made people feel powerful?

On Thu, Jan 24, 2019 at 11:54 AM <linuxgpletc@redchan.it> wrote:
>
> There is ample standing to sue. GRSec made it's "access agreement"
> public,
> which included terms to prevent redistribution (if you redistribute, we
> punish you). Which is a direct violation of the "no additional
> restrictive terms"
> clause in the GPL.
>
> Why won't anyone bring a copyright lawsuit?
>
> Are they happy that GRSec gets to use their code, and prevent anyone
> from
> freeing the derivative work? The whole point of the GPL is that
> derivative
> works be under the same terms.
>
> Bradly Spengler has violated this understanding, he thinks that his code
> doesn't need to be under the same terms. The code which is simply a
> derivative work of the linux kernel.
>
> There is a valid, actionable case here.
>
> Any of the programmers / copyright owners who's code he modified can sue
> him.
> He is violating their terms of use of their software.
> He is in the USA. It's not difficult. Just SUE.
>
> Just because VMWare does things one doesn't like doesn't mean you cannot
> sue
> Bradly Spengler.
>
> Another thing is, the "Free software" legal "representation" is trash.
> The SFConservancy was run for the longest time by a non-lawyer BKuhn.
>
> He advised "clients" to WAIT it out! And then.. guess what they have
> waiting years?
> No case because the statute of limitations had been passed.
>
> That's how that baby-faced moron has "helped" the free software legal
> cause.
>
> You guys need to hire real IP lawyers, not bullshit pretenders.
> And if Bradly is making money, and enough of it, you might have profits
> you could target.
>
> I kinda think that the "Free software legal" teams exist only to diffuse
> valid suits,
> and stymie the guys who actually wrote the code and retained their
> copyrights.
>
> Pure legal malpractice by any accounting.
>
> On 2019-01-24 16:25, Boris Lukashev wrote:
> > You've never heard of VMware, I take it? Its a proprietary half Linux
> > which beats GPL suits with strong arm tactics and technicalities.
> > Unlike grsec, they don't distribute any source, because it's proof of
> > theft... Grsecs back port work is also public, since they're public
> > upstream patches or mailing list patches, the GCC plugins are the real
> > magic... Those aren't as GPL as the kernel, rap is patented, respectre
> > likely will be as well. The critical code changes they need (per CPU
> > PGD, for one) will not be accepted as Linus has "said so." Those code
> > bits are out there...
> >
> > Also, doesn't matter if their patch leaks for the most part (4.4 just
> > did get leaked a few weeks back), as I wrote before, nobody really has
> > the time or skill available to maintain at their level of quality...
> > Linux might be free, but it's not something that should be run in
> > production when there's data or resource at stake.
> >
> > Is the thought process that they should open up their commercial
> > stable code for free to all? Because RHEL has the same "don't leak"
> > policy on RHEL sources too... VMware even goes so far as to blatantly
> > claim not to use Linux. How about Google's internal Linux?
> >
> > GPL is dead (has been for 20y), build the strongest defenses you can
> > with whatever code you can get and prove, because your adversaries
> > won't care about which license clause their tooling adheres to.
> >
> > Boris Lukashev
> > Systems Architect
> > Semper Victus
> >
> > -------- Original Message --------
> > From: linuxgpletc@redchan.it
> > Sent: Wednesday, January 23, 2019 05:35 PM
> > To: bruce@perens.com
> > Subject: Re: GRSec is vital to Linux security
> > CC:
> > moglen@columbia.edu,bkuhn@sfconservancy.org,compliance@sfconservancy.org,blukashev@sempervictus.com,tcallawa@redhat.com,torvalds@osdl.org



-- 
Boris Lukashev
Systems Architect
Semper Victus
