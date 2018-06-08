Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GvYhI3BoGlujSgAAmS7hNA
	; Fri, 08 Jun 2018 11:31:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 46E326089E; Fri,  8 Jun 2018 11:31:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RICuUffZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BCF48607A4;
	Fri,  8 Jun 2018 11:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCF48607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbeFHLbj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:31:39 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46447 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeFHLbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:31:36 -0400
Received: by mail-vk0-f65.google.com with SMTP id b134-v6so7978584vke.13;
        Fri, 08 Jun 2018 04:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W8v8qH82dOiZa7et3pdpTdIEDcnwYoszxiAUYr2sLt4=;
        b=RICuUffZ1qAFOuxqim/ZrZ4saz2xd/UXu6D58P1jjTlGK2cb4fuCT0qDB68uu1yNfj
         sSy5yHUbsxCr+MoX0JqikP0lb/DAEaZnfOGr4qq5/nlXad0lvAJjGI1HzohmyU6l1vvC
         tr3lujziwvHL3VFYMN2exnULFS6GBNyvcReOf3CduRvThO9N422VhT1pOEDlIWaPSVgb
         1pna0lCOTQl+nr3N8AB4zrNTn2hse8x1w7fr9JSpMf/XfmouMwcBy5l7P49JZgJ9Yn6O
         cgnNBl9O/9w24vuK3LG5vU/RGieFnT1i9GSIVuRDuVjCuuhgzRfUF0IOCR5rfNU+df+t
         BtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W8v8qH82dOiZa7et3pdpTdIEDcnwYoszxiAUYr2sLt4=;
        b=SG02qrnYysXA4TS+SNIYySLLJ9Y6C9kIo8/OwGnO/LKxrpei5ON4F4dtg2kICuCWXL
         /+fd7+z6wq/WnhCck/bWYaArram+HZTmcJ4F166rbmCTEBN54Ia0vXkyoYAQpKw5XKPv
         4PLhPAt18QNpiSIFbKlmc2UbCDMXD1NJRIshl6NVHohk4y6ZMVtkEEUFVDomhbiI3yTP
         OjY05qaUIWrll4jViQbkItBz1TR+cx2v72HlBFdlCHfIDX5hyUXTzmo4E7TrfGc8qLu5
         2horFM9XHWaU8jk1333B09oiNnIDrSU7Klap508tazfMcfbs0QO42tDCol6/7N0Cs+CN
         HgNQ==
X-Gm-Message-State: APt69E1IMXS0WAK09vKwWPkf0OBsWxkCewQBNItRxPXaNmxIMYz91jow
        6R1HYIdCVaYFj8N2TPy3uinwuyg89P2lVBG39BM=
X-Google-Smtp-Source: ADUXVKIb6YuI7/W8gQjlkzB/MakZm0Ifliel2lZIpBxHfgM6jCkO5e52JQBHtCL1FxdVmmKCvXBVdqXnXBL+gxuQ2Ko=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr447775vke.176.1528457495536;
 Fri, 08 Jun 2018 04:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 04:31:35 -0700 (PDT)
In-Reply-To: <20180607210023.11789-1-hdegoede@redhat.com>
References: <20180607210023.11789-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Jun 2018 14:31:35 +0300
Message-ID: <CAHp75VeYxvShJVxY8LanFnrow195k4tv+1_2bHEYashGGcF6cg@mail.gmail.com>
Subject: Re: [PATCH 0/1] platform/x86: Rename silead_dmi to touchscreen_dmi
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 12:00 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> This patch is part of / preparation for the EFI embedded firmware
> stuff. But it can be merged by itself without the test of that series
> and since silead_dmi.c sees quite a bit of churn I would like to get
> this one of my queue and merged.
>
> I guess it is to late for 4.18, but please consider queuing this
> up for next when the merge window closes.
>
> Note this applies on top of the alphabetically sort series which
> I sent out earlier.
>

Pushed to my review and testing queue, thanks!

> Regards,
>
> Hans
>



-- 
With Best Regards,
Andy Shevchenko
