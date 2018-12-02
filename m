Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD44FC65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E9320834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E9320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeLBJmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:42:20 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34179 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeLBJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:42:19 -0500
Received: by mail-ua1-f67.google.com with SMTP id z23so3405049uam.1;
        Sun, 02 Dec 2018 01:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ba+mnw0Tk07q3FL6hJbBOPC+6yVlQ3wEke/zKGlvDm8=;
        b=RyDYbOEBF9LCwGu1xZeSN9xNzVyUPn8741KqEdv4rP5/S9ND9oyLDLqqEgrgtfw4PX
         u0zOAYL1WvDBClaASGMRAu5HoEC83ajSVWkCqBZxcrmO94CdZR+vmTePA65i0Pq90eLM
         Usy95ig7dyjCjRWc355FHPw08pUT6fGdE4vXNZuSbCXgXQX13Z6/CVGmNAT/KBkILhk6
         3dUTBL0PX3A1OIIjtYK13omVAsZN/WpKbGJgflLbkUloMk55p57tsdWp1Zmh8IYMoJaD
         3puLus3jL8xhCXHgrOzKSNWZ69eqWfzXaaQIwtl8IoKwFl5aR0F63Q6FMyqmxrfr5XSb
         4Viw==
X-Gm-Message-State: AA+aEWZef1z7G0VksJZX3BOx7JnBS0Dz4PpaDW2tXLDWLJOwUjYNRmkQ
        Y0AzdN/PcGD9jZ9xfld9PRofUtskwPBdwj2eXJE=
X-Google-Smtp-Source: AFSGD/XjxVBVLfBhsYxcLR3wcv7hrJ0aZulbIfIyt/zt0+Rw4w72P6W2oYmoR4Go0nE+Nmy/6Dm/S1gzsiWRLJRg9Rs=
X-Received: by 2002:ab0:7251:: with SMTP id d17mr5589150uap.0.1543743737052;
 Sun, 02 Dec 2018 01:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20181129105956.25933-1-andriy.shevchenko@linux.intel.com> <20181129105956.25933-21-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20181129105956.25933-21-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Dec 2018 10:42:05 +0100
Message-ID: <CAMuHMdWpb-xCewVbwNq7-gbh5OFq7LFOqjn2UvEOWgByomOa-w@mail.gmail.com>
Subject: Re: [PATCH v5 20/21] m68k/mac: Switch to use %ptR
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Use %ptR instead of open coded variant to print content of
> struct rtc_time in human readable format.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
