Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeCPHgt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 03:36:49 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37357 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeCPHgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 03:36:47 -0400
X-Google-Smtp-Source: AG47ELsaNi4VU1uAVAa7SwhtVkkgY/NZgINXAlw2SJfyb82FcbdpChJb2CUTku50i1qiBzBOUQ4QBlsjyP+GhJ7ylJY=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:56e6:0:e4bc:76a0:8042:669e]
In-Reply-To: <20180315104511.GC15393@ulmo>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
 <f48200af36c3358d549fc451fbc754c2a37b0d47.1521075485.git.digetx@gmail.com> <20180315104511.GC15393@ulmo>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 16 Mar 2018 08:36:46 +0100
X-Google-Sender-Auth: 7pNhzNL3ow2OgJH80ExaYxea2pw
Message-ID: <CAKMK7uFo3YZ2P4CFywwyZLJS0tPgwOmn8dG3g84pMF+xV52D0w@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/tegra: dc: Dedicate overlay plane to cursor on
 older Tegra's
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:45 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Thu, Mar 15, 2018 at 04:00:25AM +0300, Dmitry Osipenko wrote:
>> Older Tegra's do not support RGBA format for the cursor, but instead
>> overlay plane could be used for it. Since there is no much use for the
>> overlays on a regular desktop and HW-accelerated cursor is much better
>> than a SW cursor, let's dedicate one overlay plane to the mouse cursor.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c | 28 +++++++++++++++++++++++-----
>>  1 file changed, 23 insertions(+), 5 deletions(-)
>
> Applied. I'm not entirely happy that we need to sacrifice one of the
> overlay windows for this, but you're right, it's probably okay given
> how little planes are used on a regular desktop.
>
> We could always provide a module parameter to switch this on and off
> if that's ever something we want.

The idea with universal planes is that you can (at least try to) use
the cursor overlay plane as a normal plane. It is only a hint to
userspace, there's no requirement anywhere in atomic that you only use
it as a cursor. That way desktops get a good hint for what the cursor
plane should be, everyone else can still use all the planes.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
