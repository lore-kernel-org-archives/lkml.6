Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFF4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2109B20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=livid.pp.ru header.i=@livid.pp.ru header.b="K2hrTzuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388717AbfAOSNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:13:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32998 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729915AbfAOSNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:13:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id l11so4093316qtp.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=livid.pp.ru; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fh3j9YTLp5zq/6RCMt05XuE8kd5C9ljjnTVv39l0UY=;
        b=K2hrTzuWiiw9/GsKZPDctC/Ily+c6cHowNXs5HUTK3scENBL5yE+E7WbJHuRFuCJvD
         iuaMduOc7TITwFPCnG70ZDrnaIkSVcG9lhMFiyBUHxoer13wK0IuRjnkk4zd/2Xpz7u1
         2g9L7dkMEUrBek1dydbihB0Q5rqyOhpITD2fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fh3j9YTLp5zq/6RCMt05XuE8kd5C9ljjnTVv39l0UY=;
        b=HdYfrJGALoVCgKuWXLwYteC9CV2oyhhnVHlY5DRHtvRweydPu7NxsuF4nzZKegXF/x
         66sOyTbP+w53SXC5Pj7q7Re5IhTzMeNYZwJfHv0HRF/r6ecgdc4vuedDjS7uB6oWu2XZ
         AXD0FQikUXHg6IhBcj+iVDGHoOjRB3vYoVTgZ7u4kUDQhibewqnEOSGzBJGT0yXReaR9
         hhxML36yXwpYltGRqMtUJEtT3yffuHqv2SdGjGJCibvizmtdjDokgJFPsUJX74wgA2I1
         EP3ToL6nF2mD2N0nLF1rR8Kaj9H1F5etkI+BceObyugPTz9R1Nxl9WPgJZlzWkQxpkk3
         HDhQ==
X-Gm-Message-State: AJcUukeI5VlsUlfwZYZLC/fbNH9xlirVyM+gACanDHrNX3KDebiKf86K
        4diPpIjylZimjvm3UerphU0XEuzfnHV9uxN9vIQzRQ==
X-Google-Smtp-Source: ALg8bN7wT3YGy/oW9RyyRwlmpA9kVHM9pSG3n6XMfE3Ieymp7Vb7kQiCzYDKGjWWMhL/HAKQ72g1JarltOIFrQ97yR0=
X-Received: by 2002:ac8:29b7:: with SMTP id 52mr3886420qts.266.1547575980547;
 Tue, 15 Jan 2019 10:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20190115161354.6806-1-root@livid.pp.ru> <20190115164016.GA25341@kroah.com>
In-Reply-To: <20190115164016.GA25341@kroah.com>
From:   Nikolay Yakimov <root@livid.pp.ru>
Date:   Tue, 15 Jan 2019 21:12:49 +0300
Message-ID: <CA+A=rXGasgnuHC_Gr_gsiQ6j7NAVxBSKGWAebOFVt3JhFP6vKw@mail.gmail.com>
Subject: Re: [PATCH] USB: Fix configuration selection issues introduced in v4.20.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saranya Gopal <saranya.gopal@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tue, 15 jan. 2019 at 19:53, Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> Were you able to test this on one of the devices that ff2a8c532c14
> ("usbcore: Select only first configuration for non-UAC3 compliant
> devices") was created to fix?

Yes, owning such a device (non-UAC3 with multiple configurations) was
the motivation for investigating in the first place (since it was
broken on v4.20.0 and v4.20.1). So the proposed patch is tested
against it.

In fact, I only discovered ff2a8c532c14 ("usbcore: Select only first
configuration for non-UAC3 compliant devices") when preparing to send
in the patch (it's not in any released kernel yet)

>
> thanks,
>
> greg k-h
