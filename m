Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-705158-1524065449-2-7595245310944795635
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524065448; b=a9UlKTTsiNz0V1r1ewRsc4R99nGv0QGN7G8eKHIqkJP2bLHBRO
    LkxcYi5vfNXY3/2tdQtmZlR5rVobz2cH1RU3BlSn/TDHfcpvWNCMoTZN7gLeCJGs
    L29/1HlajksaZynRdEhuL0JlUxAwPeuu0DK5Y5aXadYm/ILreDr7sQUYnpcbxEmT
    qw71pTN7sxLlpH5KN0kXHYE3CKMGYCqwq1N6NU4Dwhs5FRAArGoLdSundOaYfnSI
    i8p66UJe0dOjpvWWrecki4m9CegTNzVEJZSI4CzgpGu6qIYJlv2AvxFOPwtC+5tU
    TI5OdnIZz3e8gIkl2RfwIt7hKoeBji1UuApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1524065448; bh=y
    QkRAY0K0dPFc0yXLMbsJsA+232c8viflMASUH7qTOg=; b=Qf3rkdppzhrWFGdIv
    uCZ+BqU1X9ulTO+GsamA/bh8BcFqAax9YjLPzoBjEKAD+BvNNYhujPOQfuzY9evl
    ZohpV1w427YOUl9YI2z85Hv4Md0sZ09tAniOza/DZUbg2HXY8zAUS6XXwyJdFhbp
    glw4Xa0LIlFMX9VaXdR+qwhltOdTpDWepFM0Es96Ah4D5TvcrBHqBEomi7WumsJ9
    SlcJY4Sz2k5dba/1NAAJc48fBLOjja04KHA5RPAQNSkrQPNIiq8OiOgAUF7YFYcG
    qmUngnnalycQYl8co0hbJgKeuM/0h+22yejJy6iyJyR89QHq/ykiAduE2zDOfFCf
    JIx2g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=FPkJZQXz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=FPkJZQXz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxKzhhwqB0p96+TC1YEsO461a28nlLtbkSjhxzMeHiavZKZAvi2PhaivHil2Fhcp4Cplaj+MIbyQsvuICOPAGLoItfs0UhKVyuzGFhqlX4LEnZZTJsA
    LExj3NvtbvnUi34qDHNwhftkO2hokdQzn2eqg1PWGAX0XpTSdfjqE82v1w61+dj3fv8jVp5vp9n94J5rnQmXy8vG5tgimN9rcbZg0B9KIMqFJvkV8wvpRVg/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=hRcl7-O5eJPR_diQkmEA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbeDRPaq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:30:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:38282 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeDRPaq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Apr 2018 11:30:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Wed, 18 Apr 2018 17:30:42 +0200
From: Stefan Agner <stefan@agner.ch>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: imx: warn user when using unsupported
 configuration
In-Reply-To: <20180418145341.xwsah7spyfazcb63@pengutronix.de>
References: <20180418140638.19331-1-stefan@agner.ch>
 <20180418145341.xwsah7spyfazcb63@pengutronix.de>
Message-ID: <6cdfd27073006d0959c21eca23fa56e1@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Remote-Spamd-Result: default: False [-2.12 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         RCPT_COUNT_FIVE(0.00)[6];
         FROM_HAS_DN(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.02)[95.20%];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.04.2018 16:53, Uwe Kleine-König wrote:
> On Wed, Apr 18, 2018 at 04:06:38PM +0200, Stefan Agner wrote:
>> When using half-duplex mode (which disables receiver during txing)
>> the RTS signal cannot be driven low during transmission. This seems
>> to be a limitation of the i.MX UART IP: The RTS (CTS_B) signal is
>> controlled by the receiver. When the receiver is disabled, the
>> signal stays in UART logic idle state which is high...
>>
>> If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
>> transmission. Since this is the default state of the RTS (CTS_B)
>> signal when the receiver is off, half-duplex mode in this
>> configuration works fine.
>>
>> However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
>> cannot be generated when the receiver is turned off.
>>
>> Print an error if the user selects this unsupported configuration
>> (both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
>> configure the closest working configuration (set the
>> SER_RS485_RX_DURING_TX flag).
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Changes since v1:
>> - Consistently check for sport->have_rtscts && !(rs485conf->flags &
>>   SER_RS485_RTS_ON_SEND)
>> - Don't break printed message
>>
>>  drivers/tty/serial/imx.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 91f3a1a5cb7f..1c1080fc8084 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -1833,6 +1833,11 @@ static int imx_uart_rs485_config(struct uart_port *port,
>>  		rs485conf->flags &= ~SER_RS485_ENABLED;
>>
>>  	if (rs485conf->flags & SER_RS485_ENABLED) {
>> +		/* Enable receiver if low-active RTS signal is requested */
>> +		if (sport->have_rtscts &&
>> +		    !(rs485conf->flags & SER_RS485_RTS_ON_SEND))
>> +			rs485conf->flags |= SER_RS485_RX_DURING_TX;
>> +
> 
> I wonder what should happen, if the device tree has both
> 
> 	uart-has-rtscts;
> 	rts-gpios = <...>;

Hm, it seems that the code controls both in that case.

> 
> . I think the right thing would be to check for
> 
> 	sport->have_rtscts && !sport->have_rtsgpio

I agree, since it controls both one can use the GPIO to have a working
half duplex with low-active RTS configuration.

Will send v3.

--
Stefan
