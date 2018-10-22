Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D03C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C7720651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miKOEuam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C7720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeJWG3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:29:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43527 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeJWG3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:29:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id k9so41669463otl.10;
        Mon, 22 Oct 2018 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c1Oa+IRkYwPderRIVvtEEtzyAXNblGH/njUv240d/b4=;
        b=miKOEuamywGQAq1g2vpAFLhmi85mvXUBS5j77o26r+mP2nrz/Yj0/P8h9GVJKpmMY3
         JCbhDFgGndzDSvXUIeQP+SJCh1Cw36c2j4vDdoHHDkytoXUfYwi6PmEjeCjUdOIV3CwL
         vOixaLg9rfg1Eui+3DcqOnURs4m8lnL5xxokPFAhMbl/Ex3CJLUn/GGfIUw2LUrqJHj4
         B55+yLVfMvmjAo1anWnm5iXOuUctg4o2Hn/6olBZ0g7TA6xGMhLM0TdMBz5U1SXCBqAA
         P814KWXr/iTJtHirjavoGQi1SuYksRZO+z52fy/uWSK4CdgwG9rf79WEeAgjus7JP2Qy
         DHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c1Oa+IRkYwPderRIVvtEEtzyAXNblGH/njUv240d/b4=;
        b=OWwC3BoPGUS2Wx8mixjtOqJWt4l12TdrupSt1zfct82HSiYjcGEqW9yuf7MZ9MLlLO
         H08cfjnnfqmICHP/zu2rUwMhcnIEnWohs1YwU5jeQp9lNnkaCuSqoIg5PPa3oCanC0rc
         Zrr8Ujn3G3IIbHGKUmdrX4j9aeJyXBVN6gXrkjetHoHKEgfefa5VbOuircTGbPCpUhy9
         4mCAQTC7poAjSQXcNjVccstJYxPkz5l3e9gl0EjBSLc/KPkM0DvQWQNNff+EAnrErlgs
         hvbm0JlXxirw2F9o451JZiKMNge9mmlth5+oZ0ttv6RvrSJtq64KmeAD8O5GpkZred7L
         1Qvw==
X-Gm-Message-State: ABuFfogWghuNBbYVZcE3RujrJVvf1zWeF7UWxK1HplIjOax6CCE911FV
        ZpIJbd2Q+YsutrWdIqwBDCK4ZU+k5E4hx6pfQ0qD5A==
X-Google-Smtp-Source: ACcGV63UPCP9iDZXbdLz7KI8gCL83M5kkpj6Qxo8GiWXKQu4nJ9lYDCvHiS42gFSLFuLP13LRePQAfy92bV6gK0eX54=
X-Received: by 2002:a9d:ec:: with SMTP id 41mr28871320otk.322.1540246122976;
 Mon, 22 Oct 2018 15:08:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2eab:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 15:08:42
 -0700 (PDT)
In-Reply-To: <20181022203218.7007-1-zwisler@google.com>
References: <20181022203218.7007-1-zwisler@google.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Tue, 23 Oct 2018 00:08:42 +0200
Message-ID: <CAKR_QVJY3Wx4EfnvTM18Mcj_=WxKEZ=vQfM+SdmeiDn7Hm8qgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: Add notifier call chain for hot/critical events
To:     Ross Zwisler <zwisler@google.com>
Cc:     linux-kernel@vger.kernel.org, Duncan Laurie <dlaurie@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2018, Ross Zwisler <zwisler@google.com> wrote:
> From: Duncan Laurie <dlaurie@chromium.org>
>
> This will allow drivers to register a callback for important
> thermal events and log critical thresholds that cause the system
> to shut down.

when you have proper implementation of thermal support the cores
should throttle to 80, 60 and 40% once reached passive trip point so
they never even reach critical point that causes shutdown
