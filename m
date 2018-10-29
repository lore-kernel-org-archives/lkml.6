Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568DCC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEA22082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hCSPPPk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEA22082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJ3Axf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:53:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34726 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeJ3Axf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:53:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id n26-v6so6484308lfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOR+/qpjesTItd6MxR6cNimOvMAh02mh0J5kXuL0fsw=;
        b=hCSPPPk0lAVAPBmO4LmsIW0GJgqXuCvqAroR6CD0l5p0ejbKolsGpZY99BkF/WRRKk
         nUMW3zZ4M/FVw3s3wnSHVFY7gdCYUxHm04DLVZTu/OpNIEpNVCbbWdf8XW/ueYniOUK0
         RlJfCFRBZu4DWGxtxeo6dwjdyqzbg1h87U968=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOR+/qpjesTItd6MxR6cNimOvMAh02mh0J5kXuL0fsw=;
        b=a8kqC2b0ekV8vksuTGbHxGaqqcaLpwfAy81o10NA1sYVuvClJ/zfY7xMrpT8uRppsE
         G9+pt7JNsdPyGj9Xq1qWt/+vpKkZh+ghjdbBXRHdfg45UYtCw900nMBLFqGg0nFw00BI
         e1fPB1oH8JlvLWL3/1GIpTS5WcUVwxHR69mmm48LNwF8WQXsKUI+NLDTiI1IVPE4t2kf
         YWA6PA41qGPoQTtRU61QnqlSa3yyMzDxCH8/3laYPlz9bomOSMA5TiZrgdSLJgezZumH
         abt8Gx19O3CYzqAezC9RkeMS7UytHOoaqG4mp8eZZCEfKoHeyIUJxHAZaZqkGBZoSIpt
         K9bg==
X-Gm-Message-State: AGRZ1gIeW1unbArTlG81YOiO/Ch46M2Mcsm5OQnvPtCTWWnRVT01XBDd
        LY4uPQbpNxA2UqvbK2esxoMYLqfJui8J2g==
X-Google-Smtp-Source: AJdET5fq1oCqdlXogNATTxUYjuuoNkfd1X74N0a2S8KHexfZ/RxGGG9i2rMlDKFRK3goxOsw6BXIaA==
X-Received: by 2002:a19:db82:: with SMTP id t2mr8190800lfi.130.1540829059308;
        Mon, 29 Oct 2018 09:04:19 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 9-v6sm3102527lju.61.2018.10.29.09.04.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:04:18 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id u18so6451408lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:04:18 -0700 (PDT)
X-Received: by 2002:a19:4287:: with SMTP id p129mr7912528lfa.135.1540829057646;
 Mon, 29 Oct 2018 09:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181028100124.2116-1-geert@linux-m68k.org>
In-Reply-To: <20181028100124.2116-1-geert@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 09:04:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2ciyxuopo7H7V6Z3A9cyGGOp6xg80xRsJLnYCrFCBEA@mail.gmail.com>
Message-ID: <CAHk-=wh2ciyxuopo7H7V6Z3A9cyGGOp6xg80xRsJLnYCrFCBEA@mail.gmail.com>
Subject: Re: [git pull] m68k updates for 4.20
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, gerg@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 6:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> m68k updates for v4.20
>
>   - Just two small cleanups.

Pulled,

                    Linus
