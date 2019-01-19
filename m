Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF2C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9BB2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbMppkYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfASSjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:39:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45990 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbfASSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:39:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so8180637pfd.12;
        Sat, 19 Jan 2019 10:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ntPlN8O5ix9MTWk+pNPs1SfGLLi/+g0hRkSJC0iaDn0=;
        b=MbMppkYu+KX1dnuJqZa+gd+01WpRIxiysr0ASr/+envppdboY+DFFRQDfQ3EDpflX3
         DxK6Eiqf97ewldOZxvcukXUYRblS/WKhlYMYn+FLmpFEvfi5kWKVH4O6A7qtUim+12Ou
         mAxGDpGoW/PL+9BIdP1ji0WzdOYlYp5zriH/yFBRpaRIxeoNg9Tt8lzaCLlcGtlTYV4t
         FNMqSOHWEWmX5SSaekeqkDYFxRtFvaKezSUs2YFuuY5Vo2QUE3jlEfxud0UBUvmA+pgl
         Peyc3zKRaoADOqeSgW0JjzTHYElvQdNNHGme4NISuTEtyfkVKMCWqtJajXHdUZ3LLfLt
         tQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ntPlN8O5ix9MTWk+pNPs1SfGLLi/+g0hRkSJC0iaDn0=;
        b=VCrMqELZ4e/eSpBaBTOM/uhoCRBzYfDNdF4ntz+aFRsIJXrAzL5u5cY1054H1gihsG
         RGR3HIMAO31oCpNw8OYmmAdiTWfdwCYy5MFxx4K3WAtNXeA3wiW90duxnsSFZZlw0PIF
         1qKLE9h+6mZaArVafCpf6OLgsPG95p7lZDI06hPs3zyLAnUJejxwfePw5+LFo5kE1WSk
         yK78dih2WJJ7cyYabQJibhLKpdr5eZPAtVTytFVWEksqzHGzWwdqLn4FAE1d0CLEZRgj
         bEW8sEMjoYOn0pQeLdc5XcrNZTtfX7SuIQYyEejbU+0YqNHubkRWDstVgpvuxiXh/GK/
         T9Qw==
X-Gm-Message-State: AJcUukfTJPSDTpEFtWD98a94DhmhGLlWyhP+aQkzExC8lt5wQLLhB44p
        yUxi7AEShs+kdtytAs1WZCQ=
X-Google-Smtp-Source: ALg8bN70hCgKkOKliX4XX7yTLdk4cRt+yRik4tktHNBZgvyk/FriGdmt55+K34aveFVHJkhQIGjzdw==
X-Received: by 2002:a63:6604:: with SMTP id a4mr22379949pgc.118.1547923181862;
        Sat, 19 Jan 2019 10:39:41 -0800 (PST)
Received: from localhost.localdomain ([49.33.214.52])
        by smtp.gmail.com with ESMTPSA id m20sm10127471pgb.56.2019.01.19.10.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 10:39:41 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v2 0/3] adt7316 regmap implementation
Date:   Sun, 20 Jan 2019 00:09:29 +0530
Message-Id: <20190119183932.14321-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consist of some initial patches for heading
towards the regmap implementation and also the final patch
which enables the driver to use regmap API thus removing
the redundant and common code.

Shreeya Patel (3):
  Staging: iio: adt7316: Remove irq from bus structure
  Staging: iio: adt7316: Remove multi read and write functions
  Staging: iio: adt7316: Add regmap support

 drivers/staging/iio/addac/adt7316-i2c.c | 101 ++--------------
 drivers/staging/iio/addac/adt7316-spi.c |  95 +++------------
 drivers/staging/iio/addac/adt7316.c     | 147 ++++++++++++------------
 drivers/staging/iio/addac/adt7316.h     |  15 +--
 4 files changed, 103 insertions(+), 255 deletions(-)

-- 
2.17.1

