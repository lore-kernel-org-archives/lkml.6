Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7317D20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7317D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeLCPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:08:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:1210 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbeLCPIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:08:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 07:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,310,1539673200"; 
   d="scan'208";a="115635266"
Received: from jinbaowa-mobl1.ccr.corp.intel.com ([10.249.170.100])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 07:08:33 -0800
Message-ID: <1543849707.2841.9.camel@intel.com>
Subject: Re: [PATCH 1/2] thermal/int340x_thermal: Add additional UUIDs
From:   Zhang Rui <rui.zhang@intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Nisha Aram <nisha.aram@intel.com>
Date:   Mon, 03 Dec 2018 23:08:27 +0800
In-Reply-To: <20181010083007.239938-2-matthewgarrett@google.com>
References: <20181010083007.239938-1-matthewgarrett@google.com>
         <20181010083007.239938-2-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthew,

On 三, 2018-10-10 at 01:30 -0700, Matthew Garrett wrote:
> Platforms support more DPTF policies than the driver currently
> exposes.
> Add them. This effectively reverts
> 31908f45a583e8f21db37f402b6e8d5739945afd which removed several UUIDs
> without explaining why.
> 
I'm going to apply this patch series, just with two minor changes,
1. 31908f45a583e8f21db37f402b6e8d5739945afd does not follow the git
commit description style 'commit <12+ chars of sha1> ("<title line>")'
2. the UUIDs were removed previously because these policies were not
used.

thanks,
rui

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Nisha Aram <nisha.aram@intel.com>
> ---
>  drivers/thermal/int340x_thermal/int3400_thermal.c | 14
> ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/int340x_thermal/int3400_thermal.c
> index e26b01c05e82..51c9097eaf7a 100644
> --- a/drivers/thermal/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
> @@ -22,6 +22,13 @@ enum int3400_thermal_uuid {
>  	INT3400_THERMAL_PASSIVE_1,
>  	INT3400_THERMAL_ACTIVE,
>  	INT3400_THERMAL_CRITICAL,
> +	INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
> +	INT3400_THERMAL_EMERGENCY_CALL_MODE,
> +	INT3400_THERMAL_PASSIVE_2,
> +	INT3400_THERMAL_POWER_BOSS,
> +	INT3400_THERMAL_VIRTUAL_SENSOR,
> +	INT3400_THERMAL_COOLING_MODE,
> +	INT3400_THERMAL_HARDWARE_DUTY_CYCLING,
>  	INT3400_THERMAL_MAXIMUM_UUID,
>  };
>  
> @@ -29,6 +36,13 @@ static char
> *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
>  	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
>  	"3A95C389-E4B8-4629-A526-C52C88626BAE",
>  	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
> +	"63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
> +	"5349962F-71E6-431D-9AE8-0A635B710AEE",
> +	"9E04115A-AE87-4D1C-9500-0F3E340BFE75",
> +	"F5A35014-C209-46A4-993A-EB56DE7530A1",
> +	"6ED722A7-9240-48A5-B479-31EEF723D7CF",
> +	"16CAF1B7-DD38-40ED-B1C1-1B8A1913D531",
> +	"BE84BABF-C4D4-403D-B495-3128FD44dAC1",
>  };
>  
>  struct int3400_thermal_priv {
