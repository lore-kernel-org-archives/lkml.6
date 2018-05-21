Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-914455-1526916844-2-6989729395759473506
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526916844; b=E9UOvPp3fqaztK/z2JylFBnEyAUxet8ujBWQgwfndQ2FZFaptv
    kA/jgWiXTAYZy9kY4gkFofeUtc+ry/Up9EW7isJBUJP6BABNz2tjBB/+VTKezABG
    uExqAY/pKrex+LssDcuF0JhLFrJ4mMMXmH2Ia2EwqgD8R/dB0lNfKOSJv6tBOSzf
    QXZwkvXPHefaA0JThh3Xlv+uPHSHMiTxuO2tCRcjiQVcMeo6Fik7IKTD/oNWnW7m
    Zdb2Rl5qiIDySbNwC7SWV05loncLL0bP96DgL0RG5dbNGAGLnVDC7lqupPIR8gFj
    ztlTAg5fSEDzsQfffLVIkRCJB2JC2pEpycnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526916844;
    bh=Bqk3zU2d3Yl7Hw1POwknBhDo4SaUEWfSLJe3uDMTFu8=; b=TCbVWcpLnICl
    0U1ZsyqLjxItNxWER7+K04Fimw1wHBpUaRaQWyPNgWljDMm5RGbKImxpqbvssp0C
    mmltnR28i8fSuAj15I2/iUJ01f/dNEzbvqbBT7EckRkUjAnIRbmrBMAgnHIkd7VH
    PzWBjhaghF9hmuMGDAWpwMOsX9MckZ8IXUJuOhDK1EgvYoNa9wRRLQJe5x0P3dMp
    Mi+Y5V5dfoC5mEQCN/zxM2JzjXeS4PR8uDN4i2EjHOfAGbiTdklziBE4h+3pQCnu
    XDs0FeRtZD882GHj0hz5IvkckgCchhcTr9VEcbN1eyBhQMxow25fNW4b0lzw/cqG
    iVjHnot0uw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEd7HXMSCJNlT0AEFGaDdJPS2md7o7bX/40Saul4WUm8bwrFk+JvjfYdIZVAJR9trTz62fA/t35wDF49OX2kdcIofQ6A1XJVLDUJ8i0N0lPmnuQoBVKQ
    w9BvJnRIFLrhoSzzVdPnHUquT29qLqiViyGolGQhYpsXAgJJjQol+vpf/4zx4YKLCaa+l0Q6TR7cB5FwFvoZuQc66y337uW1nv38LD39Hoq9oaibO5qYJzC9
    7gvVt5wiLL5WHofHq5My3w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=K6HrmWtEAAAA:8 a=hBqU3vQJAAAA:8 a=VwQbUJbxAAAA:8
    a=i0EeH86SAAAA:8 a=XTcaBvVDwBjk7NxzwvAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=yV38gEssg_2GhkhKF82i:22 a=WLjMIN4s_96MqnBbPenP:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeEUPeA (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 11:34:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45749 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeEUPd7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 May 2018 11:33:59 -0400
Subject: Re: [PATCH 26/33] apparmor: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
From: John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <06051489-f5fd-b7bd-d5be-db3706dbded3@canonical.com>
Date: Mon, 21 May 2018 08:33:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/21/2018 04:58 AM, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 

Andy Shevchenko patch to do the same thing is already in apparmor-next

> Cc: John Johansen <john.johansen@canonical.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  security/apparmor/lsm.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index ce2b89e..9b5904f 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1378,14 +1378,12 @@ static int param_set_audit(const char *val, const struct kernel_param *kp)
>  	if (apparmor_initialized && !policy_admin_capable(NULL))
>  		return -EPERM;
>  
> -	for (i = 0; i < AUDIT_MAX_INDEX; i++) {
> -		if (strcmp(val, audit_mode_names[i]) == 0) {
> -			aa_g_audit = i;
> -			return 0;
> -		}
> -	}
> +	i = match_string(audit_mode_names, AUDIT_MAX_INDEX, val);
> +	if (i < 0)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	aa_g_audit = i;
> +	return 0;
>  }
>  
>  static int param_get_mode(char *buffer, const struct kernel_param *kp)
> @@ -1409,14 +1407,13 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
>  	if (apparmor_initialized && !policy_admin_capable(NULL))
>  		return -EPERM;
>  
> -	for (i = 0; i < APPARMOR_MODE_NAMES_MAX_INDEX; i++) {
> -		if (strcmp(val, aa_profile_mode_names[i]) == 0) {
> -			aa_g_profile_mode = i;
> -			return 0;
> -		}
> -	}
> +	i = match_string(aa_profile_mode_names,
> +			 APPARMOR_MODE_NAMES_MAX_INDEX, val);
> +	if (i)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	aa_g_profile_mode = i;
> +	return 0;
>  }
>  
>  /*
> 

