Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7363C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1CC20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVGZJV8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1CC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJCTiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:38:46 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:46787 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:38:45 -0400
Received: by mail-pf1-f172.google.com with SMTP id r64-v6so1628601pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=JjL01YFDLKH/V8RAnJYaqKnjrO1y9iwpHovo/trJg8o=;
        b=VVGZJV8Tq0dBGExHdHZBPdctMtSHOCPucdMf+YbeUNkxaScMQI8XnjL2YE40dSGDd+
         zNZMlApHTft9FI5E3OzfzV2r26NvyUYDqCQ5xvCX/fcUos+9Uh9F0Ar19e7ILK+bJwln
         38VmBHMD+mgjRi0UT8ZeCARuVLCiiZk/Ab+/esQVEW+gOjc9dyi0QbaP/6h8aw849GPU
         FVNVhCmYvGQIzFy80tEO6kssUvIyNDlEqEeF7uBSM98/zJ2shHGyki7BZcEz6nuiMGbF
         tJasn06y/w12Q9qcQwKz8ySTeu+e8JoxzrSTCEl3h2CluuObTYBy7vMmnXrwPXnOSFm6
         Jo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=JjL01YFDLKH/V8RAnJYaqKnjrO1y9iwpHovo/trJg8o=;
        b=mr2YiygWOFFZoNBDqBhxlMMq418kWN8hy+lnFRZa2zJLQK5UOhtBZSRo58UQUfMPsl
         ifFCbkscW+P4A6BHjCPnhbIN5hxszGBNiHahLo8LfWxVEKPyHp4jTZvLhes3IoJn6+au
         /k5F3stO36ijjbUk6tZnoPDBOrJXcskxfdYFayuJ4XmkMeflO4LdLogj3BdsBOP/9F1q
         +sl+NfL9GItdDuy4eGupt0KUq5dMoH6K+HGTK198e5ds9tzlDlJABo1MhVdJpzaLrOcy
         B7gp0g1CfrM9YZVonbsMa/DcA5QptoCvGlECCa3tQDvNyQJ76P4PkhzAd6vtRQfQKd49
         jmmg==
X-Gm-Message-State: ABuFfohYOmnode0jSg+GVe8nylrMI+fKKnMm5wOzZ0uoVDhVIk+TGcgT
        G2gs1Dx1c7yCt/DgTTzCAGrmz5iT
X-Google-Smtp-Source: ACcGV62KiBRfWBhwyUrn5J1xSjVpscpGVVFORwAwdL3T/lNQaDssc+S2SHZZ7VzHRMS3N6FgvrH6tw==
X-Received: by 2002:a62:9586:: with SMTP id c6-v6mr1466428pfk.234.1538571029867;
        Wed, 03 Oct 2018 05:50:29 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.3? ([2402:f000:1:1501:200:5efe:a66f:4703])
        by smtp.gmail.com with ESMTPSA id z22-v6sm2021005pgv.24.2018.10.03.05.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:50:29 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] sound: pci: trident: a possible data race
To:     perex@perex.cz, tiwai@suse.com, keescook@chromium.org
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <864e211c-8be5-6a34-902a-a71f176111db@gmail.com>
Date:   Wed, 3 Oct 2018 20:50:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU0:
snd_trident_hw_free
     snd_trident_free_voice
             line 3870: spin_lock_irqsave()
             line 3881: voice->substream = NULL; [WRITE]
CPU1:
snd_trident_interrupt
     line 3798: snd_pcm_period_elapsed(voice->substream);  [READ]

As for voice->substream, the WRITE operation in CPU0 is performed
with holding a spinlock, but the READ operation in CPU1 is performed
without holding this spinlock, so there may exist a data race.


Best wishes,
Jia-Ju Bai
