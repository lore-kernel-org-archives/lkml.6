Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0E6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234E72080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544717505;
	bh=K5BuJdy3X9Jtl78y51KoKfjSj2E0lZWK9AgYGx3jLQ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=T/ZCB/fgXfFw3xiXn5xyFbFdZ1+MZoxyeGlKyBCEQCw4Oe/UAOuCPTXrOFXHc7aFo
	 ErCSg5Nq5aKXjwPU289o+XFao9COSxWlAgL75oPDfOdVyKdIDWjL7wczjZpfFKq3pP
	 aOsv2iJCVJBnejw1OtKNxpQsaAG0bmf3TaB7QU7k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234E72080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeLMQLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:11:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37070 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeLMQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:11:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so2158911wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 08:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bWe2GlWkZ05R9zY+5kGDQMOsEMaoz6NEHxgULeJRw4M=;
        b=bzSGjVZ0UDtKefdG20aynyiJuMKGClPgsOQYZgKPCiMNfTIXIoR2QaWa/QwhitNnty
         a8dR1QqoCZD2ydNjj0EN6S5NFyURxap19yH16MGrSY76HWVkswfNReTQ5+pi05ncNbWv
         pcQzhR0fomg6ogTr/HVso0Zd4DUzDhI1TEyX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bWe2GlWkZ05R9zY+5kGDQMOsEMaoz6NEHxgULeJRw4M=;
        b=eRBbzEBRgS0k8C+7alNy6VC1J9Lh2o9n6gtiyj4HKRQvokKHQFYeJeb9cI87R/Y5Qt
         aPEJH0BQhhQtttARW2DN1S3uHLxNm1V4cCr4AdO/F14xxvjwIZwY9BQBxK8xbzJwKocg
         7pEYXCjm6B6+JSOtKDj7npA7GvD46DJ2YyKZ1C5HPJsfUIvhfulzpAotIuQ41zCZCBGO
         3UaOMT6eBbcoqDA3EORAdl9038MY+7OiCmmO97InBWD5YczQDGyLccD8NOXyZoDg69Ef
         mOaJaDsTWbCoIcowSKeFwFhchn6ziiQ9WQM1AzKJ3EES1BtHETS0zeIu/T34iBPBzeTR
         Y9xA==
X-Gm-Message-State: AA+aEWaAiY1KvZuIVFZT2u/5FoH1Zua+zSBP40vDzAGEyPXbmhC2V/4j
        Q0vN/mtBYSebYEiqml5DbRMm6VazYp2niAoo
X-Google-Smtp-Source: AFSGD/WsiU0KU5jtg6uLM1DvrxXsNZWOrRSJCtpSpt878LTi9KaAAQMZFQdAnKsRMppV2vgKl8hwTw==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr20926575wrw.211.1544717501902;
        Thu, 13 Dec 2018 08:11:41 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id e16sm2956487wrn.72.2018.12.13.08.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 08:11:40 -0800 (PST)
Message-ID: <1bcacee85afc8e4864be6c9a4a7fcc52511b41bd.camel@linuxfoundation.org>
Subject: Re: Can we drop upstream Linux x32 support?
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, bp@alien8.de,
        fweimer@redhat.com, vapier@gentoo.org, hjl.tools@gmail.com,
        dalias@libc.org, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Date:   Thu, 13 Dec 2018 16:11:39 +0000
In-Reply-To: <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
         <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 17:40 -0800, Linus Torvalds wrote:
> On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org>
> wrote:
> > I'm seriously considering sending a patch to remove x32 support
> > from
> > upstream Linux.  Here are some problems with it:
> 
> I talked to Arnd (I think - we were talking about all the crazy
> ABI's,
> but maybe it was with somebody else) about exactly this in Edinburgh.
> 
> Apparently the main real use case is for extreme benchmarking. It's
> the only use-case where the complexity of maintaining a whole
> development environment and distro is worth it, it seems. Apparently
> a
> number of Spec submissions have been done with the x32 model.
> 
> I'm not opposed to trying to sunset the support, but let's see who
> complains..

FWIW, the Yocto Project has working x32 support which it regularly
builds, tests and has as a supported configuration. We did help
identify and fix many of the places userspace didn't support it.

As with open source in general, its hard to know how many people are
actually using it. I don't think there are huge numbers but we do
occasionally get bug reports.

Cheers,

Richard

