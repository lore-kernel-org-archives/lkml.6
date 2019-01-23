Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9467C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867F321726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzkPtONQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfAWIZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:25:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36140 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfAWIZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:25:40 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so739418pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=046xDKJOdSFM8xjN3AKVEpyB0Yc1NJ5LwIijQN5PPtA=;
        b=IzkPtONQ1uU9r8siPDEzHU7jEBNd01kqHClbGZiATXRd3xqw3kt+2qCFq0Gf5wDHwp
         pPuu0MCSsHq1hO8SnpqvF2xQfWJ0XhS++FaeGh/NjjiH/RtWAk2IRFlaaHcq82snxyxe
         zQ3OH5GzoQ4WajepEkTHN2vV1uiYjDBa/F00g7XIqCDFgPMtq//HJR6bBE9Lht18gnm7
         Fd6Wm1+btaIXkwQzbpVGkb/vGgIryRDGeC1KtN0bv4h91gtxM6So57y9RuzP+gP07Nqs
         fO02YhC2sG7C3UBdp45xzaa3f6QGKPp8AxTnkXIsvzZUWGsUOBrtgkJJSE7hu1vGoUrS
         c+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=046xDKJOdSFM8xjN3AKVEpyB0Yc1NJ5LwIijQN5PPtA=;
        b=s12fSDa1pW7IIT6e1z5GrSVF86gOEhNqvBm2yN5tFWul/FdeOfmlHsb12mPo7FdWc5
         UKJpX5Vr+JSXi3sI+dXFHv9NFUr33koZ49Yo8MrXc9PXOiIswLTCbo4kF4NXCh4qntQz
         pW9J0bTKZoQN55Mcj8TBDBPP0yoKNcFos36hF9VoE4xF+shvj5o8bzsTfXO8aTE83FIT
         2s09pLNWsmZSO5kmkdLuxwOwC7wTJoXucnse3SQFoAKR0Zt/Am/gkQwYXKYUFj0j4sWi
         mnU6Fglc33zDeNUsc+kPQ/At8ZCNJvRr2SCw2qRO9WtFJPsnBpmrvR9eduFNmnSPBfBX
         HVWw==
X-Gm-Message-State: AJcUukciLMknwx+SOIMS29Pfpx2Pkj6ToIBE3ygdISHYIjVxxJh9fk2r
        azaW1ig9usdb8sfNFpYexVQJRBugeXw=
X-Google-Smtp-Source: ALg8bN5PPjmv/SH+abacR/EuZclxjzm+yg3wcvmi8qYjM2ySXlb7efQbzbt+ha4sT8yPHzrVmHeYNQ==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr1158185pgi.8.1548231939145;
        Wed, 23 Jan 2019 00:25:39 -0800 (PST)
Received: from localhost (193-116-78-72.tpgi.com.au. [193.116.78.72])
        by smtp.gmail.com with ESMTPSA id 196sm44786149pfc.77.2019.01.23.00.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 00:25:38 -0800 (PST)
Date:   Wed, 23 Jan 2019 18:25:26 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] time/nohz: allow the boot CPU to be nohz_full
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190114064745.27306-1-npiggin@gmail.com>
        <20190116175440.GB26169@lenoir>
In-Reply-To: <20190116175440.GB26169@lenoir>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1548231631.0hg3ugxhh4.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker's on January 17, 2019 3:54 am:
> On Mon, Jan 14, 2019 at 04:47:45PM +1000, Nicholas Piggin wrote:
>> We have a supercomputer site testing nohz_full to reduce jitter with
>> good results, but they want CPU0 to be nohz_full. That happens to be
>> the boot CPU, which is disallowed by the nohz_full code.
>>=20
>> They have existing job scheduling code which wants this, I don't know
>> too much detail beyond that, but I hope the kernel can be made to
>> work with their config.
>>=20
>> This patch has the boot CPU take over the jiffies update in the low
>> res timer before SMP is brought up, after which the nohz CPU will take
>> over.
>>=20
>> It also modifies the housekeeping check code a bit to ensure at least
>> one !nohz CPU is in the present map so it comes up at boot, rather
>> than having the nohz code take the boot CPU out of the nohz mask.
>>=20
>> This keeps jiffies incrementing on the nohz_full boot CPU before SMP
>> init, but I'm not sure if this is covering all races and platform
>> considerations. Sorry I don't know the timer code too well, I would
>> appreciate any help.
>>=20
>> Thanks,
>> Nick
>=20
> We used to allow that and that broke hibernation :)

Oh interesting to know thanks, I'll look up the old code.

> So, since we need to have at least one CPU alive to handle the
> timekeeping updates on behalf of nohz CPUs, we forbid it to go idle
> and offline, for simplicity. Now hibernation requires to disable
> non-boot CPUs. So if the timekeeper is not the boot CPU, it's going to
> refuse the hotplug operation and break hibernation.

Simplest would be just to make them mutually exclusive. I don't think=20
this customer needs hibernation.

In the longer run, I wonder if it would be nice to allow CPUs to change=20
in and out of nohz-full mode at runtime, and the time keeper CPU to be=20
able to be migrated at runtime like it does for nohz idle. Maybe that's=20
over engineering things if there is no real demand for it though.

Thanks,
Nick
=
