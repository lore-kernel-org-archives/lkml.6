Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966E2C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC020870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548066632;
	bh=tFA4GsYN4y88wPSWG9l+/tqPNXX2OXLhiorveQTLJZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ix9gLO2XyFJIJB5h6aEWekO4dLeCzuVTuAxAmjvwhWpKi4H/EPxLuu0JZNkX6IM3f
	 aU1nmVWisBLEjDmgyGqLEcaX1dw43D/jM3DEt9qQNejKr7B55zIlWitSoJC/npGlu5
	 yugTh9OSTmsz4DjWvAN5mYi1xn+Xe2RGTskjafaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfAUKaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfAUKaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:30:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F40E92084A;
        Mon, 21 Jan 2019 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548066629;
        bh=tFA4GsYN4y88wPSWG9l+/tqPNXX2OXLhiorveQTLJZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1iTp0+jtiIKtn9ftohRdtUsg/948t7aCHpHuYozzrfjfT42qcx/o4hXVAaLiEDhQq
         scQiRN2yIk6CDIDXSw+aGhOgYFgHkQhQnxhzr2BWlBLRDypLEq0P8cd0P2njEaYD1N
         sXBkLhRoMEUwxKX3YFM9kiKYFeHlUXEuoF/Qc2nw=
Date:   Mon, 21 Jan 2019 11:30:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, herbert@gondor.apana.org.au,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpm@selenic.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, daniel.thompson@linaro.org,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        tee-dev@lists.linaro.org
Subject: Re: [PATCH v4 4/4] hwrng: add OP-TEE based rng driver
Message-ID: <20190121103026.GB15590@kroah.com>
References: <1548062959-31860-1-git-send-email-sumit.garg@linaro.org>
 <1548062959-31860-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548062959-31860-5-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:59:19PM +0530, Sumit Garg wrote:
> --- /dev/null
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0

Nice, but:

<snip>

> +MODULE_LICENSE("GPL");

This string means "GPL2+", you need "GPLv2" here instead.

Yeah, it's a pain, and everyone gets it wrong, we need to add a
checkpatch.pl rule for this to keep it from being added in new code.

thanks,

greg k-h
