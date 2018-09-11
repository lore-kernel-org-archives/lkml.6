Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7B6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8199020865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b03ZRrVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8199020865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeILACW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:02:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40871 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeILACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:02:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so27160804wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pOEz3YCpBF4es40EnskT2fs92EV9eThzXBPtZO45d6c=;
        b=b03ZRrVRosAaxDrz8HTk3s93U56cmZYVc4xOs9C92ctr2m7Soi30RVtiCbvD43Gem+
         8fExF9AjTqD+0nigxKeSwGKQn7q0ufpJKPJFvO7f50YeMr98RKKZTFLaGQV6CJ8VXu2C
         /pekDxkgKyl/CJ5v+eDRJrBlg/99EzW+kEKQEaCfcdMKIX+u018aRBMcX2b9ZOuY5J6j
         D8VENsA08Uu0zTMtNc0mtJmGcB2s3q22JkRtoDKZEEgaWyQexrBgOUICAeg26VUZLq6i
         I7QuCTdst9otp05qmXkI28Hu+UfoXsidZCVAnhNBDmK/D2HPptfFNFH0lFHLadoo9/uT
         BBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pOEz3YCpBF4es40EnskT2fs92EV9eThzXBPtZO45d6c=;
        b=O2Mp7bMovdZoa/s8aYUWzYY3hKCDbycMPb6Z4JkArcNLDlElyjs0KgMGoS2u/6iX/1
         9DAenWdLNUpfzSN4wNFr3/prZQNxRCGpvJnWodcvMsOxHFrOC/djv2oogO8biUl/fjc7
         qa5g2WPpCC2g8ORZ3LmSsSn/YsoXskzPy2JIurWnGQiasBoHdKC5Oe7F7/BYs+rM1wt5
         E5hh1F30k9Rjk7hDkrMZn/6hFhlcJtxup2aKVqGqcpTyH0eQjuwSUz3FVRVP9Hyiunl9
         CqVBUqbiHH6BYwNr86zSZyc/ob1CWCkmp2IZR4czJU0ENbKPOiNOZ+kdmkUF/npPbynb
         NSnQ==
X-Gm-Message-State: APzg51DO+xSLQISgu/ksbqUzCNZJcdogowH0JO9lMSMLXwdEF4xXR0Ua
        rfCzVO6xAN2RkYdVZA0MOl45Vba+
X-Google-Smtp-Source: ANB0VdYEf1Ey0/VNpUvdtsmWW7lPiDxRBHxzi6fk4B1X0Mfo0nXGmxeX7a3W5nyC0/3s0WCoWkzT9A==
X-Received: by 2002:a5d:50cf:: with SMTP id f15-v6mr20557437wrt.128.1536692500146;
        Tue, 11 Sep 2018 12:01:40 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t9-v6sm42566968wra.91.2018.09.11.12.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 12:01:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: parse SFDP Sector Map Parameter
 Table
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        cyrille.pitchen@microchip.com, nicolas.ferre@microchip.com,
        Cristian.Birsan@microchip.com
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-3-tudor.ambarus@microchip.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <dbfc2491-5fd8-eec9-650f-183c63f9963b@gmail.com>
Date:   Tue, 11 Sep 2018 20:56:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180911154007.17195-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 05:40 PM, Tudor Ambarus wrote:
> Add support for the SFDP (JESD216B) Sector Map Parameter Table. This
> table is optional, but when available, we parse it to identify the
> location and size of sectors within the main data array of the
> flash memory device and to identify which Erase Types are supported by
> each sector.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Marek Vasut <marek.vasut@gmail.com>


-- 
Best regards,
Marek Vasut
