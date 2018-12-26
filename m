Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02792C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6EF214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClCGRR0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeLZQD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:03:29 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:35017 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeLZQD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:03:29 -0500
Received: by mail-io1-f42.google.com with SMTP id o13so11186228ioh.2;
        Wed, 26 Dec 2018 08:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=ClCGRR0xat3w9Me4+d+kcoiFPdM7rVFMtMF5/h6f+K4vOBztGhQV77lfBBMQq+jI29
         WSD66D9zFY7veAFkBV6RqUwgoOaL2Fr1HEmLISwxZzs5Hu7cWcOc6cg4T65ae6+//FZF
         5DWzMowJ0dKa5iSIDVuVTecN/Ngqyt63P+EPfVzEKUENYiG874Pgjtt+HZyfOmccujAM
         nuv+Hc4Yg3p8OeVWXEmWgbYYkz28YrX8pkPXAcx9zrBZSTXK8jEKlBJ/R9hILLICJvVE
         ajPG2JMcFoZyPpku5OcGA/YeObXOR6CVN2pyNWklV6AAgV3vpWn/6StNRf4p3G1qdDXL
         kVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=QGd2LkORbI4w/+7uH1TdKGmkbDU1joZTbeMft5CzntfZJjpeYUQK9vMYT8UW6nYVoo
         7F4Vc5YIcn5j7sEFzBXbcO+cO8SMnO8koPXioBZcQXS1A1wpcS1z1XNWoVPW5DJGZPAp
         IYVtzcgGj4WNKLA1K9n0N2t9pdWH2m8QVJjMhY4pfl13iuaMExrSBhwOi4P5xyWTy62g
         jo1HBEoKxaMwxEL+xT3WGU+eodE54iC2s8Xg1xkFvQOqm3aCXifOZXmeaGRII+/gC5nu
         oX/fOm0WYufO2DKmPyN8oN5+0EFCvTK9A1tPiYU5AsDB9ffhMJMECeXTzXUXDsscTVVa
         fgVg==
X-Gm-Message-State: AJcUukcLURkrLN/cCC3aK/XwYu7yuG+zTqIMLceHbNjr/B2l3YGGcGUq
        2pj+FipH0zGse/Wbxi1esP8qH5um2ftRXU1NR1o=
X-Google-Smtp-Source: ALg8bN7XubjncTq/wg8LpjqiRhXw7Sg5DD3cCjaV4qUicjiwHiQ93wUi38GeqoR6y4Km9KfQsDtilnoaUbX8Qg6knIs=
X-Received: by 2002:a5e:8b46:: with SMTP id z6mr13343728iom.7.1545840208587;
 Wed, 26 Dec 2018 08:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20181122142551.25367-1-tiny.windzz@gmail.com>
In-Reply-To: <20181122142551.25367-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 27 Dec 2018 00:03:16 +0800
Message-ID: <CAEExFWv5OTpSC0A2jvr0+w5nMtxWk9VDThdk4T1d+2fi0AV7FQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: axp288_fuel_gauge: Change to use
 DEFINE_SHOW_ATTRIBUTE macro
To:     sre@kernel.org, hdegoede@redhat.com, Chen-Yu Tsai <wens@csie.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
