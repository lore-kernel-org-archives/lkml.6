Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-382606-1523519023-2-6287577296568278020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523519022; b=MclF5zzrhOewyCXfMKdibND61k7RxrBahLWcbHDBzk2ZW/VS3C
    /0KK2j7dGaM+jxMg2OANYGjXHP0b+4lKjioU50lkF3BCKUpOg/bPkrrWIf00MKa6
    EKFYkWiiJPJOebycGxrM8FS7tdwUG0F3GF6A+pud3zQjqqe/BlSbArlmtEi1IXeL
    /owaJq6btC0Pk24sc9BtEbSZsw7yfeEf4Vgp/JEGtjxmgwcoGvY27HhgCXtcjFju
    L8ras3Wt+C5E6g5XvzaXRXWwTvwmH8O7asyoZQzRaBh1e78f6nnaDzC6rEFM1gGH
    r4wI4Sq0cMLgvKUPRKvnhwm1o8NCbk54ELFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523519022; bh=45UIq
    IHsxssgN3/UtW+bjhP0QaxjWlfn4N9rxttVBtE=; b=Sl5Ic6M5z7HYCompZ+uJ9
    VNjpCN3B3zjcFdE6hAqFUgeQBavdgzG/YpeLdMLpx2zvKKxQURa2RKaYVJsaGqnP
    IjLX7Unzdllq0sBiA+6PetCMV2QxqhU1xSYvey3XqCU7JFomkXsvaJWeYpyXrR1I
    Sz5zuEIh0we2ZyMYPMy2TI4D/Bbmten1Lov4MPJ/L9s/KgGzkB/5qf5vCiydmMJv
    PgmRnVyOI73nZA9wWD8aTA/Vpf4Rn+8lYXxjYYZ4NjYT1sBsxHRUjUUsceih492v
    8FyNHQxAUo//Dg3CIgpjzeHwJ+cwXj1cDkSJvc5iHVfjpG+HaPKbA9vAJNU4eVVS
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFSnYrBLYoT5zmYgsAXcelN7wR9NgVPrXjIodwEJf0e1OClNjSIFZLTPIkMO9275O2fOJ4SfHk58wG2EpkVjuqP3NJClhow3jMWQA+2x1kAl+U3tFFAC
    oFEfA8efxoeje2FI7lnJW9LcrK0hIwaHRaX5Nonh8zFhqnjxzoPBzVSxZvglI8WRpS9W+rTZ2l98BO4OVjDW61TMBSba5kKVeO97xeMqBCUDe3yo0joIND8A
    UkZ1y+NK75awgYjI4fe05A==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=P-qd95z3-qW7mMlPtgIA:9 a=CjuIK1q_8ugA:10 a=D0TqAXdIGyEA:10
    a=xa8LZTUigIcA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.48,440,1517900400"; d="scan'208";a="13760300"
Subject: Re: [PATCH] staging: wilc1000: Remove unnecessary braces {} around
 single statement block
To: Eyal Ilsar <edilsar@gmail.com>, <aditya.shankar@microchip.com>,
 <ganesh.krishna@microchip.com>, <gregkh@linuxfoundation.org>
References: <1523371795-5090-1-git-send-email-edilsar@gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <4c3eeecd-ac80-a312-59cb-2b9432a5b5ae@microchip.com>
Date: Thu, 12 Apr 2018 10:43:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523371795-5090-1-git-send-email-edilsar@gmail.com>
Content-Language: en-US
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 10.04.2018 17:49, Eyal Ilsar wrote:
> Remove unnecessary braces {} around an 'if' statement block with a single 
> statement. Issue found by checkpatch.

You should add an empty line before "Signed-off" line as stated in [1]. I
would also add a space b/w your name and your email in Signed-off line as
is exemplified in [2].

[1]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
[2] https://www.kernel.org/doc/html/latest/process/sub
mitting-patches.html#developer-s-certificate-of-origin-1-1

> Signed-off-by: Eyal Ilsar<edilsar@gmail.com>
> ---
> This is part of my take on the Eudyptula challenge
> 
>  drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> index 205304c..325afe1 100644
> --- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> +++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
> @@ -284,9 +284,8 @@ static void remove_network_from_shadow(struct timer_list *unused)
>  		}
>  	}
>  
> -	if (last_scanned_cnt != 0) {
> +	if (last_scanned_cnt != 0)
>  		mod_timer(&hAgingTimer, jiffies + msecs_to_jiffies(AGING_TIME));
> -	}
>  }
>  
>  static void clear_duringIP(struct timer_list *unused)
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
