Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE17223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USn7PyKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE17223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbeKOWOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:14:45 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40384 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387706AbeKOWOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:14:44 -0500
Received: by mail-it1-f196.google.com with SMTP id e11so28867856itl.5;
        Thu, 15 Nov 2018 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SC0iu5+qvyM6BTQbbF+F86byESvB1HjyehgnpM0EmZU=;
        b=USn7PyKQ7WKKQ9MU7i1CFvYRkWZjGZdApBCPQ4La7ts7e3P6gRe8POQqu5oxYTSNgv
         9R7Km4tCmRrekkS9ghPXmbM0yn6qJh5ToZeJ52J3KElZRqa97ZiogQnuRlpyjQuacGGN
         MBTF2wW5s7QE8dSw2cMJ36UF3rnl7HnuzJeF9gBTEOLaDcf2YGndRETFngAqc1R7xaO9
         4VYdQH8IAVrLB8nqId6vqId9Kklt1ic56caa8liSAjaIpc69AmY1tl949yONA2fNBLJQ
         LhxVQM6o/VA9yTbTQYI6DDwIFdHWTZQA+D79mQ+DbXhR4aVfgghlUPWejggbifMhoPM8
         GJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SC0iu5+qvyM6BTQbbF+F86byESvB1HjyehgnpM0EmZU=;
        b=GFR5o2qw79O+kEVXiDpMmGs4oE/qdg0f/FYE8ibFdu5KEqPvJ26nbLn5Q23+nlHaXs
         bJ/28/N189aD6TwayWWJsLMH0AOa9PwFmaNTak1RLHSvoWqAWw4ygFWdkFQtw8szQ0NI
         FwPMS2AjNELcyKVKWAwHHwrj0mS/aQIyUKYh2f1P4LaFNUC1BQuF8ZKslWpGOEmX2Pc0
         mJFj+P9DhqBuhrKXpANsoOWSFdTxg9+F+Aroj9CuY+ZRnZsafL7Q3p4iSvIdid84WPjb
         pcU+Rk5HPFetrh3HfiW2RP2sPfLULH+1J00gxEccf3w0DdH6iaSGrbkivDTK8ZFlkCqu
         Tvlg==
X-Gm-Message-State: AGRZ1gLUxsFoQ52E5m1gDn4fki8gLosivuFSDkIH+L0cxdkhGlX864Kt
        oG+ZoSTjBas8rfu4svVT+VI0FmvQllWxyO2w9c0=
X-Google-Smtp-Source: AJdET5eNpVtIQhY4jkChDCpRhdwDaxjE96MbyPAY7I/thQRAbByoe4tkaew/2cu/vE5s8jPsfdzvETNj5UQKA7RX/JA=
X-Received: by 2002:a02:b529:: with SMTP id l38mr5077605jaj.25.1542283625243;
 Thu, 15 Nov 2018 04:07:05 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
 <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com>
 <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com>
 <20181114230046.GC87768@gmail.com> <CAE_wzQ_OS-BnRrXjKFhNBeRFRYsQkX2tNO3DEUQRFR7g7A7-2g@mail.gmail.com>
 <CAO-hwJJ3jkQFyf7oByERd98nqEUTjJRu_1tZpFK9sWvgT921iQ@mail.gmail.com>
In-Reply-To: <CAO-hwJJ3jkQFyf7oByERd98nqEUTjJRu_1tZpFK9sWvgT921iQ@mail.gmail.com>
From:   David Herrmann <dh.herrmann@gmail.com>
Date:   Thu, 15 Nov 2018 13:06:53 +0100
Message-ID: <CANq1E4ThFYS8=QqnyUVMAafy3BHb8CiDqm9LmT22XZzm9wJSeg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or
 elevated privileges
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dtor@google.com>, ebiggers@kernel.org,
        jannh@google.com, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Thu, Nov 15, 2018 at 9:14 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Thu, Nov 15, 2018 at 12:20 AM Dmitry Torokhov <dtor@google.com> wrote:
> > > I think it's best not to make
> > > assumptions about how the interface will be used and to be consistent with how
> > > other ->write() methods in the kernel handle the misfeature where a __user
> > > pointer in the write() or read() payload is dereferenced.
> >
> > I can see that you might want to check credentials, etc, if interface
> > can be accessed by unprivileged process, however is it a big no no for
> > uhid/userio/uinput devices.
>
> Yep, any sane distribution would restrict the permissions of
> uhid/userio/uinput to only be accessed by root. If that ever changes,
> there is already an issue with the system and it was compromised
> either by a terribly dizzy sysadmin.

UHID is safe to be used by a non-root user. This does not imply that
you should open up access to the world, but you are free to have a
dedicated group or user with access to uhid. I agree that in most
common desktop-scenarios you should not grant world-access to it,
though.

> >
> > > Temporarily switching
> > > to USER_DS would only avoid one of the two problems.
> >
> > So because of the above there is only one problem. If your system
> > opened access to uhid to random processes you have much bigger
> > problems than exposing some data from a suid binary. You can spam "rm
> > -rf .; rm -rf /" though uhid if there is interactive session
> > somewhere.
> >
> > >
> > > Do you think the proposed restrictions would actually break anything?
> >
> > It would break if someone uses UHID_CREATE with sendpage. I do not
> > know if anyone does. If we were certain there are no users we'd simply
> > removed UHID_CREATE altogether.
>
> AFAICT, there are 2 users of uhid:
> - bluez for BLE devices (using HID over GATT)
> - hid-replay for debugging.

There are several more (eg., android bt-broadcom), and UHID_CREATE is
actively used. Dropping support for it will break these use-cases.

Thanks
David
