Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17791C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8211208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 05:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP0DI+/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8211208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFUFla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 01:41:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45178 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932583AbeFUFl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 01:41:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id a13-v6so2759904lfk.12;
        Wed, 20 Jun 2018 22:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGIsTRIUuAVbhoxU0lPjHXYTkewaocoQkBALAe3Omw4=;
        b=kP0DI+/QwwLjbtgVR+DFWbrY19NXggodgECojeYDp9WL0q3uhS2iLy6DjEqV1RsZyq
         mQGsM2wB948z0Oh1xU2ovbNfXH6SkL31RBOSOTJiFNAkGxTRklBxMS6rtRbMKSsdSxTI
         AqcK9dytwy+kWoBi5q9RWT5Norgy4nbc+vvm+t29HVFRRlNEwG10Fos/f5PuOUBPJvkZ
         i2KxWfK3tTqa0Fjip5qoyIrHxMNv4mQW62MexyhzcO9sx1H+tiLdNIFFa3EyPQUoIm51
         zUfds5D+JcI5J6s+5XO0Vk2PI/uCPnfAyDied8ACUsXzhiL7mdosiZCF7j97j86j9yEi
         wA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGIsTRIUuAVbhoxU0lPjHXYTkewaocoQkBALAe3Omw4=;
        b=tCvyiy1jWVvXi1mz6Vuu8yxbKgCPJDg2HYyDw5hN1m3GMtOTZrsfIfQi0MYJ0jdPuM
         1k+ajqNeMtyN/XgYIn2C3tcLfjxz4dgOkywIlYRvHl5glbrRp/ueOGdI6NcTEcmhS/yd
         uKDMTya2jSckXMnh5YILUaWXuWs6v1SdB9lc0/WJg7zlKyn9EsLmWAqZK85bRXatTzij
         F7wzQH8CwdaZyS77QzUC78S8cYP1LkcRRWkPGUoY2KW+OEvjWzfFEgb23fxwOirPekUM
         GLRF/wrGl3m0o1rZ/CSbolfiSnlWm5i4p/5k5v7nbbQj9cB1Mp8Xiw0lDLTOVoGfreoc
         e7RA==
X-Gm-Message-State: APt69E285KaXmOgmH4lK6ZaoINuGF2N0VjGIvLtJC4PwwzA0YEoPe1oS
        GIqWd1aJo9yNnhuMcl9EOPCMaWEGLx5JEXt7J9c=
X-Google-Smtp-Source: ADUXVKJ9hFkcbXW7p56ANBk1sbGlCyOO9GeOAC7ww41BbiE8vnEw6U8NR0AEBofYPUOT7q+pkw1bHsQ0V+ygBrj7Jw0=
X-Received: by 2002:a2e:6e19:: with SMTP id j25-v6mr16636629ljc.61.1529559686707;
 Wed, 20 Jun 2018 22:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <1529488801-22093-1-git-send-email-allen.lkml@gmail.com> <CAK8P3a17ui5QuvPzgWmQby0zVcxSKpU_0hbB7_Gdt6i39oo5hQ@mail.gmail.com>
In-Reply-To: <CAK8P3a17ui5QuvPzgWmQby0zVcxSKpU_0hbB7_Gdt6i39oo5hQ@mail.gmail.com>
From:   Allen <allen.lkml@gmail.com>
Date:   Thu, 21 Jun 2018 11:11:15 +0530
Message-ID: <CAOMdWSLtRLE4OnZGjXy+d7i5kO7CRPv0U=yM6dWjR1-iiJ09aw@mail.gmail.com>
Subject: Re: [Y2038] [PATCH] ceph: use ktime_get_real_seconds()
To:     arnd@arndb.de
Cc:     netdev@vger.kernel.org, y2038@lists.linaro.org,
        ceph-devel@vger.kernel.org, David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>
> I have done a similar patch and will post it soon along with the rest of the
> ceph y2038 series. Please have a look at "ceph: use timespec64 in for
> keepalive" and comment if you see something that I missed.
>

Oh Okay. Thank you Arnd.
