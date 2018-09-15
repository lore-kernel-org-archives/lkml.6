Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E855ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0F720881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEdBYRzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0F720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeIPCNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:13:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43398 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:13:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so5903787pgb.10;
        Sat, 15 Sep 2018 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8d7DdMHaY+JIB6dLgDWgthN97lovs8WbYr+KSH/rTjU=;
        b=XEdBYRzyAqyLlcWCL8UPpsgKt57ZeP9h4lmQtuSdIeISPDfshP+1zQS3P04H9F8vV8
         KUXcqXIUkxCgIIBonhAp0NR5YxIiHA1pv+Nmp5jnRBhiiQ89OOUULcO/JRtmpc7nJu+E
         G+1cDtBUWf0PdmRollNok5Vs2HBy7QMaqbGWm0NAZv9Frh2WbGc5XbgnFigQ7cdrXJa6
         Jp6rOjg0Jlqev8MWPWHqQ49XoI9Yo++3EOC23L/HZJvi4dc26NmyrtDvgw4B2P4ke9Jz
         01kTlEKetDB6mN0xEKwwdyvu7URwRW9Ts+qAsczk13ApeU1IPqSwqfCDOi2fOxnEx4WR
         wMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8d7DdMHaY+JIB6dLgDWgthN97lovs8WbYr+KSH/rTjU=;
        b=ExAkPhR5/iaz7qTckt8IhfVhA4Hhqfkoj2paknZMIqegEoqgjmoQcnhyWhKMyDxfy9
         Gas7wuKPtcGOZfZa+vtuU1DLKwO5qYnVfi/s0zZSRJt5MopFjMiosSui6O1DV1b16K/T
         wIFgacB8XKtLdZW0E+26aHBT4VQsnzWYZxzo+awsskEKpd8KB0POg1eSywHEfR24Xsuw
         pTM64nuRl5W6IuT4kzuocaKUeuV3VdQZy0zxyxjW6vqqRnuuajTvw7A8tRvB0erhuBjA
         5dnIlUYqAGa6L8DiOeaOLmcot68M/RUDBKAX0tVY9+JSVHhKwF1GIlEMCmcRohLqT6OQ
         0vKw==
X-Gm-Message-State: APzg51DRQxGY5fbCnOx5jK8WuO99im7Tp2vS28zeTcF7no+9XhKJL0kL
        7sEJVn8h8ZbASF2V/CE1N6w=
X-Google-Smtp-Source: ANB0VdYC1X/Dz5jo6697dgLAZSrtLpMISOZHjeOqWFtMX10ZBC0jlsPajhUg+JM3v8OkmAn+zU1xoQ==
X-Received: by 2002:a62:5ec3:: with SMTP id s186-v6mr18919064pfb.146.1537044806104;
        Sat, 15 Sep 2018 13:53:26 -0700 (PDT)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id g5-v6sm17983843pfc.77.2018.09.15.13.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 13:53:25 -0700 (PDT)
Subject: Re: [PATCH net-next 4/5] net: phy: mscc: shorten `x != 0` condition
 to `x`
To:     Quentin Schulz <quentin.schulz@bootlin.com>, davem@davemloft.net,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <2efac3971c41837fec6001018c1275d81286512a.1536913944.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2fc9965a-9f06-5008-8209-bfd1450110cd@gmail.com>
Date:   Sat, 15 Sep 2018 13:53:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2efac3971c41837fec6001018c1275d81286512a.1536913944.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2018 1:33 AM, Quentin Schulz wrote:
> `if (x != 0)` is basically a more verbose version of `if (x)` so let's
> use the latter so it's consistent throughout the whole driver.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
