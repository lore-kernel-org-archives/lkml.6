Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeBHKCF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:02:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43167 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:02:03 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org
Subject: Re: [PATCH] ACPI / processor_idle: Set default C1 state description
Date: Thu, 08 Feb 2018 11:00:20 +0100
Message-ID: <37057100.4tRoXpypnc@aspire.rjw.lan>
In-Reply-To: <20180129202249.12522-1-Yazen.Ghannam@amd.com>
References: <20180129202249.12522-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 29, 2018 9:22:49 PM CET Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The acpi_idle driver will default to ACPI_CSTATE_HALT for C1 if a _CST
> object for C1 is not defined. However, the description will not be set,
> so users will see "<null>" when reading the description from sysfs.
> 
> Set the C1 state description when defaulting to ACPI_CSTATE_HALT.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/acpi/processor_idle.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 5f0071c7e2e1..abb559cd28d7 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -292,6 +292,9 @@ static int acpi_processor_get_power_info_default(struct acpi_processor *pr)
>  		pr->power.states[ACPI_STATE_C1].type = ACPI_STATE_C1;
>  		pr->power.states[ACPI_STATE_C1].valid = 1;
>  		pr->power.states[ACPI_STATE_C1].entry_method = ACPI_CSTATE_HALT;
> +
> +		snprintf(pr->power.states[ACPI_STATE_C1].desc,
> +			 ACPI_CX_DESC_LEN, "ACPI HLT");
>  	}
>  	/* the C0 state only exists as a filler in our array */
>  	pr->power.states[ACPI_STATE_C0].valid = 1;
> 

Applied, thanks!
