Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1428800-1525095621-2-7196608718791417400
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
    1525095620; b=IdiJOQBnalIdP1Xb7mE0b1259AAVeIuoZU9U7SJht7NorQnI0q
    UZG2dSaz+FmDmj4Wfd17T/t9ljzk1BLyEcUODyqL1gJomwgwhtPyPbYXmw6vC4RF
    8szggm0hFWqL9VeKlXNjaERL4Rub8wkgUuJbOurpPVZEptBuaeVd8BDgt+GM9tff
    ScG/EnLaZWELD+1Kh/iCkN37bffKhyvePUgdB+kAO/pAFptczGqAws7/MIN0o0hr
    ESY/4dnYXbMVp+SWtPjuGzFnazMbGcB8Kq2d7c5KsJ1ZkCv7S+BKkV4yo6U2cbK1
    IQ83dqQQwePTbnotfEJf/h8OUje6GRbi1ghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525095620;
    bh=KHtkqqsYHVrNp76GB7Y1JndK9r7DzkLKBwbD8kQsRXY=; b=PkOWPHeFkjO9
    qE03tsn1njrQtg0Lo7QI+lSZkm+EY4kUGPt7CwqzL3PxmZO7BjS32atl/0ecT7hN
    jCi0HcBeFKjwByYeYLF6SALBkCWA2A/lzo+yVq4S3i0eaAS++HGmQEG6EgPNalkY
    z6e+TFP81kxAv43b0ued6DL8RhvOlegXBbe9SidQegZxP2MUiIxSJO59eGa44CuF
    PF6zOe2rGebbr3nZAVdUUhdtmkeXO8+nt+B8phr6wfS9MpdMIhWw9KIFnXH9v3a3
    mKniNpWR3Rd5AZHZO9EHTsIwUG+oj9drGxtE2+RPNx4IG9NpUadffCVqIGH9Qchi
    2PU4W8QZBw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PalUgdXm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q9Y2HSit;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PalUgdXm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Q9Y2HSit;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEYM5W2dRGmm9RchQRb9BPFj29dyBIfUAorJsCMWjeD+kIOfDy8Ct/1dQXCP+MoREzs7fldO349ww66U9QWJFEx9uz2co460gTL9/iYdIaarS64BhGMG
    dAtAoyYfvOjGHX5YfS7dVmjemxIJm6cNfyp1HzTFhFiTZlm8Krd/ZjdMFCaYjNKiuUfSKSPnu7O5VY4qZ8IgEkg2t6oVUr2uI2zeP6g4fAEBFKuaQxaRB02z
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8 a=dRAVj-Udo-jdj58jrXUA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=nlm17XC03S6CtCLSeiRr:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeD3NkH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 09:40:07 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37200 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeD3NkF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 30 Apr 2018 09:40:05 -0400
X-Google-Smtp-Source: AB8JxZoBGg/Yn046OkB5gNohBwAJcSiOo6QPA3HNPDcaMGp6xM0/vE0dIeFLMjb9jnLyz0tigu16kQ==
Subject: Re: [PATCH 2/4] usb: typec: tcpm: Release the role mux when exiting
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
 <20180430124158.45269-3-heikki.krogerus@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7e84f84a-4158-4582-6417-7942b2c4248b@roeck-us.net>
Date: Mon, 30 Apr 2018 06:40:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430124158.45269-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/30/2018 05:41 AM, Heikki Krogerus wrote:
> The ref count for the USB role switch device must be
> released after we are done using the switch.
> 
> Fixes: c6962c29729c ("usb: typec: tcpm: Set USB role switch to device mode when configured as such")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 1ee259bc14a5..66dc0773b9bf 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -4652,6 +4652,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>   	for (i = 0; i < ARRAY_SIZE(port->port_altmode); i++)
>   		typec_unregister_altmode(port->port_altmode[i]);
>   	typec_unregister_port(port->typec_port);
> +	usb_role_switch_put(port->role_sw);
>   	tcpm_debugfs_exit(port);
>   	destroy_workqueue(port->wq);
>   }
> 

