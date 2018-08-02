Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3449C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5D2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q97ClCn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD5D2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbeHBQ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:58:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33099 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732520AbeHBQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:58:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so1354232pgv.0;
        Thu, 02 Aug 2018 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OqSg613p80xMuYUvCap8dKRpRwvIUDCBTFHCvPP94K4=;
        b=Q97ClCn2r+ak+8j8N0VuS2MPTSMpIn0kjfK1YClccRtBJaUJMG1gUzm7dhZwm9GUB2
         FfvKHgQIYeJN2mIJbS5F04uTr1qWNaYi7Vg+PUlQgJKfJ9sSATlZrCbWZHYyQrLa1gVj
         dteFcZgfqsuTOzvfRaYEe+8PDfuiWe5/cWRkpBpihZLDyQ8v++0geMP5QKMhxbqwhGM9
         Vf46g5pJ0hVU2OO+zi11KwlzRU3vtocimCYJ5ZKIwX264/7YyMOShnhUsvkSnBDN8aEu
         eZ4MPzz2s8nnDe0ObH6Mv1T2RBniBL8beCZEjmUxkgQDNNClRZhrI65jN23p6abjf6zP
         s2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqSg613p80xMuYUvCap8dKRpRwvIUDCBTFHCvPP94K4=;
        b=bfNHskNvWJfandbubW0/7Y/4c3YGWK49XnAQ2a+MstkKVfLiJVHIqqWvrkMw7odXx0
         mz6prfmXDJZwcCW53RfgBbJFu+RuLOudqqsMP9Go/bqKl0ApyeEvL2KJLkfjEVWkIzrD
         CaNtjpnMhgwNZ6uUF/Ohc9vMAriU1aRglGGQbdSTZJNAbygfsy/L7uwh9w0279LA2y1G
         nFf6y1IavM4CTH9iUtCSmGc6zHAsdMUPC3gcWsPi2xz+m8Uw1o1THgVqELV3eF30MdIe
         11e0aJgMIMlii4WgcyRRHQH7ERNXqUDy5onnlDRLdvAUnTmAX+jJfviYIxiRY9MmbDOS
         smog==
X-Gm-Message-State: AOUpUlEuUoQIFDkLiyVHhXtQzsOK7ERSkkG/Co6rVesN/o0NKWojJxZO
        6FJRn+PBmSG0KqlKhpSR5DU=
X-Google-Smtp-Source: AAOMgpcGoFXFrSpRGlCNd+j1OIkjRwrAROls551EUmUD6JuMSheCvlzw0uB5uf/h0QVAokVDFRdrUA==
X-Received: by 2002:a63:f54c:: with SMTP id e12-v6mr3187510pgk.286.1533222433935;
        Thu, 02 Aug 2018 08:07:13 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id k125-v6sm3855581pgk.41.2018.08.02.08.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:07:13 -0700 (PDT)
Subject: Re: AW: AW: PROBLEM: Kernel Oops in UDP stack
To:     Marcel Hellwig <mhellwig@mut-group.com>,
        'Eric Dumazet' <eric.dumazet@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
Cc:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Matthias Wystrik <mwystrik@mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
 <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
 <18341daf5b2c458db8e30299d6cddafc@ZCOM03.mut-group.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b297c600-1600-3560-7f2e-6d504529e0db@gmail.com>
Date:   Thu, 2 Aug 2018 08:07:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <18341daf5b2c458db8e30299d6cddafc@ZCOM03.mut-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/02/2018 06:57 AM, Marcel Hellwig wrote:
>>> There are actually 2 faults, difficult to quickly sort out the merged tracebacks.
>>> You are also running a rather old kernel: Linux version 3.4.113.
>>>
>>> It may well be that whichever ethernet driver generated the misaligned 
>>> frame has since been fixed.
>>
>> A misalign frame driver problem would have faulted earlier in IP stack, much before we perform the copy to user space in udp_recvmsg()
>>
> 
> JFYI: we are talking about the lpc_eth driver[0] #57c10b6 , which is not the newest, but all newer did not fix a major problem (at least the commit messages are not screaming: WARNING, UNALIGNED MEMORY!). Is there a diagram/document how a ip packet travels down the code? From the MAC/phy driver to udp_recvmsg? It's not that obvious for me, but maybe it is something I can work with.
> 
> 
> [0]: https://elixir.bootlin.com/linux/v3.4.113/source/drivers/net/ethernet/nxp/lpc_eth.c
> 
> Regards,
> Marcel
> 


Well, this driver does not use NET_IP_ALIGN reservation, meaning IP header is not 4-byte aligned.

No idea why mis-alignments are okay in IP layer, but not in UDP

You could try to patch it to use netdev_alloc_skb_ip_align() instead of dev_alloc_skb()

