Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19613C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BF620871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V621t4L7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gxTeyN/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BF620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbeFTD7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:59:30 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34491 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754338AbeFTD70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:59:26 -0400
Received: by mail-qt0-f196.google.com with SMTP id d3-v6so1864707qto.1;
        Tue, 19 Jun 2018 20:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YJcuQi4abNC5G8aMScx8jrToPc3zwhMm/0ZyoxVbevo=;
        b=V621t4L7MqN1wv85jc1qYGHoXF8qDGfF5LoGNdHXfNQuvVQyC7GMgHOIj9fxJWNNBd
         kZeNMaQdn0Vs9Mjc5ockbI68CuNuIb6tLcTIdsIFA7slcScAbJxvD1gpm5u689DN5S7S
         Rl3W57xhnBfV2TQ1dwjIwdT08Wn5R+INRv7ZIUkdIXJyMN3nGatk1qa30BlGzMOtnAnz
         xwTsdIlbT0LXXKfEXdPlsGgWinW9un/+Rhwi+ehXHGox4kqwR80errD4zerN7z7yZama
         /ZT/hh19zZUzm2zA0PZcUZgWuiDSBsmdgQwe//Rl9hvC317FQQxen/NicPlNZmI+G766
         R/fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YJcuQi4abNC5G8aMScx8jrToPc3zwhMm/0ZyoxVbevo=;
        b=gxTeyN/52nx70cqIkUn6Jz4FjuLEaethpJyZCdg0VvKMDRKi824vzxpaFQEgnlwzgI
         LUPThSzbugIO3AT89GigJcvi0Ybm03i0rwP2fzx3QbouGaEhNuwTlH87oyq2N3gAgmgy
         6mM73Lek8+cQXKJ7sALmKBcKYudmaOzjBh11E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YJcuQi4abNC5G8aMScx8jrToPc3zwhMm/0ZyoxVbevo=;
        b=VfezC3FlIQ0lMUjuMVyuDIMfKyUbNg0I5IiSFvqZ7qdrJHQMfbKuXaGX3NGm51cMSt
         BPVqhL+sqnnndtYT9dIq94+ZgZFXmqKYCTl5PCJN6e/g4n3X2+tMumXz9DcK2VdRdCCp
         FXYGc/vNbcFitHAr2rXr77t4U4NFJ1HyT2kmh5OzroPZ5Rq9ukuIyY142W1pleuDyH+s
         TQa/9Xf5oPvioYFGWCn9E9Sz0smKI8nzbzwpLaSfrp1qcudSv1GYyMwFabVWrCMsG0Io
         qySH1TLdm6dlf8IuL65Rkp7dlNFW3nEzzmZJ+//TfpAWtKlV6Hv3jZ7n4y4qIhJspuhK
         MlNg==
X-Gm-Message-State: APt69E1AwxnvAe1Gh24WjOYSx/45KKsX71mgXaZ9timFX9B2YtfjHziE
        YUME5Ph0LILONkYnZSM6VaOyLBcP8fdKTNes+hY=
X-Google-Smtp-Source: ADUXVKIEuzz3RwSPsKVkCNOO6vmGwui+dobQ82lssX80M9PQqQpg3IvDMVnmWAaf/QTJXIiRQgi4mu8bHFf9Jypc3sA=
X-Received: by 2002:ac8:32fa:: with SMTP id a55-v6mr17889896qtb.342.1529467165270;
 Tue, 19 Jun 2018 20:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:184d:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 20:59:04
 -0700 (PDT)
In-Reply-To: <5d1f980286e2bba566421ebb29721770303fcf09.camel@kernel.crashing.org>
References: <1528918579-27602-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1528918579-27602-4-git-send-email-eajames@linux.vnet.ibm.com> <5d1f980286e2bba566421ebb29721770303fcf09.camel@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 20 Jun 2018 13:29:04 +0930
X-Google-Sender-Auth: FEhkBiOVzQ6W1ZtatI-Xp9Pxydc
Message-ID: <CACPK8XdQvRcS+n33BT=Fwm4OoMfck5B3NX=QKJc0HgoqMjwXTg@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] i2c: fsi: Add port structures
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 June 2018 at 13:04, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2018-06-13 at 14:36 -0500, Eddie James wrote:
>>  }
>>
>> +static int fsi_i2c_remove(struct device *dev)
>> +{
>> +       struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
>> +       struct fsi_i2c_port *port;
>> +
>> +       list_for_each_entry(port, &i2c->ports, list) {
>> +               i2c_del_adapter(&port->adapter);
>> +               kfree(port);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>
> This is a use-after-free, the list linkage of the freed port is used to
> get to the next one. With memory poisoning, kbooom !
>
> You can fold that in:
>
> From f9d9092160897e7308f6990067a03e937339537f Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 20 Jun 2018 13:27:32 +1000
> Subject: [PATCH] i2c: fsi: Fix use after free

This fixes the issue I was seeing. For the series:

Tested-by: Joel Stanley <joel@jms.id.au>

Thanks,

Joel


>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/i2c/busses/i2c-fsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index 713959b44403..ff69ab6aa79a 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -696,9 +696,10 @@ static int fsi_i2c_probe(struct device *dev)
>  static int fsi_i2c_remove(struct device *dev)
>  {
>         struct fsi_i2c_master *i2c = dev_get_drvdata(dev);
> -       struct fsi_i2c_port *port;
> +       struct fsi_i2c_port *port, *tmp;
>
> -       list_for_each_entry(port, &i2c->ports, list) {
> +       list_for_each_entry_safe(port,tmp, &i2c->ports, list) {
> +               list_del(&port->list);
>                 i2c_del_adapter(&port->adapter);
>                 kfree(port);
>         }
>
