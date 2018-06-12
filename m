Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1D8B1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DB32086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hh0mWbEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DB32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933838AbeFLRnM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:43:12 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:42732 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbeFLRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:43:10 -0400
Received: by mail-io0-f178.google.com with SMTP id r24-v6so346608ioh.9;
        Tue, 12 Jun 2018 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJerA/g7j/eT4ia97YQ6w8r2SThKDt/btDybPoDy6DE=;
        b=hh0mWbElUnj1TMAyXX8X3vr9YDfRGJlBbKZ7CQ46dTqMvI3VocEySTwkhkicR1rg8Z
         OMmpTaKceilwEzvMIvhQAd+ZCLFjUkHkEavCIjv4pXUpq0nqTm7KrSrHM3BPbUthW9UP
         kaLJ6m2EWzxeif6joMswxAGmmWhbt5lgnVDQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJerA/g7j/eT4ia97YQ6w8r2SThKDt/btDybPoDy6DE=;
        b=exN10qDDvXSvGh3lQDYlWD7z/mEIjY+0P3pfcjv0a/4ssBWh74P2kJ9z6aKOSNxSg/
         YOZz26yS0mptpGUCktKcPjFRxr7CeCeGD60imb/nd8kCwmPZaV9tqYuX+k3yE3z6zb2g
         So2QD/ipAoSI2CBub+lpHGuuOKOD9ZMaAEWFnW+GeJB5kIbbR+6VWleUDaSDlVTQMAsu
         /sLDaH6HB/z+btjecL0MmweSxAIcPLV1BOBHBLcS+6/LnUpwXuhTFEK5oOXIvGgLp9cb
         S9Ud0tQrA/VtMOITlnIo7usAHhktBzV7eIwjeG4NIFrDXBHb+an8Fv7af63iIZOV5yAq
         XCPA==
X-Gm-Message-State: APt69E2ia2fq4DkqObGDpOdfq7g8Pa8Hl+LSNCidLX9GfEwNRDThP3E3
        LwGUnRSeSja6tg9GgXMkcT6DQM1DGDZwRDgWwf4=
X-Google-Smtp-Source: ADUXVKJGfpnm9HjjD01u6LZr8YEeQYwbipMeQTwv230dJNu6B5alyljMO5QOg3YgCkfDuo0F8h+lmKG8EkmNju7hy1Q=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr1488772ion.259.1528825389715;
 Tue, 12 Jun 2018 10:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <e5c90488937d14e9df81752a024be9d1e73ed398.camel@hammerspace.com>
In-Reply-To: <e5c90488937d14e9df81752a024be9d1e73ed398.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 10:42:58 -0700
Message-ID: <CA+55aFxYMg+F9Jdi_25X-Qtt=7imqjQhLnjEyQXOQ6+eJvy83A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 4.18
To:     trondmy@hammerspace.com, NeilBrown <neilb@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 6:39 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> NeilBrown (4):
>       rculist: add list_for_each_entry_from_rcu()

Oh christ, people. Not another one of these.

We need to start having a real rule in place where people DO NOT PLAY
GAMES WITH RCU LISTS.

Adding Paul McKenney to the list, since he clearly wasn't for the
actual development, and the commit has no sign that it was sanity
checked.

This whole "let's re-start RCU walking in the middle after we've
dropped the RCU read lock" needs a hell of a lot more thought than
people seem to actually be giving it.

Maybe the code is actually correct - it looks ok to me. But every time
I see it I just shudder.

What people actually want is to just have a cursor entry in an RCU
list. I'd much rather have *that*, than have people make up these
insane ad-hoc cursor entries that are insane and have horrible
semantics.

For example, looking at that commit e04bbf6b1bbe ("NFS: Avoid
quadratic search when freeing delegations"), it even talks about the
ad-hoc cursor entry not actually being reliable, and how that's ok
because the code doesn't care. No, random odd behavior that is
basically never ever going to be testable is *NOT* ok.

So could we please have a cursor entry for RCU walking, and actually
have a agreed-upon way to do this? Maybe even using the low bit in the
"next" field to mark a cursor entry generically - the same way we
already do for the HEAD field in the bit-locked lists, just on the
actual entries _on_ the list instead.

Because we now have *two* of these odd special "restart the loop in
the middle" come in during the same merge window. That really implies
to me that we should have a _proper_ solution for the problem, not
this horribly nasty case where people make up their own pseudo-cursors
that have odd and questionable semantics.

Paul, comments?

                 Linus
