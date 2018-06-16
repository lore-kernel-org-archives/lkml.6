Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40E3C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 10:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9052088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 10:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljQQhtiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9052088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeFPKU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 06:20:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52039 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeFPKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 06:20:55 -0400
Received: by mail-it0-f67.google.com with SMTP id n7-v6so6033457itn.1;
        Sat, 16 Jun 2018 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7wBx7MJhVKH343JWzin9CElWeViKp721UtG7MJhz7UY=;
        b=ljQQhtiyHLsGWHnMTPvIe9bpMmQatu+yaaaLu3aXuf82YD9jp7fHtXxOQUJTujBNIZ
         OfSgB1XniKBRNFaqTtB9XTJNKLFBHSKkKp5Tu+vCDaTziLUqFMR+wVEwVQKMeWyvBOIF
         pzUwCgBEO9q+r82W3UUWyLKTAB+2cfjQo+E3IH4+uwDjxIr6VdeDQi5q5aNjqbrTi+cu
         tuXhRpuIya8hb8f6fPGtUpm0gp3k7IZoNPY2ErRCixsIl1LEqCMnxhWIBoKo/IZsjh/o
         36K++BM6GbodeM//QMfFo66qluSYHFXBgefOtsvdELjzoKiqLlxxusLzW4bEFt13WfFn
         JyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7wBx7MJhVKH343JWzin9CElWeViKp721UtG7MJhz7UY=;
        b=JWwmnWpldjJiSxR4GlRxVxmlgmHGrx8sgSt+Lm3fTZiKiBPTiBE3qBD+KRHfyGw8/Q
         OnsA+/GxHlUmx9CjuUnHDrTWqAAN5KwU2ZimDNNV5MdlZM2+VbrdFKPd4H/ksR7iTxqZ
         27Zs2iivTvBrNtx04+fbWe4Q0Dsw1kj3ezkd+hZRukSh7H1Q80aBl77pgR0u/xqWEWGt
         RDZdmQopy+IfrfhYD9oq0FVnxatuzvH0WadRzhc5+AiUfJd5gj9meDHes+drVTugpWXm
         MYx5k4UrEpk+R802ef/lObaJ4S9R0jLsdpGeSNwxfJ8rMBo/2W1ce5yzKLpyxlfk1MDi
         vW6Q==
X-Gm-Message-State: APt69E28TndTrCsU/xwSaesQxNXEmmvsONx5Ndbw1mUXdal8q41g3V68
        WNcjncEb83f7QqdcIkSKbV9eOdpE7rvQfGK4/zY=
X-Google-Smtp-Source: ADUXVKI/LqgQn3ZZ255UDIFE0S/guVUbjW49XDhNpKgYPW6dA4HQwtVV9lGFOfgsH8JOiwCUzGtfniD7r3MjGfpymtU=
X-Received: by 2002:a24:f007:: with SMTP id s7-v6mr4326879ith.15.1529144454491;
 Sat, 16 Jun 2018 03:20:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c807:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 03:20:54
 -0700 (PDT)
In-Reply-To: <20180616090609.s5s4q2ri7e2x24oo@mwanda>
References: <2750553.3y1WJKmnP5@joonhwan-virtualbox> <20180616090609.s5s4q2ri7e2x24oo@mwanda>
From:   =?UTF-8?B?6rmA7KSA7ZmY?= <spilit464@gmail.com>
Date:   Sat, 16 Jun 2018 19:20:54 +0900
Message-ID: <CAO-p-6CXp1LNMciC2WsT4S-+oubh6SLYHs+4rfmQP9m88F12iA@mail.gmail.com>
Subject: Re: [PATCH] media: staging: atomisp: add a blank line after declarations
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     alan@linux.intel.com, sakari.ailus@linux.intel.com,
        mchehab@kernel.org, devel@driverdev.osuosl.org,
        Greg KH <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for attention :)

I knew what I forgot before doing contribute

I updated it 'TODAY' and I'll never repeat this mistake again!

Sincerely,
JoonHwan

2018-06-16 18:06 GMT+09:00 Dan Carpenter <dan.carpenter@oracle.com>:
> On Sat, Jun 16, 2018 at 01:30:48PM +0900, JoonHwan.Kim wrote:
>> @@ -1656,6 +1659,7 @@ static void atomisp_pause_buffer_event(struct atomisp_device *isp)
>>  /* invalidate. SW workaround for this is to set burst length */
>>  /* manually to 128 in case of 13MPx snapshot and to 1 otherwise. */
>>  static void atomisp_dma_burst_len_cfg(struct atomisp_sub_device *asd)
>> +
>>  {
>
> This isn't right.
>
> regards,
> dan carpenter
>
