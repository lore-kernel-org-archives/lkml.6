Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E502C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3122083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YdbyIfiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3122083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388999AbeGJSdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:40 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:54264 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732681AbeGJSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:38 -0400
Received: by mail-it0-f45.google.com with SMTP id a195-v6so46378itd.3;
        Tue, 10 Jul 2018 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1IfSmsvDAoFdoRd5fE3SuS32Y+3xuQWjBh1nJH/FD4=;
        b=YdbyIfiYIWoJai885vUUKQUl48wWbwCp8dY0Vmf2ZD8OO7DxYHtjKLI5kf1DpztGMm
         ivfURscU7jbF7xJ8YwPhS2If4a+pj2Ii1keZJNZiWFjsoDMvOQdDxvgkRpXVatUcalay
         Ey2GBzy6NKrWRZitxrcCluTzEBNOjpRDkq03g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1IfSmsvDAoFdoRd5fE3SuS32Y+3xuQWjBh1nJH/FD4=;
        b=iF6flZMg/LXSSb5PM6SQdXFU2ynuzJMRTkQcl9WErPUF+Mv3ZBG8kF+snjYOOU2212
         VlTJ7nyI2HVS1MvJ8oIeh2PX7Bw1JgGd5TgSH7XuQl1VLO0BSXt4GWQR4w+nU4hPpl66
         zupCkLWVSf2HHgQIF1qPCHRgdiHxtynFkjqjzFWcL73ELpJhgWXH9m62kA+k7pOTTbqt
         HMqz4ni7yo8KyO3c0KtQmTeAz8mqxiSRyZg0J26bxM54F4PvESZUgQzvb/2j1GO3APhk
         z6whDv52KnIYufb5pJ4oM9KiQRS5UlpunFMemYBaFgktPQpxbdZ1JEZKUvMXjhSTsNSc
         LIBg==
X-Gm-Message-State: APt69E2qZJFF9viE1zsCCljEO2FjqbMN+Wu8KK5SJ/ESm4dAGV7i6nZW
        Q/4LKAvENFW+OcaUG7RSbUMQnBS6kypV6DhYBSmCoQ==
X-Google-Smtp-Source: AAOMgpcVzwrkyH5OuIKDkW8lPPJc0QDcqASXC1JW3B/wNLCIOfbQrJ/jaus5XPsEve9zolHldL1Wdfx+HOUgzNTZtHM=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr19579037itg.1.1531245884592;
 Tue, 10 Jul 2018 11:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com>
 <1530940958.3135.4.camel@HansenPartnership.com> <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
 <CAG48ez0Ccpp3yv+FVX9Sp3WHqPh6US=quDjELmv5RYVgqfBtVg@mail.gmail.com> <CA+55aFx9iTm2rZqL1jo_mhAp7EQ8tHhU6MFCSG7XdqAxY_vUGw@mail.gmail.com>
In-Reply-To: <CA+55aFx9iTm2rZqL1jo_mhAp7EQ8tHhU6MFCSG7XdqAxY_vUGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Jul 2018 11:04:33 -0700
Message-ID: <CA+55aFwtSEJpOqOsU6+g9dDHyHGZjoABz-ga6mVx=GiredGnDw@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     Jann Horn <jannh@google.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:49 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > Also, the device is called /dev/sg%d with %d being sdp->index.
>
> I guess I could make it at least say that, although it's not like "one
> of them would be ok, but /dev/sd3 is right out".

Actually, I don't want to after all, because I don't even have 'spd'
available until later when we might have already returned ENXIO. I'd
rather have the warning right at the top of the function.

               Linus
