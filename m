Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB56C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2604227E71
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/UEgrNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2604227E71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935787AbeF2L0W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:26:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40302 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934360AbeF2L0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:26:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id m15-v6so6996935edr.7;
        Fri, 29 Jun 2018 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DBhUT8oOwE4MS8/Zwj7a3Nfr66/LvWlCCqWifjKfwPk=;
        b=L/UEgrNnSLXzlyt4aI7fcu/42oBRXdfVFpWYyAL+Q5WFkeGACAIUrUq3h9QUGP80pJ
         IrQ6g1Do2CS/ThH9N6KkQBtn8YQyHWe8FgVc2NxJRJnmSLegzrtae8a2oSnd2HtV/pE9
         WOXYNYY1FdlHlTtFIgsrEDrbBSF0GVO5C8oHfL461VwoPq0t9XHx14dHM8qSk3s/Z/1D
         TzyrbOQ+j+AbhCfWHXUKxhs9vLWFQ51kuyP2HdFkMcaqA20dj/XvJkU/j5Wkh6itQQ9Q
         Z5wEYTD+ZEdEPIhWuYzhEgXdv4gw7CpDLhFw/nOI8/DcS48VB7jScDLDgaEdjfr+p1Zd
         nPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DBhUT8oOwE4MS8/Zwj7a3Nfr66/LvWlCCqWifjKfwPk=;
        b=XlFINgX0W4mlMhLIpPwNsw5nUz6umSQtMxL3RTTW6sXJYcPR+gPIXlfKWhqCjJPGiL
         v3yW9DraeyXoKmibaqRPwBHvBjmOWgaRwj+avbgZpu4RehN7XUyCsjl82O5XSW1jEOaH
         Q11zZRjUZCQ/bOflCHp3COiO7XMlyjogke+A0b7i1NglVymUim0mO3Zs+dHMM2xsS8uv
         ayoCBeKAzJGIaNX8GovwwgcDiR/O20uKoscV3nnzWnqx6KXtKnp630zqZpIF454YsqYl
         W4xwwSMFLtsVoPFjsRiN0PCVjOJcpB4rr+9yj/t5/TB4lXD2oXxJ9b9kJq8C8u4vApsx
         M3Iw==
X-Gm-Message-State: APt69E0csWubEMciMYl9aY/J/i05ca9GE4koamIVoBpQaN6o6Ikt2Nf7
        6i8gMEuLwAAq20n4WlDT32Y=
X-Google-Smtp-Source: AAOMgpcwUIKcIeCCRrJ+e+iWDx7dAI1/bAwGhzVVCN0OwKNjAxYOokSVrUNTAwVyDj1gLixqtWZ/gw==
X-Received: by 2002:a50:f145:: with SMTP id z5-v6mr8179207edl.0.1530271576865;
        Fri, 29 Jun 2018 04:26:16 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:40dc:3d00:492a:47d8:a37d:72e0])
        by smtp.gmail.com with ESMTPSA id b8-v6sm562708edd.13.2018.06.29.04.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 04:26:16 -0700 (PDT)
Date:   Fri, 29 Jun 2018 13:26:14 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Lawrence <paullawrence@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Christoph Lameter <cl@linux.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-sparse@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        smatch@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Message-ID: <20180629112613.7i4xesjyxolc63gu@ltop.local>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110419.GC26019@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629110419.GC26019@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:04:22PM +0100, Dave Martin wrote:
> 
> Can sparse be hacked to identify pointer subtractions where the pointers
> are cannot be statically proved to point into the same allocation?

sparse only see the (deatils of) the function it analyses and all
visible declarations, nothing more.

It would be more a job for smatch which do global analysis.
But to identify such subtractions yu must already have a (good)
pointer alias analysis which I don't think smatch do (but I can
be wrong, Dan & smatch's ml added in CC).

-- Luc Van Oostenryck
