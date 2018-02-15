Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755678AbeBOU2F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:28:05 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57037 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755653AbeBOU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:28:03 -0500
Date: Thu, 15 Feb 2018 21:27:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: richardcochran@gmail.com
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: dsa: mv88e6xxx: avoid unintended sign
 extension on a 16 bit shift
Message-ID: <20180215202757.GB3080@lunn.ch>
References: <20180215191218.27936-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215191218.27936-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
> index b251d534b70d..758e35fa69ab 100644
> --- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
> +++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
> @@ -321,7 +321,7 @@ static void mv88e6xxx_get_rxts(struct mv88e6xxx_chip *chip,
>  	 */
>  	for ( ; skb; skb = skb_dequeue(rxq)) {
>  		if (mv88e6xxx_ts_valid(status) && seq_match(skb, seq_id)) {
> -			u64 ns = timehi << 16 | timelo;
> +			u64 ns = (u64)timehi << 16 | timelo;

Hi Richard

Do you prefer this, or making timehi and timelo a u64?

   Andrew
