Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2377225-1525763932-2-7530010695710396371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525763931; b=SNuQckhnAeT/tWX1Pm9VSHe/tBuec7vHagY/EG5tAvrERdrI3f
    7eHKKre7ILg+E1W8RGDvAOYx/BjmLgAhEeapVrZhAnUQmFRu0PHE8GdPdh67cVjI
    K3kjpAoiv1Rrr1bJAxQ3j0hEgD7SZdWcIMQJmiKPRzhjRNf1BI6DfnldVVhiyTYn
    cKVk6ftJi5ko+lfEDd/eb787nmJ/imPqERwjRAcGIQ3Lvy/sFuLuaHuih1p1uQbo
    ogNhTdVTxVsyRaEmPkwVPSE7VSY1bFP+lxxLCcND5cmUTW4Q19kEE2ijRtIlNytl
    nxghDHOjFlQ+NCI5W6Be4XVvzM8yO7MC03EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525763931;
    bh=vECXGtgSgoxo6ts6VacRcBlR135l0IksQda4j1/m79c=; b=RFuxpGZ1jK3B
    C6voHfGMwXV8I3CLnuIPHlYNXGA0giWe+T20X8JYrKIt6Rz9aM2jQz18xvLfFME8
    4g+7vRX97KEY0CYYIOWDZXTEgv8XQfwLxRL95kmnvcO0Dujauh8Y9QBYlEL7Mhv3
    bDyNkrwkzqx557a/2WI0tB+Tu8wWCSaYKw4EW5fmsNVD6JXuv93lplK5V6B5ExtJ
    /ucYCimG5nVKDJ5LWJm81U6Jdu7x+KJAQCAtW1SqgLa52gkWEnDYhyNFLshby0aO
    WexYYv/6QBxNUl/1zR+TGXfXELOcZHws0aJ4j5IZeVlz575Ph4al0IP4v2Efa/ja
    nf728p1N1w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCjhYUfjDw2BmAvOUEtfbZFMcEzK58Ruc16sjEo295ht4EcJHA40oE0GmtdHiCO72iaN77207hD//5Oq7dIovyHaFPUg7reyMcc6q1K+XKYZMKevMASO
    TFmzKAVD5PY72uLXyZaASqJJ2HBLRaKNIe2X06rr529Y8/Enz7re1yn6GjuGGyrojtVCwLmI9o4ceMbG5P6l/L4GqVAwMVZG2YBEY94IItE1KVxPBOxXUIOV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=NteiBvkbcA4wrRlrhVcA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754565AbeEHHSs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 03:18:48 -0400
Received: from mail.monom.org ([188.138.9.77]:38720 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754498AbeEHHSr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 03:18:47 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail.monom.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-rt-users@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, gregkh@linuxfoundation.org,
        Daniel Wagner <daniel.wagner@siemens.com>
References: <20180504163041.28726-1-wagi@monom.org>
 <20180507125146.75crpaj2scav7mql@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Message-ID: <d37e074d-5e8c-84e8-5833-7ff595e6348c@monom.org>
Date: Tue, 8 May 2018 09:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507125146.75crpaj2scav7mql@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Sebastian,

On 05/07/2018 02:51 PM, Sebastian Andrzej Siewior wrote:
> On 2018-05-04 18:30:41 [+0200], Daniel Wagner wrote:
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -2890,16 +2890,16 @@ static void serial_console_write(struct console *co, const char *s,
>>   	unsigned long flags;
>>   	int locked = 1;
>>   
>> -	local_irq_save(flags);
>>   #if defined(SUPPORT_SYSRQ)
>> -	if (port->sysrq)
>> +	if (port->sysrq) {
>>   		locked = 0;
>> -	else
>> +		local_irq_save(flags);
> 
> how is this helping? You should see a splat after a sysrq request.

You are right, I didn't really think this through.

Should 'echo t > /proc/sysrq' trigger the splat? At least I was so naive 
that think it would be enough.

Thanks,
Daniel
