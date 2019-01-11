Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E27AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3369218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqCdQJf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbfAKPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:33:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39687 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbfAKPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:33:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so7100241pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dIgoxrKtHZ5BuC4BTF7icHBp5uTqqFOdRNmLX2AjHBc=;
        b=rqCdQJf0xTNxdbeLXWaO1qle9NAphP5wp5LYt8D8RFab5kXeL19cMQ2k3pkQU4+Dfm
         NO3TDT8OXSWPUs08cdlI+5CHMjXHpsmjWHXptqMPrDgfar94+0c6ZLk2plejJ7yE5vtI
         mKNS52bOxnrNkQam+SPZMXpNwkG7Y8f9ymIOX/2YTCJFaJlat7GhpYNygzt3zaUwlC9C
         gwaD9Ze/rxqy+H3y5BhMST25h+gxLLrU5tLnLpvGNUwjW438HEH8puk3x8P5cpU1+iQy
         sH+Eza9q8AvL5j+VVKcf0WM9Ju4RxsdQlc20fd+oFIBINfft9cAp5jvpVrKPOZKohuRf
         WWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dIgoxrKtHZ5BuC4BTF7icHBp5uTqqFOdRNmLX2AjHBc=;
        b=VXXQ75oD+Y7mN+6wV+eILf+gbZB5F8h+sEALquXXqK8LX8CD8bEfYUXFk+LHcLQaYU
         fc+145WlAZlwa8Ea0xWBtc+2PxFO5EVj/WVFgCGH5lpC48znJjL7FA6Jx4wHozJ1EPnz
         GccjF9tu6O4zyUqRwCgCdb729SawnPFZ0HtoEnqay6YMjjuTpxRbt++iGJ/UteqJI3oI
         A/U9WDH9VMYG6SAvZBerMHk8rOVTF7VvZFniUuRrggv2Vu43rLRP92W6sP0Oh4bOaht+
         NjcpI6VN8TxC1SLShtt9Vr11NiBwu0ePTn25EvZGOu2t0mZ3QDgwd8keH3cmZvF4l+C9
         dxWA==
X-Gm-Message-State: AJcUukfAzmSi0jUeUvdRdaI5GmdmAal80sArD51OYXt+8qBtn+pBZAdY
        fq2Y00ZnDqo1zaDy/X06D6s=
X-Google-Smtp-Source: ALg8bN6BdWI7TjyfVdfaKM+5viQbM93hH1qKfiluPjbr83WWRZKb8EL6k88OVdJcZa+gxwVrz/dBgg==
X-Received: by 2002:a62:d448:: with SMTP id u8mr14963906pfl.105.1547220803382;
        Fri, 11 Jan 2019 07:33:23 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id f20sm99778435pfn.177.2019.01.11.07.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 07:33:22 -0800 (PST)
Date:   Fri, 11 Jan 2019 21:03:16 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v6 0/2]  greybus: gpio: Switch to the gpio descriptor
 interface
Message-ID: <cover.1547219996.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series converts uses of the old GPIO API to the GPIO
descriptor API. It also converts the GPIO driver to use the
GPIO irqchip library GPIOLIB_IRQCHIP instead of repimplementing
the same.

Changes in v6:
 - Patchset now contains two patches as the patch
   1 has been accepted.
 - Changes mentioned in individual patches of the set.
Changes in v5:
 - Drop the patch which uses gpiochip_get_data() in place of
   gpio_chip_to_gb_gpio_controller() as of now.
 - This is because it currently breaks the driver, since
   gpiochip_add() sets the data pointer to NULL.  
Changes in v4:
 - Changes mentioned in individual patches of the set.
Changes in v3:
 - Combines the latest versions of the three greybus patches together
   in a patch series.

Nishad Kamdar (2):
  staging: greybus: arche-apb-ctrl.c: Switch to the gpio descriptor
    interface
  staging: greybus: arche-platform: Switch to the gpio descriptor
    interface

 drivers/staging/greybus/arche-apb-ctrl.c | 152 +++++++++--------------
 drivers/staging/greybus/arche-platform.c | 124 ++++++------------
 2 files changed, 102 insertions(+), 174 deletions(-)

-- 
2.17.1

