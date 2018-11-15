Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F2CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C73221582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 06:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q45hAbRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C73221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeKOQmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 11:42:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42296 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeKOQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 11:42:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so5101262pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 22:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NvMJl9YDQdnHkVHLq9pYzsUv3gChjJHG75uM9L790Jo=;
        b=Q45hAbRSNgIPZ1F5kjDu1feFUJGv7CmkVVzRkJaiUjIhFAJtP59J5xqM9UTe8lhls+
         /jsaRhv6wlJAUanfMkaqn8BZiDZ0WRAR1OdegVWM9eebcor+sxG8oF7wcBpATKKFbK6d
         u5dqKNLZn1wfxIap5zwKU3Qv0ta0cX+9nBqb02jIlxHPKFyJgLvhlQieAyBjzyY5hoaH
         IbSMDume/nkvz6yMKqKfQpkFML4p3+hyFcdBCriLqa/zphjUVWFn1x4xE8gRt7zHM5CV
         K47iJoaJU3vfDFUwOTMNQ5Ic7W7adjboyqbt5owR/K4hFnMop9n8OusuBCLgMuXYoJ87
         xitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NvMJl9YDQdnHkVHLq9pYzsUv3gChjJHG75uM9L790Jo=;
        b=tR8+w0kX3dZ1ANLadDOfVJE5XXMlnvuzIOLdLM7pWfyoeHd4vlfbKSg0RTN2sZufZu
         Av2G8p9lHXYYkcvP8Rv51LIMpuoUBQm1IZHVEP+yf1LwAW+Hm5CX2rYFHGq3ycuZOw+7
         R0rKfdtjLdUI719e64d5g7l/GmiNZwQLfCczO1+6sSEpZjL5kRpMxRrxk7BA54N1DyOz
         rq5bqptXRoEhcQ6ON0NqopLyMMMi9013tZFi1ZAYFMU6vIbKcJRBTurFSRwiUt1eTD4X
         +z0QOYArCg/klNaYL+dkFRC/dYSNrIZgzsb10kl/771eWDCAA9thtjoAPmweF2BqN7iE
         aa4A==
X-Gm-Message-State: AGRZ1gK4dEORXxNn6uuvQn+pN+/iPa1vf9LumsB3dEot76qZaXbC4Obn
        /YPGBqrtzpryyrq+az03wUc=
X-Google-Smtp-Source: AJdET5d3XR4q09hKRU6bOYlFT2jqjI7GHw5GH9IhnQN2waH+K92B/IDopEgMQhzHmSbejHc7G9DwGQ==
X-Received: by 2002:a62:6241:: with SMTP id w62-v6mr5124736pfb.69.1542263740270;
        Wed, 14 Nov 2018 22:35:40 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz. [122.58.176.92])
        by smtp.gmail.com with ESMTPSA id v191sm31818453pgb.77.2018.11.14.22.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 22:35:39 -0800 (PST)
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
To:     Finn Thain <fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
 <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
 <alpine.LNX.2.21.1811122002530.351@nippy.intranet>
 <fb617c67-089b-c4c0-2f47-28db41ffca6c@gmail.com>
 <alpine.LNX.2.21.1811131413210.362@nippy.intranet>
 <b824e485-796c-cbb6-9e50-504b03accd5d@gmail.com>
 <alpine.LNX.2.21.1811131700010.366@nippy.intranet>
 <0054c37f-ef34-e892-ff1d-02968ab529fa@gmail.com>
 <alpine.LNX.2.21.1811140905440.371@nippy.intranet>
 <73f75453-ce74-2c13-ba7c-f36f976d4ff7@gmail.com>
 <ab36d408-a05f-f220-1c2b-b88333f1c33b@gmail.com>
 <459ad559-99bd-0196-13f4-80440cd39671@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <9685f2d3-a492-29c3-a687-62a17e76b212@gmail.com>
Date:   Thu, 15 Nov 2018 19:35:31 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <459ad559-99bd-0196-13f4-80440cd39671@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn

Am 15.11.2018 um 12:54 schrieb Michael Schmitz:
>>> That one does appear to work - different versions of ARAnyM, and
>>> different userland versions though. I'll test that again with the setup
>>> that saw c606b5cf902 fail.
>>
>> Still fails on that emulator / userland.
>>
> Must be a quirk of ARAnyM 1.0.2 (or powerpc). With 0.9.15 on x86_64,
> it's fine.
>
> I'm sufficiently convinced to try this on actual hardware now.

Well, it sort of works - I've seen one login timeout on the console 
under load (less than 10 seconds after typing in the password), but most 
attempts went OK. Couldn't log in through SSH without increasing fatal: 
Timeout before authenticationthe LoginGraceTime parameter though.

I usually get reliable login using ssh key files with the default 
setting of 120 seconds (takes around 90 to 100 seconds to complete). 
With your patch, even increasing this to 4800 doesn't result in reliable 
login.

The error I see in the logs is 'fatal: Timeout before authentication'.

Cheers,

	Michael

