Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-427704-1527093933-2-3034882343167593912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527093932; b=Z+eo5jNUZ/c5z4585fk1Jp+vt7LEgkw8vgHWZCXUKhTK0UP56S
    ZTwEu/sf4013543xMvD3JpJGqAN3Hx1o0uVY8d4C/QobDXuIhmXSXvdch+g3O/iN
    e2g4kTx8CnoeAmc1xW0Y6CoUQOeWv4vD0vv8udNBLkefZkM07+SL/eycZkDQOM0K
    +es1ouLuliV2V8qSw8qJQiqi7fGOtIq55e+bPeP42A4DlYbOJMOZNE3gveUtlwFo
    GSrdyMH0F5dRIYEfz/HOJ8/+2UqjDxFYKENxT6hkKr80NFLMw6UEQTSgegnV9sAu
    /YKHCbiKeos3LDSzBO0Y/04L9TR7hl7Gjwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527093932;
    bh=HQkmK0AgXz2c72oSzSNhVPCIlYAHDaF6icdBux64j/k=; b=XwG9OuNHLNxG
    o3+14RHNVcnGPoZy0sSEQDViOwVprMurK3AjJt8l9EebiJOAEUvAhVsZWaPsweac
    DHjD+0pYgjcA/WIUZgo4JEOELzBV4yJHVdgJTC3Ald5aUrDpzl8KgK+KBKJJXhuP
    8HEzBISZ5vsl1GwNaOhOqvL3vyYSjp0Nd5fh00W8+dakyJfp6xkrGCsB6Bpxx+dR
    CxK9b+tflL8yfx4g8cDdxIRVkwc4iwOoUWEVpkzbcXkwrorw4QxgTdN8U/UVgne5
    kNWD+oiYuKZqcbdkfGDbPRvDSZHs+ZcdWL3YarSUcx1QybbHH1Y6l7qvAJAL9iKK
    /Aag1crzVQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA14uwGkMNcwUfgGWR2SpFUk/pyB19pqTxRwMPx3yzZcunGQrA2ElpLfMF0LYFZyyceEh58rbQ0ulRxrE4k5UEtymU5/7ATgtqTUY5KH12FGqSgSk7vH
    kGHOEO2ol4Ib17l4Wz2eTZPkm0vLDw9c9AYYZLpXnhTKz7OU7i5Vxp654yOD+WM4ZTGbQmc8wdEgv6AQ7nYmzUj8XGK5IePpAe6V1W7DPIWny2l0fhAvCJN/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=tNYIeVqtSxNbs3de2yEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeEWQpU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 12:45:20 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:42985 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeEWQpT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 23 May 2018 12:45:19 -0400
Subject: Re: [PATCH v3] usbip: dynamically allocate idev by nports found in
 sysfs
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Shuah Khan <shuah@kernel.org>
References: <c57fa7e9-d811-234b-fefc-1be998c5a8f1@kernel.org>
 <20180523092256.25922-1-m.grzeschik@pengutronix.de>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <ac85c509-72ec-c126-afb7-521ddde87ec1@kernel.org>
Date: Wed, 23 May 2018 10:44:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523092256.25922-1-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/23/2018 03:22 AM, Michael Grzeschik wrote:
> As the amount of available ports varies by the kernels build
> configuration. To remove the limitation of the fixed 128 ports
> we allocate the amount of idevs by using the number we get
> from the kernel.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
> v1 -> v2: - reworked memory allocation into one calloc call
>           - added error path on allocation failure
> v2 -> v3: - moved check for available nports to beginning of function
> 

Hmm. With this patch I see a segfault when I run usbip port command.
I think this patch is incomplete and more changes are needed to the
code that references the idev array.

I can't take this patch.

thanks,
-- Shuah
