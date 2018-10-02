Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE46C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF57E2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:57:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF57E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeJCAlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:41:40 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:51056 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeJCAlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:41:40 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2018 20:41:39 EDT
Received: from darkstar.musicnaut.iki.fi (85-76-97-131-nat.elisa-mobile.fi [85.76.97.131])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id AB603300EC;
        Tue,  2 Oct 2018 20:47:45 +0300 (EEST)
Date:   Tue, 2 Oct 2018 20:47:45 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix impossible .irq < 0
Message-ID: <20181002174745.GG3461@darkstar.musicnaut.iki.fi>
References: <20181001102453.GA18947@mwanda>
 <20181002094529.30564-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002094529.30564-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 02, 2018 at 11:45:29AM +0200, Janusz Krzysztofik wrote:
> Since the very beginning, unsigned int .irq member of struct
> plat_serial8250_port introduced by commit eff443df679e ("OMAP1:
> AMS_DELTA: add modem support") was statically initialized to a negative
> value -EINVAL.  Moreover, commit 0812db943748 ("ARM: OMAP1: ams-delta:
> assign MODEM IRQ from GPIO descriptor") has introduced some new code
> which checks for that member carrying a negative value which is
> impossible.
> 
> Use IRQ_NOTCONNECTED instead of -EINVAL. Also, drop the valueless check
> and let the modem device be registered regardless of .irq value, and
> the value handled by "serial8250" driver.
> 
> Fixes: 0812db943748 ("ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
