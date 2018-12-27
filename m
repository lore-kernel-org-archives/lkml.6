Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF5221741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545900458;
	bh=maln6hAy/7Wt4aKjXJIx5desIU0QSktkdG7ZRK96D+U=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=P86ieoSrTzEH4tSW9FhuN/k5IiLnioXjTqL1TG4yWdD3VZqfqT3LD935eItrl3CWC
	 /tsWiTZl35HTjq4Jjc1YLvmeQWr4tsMl2qbDLPgiCqKGhAu9SDILhmz9KM69Y7vBNt
	 BhdZBfVcb7IQ/cj6DxlHqk0xVOd+2ChULkx4spEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbeL0Irh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbeL0Irh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:47:37 -0500
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD5221741;
        Thu, 27 Dec 2018 08:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545900456;
        bh=maln6hAy/7Wt4aKjXJIx5desIU0QSktkdG7ZRK96D+U=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=T9fkm7wPze7i10JlmTv6TxRpI06Dp7iR86R58bTWoLnowZNvnmj//3tlSzj3t7cXr
         j1IcuhvwxwzTHURvv5El2rP/dNWDe0aMIfZbScd8w1cbVa3gkCShGj0Pwmhl+WfXjg
         cMTNq8ST0rNb4DHYfVe8MEWiNt9iReXnC38mBWKg=
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so15678845lji.7;
        Thu, 27 Dec 2018 00:47:36 -0800 (PST)
X-Gm-Message-State: AJcUukd9NI22mQhi8M1bNpxpjRhSAav95J4pl8wwY0zrfolxRAKvxuy6
        qX7yRzprssLNZ2SIVJtEEK2FMwt6PU6ThU0YS20=
X-Google-Smtp-Source: ALg8bN5YJP9bm13148kjkNeHkOWccMylZ3NkLMAfq+v3OK9e7SqWlRQUZhbtWkua0TI3TDDojE8qPvAePCq7wvc4Ij4=
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr3540501ljg.138.1545900454439;
 Thu, 27 Dec 2018 00:47:34 -0800 (PST)
MIME-Version: 1.0
References: <1545146852-32207-1-git-send-email-krzk@kernel.org> <1545146852-32207-3-git-send-email-krzk@kernel.org>
In-Reply-To: <1545146852-32207-3-git-send-email-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 27 Dec 2018 09:47:23 +0100
X-Gmail-Original-Message-ID: <CAJKOXPew1Ufq8vOE2=dqh-=zCQpB8H-X+CEK456MqgcEsNi+5A@mail.gmail.com>
Message-ID: <CAJKOXPew1Ufq8vOE2=dqh-=zCQpB8H-X+CEK456MqgcEsNi+5A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] leds: Add helper for getting default pattern from
 Device Tree
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 at 16:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Multiple LED triggers might need to access default pattern so add a
> helper for that.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/leds/led-class.c | 42 ++++++++++++++++++++++++++++++++++++++++++

As pointed out by 0day-ci this has to be in leds-core.c.

I'll fix it.

Best regards,
Krzysztof
