Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id uGyfOtghHluyWgAAmS7hNA
	; Mon, 11 Jun 2018 07:19:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 36CAE607A4; Mon, 11 Jun 2018 07:19:09 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gVGuXa4W"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B2FC9605A5;
	Mon, 11 Jun 2018 07:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2FC9605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeFKHTG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 03:19:06 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43109 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbeFKHTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:19:02 -0400
Received: by mail-ot0-f195.google.com with SMTP id i19-v6so22600559otk.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TCCKFO7mXUmmC+SOJQGUK7mUfSSufay80Q8OdCPN4MI=;
        b=gVGuXa4WhD1W1jdC/TSDzes5IVo8kVv6EHuQVE8wJrWIok1dLnWO3kkEr3M1MY4enM
         ZwlVvqK3Vz/YeVamSMIswTzf9j8E6JayKlWgWwjVMQJJVcBKZiZLtM70XZZ0nRc3Q7En
         H/29qIboFQ7CayTRjdlOBwFfy+AsyZKVV2CNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TCCKFO7mXUmmC+SOJQGUK7mUfSSufay80Q8OdCPN4MI=;
        b=qTOUsWf+OnSd1MbFRtzR5McEpvT3kW1FEaPMCvbAfgrIj2OOIzZBjBHjuRoU8x2f3g
         0tgemLkpB+7fTL1DJTDI577qqum7jfTikcNQOcawQ2bkpVBqPKFoiRJMeWUCNqJQOEzE
         WFAYwaZohG+Flut4/D64vRd5tKg34Za7A0X32XzMhgJgqkTAEwuTM+8Gju8Q8ikDZ25a
         q5wADIiiP0XDAkHi9QpkjsSagY07FUup6LSYXyyxby0cuOQaiBd7DGFk5QPR0AMg1FZR
         Jx7u3pmPnBddlaB8trrZlmrdHszoHPpBbxUleC0HfbaFR0WdG+uBtu62hMvapqSH477Y
         7YMQ==
X-Gm-Message-State: APt69E2Hqj0GCrNs2Xzp/Lrps+KRDVfW6fScuKnQQOTpqqOE5boAPYbm
        amQCIWhvleUNeHoO9fJoksCzsgNJMQHT7Vy4pH2rrQ==
X-Google-Smtp-Source: ADUXVKIyjijCWfViDjvGe0Z5by/OWQmtnsqxu1DHiMlw5poFni0TuYTPOK6e3H2r4fqr1RR7iT1LP+Cyd/ZmL55fykE=
X-Received: by 2002:a9d:1531:: with SMTP id u46-v6mr10016444otf.197.1528701541933;
 Mon, 11 Jun 2018 00:19:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 00:19:01
 -0700 (PDT)
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180610045657.GM30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-8-mszeredi@redhat.com>
 <20180604084904.GF11333@infradead.org> <20180610045657.GM30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Jun 2018 09:19:01 +0200
Message-ID: <CAJfpegtGtAR25qWgpNisvL8F51h3K6s44zkWBSVVbqecut6tBQ@mail.gmail.com>
Subject: Re: [PATCH 07/39] vfs: export vfs_ioctl() to modules
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 6:57 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Jun 04, 2018 at 01:49:04AM -0700, Christoph Hellwig wrote:
>> On Tue, May 29, 2018 at 04:43:07PM +0200, Miklos Szeredi wrote:
>> > This is needed by the stacked ioctl implementation in overlayfs.
>>
>> EXPORT_SYMBOL_GPL for exporting random internals, please.  Same
>> for any following patches.
>
> *blink*
>
> Christoph, get real and RTFS - vfs_ioctl() simply calls ->unlocked_ioctl();
> all there is to it.
>
> This isn't even a case of "using that function establishes that the
> caller is a derived work" - *anyone* who can see definition of
> file_operations can bloody well open-code it.  There isn't anything
> establishing derivation here.
>
> Hell, it could've been a static inline in include/linux/fs.h and it would
> neither differ from many other inlines in there nor need an export at all.
>
> This is really getting close to lxo-worthy levels of bogosity...
>
> More interesting question is why do we want to pass those ioctls to layers
> in the first place, especially if it's something with different availability
> (or, worse yet, argument layouts) before and after copyup.

We don't.  Obviously need to make sure to only ever do ioctl's in
overlayfs that have a common definition across filesystems.  Not a lot
of those, luckily...

Thanks,
Miklos
