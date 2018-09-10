Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB817C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8818520865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyR80GIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8818520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeIJOXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:23:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36224 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJOXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:23:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id j192-v6so20716135wmj.1;
        Mon, 10 Sep 2018 02:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/JF4voVLLJvB71QWNMd5pns4SrZO5FuvQwf249gfCLM=;
        b=tyR80GIF3l/srr1t6M/pefKsGwJcEMmfe7thGJ36WEWp7SBL8NYEAD0If7BYvSH2/n
         T7VMDlbEeKQH0908G/3e+ZxUBLKrToqkeHYIlzWgGQRsX/lx3ZehwoEURCCRYZmIZqsP
         QeD06eCSLffhI4YQNCvP9zwQXKdecYGOoBGUDb+DPZ7EAuav/sncrQ3/vvU4Li0Yngu6
         0JozZjA0Grt+bOdDESpb5F7hlLy7N3+4u7JYQaSTRt/p/j5NB3BnXJ7xd236wnUP4pxg
         dyQgBec0Uqfab+3VEb1UZcGalZPMQT6p4vJ+7V6iNg7IZexv38/lRgGmRipEweOjgaMl
         EaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/JF4voVLLJvB71QWNMd5pns4SrZO5FuvQwf249gfCLM=;
        b=l5ZTY1Xc4PaBi0JvZmpmqqB7ZdxNAxht2QWWVApszoD+DS9C8cyBVfg+f+4DU70r+o
         C4Rigz5Yqh7ZDVzFjtPLP5nREsMbZLW7MxE6Ff+nEeiOY9dakmh1CY5QBOZpciajs4jy
         /u7p8xkdRm3xbcccL1hlt/eF2KafqNoD4juQ2IM3eqntQVGSC6Tr8sUI0HU+7x7gyxf7
         M6vlxflnzrb9m3FVs8wOq2KL1J0dI3pYajb6PvxUEtxQoXoB828QykgMt3Xswuwvbgq4
         uzjhUQKhxS4bfLkMCOHNlofG31hmgWbS8tmk8Y2AL3x1MxUaUQscDWD1sfjW2m3cOa0J
         H+QA==
X-Gm-Message-State: APzg51BPlTcEx3idgnk3ZO+x1yxjAx4N7a36K+7H0LKTdmLvD9T8JGdD
        iLfPGCn41xqz2jfHJA4EyPM=
X-Google-Smtp-Source: ANB0VdYXBXezuVMKykxqjiCh5bN+hSR9MFt7M+b5zPNnpfmGS3Nec7dP8YgG1OKHXwPW0L3Vi9XvDA==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr56004wmm.117.1536571822897;
        Mon, 10 Sep 2018 02:30:22 -0700 (PDT)
Received: from ?IPv6:2003:ee:f01:8400:8022:ac53:b7cf:59f1? (p200300EE0F0184008022AC53B7CF59F1.dip0.t-ipconnect.de. [2003:ee:f01:8400:8022:ac53:b7cf:59f1])
        by smtp.gmail.com with ESMTPSA id r13-v6sm13328602wmf.35.2018.09.10.02.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 02:30:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] ipv6: Add sockopt IPV6_MULTICAST_ALL analogue to
 IP_MULTICAST_ALL
To:     =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>
Cc:     Linux NetDev <netdev@vger.kernel.org>,
        Kernel hackers <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Erik Kline <ek@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
References: <20180910082715.11506-1-nautsch2@gmail.com>
 <20180910082715.11506-2-nautsch2@gmail.com>
 <CANP3RGfGkH33mYDrenwWVkQ4uG4qyrddA+yvJ+t+=y6wGd7uDA@mail.gmail.com>
From:   Andre Naujoks <nautsch2@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nautsch2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBEuVIO4BCADaPWxLdKao/quVbf1+wVSuDMf1tJmEpeEZ6qojmlR/5vcTj+me6c5UvBSr
 wBckL0EK/JdzZMVwny1oFfAjTgO252A7Mn1Q+ss8w4RJBI6YnpeAlQIyNm7UTN2wUCY90ObO
 z019BQs3BpQ7iHG2cUWy0KunRMj6dOIGvMKCpETyI83R5annZAR0+5ZhcCB3embvKzRySf7/
 YfAXXBGYkMV9ND7r66BECmDVH/MHTENCqMOvbfVOCKwj1JdVYx/WUqLd48flZ6sx/Psfp/r1
 mY1sN0yebElCkUNzOWonqlgr5kwMZh0+lD1DSQnNhdH2FL5Vvo8qbQ/WTdJd1Equ5BejABEB
 AAG0IkFuZHJlIE5hdWpva3MgPG5hdXRzY2gyQGdtYWlsLmNvbT6JATgEEwECACIFAlO0ExIC
 GwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEFjpxyF47AzYIPEH/jTWaF3CnPugN3CI
 6AfbNP6T46tpDZ1e4QuWBZdFY2eBfDkajfWtqoLCqU7xctmkcuRtFULHnMZwu0dUAXVExlMi
 VYRTLCLYWzFrZ26P7KIudHFyb8XWSh/HTEdahRv4JKscR66kHzM4jdYeKJCud18+gxepPvPi
 7X6sJvA4JlFnomIjW4UHJByif0LRR47KOtOQD5oVon7urSE+K2ib2BqgFIy8o7+laq3/KKhI
 92/ZnNBX/KoZVChFkBCSJEKmaLQCQdCnjXDx+nz6wJT3JYF1FkrGx49An/yTHlEv3nwwDLFF
 0Ff24e/E9PpQ4lIupfqWMfgYhNCbMe2mScwZoWi5AQ0ES5Ug7gEIAMexJPQTFF+ENQxNHFGU
 dw/vq19odo/iB6CgoySTxO28FCbh00Yo/Xw9/CZgKaLxsBuA+Wie1t/MEN/6/pNVpOaTqc7O
 fR4oSbRIsthSHUAQYPAo+bES7jBu+uIO8WNWk2B6sqb2JgS104yHKtlmeZP7+VhEe1nekTkv
 i2ASyywgwkH4dFrMjjkYCt6tTqE7QDRrMmrx6NW31nOjLKSA2Nst3o62b1Z0D+YZeVUspytz
 rAuuv0bKT5GH0zsc9+yNtOYLvkmVhi4x3VW0CD0aLsIq7E9kellZ0oRh4xT9ObuAstI1mG1Q
 yAufU8LZyPRjLVcqrNzemekB59w3gmcMmKEAEQEAAYkBHwQYAQIACQUCS5Ug7gIbDAAKCRBY
 6ccheOwM2KXwCAC3D+3yvZwBycTofZ60G7xvdp2NYBZOszVRFvZK5JRsoI7tNTF635BPJ1Sd
 1Pv/FFt5FUSt/Fv7G9ibunh8He2cbcA5TjwbihhxNT1yAWd6pPKgNlUDMPlHYLBTHq5vwIDz
 3WVq651ihMFwJ9MSSLUbo5PyUpvMEVHPcChUD+nKNufI4/Y7Ob4I90nXgHB3OUXbmOcwZ9+S
 YpcJso4jCmjGBOcaOKZHCN+OX2r4nzE+vMDGWephhg5d8HLxFFDiD+Buw2SsOVxH1qXhG8nk
 AGjD/Q5oL3gtVPTrPh0XTk3JN3LLFOddMQ8oZcuIAh+4aLlGEmK+L5RPAbcigApJNjcZ
Message-ID: <5532db3d-5387-8347-e017-6443d0096d08@gmail.com>
Date:   Mon, 10 Sep 2018 11:30:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CANP3RGfGkH33mYDrenwWVkQ4uG4qyrddA+yvJ+t+=y6wGd7uDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/18 11:07 AM, Maciej Żenczykowski wrote:
> Any reason not to use the same bit that is used by ipv4?
> (as in add the setsockopt/getsockopt but just toggle the v4 bit)
> 

I wanted to keep the current behavior for an ipv6 socket as is. I think
user space api/behavioral changes are frowned upon!?

Currently the bit is settable for an ipv6 socket and changes the
handling for ipv4 multicasts for that socket. If I had just added the
socket option and set the v4 bit, you would get maybe unexpected
behavior from that, if you used it for ipv4 multicasts.

Another approach I tried, was to just honor the v4 bit in v6 context,
like this:

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 4ae54aaca373..af1659327d46 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -636,7 +636,7 @@ bool inet6_mc_check(struct sock *sk, const struct
in6_addr *mc_addr,
 	}
 	if (!mc) {
 		rcu_read_unlock();
-		return true;
+		return inet_sk(sk)->mc_all;
 	}
 	read_lock(&mc->sflock);
 	psl = mc->sflist;


But that has the same problem of changing current behavior in a possibly
unexpected way.

Regards
  Andre
