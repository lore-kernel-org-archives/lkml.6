Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE11CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F0E21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qH1CG3QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F0E21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbeKNCJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:09:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41417 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387735AbeKNCJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:09:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so9229219lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HI7SW9JFFeWPsuMYBR8L1n43Bb/u36YCq2AHZO74UVM=;
        b=qH1CG3QL5AW8FKpP3QcUVAmXhfAjtEMouz2pgTg8gGrO2B/VqODofVrhXjp5+lkclO
         tBdK+7YD/v0zeuHfd33yYwsC8DlZe+XBoiWZlkmElg1ccPgEaxgnKCURA08duOTFAjux
         jReezbtV4a0bz+J1SE6cybbMRQLLumfdNw4iKen7WcVl/WWtI3SPuZYzdTT5cCpdUiBt
         u68Cr/+u4y21QkE6Wc0cll6xnyW+pwdBZvxXY70JXGYi+BpQuk1NkYTxNzzkjhqmzWNM
         JR675t5WXxS/pJCIFgxYfwDIkrMvOoxhmi/vhFxfRHBPC26aDqMmV9mf6augpgIGZ9pq
         Z6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HI7SW9JFFeWPsuMYBR8L1n43Bb/u36YCq2AHZO74UVM=;
        b=RRHSREIXA4PYJd6zDw/liG0CRk1AcHSC53oynY5AtkF0JdLuehflVVuhePXe5vMep9
         hdrCxxfQNxkUxEZ1A/zhEjgpYMxH8edMRO1rp5vkmAoUcN+tQ/VGmRSh6fU8pn+tbUgJ
         PW3vJq/tIcRgf6LkVAmXN9IGWLOYdDAqztq6x8KIFsImCIL3JvAm8H21xP9bViKVx40G
         PHztuOCKRcuasGcoNM2MwsQZBmFuixY5H8vMvM1Vjh9Uatu3rgHgOQhUr7LunxPHZ1OR
         YKo+osTqpNnOP+NNFi482Eoikb9JaX6x0BQ/tdTl3XEczQNOgHtLdKfhLPXbB5o7zHZl
         daqg==
X-Gm-Message-State: AGRZ1gK6C2LlCbUcKYAFXK+9S3EsON4Ka5yKcYxir3c1vR5LE2q55wbw
        xFwP+Mn10+CjX5RN/6YRpIDDKfvIgyULSC/15ZbxzLw/FuAhzg==
X-Google-Smtp-Source: AJdET5edvkB6iOFB1C2w5Dn/eLLkd7gtuosGsKctDNrs6dankLfFTpjQrRz5aoHD/WVU20mgIpzUovz3Y6DpMsHJNtE=
X-Received: by 2002:a19:280f:: with SMTP id o15mr3207537lfo.0.1542125436801;
 Tue, 13 Nov 2018 08:10:36 -0800 (PST)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F91F70@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F91F70@EXMBX-SZMAIL022.tencent.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 13 Nov 2018 08:10:23 -0800
Message-ID: <CAHRSSEwewShxNV61m9SN1by+yDTGUfWkHb=ek1qFg6g8249ERw@mail.gmail.com>
Subject: Re: [PATCH V4] binder: ipc namespace support for android binder
To:     chouryzhou@tencent.com
Cc:     christian@brauner.io, Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 12:12 AM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzhou=
@tencent.com> wrote:
>
> > I have not received an answer to my questions in the last version of th=
is patch
> > set. Also it would be good if I could be Cc'ed by default. I can't hunt=
 down all
> > patches.
> > I do not know of any kernel entity, specifically devices, that change n=
amespaces
> > on open().
> > This seems like an invitation for all kinds of security bugs.
> > A device node belongs to one namespace only which is attached to the
> > underlying kobject. Opening the device should never change that.
> > Please look at how mqueue or shm are doing this. They don't change
> > namespaces on open either.
> > I have to say that is one of the main reasons why I disagree with that =
design.
> >
> >
>
> If we must return the same context when every open in proc, we can only i=
solate
> binder with mnt namespace instead of ipc namespace, what do you think, To=
dd?

I don't have strong feelings on this -- it seems like a bizarre
use-case to send the fd through a backchannel as christian describes,
but I do agree it is strange behavior (though it seems safe to me
since it prevents communication between unrelated entities). I don't
know how mqueue and shm work, its worth a look since this patch is
modelling their behavior...

We'll talk about it here at LPC and then on this thread.
