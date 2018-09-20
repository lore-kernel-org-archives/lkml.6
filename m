Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9644AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E77221479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o+wwKwCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E77221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbeITVHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:07:37 -0400
Received: from sonic304-17.consmr.mail.bf2.yahoo.com ([74.6.128.40]:42941 "EHLO
        sonic304-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732915AbeITVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537457016; bh=whUlYZ9uhr9R+6zBKrfg5ox1q7Tzf5Bra4X78Wg+D7U=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=o+wwKwCakWAtgVxvKHIsit7OHkgeYWPcB5xYB1TgNKhhV+0WHqdzUzRfC5iZeylxhMXM3yVeG2T0FyjX59+Nbtd1JFK/LpekIXjGfEGthfWGEHkh2fDLB7BXfoeLbHkZmr+i4SthmcuRwB+Q5jDVWzEcSgxmeTkIj8bwmGfiG89QTXoy6w/i23trsaibQBtErDo8ctUx5bmvb2H0MVPTWdCF0Z11WmeriWus3yRDtJSD1lzMGHYxJzmNDAFs+wZqSvUhA3HaErUUDe1K4WEr/ItCnZZWZMDsDwayqCIRQyblYzXc0PjCLCggYCNH/sYKTSpV78DF2I/OuBhoW2tC8w==
X-YMail-OSG: 8sm7c9IVM1kRl_qvUHlZVIqNzFyY_yTq1muVQidB4SMFnv.k2szAVDPtoJ1fR2W
 vMb4Fn_BizChU5wc9XFF0Iio6o_fclStp6SEFjkuYMHuXUclZ7kOAX2r3H42_gNYUriRqaNHdN5e
 QI_wdcoY7FURHmTjY8x7tarQGF4hZgjFNZDrJN0ym5faJsY3bYe.iqAMJ9GB5gA0.XEZuGJk8RNc
 T9zNBCKPmGZ5XmN2sPP7Xh9Y9CMP3K8el_.DT7GBclAuyDbAExXxAUjseDsBqFYg7Zjk14mQP6ga
 S59awFb1_1J62P4eU9Y67piatb1dQln9x89dDHkGlebdrXku15ifEw8LeWmM8e4ijXVdtNX6A5cq
 gBoLxehd9PdAtSekr.nkbkjZW_d4TyTeBbJITBuWkjyjbRTcUgusCq5Z4TbCFLmpbcAlMg8yZsJb
 p3MrD_GK8XCua6lsDAG.yGlUiOjGXMyOEzLtUmS_gK2sghi9mahoReXPhAOp0Fxs5p_zXbx0kGE6
 UgHfQtFg2zzXCeykKMRFNMMfNro7crsnoibehGc0cXs4c72.FDxqOfqjXrTfQRpV16iUcbTdm.b4
 tClrdnjT1BBN..HwEMpMAJl1yHF09Uj4Nx0qtCMUd_QhpgaJh6c.G3BPK46io8uRYnvJmACPhkoA
 Na7iTo3xgbPmyJk3nFNbpq95J7r4U94kh7vxAizbmZ9bk5KZ1_xszF3rKWJd3Y2Cx3Y3TcG8mO3a
 eCgv_8LgWOvSOg2YTnef2z0HFa9TV75aioxeeOXJ3VvZv5JQIoZwuRAyo6.tJrhWULUvUDC4nrCV
 OYxE6pDU_UduH8cTHzHgVzbeEWlnYmj7iPqgLZ2_TINWittfMyZwLTa8PW.zMAvg2OqnKtYsY.5G
 xCnBmfpbQB1FNyYMuj6TR975cacHPtlrEXa.ltykZhObZn8nssFw47_7zZM28wPGwpEu3crH9q1B
 .mHqpmcmHUDu8MW9NTYSTSbWZDnEURcLKU4xT8w9jMqqxOMxNYhM61y_xMzkFpvv.rJCxaQiZTzL
 SUUycyKAlOOnhUvozWE0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 15:23:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9a4626238894b3404c2cceb61057ad74;
          Thu, 20 Sep 2018 15:23:34 +0000 (UTC)
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
        serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
References: <20180919231402.4482-1-cgzones@googlemail.com>
 <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
 <CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f65fb0db-d79f-3867-f48c-cec2f61e027b@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 08:23:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 12:18 AM, Christian Göttsche wrote:
>> I've only had a cursory look at your patch, but how is it
>> different from what's in xt_SECMARK.c ?
> xt_SEXMARK.c is for xtables, use-able in iptables; this is for nftables (nft)

Thank you. I am enlightened.

