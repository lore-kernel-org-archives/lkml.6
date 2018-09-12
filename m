Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF93C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D6D20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9Wlg/gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65D6D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeILWDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:03:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44756 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeILWDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:03:34 -0400
Received: by mail-io1-f65.google.com with SMTP id 75-v6so748221iou.11;
        Wed, 12 Sep 2018 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IG+NtV/LgmYSnkq9OSgaWHrWU8Qd0OfJskXm/4fZJQo=;
        b=Z9Wlg/gxbn5ZZPnk73EEdKWOo1+XMFiajmhkiPB6rG8zyWskPhrhgbh8jfjHyu6lMM
         aTygphrtJiuS2t+IkZvHfDtMozUIJdrW4xwrb3Trs9pbPR0vbPeo9fWpJxS7fzWM0R4E
         sMrlU/8QT3z+dyl8FHRjr76DrbcV9hmJj0B7O/g8PT4nEgIHNaUYnaBi7IXEim4TPKnu
         tl933mUASfGE93FPuQcop7KFIwYg7vzeGLH2RPi7Y1uK2hFTBgDs4UXAoFZyx0/1y0Pp
         v1pKa2I7xA7xsTNtjB/8n2s6hc9kfOiDHWNMluE/Q1BFoh+aeJCwjZjHwvhXBHTcc7Zi
         YPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IG+NtV/LgmYSnkq9OSgaWHrWU8Qd0OfJskXm/4fZJQo=;
        b=gt/Yf8PnCWVdZ5glNDg5SZQdBC7WxPkiZ6iJ7H9117ozwuubugVHzJhPyaFVKi7HYI
         UaBmW8rnoWLiPCEK3o95jf6kCS5CrY8NRyfJSzFUJ4Ae9ZOALMuc4ROLiWYs7HTM4jls
         QEgY3Gtb7FEY8CwoUMJFZKZw30/nBy5mQL3ox2ie+dNHmZN33hHgkjDAAhtj4eWQr46k
         r2F0bBYQYV71dYW8cSd1c6Og956wbeDVlID1QN9nsIA5AAPD8EzXDDgiXztpI4NeZwhb
         YvviTqvAJkA03TIH8LrPMoGiBT/itfwJDN+zn3RftHI9edlwEtQLRKOjDgUnhnUv7sF/
         JqVw==
X-Gm-Message-State: APzg51Az9t003GBxjr/qoKzjt8S4gioSbqCyqBgkWwc92bdf+YSAdwmJ
        HUMMlS4t8lhbmzDE+b/bj5R97zTGUsXx4BBK9BE=
X-Google-Smtp-Source: ANB0VdaOQl0woCe6fxFT3yJILdnRUlfaIO9JEsZ239iZV9798m1Tldc/AXgy6oW5PyhqU9r7twgnomH6yG/FD1fYsk4=
X-Received: by 2002:a6b:f201:: with SMTP id q1-v6mr2493724ioh.180.1536771489212;
 Wed, 12 Sep 2018 09:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost> <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com> <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
In-Reply-To: <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Wed, 12 Sep 2018 18:57:57 +0200
Message-ID: <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Lars Melin <larsm17@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 6:32 PM Lars Melin <larsm17@gmail.com> wrote:
> You have chosen a platform which has limited usb resources and want to
> solve that problem by adjusting the device driver?

No, you asked for a good reason for why disabling and not just
ignoring an interface makes sense, and I think that supporting
multiple EP06 on platforms with limited endpoints qualifies as a
reason. My motivation behind this patch and modifying the driver, is
to make the driver work with the different options/combinations
supported by the modem. The platforms I am working on merely triggered
the error and inspired the change.

> Why don't you just unbind those interfaces which you are not using and
> which are eating up your usb resources?

As far as I know, unbinding interfaces from the driver does not free
up the memory allocated to the interface by/on the USB controller. I
also tried, just in case, and the output from lsusb is the same
regardless of bind/unbind.

Btw, the patch for the QMI driver has been accepted, since you
mentioned that driver earlier. So the assumption about interface four
is removed from there.

BR,
Kristian
