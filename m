Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB12C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083F208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5083F208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934934AbeF1IWq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:22:46 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35917 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbeF1IWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:22:43 -0400
Received: by mail-ed1-f41.google.com with SMTP id t3-v6so4636123eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 01:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XEOrutFaA4HB9cXrpDj9HGheu1QRTa2sf8MQSGDerpo=;
        b=eIX5CrPRWUY0//zHklR6HoJ9V/jmeluC8Fb/xWHIfN5I9pxZvkME3j8s33cqCi5CAn
         ZW/cCdA+GWMIIk+sOvdaJsGvf3W3zB68S9ldQ5MgEk7XGeZf6QA7VAU44J2WuawBUZgi
         7Ux80IdjaBAqTw7ue1PVG9ZrMaSLLttnF4ibSG/8RIiB5gLq5EeCOHSs866dBSKpbySv
         hgvaTF62RSYcEFxKQ5oAgKVy3O2eoXjEaFopQV8tHEQBzR1di2MhQS7b+dkWwenIvp7e
         LxvxQKAP/Ryg0hrxita530UjKKJTkt4pNHQHJUm9hPxW55/us4yuI7YnAiN37LlkE/iE
         Yswg==
X-Gm-Message-State: APt69E3aZCT44mDZB3iEU1v6WBThKIFU7ShY/NKNrhYJegAcHsbpkWG0
        ETWrL281cPy1V437zqJtfyhu4Fu3jzU=
X-Google-Smtp-Source: AAOMgpfTj/3VDS3X3XRdln1EzKH/1H4kTpKZlwxw/O4QU506JslCxS7Ja2OH0P47onueQsbxHrJ+NA==
X-Received: by 2002:a50:98e4:: with SMTP id j91-v6mr8480225edb.212.1530174162405;
        Thu, 28 Jun 2018 01:22:42 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b15-v6sm2274903edt.42.2018.06.28.01.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 01:22:41 -0700 (PDT)
Subject: Re: staging: rtl8723bs: bug or pointless if else ?
To:     Michael Straube <straube.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hadess@hadess.net, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9b1993c2-0b81-35cd-fe27-293f9e8f45c6@redhat.com>
Date:   Thu, 28 Jun 2018 10:22:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <473d9997-8c30-a3f3-85b6-076decc7a7c2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28-06-18 09:43, Michael Straube wrote:
> Hi,
> 
> I stumbled upon the following if else construct in
> drivers/staging/rtl8723bs/os_dep/sdio_intf.c:618
> 
>          if (pwrpriv->bInternalAutoSuspend)
>          {
>                  ret = rtw_resume_process(padapter);
>          }
>          else
>          {
>                  if (pwrpriv->wowlan_mode || pwrpriv->wowlan_ap_mode)
>                  {
>                          ret = rtw_resume_process(padapter);
>                  }
>                  else
>                  {
>                          ret = rtw_resume_process(padapter);
>                  }
>          }
> 
> It does not matter if the conditions are true or not,
> ret is always set to:
> 
> ret = rtw_resume_process(padapter)
> 
> Is this a bug or is the if else construct just pointless?

It probably is just pointless, my guess would be that once
upon a time there was a difference in the paths and at some
point that difference went away.

Regards,

Hans

