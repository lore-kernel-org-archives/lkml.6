Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VT1BE8VoGls7TwAAmS7hNA
	; Fri, 08 Jun 2018 11:30:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D8F6607DC; Fri,  8 Jun 2018 11:30:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkA7ZJ7R"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C10A5607A4;
	Fri,  8 Jun 2018 11:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C10A5607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeFHLan (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:30:43 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41500 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753014AbeFHLal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:30:41 -0400
Received: by mail-vk0-f66.google.com with SMTP id 128-v6so8005590vkf.8;
        Fri, 08 Jun 2018 04:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PtqnPgv/izx9x3gygYCeaJ/l9Pa8S2EjeNmDPXiMRdA=;
        b=NkA7ZJ7RlFNCief4mU+KA6lmgfP/F/YYOxhiWxG9T/4vCaMH3ay4jwmpNleDofGa0/
         qKx1J968izLvqhn5sU1KRkVpN7AWTNBhag+Ao2Ko04iGv6E3yvamm/zgXVCA7b2+M92G
         4YvCy4EbdFqGJp0x+OXY/3VkrmkO2xHeofLDP59vHIYq0UNdBaIxL52H1W3icrlLwAYl
         nVan3EnMHQwc7fej9vcsiEE71F8KKwwLLPbCIAgXvo9paEsLcz65gwBMvRX06xDHfO7h
         kXhWmy+b9F1Ddzdlo/ewNllFIVeb9Ft/OjfNSFtEtzWPpWuAGyfL/Z0fAS2JhayM4CsE
         4pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PtqnPgv/izx9x3gygYCeaJ/l9Pa8S2EjeNmDPXiMRdA=;
        b=YQG4ltyOzhU2erj8kuyoc5rPGhMvB6dcYmkoHH4jMF6XNfAjH4aD4bWIxwyauQmNk0
         szTkjs89Hd6orBtNV4Krtkhd3t5t4CCJXfC6Wd2dexoutLMdEI+8zDZbGqVR0Sh8ngEX
         cswSwf2M/g9jQxGrKDKLtQpxhExR2w7ObwvBO2TRKZPep1gIVx0wlbEVdyqUHtpzbBXR
         c7Re0AeaWRC3RbcTWd9eKt8jY01tmKTFp17WTA4E7lUWLtXfKAPaAiJwj+bVUFGKdjvP
         1O3mKN1gVpWMtpR5ofXwcD7IFTXGdN5hqPb6NqDvh52NqPvFM1tKoI0oii6zO6Cf+IzM
         qFEA==
X-Gm-Message-State: APt69E1FHxwe0YJS8lBqfxNeF8byvKqC20VHYHHns9k8YNl6lBsNFSzs
        gucd7RNvmpuacihJxsWeRK2d+1czRY7mQnOI9dA=
X-Google-Smtp-Source: ADUXVKIMdXkEsD74lImgUtPHcqt4Nx59bgGpPDiQnzYtXzixVM8KM65179Hpz5PSQ+UQveAjhouiyC7wjQ+FSwVKHF4=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr3568117vkd.187.1528457440494;
 Fri, 08 Jun 2018 04:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 04:30:40 -0700 (PDT)
In-Reply-To: <20180607203617.11240-1-hdegoede@redhat.com>
References: <20180607203617.11240-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Jun 2018 14:30:40 +0300
Message-ID: <CAHp75Vfvg=5MGm8a14S1gK-tN6=k71OeZr2JMGhY+pBvgcuzmA@mail.gmail.com>
Subject: Re: [PATCH 0/3] platform/x86: silead_dmi: Sort alphabetically + add 1
 more model
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

On Thu, Jun 7, 2018 at 11:36 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi Darren, Andy,
>
> This series is mostly about sorting the silead_dmi.c entries
> alphabetically to create some order in the chaos.
>
> It also adds an entry for 1 more model.
>
> Note this series applies on top of the pending
> "platform/x86: silead_dmi: Add entry for Chuwi Hi8 S806_206 tablet touchscreen"
> commit / on top of the review-andy branch.
>

Pushed to my review and testing queue, thanks!

> Regards,
>
> Hans
>



-- 
With Best Regards,
Andy Shevchenko
