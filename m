Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF2C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1400D2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1400D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeLAB6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:58:54 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33201 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeLAB6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:58:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so6173566qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 06:49:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=uxj1TdQ+N/0u/inDjFW7suiF+Rsa0dxGigogQ8qIbDw=;
        b=LIf23190C/pN5Ew7lk+PNOUK7Y6jZccqDKT+JvPRvI8bftMfSAM9rChiCYKq6UTYpZ
         9dSybTSOcQwAXHvKPyyX5XFSfMErXTwpB5hUyEICXtjZDxuQBDY4g8YuYGwqvhIn77Se
         R9XJy7XVqkkuctdPEP0d22ApTB2AYK4WQtMkVobnjU5uxb4+vfaMYSYJP36LHIj0c3EJ
         fCHaF0UIgykghP5Ioz2BdP9Mo+DibLSwr8yw864JqyvP+C27TEUPPOOQYX4X50QjV3RG
         +tEywllteOL9wEFmhTwx2Mzj4TGbWSpLwhJUqfGUAczyx5Wrt+NmEZIMum14rJZPpy4h
         DeKQ==
X-Gm-Message-State: AA+aEWYVvT9R9KeQO48t4p0PH58nFBBBHDrYQVZIPYx51V4y/dYIy95x
        Go+5d/Aq8vrojBoWc5ZV6xUv6WZZhVU=
X-Google-Smtp-Source: AFSGD/VLCW1oBWMTUlDecQYNp4Q1R4RpOY0BR42TDrMusqago5pr/izRfVyzDpSSDCvkAnpHpY1oQg==
X-Received: by 2002:a0c:e789:: with SMTP id x9mr5838808qvn.245.1543589359673;
        Fri, 30 Nov 2018 06:49:19 -0800 (PST)
Received: from laptop.jcline.org ([2605:a601:a204:5901:9ddb:9320:fea9:f5cf])
        by smtp.gmail.com with ESMTPSA id v57sm3684910qtv.80.2018.11.30.06.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 06:49:18 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
Subject: Regression: very quiet speakers on Thinkpad T570s
To:     Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Tim Van den Eynde <redhat@vdeynde.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jcline@redhat.com; keydata=
 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
 X/87hZ4pdW/aOXUAgQ==
Message-ID: <bbba2653-d57b-5fab-8c06-5fd22ae80aa5@redhat.com>
Date:   Fri, 30 Nov 2018 09:49:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some folks have reported on the Fedora bug tracker[0] that the laptop
speaker volume is very low on the Thinkpad T570 when running a kernel
that includes commit 61fcf8ece9b6 ("ALSA: hda/realtek - Enable Thinkpad
Dock device for ALC298 platform").

alsa-info.sh from v4.15.4 (just before commit 61fcf8ece9b6 arrived in
stable) and v4.19.4 with the issue present are attached to the bugzilla.
I've also Cc'd Tim, who uploaded them and has the laptop in question.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1554304

Regards,
Jeremy
