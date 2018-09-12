Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FAF20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/BX0t6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FAF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeILXbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:31:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42677 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeILXbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:31:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so1471933pgp.9;
        Wed, 12 Sep 2018 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CthXnu/unP6udl2RM+6fWMsl0VBqFHKM/1p/LS9pG6Q=;
        b=W/BX0t6MSQqTSsdyVf8QMcrSQ+QcjTnI61rdQo10v+wE4KAMvR5CHmyJECTjyQa8n0
         v+WF40wb8xo41bvQBH1WiwvhFgbBVmX5daUf2ymQBgUUnhIbDQjzel72hHhtHn5MVyv4
         36AE7TZ0WAPM8qd94pU/9zqGGlh6nvXlnPDInF/bU6jaVD9VWiB3Hr0qQrY2rUqwEkYj
         BNWByAam5eBlva+Prr5GA+kqpF2i6z61ukmqT+yzCgl55sErgNEX1zFg2HNoFil+HUb6
         r5VdgIkSmjXDN8Gaq5nKFop0LAFAx6C1FpuM7I8dIJOT+I1Jf7lo4OdmBGamdp783wxH
         vZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CthXnu/unP6udl2RM+6fWMsl0VBqFHKM/1p/LS9pG6Q=;
        b=c2kUIo1UwnX8Xbdqu6ga+lUH7+EDNQ9BCGeV7ZowkQJ636yqcq3lozEyRnfOW3SWib
         esdp+lPVCNA3Q/Uq/TJXrelXOKWN3EUrhSHV3KIkNyibyX4Y6ln2lrpAQQaVKIwlfVrw
         r7P3XWrOxTL6g+8IcYZ98S6SZMNU4hH5WzS3pJRb9AQ9xlKY0I7DNbZNFdXbIH23RwYL
         gMk7YGpS1cClxvzqB82zRAINcHIO/Ck/HOx/XxHctgv2IthrZ5DwMJMZuo0/18/6i1Gl
         pmslqsH2iFb2B9UgJAv3J7VQsh707XWuNY0/n+PKWMinMALu9vm4bJdhrcDQdNM8cR/y
         0aPg==
X-Gm-Message-State: APzg51Bds6Yz7yvOQ3OuJIQIaaqdFLxA/G8+cZ2shRxzVotg8C2fPPkZ
        CrLGAQiFCBhZBsa80XFFrb7zPUXKT3I=
X-Google-Smtp-Source: ANB0VdbqZsFqP093bMWCBP/yZCnMf5HDf6ajYrP8xIyrqly8BqTkqFX4P69a/Zz0bxySIjuQN18g+g==
X-Received: by 2002:a63:69c3:: with SMTP id e186-v6mr2803772pgc.431.1536776747774;
        Wed, 12 Sep 2018 11:25:47 -0700 (PDT)
Received: from [192.168.1.5] ([119.42.83.160])
        by smtp.googlemail.com with ESMTPSA id w13-v6sm2081515pgs.89.2018.09.12.11.25.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 11:25:47 -0700 (PDT)
Subject: Re: [PATCH] option: Improve Quectel EP06 detection
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180908125754.1947-1-kristian.evensen@gmail.com>
 <20180910103022.GR1089@localhost>
 <CAKfDRXiVbE3-eteTCZjEqyR0LaLMpN8t4P_ihzHPChse9=FxmQ@mail.gmail.com>
 <8ce10eef-f332-a1c0-e16e-fb1c2055131a@gmail.com>
 <CAKfDRXgTL6L27JLbbOLLsXd9KK8vBtVCjrTNpv6R_MYCJoZqPg@mail.gmail.com>
 <de1b5aa3-d9d6-da49-7e49-553694f5b666@gmail.com>
 <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <f2c15eef-ed8d-12c0-2ba4-3dc068ca9fd4@gmail.com>
Date:   Thu, 13 Sep 2018 01:25:43 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfDRXi3QdB0qCvqHPFXpxdpiHSJ2WoSqZGgjD3gEzAaPbBPUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2018 23:57, Kristian Evensen wrote:
> On Wed, Sep 12, 2018 at 6:32 PM Lars Melin <larsm17@gmail.com> wrote:
>> You have chosen a platform which has limited usb resources and want to
>> solve that problem by adjusting the device driver?
> 
> No, you asked for a good reason for why disabling and not just
> ignoring an interface makes sense, and I think that supporting
> multiple EP06 on platforms with limited endpoints qualifies as a
> reason. My motivation behind this patch and modifying the driver, is
> to make the driver work with the different options/combinations
> supported by the modem. The platforms I am working on merely triggered
> the error and inspired the change.
> 
>> Why don't you just unbind those interfaces which you are not using and
>> which are eating up your usb resources?
> 
> As far as I know, unbinding interfaces from the driver does not free
> up the memory allocated to the interface by/on the USB controller. I
> also tried, just in case, and the output from lsusb is the same
> regardless of bind/unbind.
> 
> Btw, the patch for the QMI driver has been accepted, since you
> mentioned that driver earlier. So the assumption about interface four
> is removed from there.
> 
> BR,
> Kristian
> 

That the patch has qmi-wwan patch has been accepted does not change the 
fact that you are solving your problems in the wrong end.
You are using the OEM re-branding AT cmd to change the interface 
composition without changing the vid and pid at the same time, this is a 
big donut and the whole reason for why you have submitted patches which 
shouldn't be needed.


rgds
/Lars


