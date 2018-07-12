Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA78C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42F620652
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8j1sb4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42F620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbeGLQUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:20:14 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45562 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeGLQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:20:14 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so31217441oic.12;
        Thu, 12 Jul 2018 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aYNNiOkxV0+qzrrcfAnBC1hBKWw9HPmzpsTThQDXBeE=;
        b=p8j1sb4JMDFLlADA2+rBr/9P8OJzxTPRYY1xCBwKqSWZDXrHzW8UbczjgMW/Ay/6gQ
         PMWQh3Uwikf40dmkhsyq6ZBlAGz7ONTBBJYROZPZroVJeGxMzuhtH5OVQ/vP+3ZCsq1Z
         xXc4qZNBwN3doGQ6DRJX2kCry+uw31LB+T+Iq4MqVydUchiOZPaCnwyhIUx+SlSwkDdd
         9gPyPXqzrZoVC22C2YvgI6eiWwuP65JKv/+Y7LELYBRoiv8/hiXOWrJ4Wez5CSchWBf5
         ttvDH5bFfTKIEb0Va7iSCrSL0EV16FriNjfwo0QUDsv+SsX7MRz9G5GOw9yDpKfnkb8x
         XX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aYNNiOkxV0+qzrrcfAnBC1hBKWw9HPmzpsTThQDXBeE=;
        b=WyFEkAaIBZjEaJltcRlQiWX8kHlmSJ8YaB544+93HjkBhwejqFUjwlSTUr1o3jpgA6
         gPlmFHuegsUeMU4BlH6Qj2Pru7B+NMFhIXMhf7TJIxzxff/S/KbR0URYx+Of/7218wnE
         hY1fKzWJER2BWyRRz1eMD11H8EVrNR0hRXMNvkPL0D0j1aN1W5DiuAqmrfrTbhXzGc2e
         JQ2hVuvM5uQJCO3+bLRZPnodCXvpey+id+mQb0IWxQsh8Dk4CssCoPwjgvyuGuKCzJHx
         4YxQBg08Akdrt1Mm3i15Lmh8CkmlQqk39ddysLyDOgBX3UhjmG2qsxUf6F9MQAkW7FLP
         Z/Dw==
X-Gm-Message-State: AOUpUlFeYhijcka2QHHaiiNGRnX9+figUftbhDOyDJAqjMDg2sgEGOdT
        JGi+TyXKJnC4rnENe+CeZXljbByCNZPILppfeMw=
X-Google-Smtp-Source: AAOMgpeXeoWl34p90RcS5hzLfJKTN/OsGVnMzU5HXnD1MRaXvTLUG0iM1F4QO6op0rUjuh97US4MuuNqTls5qkEsDEE=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr3209996oif.9.1531411801714;
 Thu, 12 Jul 2018 09:10:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 09:10:01
 -0700 (PDT)
In-Reply-To: <20180712160517.7382-1-standby24x7@gmail.com>
References: <20180712160517.7382-1-standby24x7@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 12 Jul 2018 13:10:01 -0300
Message-ID: <CAOMZO5C19cfkXaT29g+rW7t3x6gAiZpEyMWV9uqjzLF=9fwgrw@mail.gmail.com>
Subject: Re: [PATCH] bonding: Fix a typo in bonxing.txt
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, netdev <netdev@vger.kernel.org>,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:05 PM, Masanari Iida <standby24x7@gmail.com> wrote:
> This patch fixes a spelling typo in bonding.txt

There is a typo in the subject too: s/ bonxing/bonding/
