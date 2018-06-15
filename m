Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F52C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D758208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=micronovasrl.com header.i=@micronovasrl.com header.b="iv4HNqAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D758208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=micronovasrl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756527AbeFOUzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:55:05 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:36244 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753735AbeFOUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:55:03 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id BCE36B0097D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 22:55:00 +0200 (CEST)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1529096098; x=1529960099; bh=lndqVC0spHTgwLpmSxRXNyNkbAtdyznmidu
        JR2h5pDg=; b=iv4HNqArlzJsEpNmQSwwHP0j2oHRDq4ZvU0qyClAWbcgfC7Dj5g
        2KDwZwqzjzdiVe0IGpsm4Kn7JEEtKhrTni3R7q4fJoLgctqqJF1RLGBhSByMg7yx
        lESTcJeCM+ELSb7OqhYiQt/+BrJY5cMNyzQz3OuvjwNgclZqOT71iVgc=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nEkMbzg_imK0 for <linux-kernel@vger.kernel.org>;
        Fri, 15 Jun 2018 22:54:58 +0200 (CEST)
Received: from [192.168.2.70] (62-11-51-166.dialup.tiscali.it [62.11.51.166])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 74945B00319;
        Fri, 15 Jun 2018 22:54:57 +0200 (CEST)
Subject: Re: [PATCH] Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com, stable@vger.kernel.org
References: <20180613081647.31183-1-paul.kocialkowski@bootlin.com>
 <d5357ae3-9dc1-b0ac-47bf-8742d55c4f3b@micronovasrl.com>
 <99b2583187fe9925251029e876b061aac9172597.camel@bootlin.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <94a68af2-371f-d81e-b25d-31ae7869e98e@micronovasrl.com>
Date:   Fri, 15 Jun 2018 22:54:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <99b2583187fe9925251029e876b061aac9172597.camel@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Il 14/06/2018 09:26, Paul Kocialkowski ha scritto:
> Hi,
> 
> On Wed, 2018-06-13 at 23:52 +0200, Giulio Benetti wrote:
>> Hello,
>>
>> sorry for my ignorance.
>> I don't know the right patch workflow in the case of "revert commit".
>> When I fix this bug, should I have to re-submit the previous patch
>> entire plus bug-fix?
>>
>> Or do I have to submit patch with bug-fix only?
> 
> Yes, that is usually how it works! The revert patch will be picked up by
> the maintainer (Maxime), integrated in his tree and eventually merged
> into Linus' tree (along with stable trees).
> 
> Fixup patches for this will need to take into account the revert patch,
> so it becomes equivalent to submitting the same patch with that issue
> resolved.

Thanks for explaining me.
I'm going to submit new patch asap.

Giulio
