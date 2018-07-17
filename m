Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCC7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF0F2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC41j2yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF0F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbeGQU0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:26:39 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33993 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbeGQU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:26:38 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so913602ybq.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VnB5ThTWkQK9YOXrSJQqXXaqg9aJi8OcRcxgAUgbcCM=;
        b=EC41j2yoBLXj+i+rtprNnVE5MNM3hX7cAZTZ7LGrgbxRa6sVX3UP/15vjwA39cvvRe
         2aaawNx8h2BlRwuoyq2Gc3I0te5+DkVnzb9SxmgcNBGNJGe1kc9WHmDJFJom8+2H9nEh
         uVmp4zoRF+RQtqD2th03U191IRzsm9dKvNizmwds25el29W1U1rEJ+V5kPCYtASsVNGx
         4Mxlp9+GTdRsLuo6l7mDW8CwlbyEK82ZsEIEUxOT1n8QXNvzuHgt4gwbp8Qvr6Z5xTHt
         C8Ntw18LsIAETZ1RKLaLGrzSw1Ki4R0OJO2Z97GG7dENscR/EZz2X47NL7aOmK/4B1XG
         ts5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VnB5ThTWkQK9YOXrSJQqXXaqg9aJi8OcRcxgAUgbcCM=;
        b=jv9pvqLymQLDWYYevWfXbIEI/mdWvzEvmH+bFuWOEVp0DJFUsNohXK+Q735ZLPg7P0
         hhF2qni9h5E0GyYFLPg0oaEcGQrHLhjsMseBxaasgPvfyD20aVSX5bSKMjB4caLBrWiu
         NiKavuSpCBghJ6dMxzH2d/eFEDPtyti1IrgpujAfYefVbmsE3c816vcdcH1Egu4afzup
         8h6FN8DWXbY2APU+suXJUGTnbsG4nh/X269uRFJ0ymU9u24KirQZUWAlSkgTcGfeNhOe
         OQurQsIAyqaNKbWbcQqoejdSUKaPL/x2wusrhtzW+PsiHmtvVy3VhhUnMvlZ9qpTX+5b
         euCQ==
X-Gm-Message-State: AOUpUlFsc6EDXQ1o5I2THBwt44J87PQ4Qx20Kzq18g1ZWy8K7uAVGcez
        G9ac/DEWL3Ize6KHLBSkTJxR2W6TOGRQi7Sm9ic=
X-Google-Smtp-Source: AAOMgpcU/RIB6sPHCEIzSzo/uZkjJCYpmxAFiW7Nau8b8nUBAhSGwp52tYChCcdDUeRIbZx4ZmZ9jEemrlUnQIA8o30=
X-Received: by 2002:a25:69c2:: with SMTP id e185-v6mr1685342ybc.366.1531857148853;
 Tue, 17 Jul 2018 12:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:52:28
 -0700 (PDT)
In-Reply-To: <20180717101329.yl4hwob2jbjlp2uh@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717020926.176408-13-toddpoynor@gmail.com>
 <20180717101329.yl4hwob2jbjlp2uh@mwanda>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Tue, 17 Jul 2018 12:52:28 -0700
Message-ID: <CAO3upobJBYVz7Gh+Ghckh8mYbx9UpAG7xmCC2qcjsRb7em3eaA@mail.gmail.com>
Subject: Re: [PATCH 12/32] staging: gasket: gasket_wait_with_reschedule return
 when condition hit
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 3:13 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Jul 16, 2018 at 07:09:06PM -0700, Todd Poynor wrote:
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> Return right away instead of break out of while and then return.
>>
>
> You could remove the (retries == max_retries) condition since that's
> always true now and pull that code in one tab.  You could do it in one
> patch because they're closely related so it's One Thing [tm].

Ah yes, also removed the impossible-to-reach "return 0" at the end,
thanks -- Todd

>
> regads,
> dan carpenter
