Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BCBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756792081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBkk245t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756792081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbeKADSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:18:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35452 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbeKADSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:18:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so11526280ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PW1gMK0PPl4ZKLoyFgZpH1RLxA4W+aDK5kvsaTAUwg=;
        b=fBkk245tSDULtm9o26Jv82u8XS2tcTQl07fvxJnffdz03JRPbltFdjFxnq8ayldW3X
         yaNxDoJ9kem+Ic3ncCvwg9jU2BVtt8FV9wlU78uIkJzyItVsueyGjjD9EI3vwL6gQePi
         diBTTD5/3nLuGZ/WXJshMjMXNSouTf+6Iko/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PW1gMK0PPl4ZKLoyFgZpH1RLxA4W+aDK5kvsaTAUwg=;
        b=CKuVrybvf75jGUJghR+7AogOUtfgtbwls5RA3t9iHhQCowNdMNYej7Y64qy6wnlbD3
         nUd0xrndrFDao3mkI+ZfcirJGnCpKxM89cW6SA8Q9ygzj8EJttTB/kVXnKKbxxcyBAeI
         4yanvoHHw+0UhDuT+coQq+KwHKjTVhaFz2BgctblV0B+ewsHklxnj43/vLfV00WKL6+t
         Gmqbb3qD4b8+8HeAITROPSRCE/ErUWsDRc/uKi9FormW15F5jdZXQY/BzIWFXNroQJdI
         tDLJuQCsudJjQz55jE3+mV/3U2eCjc6hDGUGUSmVYuW+u6UiGIgWgh9Blzotxty7Bsjx
         JISw==
X-Gm-Message-State: AGRZ1gLEwDRrP1ldYdd2067owl/3i8gWbsTYWh0thzUIHU23D3w5AQnV
        FwBIscf1KwgsaCSdkelz/33jZRJMeNY/vg==
X-Google-Smtp-Source: AJdET5fHWJHuwCm3MLo9CpUif5ANHPREK0qGgG9H64FXWYCys+/tqzGu8kAntBkuWlaLuiYCLfBjqA==
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr2690308ljd.148.1541009984238;
        Wed, 31 Oct 2018 11:19:44 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s69-v6sm4334406lfs.92.2018.10.31.11.19.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:19:43 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u18so12379951lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:19:43 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr2418750lfj.16.1541009982705;
 Wed, 31 Oct 2018 11:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181030233954.180489-1-sboyd@kernel.org>
In-Reply-To: <20181030233954.180489-1-sboyd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 11:19:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwUobiCaLNNm==z9KQ7g9cCUxmztOBRtCJ-D6PLo-3jw@mail.gmail.com>
Message-ID: <CAHk-=wjwUobiCaLNNm==z9KQ7g9cCUxmztOBRtCJ-D6PLo-3jw@mail.gmail.com>
Subject: Re: [GIT PULL] clk changes for v4.20
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 4:39 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> This time it looks like a quieter release cycle in the clk tree. [...]

Pulled,

                  Linus
