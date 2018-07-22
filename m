Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09876ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C36F20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ka9q-net.20150623.gappssmtp.com header.i=@ka9q-net.20150623.gappssmtp.com header.b="ixJLm7ur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C36F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ka9q.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeGVG13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:27:29 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:46925 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeGVG13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:27:29 -0400
Received: by mail-pf1-f175.google.com with SMTP id u24-v6so355872pfn.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:openpgp:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QWJIKdH0ytydD1bXsTYnDfNlvp/z/S2KAdC8oL8MDuM=;
        b=ixJLm7urWiifEGhlL2Zz/zgdyEzVL6Kz3KNyPc9BZerlnr8GTbqCiJyneqTwmupAkc
         68Jy9dOD/twK64Pv3UfuBe8lSfU2aK6SmOoNsjFgpm6PEzpazgw8xBQdqn7cbUgu4X5p
         4SCPbN6eqpG5kk3gmkJvDesInXmrjaHsQUjMP3jTjPdIBMK25m4i1tu4uetG7BRXqBId
         eNkN/Y5Iz3CEzMpiiFtTFhT1qqVwBGtCGLsN+lcQ5zOYdhKwRQLihr8b8g9tsUG4Q7VC
         ZfkCDAJe3rciHh4Kptx9ZBe5H4AayIi0i4U9XwUm09q8uv9G2tHCLqlaMnSksnzFX0Hf
         fOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QWJIKdH0ytydD1bXsTYnDfNlvp/z/S2KAdC8oL8MDuM=;
        b=PRzlZvM72cAHSr0VdC6QX4UMR3RkHxwfSZVxVzc+BCsn8DpRKtTlEBwEZ3jLX/05SZ
         4hheQ0ZBTv0GmfHzM2IYVM+KMMinbhxFboFJNT6IsTiLkTbATzylvWz+dgbH146mHP4u
         AIH8J6zcN23pv8qz5H00fIFoukoWpAIrkU44j6g2G4MLmnEEea7qW0v3uwcMXz6d+tZA
         AwNe5fh8bdYWNTxNICUqGQ4kyc6LgAr6XmoIHYTZe6VD2Oo10v0vv3P76xnLxkZ+eV1m
         dsfxoZ4ujDocTQ8XClKJ5s+BKIVwpulaSKcWNNApbK4oP0jHG4p9DfuCxGS2O+5BZU88
         scOQ==
X-Gm-Message-State: AOUpUlEHmNI/EtN5sBmf584ZeUCv9hNIf7369Rezspjxatt1tfDZzDPX
        TE6ePGqdlb6HvENjzAyhYz7tjw==
X-Google-Smtp-Source: AAOMgpcTs53KC2hbLfbk3/K4JgBFHaDGm1mg4YX/CRZM2s3o1RPkBFpTfLJ+0O2WbuNFYSVD7KX6MA==
X-Received: by 2002:a62:2b4c:: with SMTP id r73-v6mr8277771pfr.134.1532237525530;
        Sat, 21 Jul 2018 22:32:05 -0700 (PDT)
Received: from patty.ka9q.net ([2605:e000:1c0e:4055:ec02:f11d:3638:80f5])
        by smtp.gmail.com with ESMTPSA id t63-v6sm7694585pgt.57.2018.07.21.22.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 22:32:03 -0700 (PDT)
To:     David Miller <davem@davemloft.net>
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <147f730b-8cbf-b76d-f693-b3fdaf72a89c@ka9q.net>
 <20180721.220309.1193443933653884021.davem@davemloft.net>
From:   Phil Karn <karn@ka9q.net>
Openpgp: preference=signencrypt
Subject: Re: hard-coded limit on unresolved multicast route cache in
 ipv4/ipmr.c causes slow, unreliable creation of multicast routes on busy
 networks
Message-ID: <0e085e9b-1e49-126c-f5f7-6ce2cfdd478d@ka9q.net>
Date:   Sat, 21 Jul 2018 22:32:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180721.220309.1193443933653884021.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/21/2018 10:03 PM, David Miller wrote:

> There does have to be some limit, because we are depending upon a user
> process (mrouted or whatever) to receive the netlink message, resolve
> the cache entry, and update the kernel.

Wow, thanks for the quick response.

I notice that an "unresolved" entry seems to be created whenever the
router sees multicast traffic from a particular source to a particular
group. The entry seems to "resolve" when an IGMP membership message is
also seen for that particular group. There are a whole bunch of active
multicast streams on my UCSD network segment for which there are
apparently no listeners, and that seems to be why I always see a mroute
cache full of "unresolved" entries. (If I run a local application that
joins a group, the entry "resolves".) What puzzles me is that the Iif
field is given as "unresolved" even though we know where the multicast
traffic is coming from. We only don't know who might want it.

I'm intimately familiar with unicast IP but I'm still learning about
multicast routing so I am probably missing something important.

I tried a workaround by using iptables to block the unwanted multicast
traffic (the senders are on one well-defined non-local subnet). I
created drop entries in both the INPUT and FORWARD chains but the hit
counts remain zero. I guess the mroute table is populated before the
packets reach netfilter. Is that how it should work?

Phil
