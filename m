Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D699CC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919432146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWoOsiPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919432146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeLFXSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:18:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45888 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeLFXSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:18:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so1633937lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWTrYGwFa0mrTz9Vke35lkbzRb1m/t7xeRXdbHsQz08=;
        b=TWoOsiPhRlvJBZ/+1acTg8O4mEgEyRVMbf/pBv7e4NOv72HXrZ34rHB3G8NeHFns/r
         Vg6XVfZyzc76ZTTRls+slcwxDbOwEzwmhOoPiqMIOdtH6TOkhEZvam+dQGEXhWs2erqF
         8eFaDji9kdwiOUP4Vj2BdMKdoVSMz/NfpH4cxO5G7nUPK0lsk9a6BHv7et2/k2r9JhbJ
         d12uEPo9FWZpReHtdJRFu/QeRz6vh1A6CCmmm1YvupUJxlzm89lYuxXNAPw4DZxNpmfl
         U6P/aOAUEMy6s+h87IIkzGilr0HNO5TtZChMmFM32O9ymmf1rI8/fWTOXzgksTxRTe/g
         kulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWTrYGwFa0mrTz9Vke35lkbzRb1m/t7xeRXdbHsQz08=;
        b=U+4W1vcKGfKs0lLJPoQRep52XtvHD9alyAAS4ELii6NgkOW/Fc5ZIBz3FIt6Y3X0gY
         xO71/Vf86g2IGftJVghbX8xrQmKFQcI6MY8pdZ9wzvcgSI1p4LwQaco+xBiqRPeo+ey0
         chAXh+MC7Aq9OZccUux3rnLNk2ci2bIdip7NFNKXSu/bGj2x3biha8uVUEYTHqCql3IC
         Ql5cUx6jNa0worrmpnIQ34sbbL5hyZEoMXCMxe0w1TIgwpeJHMjj6vh37GWREzET4yOi
         c+eUrLrfvErZ9nqa96PxcEfoTf/hV96FetpOR2MA203uu09NxU3v09G1xVC+AuwudnKn
         xfqQ==
X-Gm-Message-State: AA+aEWbLT7RoOlDYf57aBa5MycytJzq+KXYijp3B0TWrTaQiaLqnhMt0
        q7TaE/mTb8fEzJY48NGsk07Zts8gr8rRBKYLdp0=
X-Google-Smtp-Source: AFSGD/WNAdOdn3TyV6hVtnHjSDSquoI55kDdKn8A+PO+Dl5XJFvZu/+xNs7ySTw5xcDvmmrp7B9f/TB4l45O7/h+fUI=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr17498766lfk.151.1544138312985;
 Thu, 06 Dec 2018 15:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20181205135247.7964-1-mans@mansr.com> <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
 <yw1xr2evkg8t.fsf@mansr.com> <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
 <05e86c46-8d31-f922-9a34-fd6690cc1f77@robertabel.eu>
In-Reply-To: <05e86c46-8d31-f922-9a34-fd6690cc1f77@robertabel.eu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 7 Dec 2018 00:18:21 +0100
Message-ID: <CANiq72=mqVm4ruLTp3QAzap-6+bqf-b04bwQMOSX-hKGx+4afA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
To:     Robert Abel <rabel@robertabel.eu>
Cc:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Fri, Dec 7, 2018 at 12:13 AM Robert Abel <rabel@robertabel.eu> wrote:
>
> Hi Miguel,
>
> On 05 Dec 2018 17:47, Miguel Ojeda wrote:> Hi Mans,
> >
> > [CC'ing a few people involved previously on this]
>
> Thanks for CC'ing me!
>
> On 06 Dec 2018 11:06, Miguel Ojeda wrote [to Mans Rullgard]:
> > Are you able to test this?
>
> It's unfortunate that my original comment got ignored back when the breaking patch was submitted.
> Nevertheless, if somebody posts a patch, I'm happy to test.

Which one? Do you mean the original 129957069e6a in 3.2-rc1? Or the
more recent ones? At the time of 3.2-rc1 I couldn't be involved in
kernel dev :-( If you mean in the recent ones, sorry if I failed to
see some email or missed something -- it was not intended at all.
Please feel free to nag me/everyone a bit more :-)

If you are also able to test, that is wonderful as well!

Cheers,
Miguel
