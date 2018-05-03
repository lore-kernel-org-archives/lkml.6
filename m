Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990919-1525328047-2-2127924429059587719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, TRACKER_ID 1.306, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='hk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525328046; b=N+CGkW1z749rQpMDyc6hZsU6VtGWPpPRYZckOpsZ7KtEuGDuRC
    uZL4dib2Ec++eOVeZYkKP3uG3C5564ma/U7NhqV+dKN+UE4amRBAiP52bY+pwMBB
    jZhuqwtcZpJH6Q7YDBaZ1XIzZ1xOUYoQJYF7Oh+pHVKYX7QPM63KtY6NUPRNQPtM
    q9jLQQuJRw9XBTvS27KKc1e7/W2lDCkZ7jpzgVcb0uMiNRAtiJLusOfw2bGgBBCF
    OMtKXBXZOcwQPYJzEkdYECD/DQecUDaR/jngIUhLat+N4iFbvrUgiQ7Vjgl0qLNp
    8q1+LW68UiNoG51Qz5IZD3KPb86LxAqRCX9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525328046;
    bh=jMiHSPe/V0gQhrFUo46BruK3OIMecR5Zrz58yGxmaHQ=; b=eqQ6eSQMwRaK
    CigOIdSjE4bqw2wLgNGk3BYGwbnAES0AAuxEQTO8P/TxjrdzKFVE+XgEwD0zCyfq
    VaZDxmIwXEStqMoukRHU9yWc4OY/Yrim3OGFJiahro1fVjuKMjT5g9nNqpevKPXx
    Hee1lvqpwRNAy3SIdoSDYrJhWynxcNbvwJPSYJDARVeCFckIQYuMZ9tkJVu7CknA
    w3zFXLD4UXKF+MXyGeLeWu3G959f2B9CxsfR6qGLD+kg3GLjKfKKKczaj7YuqmKG
    WyCndwLHso+exBp7ATNDX+68TWR7ytGfe4XA58S7dkIZR0akk2xlhpPw4QsqvBTG
    2ux9S1b8jw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gtsys.com.hk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gtsys.com.hk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH79OZ8+Zvw4D1280kZC9dh95kcT6xqASCjs7PZYQ857DRR7sw9sbde214umGcqjBbJG9E2d43/ZFe1gOToOVJLDRO4h4Pc5ZkfEA9zX8ctNoJ3SqjE9
    Cx4814CqGfQrpBYqD6ArDff1AVujqPnwrUFzO51LAmUo7sRkM7hpnLHSoENs5t3FfvBpYCDB8qEx5kSN90ZtvelV+s4R01v+oVRoN6vK7D59NviAa0KSB2N+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=O7zmUmNSAAAA:8 a=VwQbUJbxAAAA:8 a=qzlHCkm23KfD0gQRDXcA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=IJxu9zi5bFdC9NS7oKyv:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeECGOD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 02:14:03 -0400
Received: from sh1.xit.com.hk ([111.91.236.50]:50674 "EHLO sh1.xit.com.hk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeECGOC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 02:14:02 -0400
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
Date: Thu, 3 May 2018 14:13:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
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

Hi Greg,

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

The IMX serial driver is broken in the 4.9.x tree since 4.9.89.
Uwe's patch

6df765dca378bddf994cfd2044acafa501bd800f

please apply to clear the situation.

I know you very busy! -

Chris
