Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B610EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D74C24581
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iDT+GI6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D74C24581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933856AbeGBL7G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:59:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37718 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933061AbeGBL7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:59:03 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so11633182itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m9535BQyrQbAOIUzmxsuUqQRjrPd9QU7DBbff/NlDEk=;
        b=iDT+GI6LLUvgmgedLT8pD8BNB0pD6unk53y7RUubnrBzLWBjHQ3G8SMGFk47a8pAsl
         qs6+aA43fHeiDtRy4xlPcuLvE7+5sa/1xoeFsJAn48q9rKXSOPaNgiNflpDa9udAvfeL
         rFGHGrSVxPZbqX5Ly7AQUghZyDedFcz+Qh6sS4Qvs9nhrFpV771gz5PHnHhCBMZRmsDB
         X6hOeV6S9tAwdNr3yHyCyKUdj7OShSVFEPPtxGC0GLkuqm8jfI87uj5bpalUzO0TL6jN
         bTI+9XBQygjBHjrCvsM6eJz+uRpkEzrAL1rOA9BQp6OchmWpsvAWIz6f0Ti+hegId/ls
         zptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m9535BQyrQbAOIUzmxsuUqQRjrPd9QU7DBbff/NlDEk=;
        b=MrYSNnDZXsaIdme6qNq61kNaoJX+AoKf9wAFpJYAicUyECVpGT2+OoTsX44PyvMKqb
         6P9fj6Qhr5bNAaK3oS8+G3sh4QQh2HP8aY0mt8oc6C2tNhs46QZ8S/FahreZ57rIJhTt
         SanmqSllBtY9I/QysmzZb8H7j56tQTtX19OP1JfjlKGLcBRbtv1CPO3iDnCpPFDK73xI
         jSfFPcUHtFDbmMSNTGNki3wdksiQjYUEcufhS+MQOBMuNSw4vJfTvUUH7HHo5VFhS3Pp
         eqnhfSttiggB3mLqN+pFIr9DywBgQq5aCD2uCuw+bu9RBJkBC0QiWQh4rDbiquhMo2dH
         HAow==
X-Gm-Message-State: APt69E1S3hovizQUf6uJdGFhBSKHM8I3ok4yBH9pEb/Ncuxy/o2jsdnT
        56W1C9Pk0B8au28SUNBnc9AV50JGeddQ5Ab84YuPeg==
X-Google-Smtp-Source: AAOMgpeWoCZXnV02mJCjLStbYy6aGw8eAvTl599/Bt5Bx/gDgxWB612yXk3yMHjDnpdTlNY+xiFJbJoJz8lohxD/I90=
X-Received: by 2002:a24:d80a:: with SMTP id b10-v6mr5601916itg.141.1530532742492;
 Mon, 02 Jul 2018 04:59:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5e:9402:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 04:59:02 -0700 (PDT)
In-Reply-To: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
References: <1530522740-2798-1-git-send-email-alanx.chiang@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 2 Jul 2018 13:59:02 +0200
Message-ID: <CAMRc=MfFH7EnyAXyBK+sssjyYoz9LhNDTkzWRsHBsPcDV7Ecig@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/2] Add a property in at24.c
To:     alanx.chiang@intel.com
Cc:     linux-i2c <linux-i2c@vger.kernel.org>, andy.yeh@intel.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        andriy.shevchenko@intel.com,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        tfiga@chromium.org, jcliang@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-02 11:12 GMT+02:00  <alanx.chiang@intel.com>:
> From: Alan Chiang <alanx.chiang@intel.com>
>
> This RESEND PATCH only adds the Acked-by and Reviewed-by,
> no other patch for the codes.
>

Please don't do this. We're waiting for Rob's Acked-by and I will
collect all the tags anyway. Don't resend unless there are changes to
patches.

Best regards,
Bartosz Golaszewski

> In at24.c, it uses 8-bit addressing by default. In this patch,
> add a property address-width that provides a flexible method to
> pass the information to the driver.
>
> Alan Chiang (2):
>   dt-bindings: at24: Add address-width property
>   eeprom: at24: Add support for address-width property
>
>  Documentation/devicetree/bindings/eeprom/at24.txt |  2 ++
>  drivers/misc/eeprom/at24.c                        | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> --
> 2.7.4
>
