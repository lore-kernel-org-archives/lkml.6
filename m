Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA3C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49AC218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548949208;
	bh=5bmqbO0/nVI5m0s4mwUYnmLo7aQ1g72ZJhipFCOH2fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0NtCu7IlcKmGrhPISJj6uPSU/9N/tbk+OPjGF/5gNFMSKhaLcOz7UgWZF52ifEni+
	 kK4Eu5v6On9q2yEkaaUZa+/IXzMzIjyXMivrYBXqSqw8jCPhJ1/HBXNFwdFAlWvye/
	 kazGRe5fb8pIGQsPhm/NvSU3/Qz6wxjG6AYMSecE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbfAaPkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:40:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41474 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbfAaPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:40:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so3053813ljc.8;
        Thu, 31 Jan 2019 07:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEbsfq3Dl6n0U1jU7HiNj0/b8bjtRUy0PQ+fgxvrvJg=;
        b=gbRZqBxp2daVDWk3KW2tV3mzgAuHomLa3KAyO60gpkS+wDzLv7IxEdt+prP0oOpAnU
         i+TogHzfDawOQ2HnVBl/IyzY/2xL8rUbR2TFRayZJOlbs+bpliDqSmvRIWSfXKJXlbPC
         nHvCReYxMbtNq90iBV35o3DrkSuOeCKpOfLf7e8KZFThZQB1qVQakTXSdXWXZTCDVUMO
         ROOy6MS/FgfgUSP9UXC1Tl4zkvOttMA4vU4Iy+LfnWNyHMtSmad9V6EwM//49MbYYLZK
         esdMwBPMnc7j5eEIqSwzqZ5yIPwcAT4qpKjVOAKUPJ+gr5kwMV2E5xr52bI+f90Du5Sx
         Nwsg==
X-Gm-Message-State: AJcUukfxcnkVqLKUEwSVbis9dov9sQQOQAWxioK+RR7cn+wgpmFoDYpT
        9uPQxdZhNjjNzGqKaOH4gBY=
X-Google-Smtp-Source: ALg8bN5lHiXt3UsKOO1GNuwnL9vDkLCyqQEJbIgpxWVaNU6OjL4yj838vQDNbRwrd4XAMoETzwE7Rg==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr28574237ljb.52.1548949204055;
        Thu, 31 Jan 2019 07:40:04 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t19-v6sm838425lje.23.2019.01.31.07.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:40:03 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gpERc-0007SY-MF; Thu, 31 Jan 2019 16:40:00 +0100
Date:   Thu, 31 Jan 2019 16:40:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190131154000.GU3691@localhost>
References: <20190130053925.GA26699@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130053925.GA26699@myunghoj-Precision-5530>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 09:39:28PM -0800, Myungho Jung wrote:
> tiocmget() and tiocmset() operations are optional and some tty drivers
> like pty miss the operations. We need NULL check to prevent from
> dereference.
> 
> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> ---
>  drivers/bluetooth/hci_ath.c   | 6 ++++++
>  drivers/bluetooth/hci_ldisc.c | 4 ++++
>  2 files changed, 10 insertions(+)

Ah, you had already submitted a v2.

I still suggest splitting this one in two patches and that you add a
Fixes and stable tag to each so that they both get backported to stable.

Also, when resubmitting, make sure to include a short changelog here
below the cut-off line (---).

> 
> diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
> index d568fbd94d6c..fb9f6323a911 100644
> --- a/drivers/bluetooth/hci_ath.c
> +++ b/drivers/bluetooth/hci_ath.c
> @@ -185,8 +185,14 @@ static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>  
>  static int ath_setup(struct hci_uart *hu)
>  {
> +	struct tty_struct *tty = hu->tty;
> +
>  	BT_DBG("hu %p", hu);
>  
> +	/* tty driver should support operations to set RTS */
> +	if (!tty->driver->ops->tiocmget || !tty->driver->ops->tiocmset)
> +		return -EOPNOTSUPP;

-ENODEV might be more appropriate.

Johan
