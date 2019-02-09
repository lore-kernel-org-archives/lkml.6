Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5034FC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165DB217D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="HNjYi04q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfBITRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:17:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36167 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfBITRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:17:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id q11so4950255lfd.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 11:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OgD5Wl5TJQIQJG3EWlvjDgLdlSUmVzFVqDCAbkP63GA=;
        b=HNjYi04qTzmurepLAa2ni4S6rJEcJtkpsspGQZZCMcIah2slGQHPlvV/wFcLFy17pA
         otsjiR4bkMUm/ADOvCkeGLxtsq3uSyLZ1CQMrT0hfWG8yp+P3BwB3zDEuYkALDetJcub
         0ZqGrgNOucras23Q9QX5I7AIBfYmL6ClqycCSrD5Sl5VXjk5Fxz8DlBDlwD+phQblLmz
         KgzwoNeySXWr7XAjzBBF3IvGVHm4kaTcvDv5SY7paJ7G0Fh85fTxBmvrPZ0l3I9VPBYc
         lyKpRszf4sKWdjAzg6lIUldh5AHAspSO3/RAmaxksO96XF+zdvXnv6IFGjqlBaGuz6hV
         wmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OgD5Wl5TJQIQJG3EWlvjDgLdlSUmVzFVqDCAbkP63GA=;
        b=Nplj31Retoshjrp6P4GhYhZRIzWHqXfvwrdiOOA9go0WcPNLxn+VCfgOTNHU4pU3Nm
         7juhIM793sdNT/YA/18ssk0gzsJX9MyuU/0Hl3i2qDdfeL0S4uCPthdraOEfzWvRuBOj
         G3Dl/shQGSIyyvaN3ot/DkHyVmdRxl+tzfyvAJVUOY6yQQ8ee8rEoJZE4Jbe6xSOGj8I
         dEugzDZqg5ZxxndauW0tCCJ9kR1WP+0bpLqvQkviWgU7yFpcessw3LJ+e9vxLFBO21LT
         GEKXbDOEvWNe7UedoJl3DH0AcbEEr6lBkhFkkV4/1EI2wz71mDCLr0HE8UFUOWmnlAzL
         wdHA==
X-Gm-Message-State: AHQUAuZvKekuOQYuc7x+t3gt49mROFA8i1irSTmaK6ZUUIVpq4cy8FCW
        Lf4LRpv1faH+b7PNHJ4YClzs36gNsAg=
X-Google-Smtp-Source: AHgI3IY9GG9sRnYRWqmMww+kWy7wrRfd4J9ctTC3DR5NsYWujFelyL6p274R1ImsAT1jM3W15m79rw==
X-Received: by 2002:a19:da1a:: with SMTP id r26mr9523835lfg.2.1549739836443;
        Sat, 09 Feb 2019 11:17:16 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.183])
        by smtp.gmail.com with ESMTPSA id e132sm1246793lfg.22.2019.02.09.11.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 11:17:15 -0800 (PST)
Subject: Re: [PATCH][next] can: at91_can: mark expected switch fall-throughs
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190208184444.GA28484@embeddedor>
 <8402d6f6-dff1-eb99-3bd1-051b4f6f24f0@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1db2edde-5e21-6eab-d643-ae257ecb311b@cogentembedded.com>
Date:   Sat, 9 Feb 2019 22:17:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8402d6f6-dff1-eb99-3bd1-051b4f6f24f0@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 09:55 PM, Sergei Shtylyov wrote:

>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> Notice that, in this particular case, the /* fall through */
>> comments are placed at the bottom of the case statement, which
>> is what GCC is expecting to find.
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enabling
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/net/can/at91_can.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
>> index d98c69045b17..1718c20f9c99 100644
>> --- a/drivers/net/can/at91_can.c
>> +++ b/drivers/net/can/at91_can.c
>> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>  				CAN_ERR_CRTL_TX_WARNING :
>>  				CAN_ERR_CRTL_RX_WARNING;
>>  		}
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
> 
>    Why do we need this comment at all? Just remove it, that's all.
> 
>> +	case CAN_STATE_ERROR_WARNING:
>>  		/*
>>  		 * from: ERROR_ACTIVE, ERROR_WARNING
>>  		 * to  : ERROR_PASSIVE, BUS_OFF
>> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>>  		netdev_dbg(dev, "Error Active\n");
>>  		cf->can_id |= CAN_ERR_PROT;
>>  		cf->data[2] = CAN_ERR_PROT_ACTIVE;
>> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
>> +		/* fall through */
> 
>    Again, we don;t need it here.
> 
>> +	case CAN_STATE_ERROR_WARNING:
>>  		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>>  		reg_ier = AT91_IRQ_ERRP;
>>  		break;

   Ignore me, I misread the code...

MBR, Sergei
