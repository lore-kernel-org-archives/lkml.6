Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584ECC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9F720892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYcEaQi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9F720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeLFJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:19:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34960 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:19:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so22498588wrb.2;
        Thu, 06 Dec 2018 01:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=saQamXVIK+Euaf/h7+XQjCq0HygCncinysq+4JhiIDs=;
        b=HYcEaQi4rnh7PLOcckPKeyv63h/wkBuHIkN/f4rZkEwQtQ0eGCmFnUiE8XaWRGWr44
         V9c2AHW0VvfKNz0Aj7wIbkyJ66tMpmCiCIVc4on1PwYxfaoX1km5+OgpJyfNNUvRPILy
         oy2hkWKp6r5aqqkl6s0j2iJWpWw0iP9DNPgOwKeMfbw5lCnRSUElWUGNV/zr8mpPawxO
         695sigGT3E/xFELy28A+gB0lgnyXxPP2fFbxr5uZGSJW4JYX692DEEILSveO7nrYtTAu
         pBiOIWgWDFkio9UlMQiBuQ7x5T/ldDXbeEmvQlgtU/Voo1Xl9lH6JeGp6Z28VstpamvM
         JrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=saQamXVIK+Euaf/h7+XQjCq0HygCncinysq+4JhiIDs=;
        b=KfEWctlazWfUmaLvAgqe7cUCxyHC5YIUSuhBOe62uDJccmC7NamdXQAoJMw39jWNow
         h8TV51ODmbGr9C0vb3cMMIgACctQW+3a70ThJio5Do6nhumqjvYV15sC1Asasvn97NyB
         C5dqzWI40eGEX70z8UR+4IRwVPV7pfRuAE/BYRGeHvg+Gco1z48Lu/dk/tycWPyzxHaI
         k00ZzPE/El95CNisNiyaHJ+O5T9Qm4vqBbJImLGtzuN7laV9DmqIe7AWYL17qRH0Cwq8
         kLqRl8uToYrkqHsMaFyNrOguNE8sjq44rPyQdes/UJppwcaXwgV3AUkPAcg2C1s+Ai4+
         YkfQ==
X-Gm-Message-State: AA+aEWYa71i7Le3gkxvwDOZ1SulDNnqaoAvwZ7nyhuNR5PsmRljcOX/3
        hb87HtJVBSKjrmT9syRs0HU=
X-Google-Smtp-Source: AFSGD/WaRDjrZUggiQSw+3pIwY+KsN5ZSduogl7YDEPgnMdbkK29du/8KwtG9YDG0n/eCF79I+aEig==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr23727443wrg.230.1544087985140;
        Thu, 06 Dec 2018 01:19:45 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id e16sm22036291wrn.72.2018.12.06.01.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:19:44 -0800 (PST)
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdWEiOTSSM=rKu67r-kgJ=TyAi7p7ndhAS4d5-6gccmmoQ@mail.gmail.com>
 <OFE69673FB.D4270C56-ON4825835B.001C7201-4825835B.00209DC7@mxic.com.tw>
 <2c6c23fc-299a-f64d-c81f-4b4123f1577b@gmail.com>
 <OF62002C8B.5D0A4315-ON4825835B.0031F545-4825835B.003310A3@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c7fe7eb3-b13d-2e90-12de-3edeadd9d5b0@gmail.com>
Date:   Thu, 6 Dec 2018 10:19:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OF62002C8B.5D0A4315-ON4825835B.0031F545-4825835B.003310A3@mxic.com.tw>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 10:17 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> >> > +
>> >> > +       pm_runtime_enable(&pdev->dev);
>> >> > +       master->auto_runtime_pm = true;
>> >> > +
>> >> > +       master->num_chipselect = 1;
>> >> > +       master->mem_ops = &rpc_spi_mem_ops;
>> >> > +       master->transfer_one_message = rpc_spi_transfer_one_message;
>> >>
>> >> Is there any reason you cannot use the standard
>> >> spi_transfer_one_message, i.e. provide spi_controller.transfer_one()
>> >> instead of spi_controller.transfer_one_message()?
>> >>
>> >
>> > It seems there is a RPC HW restriction in CS# pin control.
>> > Therefore, it can't send the 1'st spi-transfer for command and then
>> > keeping CS# pin goes low for the 2'nd spi-transfer for address/data and
>> > so on.
>>
>> Isn't register DRCR bit SSLN/SSLE exactly for this purpose ?
>>
> 
> DRCR is for RPC module works in external space read mode, using memcpy( ).
> It is not for _spi_sync().
> 
> I only could use manual I/O mode by SMCR@bit-8 SSLKP and I found it has
> some
> restrictions in manual I/O mode to control CS# pin.

What restrictions are those ? I am aware of some, maybe there is more.

-- 
Best regards,
Marek Vasut
