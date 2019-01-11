Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3183320874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWXRdCZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfAKJwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:52:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39641 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbfAKJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:52:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so10376815lfh.6;
        Fri, 11 Jan 2019 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIQwehbPrlY7BUP6CB2B8k1PMAjTFQv50MV82hxeWcg=;
        b=tWXRdCZ2D6dwuoxQCh+RSNF1sdTWe5eu6rGt1gdnelgAg+UpYdmuyd3uGqpm/xKggV
         FwkYDfUC3iYLJORA37eEHgCPFduhyuXXTQgVWPGJ2RyG3pXAH8b9xci8KhOf2ycb7085
         lYuzmfoke1FcGvVNSA1rJGdieywkiZ0Wix8XOBIy5kPlUilOpOYrEeLDU5bVE8eM2+dq
         J8RWKsmM43a0R1dwLBx+ds+qwbfYWyyCNLs37LcrgFEXSg82lJqu8N2bJLTILEIfZww8
         mLccx6gmDpiy3wSlc6DGHhDcgwK1ePCMqksJWB8fm4zvVUh6XQngVmjgmCTMAtxb0k2l
         ldng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIQwehbPrlY7BUP6CB2B8k1PMAjTFQv50MV82hxeWcg=;
        b=DNgfrPxcYYHJXv6NaKbTAF/dWU16V5gUbTz0o0+vFsfbCzii9fiS1G+JXwLeGAJL8T
         SMTj/coCl0Ls/9gQGE/Q6FV5hhNEaV6EEMgogfQjtXueymqMVzem0daKRzHoP3SUN+ft
         tMaV7CmyDJJPpREyoyPfjtbIq92vcxSz+HVHOFNCA8/AAj7fllXPZ86sPZ7iU6aMfyfM
         58L46ZNO4MDDuTZ0LPQD0vPIpj7lHXtv+L+esuhvyp6dLgMiDVOukdvarPFGufO4+Ns6
         Vyoghn5EIDxOkHjUOX38NpBVMvnqcCDR7OhsNSGee+nBMeUZ+33ti9XAxXtdUejU/gx7
         de9A==
X-Gm-Message-State: AJcUukcInNv+hixeun9ZUS1zDHnvQGKDSKQ6hPBl3XQlYd9YyrO8PibL
        kp5k9QICw5u6ihoZQ7YobKkqnLHZn93rph9twQk=
X-Google-Smtp-Source: ALg8bN6zxUtJLmjmXaPX9LtyOP/4mys2mrMhfZc1+Cnkq876ds7Ktqb1cVBb8nfdZ4ageNNFRJlSkawQaiB4XK5g/xM=
X-Received: by 2002:a19:6514:: with SMTP id z20mr5734838lfb.31.1547200328069;
 Fri, 11 Jan 2019 01:52:08 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZt=Q4b_tn_vDx3g1ap7GNrXsHQk7Jki1T+zPbqVot90jg@mail.gmail.com>
 <CANn89iLkciYGn7GyKc2QitSjjTms58_GKFqjOJ=6G8wEFi=SJA@mail.gmail.com>
 <CAA85sZvciuNTc1NM1XbbBCqV-hWwjMZM+0i3vigtzmJ8CpPjHg@mail.gmail.com>
 <351f5da149072c8c1165f8f205ac5c852a92dff8.camel@redhat.com> <CANn89i+h4Og42OKaqJ8dsrupHkt2Lg1vPo-j92Bos98yPJzoNw@mail.gmail.com>
In-Reply-To: <CANn89i+h4Og42OKaqJ8dsrupHkt2Lg1vPo-j92Bos98yPJzoNw@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 11 Jan 2019 10:51:56 +0100
Message-ID: <CAA85sZt3NBKgebX_Bdwbz7QH--W6zb3w3-qoxRHpcHMuSYzPZw@mail.gmail.com>
Subject: Re: [BUG] moving fq back to clock monotonic breaks my setup
To:     Eric Dumazet <edumazet@google.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:35 AM Eric Dumazet <edumazet@google.com> wrote:
> On Thu, Jan 10, 2019 at 12:55 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > On Thu, 2019-01-10 at 09:25 +0100, Ian Kumlien wrote:
>
>
> > > This works, and so does: https://marc.info/?l=linux-netdev&m=154696956604748&w=2
> > >
> > > Pointed out by Paolo (tested both separately)
> >
> > Note: I cleared the tstamp in br_forward_finish() instead of
> > br_dev_queue_push_xmit() because I think the latter could be called
> > also in the local xmit path, via br_nf_post_routing.
> >
> > We must preserve the tstamp in output path, right?
> >
>
>  I was not aware of your patch, SGTM, thanks.

And you can add Tested-by: ian.kumlien@gmail.com
