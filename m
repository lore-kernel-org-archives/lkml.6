Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D3C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9813F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdJAAms1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9813F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbeGKQxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:53:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36219 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387704AbeGKQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:53:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so18773042pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oe1OEp+mUmKx93KG7Ohlhk9Jj9BeVzPeaUnmfodeKF4=;
        b=gdJAAms143g9vxXj9lzkkiJvuthXH7XxOvHT0swD0rFIyggalA+dRZAg6NdvfrEHjr
         leV/56q2BL3vUQNo9WE8Li8Re02xB2aov2+y6SE+nqcRwpVB+7eHLeKMHtTBNkkGoTK9
         lSq+NVfTxTmzDV8mRjTHtHBzPZk17Hp1hmngiSUJiM0zaWYLQ/ESMoFjmX+qPzXox86V
         DXyz7kJwgv8quT91U+jROREqO69LFiyZ52CaRBSoeWfgcDS+fUoioBSWHfi/MI7Lfxwg
         y32olTBSZBH0njY5Wl/z7hgMCOhXO2H5MaRzByl5teImfDAvGlPGaGCLZ3ffth0+0FYY
         BToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oe1OEp+mUmKx93KG7Ohlhk9Jj9BeVzPeaUnmfodeKF4=;
        b=g71lqRfT831gOwH+v/92vZtpIxugdsTbT5Du/k8yeT78YnWGsDlTZDCtUlvyAgNiBQ
         poCdfe6q7S1H/VesUyvtzExRqnJX+GkZ/A1H6rp+S9/tzficoPMifIqqyqcEfZADI5cv
         uUKpO5HC+3oU72qzvwMV+G8hEi0MWJVIvG7D0ijWwNn1MoqGvfNeZwVtOazRvf5EVBXi
         evgbywDo3yGpLipxd6OrWtc2bxtitdgTLoW7SP2MkVwFSnLWFuWZrLJ2DOkdPRUEkBbA
         OAIy4DiG8f3hizhbHCXDJysAerIVb3GgyYmvnmYYQ59AgHM5XtaWdVPAp6a/8nRC/Z7l
         Rmfw==
X-Gm-Message-State: APt69E1bXXzcWSwO+KN0cSOUbRvV6EGenneb+2dKtPf7z3KK2PW1bVsa
        cFoD2JMj1aA1nuFOhIPrSn1fxspxi/OfPKqdZlwaFA==
X-Google-Smtp-Source: AAOMgpfMSWUZa5B0HRjLkk8GB3oW1j731wtxxHbx8vrPofbVinZlVH3gpPeO8tcoMYqnmvzrrQsjgeLIf0pNjpaQ/bo=
X-Received: by 2002:a62:b612:: with SMTP id j18-v6mr31025833pff.199.1531327681375;
 Wed, 11 Jul 2018 09:48:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:950a:0:0:0:0 with HTTP; Wed, 11 Jul 2018 09:47:40
 -0700 (PDT)
In-Reply-To: <CA+55aFz1GVHUGiX1SE_5C-e9LdXdx3pBB10zwga1LOy6axk5Ww@mail.gmail.com>
References: <000000000000c242e90570aa0062@google.com> <CA+55aFyEZR=v2GySzWWF3uh9ZB53CFFv460Wzg4n8DGze8GFfw@mail.gmail.com>
 <CACT4Y+bOJx+SnkMqzDDUTU1iztQ7DpMBG7Z-oV5wArRaSEzh+Q@mail.gmail.com> <CA+55aFz1GVHUGiX1SE_5C-e9LdXdx3pBB10zwga1LOy6axk5Ww@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Jul 2018 18:47:40 +0200
Message-ID: <CACT4Y+bvGNmjP+3z3uzm=SvnngkbtEx-JeT6iVWg4gwYvoKyLQ@mail.gmail.com>
Subject: Re: general protection fault in in_aton
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot+2a831e062bb4aebd8755@syzkaller.appspotmail.com,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jul 10, 2018 at 12:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> Is it really hard to get fault address? I know that userspace
>> generally receives fault address in siginfo.
>
> For an actual page fault it's trivial.
>
> However, for invalid addresses (aka "non-canonical"), you don't even
> get a page fault, you get a GP like in this case. And then the actual
> address is not available.


I see. Then I don't have any great ideas. Running without KASAN would
result in more, much more cryptic crashes.

FWIW for these "GPF could be caused by NULL-ptr deref" I first just
assume that it's in fact a NULL deref. And in this case it all pretty
quickly forms a consistent picture that it's indeed just a missing a
NULL pointer check. That dffffc0000000000 in a register also a good
hint.
