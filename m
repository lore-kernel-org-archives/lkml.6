Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0538C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC8208AD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 00:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qI81QjrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAC8208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbeGKAfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:35:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46029 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbeGKAfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:35:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id c4-v6so3671836wrs.12;
        Tue, 10 Jul 2018 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oFgNAnIWTx2kvUehYXFbG5Zguk9oPjYrX3BQ8LiZjzw=;
        b=qI81QjrMs7qklBMBwXkKCtpndP60U0p1xzouVxlX8g/Vo+xsQ/F36ZScK8fBKRKJgV
         1GHpXIO4+HgtunOnp7PtmG8VhYZ5H85GtioHjTiQeBTzzufzpvMkQUr40uAlRf0I7H0E
         GhF4EatvPj3r03bNIjIKXPzlNtG1tkXUlSFhBdRqADPtZffIuUpwQV8DBnUJcyErHzAJ
         ucm34vM6gZ/Cy5QXhGJyoeaWar1ajkl5mupU4l0zS9nkWKzn4TiG/xBVvy0OpD6nIlUt
         C7G5nc7iROjgh6iZBx14WGmHbXtxhxLX3qGKNFiNQcLCTm0WryekjVcFys3rOnr948YQ
         ieLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oFgNAnIWTx2kvUehYXFbG5Zguk9oPjYrX3BQ8LiZjzw=;
        b=LET7sBlaLSzpBTcc1ZHWy1jJQeIFEGPF+SOczd42L+Ci36ioyw2/ylOctasaZ2MFG/
         hmSWJsotZJZgPBclxm2iK6Aiq3KbMo+/Ex2VOFT4VNtZ6eJvQFzFSkk0fN7li4mAqVVO
         pyzL6UVKRtedw4iCgqTfTo0/ua0e/u0YZD9Mh6wlUgnoy6SQxpQK6p5xZl6GyaGYPsei
         0BYdCvkRWef7r/qWp/rtY6ttahf5es2SRiEVgb3iE6TB4n7TpknRiKnHDd716Gaf2/Ib
         r7f92LKiLBUoNwv1ih9YkA/tLrqLzB0UlWHnUQLf44y4zW2inowNXQxQOaGyssa4Ejk1
         s38A==
X-Gm-Message-State: AOUpUlFFey+WXOLALAIcaugUNlFIIC/GQ5M4GUp72QRkxXUO7WFfi0b2
        i2JaMV0sdwKOmszi7rsEPjvQ0jMbpQGQQjfXkebLJAYx
X-Google-Smtp-Source: AAOMgpe1E5oNqpnUfQHKBJLvdfXDDEJAyrtIVUZvO8uQTTN1rkXt6MTkyU3KMlquSXNyLspAWf1ITKumBuf5n7SKmBE=
X-Received: by 2002:adf:9744:: with SMTP id r62-v6mr3042372wrb.130.1531269239728;
 Tue, 10 Jul 2018 17:33:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8a8a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 17:33:19
 -0700 (PDT)
In-Reply-To: <c29f1535-3c5d-e588-862c-ba948363c973@gmail.com>
References: <20180710065147.27647-1-jmaxwell37@gmail.com> <3f856638-52bc-6630-a3d2-2b50f1bf7e48@gmail.com>
 <c29f1535-3c5d-e588-862c-ba948363c973@gmail.com>
From:   Jonathan Maxwell <jmaxwell37@gmail.com>
Date:   Wed, 11 Jul 2018 10:33:19 +1000
Message-ID: <CAGHK07Aoa81QN+LmVttJQ56Sn+R-KyksYqZxSYL5-5reDRt3WA@mail.gmail.com>
Subject: Re: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        David Laight <David.Laight@aculab.com>,
        kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Maxwell <jmaxwell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:48 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
> On 07/10/2018 05:38 AM, Eric Dumazet wrote:
>
>> Note that if we always do jiffies_to_msecs(icsk->icsk_user_timeout) in TCP,
>> we also could change the convention and store msecs in this field instead of jiffies.
>>
>> That would eliminate the msecs_to_jiffies() and jiffies_to_msecs() dance.
>>
>> (That would be done in a patch of its own, of course)
>
> tcp_keepalive_timer() does use icsk->icsk_user_timeout directly in jiffies unit,
> but considering keeapalive timers are rarely used, this point would have to
> do the msecs_to_jiffies() conversion.

and also if icsk->icsk_user_timeout = 0, then timeout in retransmits_timed_out()
is in jiffies and that would need to addressed.
