Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1071CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A280C21920
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TsByXDkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A280C21920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeHGGbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:31:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54599 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeHGGbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:31:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so15846858wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=43CNGiPZtu99U1ecdNIeWNs0LuGM6YdsZalTPRLmOnU=;
        b=TsByXDkqOAqHmO+pmGLBOe3GcQCOmbkDERgn02p3kkgEz7Uz8vLl05TnJDu0LjT/HT
         +crRXjng2Or4NSTkjOPEFIOgih5mVsOzkKqELM3h9AiMguVhUjnggRUmfqNKcGTsytuk
         6yXA/seWhFSOVF3judVWGJ+0gPIP6K508RmWpq5Md3BAHh4se2kH+w1Vz/q7y5tgKCZF
         dOO9qPFyG/JvAOKpzEKgYmY6I25a2TDDE/8qW5gDuyy63Uy1rOfoLwNAwODveSBRK3eK
         WWACQ6xqo3AN/f0MIvbPpjA/CCY2ZK2jPFK6ry1fdznjTKJBWmf9Ah72RDCEuRlS8LSI
         PAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=43CNGiPZtu99U1ecdNIeWNs0LuGM6YdsZalTPRLmOnU=;
        b=O9fUEiuRodWySYLkRJEm9efFFKGZ0lE+3/bq99+UXyLfo0UOQxupEZf9Mz44ekBtB5
         PeCOvNMynCy3s0FVwIN75g5euIcqLDTwg+T0HCJ/1jt40pHE+bKM6iJBL7XZkepXRr9W
         ui1fBSzQ6feXyK6tu6tKY6s7oDgVLXwbsZ+0Wo8gcrFMdK6c7ZPDAK3lwHgz0gFPU/CP
         oVweu/0kIiH0vKMTfBEescaJf4qyRU9g8OpdKXmkZilpZXx8DXfDsekdk32n8ibX7rvd
         De1LY0nxQJqIXa/zMdLhtQU35ePjdq9409PNTPYfYszTcW6sgqyu53gZF3FFJyVMspS+
         19BA==
X-Gm-Message-State: AOUpUlGr6gzLbLTv4QkErwtn2lp2GlxGaMKsqdkAWz7BpdXBdN1ftt0R
        ZoRbNbW/QZZTKnCSzh5gU3DwV03R/GpfrZP65tyK1w==
X-Google-Smtp-Source: AA+uWPzjqggtAirTaYiedTtJWY8PPx/f/h5tjlYzeb9d6r4r3PTf4HqkPDrGblryBMFel9s5LCTQWGs+OSj3P0SiuXI=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr446389wmd.46.1533615565156;
 Mon, 06 Aug 2018 21:19:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 21:19:04 -0700 (PDT)
In-Reply-To: <20180807033043.2esvm5qbhhqvatvy@mailbox.org>
References: <20180621220416.5412-1-tycho@tycho.ws> <20180807024442.GA12274@cisco.lan>
 <20180807033043.2esvm5qbhhqvatvy@mailbox.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 6 Aug 2018 21:19:04 -0700
Message-ID: <CALCETrVR9r4QsKtwK_+tO7V33G+4r4rkB652rq1A1K2XJvTNrQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] seccomp trap to userspace
To:     Christian Brauner <christian@brauner.io>
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 8:30 PM, Christian Brauner <christian@brauner.io> wrote:
> On Mon, Aug 06, 2018 at 08:44:42PM -0600, Tycho Andersen wrote:
>> Hi all,
>>
>> Dinesh Subhraveti has claimed that some part of this series might be
>> patented. While he has not furnished me with anything to confirm this
>> claim, I'll put this series on hold.
>
> Hey man,
>
> Sorry to hear that your faced with such nonsense, Tycho. This is utter
> bullsh*t of course. If you have more details at some point and feel
> comfortable doing so it would probably be good to share them here.

IANAL, but I think it would probably *not* be good to share them here.
Patent law is seriously fucked up like that.

--Andy
