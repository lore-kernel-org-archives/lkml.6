Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC39C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EEE2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfJh6TwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfANOX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:23:27 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44755 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:23:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so15695388lfe.11;
        Mon, 14 Jan 2019 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pvrcZ5qClIJy9+s/pvg4XctfRSTgieMg5pDWpl6LQmI=;
        b=LfJh6TwMsWFHDn99Um+H1BXQJ3RkVnxOtf7FUByODVEsrMA1lS0VbH1jhwrK/zSSSk
         sJcikJ0fWPVpZUbaET6R4iY9HB3N4CSPml7rq48MDxiiVRY35XSXbgq31m4WqkPUBI3d
         j+AwMdwrwb29cJGnfptnSFW9+ejCE2ogHFr91/CTUU0mNxbFiPuwz04+kFfpfBv+FI+w
         uem6kEkagay5m1ABi9un/3hODtWIopC9MDquAMp7uTQZ4cdgDE57PTjZlw3oQ46z6mAP
         p4InlKc4+iBOmnRlOea8iNHzzHYPsFeaOo9azNDCY7uTpoMa2F6VIO3vlYOAp5morDfT
         7/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pvrcZ5qClIJy9+s/pvg4XctfRSTgieMg5pDWpl6LQmI=;
        b=JVdMFvVk8SorYRFCxZFlQcDEM/U5Qz1RDS3KagC1kmpj+UxDZ17G4zXpR+MUyWGJV7
         CiEk8CKIkfl5RNhORKGYucUuay6x9YV9DJxTsv+hvHQWuC+5SBMOW3XpHByXlaFiqhoY
         Df2CM1JOoePmNZS+RwyxKXhlm9rYt8bsqhT7waQzt9qgS2r4gU0Aur6fj9hPmYAu6Op0
         N6p0aNcEh5gyg+8uyOoSBumyZ4zD+1Slr9eysMQSd0fHczk0dir2/qJ2SpwAGN6t+H+H
         bRhHZZ/3wIo9udHw7qCgZY+F8+oMBU+wRVQIFKfw/QJ8oJFW6A1CuxGTUZqQdywWitRl
         osfg==
X-Gm-Message-State: AJcUukd98kLva18Wo9V+3/lHJQwk9kT+s2dzqapA5knurY67JBU69RzM
        BhBS5zcfDM4g9Dr7LhFnQochxc0/a3fILkR+a9s=
X-Google-Smtp-Source: ALg8bN71W1MQi0C1r4fHiUqPaIzIyl6EIl04MF/zYdmjA/0tynSOBQDi2iZPITFvQMkVNs5kKI7c4TOnFDyoBA6A5q0=
X-Received: by 2002:a19:5394:: with SMTP id h20mr14175972lfl.75.1547475805073;
 Mon, 14 Jan 2019 06:23:25 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com> <20190113230946.GA18710@amd>
In-Reply-To: <20190113230946.GA18710@amd>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Mon, 14 Jan 2019 17:23:13 +0300
Message-ID: <CAE5jQCd+HBh3hCkQW4SR4QOHAGRS3wEuZfT4q1N6V8g9rrpBuA@mail.gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Roderick Colenbrander <thunderbird2k@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> fuzzed data is hard to discriminate from valid data.

Just in case it can be helpful... If it is about manually "parsing"
descriptors to understand what is wrong by hands, then maybe Kaitai
Struct parser generator can help. I understand it is probably not
suited well for in-kernel binary parsing, but given a text-form
description of a format, it can visualize parsed binary data as a
hierarchical structure.

Best regards
Anatoly

=D0=BF=D0=BD, 14 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 02:09, Pavel Mache=
k <pavel@ucw.cz>:

>
> Hi!
>
> I just want to note that while these may not be high-priority, they
> are still security holes to be fixed.
>
> > > When writing the attached file to /dev/uhid, a NULL dereference occur=
s
> > > in kernel. As I understand, the problem is not UHID-specific, but is
> > > related to HID subsystem.
> >
> > Thanks for the report.
> > I wanted to tell you that I started investigating the other private
> > report you sent us, but couldn't find the time to properly come with a
> > fix as the fuzzed data is hard to discriminate from valid data.
> >
> > A couple of notes though:
> > - writing to uhid needs to be done by root. Any distribution that
> > doesn't enforce that is doomed to have several security issues
>
> We want to protect kernel from root, too.
>
> > - we could somehow reproduce those fuzzed data on a USB or Bluetooth
> > connection, but that would require physical access to the device, so
> > you are doomed also
>
> Not neccessarily. Imagine a kiosk where PC is protected but keyboard
> uses USB connection. If our USB stack is buggy, you are doomed... but
> you should not be ;-).
>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
