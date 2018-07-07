Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AE2C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259E32154E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPczq5/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259E32154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754352AbeGGRDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754290AbeGGRDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:03:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E535821527;
        Sat,  7 Jul 2018 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530983002;
        bh=SeDFwvY7xaRU0jS0jB2Kj5peBNUsWPsID6JVpD6Kp2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lPczq5/sPXQZCaIWrh8548j8I6fbfPklmDkChFCaMJsN5+GsRh/PtLonPBbo+Xhk1
         byyfaa1aj3cp93DdA49Abv7+C1ivpx2FZx3IDLmlAXJKlQbga2UQBDOv3E5FKu2CBV
         oXaWsat9Hqs07XF8xyf/cQ5dlPpP/5+zLEL7o/nY=
Date:   Sat, 7 Jul 2018 18:03:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sca3000: Mark expected switch fall-through
Message-ID: <20180707180317.52cb8b39@archlinux>
In-Reply-To: <20180703193934.GA13572@embeddedor.com>
References: <20180703193934.GA13572@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 14:39:34 -0500
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks like a bug to me not an unmarked fall through.

Should be return ret;

Do you want to do the patch?

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3000.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 4dceb75..209b52a 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_dev *indio_dev,
>  		mutex_lock(&st->lock);
>  		ret = sca3000_write_3db_freq(st, val);
>  		mutex_unlock(&st->lock);
> +		/* fall through */
>  	default:
>  		return -EINVAL;
>  	}

