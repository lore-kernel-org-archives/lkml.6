Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E1C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6A521741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiRHToAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbfAIGuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:50:46 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:42363 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfAIGuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:50:46 -0500
Received: by mail-yb1-f174.google.com with SMTP id q145so2588098ybq.9;
        Tue, 08 Jan 2019 22:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tUMof8I5+V6VNjLfsGunUyBc1kECZ3AICUiV/cVprY=;
        b=fiRHToAw9WFQeAS9YoBUSBMY0ywdFsT73s/9K7VWwWS5wr9MCxw9aQc28ob3qFdgGz
         jEnISwbMKV6FecUDNTZCqq/JimXeShVxHoLLzlMYMUkPx668lN154NHSE+oouPemqKiG
         JrPh3yHGFhFcZYZvYoNqSWtfevg2ISxe3f4aJplm2I4xyuXWLu080ZGFBUHEN6SaaKKH
         lX+BmZohpIiRv/p1g0FFIb4nmMtffUtt4WrJCYx25b8Gzx12E92acGQqy6c/scf1ox09
         WrJWQFyfVF9ch6Uhv1LRLCcv1BCzYSPMMxxyQVWKEE2dTQ7AYB7RP/h4xHfD/WDSexls
         pNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tUMof8I5+V6VNjLfsGunUyBc1kECZ3AICUiV/cVprY=;
        b=DdVbLCHJdWJTMV+BL+jLwnDAFhJc1/rBLQlBzQGH/tMEzyoeRuhvkNuU0ERdUgO0Zg
         VXira61zMD6+DxU5kZtyIkG/W1ZQmCVR3iMyeRnpprkFueYrJ51gdjcDCnpRbHH8kRue
         HHYBGW78wkr+mXxcodyhzlQ7PMsLyrCN0DeJjn129AqC3EDAC0WgcRMNaq4MBf0TFRc9
         0U3t8ODqpG+IpbC0/JlwGEowfNu7FcbIxhBp+Mbp2hwxwx7PRqaK39XV0cjCNJXI/xoj
         dWUf/1fy+l+uNfrxF5CmCJA8U58EjOb8UqUGZVhXVkvSzRcKMMqUd8Hs+tvCU0/wbREz
         i0Rg==
X-Gm-Message-State: AJcUukd9WvfwRM26R+b+yWXkfEP6JuUmz8k0IHVXCGlUeGORfTYS8JgL
        9CuqhLIZ2eYpaJUVZDEBClYR4/U7UpmEyRHn7XAZ4MWP
X-Google-Smtp-Source: ALg8bN7XOObGiCrbkBgQZrylIVKHH4OcIMB+0p5G3T825Kc0YqK9g4Y908CmMocJ5OwIGS2ReW70OjBss56un8NwOQA=
X-Received: by 2002:a25:ba84:: with SMTP id s4mr4611428ybg.325.1547016644835;
 Tue, 08 Jan 2019 22:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20190108192628.121270-1-sashal@kernel.org> <20190108192628.121270-16-sashal@kernel.org>
In-Reply-To: <20190108192628.121270-16-sashal@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 9 Jan 2019 08:50:33 +0200
Message-ID: <CAOQ4uxgwZjyoEOeRRj0eRsPR2+QmyUht0sErtZV=meKcPTDVcA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.20 016/117] fanotify: return only user requested
 event types in event mask
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 10:11 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
>
> [ Upstream commit 2d10b23082a7eb8be508b3789f2e7250a88a5ddb ]
>
> Modify fanotify_should_send_event() so that it now returns a mask for
> an event that contains ONLY flags for the event types that have been
> specifically requested by the user. Flags that may have been included
> within the event mask, but have not been explicitly requested by the
> user will not be present in the returned value.
>
> As an example, given the situation where a user requests events of type
> FAN_OPEN. Traditionally, the event mask returned within an event that
> occurred on a filesystem object that has been marked for monitoring and is
> opened, will only ever have the FAN_OPEN bit set. With the introduction of
> the new flags like FAN_OPEN_EXEC, and perhaps any other future event
> flags, there is a possibility of the returned event mask containing more
> than a single bit set, despite having only requested the single event type.
> Prior to these modifications performed to fanotify_should_send_event(), a
> user would have received a bundled event mask containing flags FAN_OPEN
> and FAN_OPEN_EXEC in the instance that a file was opened for execution via
> execve(), for example. This means that a user would receive event types
> in the returned event mask that have not been requested. This runs the
> possibility of breaking existing systems and causing other unforeseen
> issues.
>
> To mitigate this possibility, fanotify_should_send_event() has been
> modified to return the event mask containing ONLY event types explicitly
> requested by the user. This means that we will NOT report events that the
> user did no set a mask for, and we will NOT report events that the user
> has set an ignore mask for.
>
> The function name fanotify_should_send_event() has also been updated so
> that it's more relevant to what it has been designed to do.
>
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Sasha,

I have no objection to applying this patch to 4.20, but FYI, it does
not fix anything.
Before introducing FAN_OPEN_EXEC in 5.0-rc1, this patch has no visible effect.

I don't mind if you apply it. It will make stable code closer to
mainline, which is
always a good thing IMO. And FWIW, I think that patch is quite trivial
and low risk.

Thanks,
Amir.
