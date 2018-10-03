Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3EDC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E122089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/Em79Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E122089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJCUmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:42:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46327 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJCUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:42:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so5156493ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+goval1GFa+ta5e/NLQBZnBg+kRZJXT3Unlgtxg2OGU=;
        b=s/Em79PefXEvLhGU6UbUzb4JhjO0jPFJn9rMaFA6fPhG2eXVqVNx5PePj5WVPDhCrK
         7x7AzHmbIg8FbKxVFwwHIl0CqQUylphzaBQ79z9nO7utPykMG8dhwkQva5xr++RbDcuc
         ZQBYHBcxjCgA9JBOW7yy4P3PSY0hfuvCeRkbWKOYjbVDJUMtzO8UpJrF6V66oNuYlxuc
         Rt6dQY8E82+IXhcVowwRiNqP8MqdiWu4i/UbfRsaon7De0zTYN2ElOyaZNe95OeuydAg
         IxQ/XkKhJa/zXnBYiULeEyT6kOFOJQTKG8j1jh8WxwnqsVvZDDMn4Cr0R/wD6GNEzfPZ
         jPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+goval1GFa+ta5e/NLQBZnBg+kRZJXT3Unlgtxg2OGU=;
        b=SGYJOeqIKVOtUMB2Viw4fINuBYPflTDaDzccRCaN9NfBtkn3wb6rO1aGffngHBolKo
         UYUWon1Q36/hRbxwiwLTeERijtW3HszRrGiA0JQJrbSPvk/Eajvw8WzIkUgSKKOQclXg
         +ESxbqF2HT3Ug5gkhFvGB6pY76PAIda5zUxdQmT49h7cQovX1IyB3/PbO5ABiKbxnYdU
         tCl6Q1t8nqYufMovv7d0MZ1a8WEUYxCvndUPayDToAAKjqwR2S41gqw7GEth5/E1+VIF
         rnzVBk9vb7D+r5boPH42fruhtXlNSP9uPnK3BTI787CeUPz11TMDb1MKBRgsln9jzzmI
         eDlw==
X-Gm-Message-State: ABuFfojfygWzWRnpkVcWLgMoYySgGtu5dSoXKIhPk/sdmUGdkWsBcqQ5
        CUS17GdNehoeM3giS6NrXnA=
X-Google-Smtp-Source: ACcGV62QkrQJVqOIQPu1Jgy8zJ1quHovu3UZ9tDpUDOBD0+oE9e1LqkZLxZt6zKN5pWEsD41xAzjYg==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr1216124ljh.103.1538574832879;
        Wed, 03 Oct 2018 06:53:52 -0700 (PDT)
Received: from z50.localnet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id e6-v6sm334285lfc.49.2018.10.03.06.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 06:53:51 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Date:   Wed, 03 Oct 2018 15:55:25 +0200
Message-ID: <4278198.vlhjLe5TOR@z50>
In-Reply-To: <20181003143054.597b3a9e@bbrezillon>
References: <20180719081508.5dafebde@bbrezillon> <20181003120028.9257-1-jmkrzyszt@gmail.com> <20181003143054.597b3a9e@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 3, 2018 2:30:54 PM CEST Boris Brezillon wrote:
> Hi Janusz,
> 
> On Wed,  3 Oct 2018 14:00:28 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Replace legacy callbacks with ->select_chip() and ->exec_op().
> 
> Thanks for working on that, that's really appreciated.
> 
> > 
> > Implementation of NAND_OP_WAITRDY_INSTR has been based on legacy
> > nand_wait_ready(),
> 
> I don't remember what the ams-delta ->dev_ready()/->waitfunc() hooks
> are doing, but is shouldn't be too hard to replace them by an
> ams_delta_wait_ready() func.

Default nand_wait() is used as ->waitfunc(), and ->dev_ready() returns R/B 
GPIO pin status.

> > otherwise that function would probabaly have to be
> 
> 				^ probably

Do you think other drivers which now provide ->dev_ready() won't require 
reimplementation of nand_wait_ready()?

> > reimplemented inside the driver.  Hence, legacy callback ->dev_ready()
> > is still used.
> > 
> > Use of IO_ADDR_R and IO_ADDR_W legacy structure members will be dropped
> > later, as soon as the driver is converted to use GPIO API for data I/O.
> 
> In the meantime, can you move the iomem pointer to the ams_delta
> private struct so that this driver no longer uses the ->IO_ADDR_R/W
> fields?

OK

> > 
> > Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> > Hi,
> > 
> > I've not tested the change on hardware yet as I'm not sure if:
> > - handling of NCE limited to that inside ->select_chip() is
> >   sufficient,
> 
> I think it is.
> 
> > - releasing ALE / CLE immediately after ams_delta_write_buf() is
> >   correct.
> 
> Well, you should probably consider waiting for instr->ctx.delay_ns
> nanoseconds after each instruction, but, if it was working before the
> conversion to ->exec_op(), it should work just fine now.

OK, I'll give it a try.

Thanks,
Janusz



