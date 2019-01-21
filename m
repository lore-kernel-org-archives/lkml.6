Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78413C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B8120880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="kF7MDOz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfAUHRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:17:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45956 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfAUHRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:17:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so22479402qtr.12;
        Sun, 20 Jan 2019 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQS4dApOQ8D+jq9Hf+FEXLnyJvAFN5QvNThj5XsJjH8=;
        b=kF7MDOz04YfonTsmUw6Hw9Bl27lA2DYqMtZ28shJmJ5zSNJZqrIcjKW/F+FCBxz5QW
         jrc3WlNejTskjQd0vjaPpuMRAZ2YOxCsxxgdg/puoLPf7rJXzvRUKfZvjzSkn5F433Yq
         InqjzFsxXYAnX/MMZmKJA2UbahN6jy+UbD0zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQS4dApOQ8D+jq9Hf+FEXLnyJvAFN5QvNThj5XsJjH8=;
        b=p3BWhVvvRdQc40PXm/lYZi3UuLstaDXAoE0rjthGHRnS4N1ed027E2uCRxTYs0bYnO
         pwKPrbXKijAmwT46IPcpgmlAy6HGxEfhJFDH6LSt84lFrJDVW2K4csHpkW3TIXeaiEtz
         JmbCvHAuihTHd9No4sZadClJRnw1Oj3Z4vnsCFP4klpoWe3o3xPQSh1C2HM4fxnawDXB
         ouUkfiJaU3s1bLynbFR5QAazPlli6HYiYMqmY6ABISTmvx5KA604e0T5uy4069l0M3qp
         tCiOPR8wrWXYhK08aQMoU0k4tFRiiGG8cmz75S45yuRsmH72eP50WHRvFc7Q1w4B/38V
         RW9w==
X-Gm-Message-State: AJcUukcbsiKeNUEwJiRvgLgDpICvECvRzni28CiLb+OOskyfBVVoges1
        +Zcc0kpAgQyLg2VZQJXed+oFSZDR8jjaN3RZpErkGvu2
X-Google-Smtp-Source: ALg8bN44shxb2J0M3z9sjRCFuo4/J0aMjjxqNvJ52rP1UcA1tnGgudSEPIMVnKPVzBjGDURtQ9HSX83f/Ti71iUvX2s=
X-Received: by 2002:a0c:c927:: with SMTP id r36mr24582500qvj.51.1548035295703;
 Sun, 20 Jan 2019 17:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20190109164343.164205-1-tmaimon77@gmail.com> <20190109164343.164205-2-tmaimon77@gmail.com>
 <CACPK8XebHzVAO2TX25N24S0Pgg_0xA=7GN3j0oXhSyD4LmL4=w@mail.gmail.com> <CAP6Zq1j=oPdVXZKBteBcaLVZcvoU7M6YbfGhSCaC44Ld9AQ9Ag@mail.gmail.com>
In-Reply-To: <CAP6Zq1j=oPdVXZKBteBcaLVZcvoU7M6YbfGhSCaC44Ld9AQ9Ag@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 21 Jan 2019 12:48:04 +1100
Message-ID: <CACPK8XfFRigW9pN4JLrH+KcE6ACJUzX0qJV8xeph_DkfKWgBEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: iio: add NPCM ADC documentation
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        linux-iio@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jan 2019 at 02:12, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Joel,
>
> Thanks for bringing this to my attention,
>
> I think I will leave it the same way it is now because I will like to develop the reset driver and to handle the NPCM7xx SOC resets.

You could also do that.

But I was suggesting you use a phandle, so you could then find the
node you want without searching the entire device tree for the node
with the correct compatible.
