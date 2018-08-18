Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DBEC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25280219CA
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 00:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1DSIKqhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25280219CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeHRD5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 23:57:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:37410 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeHRD5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 23:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=sGWXkA3SuscJ6LSTiq1aAQQE460Etq8vavr/+DKUCZQ=;
        b=1DSIKqhc0ILD991r6CuAYs5wh0yiQgU4wKNgvlONh6gp1YCFs5LdtfWtS8uoX10w289MVHgLbwLJZkQrfPSzGa/1muB4/C/cR2YYoWA3JF5IxYoTFGk9xTb8NL8YvWBfvoIHH6vkt+XNVnvoXI1N22Q4aKAh0RRDSCyK2b1Vldg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fqpTP-0007zA-QF; Sat, 18 Aug 2018 02:52:11 +0200
Date:   Sat, 18 Aug 2018 02:52:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     justinpopo6@gmail.com
Cc:     linux-gpio@vger.kernel.org, f.fainelli@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, gregory.0xf0@gmail.com,
        computersforpeace@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] gpio: brcmstb: allow 0 width GPIO banks
Message-ID: <20180818005211.GC26866@lunn.ch>
References: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 04:47:39PM -0700, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Sometimes we have empty banks within the GPIO block. This commit allows
> proper handling of 0 width GPIO banks.

Hi Justin

This is coming from DT? Why do you put 0 width banks in DT in the
first place?

      Andrew
