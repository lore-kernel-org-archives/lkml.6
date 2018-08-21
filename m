Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74615C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F3214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTKvEy10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7F3214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeHUKW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:22:27 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35063 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbeHUKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:22:27 -0400
Received: by mail-ua1-f68.google.com with SMTP id q12-v6so11257914ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oGCOBb0EBatSOi0cxwTFT/jfSxTd68ctoEWJnHmmHFg=;
        b=gTKvEy10pHz5OhzE0ucFrRkXygkFGYNaMEsivhMW6yRjINAYCUi7ZZpd9PkMSq1Zca
         Nva84kRNmXGtmdvczIh5XKTBHcviOn3k8Ad09V3auGJ4b2g7OrHvr/bl89JOYSfouziZ
         xOfrhNc2nAmZipQDG2mVR5u7uftb4DAJPZMfRhJTKucS9X24wB3AZ1f2U9A9o3cnOvLU
         be8NiUeQjTWYQNxHojGAfpRdkNsNQqVWFFWimyY7xkyCyEHkXRj5FS+5E0Vbm1FP085w
         xfXDz/gtsRoLnYk4+nI8B/cxRMqhBi58Yc92lvsfZLSwXqfLsPMR+/1/HVlltrDTXJSV
         lLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oGCOBb0EBatSOi0cxwTFT/jfSxTd68ctoEWJnHmmHFg=;
        b=eFRy3GDs9SoI/12//khuwfI3cu1gksi6sPvQs1krxDkrqT655piT99SBpaLmJOIw4j
         LiKUeiy0CS2D1eFEf3f3RWMPj3hLZWy1wlsfb6nJYMMPbvUHb60HH6Z/jc2gnduBipJj
         KH3tfiNtO6VkIQVZ9g0QwvbgvGAmulx+cOy/cSHJZmbrJozR0rMAlPRJ4v6L4R6vx52a
         0J4pGWR8hYoR7y0CKS57KuTgzm8sZCNWbtRNUfCwy7On+/xdZ+koByEXopiI6j5/gWFU
         pXv08w4MUI5VEmiYYsuVWhMZNoUrJBdLWqAyDyX2j4i0j70fLog7HkEzouzKexmyYYCy
         70fg==
X-Gm-Message-State: AOUpUlFRCkiCcO6kJjF5Wd+BxuUQYHzFBMVR2v2G7n+DcIDbwT+DJ1jp
        4gcKGzteh2awNV+a4oJDySQyxPGXB3tFZTyccA8=
X-Google-Smtp-Source: AA+uWPzGDLuULtvWxDtPKKUN3AolPl9f0EGMPcnC1QqCNhUHD3mPFP8aOFRJcVxISHSTVKUrRSK1awuXvWEKFucy3c8=
X-Received: by 2002:ab0:4666:: with SMTP id z38-v6mr32360318uab.159.1534835011169;
 Tue, 21 Aug 2018 00:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1534730156.git.zong@andestech.com>
In-Reply-To: <cover.1534730156.git.zong@andestech.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 21 Aug 2018 15:02:54 +0800
Message-ID: <CAEbi=3e0mGLCbKQnJ16qsCHCMeqHiTmCYGNg+DKBMWANSqNYQw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove the deprecated ABI implementation
To:     Zong Li <zong@andestech.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zong Li <zongbox@gmail.com>,
        Greentime <greentime@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zong Li <zong@andestech.com> =E6=96=BC 2018=E5=B9=B48=E6=9C=8820=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This patches remove the implementation of NDS32_ABI_2 and
> replace the magic number of offset of lp on stack.
>
> In stacktrace.c, we dump the stack without considering the old
> ABI, it should be consistent in traps.c.
>
> Zong Li (2):
>   nds32: Remove the deprecated ABI implementation
>   nds32: Add macro definition for offset of lp register on stack
>
>  arch/nds32/include/asm/nds32.h | 1 +
>  arch/nds32/kernel/stacktrace.c | 2 +-
>  arch/nds32/kernel/traps.c      | 7 +------
>  3 files changed, 3 insertions(+), 7 deletions(-)

Acked-by: Greentime Hu <greentime@andestech.com>
