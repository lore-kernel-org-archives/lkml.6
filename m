Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42217C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0385E2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 01:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTemtdZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbeL1BOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 20:14:18 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42368 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeL1BOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 20:14:17 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so17591456otk.9;
        Thu, 27 Dec 2018 17:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:openpgp:autocrypt:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P7SkxbNBrJXSSAGkSLTcHk57+7B8IVojDiOXduukeu4=;
        b=NTemtdZtvNmvTHCR+ApuaX8VJXOqgm34154fv3afJ5t0xvp9H1uaqjO626aZz8+Edq
         APtfXA+LYcpF9nVunaOA+3mYxylBcd9S1wlwvsECqd2awlO1E5I2NgcFo4gv19PkFV/U
         TGCW/hKYsnQXFMa1qWTk/0ZT6FK0e1TIOouOCR6slMx+eg4cVNm/q0NH5Hj6dSLC7OXQ
         ode6iYPyl+cbRXu+nva5ZAdb0M0H/E7iLEYKJIrgp6t7HJRhdeNAUJIsoY7VvhiUWGEw
         BiHZ5M4m/dLYyMSuG2B6hF2Q37/FSuu+D0Vw4qYBYmatNnNg7VqRmQhx1mrLQZn4bCv1
         YaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:openpgp:autocrypt:cc:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P7SkxbNBrJXSSAGkSLTcHk57+7B8IVojDiOXduukeu4=;
        b=AZ+TqNsIu3BJyw+xN+F2SdhElufJQuKWohwz2gjhC6AmLvaqu3GzA0SbzkCZN7BB4I
         oWrbd2RYe+0JjRBthP3/S4CXOAK0FYORkFncB+ClSclDjHmc6DbjLSW7bEwQ5DEdOBRO
         M7MrWp7uLiSDUWUvFbbdMZqjCb2sMRXWO+ZAbtcGksjzTdgRdDUcqD9899yAivE9eHro
         1hp+En4GjekAyncYXrJt2FuOQZezXYwiVzf+mUfZLxVFZ8Z8HMokbOyC7Wc8RfWdzwFK
         27fKLjqx2od4biqts7++YTm+MUqrlMUwYt+poFXLZ70n2dB+53qoJFeAOPTLP3nyMz37
         eDeg==
X-Gm-Message-State: AJcUukdahnPtkVSlPNodSNGtNVSqWBlqcSeUIj5AHWh3DfTjMVPzu/OH
        NK69hK2leKxNavpdmWvh9ss=
X-Google-Smtp-Source: ALg8bN4qari3jPKeDvA/cToVQsvaek88QLEfP6aT0hQNmQvYqrLI1zZVuUWQNuZmyQQ5yfxIEPu3gQ==
X-Received: by 2002:a05:6830:d:: with SMTP id c13mr18487066otp.82.1545959655496;
        Thu, 27 Dec 2018 17:14:15 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id i12sm21094950otc.48.2018.12.27.17.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 17:14:14 -0800 (PST)
To:     Stefano Cappa <stefano.cappa.ks89@gmail.com>, fugang.duan@nxp.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAKRytNzMHS-wN2_xSncf=a1Bgd=PVBV_GKHJw4tw1gc=_fkeNw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: iMX6 FEC driver Linux-fslc 4.17 - IPV6 Multicast not working when
 unplugging/plugging ethernet cable
Message-ID: <dcf7621e-d7be-98bd-fbf7-9e0abf3ffc2e@gmail.com>
Date:   Thu, 27 Dec 2018 17:14:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKRytNzMHS-wN2_xSncf=a1Bgd=PVBV_GKHJw4tw1gc=_fkeNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/27/18 à 6:21 AM, Stefano Cappa a écrit :
> Hi everyone,
> I already posted this in NXP forum as a comment
> (https://community.nxp.com/thread/359397), in yocto mailing list
> (https://lists.yoctoproject.org/pipermail/yocto/2018-December/043664.html)
> and in meta-freescale mailing list
> (https://lists.yoctoproject.org/pipermail/meta-freescale/2018-December/023625.html)
> A user in meta-freescale's mailing list suggested to resend this
> message to the emails obtained running "./scripts/get_maintainer.pl -F
> drivers/net/ethernet/freescale/fec_main.c".
> 
> 
> The problem is:
> 
> If I boot my iMX6 device with ethernet cable attached and I execute "ping6
> ff02::fb" to ping the multicast address I get this response:
> ~# ping6 ff02::fb
> PING ff02::fb (ff02::fb): 56 data bytes
> 64 bytes from fe80::c2f:eff:fe11:2d71: seq=0 ttl=64 time=2.057 ms
> 64 bytes from fe80::809:1bfb:8d4c:ae54: seq=0 ttl=64 time=73.101 ms (DUP!)
> 64 bytes from fe80::3e28:6dff:feed:5b97: seq=0 ttl=64 time=150.772 ms
> (DUP!)
> 
> 
> Otherwise, If I unplug and plug again ethernet cable, I cannot ping the
> multicast ipv6 address anymore.
> The result is:
> ~# ping6 ff02::fb
> PING ff02::fb (ff02::fb): 56 data bytes
> ping6: sendto: Network is unreachable
> 
> 
> The original NXP discussion was about older version of Linux, however
> this issue is happening with both Linux 4.9.88 and Linux 4.17.
> Probably also with the latest version, but I didn't try.
> 
> 
> Do you have any suggestions? Is this a bug? This is really a
> frustrating and I'm really
> surprised to see the same problem also on Linux 4.17.

All multicast filter programming would occur from within the
set_multicast_list() function. At first glance, there are several things
that could be wrong:

- hash is only 6 bits, and written across a pair of 32-bit registers, so
that would leave only 10 unique multicast address entries if I
understand correctly how the hardware is designed

- if we are exceeding the maximum number of unique hash values/bit
positions then the interface should be put in promiscuous mode to allow
the reception of all traffic, and multicast filtering needs to be done
in software (very few drivers get this right)

I would instrument that function and see what is happening in there at
the time of failure.

> 
> 
> PS: I'm sorry for the double email, but the previous one was in html
> and it was rejected.
> 
> Thank u.
> 


-- 
Florian
