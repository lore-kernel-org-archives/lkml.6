Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966951AbeBNJ3o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 04:29:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63080 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966446AbeBNJ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 04:29:43 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] ACPI: SPCR: Mark expected switch fall-through in acpi_parse_spcr
Date: Wed, 14 Feb 2018 10:27:53 +0100
Message-ID: <1757557.bTtaD8LxG2@aspire.rjw.lan>
In-Reply-To: <20180209180821.GA20326@embeddedgus>
References: <20180209180821.GA20326@embeddedgus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 9, 2018 7:08:21 PM CET Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1465078
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> This code was compiled with GCC 7.3.0
> 
>  drivers/acpi/spcr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> index 89e97d2..9d52743 100644
> --- a/drivers/acpi/spcr.c
> +++ b/drivers/acpi/spcr.c
> @@ -115,6 +115,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
>  			table->serial_port.access_width))) {
>  		default:
>  			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
> +			/* fall through */
>  		case 8:
>  			iotype = "mmio";
>  			break;
> 

Applied, thanks!
