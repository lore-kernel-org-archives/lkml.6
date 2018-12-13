Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631CAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD6320811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b07SuKar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD6320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeLMAVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:21:14 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:40742 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeLMAVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:21:13 -0500
Received: by mail-lj1-f174.google.com with SMTP id n18-v6so205831lji.7;
        Wed, 12 Dec 2018 16:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqxiAOw7OtShfro8/bvnUFGX/ltm9YGvR2Bgh5kiSyE=;
        b=b07SuKarla+Ae6YdcEG2lQGVaO48tTUei65Z1zqG8XdpP6QCQXR7kDo1yvdYJ3AV2F
         6x8DLEUi5m5ijlfI43AUUWLfjSVWdmSsRjkLj9yDLET4+c9DzVaWweB5+Uz412psP7t2
         ctC5rGHTgjdnKkCGXmp66iBz1Jj3RvBe7t6EurWl9oliWfjhZdQDvTk+RuHmoJT/4EAA
         BBme5wCVIH/+Znz9BLUw9fwiDh2HsENlGKcIfTsun9FgSJ8seZibjBjMWnbRica0xoxr
         8XGXnocU56+Enq0f29vCiXMRYcHctiHUySpIWN9ESmfjRMCinUADWfxwSpJi+Ex2zs2E
         zhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqxiAOw7OtShfro8/bvnUFGX/ltm9YGvR2Bgh5kiSyE=;
        b=LbAOkn0o382XZI8PvcKDaB0FtNktQubfioNBL5SBNgRvAyldOAyWPjlsk8PZ01RPa9
         ZTCaN+VV4zYAZ3h6Ngf4+/yPRYP2TdoLh8g1qpOAAXczqglSk2nSkCxekwKC0DSrUatr
         ss8/xS1OkaC0bX5YH4zFkjnRim640Sd4LbZqIErUbbmvk5s1xe7WNV3/2mu+S503aGUf
         jsiHvlpYE8cEwoTaLGublSGsirIjBeUh1KgT9LUpGYah83Dm2ClNvxJL2hYcY7aYPdBV
         +P3teaJDAmXZ61zWxLEYy0mzOYkBrwkquHt78WM1gCKnVbVB5eGiD8fI6z6xyOQHEoYr
         /iIw==
X-Gm-Message-State: AA+aEWZBYN5A0SnKu1ViaRlJKJP8j2ZRGd64CB6nYHIqNQ8XXPeRAYda
        vr/zpMMsDqeRghME5ZhiaB8QdT7Owi6vpSOPm9M=
X-Google-Smtp-Source: AFSGD/UQ5OvY2gSxHorAiKmN/IUrqivHB7dxF1O4EZ0lRByxU38t/A7yTOvZkw5VSglIDdxhabVrAGeAWrgj0Io44MU=
X-Received: by 2002:a2e:478f:: with SMTP id u137-v6mr13567283lja.142.1544660471176;
 Wed, 12 Dec 2018 16:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20181213073245.5b2d2536@canb.auug.org.au> <20181212205253.d3reuxcyjhnwh3ul@ast-mbp.dhcp.thefacebook.com>
 <20181213094820.62d26354@canb.auug.org.au> <20181212233909.hhf5q4vpi3mmi37u@ast-mbp.dhcp.thefacebook.com>
 <1544658320.185366.407.camel@acm.org>
In-Reply-To: <1544658320.185366.407.camel@acm.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 12 Dec 2018 16:20:59 -0800
Message-ID: <CAADnVQL0jkm6UkQkppcW7bNzw8bvr-FZQi3fP6oJRCcdGiYZ6g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the bpf-next tree
To:     bvanassche <bvanassche@acm.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 3:45 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Are you aware of Linus' opinion about rebasing? If not, please have a look
> at https://lkml.org/lkml/2016/3/26/71 or https://lwn.net/Articles/328436/.

very much aware.
above is not applicable to this use case.
