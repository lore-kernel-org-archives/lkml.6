Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B220661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547064328;
	bh=7NgPLKwMEIVcvf4RJn4PUcvEnCTMdPb69okC1TgMrTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oKwtCtmll0bXNK4sTg+cvwRsqzGjc17Ebi+qKZJsvjvveaVne8r0S5DPkitKc7zi5
	 wzD+ev6KtmYNLzeC3fe7yfrDdCjkT8IKhEtrTPjcgYQ0CKblXDjTF+IVWdYEFBS+tN
	 aJhUuW0HVA6n5CVhQrq0UiqohooSZ7ie2wINzjVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfAIUF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:05:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36484 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbfAIUF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:05:26 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so7043559ioh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7NgPLKwMEIVcvf4RJn4PUcvEnCTMdPb69okC1TgMrTI=;
        b=HhYDKzYzEsdfqKWlP3dInn6VSAS/KXBk3upG+DSHAelyI0BrpOABN5FdERORMQBbA+
         m0vCt4X8np2BnC4knjoufIHztgb2qIxAYy1JAHvYoUt32ls5IoAshMwx+JshxIiHtlTV
         fFSeBHVv5e7po0+OEGR1CPFxeQiL4QFIfdoIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7NgPLKwMEIVcvf4RJn4PUcvEnCTMdPb69okC1TgMrTI=;
        b=LtVxmzDGQFap9jfhOoei49Jc9Rxn0dgLdsyflvuLrH7oMn0nUPE9vMggJdkC+rBlN5
         J5CNlyJHj7gfyI1TPp40H+vtBXg1AuyuDTnHrExruormPb2FCBFRMyxxLLUh/6xF61og
         iVIoX1XCSsuW1KS4Yw0+26jo8zdtT+9Y/+KGr6C5aItQE468+sf5hGIs0Qr+Y8mO0n4u
         fnwx23zcQI/hvFF0AcI+2OCK5xq2nOdRkW+VRoYiB+JZU7aHD1j2klFRmplsinrtLRFh
         Rxip10ICosNAaSJdg1pdIDFeSXD48HnmsTK9ujhhnKP0pSfX1aHiykQUmtIPnFtmhxUN
         aG7g==
X-Gm-Message-State: AJcUukdVq5qH9UgksNn1+JpBZ3IEZi1aODW9RFI+g01mxcCIUQ2RGBAF
        ou9De7zD5nqylpBLdma0dafC9hLx5ddj2w==
X-Google-Smtp-Source: ALg8bN5jZt/WOB60lBkhY7ty7EHZukO6Bz76J2St9WuxC49U1nNKAWAiAARqPeOSqJIvlp/fP0B8vA==
X-Received: by 2002:a5d:9803:: with SMTP id a3mr5267923iol.203.1547064325823;
        Wed, 09 Jan 2019 12:05:25 -0800 (PST)
Received: from pure.paranoia.local ([198.144.156.49])
        by smtp.gmail.com with ESMTPSA id c41sm4977306itd.15.2019.01.09.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 12:05:25 -0800 (PST)
Date:   Wed, 9 Jan 2019 15:05:21 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pr-tracker-bot@kernel.org, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190109200521.GE30131@pure.paranoia.local>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
 <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:40:20AM -0800, Linus Torvalds wrote:
> Side note: I do wish people would use the proper _public_ access.

I'm wondering if this largely happens due to people's insteadOf rules.
We've established that git-request-pull will quietly substitute URLs in
the emails it generates if a matching insteadOf rule is found. I started
a discussion related to this on the git list, but it veered a bit
sideways:

https://public-inbox.org/git/20181115182826.GB25806@pure.paranoia.local/T/#u

> Maybe the pr-tracker-bot might even send the person who did a pull
> request a (private) notice that there is something odd when that isn't
> the case?

I'm not sure that would be very effective. Folks tend to ignore bots,
and with this one we're specifically recommending "add it to your ignore
list if you don't want notifications." I think an email from you for
such (rare) cases would be a better way to indicate that something in
the pull request needs to be changed.

-K

