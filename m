Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C437EECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 01:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717FE20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 01:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ka9q-net.20150623.gappssmtp.com header.i=@ka9q-net.20150623.gappssmtp.com header.b="wSOnDTAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717FE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ka9q.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeGVC0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 22:26:13 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:34368 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeGVC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 22:26:12 -0400
Received: by mail-pl0-f46.google.com with SMTP id f6-v6so6729837plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 18:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:openpgp:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kVBXgTPSLF9g5RPKucwZ+AnSU0ZHpFNQyYURJQ2jeig=;
        b=wSOnDTACOZOVc3dNrqFHi5pjG0avEjBCt4aC7jHUOSUDRDW5lprAl42jIud1WUT/ku
         6f9FDv5Oc9Hgt7uJGihjLPzqXn+wQyfKVJdPgQS5oqrHEgiULO31NVGbDzCSf/wa4iMC
         dW29/yOVRXuPnm+T4sAmKFDnmA3mxoP5svwboH4712N2WgZIN1zT6DelMUCqmZwsWyYx
         kBoT5uGdZvxWgFFP71G9dqwTEZ9TM8Foa8ct4KXFmPUI8MW4/KW0481MrRRkGP+nFQSq
         YJYQsiPYyQJCIOKYc3g6x8oDtAVd+KfbJikFVhhHLVBBGs/9Xi00WvfY4U7QAX0sFfcA
         MOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:openpgp:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=kVBXgTPSLF9g5RPKucwZ+AnSU0ZHpFNQyYURJQ2jeig=;
        b=qvpVBVeSNmQuZVBhgPacfELonr40hsbaplLQY8nErV/epFVymV5hJ47Ae/JNc6GERB
         rVPDQhsObz7YA9/yooA5l3dd6yA+2MCkDp5oz4wZ6pMWLtrgAIQ/A37jQJL9jfEtGYJh
         g/h7iEl5Ht/hyX6h4wAbo5tWP2DIHYgnlFbAqKBTtUK/OskRbLWNh8D8FxvpTLfpE+Ac
         5XIDHecY3Gfl9t2KAsuGthi21guQj3sDRBgcriovKpNIFaqYBWJhxMC/TjKi/oXtxEmF
         UYhL69+eoRdbSahIjs32GH/NunkDae8YKxkmd8ImCXspogeCyd3wSN/TKGsU8svX1Bay
         O3Sg==
X-Gm-Message-State: AOUpUlGUHrw241nBc1Q8AppgiZuo91bFuMM5QZrr8xsXejkzveub2LKK
        SeCsclm+FHn40OvukA6JUmrugkd5rhw=
X-Google-Smtp-Source: AAOMgpcJY1fOqrsFrAGhqxI9Ows1y5lc8LlLWPtSryD2bVXS+aTSmIOEvDyJSnNqkvuzBj8BcT7Azg==
X-Received: by 2002:a17:902:6845:: with SMTP id f5-v6mr7483595pln.173.1532223084799;
        Sat, 21 Jul 2018 18:31:24 -0700 (PDT)
Received: from patty.ka9q.net ([2605:e000:1c0e:4055:980f:3b53:4381:3284])
        by smtp.gmail.com with ESMTPSA id 70-v6sm8382218pfz.55.2018.07.21.18.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 18:31:23 -0700 (PDT)
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Phil Karn <karn@ka9q.net>
Openpgp: preference=signencrypt
Subject: hard-coded limit on unresolved multicast route cache in ipv4/ipmr.c
 causes slow, unreliable creation of multicast routes on busy networks
Message-ID: <147f730b-8cbf-b76d-f693-b3fdaf72a89c@ka9q.net>
Date:   Sat, 21 Jul 2018 18:31:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running pimd (protocol independent multicast routing) and found that
on busy networks with lots of unresolved multicast routing entries, the
creation of new multicast group routes can be extremely slow and
unreliable, especially when the group in question has little traffic.

A google search revealed the following conversation about the problem
from the fall of 2015:

https://github.com/troglobit/pimd/issues/58

Note especially the comment by kopren on Sep 13, 2016.

The writer traced the problem to function ipmr_cache_unresolved() in
file net/ipmr.c, in the following block of code:

		/* Create a new entry if allowable */
		if (atomic_read(&mrt->cache_resolve_queue_len) >= 10 ||
		    (c = ipmr_cache_alloc_unres()) == NULL) {
			spin_unlock_bh(&mfc_unres_lock);

			kfree_skb(skb);
			return -ENOBUFS;
		}

This imposes a hard-wired limit of 10 multicast route entries with
unresolved source addresses and upstream interfaces. My problem system
sits on a busy subnet at UC San Diego, and when I run the command 'ip
mroute show' there are almost always exactly 10 unresolved multicast
routes. The authors reported that removing this limit solved their
problem, but I still see the test in the just-released kernel version
4.17.8.

I don't have this problem on my home network or on a small network at a
local high school, both networks having fewer active multicast groups.
The problem only shows up at UCSD.

The problem is most acute with a multicast group that generates only one
packet (decoded ham radio location tracking packets) every 10 seconds or
so. The multicast route *never* resolves and traffic never gets through.

The problem is also severe with a multicast group generating
intermittent bursts of traffic with seconds of idle time between bursts
(audio PCM from a software defined FM receiver with a squelch that stops
the traffic when there's no signal). However, when the receiver is tuned
to NOAA Weather Radio (which generates a continuous stream of traffic)
multicast routing generally worked.

The *only* difference between these three cases was the intensity of
traffic in the multicast groups.

Does this hard-coded limit serve any purpose? Can it be safely increased
to a much larger value, or better yet, removed altogether? If it can't
be removed, can it at least be made configurable through a /proc entry?

Thanks,

Phil Karn, KA9Q

