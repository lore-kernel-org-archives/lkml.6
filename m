Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C26C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A922084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3m0Dcsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfBUN2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:28:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41291 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:28:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so8619309plk.8;
        Thu, 21 Feb 2019 05:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9yQpXUXsa9DaLMPn71/JplZopjBUHFWx0ET1kih9hA=;
        b=S3m0DcsqxG+Z/kOdBmYmZYskYWN9MLblqe8ZnITX1wSPP/Dz/Yjx8YTD2sB+S7TNcQ
         2cUG6vZpgQNrmBe7dmZJtbqs/iL8P7jArgclNLgsi7o3moppkpepWhJTFI++2uG8fuHF
         MCGaEdribTbBT56hljmJBoXqVw2farhLqam7bExf9wkzvoMplL3GCdZOq0IAo6iqhnor
         mKTLd8Zp8Ar++Szh0gcLddY+iIbbVReFJV0mL/h/moV5UfUQAzO+9HAAUvUMPIdKnoWi
         /3U8VqXZeOwTxKwnFffaTGTgMEwaCQ43i/KT/eEP29RcJE069zOIBgsTL+XrNrOQ+jpp
         y5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9yQpXUXsa9DaLMPn71/JplZopjBUHFWx0ET1kih9hA=;
        b=lfZ7664nSg8F0lQDTTwk7pO4QPHf7JyqRSV8/1Jitx1KIIBQT/ZxXzPCksUDBVSc5S
         ojXKV3uqdF1wMfnonlUKSivbkiXolT3d5VsZ+N/+ycfWS+iilMATEVdefbF15V3O2tBJ
         HTvrNqVstYv2JelugNX0Y6kHATnr7r4tiYkH4u+rmzscFVDGoBTVtuVX2ncJcXFcZ8uu
         GbfgBZuSDcaQPBub/0AC6N6GnL5KBuViVpoMFD42SExj7FazfhR2itfHT70+FMsLCYI0
         iqI74yEMcT+Qbpe0aiQ75eH9qQMotaRuy3f3Q6IzahKrnoCWVuwgsC/VXUcz1eG3xaky
         OGKw==
X-Gm-Message-State: AHQUAuY974UZf6PxCXXeHGGctO0x7zsZiaaKHePqPJIgAsD5vyw5fW8Z
        LIBICE+9lDCCQLTpZ8Ko1HWzjnlDTQOTc4YcGNAlqkQF
X-Google-Smtp-Source: AHgI3Iao+GgldUUholkBSQLalbp0XXrJCxncaqK6G2hqZ4tfkYa+X7A6Gqm8Z1WBV7uLY+8/S989aAvi4VPbFK4I4as=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr42719939plg.314.1550755717071;
 Thu, 21 Feb 2019 05:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20190110175845.1203986-1-lkundrak@v3.sk> <20190110175845.1203986-7-lkundrak@v3.sk>
 <20190221012231.GC5838@wrath>
In-Reply-To: <20190221012231.GC5838@wrath>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 15:28:26 +0200
Message-ID: <CAHp75VcWMf086oGrJHWOCgYFy-J-KLw+jzFoAwuXaHtS7dgdvA@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] Platform: OLPC: Add XO-1.75 EC driver
To:     Darren Hart <dvhart@infradead.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Andy Shevchenko <andy@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 3:22 AM Darren Hart <dvhart@infradead.org> wrote:
>
> On Thu, Jan 10, 2019 at 06:58:41PM +0100, Lubomir Rintel wrote:
> > It's based off the driver from the OLPC kernel sources. Somewhat
> > modernized and cleaned up, for better or worse.
> >
> > Modified to plug into the olpc-ec driver infrastructure (so that battery
> > interface and debugfs could be reused) and the SPI slave framework.

> > Basically all of the above is based on the review by Andy Shevchenko.
>
> Andy, I am happy to merge this series - but this patch includes a lot of changes
> driven by your feedback. Are you satisfied with the changes, would you like to
> add your Reviewed-by?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Open minors:
 - u8 vs. unsigned char in a cases when it's about command to send to
HW (including unnecessary & 0xff parts)
 - _TIMEOUT w/o units a bit odd (perhaps _TIMEOUT_MS ?)

I think this may be addressed later on.

-- 
With Best Regards,
Andy Shevchenko
