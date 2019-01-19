Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271AAC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71D82084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 05:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee/REJH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfASFoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 00:44:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36346 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfASFoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 00:44:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so7627307pfc.3;
        Fri, 18 Jan 2019 21:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tWJODNziNZEVZjM3YX4C/FAyEXc/pL/1fBYz3P3Doo=;
        b=Ee/REJH76DOEoWtBzgGuhKlVbzAJs6msGqQmBPfoy9CSu30RcDWEJ+A+5xnEIE6su2
         ll/Zam2nJ4JSq5jdsB2n1IijTvyh2RbU9FZyZNmF5f11/kcaBK43LtswFcFt5vQgeQF2
         j+aZNM0SnmbPMb5AjWnlzheBZO2F8LJ60AvTRnJLGwb0tnGS3b8OBsuJka4IEcsE1iQd
         svyJ12QtsOCBEd+sD1NA2ip6tc+z0bselVUdwIYpSO0uG7Pjov0VZsP3IMsLqEJfrOU0
         f5SFRGc6VTpV2q6I+8fB3o9dKbzfTZxUUD1x9ApMvnC3MGfIuf9ri4HVNnn7incH9dFg
         v9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tWJODNziNZEVZjM3YX4C/FAyEXc/pL/1fBYz3P3Doo=;
        b=WIjLR9jXtccs1i65Pv0kDaaVRBw+SmsdKoqkWef16/yH29ZrbjYcm9JVWlYJWijhwZ
         KguBygh7RhCeq8K4ry6nWFaTYxDFaNYsslHXHXfnhCicoveTYUqurHCW2ncomRhaY4Gc
         kJi8zeZHU7iZp8vdOTYEfStrV+WsH60PVNpYvRrMtM7NPMAWvhqyp6DDM9tBEARlaOgC
         KGpoPYXP/2Fh04WTZx8PxnBvjFb/cX9zjzfACVzzEdzNqCNoeveTjlj8zduiqXwjkj/1
         ngGWfsk9WYlBRjeOnSjMchSDXeR4nPkzCTQqQa+8KVS6B1dM5LKrL2K+4schuaC5ZpEd
         NqCQ==
X-Gm-Message-State: AJcUukdCWSVZeUf/AhgK9QnwFmjuU7pboqoBkHZwk2IAZSiMXYYfybKi
        4J99X0TqvV3Z8CWEu96aBVnW+z3psVzgZGckYho=
X-Google-Smtp-Source: ALg8bN4YmbiIMDuoMR6l5D1Ozo03fljw3fgaSFT/xC/AD/dNSY/8yheRbQ433bVPKNGBGNYbLukVWJOeN/L6d5JSc/A=
X-Received: by 2002:a63:a112:: with SMTP id b18mr20666654pgf.440.1547876641709;
 Fri, 18 Jan 2019 21:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20190117231416.111952141@linutronix.de> <20190117231501.453156872@linutronix.de>
In-Reply-To: <20190117231501.453156872@linutronix.de>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 18 Jan 2019 23:43:48 -0600
Message-ID: <CAH2r5msvpEXYLMCXxJzya+ohfgTwgduC57QsA-p43FfaGdV+gg@mail.gmail.com>
Subject: Re: [patch 7/9] smb3: Cleanup license mess
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Thu, Jan 17, 2019 at 5:17 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Precise and non-ambiguous license information is important. The recently
> added aegis header file has a SPDX license identifier, which is nice, but
> at the same time it has a contradictionary license boiler plate text.
>
>   SPDX-License-Identifier: GPL-2.0
>
> versus
>
>   *   This program is free software;  you can redistribute it and/or modify
>   *   it under the terms of the GNU General Public License as published by
>   *   the Free Software Foundation; either version 2 of the License, or
>   *   (at your option) any later version.
>
> Oh well.
>
> Assuming that the SPDX identifier is correct and according to x86/hyper-v
> contributions from Microsoft GPL V2 only is the usual license.
>
> Remove the boiler plate as it is wrong and even if correct it is redundant.
>
> Fixes: eccb4422cf97 ("smb3: Add ftrace tracepoints for improved SMB3 debugging")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steve French <sfrench@samba.org>
> Cc: linux-cifs@vger.kernel.org
> ---
>
> P.S.: This patch is part of a larger cleanup, but independent of other
>       patches and is intended to be picked up by the maintainer directly.
>
> ---
>  fs/cifs/trace.c |   10 ----------
>  fs/cifs/trace.h |   10 ----------
>  2 files changed, 20 deletions(-)
>
> --- a/fs/cifs/trace.c
> +++ b/fs/cifs/trace.c
> @@ -3,16 +3,6 @@
>   *   Copyright (C) 2018, Microsoft Corporation.
>   *
>   *   Author(s): Steve French <stfrench@microsoft.com>
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
>   */
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> --- a/fs/cifs/trace.h
> +++ b/fs/cifs/trace.h
> @@ -3,16 +3,6 @@
>   *   Copyright (C) 2018, Microsoft Corporation.
>   *
>   *   Author(s): Steve French <stfrench@microsoft.com>
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
>   */
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM cifs
>
>


-- 
Thanks,

Steve
