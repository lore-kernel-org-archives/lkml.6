Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E8C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBAD20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/XJ3n8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBAD20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbeKFAD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:03:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33619 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFAD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:03:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id c25-v6so7660312oiy.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYdo10f32NckHCIXZEb68VSH/2Pa5G60hUJFlsrnFHQ=;
        b=f/XJ3n8o2Aqh/Fx+OqiA7cpqz1XKCPQdt6mbOZ/xUpxwrneVNbHcoNzYLsVS9rCXgP
         5sIp9k2qponHS5zmCJl/weh/L0h/OyGTFEklv4yAWqRRtpoWk4IBgaPolsR5yP8WOjMR
         PubERiTpzR5OR//Kch6CZkRcLWYE8UyUayDUQd+agZcXoqaap8rkeisfyFp4GYEYz3WQ
         +auUAkye7phgd5dljdOcng3SvMb+waIpVNQSQzFO0xxMwSnqewGLwSqfntjzW4tETJ8r
         kjGpD+onqmbBUmkGwsIEhfRsh2R6OfSOTvKmzzk8eOV/9MEBHSMifVo8GlOU02IvqmKy
         ceaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYdo10f32NckHCIXZEb68VSH/2Pa5G60hUJFlsrnFHQ=;
        b=ckphZ+aIoGuspXR9yVY8Nh0BOQRPdJZGpt1LoeLqv88cDeeE5qUjj+cAuRt19ieUr+
         83UCx64ZGjnNopEN8Vv2ZD4EdOt4sXU0QzhkZ3mEDpvgSd0agHE15QHYC2zDqtCz7SqF
         vs1dK8M6XUoF/mj/+mrXNDawdGUSOKOhOZfvE7CowKp08haSq58invM01AFIm6CLG71B
         eIwySwtsMMHJN0+IEyUeYPEoSAr0YoOeAip7RmgraP+NuJYajhpY0Cj2Xej0Lcc3Yxw+
         Aj5N4ygYrbsXQJfooVZik4AHyjDfC0W82r/jq3Pf4AhBfV1MynekYp17W2a+HFx3X9Zh
         UNhQ==
X-Gm-Message-State: AGRZ1gLKIc2WomrYifl/IhD7fn2B8kBp1O6s54b8loeK/fwLur66cJqf
        QERhVsDRwacwBI/BWJtBnNHcEU+ywhoaPCHrJV4=
X-Google-Smtp-Source: AJdET5fuDisIvruPi3z1QlFMglbHL7OGue7AG051BWdUIR+hauk7fhlv5nOjeg7W5T0sx/IP2csPQXGioS/xjh9dT84=
X-Received: by 2002:aca:c1d7:: with SMTP id r206-v6mr13597415oif.44.1541429003665;
 Mon, 05 Nov 2018 06:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20181105142602.25750-1-david.abdurachmanov@gmail.com>
In-Reply-To: <20181105142602.25750-1-david.abdurachmanov@gmail.com>
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
Date:   Mon, 5 Nov 2018 15:43:12 +0100
Message-ID: <CAEn-LTrK2x3n9enzv=+CbCOFzVrX_RZXZ1wB_ktjkys=wzYfLw@mail.gmail.com>
Subject: Re: [PATCH] riscv: add asm/unistd.h UAPI header
To:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 3:26 PM David Abdurachmanov
<david.abdurachmanov@gmail.com> wrote:

[..]
> diff --git a/arch/riscv/include/uapi/asm/syscalls.h b/arch/riscv/include/uapi/asm/unistd.h
> similarity index 54%
> rename from arch/riscv/include/uapi/asm/syscalls.h
> rename to arch/riscv/include/uapi/asm/unistd.h
> index 206dc4b0f6ea..5545f498071d 100644
[..]

I forgot to pass --no-renames to git format-patch.
If you want I can resend it with --no-renames to make it
a bit more readable.

david
