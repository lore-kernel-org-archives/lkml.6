Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4992064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6cduVeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4992064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeGQU1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:27:19 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35206 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeGQU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:27:19 -0400
Received: by mail-yb0-f194.google.com with SMTP id x15-v6so910635ybm.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X9Rz7WBkO3RO2YqqvpcSq2TNOm1p+tqxWjq89IL/Qg0=;
        b=S6cduVeWwcRLPvJHBMor22+2wuz4Qc3qLUyPaedeDrducVcpTyg2hnmnvPz2P5GRWw
         sNli4thwZhdCTyyznVN/KNzKbCp1JxzVjNsH6xL/hs9biqBPVndBQlURV/Gbi9M9U5QB
         kzVTMnhLZb6+dhoefD4Q0g6ChljGEtKrlxGQ22Iez83sGwHciAQYvIx/Ftx9qU42Sgdh
         nOE8aC6Xqh0LiHSxanaLPSy60IUtVjcFjP59P139HzeA0r84MSC/af/74r0fYOJDyGkY
         zSo1yGz2fyZfaAo8eW528rYgp1CECsJfn9uxKD76g1DwSBqmMQEvN10SbWaO54ovPO/o
         /5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X9Rz7WBkO3RO2YqqvpcSq2TNOm1p+tqxWjq89IL/Qg0=;
        b=VVfR573DpDV5V5Xhb/RlO11ntVdH1aawRrHm8kUoU1ZypBowKe1NANtIT/Fvg9FyHd
         WdeZUMj8sFNTB+Tw3EWgesVTOijnHITXIvYRKPGNvoVTetyPAEOfGqQsSpGPViTail9n
         EapJXUvDIbm+MpW8vBkjFO5zDS1DoGVLo3LeMY3yq5IaMa/FheDch+8e8LjnrdToaMLc
         BUMWu2bGIEMeUwKt7exGviKeXMu+w9pykZiRPc6G3HirjnK3LOrCAsqGyJkntmGvEnrL
         BFcaX4Tw9JI62wycukZqYWzq7lN5+jaYS4fyuXujFXM7PPU2AO/5Lyg3aG6pEvhzxpwo
         aoDQ==
X-Gm-Message-State: AOUpUlGtTWn6u4nmU8MI07AQOxa/Phegps/WKf6Ew+iS0MYcRk91qz3/
        d0wBGaUWViw2NiQT7pEqaPIy4FeEvPgPsUq7H08=
X-Google-Smtp-Source: AAOMgpd81RfO7rYaxRMWJ89ooRRWPSf3MyXGtyCGuZmO1IID5Zis87uCq9g4GvL4oOPVwvtIq6F5l6B0jkWBsu//duE=
X-Received: by 2002:a25:844f:: with SMTP id r15-v6mr1675751ybm.345.1531857189719;
 Tue, 17 Jul 2018 12:53:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:53:09
 -0700 (PDT)
In-Reply-To: <20180717111233.5jsxqfyveibe6b7j@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717020926.176408-13-toddpoynor@gmail.com>
 <20180717101329.yl4hwob2jbjlp2uh@mwanda> <20180717111233.5jsxqfyveibe6b7j@mwanda>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Tue, 17 Jul 2018 12:53:09 -0700
Message-ID: <CAO3upoZZeYZySN03=E4ubUf=a8_EOc3i9KpTMmfR1yCHoo8AjQ@mail.gmail.com>
Subject: Re: [PATCH 12/32] staging: gasket: gasket_wait_with_reschedule return
 when condition hit
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:12 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Jul 17, 2018 at 01:13:29PM +0300, Dan Carpenter wrote:
>> On Mon, Jul 16, 2018 at 07:09:06PM -0700, Todd Poynor wrote:
>> > From: Todd Poynor <toddpoynor@google.com>
>> >
>> > Return right away instead of break out of while and then return.
>> >
>>
>
> Btw, I wasn't going to complain about this but since Greg is being extra
> critical about commit messages that don't explain *why* it just creates
> an environment why I also feel free to complain...  I couldn't
> understand what this commit does without looking at the code in context.
>
> A possible commit message here is:
>
> [PATCH 12/32] staging: gasket: small cleanup in gasket_wait_with_reschedule()
>
> gasket_wait_with_reschedule() is a little more clear if we just return
> directly.

I've updated the text for v3, thanks -- Todd

>
> regards,
> dan carpenter
>



-- 
Todd
