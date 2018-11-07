Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B25C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C8D2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mBNR7qyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C8D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeKHBZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:25:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37087 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbeKHBZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:25:22 -0500
Received: by mail-it1-f195.google.com with SMTP id j79-v6so11418827itb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 07:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ew6ayYsUUk+BWd//Ljx7W4qmeoFs/gumb+LSKo2O/t0=;
        b=mBNR7qyyNID+R/SJF2fKxEq0DxmYV3XMb4Qy9aDlelMmp3GnBuMrHnaRrUtl3SvsG6
         6g5KTvafqcIwRAfDvGhPkEX9U1p60CYoQPEW1d/zulCKXDxFTrXHQOTwSbRecZDbj9mK
         uruBCtf67IRUlKbK8Mih1K8ipq6E+rU7h2P60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ew6ayYsUUk+BWd//Ljx7W4qmeoFs/gumb+LSKo2O/t0=;
        b=oGJQcA/IYBH+/j2kbWpCgPoLKyer05hcd4ade1PFTSUm977uGVSp76f5jopfLwvrPC
         zvAdV1K/du0lNuzpqSDRRza9uT8/CIdo1bc6fjwroM25IT+cisM7xfOowhrdtJBM1rJy
         zRCOn9xm8g2bvDsvQfxZNpiQlzreiouuGdm9kX55ou+1HQNpAnBVsphwHtyI1wCL5tSZ
         EK50HBJclO2QLfM6Y3UL6fS6AxZFQ7ZqCjIGpRJYaXnhK76b6LT+kAiLQsPsw8xlgIH/
         nOb3A8bDzegkTas/mc2XRkEMHpiZI2qEu+8CB8WdSIU6WX0J25ZEFIURjTgBkmnfVPXy
         4v7g==
X-Gm-Message-State: AGRZ1gLQRlgy51qPS32qt6MTolQRDc1irKX0H+5hfW86hvSjYeT4ee1H
        PNjFj9U5+L1uRrvy0b5LozyCUkBxzyml9udEXzh+bw==
X-Google-Smtp-Source: AJdET5fzwvLiBsidCRvLQnOdycVt2oFg1mmWQ4YbYVrh7OOlNM+ve2Bdfml3zXucPULoupqDP6xtFWB1s4AzRCojJdI=
X-Received: by 2002:a02:9951:: with SMTP id d17-v6mr708756jak.78.1541606066277;
 Wed, 07 Nov 2018 07:54:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:ac42:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 07:54:25 -0800 (PST)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CAKOZueu=zM_HjeET6SBJaP2zHD6+w7K8ewtk6B8C38Gkm4g0LA@mail.gmail.com>
References: <20181029192521.23059-1-dave@stgolabs.net> <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
 <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
 <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com> <CAKOZueu=zM_HjeET6SBJaP2zHD6+w7K8ewtk6B8C38Gkm4g0LA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 7 Nov 2018 16:54:25 +0100
Message-ID: <CAJfpegvs4hafbe9XSgU175+26_ks9oh6iUo5m2tYLA=6MMvMrQ@mail.gmail.com>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Daniel Colascione <dancol@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 4:42 PM, Daniel Colascione <dancol@google.com> wrote:

> configuration!" is something I've heard more than once. Who's to say
> that sysfs is for exposing /proc/pid/stat,

Patch is about /proc/stat not /proc/PID/stat.  Please revise your
arguments based on that.

Thanks,
Miklos
