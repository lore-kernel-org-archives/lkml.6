Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53211C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4B720685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/j7e3gR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4B720685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbeKFXjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:39:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41021 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388672AbeKFXjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:39:47 -0500
Received: by mail-oi1-f193.google.com with SMTP id g188-v6so4831280oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 06:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2t5yTmInuvGY5CzDg1tMjTZlNl1d5my+Ro54B1I7oU=;
        b=A/j7e3gRy0AXHaKI7JRcpHvzP1qYS3jG/nTHqtvtJDn05O9E7nuPdtdcMGKy8RwjJO
         NeJgpt+gqKc3qZx7GJs3vq73Lu5dhJpw0eBurMaWdNmg6KqEa/VfeLGWF1PsOOWwFbsu
         xIXa/RYJEpXyCIDWaB4ZPN+XRK6zSoe2pu1So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2t5yTmInuvGY5CzDg1tMjTZlNl1d5my+Ro54B1I7oU=;
        b=bGaMWFeNT5ux4HCQTBVmZbRTGffiLoFEw5LvfmpfHn4HSdiFeKnS3njxH9fPs/Yahp
         WDNSeuoErW2ScB0Ut+KkfemuGc1ZTCQ9mGb/7UznnLrtd+ysLZ0zKf3UQHz25DREt4dW
         QjSEvh4dCyyK/J19F+PcCvGr7LKDeopvBmOiQ7LXJ8y8QbKnIPzqy9oCGfwgtpcMdgJH
         0TluFsixtSnuiml3Axf9g7MOJJohLRWDLLw1UylPXJj59+/vgQKY9zKYx05hrrJMIXPw
         6uyFqm+ImBffGjLojTYE+avm5M+ZntNxN/zVLtpkHFsILmwvlaNNsrGBmILej2BAivlg
         Fvcg==
X-Gm-Message-State: AGRZ1gKgjSkEO6SXvh7NrrO1owt/U+vtmF/JFglNnlBdQJVFQj3T0xsi
        vU48bd6bv/CuKC98d6ohuGT3EMYx8k0wqKbBqaUo
X-Google-Smtp-Source: AJdET5f1Ba3m/VLjFyJELCg4/NeXbZHZetC9Pi/xcxB9JKZbhWXfoLq2/Dv03sX5lB0Q7kHOdQcbnHdCudHA6/Er4qU=
X-Received: by 2002:aca:a54:: with SMTP id 81-v6mr16329709oik.31.1541513661536;
 Tue, 06 Nov 2018 06:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20181106093100.71829-1-vovoy@chromium.org> <20181106132324.17390-1-chris@chris-wilson.co.uk>
In-Reply-To: <20181106132324.17390-1-chris@chris-wilson.co.uk>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Tue, 6 Nov 2018 22:14:10 +0800
Message-ID: <CAEHM+4qb0Q7jJNqowECGeU8ZqcWY8ZyQLrY-OgbvyM1D=BFqyA@mail.gmail.com>
Subject: Re: [PATCH v7] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:23 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
> Acked-by: Michal Hocko <mhocko@suse.com> # mm part
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Thanks for your fixes and review.
