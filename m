Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E0AC7113E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A4E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+B5YUF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A4E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJPFCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:02:25 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37790 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeJPFCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:02:25 -0400
Received: by mail-yb1-f195.google.com with SMTP id h1-v6so8073497ybm.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q7DCRXHEMau44GgTgT9U9Gyw18D4AVyK4HnNw+Y7ztA=;
        b=G+B5YUF5fxeIjIgWm0SLF1c2nozgNVIzvQQvAk2H/QitZBQIbNIAbPML5Dx5tMR1jT
         EmI0ZJS7eBFaYUgaWKhx3o8MqZQOtia9l6KO3ItTmN7QLOmvDaWxTMzUi7oBFEARtj/Y
         CGBaYZEsxW4MsQ486fjjtljiqkF+x1G1fTMIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q7DCRXHEMau44GgTgT9U9Gyw18D4AVyK4HnNw+Y7ztA=;
        b=laQ0SNv6o0EKE6VkRF5lQsV9UCODrZjUvuCnu8Wv73F6TkwCc5rIeV9yRUROixdPBD
         dqVBwk6M0C3uqfTnOvagnROxtkjZSiz+K1gHAp9xLDSMbbf0iCIEAY3x5ZMLmoEBj6Yh
         3gCEZsOap+bGLm7z3kq+PQrh+TklNPjmKM+Q5rEZPP71orFeDeOVU9gqNSsnDgP+khBt
         70UyjLgxVoSHBHHJBYser/bw5YMjRXMUPkzYHBG+SIWSGT8RASSefLtji1YZ4M/OZscv
         I2tgUcoK0Uw5AbFLhyKkbtXS02GNozdiNIZ+8Uf6fc+qU0Q5lZZsiGPOX9SBuQyAs1fB
         Ui2A==
X-Gm-Message-State: ABuFfogYwVBtaicyExGX6esCVz8fFH/6zEFTfEwY/zcqL8cDeuIOZy6z
        QWeju0m+no1hRdu2OHeRrLAuacEGqeI=
X-Google-Smtp-Source: ACcGV62ImNNv6YN6kkd4IwUCUvDHywSdgPa9cTYWk2zi1j489M5Axym6LIH5H/dwNrtjNL06C1upcw==
X-Received: by 2002:a25:2a05:: with SMTP id q5-v6mr10418995ybq.63.1539638125582;
        Mon, 15 Oct 2018 14:15:25 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id z20-v6sm4212652ywz.75.2018.10.15.14.15.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 14:15:24 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id e190-v6so8065937ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 14:15:24 -0700 (PDT)
X-Received: by 2002:a25:640a:: with SMTP id y10-v6mr10267332ybb.421.1539638123708;
 Mon, 15 Oct 2018 14:15:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 14:15:22
 -0700 (PDT)
In-Reply-To: <CAHrFyr7nXUPxysMNv-HHRVSCB3UUmSb60qwFM8zg3Zv41NC1RQ@mail.gmail.com>
References: <20181015192710.GA18693@avx2> <CAHrFyr7nXUPxysMNv-HHRVSCB3UUmSb60qwFM8zg3Zv41NC1RQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 14:15:22 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+S8fByq56DBrV3xQsoPmM9tXMa+Jm+ViuUcoTL3jM1OA@mail.gmail.com>
Message-ID: <CAGXu5j+S8fByq56DBrV3xQsoPmM9tXMa+Jm+ViuUcoTL3jM1OA@mail.gmail.com>
Subject: Re: Re: [PATCH v1 1/2] sysctl: cap to ULONG_MAX in proc_get_long()
To:     Christian Brauner <christian@brauner.io>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:32 PM, Christian Brauner
<christian@brauner.io> wrote:
> On Mon, Oct 15, 2018 at 9:27 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>>
>> > int kstrtoul_bounded(const char *s, unsigned int base,
>> > char **trailing, unsigned long long *res)
>>
>> NO! The whole point is not have million variants of slightly different
>> integer parsing functions.
>> Cap it in the sysctl -- noone would care.
>
> (Please keep the CC list when replying.)
>
> Whatever works; I prefer the local strtoul_cap_erange() in kernel/sysctl.c as
> well.

This does match the standard of "evolution" for the kernel: there is
only one user currently, so keep it a static in sysctl.c. If we grow a
greater need, we can move it into lib/.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
