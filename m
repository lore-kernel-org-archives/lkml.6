Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D492C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7835F21A5E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzhSvA3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7835F21A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeHJXmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:42:17 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41212 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeHJXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:42:17 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so8832058iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXWCveCycGuwgQIDN5OqZRm3roCUZ5JO3Ldkn7Zx1j8=;
        b=WzhSvA3DNPR9W2Kz0tq1RVgmJmh1WrSHvceE3TCHFeOayMOApDfOlpYeCc/4Dx2MoE
         RKERa/23EmRG7rbwf9OwzsPLmqRIytd72zXKPbsIykHFgHU+3yc267hqSoZAu26FBvNB
         Dmn7k96moWDIQ9Y6P/G/9EHNd844hx8gmVLJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXWCveCycGuwgQIDN5OqZRm3roCUZ5JO3Ldkn7Zx1j8=;
        b=oyarrvDu8zbH80MMpDvRpjK8Xuy7BbDdkEw0za033NORkYLyTZ4PJUQ6MUutHaxt5W
         08aRlHH5IgkFkmiqCoKrBi2lNjrGBuTUpGmtdpRiJerM12t5PW2FV0y5uCeuakAVFwdl
         KMYIG91inV1UEh/lzb1TA2fIALMAGRLtgMSrH5fhSL5+v+3cxG2z1AXuMzygBgn1/amV
         cGP/8RzJJtc1lG04s9ipM3nagIkCuVNazr8OhLziJIykQNytgRNmXAFVR/B3fdRNHIv8
         FVmrZ3BugASi9MNMwOS1nGmN8AqZLZ5TBuoBVQ6bWldaeyAj3CIuFgW5m7qQs8c/ghIb
         uy1A==
X-Gm-Message-State: AOUpUlHc5h2UUKTygNJ4M8R90b/j9kkiKvWUpFEeOA8C5zOX8Eznu4C1
        d53mzoNIalbVN6raM+LJ9puark676wDHSHuHvB/W3eio
X-Google-Smtp-Source: AA+uWPxKVC7TB88vYEtmWD8b+nr9jvoKzX5n45My2ucaBs50o2tYzNf8bbbz0PwgEugHLR0Yp8Prur8tisusxGktuMQ=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr6411372ioa.277.1533935444826;
 Fri, 10 Aug 2018 14:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180807093226.5624-1-rf@opensource.cirrus.com>
In-Reply-To: <20180807093226.5624-1-rf@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 23:10:33 +0200
Message-ID: <CACRpkdbNT9cs3gXQbGnKmYutbOD4u_9WLhfL+i7oFFpbWyQEHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: madera: Set is_generic
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 11:32 AM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> We are using the generic pin configuration interface so
> we can set is_generic.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
For these patches.

This is not yet in my tree, but I can apply this and the others
after -rc1 (probably the easiest).

Yours,
Linus Walleij
