Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B3EC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7818F2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnABEk1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7818F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeLMVD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:03:56 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:40504 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMVD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:03:56 -0500
Received: by mail-lf1-f52.google.com with SMTP id v5so2647216lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 13:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lp0crvwtopKqZkZUXITGkKk22UryC3tCVUPE5CIe5KA=;
        b=OnABEk1BW1kX0rHLFNCJ1xDhe0lTsXat0fn6HUpHCSkmnj22NtuZH+seP3mwnC0Wcb
         oASU1tM2svYIf3zVn3R0fvOcBKUZShUnfUuzMfPZ5gIL0YVqjvsqcA2lNaOIEQ6xcrJV
         9ALeWHTTYXsxlAbjszb1v006iS+A/SlPQvAaqdxWrZYR7zWI6mT2eRiC4poUPSr7y5Lq
         IUbvIoDcKOCyoWQ2SmZj86PMSb4Yq0M/Kx3pK5I4Y6NM2y7e5Xvoa5aX2UBoH/DvRYBe
         pZz7QYXSyZESaxXNapjkNXZZgoiw2lrtxJtteiP2/KLpPsUhjch8/QcO7o7Ww/pUDFH/
         PggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lp0crvwtopKqZkZUXITGkKk22UryC3tCVUPE5CIe5KA=;
        b=fxP/kaqm95VwPBU3AvToUjCkXuZ8P+e1kK9SQpWfuyjYXYSQPIw+Y2cnAgFXMTWz7e
         qO93Ue25CLU6f9Qh9iKfJhC78nFc/xmQyBDOliQYWesTbZQV/eueNSEUwRF/pErH60+s
         PZV6EDuDkYdGjTmTgSrA1jMJ7laduA3bf7vNWRZGBp3QqvGyJAsgh5PXPrfsdHdKmd8X
         3H7/wxiQYWzR0I4fBX44KsRAyb6z8DcE6OA3V8T0mCPt1W4cUoonRcWC+giFFU7nTA14
         0/Zc+SLNqiQyiZf86pIvmAStD50qkr03MQ70DV031UpT/4nBF/jkCxDsQJ4U7cv6iC+B
         ar/A==
X-Gm-Message-State: AA+aEWbRGcWrWIFW4YiagbfEBdtlWBqk+8dijFoNvJm3WQoy+yTRmmuq
        WV0ww0LN6Fa6MUjxCP63T8D7craBLkks5OJMPtA=
X-Google-Smtp-Source: AFSGD/WHx50SQxDvIHoHXiTckeDGS9RaRggADz56O7DFkhnOHeDVyvJKsyXCjUvuZRX5+DviFPwEFhWO9bGvKxjHt1c=
X-Received: by 2002:a19:f813:: with SMTP id a19mr169016lff.67.1544735033659;
 Thu, 13 Dec 2018 13:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20181205135247.7964-1-mans@mansr.com> <CANiq72=Xg--8vG0+JLsPykOUfXpo89R2H-pBLuMROnQjMui7qA@mail.gmail.com>
 <yw1xr2evkg8t.fsf@mansr.com> <CANiq72keqco3F=8YDHFqoeBRFsrs1Cbd1aF1owf90Hbncv40mA@mail.gmail.com>
 <yw1xmupikgg1.fsf@mansr.com>
In-Reply-To: <yw1xmupikgg1.fsf@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 13 Dec 2018 22:03:42 +0100
Message-ID: <CANiq72nMMB5Hvs1WfonQGx+p-dzF+Qiu5VaH13ro2Aan5paDPQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: charlcd: fix x/y command parsing
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Abel <rabel@robertabel.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi M=C3=A5ns,

On Thu, Dec 6, 2018 at 1:06 PM M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com> wro=
te:
>
> >> BTW, the parsing of this command has been broken since 3.2-rc1 due to
> >> commit 129957069e6a.
> >
> > Thanks for checking! Are you able to test this?
>
> Yes, that's how I noticed it was broken.

Fantastic, thank you.

Can you please add the explanation about commit 129957069e6a
("staging: panel: Fixed checkpatch warning about simple_strtoul()") in
the commit message so that we don't lose it? I will pick it into
linux-next.

Cheers,
Miguel
