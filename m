Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E55C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322AC20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="suPO+6yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfANXQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:16:50 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41731 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfANXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:16:50 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so572398lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cTqWoEmuiJKbyfVWYcaMeM7RguPJlGI/+7cZrAm2Ggs=;
        b=suPO+6ybbPvHr5s+ytFSKRHSaZ0eDAoSv3dI56CLA+AzAH2el+8PTupxkAMehHH48C
         te0eNeP+e0olqluSwS8cEv03Y12CF5LM6AWPImEQKQdPPyQcO03dQ4t7L+yTkIBDTbTY
         4XffVnIsUbHRFcc97yRNvfLu3vABAXVu6GAX9X7jM+I6u9kGueI6GL2S32NpLd+WqwNC
         CJs22TyQguUMwXd/if/0orAPeG7/w9UFYUpsXVUTAoUcOip+0vU1a1pb0SYh5PM7LnJE
         KhV4/CkJfrIsvd4TKr2mT4/kd8Pnq23f/+QJkomJvsJo7P8f6ilnF7D6Be8QBrCcbBn1
         745A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTqWoEmuiJKbyfVWYcaMeM7RguPJlGI/+7cZrAm2Ggs=;
        b=O6XCtbJ0YDQIqj2/EAZVE4FiV1loSJKH9A6E9WINIrPS78ldVdgDgdluU2mThFEmiS
         sdzoMDWbrtyFBy+yIrNOo6veSq+8Sba7QyGdPLZUpy/rUCDpq8bgm51JQqejJgkmxFLd
         uqXGAu12QuhCejNPpnsQlZgPD0AROAJwURX6/v8CDKZvA1Qv5g3psWVvZeAbfwzvOI+k
         iIgsN0ROIIrkcKVEhRHB4qyRmnbqB5uxvmyPlT4v5c1/tOtS4gJExkK2K7/Cxw67tOuM
         +tT8twgO3nlBX6VfSmTWFlZjFVePy42thMmnaPGgahPyYFUx/cNUN+A5jOCIsMFSZ4Kq
         aClg==
X-Gm-Message-State: AJcUukc5CwS0S3hhSFg+j3yFz3n4odom+8MPJPVctV1iJi2sCvALtCqO
        nVlxxXScZXuqEAdtlfRegSVpUQLsGTHwWm+61QX1y/Q=
X-Google-Smtp-Source: ALg8bN6SIG0FAZ+x0q+flrznli/fH/34KbpYAsau7X95wQZyrVW/Kd0s5NGMCRD6eqyoJPrZ5QbVtldhkwIutCrrHbw=
X-Received: by 2002:a19:6719:: with SMTP id b25mr591846lfc.38.1547507808147;
 Mon, 14 Jan 2019 15:16:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <9e8a94d983219ef650e45082e1bbf3c65a280b6e.1544477629.git.rgb@redhat.com>
In-Reply-To: <9e8a94d983219ef650e45082e1bbf3c65a280b6e.1544477629.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Jan 2019 18:16:37 -0500
Message-ID: <CAHC9VhSYYP40E1w3skfa_mfPgsfme3Vnz8XNeBT-1VKMQcKcYw@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 4/4] audit: extend config_change mark/watch/tree
 rule changes
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Give a clue as to the source of mark, watch and tree rule changes.
>
> See: https://github.com/linux-audit/audit-kernel/issues/50
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h          |  4 ++--
>  kernel/audit_fsnotify.c |  2 +-
>  kernel/audit_tree.c     | 24 ++++++++++++------------
>  kernel/audit_watch.c    |  6 ++++--
>  kernel/auditsc.c        |  4 ++--
>  5 files changed, 21 insertions(+), 19 deletions(-)

In the previous revision of this patchset I mentioned not wanting to
change right now, I stand by that in this patchset.

-- 
paul moore
www.paul-moore.com
