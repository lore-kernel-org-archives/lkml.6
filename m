Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7098C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD43F2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="feaR/4d4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD43F2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeJDXiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:38:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42554 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:38:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id h26-v6so9828564otl.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCiFnp1gzATU0vriSJeSPH4fGwtIksN5eiOG5C3mWMY=;
        b=feaR/4d4WSdOW9KyLZFwRrzm2ppBfwaLEkopYS37hyuZtFziht+GjHy0shaVryqa4W
         K6TjH5JiQY3ruepJoFYpd6EFUVphrOyTgHeIQebOoWkar7juN/fV40zW9PLV+fDSiV9K
         bUZKvC8i+N7vbeayMdBpOwtvYGvn8MbZ/OvttSlfhipb/Z1pz5eM5Hy4ImHmsi0bKS3E
         YnxxhoX/hnXHZP1HngxwDog4WgDkbfPWPYQM145Z0QZ3mQp90G7PnPxYL0Ob4G2Li5n8
         y4At+Ee2bZpSgYAmhTyx+XHph33sEBTTgooxw/hJXHXKwjAjOw1k3ha3muGG81g2BCHS
         2UEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCiFnp1gzATU0vriSJeSPH4fGwtIksN5eiOG5C3mWMY=;
        b=mkmF20cfUCI0+5DBj2mcLhJ13jMK5CE0NZG1OrSE/Q4nh0EuI6iAD3EH5RICY9n3GB
         +B0xVx3tC6JhnyzNhQRqKMjv9FKD1u3SIbPkmjxvEjU8kqrYX+HjOuiZs1kc5TmhlmTG
         DbtZ5V9tbHUM4JopzrBtFuFnHqaXFzXfAY7pA6wB4ZIcb0SFJjTf3cZsx241d3q5RDpm
         YWzs5pBauUP3m7BRB9ffZKCE4me5zz+fYLQEx6xYKZZKE20iRKW4n+nwcWRnYmmxJKK/
         GIun3UELZFxT5Fm8kxRRy4X3rduQosKCbwBplRQnBVVnhNekk6SA77jWfxVJrnbBVD7j
         SgJA==
X-Gm-Message-State: ABuFfojMcWunWASHxjOiBZA0g2fECKVvg8H4WBpYC0EvGNO3X6MAftHP
        Y2Icw67ut9F5qt7fhOAJKU4cazG/F2sMtabSlw9Bcg==
X-Google-Smtp-Source: ACcGV61hAos/9cPzjCYN1IY/IF7mynO7qJbYDHN4nSIy9I5hhMHRYXX/vgSBKkmQBAjKqRT1N6kJT4k4doMmu7IC+yI=
X-Received: by 2002:a9d:530c:: with SMTP id g12-v6mr4050004oth.353.1538671486292;
 Thu, 04 Oct 2018 09:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181004074457.GD22173@dhcp22.suse.cz>
In-Reply-To: <20181004074457.GD22173@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Oct 2018 09:44:35 -0700
Message-ID: <CAPcyv4ht=ueiZwPTWuY5Y4y1BUOi_z+pHMjfoiXG+Bjd-h55jA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Randomize free memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Oct 4, 2018 at 12:53 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 03-10-18 19:15:18, Dan Williams wrote:
> > Changes since v1:
> > * Add support for shuffling hot-added memory (Andrew)
> > * Update cover letter and commit message to clarify the performance impact
> >   and relevance to future platforms
>
> I believe this hasn't addressed my questions in
> http://lkml.kernel.org/r/20181002143015.GX18290@dhcp22.suse.cz. Namely
> "
> It is the more general idea that I am not really sure about. First of
> all. Does it make _any_ sense to randomize 4MB blocks by default? Why
> cannot we simply have it disabled?

I'm not aware of any CVE that this would directly preclude, but that
said the entropy injected at 4MB boundaries raises the bar on heap
attacks. Environments that want more can adjust that with the boot
parameter. Given the potential benefits I think it would only make
sense to default disable it if there was a significant runtime impact,
from what I have seen there isn't.

> Then and more concerning question is,
> does it even make sense to have this randomization applied to higher
> orders than 0? Attacker might fragment the memory and keep recycling the
> lowest order and get the predictable behavior that we have right now.

Certainly I expect there are attacks that can operate within a 4MB
window, as I expect there are attacks that could operate within a 4K
window that would need sub-page randomization to deter. In fact I
believe that is the motivation for CONFIG_SLAB_FREELIST_RANDOM.
Combining that with page allocator randomization makes the kernel less
predictable.

Is that enough justification for this patch on its own? It's
debatable. Combine that though with the wider availability of
platforms with memory-side-cache and I think it's a reasonable default
behavior for the kernel to deploy.
