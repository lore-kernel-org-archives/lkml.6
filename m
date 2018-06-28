Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D10DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C392C245DA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/B70h6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C392C245DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965304AbeF1Hn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:43:59 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:53557 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965261AbeF1Hn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:43:57 -0400
Received: by mail-wm0-f42.google.com with SMTP id b188-v6so2295612wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UuBuWvZk55ptloJwzBXIAby8hLFE+iUYbNZq776oz/c=;
        b=V/B70h6DX/Ft5jVnynqW2o7FS4lo1GvPGnh0dhfM9eO55iwNaxc28A+uBYkemAf716
         L1od4y2nlaCIMqLHUo/h/JJErC1Vc7Lel5PSkUnXnOP3CnNdDlI9lrtZ7R5nzEXHnMGP
         /v6k3qoyg9/j2tOohkoW/UfLd/G0XqQIOqKJGiOJ+OJvGhx4qoUkOp3LvBnhRVR9Q9jn
         0IEUm4mZ4y65wUUdkSNqw6wz3LBpTCht2U51feoeXrgmPCZnBwNcR43EdZH0Wz50UR8I
         kiWDhdpZDDCFNfLMHphBdQgHHdyCi4ApHHK0I0oA1lDjLr19qHm5hbPrlHbn0ZDkW2Bk
         IqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UuBuWvZk55ptloJwzBXIAby8hLFE+iUYbNZq776oz/c=;
        b=nJpPEZ1cE9z1QS60gRWISIHlOfDCbNboAcCqWTHCdqaVkaVl544YujhCJ9KX1hVXhl
         NM8hYRjnTj5WIOqQBYx83XgHlYF4hfUeYtvPNG4kFC2nc53d4Ac36suK7OeIIo2eITES
         6A7yv3B1eM3eAi+9kMB7KA0ghxGFi/yx5yCv3koSwrMskAJA7XHQj1jb0LFcELcS40ow
         Qw6tpGJ9lu6ZKYh9fFoPtfJh3ZLj05KmDmu0ynjrUut08F6EURjoCR0E4th/lTn9dttz
         E390XjQtU3epMNXGzezUt56kSUdWk29Pqs9dNHBOSCHLwOdQ+PU4iw+PpDA2T5JBswoO
         fjkw==
X-Gm-Message-State: APt69E09F/EHQK8P3ZgeaiboRdlfw2sukqacqgahdJjWep4wQjO6cnu4
        NukfEYu6uf9OweJmM8OlRKRetOAx
X-Google-Smtp-Source: AAOMgpd4trzPd6UpmW8CMoZT4bRDgOMFH/6L/Iidhwy1jF/dzcKNohOmvKf4Hh8je13XzfBL0Xnrcw==
X-Received: by 2002:a1c:30d7:: with SMTP id w206-v6mr6958209wmw.153.1530171836278;
        Thu, 28 Jun 2018 00:43:56 -0700 (PDT)
Received: from [192.168.1.4] (x4db2000a.dyn.telefonica.de. [77.178.0.10])
        by smtp.gmail.com with ESMTPSA id o17-v6sm5713346wrp.62.2018.06.28.00.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 00:43:55 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hadess@hadess.net, hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From:   Michael Straube <straube.linux@gmail.com>
Subject: staging: rtl8723bs: bug or pointless if else ?
Message-ID: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
Date:   Thu, 28 Jun 2018 09:43:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I stumbled upon the following if else construct in
drivers/staging/rtl8723bs/os_dep/sdio_intf.c:618

         if (pwrpriv->bInternalAutoSuspend)
         {
                 ret = rtw_resume_process(padapter);
         }
         else
         {
                 if (pwrpriv->wowlan_mode || pwrpriv->wowlan_ap_mode)
                 {
                         ret = rtw_resume_process(padapter);
                 }
                 else
                 {
                         ret = rtw_resume_process(padapter);
                 }
         }

It does not matter if the conditions are true or not,
ret is always set to:

ret = rtw_resume_process(padapter)

Is this a bug or is the if else construct just pointless?

Regards,
Michael
