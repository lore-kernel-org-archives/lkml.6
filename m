Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6578ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8512075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K6eu7jLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8512075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbeJYAwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:52:21 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38151 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYAwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:52:19 -0400
Received: by mail-lj1-f172.google.com with SMTP id k11-v6so5350753lja.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KE4Z5RqGmFwIirvCmcQXGA7g2F3UiV0a7VmuLfzbaA4=;
        b=K6eu7jLCQU/1J/NQJxqOI95yX1egHkxcSIOVg6PidI+g34yoQC1rBOIWAj/n/x93rl
         QhInUL1Tc+t1p+e2B+KKsZQwcYSov7W4RQMhlWj1i3BTcXiUJWdT96+u/ZvKBHoLBFLO
         AR4mDnhtGZsY5t0bLKHt+670Dk2St8uamIKow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KE4Z5RqGmFwIirvCmcQXGA7g2F3UiV0a7VmuLfzbaA4=;
        b=X7vTDdwx7B21HGM1FOM+gPnI8SApGOQ8/x+n1p3o/oTRt00CkiXTP5QVVRzALEYBag
         u/i08qFgaCrYV8rs0Cm7XEkh1dI+Zy6OlMDYeAdqWhSMI0GHTihvgj7WsqcbkPwUD/QO
         OQ3i1SuzRmMWmdO43dtzstOLPhmMonTLC1rlG/JX63JuIdptJd36arjR15oSMIhCcLGm
         Li6wZjbyaVW3IiSUEchoTxAH4TmJQS1XIRy2jpFxwpLuo8hKvdPZbE9qPb5sYESkH71l
         HNA0FdixMyQ54NHdDeCGrIL7mPGZc4jg5GdPDm8IxvePC+a6Xuy2JFrUjb+p9V37dLD2
         YR7g==
X-Gm-Message-State: AGRZ1gI3cALfAkNnfXOX5osBOhGvfcXLV0EKlf5l8KDZSmN8t6AftxVy
        KvyzcSN/z3NPcB2NNQCuSju0vG22rNxf0sIT
X-Google-Smtp-Source: AJdET5dgSIAQCnlFHf4TdUjSim0Q6lPZitthr5gaKm6aX4p9naeiLxWVSrymIM7cbBxtz8nntyyOjw==
X-Received: by 2002:a2e:5c2:: with SMTP id 185-v6mr2435386ljf.127.1540398214274;
        Wed, 24 Oct 2018 09:23:34 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id u20-v6sm800872lfk.55.2018.10.24.09.23.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 09:23:33 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id u21-v6so5344160lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:23:33 -0700 (PDT)
X-Received: by 2002:a2e:980f:: with SMTP id a15-v6mr2444826ljj.6.1540398212895;
 Wed, 24 Oct 2018 09:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <743b8d6b-6b1f-8766-7db3-1df5d95227f5@oracle.com>
In-Reply-To: <743b8d6b-6b1f-8766-7db3-1df5d95227f5@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 17:23:16 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgYz2Ht5ieCN4_t3L04rqEa6UW+POk-GxydR7UyASQTgg@mail.gmail.com>
Message-ID: <CAHk-=wgYz2Ht5ieCN4_t3L04rqEa6UW+POk-GxydR7UyASQTgg@mail.gmail.com>
Subject: Re: [GIT PULL] jfs fixes for v4.20
To:     dave.kleikamp@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yuchao0@huawei.com, cgxu519@gmx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 2:47 PM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> Just a few small fixes

Pulled,

      Linus
