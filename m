Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC8CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF87204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJTRl+dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAWTdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:33:50 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40071 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWTdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:33:49 -0500
Received: by mail-yw1-f65.google.com with SMTP id g194so1383309ywe.7;
        Wed, 23 Jan 2019 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnToHkSh61f+ZWdK1bgFPkgQMmcdK9rBCE3uZ1ELXOo=;
        b=WJTRl+dwlzTfij1LWYpZHvim8gynTW9jCn2f3xLjbml7tZ61vX4WSfes7bLTYr2AUJ
         K4tfCoFDeioP5VlGN+xt6mULywnlyY2UGJZ82nGOcm2ERd65wIiD94nBt9L3Fl9opIiR
         +gngU0lmYuXqAgA3NT6qkDWowUUak3YaZSqvhoj+JDWXl8Sfted0TVrYbpj5P/hADMVk
         i35MvjtSep83MgwNsNFZGKAHFpFLictkCFTTI4RwUb5/D2lwYotmosjf18YHhZMtOr9b
         cj/e6+IjfLv0FAI28ZOxFN0CAo0/MCbK6BKrz/OmXcH1Rx7KPlkAw2bWaq/vWk+kyCaf
         8WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnToHkSh61f+ZWdK1bgFPkgQMmcdK9rBCE3uZ1ELXOo=;
        b=gvfl9NP7UpCkQBnWmbsURdNdjK5ua1LpWH+RovuK7ERmyxxYDVndSNW4txolEDL8Fc
         JSdiJdbT9Ac1s7+/wSmlj3H7VjZdUczmDtNwptoAeQLY3GoP8n335zzLkktloCw10R/i
         n+ogrmjYDGcHGk3tFcEyBdDg0kM/k0RwtdHA62wfSnSgm79no5iNA0JppQuaL146krOu
         wYi9OVYNF8d2O5jFmugnPCh6bxbxeKQLvvnuCC21Zi1KJGYAWxE2tbN3KrGSqaGQnl0d
         MagCHc4QbIBGSec5q76tTUmbAKwkFXmlXQ14nILRswqnZt+c7YWFeHsbwqnGe3frZ3Rk
         85aQ==
X-Gm-Message-State: AJcUukcbE9dP+Wm/lMgRqJfbxFXu4Cc020zcvoHwLoC7VQInjABOZS93
        4OHIxzzrT9R6ClIs1iy5wmyzznmRM2z28F5UV6k=
X-Google-Smtp-Source: ALg8bN6MAMek4jX+5FseZwTmp5ebEpEKTz/pHUkTn+HeLX4AKWzeE8N0IDyvjntjsLDbqR1U3aCjqaJ8+8MPiIOlbss=
X-Received: by 2002:a0d:ea81:: with SMTP id t123mr3461531ywe.496.1548272028680;
 Wed, 23 Jan 2019 11:33:48 -0800 (PST)
MIME-Version: 1.0
References: <1548236958-17565-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1548236958-17565-1-git-send-email-clabbe@baylibre.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 23 Jan 2019 11:33:36 -0800
Message-ID: <CAMo8BfL=MX3GhggPbaKUFj5sPme5W3crDEMkMU8BgQJARcMjRw@mail.gmail.com>
Subject: Re: [PATCH] xtensa: rename BUILTIN_DTB to BUILTIN_DTB_SOURCE
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Chris Zankel <chris@zankel.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 1:49 AM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> When building some xtensa config, I hit the following warning:
> drivers/staging/mt7621-dts/Kconfig:4:warning: 'BUILTIN_DTB' has wrong type. 'select' only accept arguments of bool and tristate type
>
> It is due to some arch use BUILTIN_DTB as a flag for the need to builtin
> dtb but xtensa use it as a string for which dtb to bulltin.
> But for this (which dtb to build), it is better to use
> BUILTIN_DTB_SOURCE like other arch do.

It's odd that we see a warning from the driver's Kconfig, even though
the driver itself is not selected (it depends on SOC_MT7621 which
is a MIPS-based SoC).

-- 
Thanks.
-- Max
