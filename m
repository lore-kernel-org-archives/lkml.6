Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AB8JxZrFPkMI52lqL0KjKPTBLip2RMX9Temr1y44tnUAw0NyXzRduqknANpqRgbVSlCUjZT1XPpi
ARC-Seal: i=1; a=rsa-sha256; t=1525951526; cv=none;
        d=google.com; s=arc-20160816;
        b=vUD7T3YPNGj3dN1kFgnvymhUhozzhrKOxJ5VDr3GowOgbRdHD4xMoFmTkY8dhtHcKA
         TTy6LF//c7BtPUbR0CYKBGCwPQc4gt/a0mXACN85sOKJ2FdWq7ItrkHxlN8XKME6FJZN
         Pk1rhLX5B3AwOC3T73O6vQku+nFweWuK56BiDFgryrlPhFnLQLiDsk36X7vohSLEM7IB
         Tx895irZFhR2W5X+FY2PTHG6zLPTNA0E0OPLgvckEf8bT8bq/SbeHD4ju8QVGhFU6/am
         D+2U1HwFJRjkbYvKjoZhIGAQ3YXGqwc0+LwvatGiedAGluRCICeNXkehVAzTfh7lO1er
         bm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Bx5kGGNYnnA6Cbxykju8AzJoHZQLKXUR3Qn2U/515Vg=;
        b=rDWu/Irs1/r5I7RUQo+a0vbWJDFOyGLkY5aC4iw4ALviWxFAt3wVs9ys+1JP9TDdg/
         PAR0DTgsf0YEjFKpCFNCs7dRbThceguI/p/PnTDarQ+5zbEpRI2oGPOOZim1v9aAbx/u
         aydMkxT6+4JQlLJm7bla2GK9WuOtacz3+4Qv8n79R98dFZcRlN8m45tJoa4nzbWZ/Beg
         bVfrTRXijqfgk2Tf8AHRskM32hKOpnSX+XnVArpm43BOawDaUBq4ZWM/z0yCvI7nfeQb
         yOZKRkfw481QVxugEjHjaAiAwGPh2t9xwURWfzng5OmcsbwsGs3nGTolKnbEa+Dk0yKp
         TgEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH v2] tty: implement led triggers
To: Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-serial@vger.kernel.org,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
 <20180507092710.GQ2285@localhost> <20180510111434.GC6977@amd>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <01dcbf5c-70a0-b067-20c3-f99e22ed4512@arm.com>
Date: Thu, 10 May 2018 12:25:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510111434.GC6977@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599475610182983981?=
X-GMAIL-MSGID: =?utf-8?q?1600076147503888928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10/05/18 12:14, Pavel Machek wrote:
> Hi!
> 
>>>>> @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
>>>>>   		struct tty_buffer *head = buf->head;
>>>>>   		struct tty_buffer *next;
>>>>>   		int count;
>>>>> +		unsigned long delay = 50 /* ms */;
>>>>
>>>> Comment after the semicolon?
>>>
>>> Given that this comment is about the 50 and not the delay member, I
>>> prefer it before the ;.
>>
>> Hmm. I personally find it hard to read and can only find about 30
>> instances of this comment style (for assignments) in the kernel. And
>> arguably the comment applies equally well to the delay variable in this
>> case too.
> 
> It is not too traditional, but I believe it makes sense....
> 
> (and yes, I wish we had kernel in Rust, so we could have real units
> attached to our variables...)

Well, the variable itself could always be named "delay_ms" if it's 
really that important.

Robin.
