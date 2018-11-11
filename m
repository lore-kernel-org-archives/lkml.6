Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83E9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CF020854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CF020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbeKLGIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:08:13 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:53429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeKLGIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:08:13 -0500
Received: from null ([172.19.246.153]) by mrelayeu.kundenserver.de (mreue009
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1McpW6-1fn9KX3ZXG-00a0y5; Sun, 11
 Nov 2018 21:18:15 +0100
Date:   Sun, 11 Nov 2018 21:18:12 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Mike Brady <mikebrady@eircom.net>, tiwai@suse.de
Cc:     devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        f.fainelli@gmail.com, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, julia.lawall@lip6.fr,
        linux-rpi-kernel@lists.infradead.org,
        nishka.dasgupta_ug18@ashoka.edu.in,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1197390391.186035.1541967492518@email.ionos.de>
In-Reply-To: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
References: <B1CDD261-AB22-43CE-AF46-DFB5460B5D50@eircom.net>
Subject: Re: [PATCH v2] ARM: staging: bcm2835-audio: interpolate audio delay
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:2WhD7UsCKuCLCUAgyaumxBCtesA74bOMmvZUYXQTG4kZ+6W628c
 raR3YKIY92DBdXJ72bk7ir3/oRGXWKmfGZxIsAeaYHzskU55ULI78MXvc7vgFLV922tvAIR
 XV4z2fLiW0gGUOYKMuX0MGpBFzXC5FwMx7yH67YwdiSb9kxXm3HNw6HAHqEIViy5YLs8XNi
 OhwB8sihnNffvZPeu0gJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9jkkUeVqVL8=:3kd9QtbNnQjjjuSc8Co7Qp
 IJdrMKBnLeVMr0/t27PbMcGGuQc8DoP4hS4TtIN3jbHWlk7M818vgGfyVWXb2wkhich5/4kBB
 /02G1aViogKOYCFU2CT15hmAInU6lji9Y9auae/nok7BVpTGlciv1d+6uEQUCEG92Z8cUbW9U
 wh2chZirQUa/AeD+cVsvLX+XIqiHrhLNv3zuTYYyzMTPiuscK/7UR2eRNX7aCJ8//GuJApWy5
 Auuzwknjek9MpoMQjM+rEjDP3OqHI85TY0h32/EAqPoNaSLwtynTNQ+RG2v6t4WfmX3tUniFZ
 SZ4pWmIgK0J/YEYOxr1kDFSyCe+lEc16G8F6xwwqvVUQE65S2vuMr/nNK3Hdt9wpIAj2VxBnG
 EPOtyvbbEvpobncopYiE0G7+oyKwJiQLj9rOLht7O3yR3zVogo5JUrLWkT5qvxW3Q5rZMKcM/
 APghJpS2OFWoxKys+BWCUv6e4GiBjOMldd3NxHNILWz9A9D5DOSvPl4V+b+R9DbsEZeUziB3N
 yVe7ojQCuR6t4PD+P3AO4OwfQCDNtW96ZclGVmVlgBzCGP/aiIU0q2se3iY8ly+ctDBqntr1n
 DRi5AJr31GjtZ6Ol53uyGx5P3vzRlr/4vyXndwMMCFeNz+M4kq7ZywETwD709PqY7LJ49iQZ+
 avD1XLSazN7VQyXSCm+Kdrtpa7eQ9B8QGUhgRGoqeI/GXAWfz9T4qbYeXmOi71wHhB3YGWvoy
 PYX9xY5k76hYuzRMNsi/FN+aUOTanBXZZFTZAH8U3o8ICOpBUHbYulzNwDV5AKFv7fuIJwVgm
 YhldNYeDZ0escm/NAzEeF/XB0mfX8OgQg/u34QqSI35SYMlKkQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

> Mike Brady <mikebrady@eircom.net> hat am 11. November 2018 um 19:21 geschrieben:
> 
> 
> When the BCM2835 audio output is used, userspace sees a jitter up to 10ms
> in the audio position, aka "delay" -- the number of frames that must
> be output before a new frame would be played.
> Make this a bit nicer for userspace by interpolating the position
> using the CPU clock.
> The overhead is small -- an extra ktime_get() every time a GPU message
> is sent -- and another call and a few calculations whenever the delay
> is sought from userland.
> At 48,000 frames per second, i.e. approximately 20 microseconds per
> frame, it would take a clock inaccuracy of
> 20 microseconds in 10 milliseconds -- 2,000 parts per million --
> to result in an inaccurate estimate, whereas
> crystal- or resonator-based clocks typically have an
> inaccuracy of 10s to 100s of parts per million.
> 
> Signed-off-by: Mike Brady <mikebrady@eircom.net>

the former version of your patch has already been applied to staging-next.

Didn't you received Greg's email?

So please rebase your changes.

Stefan
