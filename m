Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FBBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F11926889
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F11926889
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeF1EMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:12:45 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34246 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753382AbeF1EMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:12:41 -0400
Received: by mail-qt0-f182.google.com with SMTP id d23-v6so3637425qtp.1;
        Wed, 27 Jun 2018 21:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fN8hCwxtQwEM6xRNMJUxbh7l5EF16hTHzBycvduYrGA=;
        b=Rfz3D2pyyX7gBwMqLUD7RE2kuBT9rMczP4f/l33bLlWsy1ZBKhBmnhZi0PgsZ+gkS0
         Oaz4+hWly7jp/jEKXPM+ooDKbAlJ5ZNGn8YR+oLJS/GUjsCGCb9TA/B44m0LDd2f4Zu2
         uxt1Yv636RG1M16gulZi6OWd2KqTN0RYy6zEu/0xm1Uk4JFOHuQnppYOFolAZqQyHxOh
         rae4GDoSV+EmnyAMeonFhS1ktqYv06ZzBe1LjA4/uB6Pw11noUhyJv5WlaM9QAY3oPcf
         CSBOoBBaKTdbZGD8E/L0dUQInWYPuuMRKiND29XPTf3gCxqpQvcg6Bw4b2++wBtTDmmV
         T/fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fN8hCwxtQwEM6xRNMJUxbh7l5EF16hTHzBycvduYrGA=;
        b=U475jhP4QUNj1xTqyXcGkSZobXKZunjTrXRYLKa//P3ol06KN/S9BTKNh+D69UrQtM
         J1G9xVg81dCnSw6BZ5EYtNyknUApc1XP/74iwOowSZxNJebDbm2FpSvH1yp8Y4XUgHBU
         91UBBpljl9bTpk4cY7Zvw0MUWcd4T9dBt1evc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fN8hCwxtQwEM6xRNMJUxbh7l5EF16hTHzBycvduYrGA=;
        b=B1y8FZxBUeWuxAx3hsTPNAjeyfFQ41ub1tI7xIeYgmYiuj1yzLnQ0qE/Tcw+HPM6DO
         LiyBbX8+ZENZFXfNU0vgJzQdsvsdOLYcqX5sIMC3mQKJ7ZFCf3ZJUkDSpA6UuvTULqwv
         E9Yrp1o2uOYK2g2DyVzWtalJ2VWOU3QfvMnYmc+j+J2NrfdxjbDFaPmnLYbKZF6wc1e5
         makalwuvmd77Bl2xyBgRTjU/8RKPU2LJ9zLEd4d3IONd3a5KYsuPyTAMaGkR7enJ3SJC
         QrjAVyoq7MsK/yr+OsQiN/fd8abdS9w3JJ8Yoq21IW0sJxg3w7JuYmfjGDPeYSIpMTV5
         EEeA==
X-Gm-Message-State: APt69E3FnqEkxVtCID2GZOoiR/oc/gubmY06ON91MUvuQJUfimnKHMqW
        /XCtITRDDZ0Y1osY8vUHOTKAjI+W0jHOSxlaZGI=
X-Google-Smtp-Source: AAOMgpdPdpGNacQ/5cuAnNpW1MUBieTj4rI4VIV4z3RqxcEdzS4E0e56TsoOPNIG2BMLh4B+gtKtPZCKwWk4Asyui60=
X-Received: by 2002:a0c:b892:: with SMTP id y18-v6mr7759523qvf.188.1530159160620;
 Wed, 27 Jun 2018 21:12:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:12:20
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-12-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-12-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:42:20 +0930
X-Google-Sender-Auth: gwVSt078kkl2v3vegZs74cOOf9E
Message-ID: <CACPK8Xc6zRXUzEyde=A2m8U2mzaeNMu8w=XFW77-5_uJgW3EgQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] dt-bindings: fsi: Document binding for the
 fsi-master-ast-cf "device"
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> This isn't per-se a real device, it's a pseudo-device that
> represents the use of the Aspeed built-in ColdFire to
> implement the FSI protocol by bitbanging the GPIOs instead
> of doing it from the ARM core.
>
> Thus it's a drop-in replacement for the existing
> fsi-master-gpio pseudo-device for use on systems for which
> a corresponding firmware file exists. It has most of the
> same properties, plus some more needed to operate the
> coprocessor.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Joel Stanley <joel@jms.id.au>
