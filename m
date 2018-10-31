Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C360C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E802080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tsxx4ZIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E802080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbeKADob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:44:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43424 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbeKADoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:44:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so14534642lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jMi88DNx6KER93o5ommpEFeTPfu6VbrbVU2DkKOHFU=;
        b=Tsxx4ZIE3QV2aPb+52/xMfOiLnhfJh6UR27njzE61TC+S6TI46sj5zADV0SiEkS7ek
         VQpwaadky0yiXrhfvIHYsnr/TtXN1ECX1GMaJ+zEdfy1+rTIVhztgKocGChLC9GDqCA6
         kgXGyfBu3OCpwP5IKLGHc0flpvjdPNLcgJb0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jMi88DNx6KER93o5ommpEFeTPfu6VbrbVU2DkKOHFU=;
        b=jVTO6him8eCczfrzdTIv3tcTQ/4G6xF2iZ/c3POqWRImXGYwKCKjQTMKoXz+WKrmrh
         /LySw0fCYWF/onDPNBOCUO0OeWHTnPWL9POVgoy/s1AV8l4wqEh461aKVB6BotMJLKX+
         ofm7bAPH3eAxWc50+avTeFdYDNj/CR3MsdeBFF4CGGF2G6Az1JIy2yqwB7oXNr4DHduu
         Qz2VxUdQ9Wl4Kl/y5bqcotYWLSRSFRbPGBI8Q5QAIWW96l92mx+w2ygBm5zFz/WEL51y
         NKX019dNoFd2wYH5iLc9+fYoMBm027v6KFIWHoCiAjubLuszqy/0Fdqt+xLJ8WshsDzr
         e5aw==
X-Gm-Message-State: AGRZ1gLxX1dOAcTD++Di+1ker2zNHR40AAswfZOIE4gwX+IXpDh+fbgk
        FymVGP76v5hZATpkcpuLldD2PX2f63PVAA==
X-Google-Smtp-Source: AJdET5eJalsp5VNl0tjXxJVMwAVHcYr85pMiH92uQaAPk+UOXoJb0RT9aOixC6lDetEX1PDQ3XzmTQ==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr2441783lje.115.1541011513253;
        Wed, 31 Oct 2018 11:45:13 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id l63sm1400007lfl.76.2018.10.31.11.45.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:45:12 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id s15-v6so15820808lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:45:12 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr3058833lji.133.1541011511794;
 Wed, 31 Oct 2018 11:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181031143114eucas1p17d216460a93d5d5e29e71609e2f2214a@eucas1p1.samsung.com>
 <c0f72f36-5fdf-4207-03a5-fd903ae4d278@samsung.com>
In-Reply-To: <c0f72f36-5fdf-4207-03a5-fd903ae4d278@samsung.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 11:44:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRGtMCFYxaDwYQDQbP1OzGb=ZhYdU9B_DdU_OKt7gwoA@mail.gmail.com>
Message-ID: <CAHk-=whRGtMCFYxaDwYQDQbP1OzGb=ZhYdU9B_DdU_OKt7gwoA@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev changes for v4.20
To:     b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:31 AM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Please pull fbdev changes for v4.20. No major changes to the subsystem
> itself, mainly fb drivers fixes & cleanups (atyfb & udlfb updates stand
> out from the rest) + removal of no longer needed old clps711xfb driver.

Pulled,

                     Linus
