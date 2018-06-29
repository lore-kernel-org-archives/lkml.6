Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3EBC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C1827DA6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DUSMr9qG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DhC/8qu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C1827DA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937298AbeF2TrG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:47:06 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39883 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933642AbeF2TrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:47:04 -0400
Received: by mail-yw0-f195.google.com with SMTP id 81-v6so3999114ywb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lwNJOhLqgdviurbFlLqdrYSot6ycTMlaqs0G7YtXJiA=;
        b=DUSMr9qGA43/IOJ9JQrw8VjsLNjfsASsFJucYwRw9wNudQxVOxmShpLE7U4dYslVDM
         wuTHMlANwm7vSu2cvcdFumPbHZJhY6uaNAKa/dEHO4Xb+HrrPXQ/o8dybb3o6UJEGlCy
         uAIL+ToBAyfUMIAms021EWzJ5fxDDp4FKQw0g8njdCu1ICMqWrAje/azKGCB9RbOoAS/
         y3c8gDvvXL1AkY6Bi/PQjf5EaFK0FEKsm1SF1eKr18Q1kjpCt2iWw2UL8ODnCAYXPRbD
         nktIPEErHq5X6AYeL1sY8m2OFB5tOuZT7xIbS7j0XaAMHlVF4x5MtP18YKMpAO94nop8
         M+Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lwNJOhLqgdviurbFlLqdrYSot6ycTMlaqs0G7YtXJiA=;
        b=DhC/8qu4VyCOOnZoidM9vWVUKQEbTqfCx7A/CdFSfC8Z6ipZASinNhoBCbytwKp+z6
         HxzPiUWC1MgmpJXFhtvEca4uWIxaN7CmRXJpiB8P7iyoroFiAoAsaXGe7ETlEr5pIPH7
         qTLtXgdnR+5JlXFjBrjStxPvtVzynIQR9/aP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lwNJOhLqgdviurbFlLqdrYSot6ycTMlaqs0G7YtXJiA=;
        b=GrrF/G1inYkycXI1S0zOBMhd35dscuWoKkXo1+IQsNUu3BfBxRZi7fXVfK6m86Cp3Z
         AM8/589cw08jLJtOJweuLcV4+w7CM8/7PJdT2oAylssuDrNnPWWeXzghF1TrMjblkwcS
         p7fSPSWeFYvaaOQalPaRt9NGAcJ7dwvbm/xPYlkkBToe58gDwMvGlWZAbqMOLTb6Y8wG
         7q2DBbawl5rXgssVXjKE3Asw/0or8ZNhoTFmlJ2yopch13XUKMmdHY0GHjGxBGOXOo8e
         kKm6WG1FUpqg/OLZQGc1yvdEJNk+lVJ+gskf+S1IV7GRfzYvEgf5j3B/LX7wQ53LguS4
         H1MQ==
X-Gm-Message-State: APt69E2jRhMI4wVY6j2wK6WbU/m2k7VRohj5rn2GCZscD5twXWROP1cT
        UIXQIn04LkqK7w+YwQgotqtbljWy6XQWiYkdyBbvOA==
X-Google-Smtp-Source: ADUXVKJfcNiGgJgR8GDqdzLtzKZXGWKW7M3K1XVWZ9n/zvpg4BnqrgOLT+vaXTyfrqKmCQtmkdhwThocKuF2a6EEVxU=
X-Received: by 2002:a5b:b4e:: with SMTP id b14-v6mr8652862ybr.463.1530301624001;
 Fri, 29 Jun 2018 12:47:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 12:47:03
 -0700 (PDT)
In-Reply-To: <20180629190553.7282-1-labbott@redhat.com>
References: <20180629190553.7282-1-labbott@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Jun 2018 12:47:03 -0700
X-Google-Sender-Auth: nH_1CaDy1QI7tSS4BmgEhmiux-s
Message-ID: <CAGXu5jK+nqbRnk=RQW0wPrcEjqvmuR3dWKxyaXqXHn9__Kx0EA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Clear the stack
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
> Implementation of stackleak based heavily on the x86 version

Awesome!

Now I just have to figure out how to unbreak cross-compilation after
the kconfig changes to gcc-plugins. Whoops. :)

-Kees

-- 
Kees Cook
Pixel Security
