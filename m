Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C18C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1156220819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQIworpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1156220819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbeKEMqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:46:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45455 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKEMqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:46:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id d135so12404623qkc.12;
        Sun, 04 Nov 2018 19:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkEN5lBFbysuSJlznNOpnoLwk60CYb8iNqwsMQR7zaA=;
        b=lQIworplozpQckFgCAixbTz96tR4TXAYGrGGFn6sLehsVoN+OHZqLPVkjvlPa+Func
         lnO8eYmcbqSo20YIOwiZGI/S0q1comLYJxvuqZP3+67qC+2I8ruOvt3orOj8OjpHyzh1
         FUWYMYsn0zfWUUSpPLz92pBTFS4Jr5pjA7i8J1rYaEN/cRqc5Mw8MihovclxHE1iV+76
         3wuxBFnUGvByK1OwqMzENBh7rlJrV+rBNBvI/iJhWwFJ5uJ2fCbtVOf6lsvtTorJPjpS
         DNb/uiCbxm+2Rbzu+8BwavvYnRUL80a3irpfA4/H57k8I85LcKC7sZgxZW2mBh+0E8yb
         P42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkEN5lBFbysuSJlznNOpnoLwk60CYb8iNqwsMQR7zaA=;
        b=uZwqEDI42R+SyHPWfhS1Lxd4s63NDgqOxFvsYg+u33mCTbYtf6FIe5LG5WE/pvUth/
         j9DA3KFDkP7V++0bD71gddI3ZrzSLEu4uRHOIvFm6NPtwG+VpJYlAQh9kDDRi1Plpd0a
         GoKeNpvE+Eq0WNZdd/yvVANX1bbHY5qd6DyPYjj438jABwwPd0lhidzEXKL5/Uz1d8aS
         6TVvH905k8wwB5yr0GqMRq3qjBiECSObhsr4MbZEiAoHfSj/A4vAlscPp4YEPqoKMVtz
         xPVC+R2NTspqjqOBqcUC82Guhje/9OIVa/wc61cqpC1mUmltgR4/QwKcInGX692BInpW
         3yjw==
X-Gm-Message-State: AGRZ1gI1UaDtVWbHyBuBRlBHNcGUGEnulJ2L7tlZhp8pnm1+eKdZFz9/
        JyRX/U8Nk6SQ73IHhFfnnjPxv6gAXKMpuEv18toGeA==
X-Google-Smtp-Source: AJdET5cNVBG/G+A8k6e4LFldFeVjR2nTshf3Lyduq0V2YFxNdkSx9AZHbq9HG39O9oWPHdMC3pjCBmcqJajcvcTvQw0=
X-Received: by 2002:a37:b4c7:: with SMTP id d190-v6mr18272872qkf.165.1541388526516;
 Sun, 04 Nov 2018 19:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20181102160710.3741-1-v.mayatskih@gmail.com> <20181102160710.3741-2-v.mayatskih@gmail.com>
 <fe79c7fd-1e9f-dab8-3c65-8151181c922c@redhat.com>
In-Reply-To: <fe79c7fd-1e9f-dab8-3c65-8151181c922c@redhat.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Sun, 4 Nov 2018 22:28:34 -0500
Message-ID: <CAGF4SLgDk+48aLKHhA_ZgRc6D30tGdnB89b5m5bZKwzyoDb0dQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] vhost: add per-vq worker thread
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 9:53 PM Jason Wang <jasowang@redhat.com> wrote:

> I wonder whether or not it's better to allow the device to specific the
> worker here instead of forcing a per vq worker model. Then we can keep
> the behavior of exist implementation and do optimization on top?

I was thinking about that too, but for the sake of simplicity it
sounds valid that if the user wanted 8 parallel queues for the disk,
they better be parallel, i.e. worker per queue. The rest of disks that
don't need high-performance, can have 1 queue specified.

-- 
wbr, Vitaly
