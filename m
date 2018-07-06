Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A597DC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0C623E87
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0C623E87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cosifan.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933317AbeGFMtz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:49:55 -0400
Received: from mail2.cosifan.de ([85.239.105.221]:40370 "EHLO mail.cosifan.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932569AbeGFMty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:49:54 -0400
X-Virus-Scanned: amavisd-new at cosifan.de
Received: from [192.168.216.41] (unknown [192.168.216.41])
 by mail.cosifan.de (Postfix) with ESMTPSA id C1A88A1602;
 Fri,  6 Jul 2018 14:49:42 +0200 (CEST)
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
References: <s5hk1qaf9hv.wl-tiwai@suse.de>
 <7049b672-859c-e049-a391-f66e4336d4a9@cosifan.de>
 <CAJZ5v0ikijT8MRHRsTAZ=FGPbkTu4QeJENBCeaa7BDP_E964UQ@mail.gmail.com>
 <1704080.gFTvVrrZA1@aspire.rjw.lan>
From:   =?UTF-8?Q?Thomas_H=c3=a4nig?= <haenig@cosifan.de>
Openpgp: preference=signencrypt
Autocrypt: addr=haenig@cosifan.de; prefer-encrypt=mutual; keydata=
 xsDiBDy8NoURBACtgvNVUTFG6T3wOZkSzdJ26LEkXupbS8jCaEmAug7cR/dQcUbNhMaR6ijp
 LBmLoCCA/9Yvz6GTdeIKjlY3wJ+NyUMP5R85NsPv9+EjVK6YAIQekhcg6WfcjE6gCsLLBO+M
 nwTaWqLo/Q3q2l18VgB8VNLpFkIzsZG1F0JbpBqajwCglsmt8eQgng+DqoTSZjnkaOj1K4EE
 AIDk4KmByPpQi3kvCoBdQGSmHBN0MowKIMcDGUigVcokcdrDTmL1CFNGavj0wOkP4wl3kIPs
 2zNcVW2WNMgAvhAmaz8w1lfn7p0ax1pUVbC46NwPyaYp2YPwKL+cEiYbFJwKZzihxAXCzxc9
 vQbfzvFYw+6C2+HWMXZW3cLKTrH4BACY5QDpUjG2iiD99EHZqg6bcI1pXnksGJOMg6MSSR9w
 bxKK0qiMSSS5JG7PRk3YgNrtTbEb9neviXkdSh1ItDF4HXJZlj2duCXwQwkIOCWCmYdEO8QU
 moxZbLiBC7zE6fhr0B/MOMIOyPYPPJF89POi09sHdP7cYSDbWrGo2tcICs0rVGhvbWFzIEhh
 ZW5pZyAoQ29zaUZhbikgPGhhZW5pZ0Bjb3NpZmFuLmRlPsJgBBMRAgAgBQJJyNJ2AhsjBgsJ
 CAcDAgQVAggDBBYCAwECHgECF4AACgkQoLaSaJmIjTb0nQCfbTOUH79OLDX1mrBjzvdVs7z3
 V2EAnR3gqGqEpazK2gZvVGYOfGpaFrWWzsBNBDy8NogQBADCdQ/wJ5xopgje7lpWCXfRQLqR
 vKtknjybZxyVpgHQqvTXQj9HK96uPgkCFMwBONTYuQwHKpBjz+1iQRjS6vjSpWj0nSup1dQd
 DB8ZS0ztWr5yUWX4aVQS46v0KEbXVBr0cENVZojcZ06J0MeckR4gsMEzXDedgUKfga6oacz+
 1wADBQQAqS98DcPG7pfFGkP1VLxlWQMUXcLOQhiVBq2uLczTiS5Axzab5mnI22/nDBn4cFYQ
 dU2Swc97pD8ZuE1rr7mfSuoZ1Vupv95TKDZ7KHNfSNKM7hHF69dbWbutOUg/Eg0fMvKrsdjm
 F/XA0VlF03XXgw6xTNwuca4v4IAG6pxVpC7CRgQYEQIABgUCPLw2iAAKCRCgtpJomYiNNunp
 AJ4piTdHnixDPkGiNgVNA4iW7P+hAwCfRGZcwHPpxIqnDkeibEmvO6qcRYs=
Message-ID: <6f01a906-b27c-0e1a-e9f6-fa27c015faa3@cosifan.de>
Date:   Fri, 6 Jul 2018 14:49:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1704080.gFTvVrrZA1@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 06.07.2018 um 14:13 schrieb Rafael J. Wysocki:
> On Friday, July 6, 2018 1:21:50 PM CEST Rafael J. Wysocki wrote:
>> On Fri, Jul 6, 2018 at 1:12 PM, Thomas Hänig <haenig@cosifan.de> wrote:
> 
> [cut]
>  
>> So the latest patch:
>>
>> https://patchwork.kernel.org/patch/10511211/
>>
>> should work for you (please verify) and the change in
>> drivers/acpi/sleep.c in it most likely is not necessary.
>>
>> If you can confirm that this one works for you, I'll send a smaller
>> one with the acpi_hw_legacy_sleep() part alone.
> 
> Well, scratch this, sorry.
> 
> The power button probably is a fixed event and it won't be effected by
> that patch.
> 
> Instead, please test the patch below.
> 
> ---
>  drivers/acpi/acpica/hwsleep.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/acpica/hwsleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
> +++ linux-pm/drivers/acpi/acpica/hwsleep.c
> @@ -51,16 +51,23 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
>  		return_ACPI_STATUS(status);
>  	}
>  
> -	/*
> -	 * 1) Disable all GPEs
> -	 * 2) Enable all wakeup GPEs
> -	 */
> +	/* Disable all GPEs */
>  	status = acpi_hw_disable_all_gpes();
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
>  	}
> +	/*
> +	 * If the target sleep state is S5, clear all GPEs and fixed events too
> +	 */
> +	if (sleep_state == ACPI_STATE_S5) {
> +		status = acpi_hw_clear_acpi_status();
> +		if (ACPI_FAILURE(status)) {
> +			return_ACPI_STATUS(status);
> +		}
> +	}
>  	acpi_gbl_system_awake_and_running = FALSE;
>  
> +	 /* Enable all wakeup GPEs */
>  	status = acpi_hw_enable_all_wakeup_gpes();
>  	if (ACPI_FAILURE(status)) {
>  		return_ACPI_STATUS(status);
> 
after cancelling the build with patch 10511211 and rolling everything
back, I applied the patch above to my kernel 4.17.3-1-default and when
pressing the power button the system shuts down and stays off! :-)

Thanks
Thomas
