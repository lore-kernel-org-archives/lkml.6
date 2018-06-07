Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RgFtK7TXGFuZRQAAmS7hNA
	; Thu, 07 Jun 2018 07:01:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 42627607F7; Thu,  7 Jun 2018 07:01:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HketVEMU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 83A2D6063F;
	Thu,  7 Jun 2018 07:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83A2D6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeFGHBu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:01:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43754 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbeFGHBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:01:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id d2-v6so8772187wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W2asmIcVuhk04xlo6ROyQ06702MDiBdzgfWurSsLxTk=;
        b=HketVEMUFFIQYBOUpUspoLGSbBRfAVR3PoEznfGn4cRKKFtQEELrJQeVF2eA7Zeqby
         +ij7VRqu753H6sZyLiY2CRwNl10CaJCbr9oDumI7kWoGIJIY0+sC8FSVUddj829BBH9v
         LIpTnm+QM4hwdiiFPV2GzQ7RiBS/j50UcIm4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W2asmIcVuhk04xlo6ROyQ06702MDiBdzgfWurSsLxTk=;
        b=HhEgYzlQewYKdpArN4E7XYuoo4YSOV9h77XYI8iNQksfZ1DgIhuGUR6TddrC3fo55n
         YvFXAviJ0zoFi47L4SErxCynEySEP/dtA5gGIOiU2sNlqW7wKo7+QD0pG3gSU4OPnERd
         mjIeOwammKj/wumL38zJh4IlKFXpB7e5lmKKwXO0bsTrdjCg8zw054CmpvapToTR4Uwn
         Ue1TpTXUFqIOQZlwTmUhGqry5/Gx+T/9PvVqs1Il7ustP0haBdnm6ytY1uQuLBJ2Bp61
         OjY7c8rGmYwjoJ7608PqulxFRyRVeincVXgCtH/EUyRtz/auepYiWTghwwVEQizjCZ73
         oG4A==
X-Gm-Message-State: APt69E2L4zE39eSMUkwIEGxB5wFEFfkTWzBaHJFg5VDrl3rmtzSDJ+3v
        N7K+dIzdU/JLhRbDXgrWfAae9Eo1elE=
X-Google-Smtp-Source: ADUXVKIhee2bWXv2n2Q28+SExSbzGAlP4Ro3KdJjbKN8Du0eEpbm2SmMthldSCP/rbcqcuCL8a2FAA==
X-Received: by 2002:adf:e687:: with SMTP id r7-v6mr561703wrm.14.1528354907772;
        Thu, 07 Jun 2018 00:01:47 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id s132-v6sm936767wmf.5.2018.06.07.00.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 00:01:46 -0700 (PDT)
Date: Thu, 7 Jun 2018 08:01:44 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 04/14] mfd: da9063: Use REGMAP_IRQ_REG
Message-ID: <20180607070144.GE21163@dell>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
 <20180606100003.17067-4-marek.vasut+renesas@gmail.com>
 <CAMuHMdXdoAaBbx+_G3+n=e+zki3z20t7ATXttDUnmYRu95HMVA@mail.gmail.com>
 <3317638e-8688-35ef-ab61-7281312f2c3f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3317638e-8688-35ef-ab61-7281312f2c3f@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Marek Vasut wrote:

> On 06/06/2018 01:31 PM, Geert Uytterhoeven wrote:
> > Hi Marek,
> > 
> > On Wed, Jun 6, 2018 at 11:59 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> >> Convert the regmap_irq table to use REGMAP_IRQ_REG().
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > 
> > Again:
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Added.
> 
> And the obvious question is, what do you all use to collect these tags?
> Doing it manually sucks.

Manually for me.  Copy paste.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
