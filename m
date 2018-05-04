Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-260683-1525444624-2-10700577848016813192
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525444624; b=LUeWsCThJI77flWg0CcXa16JyPR8JJ7aEW0i5wtyi3pk9RDxSS
    U/0OPlDCqby+he7J3B0cZwHZM3mS/l9K1oh+x/p6fJbXSCezdsI6b4uqg/XIipEd
    ZpLz9sRA5QIyVTJ99A+JTpRe4C0HyKtcWaRd+1c08Yn1fuz1RutTO0nX42ay1sPo
    9EgTeC3kU2WI7eX7nmRkIxO78cOqh9CDFMNOADkDBcKTHWXu8hajx65ofezkRkFS
    u5q56pyvWQGVyQhuVaiH4DuwtX1imwAQr1tC6BmDtKwjHFM4VDUaR9BbzYdAOS+6
    iF29J0L8hxC8zE0V2mQaPE9BRYjZ0v1CGW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525444624;
    bh=CdGLTmRmd1UlqOuUF9QRM0bYHJyYhc6xjJhm+j/B78k=; b=BYtL/D1kIRab
    FIsGfgioVO34gyLhnvUvTVSR1oESbhN1xlFrOI9YXQ1Lih4jUgm1McmhX9C0O1Ti
    OxzAqc2fcgKJnZOtep8XagPcvJGU4FZJOTA4UqDBfQHTKknOXbvP6MrLds67XNTv
    XE9bvGZk5vWN7VkSXgrsygKmxBKp8InQ+sw3yuhCdgAdHf+6+oZJ4HgvPyV4atdQ
    HDmwdPn+OuoIr7AUjroCHVqHAV1ikluTRSm6JTAKgLRpbH9jK8C4dEedFC10lNX3
    z0eqRQIvDKZRzWkpd8jewhTo1a1w3qT9DS+9QAXn8XusLAJpk4qZD+65cLYovVxc
    mQnBNrtlzw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfHcz8zTESp+hk3mhr2U+iKR40YtsVt7BtZmo35B2/gs+tzbkHT4NX5BDb+8eyqDvnZflfjvx/B8V54D+GH6IjROCEllHIRxFljXygW/l0Zdqx6EJEC7E
    hk56cpg2c+Md1qjzTZ07a/6lGoByGpOBes68TWCjvA/LtD1uLQN0GGMd0sQyY5dTyBgTf1hc2OzogsCZ91327qAmGEj7/fwH7iHdO+WoGMd2EV9T2ES8qohu
    TdsTMU2BP6MimLdmCYhciA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=_Wotqz80AAAA:8 a=VwQbUJbxAAAA:8 a=WqHXEHlq1YoW2ERZOxMA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=buJP51TR1BpY-zbLSsyS:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeEDOhB (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 10:37:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34340 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbeEDOg7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 May 2018 10:36:59 -0400
Subject: Re: [PATCH v2] apparmor: secid: fix error return value in error
 handling path
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20180504140914.GA16787@embeddedor.com>
From: Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1f4a965f-a245-a5a9-f815-9915df9b3a9d@canonical.com>
Date: Fri, 4 May 2018 15:36:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504140914.GA16787@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Gustavo,

if you are using the coverity scan bug tracking, please can you mark a
bug as being worked on by yourself so I don't work on it at the same
time as we're duplicating work here.

Colin

On 04/05/18 15:09, Gustavo A. R. Silva wrote:
> Currently, function apparmor_secid_to_secctx returns always zero,
> no matter if the value returned by aa_label_asxprint is negative
> (which implies that an error has occurred).
> 
> Notice that *seclen* is of type u32 (32 bits, unsigned), and a
> less-than-zero comparison of an unsigned value is never true.
> 
> Fix this by temporarily storing the value returned by aa_label_asxprint
> into a variable of type int (signed) for its further evaluation.
> 
> Addresses-Coverity-ID: 1468514 ("Unsigned compared against 0")
> Fixes: c092921219d2 ("apparmor: add support for mapping secids and using
> secctxes")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes is v2:
>  - Update changelog.
>  - Fix misaligned lines.
> 
>  security/apparmor/secid.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index 5029248..efaa0d9 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -142,6 +142,7 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
>  	/* TODO: cache secctx and ref count so we don't have to recreate */
>  	struct aa_label *label = aa_secid_to_label(secid);
> +	int seclen_tmp;
>  
>  	AA_BUG(!secdata);
>  	AA_BUG(!seclen);
> @@ -150,17 +151,21 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  		return -EINVAL;
>  
>  	if (secdata)
> -		*seclen = aa_label_asxprint(secdata, root_ns, label,
> -					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -					    FLAG_HIDDEN_UNCONFINED |
> -					    FLAG_ABS_ROOT, GFP_ATOMIC);
> +		seclen_tmp = aa_label_asxprint(secdata, root_ns, label,
> +					       FLAG_SHOW_MODE |
> +					       FLAG_VIEW_SUBNS |
> +					       FLAG_HIDDEN_UNCONFINED |
> +					       FLAG_ABS_ROOT, GFP_ATOMIC);
>  	else
> -		*seclen = aa_label_snxprint(NULL, 0, root_ns, label,
> -					    FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
> -					    FLAG_HIDDEN_UNCONFINED |
> -					    FLAG_ABS_ROOT);
> -	if (*seclen < 0)
> +		seclen_tmp = aa_label_snxprint(NULL, 0, root_ns, label,
> +					       FLAG_SHOW_MODE |
> +					       FLAG_VIEW_SUBNS |
> +					       FLAG_HIDDEN_UNCONFINED |
> +					       FLAG_ABS_ROOT);
> +	if (seclen_tmp < 0)
>  		return -ENOMEM;
> +	else
> +		*seclen = seclen_tmp;
>  
>  	return 0;
>  }
> 

