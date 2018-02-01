Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205632-1517474805-3-245578409858095064
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517474804; b=Zs0nIIs7Fd2riyrUkQ6tEs1lYp5TsiJLmaOwLj1VOHaj3+s
    gIVLeTE+5z4SDBfElkfKZHaTQAwmF8WKnbE39VVhI28z1VcN8rZupnuYvTXKdN2I
    6QTStW2ZOx9JeIEysFZc/O81uP3Y65CU52kc8CWn3J7aeRSO5dYzOsTCoIIdjQ8c
    LS3XhM7P88sWkhqx2URlkHd1mupIFWNDZgmF52hW3dzbV5f8hOkH9YURpwRhgS+e
    iB9TmMWLU2d29nV0UIBB890+BmL0g3MTyNYGbsOeGS+vu4n6sW8bR5iMvKLjBq6Q
    OUmP5oY6zBk52zznELLIFw619mw8IKms17wC8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517474804; bh=eM9J2o3CfACZsjKi/MrRR88lallw/n5BG9ljgNdCEhs=; b=d
    ihh8NBV3iJVzR0VBwdF9K38Ok4gEUSo7gN6dn0ijflIJvdlsjaOwBJO6Lt67S8Dx
    cEOcDIurVQ5jlwHLPfgk1QRC7BL2vfkZzJd6N1otMgjdSRoBdO8oxiWO09jg4aA3
    jHZToNVEGPP+8Szpvb03/oBRRO40ytu32LBLHN9lucHTUSCTbNlEGrFtqiNBtD7g
    NgYsXjhEouJ69Wb5TpJeq8UZqJsN0FPNgcVZ9VeoNDUpwSmEbPW9I3uTUDRKcv4i
    VbFYLQIIHa9GUS8uotje4EysBs6kzusSsSkUD73/8kpKjkRp/mISpheoKmbqRCNf
    q+23jzN4lJcZrCYUW2APA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o7fokorx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=o7fokorx;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeBAIqm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 03:46:42 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37961 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeBAIql (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 03:46:41 -0500
X-Google-Smtp-Source: AH8x225ydQoV+lgwOeQK/8A8G5z2/i4g56EUrZrJ07K8x7uenbflh/AaS4jfsI15Lb6zkVanvrLNgQ==
Subject: Re: [PATCH 4.4 28/74] ACPI / scan: Prefer devices without _HID/_CID
 for _ADR matching
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Slaby <jslaby@suse.cz>
References: <20180129123847.507563674@linuxfoundation.org>
 <20180129123848.888319573@linuxfoundation.org>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <ffdd5d23-0080-6b00-1b46-2b7952200ac7@suse.cz>
Date: Thu, 1 Feb 2018 09:46:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180129123848.888319573@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/29/2018, 01:56 PM, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> commit c2a6bbaf0c5f90463a7011a295bbdb7e33c80b51 upstream.
> 
> The way acpi_find_child_device() works currently is that, if there
> are two (or more) devices with the same _ADR value in the same
> namespace scope (which is not specifically allowed by the spec and
> the OS behavior in that case is not defined), the first one of them
> found to be present (with the help of _STA) will be returned.
> 
> This covers the majority of cases, but is not sufficient if some of
> the devices in question have a _HID (or _CID) returning some valid
> ACPI/PNP device IDs (which is disallowed by the spec) and the
> ASL writers' expectation appears to be that the OS will match
> devices without a valid ACPI/PNP device ID against a given bus
> address first.
> 
> To cover this special case as well, modify find_child_checks()
> to prefer devices without ACPI/PNP device IDs over devices that
> have them.
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

You seem you took this from SLE12-SP2? But where did you take the
upstream commit SHA from? In SLE, I have "Git-commit: fdad4e7a876a2..."
which is the correct SHA of this patch. The above c2a6bbaf0c is a
different patch. So are your scripts broken or is this a manual oversight?

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/acpi/glue.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -99,13 +99,13 @@ static int find_child_checks(struct acpi
>  		return -ENODEV;
>  
>  	/*
> -	 * If the device has a _HID (or _CID) returning a valid ACPI/PNP
> -	 * device ID, it is better to make it look less attractive here, so that
> -	 * the other device with the same _ADR value (that may not have a valid
> -	 * device ID) can be matched going forward.  [This means a second spec
> -	 * violation in a row, so whatever we do here is best effort anyway.]
> +	 * If the device has a _HID returning a valid ACPI/PNP device ID, it is
> +	 * better to make it look less attractive here, so that the other device
> +	 * with the same _ADR value (that may not have a valid device ID) can be
> +	 * matched going forward.  [This means a second spec violation in a row,
> +	 * so whatever we do here is best effort anyway.]
>  	 */
> -	return sta_present && list_empty(&adev->pnp.ids) ?
> +	return sta_present && !adev->pnp.type.platform_id ?
>  			FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;
>  }
>  
> 
> 


-- 
js
suse labs
