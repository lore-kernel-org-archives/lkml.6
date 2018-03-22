Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3867414-1521760937-2-17806780129304665406
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521760937; b=L6TdO34o/b+GgO5ZUVN+mQLjHdBPPbrNAnIko+fZXU/uy2J
    VWHBbeyJ6cYVPkxkgSpmnlTtJcVzZvgfMV0zQ/k1yr3VNdRVIENcQsCToqdzShnM
    zkIWzuCwal6lrheHdakyfQwokmc2HEPmFOdmNZmTdTIi0aO3OPYBRwt+90LHayyr
    5XCYbbw9ZM2pxDioIG6ukkmlq7F0jMJBc1S0PnviDo1zrkg2N6DYWUvCcUpSpt3k
    0uaRNuRPXT5DP0E9uXAPo1OLF3HivJRAqcElOnVU+1Kvu7YhycBnLplZplHME7kG
    D4HoEsS7/Rp/xhDEeUIgadjH6Th47e3Rynw4W9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1521760937; bh=dJcZRI
    uXRzkOhgm689pcXHetZn2GOkBR1gXB7QzW73s=; b=UZcPoBSsHhFcF6DIpMH5sd
    N6ijhIOYQ6hYgfNwKcYLcVno0oqF+H8D9F260yIajCeiOBlPRo5EX1SZkgf4JjXL
    VpfXvrfGC3GcCmfryoYfJrvDviM2aXCLNaFuo+yaaqrs6FZ2Ksmmz/f9l3oiR8Lp
    PMfqowJWRg67+OLfGvHROg/e5jjFRFyvT7/7h7QUzUlrYnplSl3bws8ohoAK5IQf
    Qcj44lyFMOTvIa6kYw4EMu2Xy+8HnzewBBnlLD9hGD1xYny+PW3/E8PZDe1XtKgB
    N4qAJ8/5fyctpUp0evsdZEUMUqqw6iXU8uwOfQL7TlOXzlnvNfd10btN/SuayTzA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rjwysocki.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rjwysocki.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCVXWE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 19:22:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43460 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeCVXWD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 19:22:03 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Daniel Drake <drake@endlessm.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        chiu@endlessm.com, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] ACPI / PM: allow deeper wakeup power states with no _SxD nor _SxW
Date: Fri, 23 Mar 2018 00:22:27 +0100
Message-ID: <3441706.zTHvev0s8F@aspire.rjw.lan>
In-Reply-To: <20180320040735.13025-1-drake@endlessm.com>
References: <20180320040735.13025-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, March 20, 2018 5:07:35 AM CET Daniel Drake wrote:
> acpi_dev_pm_get_state() is used to determine the range of allowable
> device power states when going into S3 suspend. This is implemented
> by executing the _S3D and _S3W ACPI methods.
> 
> Linux follows the ACPI spec behaviour in that when _S3D is implemented
> and _S3W is not, Linux will not go into a power state deeper than the one
> returned by _S3D for a wakeup-enabled device.
> 
> However, this same logic is being applied to the case when neither
> _S3D nor _S3W are present, and the result is that this function
> decides that the device must stay in D0 (fully on) state.
> 
> This is breaking USB wakeups on Asus V222GA and Acer XC-830. _S3D and
> _S3W are not present, so the USB controller is left in the D0 running
> state during S3, and hence it is unable to generate a PME# wake event.
> 
> The ACPI spec is unclear on which power states are permissable for
> wakeup-enabled devices when both _S3D and _S3W are missing.
> However, USB wakeups work fine on these platforms under Windows, where
> device manager shows that they are using D3 device state for the USB
> controller in S3.
> 
> I assume that the "max = min" clamping done by the code here is
> specifically written for the _S3D but no _S3W case. By making the
> code true to those conditions, avoiding them on these platforms,
> the controller will be put into D3 state and USB wakeups start working.
> 
> Additionally I feel that this change makes the code more directly
> mirror the wording of the ACPI spec and it's associated lack of clarity.
> 
> Thanks to Mathias Nyman for pointing us in the right direction.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Link: http://lkml.kernel.org/r/CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com
> 
> https://phabricator.endlessm.com/T21410
> ---
> 
> Notes:
>     This should be considered for Linux 4.17 to give it a decent amount
>     of testing time before release.
>     
>     v2: fix unused variable warning
> 
>  drivers/acpi/device_pm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index c4d0a1c912f0..3d96e4da2d98 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -543,6 +543,7 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>  	unsigned long long ret;
>  	int d_min, d_max;
>  	bool wakeup = false;
> +	bool has_sxd = false;
>  	acpi_status status;
>  
>  	/*
> @@ -581,6 +582,10 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>  			else
>  				return -ENODATA;
>  		}
> +
> +		if (status == AE_OK)
> +			has_sxd = true;
> +
>  		d_min = ret;
>  		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
>  			&& adev->wakeup.sleep_state >= target_state;
> @@ -599,7 +604,11 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
>  		method[3] = 'W';
>  		status = acpi_evaluate_integer(handle, method, NULL, &ret);
>  		if (status == AE_NOT_FOUND) {
> -			if (target_state > ACPI_STATE_S0)
> +			/* No _SxW. In this case, the ACPI spec says that we
> +			 * must not go into any power state deeper than the
> +			 * value returned from _SxD.
> +			 */
> +			if (has_sxd && target_state > ACPI_STATE_S0)
>  				d_max = d_min;
>  		} else if (ACPI_SUCCESS(status) && ret <= ACPI_STATE_D3_COLD) {
>  			/* Fall back to D3cold if ret is not a valid state. */
> 

Applied, thanks!

