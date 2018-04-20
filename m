Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1234427-1524214577-2-3685872643515246279
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='hk',
  MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524214576; b=gr2C07iboYMVEroy3M0TBX4Xm2kf55SUDHRreAyymVmskiewcV
    QZY3JgZVH5mmDVeQjpz/6jhKkzKmQpugi5+TpZFlt15aRRpGcXqWFi2jw1xc0t/7
    TogAo/6Qi3RqR2hJDhbggykZTMWrXHajzdVwHnUvYnBlpLHnhKf5A8C8f/xAfEUX
    Im0wSnsgkCiErG1DsnkoMVO0XcsDgcaef/PlvoaSc8tz0U/2yO0p1ZdFfbZFWRJv
    G38/HTQK3KHU++zXWtqHSJMEBJXIAFPdC6wd7bVUpOjrlG63raYWc9TMu3jWl50W
    4bLDh0NYKtFXPKMscIbFscT8RUTTu6lmQstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524214576;
    bh=gzcgWKQ7B9jV8rlBCsvHwlm9Z/H1nW4Nj2vjUEOmxYE=; b=V7D5nVTfq2V2
    Po8/LoKxREahEnSPDTIFW0rFfJObld2M1F1+N8KJNX+TeeNqyzprsGpLPThgW1im
    S37kLXNoTcGH6MT94Acqytoc9TIaORPUh95RAFl8RF+kob04p+9dz89BNitfo5IP
    gxtPxRbIGZE+PHmhO3ezeUSRh/qjG3ya3Vyv3itIHV5F7I6v4YWq7+5G2xkKJPKl
    K3ZDx9oZaX/bfz/fiWrO9GAcv+EJ3pnmcr0zTAgBxrs5T009PNKa7ztr5E01qFgj
    Xvsk2ejciUZFdVzWbROdBMzCTfQA34ftlycFtcp2jPluTHXKaR74SnoqtN5OnLuv
    d8hZJmL51Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gtsys.com.hk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gtsys.com.hk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOj5FBOCq2cLYTTVgvdwgJCwfYjHH2eOTes2FAO9mEiQ94zdGEPFKYwGWRRubSHdgy1t0e28hAsh2j9JabjYo1TQbagVHNVPevdKqHCLk6GzlfFTnB0B
    ME2gDfBi4VzEu7UbMhhSu+QRRadHAOERcqFFyIFnvZFtgIlZzIUQ+Ygmg0MDrHeKVZZtiRqSAZQ7kPTuQUZZtDaTMctZ6JhKcz2245h18UYGKVfQhp8LbXZ1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=O7zmUmNSAAAA:8 a=VwQbUJbxAAAA:8 a=vhPfHTAonYh4u7SR1sIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=IJxu9zi5bFdC9NS7oKyv:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeDTI4N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 04:56:13 -0400
Received: from sh1.xit.com.hk ([111.91.236.50]:41468 "EHLO sh1.xit.com.hk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754066AbeDTI4M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Apr 2018 04:56:12 -0400
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <f9cea977-56b8-052d-ccc2-9b6de7cd3645@gtsys.com.hk>
Date: Fri, 20 Apr 2018 16:56:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday, April 20, 2018 02:13 PM, Uwe Kleine-König wrote:
> Hello Chris,
> 
> On Fri, Apr 20, 2018 at 09:07:59AM +0800, Chris Ruehl wrote:
>> Fix a problem introduced with
>> commit e61c38d85b73 ("serial: imx: setup DCEDTE early and ensure DCD and RI irqs to be off")
>> result in non dte-mode imx-uart fail receive data.
>> By add back IMX21_UCR3_RXDMUXSEL the serial port works as expected.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   drivers/tty/serial/imx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 91f3a1a..3d09933 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1391,7 +1391,7 @@ static int imx_uart_startup(struct uart_port *port)
>>   
>>   		ucr3 = imx_uart_readl(sport, UCR3);
>>   
>> -		ucr3 |= UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
>> +		ucr3 |= IMX21_UCR3_RXDMUXSEL | UCR3_DTRDEN | UCR3_RI | UCR3_DCD;
>>   
>>   		if (sport->dte_mode)
>>   			/* disable broken interrupts */
> 
> Doesn't 6df765dca378bddf994cfd2044acafa501bd800f fix this for you?
> 
> Best regards
> Uwe
> 

Uwe,

the patch you point out would fix that problem from what I can see.

But it not yet at the linux-next and since the error persists for 4.9.89 
to present I filed a patch simple patch which fix my system.

Let me apply your patch and see if all works well then I fine to drop my
one liner.

Chris
