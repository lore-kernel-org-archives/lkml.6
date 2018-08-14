Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10DDC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7588B21738
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky0KVpVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7588B21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbeHNPho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:37:44 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35885 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:37:43 -0400
Received: by mail-qt0-f195.google.com with SMTP id t5-v6so20933170qtn.3;
        Tue, 14 Aug 2018 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LSdJB22vzugeYdCQwG643iZT3g/2nPdkb6ENk3QX3t4=;
        b=Ky0KVpVVb3PSQVYelvIeVJssN2Lx53CyKnBxodFUyrCu91uEciDsJ9UpYU59JJVu9C
         rxd2Tu/zl13My3n2glFhB5RIRSVjVR0Vj1G4ydWjSm9f0iVCqjr6BAcmuguC4VkDwbuf
         2i6fw9dEHsQA6IBaFPsy5EGPKIMnkpEA2Q9fLzk6BadNmAYjYOgAa8z8+UdRhCNnS0rg
         3ejh5onaIeKZfBOKtdCzf4krXK1eAGiBFRpOC9ocoKp8e2qmlScov/uwQqjAwhJf4rFa
         isC72xWSvTqPdOqOC4ckxjMHbCLW0ee8Buhr1/woGE0H55whM6pxr+QvJMny3XbJQGzh
         eEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LSdJB22vzugeYdCQwG643iZT3g/2nPdkb6ENk3QX3t4=;
        b=YtL5xIY1DFLWC7vf8Sc9TfCWqlHxH/m2hFOuMXUvTEs8LZMN4YkBEe4LUUZ08UjYmB
         TvXRvlk9TYz4jcXdiUSAdNPkt9b946Ro92M3ztbLggT5TNXBAL7K3dn4FzE2OPuqrIO/
         E1sg/10/QC6zpv8Kn9pRQimhvchtn7RpIEpFKz7xfGfgiauCLPEAZGshYIpzCrLON0KB
         UO7/JTFP2vXZH42ijmtiRERTuEyK6XcoroBgWSrKgiLR7INSm5YQiT3z1ZnTOFGxIfEW
         6Ld3NE9y2k6aRogYKovFMXCE+QEIdxhu29UcCDJGcjKREmzMl59eHet0e0mNgDnK+yMe
         GvMQ==
X-Gm-Message-State: AOUpUlHc8uOrbiefT4Xr70hI2Eb5pqmwpU43aWJfGSyK/heJFyPALMly
        rdFOb3MPre06QA3G2Ot/Hx7R0gc7z4tCzGsANyo=
X-Google-Smtp-Source: AA+uWPwtrZlWwmjxPQkC3KNDFIADYHjrLq/e2qLqTcXtRSxz1El8qEOFvNsxl5n6dY/4m+ry4hxphDdbC1HWFKBiwKQ=
X-Received: by 2002:aed:3c34:: with SMTP id t49-v6mr19856150qte.404.1534251040697;
 Tue, 14 Aug 2018 05:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 05:50:40
 -0700 (PDT)
In-Reply-To: <cf106f99b8794bb38c16c7a5a83e128b@de.bosch.com>
References: <cf106f99b8794bb38c16c7a5a83e128b@de.bosch.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Aug 2018 15:50:40 +0300
Message-ID: <CAHp75VeVvJhkz2b5SVwaKFzGUtiRiqcKnCDXxcQhV6ke3pyzLA@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
To:     "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "WANG Xin (BT-FIR/ENG1-Zhu)" <Xin.Wang7@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 2:39 PM, Jonas Mark (BT-FIR/ENG1)
<Mark.Jonas@de.bosch.com> wrote:

> tout = jiffies + msecs_to_jiffies(at24_write_timeout);
> do {
>          read_time = jiffies;
>
>          ret = regmap_bulk_read(regmap, offset, buf, count);
>          dev_dbg(&client->dev, "read %zu@%d --> %d (%ld)\n",
>                  count, offset, ret, jiffies);
>          if (!ret)
>                  return count;
>
>          usleep_range(1000, 1500);
> } while (!time_before(tout, read_time))
>
> The advantage of this code is that the usleep_range() is unconditional.

> The disadvantage of the new proposal is that in case of a timeout one
> more unnecessary sleep is made. Is that acceptable?

Yes.

> An alternative would be to duplicate the regmap_bulk_read() and the
> debugging code outside the loop.

> Is this preferable?

No.

-- 
With Best Regards,
Andy Shevchenko
