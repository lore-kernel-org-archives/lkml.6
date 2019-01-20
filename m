Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95806C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA622084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 10:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QuvOaThZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfATKA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 05:00:29 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33892 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfATKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 05:00:29 -0500
Received: by mail-lj1-f179.google.com with SMTP id u89-v6so15101141lje.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nou3fs3Y96BAWpXHhlaYB51/JeEc54cVl/ZbMqKLQ/M=;
        b=QuvOaThZ03dWh7zs55B7nkf8ccCroTR+jkwqF9RrjPM3rd4nXKEbO7fCNCzXCMGqcK
         mQLg2/BwZXqBlTD5fDzyi0qn5VG1L7kcWExe2wS33zfUARbYDhcS9BWDcVI/02EngK7t
         U6U830U64fxri3kyKtSosO7d3hPbA93/ptIHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nou3fs3Y96BAWpXHhlaYB51/JeEc54cVl/ZbMqKLQ/M=;
        b=G/fN+zxV428GepRUAC3fOqU8DEB/9RkD7W9dpXIR9fYj8A9uSlfk9vH7xa1J0LIbAA
         rWCsRFaOw+iqT0GE42tPsjxV8uxDZPxKamangXcX+YI2neAutV5tUoQwXVLw9NjzHMtS
         QN70li/n8GjUAMFhf1XDIsMJbobY07HQJZq8GOnVgUNZj+AW23fx3LUhpzj+/U9Yrfef
         j5UCKhaJkLFA58bSQwcbPJAaPFpChrsbLks0nWgMA4DxnZLtjrML3PW67XOM5tJfyoTQ
         E/lpdphecn5GIrGFtVEI1yCcpxGR1hP2SURPd8fGdzqy/upA1m1LceSfj8/DVRY0V616
         Mr/Q==
X-Gm-Message-State: AJcUukdQ9HGzqN7uO0/RJecPm/SacuURSHDAeQAvm4Cy3hWKBHLj+/JB
        LDLoq868GiMjGd2IsSxIsEsDrU5nQLO6Sg==
X-Google-Smtp-Source: ALg8bN5cN89b/uTup7BtRgBL3RY/7v2aItyASk5DfYQ4t7MU6DkTcZvfeDiF0sMihC7oOam+0bq99w==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr15296729ljh.59.1547978426673;
        Sun, 20 Jan 2019 02:00:26 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id h82sm1682586lfg.94.2019.01.20.02.00.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 02:00:25 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id n18-v6so15078064lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 02:00:24 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr16732573lji.133.1547978424135;
 Sun, 20 Jan 2019 02:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
 <20190120000138.GI26876@brain-police> <CAHk-=wjKgJ-9ypvzq+CB_NKnRk6iAqFtgVPwSH17C5RqJoYF=A@mail.gmail.com>
 <CAKv63uuf4e0arj9OvSLXRTxF9pUJUmbe7yApU0StF-B=BcbGZA@mail.gmail.com> <CAKv63utKUuXTBT44anBT17-O4puzJsesHmAOFPDN=qFPjzPGTQ@mail.gmail.com>
In-Reply-To: <CAKv63utKUuXTBT44anBT17-O4puzJsesHmAOFPDN=qFPjzPGTQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Jan 2019 22:00:07 +1200
X-Gmail-Original-Message-ID: <CAHk-=wgrTWpzTo56=mOT8f8RDAo=RvHsXp4d8GqbLwEZUQmJqw@mail.gmail.com>
Message-ID: <CAHk-=wgrTWpzTo56=mOT8f8RDAo=RvHsXp4d8GqbLwEZUQmJqw@mail.gmail.com>
Subject: Re: fix int_sqrt() for very large numbers
To:     Crt Mori <cmo@melexis.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Florian La Roche <florian.laroche@googlemail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 9:30 PM Crt Mori <cmo@melexis.com> wrote:
>
> I have just re-read the patch submit discussion and a sqrt of 64bit
> number can never be more than 32bit. That is why u32 return value is
> enough.

Right. And that's exactly why I thought it was so odd how the
mlx90632.c driver - which is the only user of int_sqrt64() - does a
nested one.

It would be sufficient to do

        int_sqrt(int_sqrt64(..))

because the domain on the outer one isn't actually 64 bits, it's only 32 bits.

But it's just a slight confusion and doesn't really matter much.

The bug in int_sqrt64() is real, but as mentioned, the calculations
done to generate the argument for that one user do seem to all be
*signed*. If it overflows into the high bit of an u64 (which is where
the off-by-one bug would matter), then the types in that one user are
already wrong.

So it would probably be a good idea to clarify the single user too while at it.

           Linus
