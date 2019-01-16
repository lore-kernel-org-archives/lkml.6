Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15721C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CE12082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+08RLTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfAPEyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:54:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36028 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfAPEyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:54:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so4325322ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 20:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n37s/YGdb4u8vwIo2QSiIPj0FBg6xYRbNHc/M6iAOEU=;
        b=p+08RLTtT8RkF7ViFqYvYROqrgKLJz/UJcXJ/cTuM/Qk75vrF5v4eVCk8Nj4AGiXDF
         cFa/Lm9mpQilBq4Rmm0f4fK5VjpQUCl0FkWv0oFvz9rcz/njCvkf5eaxvZ5cAn85a54s
         Vyd8dIiX9lGQ2nEVE0jPNIH6pJwQmM4Ws97maP0LWrmkuUS8bwYVQp4M0LZc6agNiHXx
         8xQQraVmljhDqnMmyM2x2ER35eG6fqHk0J0e56d1wZ2iVNN2xgOt09EesZBOzSUhTM6X
         nNIB6UCoJJHdI0YHrdZMZAHVjM+3f5sPRChYK8L04XYldkWTOerQ90/nPZYV/p6REFHk
         INHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n37s/YGdb4u8vwIo2QSiIPj0FBg6xYRbNHc/M6iAOEU=;
        b=kmUfQ5JhOstjA7TorF4au4c+Uy5gQQucAI2Kbw2cX53bZryNqjJlKQ1N1q7yV1YjH0
         S86pKILitp+THgf1m/uZDvh+ZbWZ+68UU2iNhRnt5RofOyFkkghrR8j32zHLdOOBFLmI
         J6tBnLUTHkTM/ssSfzwCXTwjqHtluEBstNiu9PeqWzwe/vp3W3FOs7tpLJ6hqmY9B6gb
         pTmdvdtwiNguKjy6fpmZgnPiEoePpvZSbS4YG27vboD+lK4j/n/7ymX78VMcI2yNQbfK
         rJw8onXc2mgmSlpVBrcciSGXiWxNqNhp/CeoDOyzRE4P1m5UptXxSBAZC3dCOXByzUcz
         jFtg==
X-Gm-Message-State: AJcUukcWvO76Z2K6Il41vMmKbtTO3X2mwKTVDanPPMnOJvqWOH3xtiex
        WCXpvILqWk5fPNMZlDnMIls4hQExwJovNvWtx9P3yg==
X-Google-Smtp-Source: ALg8bN69tDvLZc0HwDtQvMBhB7N7ni+eaDBrXDSaYrvCktyBeyhXMj9z+DqRfM9+UqXBZJvPfP/5V/u8+o55AB6Dft0=
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr5530060lji.14.1547614444568;
 Tue, 15 Jan 2019 20:54:04 -0800 (PST)
MIME-Version: 1.0
References: <20190109021112.5836-1-rkir@google.com> <20190109021112.5836-2-rkir@google.com>
 <20190109083109.GA24501@kroah.com> <CAOGAQeqrdtgwoETZcEefneXi0wnQvZfKZX7=SUU7PfA2nOGzsw@mail.gmail.com>
In-Reply-To: <CAOGAQeqrdtgwoETZcEefneXi0wnQvZfKZX7=SUU7PfA2nOGzsw@mail.gmail.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Jan 2019 20:53:53 -0800
Message-ID: <CAOGAQerq1iNbT4ZWOwzp40gPQJ-n3PNGXf-sr2cGPCXWKw3_Pw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish: goldfish_address_space:
 add a driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you have a pointer to the QEMU commit that matches up with the device
> > that this driver is supposed to be supporting?
>
> The device code is here:
>
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c

Hi Greg, do you need anything else to review my patch?

> why the existing memory driver does not work well enough for you

I tried to find the existing driver to share memory between QEMU and a
linux guest but could not find one.
