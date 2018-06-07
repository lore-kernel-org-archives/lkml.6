Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3v8xHyvhGFvYDgAAmS7hNA
	; Thu, 07 Jun 2018 07:41:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE5E76089E; Thu,  7 Jun 2018 07:41:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV+1bYX1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BC43F605A2;
	Thu,  7 Jun 2018 07:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC43F605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbeFGHk6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:40:58 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:38897 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbeFGHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:40:57 -0400
Received: by mail-vk0-f67.google.com with SMTP id b77-v6so5446707vkb.5;
        Thu, 07 Jun 2018 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IhbXr3XGzblDl/JJj0kqEmHub3LitPrdfd5qksvq/gI=;
        b=rV+1bYX1ohPHdPi7V4eFQWEr0WFVxOOIKFoOGUcC1PAk42wKB1MGQwqshOfinjQ6EK
         ZGq/d5iMy0/lSMwUZgLoTuclMb763asqFlYZen53Ru96YaDDS+w9l/UwZO5IYtJaWZZn
         AnuHt9WQwKXhaNJJm5YRVHYJrFFtDMGD/+x/r7UpCR9NI+mYW9Ew6wsyD32qeb4kveRK
         xhCmwLtuKBYjhsfqXXySeEazt922S7z5AUvYMH7YypliTsx+C3kn7t1qRthGJ44b5SoQ
         /CUf15T76xhgBSIPuhCWET21TOSb7+GCYFqBlu9eu3s2aU4ejHvdOqH7eJKmv1nbM6PC
         CUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IhbXr3XGzblDl/JJj0kqEmHub3LitPrdfd5qksvq/gI=;
        b=o7sMqMTsmKMBzWF4WlM7pF9i+BTyh0bb0moOFkhQGYBTMM2/zksvqHlrJYQQzrKofT
         Y1AQp/n25ay+TcE1gmGBelD1lT2l+QGbOYG3muwC2b2G+TPm3iDxltlsqGF/91AYt1Hr
         4BytFpm64Js02bSFiMRoT8Gpg2tUxc9s4G/N8mDrpa4nGWuwDMEqo5ckdRVN6NSTDKeo
         5+22Q6zaN0cMm8R+eiui3P8agSZdMv62oubifSpxrXIo47XHah5KsnUaevWS/0sT/j6V
         m4E1POeUyDHHbFHsPbncH66AzHbUET/NJIqPBlYspmbz8a1UfhIJJRVE9+vLHzN0Y6T6
         g4LA==
X-Gm-Message-State: APt69E3OFqKyYaDX2gNOIFlR6vmHsIDTzxevw/UKPN9u5uVp5cpz+4zJ
        vDNBAwx7xGcf6kK520pP2tkb04h4N3CZy+GTaqY=
X-Google-Smtp-Source: ADUXVKIJrtGoV2gUe24YMmRVjmldr/3UpMQxvgr0jPkBHWVTH5Yesj9Q+Cpr6Hn66xZGzqfnTlj5Few2dQUtgPDINCQ=
X-Received: by 2002:a1f:e686:: with SMTP id d128-v6mr444433vkh.176.1528357255799;
 Thu, 07 Jun 2018 00:40:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 00:40:54 -0700 (PDT)
In-Reply-To: <3317638e-8688-35ef-ab61-7281312f2c3f@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <20180606100003.17067-4-marek.vasut+renesas@gmail.com> <CAMuHMdXdoAaBbx+_G3+n=e+zki3z20t7ATXttDUnmYRu95HMVA@mail.gmail.com>
 <3317638e-8688-35ef-ab61-7281312f2c3f@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Jun 2018 09:40:54 +0200
X-Google-Sender-Auth: jajNMa1WLVKhp9kPf2NIghb8OMs
Message-ID: <CAMuHMdWsZYDeqS4jao0isVVVpG+gFFW1LkOGhcnU7U3+6reHAA@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] mfd: da9063: Use REGMAP_IRQ_REG
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Wed, Jun 6, 2018 at 6:06 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On 06/06/2018 01:31 PM, Geert Uytterhoeven wrote:
>> On Wed, Jun 6, 2018 at 11:59 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>> Convert the regmap_irq table to use REGMAP_IRQ_REG().
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> Again:
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Added.
>
> And the obvious question is, what do you all use to collect these tags?
> Doing it manually sucks.

1. Add green star (in gmail) to email supplying tag,
2. Once in a while, filter using has:green-star, and git rebase -i my queue,
   adding tags and changelogs to the commits in git.

Hope this helps.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
