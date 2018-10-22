Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E50FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB0720652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b37QEqa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB0720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeJVU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:58:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45993 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeJVU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:58:55 -0400
Received: by mail-ot1-f65.google.com with SMTP id z15so208611otm.12;
        Mon, 22 Oct 2018 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ps/vyESeVng7sBbNnNQmXQK2QPK+JvYsIErwoICusyo=;
        b=b37QEqa6TkEVzP/zS5OHb6bmHYIgpabR+Ma+XiA4q4e8G+MOYUETdJJ7pyerNveWQq
         Mf/wlsnwEmUXPTFE6Ws0QJqdpBifdDZ0ZalRrVslJ9XC+GUVKNN9rAgiOjeizsHjwUDO
         pskTNSYxc0YP5JOp0GC2kS6nYnAPysBf3+S0W6bXkMFYsGu7EurqumBJV2dHIC62erkX
         QWnUby6cx1VkSZD7yXxexRffTcdI+rh5TZsAEStJB6juAZA1HzD63TiOBuNF+VfF2DWI
         jWCwxrwBKberZK1+Zg2x8hSOvg7AZz2Jlfxa2248Jvd/8l4S5Zh4Uu1eUbi/rHoZkLOW
         uKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ps/vyESeVng7sBbNnNQmXQK2QPK+JvYsIErwoICusyo=;
        b=H92EkNaEsbukZBs9A/xHDYGiLqjkug6aGuIl+fJfQeMKztyRf8PAQ02eNboqZXzyn9
         55OB6ncBZ1eASbvWY3YJGKxbC3xurO5e/01tpLM/7uOUlb/iwKsd3z+HXSu8ZQo6P7Oe
         LjyZcLTBjrg11yc6adPU++pp7WvZWGY211e/wheGU2vfXKJ/xwQ6E9W/OWx+Uk+ZHhjC
         YZwsEqVPpdUFX3Z+SPqpQx9CGD2fg6D9aTq37XAOZ8guYzszD3yl9NipChHFgpo+p+aV
         gTI9+ua2qE0r8kjksOm2pkUJh0rQPzd7KOCf9Ll6sx9ysUXskhmkb/zSQuZuahFotiZU
         dWuw==
X-Gm-Message-State: ABuFfogxKquogu4yv+1ffc+XPzo+dG2oqTPpgY7GfcJJYEiI7/chrqfO
        mA6657xzh+Lx+0304cAjQ/vNU9N0VNNQP1XYJTg=
X-Google-Smtp-Source: ACcGV61yhhwTcPmcNU0173/RoTX1PoUhMN0esqOuxXB2QM5dYhzHw9sTwLVKJGJT06ZzbzHTirrDh6AuXAWwTUO2UDk=
X-Received: by 2002:a9d:f9b:: with SMTP id d27mr31725190otd.225.1540212029377;
 Mon, 22 Oct 2018 05:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180920145658.GE16851@w540> <CAHCN7x+U=Y=-v1UP5UYvY8WtUFRJGjmx=nawTuE=YcHdm_DYvA@mail.gmail.com>
 <c1cb34b0-b715-cf08-6f75-2842f1090c5d@mentor.com> <20181017080103.GD11703@w540>
 <CAHCN7xLx6uAmYiGh3p=piZFwE0VkfixTLqdjETibKwk2+DhMzA@mail.gmail.com>
 <CAHCN7xJKuPYg04WfRzbYWO4bGoHHnD16LBPRsK1QsiYY1bL7nA@mail.gmail.com>
 <20181022113306.GB2867@w540> <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 22 Oct 2018 09:40:26 -0300
Message-ID: <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Adam Ford <aford173@gmail.com>
Cc:     jacopo mondi <jacopo@jmondi.org>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Mon, Oct 22, 2018 at 9:37 AM Adam Ford <aford173@gmail.com> wrote:

> Thank you!  This tutorial web site is exactly what I need.  The
> documentation page in Linux touched on the media-ctl links, but it
> didn't explain the syntax or the mapping.  This graphical
> interpretation really helps it make more sense.

Is capturing working well on your i.MX6 board now?
