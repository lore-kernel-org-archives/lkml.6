Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBHJvd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:51:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62050 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeBHJvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:51:31 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] ACPI / CPPC: Use 64-bit arithmetic instead of 32-bit
Date: Thu, 08 Feb 2018 10:49:47 +0100
Message-ID: <2503109.MpnWDuSnnD@aspire.rjw.lan>
In-Reply-To: <20180206233617.GA30829@embeddedgus>
References: <20180206233617.GA30829@embeddedgus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 7, 2018 12:36:17 AM CET Gustavo A. R. Silva wrote:
> Add suffix ULL to constant 500 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> u64 (64 bits, unsigned).
> 
> The expression NUM_RETRIES * cppc_ss->latency at line 578, which at
> preprocessing time translates to 500 * cppc_ss->latency is currently
> being evaluated using 32-bit arithmetic.
> 
> Addresses-Coverity-ID: 1382602
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Notice that another option is to cast NUM_RETRIES to u64 at line 578,
> but as there is only one instace in which this macro is being used I
> think adding the ULL is just enough.
> 
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 06ea474..0afbb26 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -119,7 +119,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   * to PCC commands. Keeping it high enough to cover emulators where
>   * the processors run painfully slow.
>   */
> -#define NUM_RETRIES 500
> +#define NUM_RETRIES 500ULL
>  
>  struct cppc_attr {
>  	struct attribute attr;
> 

Applied, thanks!
