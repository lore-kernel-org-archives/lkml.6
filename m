Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0BDC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86FC20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 13:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhnEL7eS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86FC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJZWAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:00:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35689 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:00:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so539341pgu.2;
        Fri, 26 Oct 2018 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sxP9Vub0IBi+QpvfesWRSk3+e6ECIPzTKLe7oLEuyR0=;
        b=JhnEL7eSZDtdqXMcVZFQAJRECbcWkAS79DQkaqScqxIRxaSJ2x3Ave6Y0VxjzULlTY
         qtLn8SDfKQfIScEw+h/LY+j9rh/QiW3lkq/seT2swbjjdYiuUaoxZAgPhzurI4O9Mfxy
         4+vgXYGGCi1AE5TTWBE+5pcVeLP/MyChA5Xh63CM1Cw3YDJlj9JJi6wuH01QPq7k20pP
         Tc9AOZZi+QdD7OlhRR3Ne6JFy43sQD64+JqtfuHP4s8tdF7VhGGM3qZi5EdDyh1tmsVa
         roLcashWXSFfiFuoWbYwHZ02kdKjQuYrbZrtitKll6hsFc8p4Zg5M7VZZm0xaxkwoKCt
         9izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sxP9Vub0IBi+QpvfesWRSk3+e6ECIPzTKLe7oLEuyR0=;
        b=qIXEYgiPSlSbz9Sv95v2hEX8BloOf4ntYky3+/KOlRz6tH8lJN0fI7YxEIsHVh+bKD
         t4JABAH2ppnFqX/OBcUEBdimoV+xpxxzqA1OXOPMNYMrDPtnZC8ovYuegaxLrqB8UGyw
         UeXfEzq8w7blQ95APfEfa/4Cl1mSAeCMo/mwCfV7SXbhZmu5HW+2nsIrHQaxnpifQWmj
         8KGD6OWTFQ2VWwn3x3h+P2ZpdpwcjMa7nzrJR0P8GLfnceN19KkyxN48NRkAK9K6MjoI
         wvHXK1xbL1BMLMVt/iYfoEz2ZeFvs6NhNtaa5XOIT3S6bnpqfUkENpZEKu27u4liCnfg
         vExg==
X-Gm-Message-State: AGRZ1gKftryPrNupgBITcJPwT5jgKx8jrzUAOGbDJ7OjwjRdSnmP2vzf
        5y6Gf67t3SD8huak1AU74Dw=
X-Google-Smtp-Source: AJdET5dhSLfnz+nAV8vTVHN4w2KY8mNkMdQ5uWPvnEOCjXN/weDdfh+aNeRvIm3rJoXUidphZc5UJA==
X-Received: by 2002:a63:9e02:: with SMTP id s2-v6mr3551570pgd.302.1540560199034;
        Fri, 26 Oct 2018 06:23:19 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id y10-v6sm21535845pgi.85.2018.10.26.06.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 06:23:18 -0700 (PDT)
Date:   Fri, 26 Oct 2018 18:53:12 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Slawomir Stepien <sst@poczta.fm>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface.
Message-ID: <cover.1540489369.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the gpiod interface instead of the deprecated old non-descriptor

Changes in v5:
 - Add device tree support.
 - Add device tree table for matching vendor ID.
 - Add Support for retrieving platform data from device tree.
Changes in v4:
 - Add spaces after { and before } in gpios[]
   initialization.
 - Check the correct pointer for error.
 - Align the dev_err msg to existing format in the code.
Changes in v3:
 - Use a pointer to pointer for gpio_desc in
   struct ad2s1210_gpio as it will be used to
   modify a pointer.
 - Use dot notation to initialize the structure.
 - Use a pointer variable to avoid writing gpios[i].
Changes in v2:
 - Use the spi_device struct embedded in st instead
   of passing it as an argument to ad2s1210_setup_gpios().
 - Use an array of structs to reduce redundant code in
   in ad2s1210_setup_gpios().
 - Remove ad2s1210_free_gpios() as devm API is being used.
-
Nishad Kamdar (2):
  staging: iio: ad2s1210: Switch to the gpio descriptor interface
  staging: iio: ad2s1210: Add device tree support.

 drivers/staging/iio/resolver/ad2s1210.c | 129 ++++++++++++++++--------
 drivers/staging/iio/resolver/ad2s1210.h |   3 -
 2 files changed, 89 insertions(+), 43 deletions(-)

-- 
2.17.1

