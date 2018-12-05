Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF57C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E160E2087F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="aPeUsASA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E160E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbeLEHCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:02:23 -0500
Received: from host.euro-space.net ([87.117.239.2]:33466 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbeLEHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MUwZ4/xXouELJhOt4zikfgXQ+QMNK1eM/6meihPAHSM=; b=aPeUsASAxnhfQgD45XVInLKTY4
        VEB79OnLMCtfisp0X6qjVTsFsjs9/x94gf2HUbbSVFF5mgO71r/7zkjb1lnl6Kk2D4ihR36fwlMc9
        Bmv/0q9ZqZ8lDeeWDuj0+lIDDCHslMgOlGzWC33dcokzaQT0WdccNj2XGZ8QA+v/dnQqaVdHnO7ml
        t179rtzdtlV1j6YDVBSv9XYFfBRqvJnRcqJmBH1/RYZpuX6ub+MFdDYCRWmbI24ZeVzvDF8UzWlDo
        y1GJXD+qQhzfJ9LiLqVgwPo04m8NGVLjY2tQeaeU4ZqQbK7n8iVRLadeIXhJjMMjopzlXCrHLBiN5
        pNhJ6SjQ==;
Received: from x2f62ea7.dyn.telefonica.de ([2.246.46.167]:33156 helo=[192.168.1.3])
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1gURCN-00006S-CI; Wed, 05 Dec 2018 07:02:19 +0000
Subject: Re: [resend PATCH] dt-bindings: sound: Add documentation for pcm3060
 property out-single-ended
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20181115071253.22558-1-kmarinushkin@birdec.tech>
 <20181204214313.GA7847@bogus>
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
Message-ID: <7cbf1452-354f-07d6-2310-cadc4358433e@birdec.tech>
Date:   Wed, 5 Dec 2018 08:04:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20181204214313.GA7847@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Rob,

Mark already applied this patch, with a slightly modified subject:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=fd7de6370cb62b147185834d60069568a21acacd

Best Regards,
Kirill

On 12/04/18 22:43, Rob Herring wrote:
> On Thu, 15 Nov 2018 08:12:53 +0100, Kirill Marinushkin wrote:
>> Output of pcm3060 codec may be configured as single-ended or differential
>>
>> Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
>> Cc: devicetree@vger.kernel.org
>> ---
>> Hello Mark,
>>
>> yesterday there was a misunderstanding: when I wrote you
>>
>>> I think you forgot one patch in the series
>>
>> you accidently applied the already-applied patch instead of the forgotten
>> one. To avoid the confusion, in this e-mail I resend you the proper
>> forgotten patch in a separate mailing thread.
>>
>> Please apply this patch for-next.
>>
>> Best Regards,
>> Kirill
>> ---
>>  Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
