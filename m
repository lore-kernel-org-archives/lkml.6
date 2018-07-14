Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9573DECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62EE20873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncO07Pnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62EE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbeGNTky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 15:40:54 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44089 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeGNTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 15:40:54 -0400
Received: by mail-yw0-f195.google.com with SMTP id k18-v6so12913493ywm.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wvLa0VU3H1fgvh+Dpe4d1kFglH+s0YTBrfSvG4uOTro=;
        b=ncO07PnvvohSW3VkZQfDOQcWAvfjKsgb8jpT0PYadlOEln8FpWOYqEqmrFsxK4bHE2
         Brhq65NuEqKxKYIFcKSNRUq+3EokwoP+vaMo6vGn7wLY5M1zm+bErFKwX9XpQxIGgGvj
         a6j0rFLbQHjBAehUS6WSgQ/88YZ9Al0UpLaCATQXbByjEZymLibVa0RX40jZsNlnaAYK
         qW0KUmsUu26rwvHn9FrWeO+pCxW08Okd7rgF2S3oKd8MuUzbvkJf4xxuUSiTOA2evcS1
         1hzEAXl10sZ+x4zHjbWgosRR43wxsJGIztIINIoNhSpup8ZPix0QKM8EDQCQdtvDER7J
         qlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wvLa0VU3H1fgvh+Dpe4d1kFglH+s0YTBrfSvG4uOTro=;
        b=Ie4whJY2h8WPfVELOsDuvt1K5nbUAirHY8+JC/WLUmw6sMlBZWUBbyHk7q/qViu/Cg
         5X86YVqjQmtMEuUGms50z6EUEjqRxGqtAA64AyoMStXEmdELgP7iQvDz0lkKxMzRhNcP
         irqiEBIZ5VW4cyGFkjoxhBJ6FQlp35aG72NiwHqR7fi1/HoIBaB4Q9tS324WhedwKHmD
         IjYJXXVwJ9wN9zpN3y19tSsqHGnsZ3otI1ORptVyVVCkyO+YXjDhOC+tonWSOQQkZoPn
         Xl5heEuEdLC5qSbCG+XxlDo11CDZJZQMT+eHRn29MjxrCxBDgwys9Zo2re3zFjzQzVYO
         RIRA==
X-Gm-Message-State: AOUpUlFS/geL85+ppMySHLGRaAZG2TUrU5gzBan8rDD/cUMa8QkJpAXh
        HfAusag4Gy8mSFX/sPinyELuIorl59rIOfhoK34+Tw==
X-Google-Smtp-Source: AAOMgpe3wi16KT0Oj0rhy0QCH0ERCKmBdkVb9gTa9s6Zft3q6X/VQ+arcBIngHaC69sn9rGNFDZ5GvRP7tvhp00wndY=
X-Received: by 2002:a81:86c4:: with SMTP id w187-v6mr5581530ywf.424.1531596051784;
 Sat, 14 Jul 2018 12:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 12:20:51
 -0700 (PDT)
In-Reply-To: <20180714074450.GA22469@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-13-toddpoynor@gmail.com>
 <20180714063502.GF20451@kroah.com> <CAO3upobyf9JpKLSoSPeVfNGOh6R0cud=hT+bhA=U2kNkGEJ-aw@mail.gmail.com>
 <20180714074450.GA22469@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Sat, 14 Jul 2018 12:20:51 -0700
Message-ID: <CAO3upoYSywZWQCnhYijzEeNdr+ONXxcX3kJVv6nKUeqqe52ujQ@mail.gmail.com>
Subject: Re: [PATCH 12/18] staging: gasket: annotate ioctl arg with __user
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think I'm following http://www.kroah.com/log/linux/linux-staging-update.html,
>> but if I'm off in the weeds do clue me in, thanks.
>
> That's something I wrote 9 years ago :)

Still the top search result for how to work in staging, suggest an update. :)
