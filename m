Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E24C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0702192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 14:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fOupv8ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfBQODA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 09:03:00 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39757 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBQODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 09:03:00 -0500
Received: by mail-ot1-f51.google.com with SMTP id n8so24095284otl.6;
        Sun, 17 Feb 2019 06:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRF7QEZ4ps6hDZrYg29EaqW9rR7Z0aLbdNOon8BuccA=;
        b=fOupv8niAR4uZSUJ+ftsUj0MmVCLqXB9kTjQv5plP08//eCbch+Mcxijtuh5wVViKa
         F/R/Tuvq690c+/s4kyeVeAgWyHMZ+5JYe2jtsHWXhDSZNCQJxFzhMs99LaoRoJEVMxgr
         85jJTJxJsm3ubrf4Y/bVAjKC+QVNSj/RKKfu2ry8UoKRERpUzABJZOa1whi/l+N7szRL
         OK0p1V6iOAczGtn2fyZlHpFvYdQMAQRtjrTR0RidD1CpDfSpXjyPq4ZKF+o4vQlicTLg
         a+umFH4VStwBgr4g9hmY8TbjWRUVm/DjprB6GtHM+UmLZwpFXbZaPnCfth5MK+OeFs98
         Xw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRF7QEZ4ps6hDZrYg29EaqW9rR7Z0aLbdNOon8BuccA=;
        b=P2lXI+Rph5kRGIyvERmDe9uzbNoimKnXZnPMd0GbHrTypa/+pxt2kO3ULhcgU2cb6B
         JmE0P8JpQkGROpte51V9kNby/JbozpbULorZDWppxZlq1gpbzYEAVWCU0sZpqMVJhmXO
         rIrH5qL8kAh4fMTr3Zt4CX3Vv7qLcOXfdWPKcmfFrT2USeaxRGRQ2dj89Nif+485FZjx
         Zy7q4gAfcmHVepkorPAQ4s+D9qsUQ41yQBXEQMnMNdYmxFsxCndQe768z/gcdZq5rYgY
         Grq+AoTKSjQo2OtHL1Bxs4wUKzwpg+PFJ/QmoycH49yfpTt0zTYOf2QZhN6+U+2aK/Av
         Jssw==
X-Gm-Message-State: AHQUAubGn9wNtcyUv9l8dOPhLilnxAgHWgHtBHRX18NGAjEJ0B2Y0qEi
        /xfgSIbHlLiuDDKA/5hiH6iqSRh7kj+l3wiWhLM=
X-Google-Smtp-Source: AHgI3IZXLCcpxapVqlJ3MOwLLh7Qq9+xZufFlKkmn99eFUBNzWxxQp+RJStiLJf2x7tpTIH7Kj/l5ZPHyzOPVhvV3O4=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr11771077otg.308.1550412179185;
 Sun, 17 Feb 2019 06:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20190211103324.643-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190211103324.643-1-alexandre.belloni@bootlin.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 17 Feb 2019 15:02:48 +0100
Message-ID: <CAFBinCC8FBeswc-dq0brSOxtLVt97dKgncU=gy-FmY5cwBPGww@mail.gmail.com>
Subject: Re: [PATCH] rtc: meson: remove useless rtc_nvmem_unregister call
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Mon, Feb 11, 2019 at 11:33 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> rtc_nvmem_unregister() is called on rtc_device release so it is not
> necessary to call it from the driver.
thank you for taking care of the linker-error!

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
