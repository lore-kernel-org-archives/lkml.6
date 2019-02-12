Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AAD21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZGboSaB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfBLIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:47:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39674 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfBLIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:47:16 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so1458968edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wRjdTHx18o/cxI6eHe40jtMc+ZermkwQqWMgUbSpQcI=;
        b=ZGboSaB9fI/g0V91CAgVyvyV5t6RxcvRtANBCD2erZ3asBaZ///kvwu4WIDyjPEyih
         ryMB1vHivvYBFSh9TSg58yk63VzY2fM4NLgeoVbJI2RuE7f3F2EUqbKO7juFdlQigv7q
         HdTqrLvP8vVql97ibM+mTnUGqe+jbCjdvaQAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wRjdTHx18o/cxI6eHe40jtMc+ZermkwQqWMgUbSpQcI=;
        b=ZdCmCJyjS61NTXcZANFflMUCX/eCRYYxNEIGj1buCdrdjPOd95vEVoi+PmF07Tbm4d
         co0HIhmlYRSs70c9YHHD8Mb3R7dGpWdOdV2QCBOTinm7lOEfNz+rOVEX6E3d5ue4Y/iI
         2ubncD4KRHNBP780aEVJYfwaAqmqXI7vqpEwKLtVbKyicxjoyCLJ9G6rShFdY306m0Sa
         98+9gNBGUBkv+tUmfawJzIxDD3Y/OypMQiPIE/ppRHXXX5r4ygdxBwJrRUJXF7DSU249
         Lu9qWZjRJaHEY47HgttAQDNpa8YuYojjHgKgQgXwbDPzSmroynmhisnUxaEz4rqnKcWL
         PA6Q==
X-Gm-Message-State: AHQUAub2s8/z9i5iJvo01j7VHCzaQagYAhOiI5TQExJRwKFFRTUnbZmy
        KLrO8kJrAs1Ryz7Low6CrGV7B4RHnD+mNoLOEm5yIg==
X-Google-Smtp-Source: AHgI3IbwWqPmYEqjxNjsaYrnzds6V5KH6Jpts6iusGlhXazWcuTvRwClhVAXe7EgUkodXddmRSCmWfwXvqwniswSR2g=
X-Received: by 2002:a17:906:f87:: with SMTP id q7mr1891715ejj.158.1549961234633;
 Tue, 12 Feb 2019 00:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20190131095625.261755-1-pihsun@chromium.org> <511a36863af02aec12fd77657b0ca199e023f319.camel@perches.com>
In-Reply-To: <511a36863af02aec12fd77657b0ca199e023f319.camel@perches.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Tue, 12 Feb 2019 16:47:03 +0800
Message-ID: <CANdKZ0dEFr5TAuat16sEKm=B3bRa5nqBvR3OCM=hzKGcBQKbJA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Properly detect /* */ style SPDX header.
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:54 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-01-31 at 17:56 +0800, Pi-Hsun Shih wrote:
> > Currently for a header line "/* SPDX-License-Identifier: GPL-2.0 */",
> > only the part starting from "SPDX-" is passed to spdxcheck.py, and cause
> > false warning. Fix this by passing the whole line to spdxcheck.py
> > instead.
>
> Thanks but I submitted a different patch:
>
> https://lore.kernel.org/lkml/8b02899853247a2c67669561761f354dd3bd110e.camel@perches.com/
>

I tried your patch, but when running checkpatch.pl on
https://patchwork.kernel.org/patch/10790203/, I still get:
WARNING: 'SPDX-License-Identifier: GPL-2.0 */' is not supported in LICENSES/...
#75: FILE: drivers/remoteproc/mtk_common.h:1:
+/* SPDX-License-Identifier: GPL-2.0 */

Feels that these two patches fix different issues.
