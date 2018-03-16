Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4146336-1521240954-2-14090619912317711750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240953; b=S1WmLqzKnvXnAKcNpP4dpXSj+J2/qr5mZLogRDvfbr0Okq2
    ZU+fpGDnyt4XjzjKG6fJEMBYug9lQRyddfj18O6pH8ZZoYtlcwY8uTdX1zJi8YgB
    KRE6Quvk1fNMCf5Ksg7B8IoFM7wmMs2xtXmU7oNIb03MfhhTlH3isKn6za07vY34
    cvR+dPAgALDtG19DYZ1lBwCFHnA6vVk/xTYf/1Tg6DwLWsPcY3ycay9Wmh0od9hd
    yVuwdDOB6kwO1HLX99Too6Yopf0mv8/o6uh/h5R0cHreUH74vcWmgkLY5CiSyeyr
    RECbg3ZVzaZ7HkGx9jSVdyOGLpv69TTlgZ01zrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :reply-to:references:mime-version:content-type:in-reply-to
    :sender:list-id; s=arctest; t=1521240953; bh=lOQvuGz+u1KpEUvg11z
    9fGWeeI2/+Io9wpxWKe+4v5A=; b=wWGwHHJLU5SWGrDt0lZ4wqVttk+5zhth+60
    hqehvD6QIDEgUwsNRj8sl5Bx7dbdFsEsOYSFuQifBC0PdN80Y3YB4Y3RgLyxx9L5
    u+b/s/oDK6NMhhkqBLK+c6Fx3KabXQyGVBfCLRh52Igj9uqxpfDHEDL6Xs3VxNsF
    zyvWWu1taJW4TroyVrfMlkCsFeIB3mZTiAtgWePd/BTmiNZiJv6rQIwsmpQlKTU7
    da7hhDG1EqNrWY58kbKtp4aqg1IyDRaR4k5/cUu0G3VCFg9pif58G/hMYzhk5kzk
    quw2B7tGgscPnyQ6ZVCxUHkqR7JPjSuXxp3Qx4KfLbehY2X7sDQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeCPWzk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 18:55:40 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:25661 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbeCPWzj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 18:55:39 -0400
Date: Fri, 16 Mar 2018 16:55:37 -0600
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 4.4 29/63] watchdog: hpwdt: fix unused variable warning
Message-ID: <20180316225537.GA5989@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <20180316152259.964532775@linuxfoundation.org>
 <20180316152303.262268098@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316152303.262268098@linuxfoundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Greg,

Sorry, if I'm missing something, but I see 3 patches for
hpwdt queued up for 4.4:

	queue-4.4/watchdog-hpwdt-fix-unused-variable-warning.patch
	queue-4.4/watchdog-hpwdt-smbios-check.patch
	queue-4.4/watchdog-hpwdt-check-source-of-nmi.patch


Shouldn't there also be a 4.4 patch for

	commit 2b3d89b402b085b08498e896c65267a145bed486
	watchdog: hpwdt: Remove legacy NMI sourcing.

As there was for 4.15, 4.14, and 4.9?

commit 2b3d89b40 is the Spectre related patch.

thanks

Jerry Hoemann



On Fri, Mar 16, 2018 at 04:23:01PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> commit aeebc6ba88ba3758ad95467ff6191fabf2074c13 upstream.
> 
> The new hpwdt_my_nmi() function is used conditionally, which produces
> a harmless warning in some configurations:
> 
> drivers/watchdog/hpwdt.c:478:12: error: 'hpwdt_my_nmi' defined but not used [-Werror=unused-function]
> 
> This moves it inside of the #ifdef that protects its caller, to silence
> the warning.
> 
> Fixes: 621174a92851 ("watchdog: hpwdt: Check source of NMI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/watchdog/hpwdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -474,12 +474,12 @@ static int hpwdt_time_left(void)
>  	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
>  }
>  
> +#ifdef CONFIG_HPWDT_NMI_DECODING
>  static int hpwdt_my_nmi(void)
>  {
>  	return ioread8(hpwdt_nmistat) & 0x6;
>  }
>  
> -#ifdef CONFIG_HPWDT_NMI_DECODING
>  /*
>   *	NMI Handler
>   */
> 

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
