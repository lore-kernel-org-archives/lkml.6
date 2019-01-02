Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20586C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44AD218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFoaJuam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfABTBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:01:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40915 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfABTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:01:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so21618657lfe.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w3dVlr9MSmGQk4pvLF050kkN3SdqBcTKyKlCYapPKew=;
        b=JFoaJuamyDJGoBYCvB2+QFNl80auPjsCZYZDk6ronXoc1jbHU4iacFZPM1kZ5UGcZ4
         fDHEJx/MJPDF+tNmVKE/8Sw3RyNhcc9v3Nesf5AZMs47JzcbwefP1pdvyRS+b19NPt0S
         8zg8sQS2RDlyoy5dsRc4l2JEzEckvyQ5XzsE2QAVEVs8/Mz6Qt2uAmg/YhgK2f492xPM
         JFUBjyeF4S/dgh7zjt4xkmHPiZff4B6nJqVwz6DTtLjZeHuirU+X+NJdwvGMka7zii40
         2ndW7XXZ5acqi8LenFGNYfl+bb3jxRzQDRcjX4rzyON6aulcdB0WOODBLZRYv+dBkX6d
         u4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w3dVlr9MSmGQk4pvLF050kkN3SdqBcTKyKlCYapPKew=;
        b=cnL9wIDCeDAqFOfyge2yR8IW2mouBTw/dUsriZ4Z1nn832UF6zuZ/L3paNUzvztD6W
         hobi33wdft5x6kGEsqLHHL1uOGmSBLrTg7xWHZ/CTCwWhiq9IBsdnAQWrOx078J1/mpy
         v6uLw9Ahb0CSbhdmgu8V4fgFB/FhR5XyiXbNKmHWe9/M3GBfI58sadJmygPTNANBLNM0
         eoUeXXBxpx3Giwp1pAd1aI2dQb5zL+zLomqBdcO84GvYdiHwnImhqq52GUhvWwGCRCR7
         bjz+FPRpy9BWzzy9DhjHky9z8vklyCyzfYt2ImWnCHnjFdiAvB7hkDfduBUn2vZ57sDW
         pfdA==
X-Gm-Message-State: AJcUukfUTJJv+OtFCZV5NiB0XyBdVbI9FBOXc3020wxH267rPxSco2rx
        L9LHZqPkVs/4tCM8jK4ktEEnOdHo
X-Google-Smtp-Source: ALg8bN6c5FzpnZ+WqYD8c0I5FF7DyRQl/ROiuc+8P95c7Jm7nwgqeelMpVoEg5oKYpgwktlQZuXKHQ==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr13205067lfa.40.1546455688560;
        Wed, 02 Jan 2019 11:01:28 -0800 (PST)
Received: from [192.168.0.160] (ppp89-110-27-163.pppoe.avangarddsl.ru. [89.110.27.163])
        by smtp.gmail.com with ESMTPSA id y9sm10425638lfe.75.2019.01.02.11.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:01:27 -0800 (PST)
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
 <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
 <4dd17d38-8c4d-b5db-1091-edba0d95cadf@gmail.com>
 <99d2e692-6a6b-b880-c8c2-99944f8a5f52@lwfinger.net>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <0acf4a76-c5e2-9a5f-bc57-04794b515107@gmail.com>
Date:   Wed, 2 Jan 2019 22:03:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <99d2e692-6a6b-b880-c8c2-99944f8a5f52@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/19 12:38 AM, Larry Finger wrote:
> On 1/1/19 3:02 AM, Ivan Safonov wrote:
>> I suggested a patch for loading modules from interruptible mode, but 
>> this patch remained unclaimed ( 
>> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124851.html 
>> ).
>>
>> For some reason I thought that this patch had been removed and did not 
>> track the fate of this code ( 
>> http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124573.html 
>> ).
> 
> That patch was quite extensive, but had only a minimal commit message. 
> I'm surprised that it did not get a bad review, but I can see why it was 
> ignored.
>  > Where did you submit that patch? It certainly was never in my mailbox.

I send patches to emails from get_maintainer.pl list:

ivan@alpha ~/source/kernels/staging $ git format-patch 
515ce733e86ee2e1bea4dba76d2d4491013d0f73^..515ce733e86ee2e1bea4dba76d2d4491013d0f73 
-o /tmp/

/tmp/0001-staging-r8188eu-Use-lib80211-to-encrypt-CCMP-tx-fram.patch

ivan@alpha ~/source/kernels/staging $ ./scripts/get_maintainer.pl 
/tmp/0001-staging-r8188eu-Use-lib80211-to-encrypt-CCMP-tx-fram.patch

Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING 
SUBSYSTEM,commit_signer:16/16=100%,authored:1/16=6%,added_lines:345/1450=24%)
Ivan Safonov <insafonov@gmail.com> 
(commit_signer:7/16=44%,authored:6/16=38%,added_lines:337/1450=23%,removed_lines:1380/1605=86%)
Michael Straube <straube.linux@gmail.com> 
(commit_signer:6/16=38%,authored:6/16=38%,added_lines:715/1450=49%,removed_lines:92/1605=6%)
Santha Meena Ramamoorthy <santhameena13@gmail.com> 
(commit_signer:2/16=12%,authored:2/16=12%)
Dan Carpenter <dan.carpenter@oracle.com> (commit_signer:1/16=6%)
Hans de Goede <hdegoede@redhat.com> (authored:1/16=6%)
devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

There is no your email.

> 
> Larry


