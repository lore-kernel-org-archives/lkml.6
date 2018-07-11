Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5891C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75882208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUXe5xTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75882208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbeGKCGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:06:16 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38124 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732348AbeGKCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:06:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id x13-v6so7390984pfh.5;
        Tue, 10 Jul 2018 19:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CFND8h1GiZpzwzam9HXrIkkrB8eYCOwCR32cU1+B4FU=;
        b=PUXe5xTyd64FZ0c0mKqNoo7ouot0bDne5VvqOAue6WOFkrvVoKMV8yemUT2YqGfUSz
         /zJwyRf/iVv7+tRK2gCtEKZ8pGgGmQOUJKYaU4Ilf/2uIBgehNXmXIeDl/ncrA7aPX6d
         /JkDmB5143cgA1senJzq9Z/6WYk8r+P+l+IPm1SFIUjiavlQlJu/HioNqfB4blkKwcDr
         ugKpSHVM4VIEgjcXdYlpySL6wARPq5LFueT+149YLJlUfLhO9v9kj4k8Dg6eFzhojBBa
         dc8z+dZsuFjoY6TkHNq7B9zm0lRqJetkfutk9Bvx5QVGk4KQ/srBC9zvO2UyWzaE/Bv2
         XDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CFND8h1GiZpzwzam9HXrIkkrB8eYCOwCR32cU1+B4FU=;
        b=ivZRsut3qVhOvZnozZpdsVXbPg44Isa5TpFLaYH8kx6uthRgNDWXYfHHVSeQusEOe8
         KgZouflhJHFbej0O0V9d8LkVryeinkv68zNa5xIVgYD2gSGBDfjFfn5A6ziuEebPbqe1
         EWcnN7hAzc2oy/69K9eYtRLBqCI3Z/Xa3Aw+E4/6Wv6xN5/PNVSEuU0hVlpQM69oCuR8
         wxGX+Wye/eZYD4AXW0KWQw5WZEro2pmcd08Yhmo6NMtABKp14NCOJa/8LD7OPjZkRrU9
         m2IF+KP8yhtSmGBjdRzRoSfME4Qw+irQ8rm+UdFb74YnW0UyETOv17rKoqTTUR9YIpx7
         QXig==
X-Gm-Message-State: APt69E2AoufReahWmz0qgCZ4T55PEJH4/n74HuX8SnbMkJdN5kGp64MN
        RyDmVfF5l6E8qPR2PXiqmUs=
X-Google-Smtp-Source: AAOMgpe2px619wR1UeVa1LSoQUGMwxDiC16OhJ9HKAlhmDnJ4RRN3lKSWYRXD5r0OFEBBdwv9N3xSA==
X-Received: by 2002:a62:6eca:: with SMTP id j193-v6mr28180797pfc.256.1531274663559;
        Tue, 10 Jul 2018 19:04:23 -0700 (PDT)
Received: from [10.1.10.12] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id e9-v6sm8893705pgu.5.2018.07.10.19.04.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 19:04:22 -0700 (PDT)
Subject: Re: [net-next,v3] tcp: Improve setsockopt() TCP_USER_TIMEOUT accuracy
To:     Jonathan Maxwell <jmaxwell37@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        David Laight <David.Laight@aculab.com>,
        kuznet <kuznet@ms2.inr.ac.ru>,
        yoshfuji <yoshfuji@linux-ipv6.org>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jon Maxwell <jmaxwell@redhat.com>
References: <20180710065147.27647-1-jmaxwell37@gmail.com>
 <3f856638-52bc-6630-a3d2-2b50f1bf7e48@gmail.com>
 <c29f1535-3c5d-e588-862c-ba948363c973@gmail.com>
 <CAGHK07Aoa81QN+LmVttJQ56Sn+R-KyksYqZxSYL5-5reDRt3WA@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <46861e12-1ae5-374f-e907-87ba6241de5f@gmail.com>
Date:   Tue, 10 Jul 2018 19:04:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGHK07Aoa81QN+LmVttJQ56Sn+R-KyksYqZxSYL5-5reDRt3WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2018 05:33 PM, Jonathan Maxwell wrote:
> On Tue, Jul 10, 2018 at 10:48 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>> On 07/10/2018 05:38 AM, Eric Dumazet wrote:
>>
>>> Note that if we always do jiffies_to_msecs(icsk->icsk_user_timeout) in TCP,
>>> we also could change the convention and store msecs in this field instead of jiffies.
>>>
>>> That would eliminate the msecs_to_jiffies() and jiffies_to_msecs() dance.
>>>
>>> (That would be done in a patch of its own, of course)
>>
>> tcp_keepalive_timer() does use icsk->icsk_user_timeout directly in jiffies unit,
>> but considering keeapalive timers are rarely used, this point would have to
>> do the msecs_to_jiffies() conversion.
> 
> and also if icsk->icsk_user_timeout = 0, then timeout in retransmits_timed_out()
> is in jiffies and that would need to addressed.

Absolutely, this is what I was suggesting.

Pseudo code for this part, before your changes.

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3b3611729928f77934e0298bb248e55c7a7c5def..cae7bbc956ed51e9d381650957f54550cc0967d9 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -183,8 +183,9 @@ static bool retransmits_timed_out(struct sock *sk,
                else
                        timeout = ((2 << linear_backoff_thresh) - 1) * rto_base +
                                (boundary - linear_backoff_thresh) * TCP_RTO_MAX;
+               timeout = jiffies_to_msecs(timeout)'
        }
-       return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= jiffies_to_msecs(timeout);
+       return (tcp_time_stamp(tcp_sk(sk)) - start_ts) >= timeout;
 }
 
 /* A write timeout has occurred. Process the after effects. */


