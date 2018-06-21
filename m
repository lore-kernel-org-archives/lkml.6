Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AE5C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF9620837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF9620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933180AbeFUKeI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:34:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43758 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeFUKeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:34:05 -0400
Received: by mail-lf0-f65.google.com with SMTP id x13-v6so3980022lff.10;
        Thu, 21 Jun 2018 03:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2pKfnzW6JyKamYNYcCL3J0AFAYbziQZ/A5vmPFDVbaI=;
        b=sJsz5HtjiA16dS+dk+PlJk3mDhhiBMAoYJqI8FaUenFWTIJ/FYGC63rkfkNiyob1ps
         c8KGzCx5gd6bPjjUJ5yNyoqe7e5p0U2WDIP6ymOdTJ6C44Y8s1uMrOr9/wnbyNOVTuS/
         TV1L3tk1JsLBD8WTIiITkPJhUCE6/rzkm+/UqaMHYr8Jcvc3PuDwSqG34g5V9HV6/PRk
         PGgp0PbvDPijtv6/HopZ4P56gAWc41Nc+ilRCvIXKEVLdFOuoshAeH7PsDNMIYt+OSqG
         U/HEbMAJTWWxR9rJkNxG1806W3FXONwkX7fHSmabA7pBGwt+zFS1WSUHNsf9RxC17Sk9
         ew3A==
X-Gm-Message-State: APt69E0gKytAtL/1FLAtQRxoaz3HM4SILcQaLpxcpVEWb/QOMe08JTgO
        X02XIrr+PHHcOcq+vuSV5t8=
X-Google-Smtp-Source: ADUXVKKsEKBIrZdrqXqmLsatqlkhvtL2mLsAZk0xnn8ZlWV4WcbgeTiuSVxSLvkSKO3QmFuVwgOZqA==
X-Received: by 2002:a19:d405:: with SMTP id l5-v6mr13621063lfg.28.1529577243652;
        Thu, 21 Jun 2018 03:34:03 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id w1-v6sm873852lfk.59.2018.06.21.03.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 03:34:03 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:34:00 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, heiko@sntech.de,
        gregkh@linuxfoundation.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 0/4] mfd/regulator/clk/input: bd71837: ROHM BD71837
 PMIC driver
Message-ID: <20180621103400.GB6076@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 01:55:31PM +0300, Matti Vaittinen wrote:
> Patch series adding support for ROHM BD71837 PMIC.
> 
What is the preferred way when I send updated patches:

1. always resend _all_ unapplied patches even if there is no changes to
   some of them. (patch-vN mail thread contains _all_ unapplied patches)
2. only resend changed patches (patch-vN mail thread contains only
   patches that were changed from patch-vN-1)

I have currently used approach 1 - so that no patches would be
accidentally forgotten - but downside is that people need to check if
they have already reviewed some of the patches. I'd rather not caused
any extra work. What is the most convenient way for you guys?

Br,
    Matti Vaittinen
