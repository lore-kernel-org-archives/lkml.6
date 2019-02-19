Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7418BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1392146F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfBSJ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:58:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60484 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfBSJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:58:29 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a25239dae484f5e6; Tue, 19 Feb 2019 10:58:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] ACPI / processor: Set P_LVL{2,3} idle state descriptions
Date:   Tue, 19 Feb 2019 10:57:02 +0100
Message-ID: <3670654.07UQUedC4A@aspire.rjw.lan>
In-Reply-To: <20190218013335.233265-1-Yazen.Ghannam@amd.com>
References: <20190218013335.233265-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 18, 2019 2:33:49 AM CET Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The ACPI idle driver will fallback to using the legacy P_LVL* SystemIO
> method of entering C-states if the _CST method is disabled and P_BLK is
> defined. However, in this case the C2 and C3 states won't have a
> description set, so the user will see "<null>" when reading the
> description from sysfs.
> 
> Give each of these states a description.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index b2131c4ea124..98d4ec5bf450 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -282,6 +282,13 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
>  			  pr->power.states[ACPI_STATE_C2].address,
>  			  pr->power.states[ACPI_STATE_C3].address));
>  
> +	snprintf(pr->power.states[ACPI_STATE_C2].desc,
> +			 ACPI_CX_DESC_LEN, "ACPI P_LVL2 IOPORT 0x%x",
> +			 pr->power.states[ACPI_STATE_C2].address);
> +	snprintf(pr->power.states[ACPI_STATE_C3].desc,
> +			 ACPI_CX_DESC_LEN, "ACPI P_LVL3 IOPORT 0x%x",
> +			 pr->power.states[ACPI_STATE_C3].address);
> +
>  	return 0;
>  }
>  
> 

Applied, thanks!


