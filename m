Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B00C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085C020854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085C020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeILPFq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:05:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:40815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbeILPFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:05:46 -0400
Received: from [192.168.178.201] ([79.193.244.88]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lomql-1fKwzM0Znn-00gq49; Wed, 12
 Sep 2018 12:01:51 +0200
Reply-To: 20170201165532.2605534-1-arnd@arndb.de
To:     arnd@arndb.de, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com
Cc:     drbd-dev@lists.linbit.com, nicolas.dichtel@6wind.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
From:   Philipp Klocke <Phil_K97@gmx.de>
Subject: Re: [PATCH] drbd: avoid clang warning about pointless switch
 statement
Openpgp: preference=signencrypt
Autocrypt: addr=Phil_K97@gmx.de; prefer-encrypt=mutual; keydata=
 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
 12TtBTzNsw==
Message-ID: <4853c5b7-fc65-5499-a129-52bfc6c2851f@gmx.de>
Date:   Wed, 12 Sep 2018 12:01:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-HK
X-Provags-ID: V03:K1:VO0Q4pUHEoJkjyF8VfkInoz9VN7t6MjOfTWuhQ1CxBOXdvtFoB5
 XRKOQv+u9r/snHxqv1W0/1PfNaXFqPplSJpTT/bSUEGdYmv9uL6WoBHQOJhevNBV1oT8Bs6
 RAkYq5vL9jijto4K0tT9U35ID90NggHw3H3UDjrHO9u+8tNf7SVjyFgnYL0yPxbL6O1szEa
 KJjkGpOcP1VqFm4yTeZJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3c2uNz/GHoc=:Nz1A2C3u8u13paPCd+tWw+
 50FDPsnsxkugudUjpH1z8sPMOvgedOe98cfFz60JGAV5gpYzmzvd0yJVI2yDt0PctaTUdd1DV
 sZv9RWtNFkb+tctHHeBCfbJ5mE5wE51cjzURcFUyAysKMaTAUKRTFf7OyerBklIHXhlvcXry0
 u00w8gVdYYPI0q50KIEno1Cke8qC60T5RiOppLAqQF7co0xxHvLNVxcOkLrvZRKOo6hDkt2fo
 N9EUgQCInBJV5i6BEYIaZvoqsUnvJMn2GvD79S9MRiOG/x1+eXSV0RmF9jV6QASgn7meDmaXb
 a+BcYqGdzCXQ2pq22I/xJN2sBZDMoOiplyUlyMkeAz6bnnKjVqt6DkHUzqrpAaMq0XUpgrGYw
 3h8XjixUnARPorTAXYLPJGqoRRZ4axM2QlY4QUxOjaCL9CpdrMrHDhZLglK+8CiQguYatap0D
 2iZprpwoeiGf3qEZHVTwgRWc/9uqiLyZMX2G36sUr1yEBqvD5ACvYEzvj5X3llODL0QwkKKIz
 hNxMRnr6AfD5Rx5Hm4jU6IzN7t+rN8s2dF7/lY0WeyWexFKDjs+bXVcYSfNtcMOXEGMMEV0rJ
 4kyeL3/vQhFheztJTSRdj4n6chNdPWy4i9M6WgbK9eARrCJQuzKHwP8CLeJUzsIK7aHg1WRaH
 sMAQbNF0JUMJTzOCE6iGG+OxxA3o0LPTNiL2Kcbkf0rhIH2ykfTcqSeXF/K0Om0OosoZGTi00
 t3U175Dc2wkKGq+lrF8z5bsF+zH+EXSES77XQomtUgYTKIYhroYy3mF0f81ZmP8Rx6z9GY9Xp
 XvsFWleCXPvtw9mUa5qw4orE8ciN3KYbEHufDAd7sy2EruTjCQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've also stumbled across the "warning: no case matching constant switch
condition '0'" and wanted to fix it.
As your suggestion is probably the best way, I wanted to ask why it
didn't get merged yet.

Maybe the patch got lost?

Best regards,
Philipp


