Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE13C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D421B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LHdbWUHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4D421B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeHIJh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:37:58 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33102 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeHIJh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:37:58 -0400
Received: by mail-oi0-f47.google.com with SMTP id 8-v6so8228271oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q6nsvPMdwQ/LSeTS0u/S8l9EgKiy8KAK+80Arhi3a1c=;
        b=LHdbWUHRqw1vTa5y+Hg1KEobBLNNun5kSDwvrV5iDHpxVeeb101GaBIe4kXMz1yO3r
         Q6jZqhMZ1jNNv7aFMkTbX+JPdUKfEcT7Oif2dH6X5/DucE9n1XwXBi+bbCW6A8TUdSiT
         uLj66E4f21fAjoYYDwOneGLv7jOJkJFg6qclI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q6nsvPMdwQ/LSeTS0u/S8l9EgKiy8KAK+80Arhi3a1c=;
        b=gUYZsrRmfzjHWrNY2KX4hilNl+IcRybPRvPle/Nu1siDXBf/wC1ZGy8Etp8oFZ8UJY
         qsqNpREARswfnPIgUW3jTXsmIvcjhFH5G+STogA6NLnl0kvmoZYh3YwJCSvdQP/eeura
         us5Yt4iHxZO877eLpqUdWnb3Mdzn3YxSq+HOHxxjEcdXzKjjbg/9fbtjjRq4H9gYEod3
         2D6+QaIQRf4JaKLbaU/NCcTdzvQXGeEFAvjFWyQYqVi/zUZzC/5CEj+ua+Nx3roqOtP5
         eO+2agl4vJlcyLEGSamvnHENbWq+Tc1r51+xaG6FTio986BOtgDM9vpeQIibaG+11UZG
         7Ggw==
X-Gm-Message-State: AOUpUlFInPyPJbCVkIq+cduF0wYg+nRPXb4YxTylKNj7MGvxLz1/5jRH
        UPYRJGUvxRBtIjqGuJcmpZAYy3nqlWHy2jnqhPy4Qg==
X-Google-Smtp-Source: AA+uWPx+u6thLpzNLxZDjSzpoavNDWCTYRRhQO5Y3zmFGFU8YFHR5x/qR0n31lWBo/N0kChllaG5d2mo/sr6gpY66/M=
X-Received: by 2002:aca:4bc6:: with SMTP id y189-v6mr934648oia.181.1533798869048;
 Thu, 09 Aug 2018 00:14:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 00:14:28 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <EA52CBCF76D5E04D95BED55B83577BE7A6770F@MBX50.360buyAD.local>
References: <EA52CBCF76D5E04D95BED55B83577BE7A6770F@MBX50.360buyAD.local>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 9 Aug 2018 09:14:28 +0200
Message-ID: <CAJfpegtOqbhwKBpaGdWwcBG5sBrbjtLFzpFsqsB8_VbT7=vE9w@mail.gmail.com>
Subject: Re: FUSE: write operations trigger balance_dirty_pages when using
 writeback cache
To:     =?UTF-8?B?5YiY56GV54S2?= <liushuoran@jd.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 5:37 AM, =E5=88=98=E7=A1=95=E7=84=B6 <liushuoran@jd.=
com> wrote:
> Dear Miklos,
>
> Recently I've been testing FUSE and libfuse example passthrough_ll with w=
riteback cache on, and found out that the performance drops significantly c=
ompared to that in local filesystem. As I can see from trace, balance_dirty=
_pages is triggered very frequently even if there not enough pages that sha=
ll be sent to libfuse. I'm not sure if this is a known fact or the FUSE wri=
teback feature requires some specific configurations. Trace log is attached=
.
>
> dd-19067 [001] .... 195295.568097: balance_dirty_pages: bdi 0:42: limit=
=3D3180390 setpoint=3D2782421 dirty=3D5 bdi_setpoint=3D0 bdi_dirty=3D32 dir=
ty_ratelimit=3D32 task_ratelimit=3D0 dirtied=3D32 dirtied_pause=3D32 paused=
=3D0 pause=3D33 period=3D33 think=3D0 cgroup_ino=3D1
> dd-19067 [001] .... 195295.602029: balance_dirty_pages: bdi 0:42: limit=
=3D3180390 setpoint=3D2782421 dirty=3D5 bdi_setpoint=3D0 bdi_dirty=3D33 dir=
ty_ratelimit=3D32 task_ratelimit=3D0 dirtied=3D1 dirtied_pause=3D0 paused=
=3D0 pause=3D34 period=3D34 think=3D1 cgroup_ino=3D1
> dd-19067 [001] .... 195295.637026: balance_dirty_pages: bdi 0:42: limit=
=3D3180390 setpoint=3D2782421 dirty=3D5 bdi_setpoint=3D0 bdi_dirty=3D34 dir=
ty_ratelimit=3D32 task_ratelimit=3D0 dirtied=3D1 dirtied_pause=3D0 paused=
=3D0 pause=3D35 period=3D35 think=3D1 cgroup_ino=3D1
>
> BTW, I'm using Linux kernel 4.17.12 and libfuse 3.2.5. Look forward to he=
aring from you. Thanks in advance.

Try

   echo 20 > /sys/devices/virtual/bdi/0:`stat -c %d /mnt/fuse/`/max_ratio

where you replace /mnt/fuse with your mountpoint.

Thanks,
Miklos
