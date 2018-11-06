Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A5C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA5C20866
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSrrn/pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA5C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeKFJZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:25:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45440 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeKFJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:25:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id g10so9807955otl.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 16:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76fZ14GYGbbBgsenkR/Fwdtk6Bt2MI68cayoBnSXa80=;
        b=eSrrn/pPYvpmX78yh7vclOKBuGWl2o0+dv16piMKHM5BQWcMhJ4XZKN7dYJuotjcRp
         9xJxB4k/nCDViN4xiRHNlRw6tA8FwWXAqtO49SCq2Bisp73xMOQkPI9txNtBrMxEFekA
         HKzYF9eEMYXx/zVW8Vg0e+Ls5VISGr53sYLXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76fZ14GYGbbBgsenkR/Fwdtk6Bt2MI68cayoBnSXa80=;
        b=JBU7LnIF79IPIz0Trgva1CMokIrp5sppFpSBQaJwx4TCiU6R45GG1BxDoX47rpi2G6
         0VDgtbWjfXGxgdFo+3Mm+E6GSznw4/GeqfMljtbVUHFpIXkSqch9et7ALru1GPB0OQbf
         7uElkkgSB1O0lRtZCtXmZVI4WT9KT1Qx+oeNhO0Op75/J3ZXP/AsezU9grxjTyoNDFOv
         JmOahYpatQk/OvcHvxsV4KVxEeAzi+QoCNv3QSy1NwH/NSJttESzTwFnqK+i5pSByMWj
         WoC1pb6XH2ZcQI1cAY6lCIwzC7BTSfpkydsmcV56h5UAw1jy4EUK4TKmYhgldm9ktwYX
         nGcw==
X-Gm-Message-State: AGRZ1gJvbFSH1PcwXDNK4/edQ74aWY+qHAnf8h8BNoZ0vP13jFG4rdPV
        j85Iot0/a1uApKJNUlTfmHFjJaPtGT9dc8Hcos7G
X-Google-Smtp-Source: AJdET5dcti9dZbhNZKosimLp5obyBlwmluGwQl6AzCp8ZRgyeiFNwLP7caU95FRmLpz47Ss3yWugiESCH13Fw4fMlaM=
X-Received: by 2002:a9d:5755:: with SMTP id x21mr15638811oti.193.1541462597725;
 Mon, 05 Nov 2018 16:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20181105111348.182492-1-vovoy@chromium.org> <20181105130209.GI4361@dhcp22.suse.cz>
 <CAEHM+4r4gRiBdRHaziiAFzwB5VD785zpUEr31zFLbx4sNUW6TQ@mail.gmail.com> <20181105164135.GM4361@dhcp22.suse.cz>
In-Reply-To: <20181105164135.GM4361@dhcp22.suse.cz>
From:   Kuo-Hsin Yang <vovoy@chromium.org>
Date:   Tue, 6 Nov 2018 08:03:06 +0800
Message-ID: <CAEHM+4qOeQAK+QA-sqpcnfZ36zDiO_3ScYFxnY_ur7y+u_P9BA@mail.gmail.com>
Subject: Re: [PATCH v4] mm, drm/i915: mark pinned shmemfs pages as unevictable
To:     mhocko@kernel.org
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 12:41 AM Michal Hocko <mhocko@kernel.org> wrote:
> On Mon 05-11-18 22:33:13, Kuo-Hsin Yang wrote:
> > OK, this function should not be specific to shmem pages.
> >
> > Is it OK to remove the #ifdef SHMEM surrounding check_move_unevictable_pages?
>
> Yes, I think so.

Thanks for you review.
