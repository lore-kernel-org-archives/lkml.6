Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8FEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1B20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=microgate-com.20150623.gappssmtp.com header.i=@microgate-com.20150623.gappssmtp.com header.b="GfxIyEtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbfACP5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:57:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41543 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfACP5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:57:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so16174982pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pabVha8AYe88Z3JqtWOtTwJW/Tm4lwZSMMo59Skbsbc=;
        b=GfxIyEtXii8mYEdoWjzQ5HGZ1Uej78w4vUe8PgoPw+xAAzyFNfv4AVCSbVhZTD20Aw
         EjZP3ffsglC1Xclsnq+k9b0knMtTZMLMHjXcjYeK9lU33k9nMEOVbvTr3C7Cz2P7oCiI
         Oaq2u8crm/Jos8fpdw0EG++uJ3FGbEtm7om9EF7+5u3mtwEwOB/htvIfckK6VZpoZfdy
         ZrO52XHqLdyvbCyasGY5ulSM/Xk2ielmvC0hICNvA2sOow72GVufDnRZ/NJkigBP4s/B
         g5NqhXobM+j58Fvks02CMCr1ru3cI+Se5yZQB/k26KX3kRznR9aM00ScvTwtsA/flbL3
         T5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pabVha8AYe88Z3JqtWOtTwJW/Tm4lwZSMMo59Skbsbc=;
        b=PcA0tRMfrtJOIpze0glRo5gWDU4HDnLbR3pM7lfKRSGqdQ+ScwaHEuwR8EN3OjhoPP
         nddE4tx0Cxy+9CDGXScHK5Fbw25uLwrRMXtf5QRBmTC16Jz21BRepi65+my7f7B9VxJa
         AltAsfFGWxlV6NV5Em+LG4O8+3FExMoWi97/TVJKW5YtFt9s2MbsO6PXD7tnlV50YjIL
         R8LRtrDzPGmCOQbrNv9JjFtNTPskTCF7hMA8znb3rzuZ6sLxMwtKP0KjahBJrIN3Gsb3
         ZpufeJRAC3gLFawIAzQ0DLl4pEJWGAEBpX0S0uWDG/++SMRLlL6R/uqZB8tcg3PdvbLC
         bqzw==
X-Gm-Message-State: AA+aEWYeE+7xIt7UmCVwSlw+WHxg+sDekfWCuntva+i+7SazwAVSRBag
        QVc4oyvsgiHFdXnSJlmTXSS7Iw==
X-Google-Smtp-Source: AFSGD/W97qOnWQmy7TI3FbuYAADOlx0Q1YZXU5yLktu3bKWZT6VLKhQmEzpqJUGB7Z0ovkt3M6isYg==
X-Received: by 2002:a62:9719:: with SMTP id n25mr50390534pfe.240.1546531022534;
        Thu, 03 Jan 2019 07:57:02 -0800 (PST)
Received: from [192.168.1.77] (c.208.53.119.160.static.broadstripe.net. [208.53.119.160])
        by smtp.gmail.com with ESMTPSA id b7sm135668578pga.39.2019.01.03.07.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 07:57:01 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <98eec651-d1ab-48e5-309b-7e748981cfdd@i-love.sakura.ne.jp>
Date:   Thu, 3 Jan 2019 07:57:00 -0800
Cc:     Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <434841F9-C2DF-4D73-9AFB-3BFADF325086@microgate.com>
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
 <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
 <ba6de468-d36d-cd33-9a13-520102b676c6@suse.cz>
 <98eec651-d1ab-48e5-309b-7e748981cfdd@i-love.sakura.ne.jp>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 3, 2019, at 3:32 AM, Tetsuo Handa =
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>=20
> On 2019/01/03 18:09, Jiri Slaby wrote:
>> On 02. 01. 19, 16:04, Tetsuo Handa wrote:
>>> +	if (wait_event_interruptible(tty->read_wait,
>>> +	     (ret =3D -EIO, test_bit(TTY_OTHER_CLOSED, &tty->flags)) ||
>>> +	     (ret =3D 0, tty_hung_up_p(file)) ||
>>> +	     (rbuf =3D n_hdlc_buf_get(&n_hdlc->rx_buf_list)) !=3D NULL =
||
>>> +	     (ret =3D -EAGAIN, tty_io_nonblock(tty, file))))
>>> +		return -EINTR;
>>=20
>> Oh, that looks really ugly. Could you move all this to a function
>> returning a bool and taking &ret and &rbuf as parameters?
>>=20
>=20
> OK. Something like this?


I agree with Jiri that placing all the conditional logic in a single =
expression is difficult to read.

But exchanging that many locals with a separate function defeats the =
original purpose of
simplifying code and this implementation changes the logic (write no
longer checks for line discipline changing under it during wait).

Converting to wait_event_interruptible where possible is a good goal but =
this instance
may be better left alone. The current structure mirrors the existing =
n_tty line discipline.


