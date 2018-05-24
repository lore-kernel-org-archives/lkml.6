Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527153540-2-12278056121216573444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527153539; b=doxcgcbLP8Jk1TGOP/1ryNcx1qZ0Y4jFAVfWM3vN0F9nX7APUb
    HP+XfrkH/2y/jDoOEOCaVER8NQ/Rj8MdMSlkC58hRPsP91ERaYFrmuyk52IcbHAw
    APYWuMCD4ob9GYlE8EiHij0URaL22BlSZZ8EqfHsolBG74hAvrUrpysYpCMUcHJM
    gc25h9cfDWRf1qEOpGW5jvu8a2ncrqgQ/rzYbIgJc34GKnE5iJlJyt+3yLXgblvn
    DiRPtiWnVKEC0VXI6hVH4P8UqtS3Z456Ta5Jd3Fltku+K7hs4euYiiRTi6tEFXJL
    T8qLnYYSs+EzvKoGI/hGJurprBW5Xjw6eLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527153539;
    bh=fmbPzlsuQnXfVOspttlvcEOKozOSd4IC4ATH4TlZ5hw=; b=JTRpLGbGWKhm
    mEW445Y8R+wIhQj/MMh14ox7yq/rCEl/Ws1sR7f9KcGKQnYCRx5wNgXYsWitz+sq
    jWeUbGYXSWEEC5nEU1FF09bGHAJp16IswiCbb1EsugxkKp0Jsmlbe1cF07YKncAD
    lfdBQ/gszpp6/of9eTqVHAqpDPTjt844kitjqvHpZGiETr7cwEikK8TqXg7qgwTf
    JhaRq7TTOysuYA+AWvXzmqR6Eg9WT0R6m6jVe1dQG+B65q7OhxKsseQjMtGFQSri
    t+vN8gFnDzeLfNCo9/i1gW3eKisE71EfFiKdB73ET4G1gFG7pxRxB1te2iTANt2U
    IYlQnp3i8Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=WbYdrKXh x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pT1n6vve;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=WbYdrKXh x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pT1n6vve;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGDaKTOa2FZOlw9VkEhKAOfO9Ek1imnTTd6s/iq/qCRX+iFiZE9vLRtR8G8i9B/uIdaoWtw/7JH0cRd/SFUIjzIzrDa3lclA+jCnOnaAg1Pbo7bB6JRR
    lnuzD7z/XrQWSK++39IjaiTP0CrrBPG7bL4osqIL5g+fdgteYpHHvre6np7ygXA9C+Zu9nx8+RzJYONLBEZszp/7dkRun0j6phBKNtKZXEylsFIBW2GKyIV8
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=EWnOtJgLcj20acoOMwIA:9
    a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=nlm17XC03S6CtCLSeiRr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965907AbeEXJSp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:18:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38313 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965664AbeEXJSn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 24 May 2018 05:18:43 -0400
X-Google-Smtp-Source: AB8JxZrWiUQsOAPLhpKjB+eA1KQfDQpJPQ61AKP9J13BJkWGetO+lxJouAnhVcVsY22zpjtpMEgHEg==
Subject: Re: [PATCH v3 3/4] usb: typec: fusb302: Fix debugfs issue
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180524081827.37861-1-heikki.krogerus@linux.intel.com>
 <20180524081827.37861-4-heikki.krogerus@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2b9c6203-c4c4-ecae-9d50-d8180aec4a54@roeck-us.net>
Date: Thu, 24 May 2018 02:18:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524081827.37861-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/24/2018 01:18 AM, Heikki Krogerus wrote:
> Removing the "fusb302" debugfs directory when unloading
> the driver. That allows the driver to be loaded more then
> one time. The directory will not get actually removed until
> it is empty, so only after the last instance has been
> removed.
> 
> This fixes an issue where the driver can't be re-loaded if
> it has been unloaded as the "fusb302" debugfs directory
> already exists.
> 
> Fixes: 76f0c53d08b9 ("usb: typec: fusb302: Move out of staging")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/fusb302/fusb302.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
> index eba6bb890b17..9c1eba9ea004 100644
> --- a/drivers/usb/typec/fusb302/fusb302.c
> +++ b/drivers/usb/typec/fusb302/fusb302.c
> @@ -234,6 +234,7 @@ static int fusb302_debugfs_init(struct fusb302_chip *chip)
>   static void fusb302_debugfs_exit(struct fusb302_chip *chip)
>   {
>   	debugfs_remove(chip->dentry);
> +	debugfs_remove(rootdir);
>   }
>   
>   #else
> 

