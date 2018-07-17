Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5295ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B652205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Agg6I8Ya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B652205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeGQWtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:49:00 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44085 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbeGQWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:49:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id k21-v6so1161012pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LOeZH0S60js3KWDHVt/98HgMJwy/gNIt6M4GLg3vImo=;
        b=Agg6I8YaPg0r9u3ngwda2cFuaLxiEaj9Hm6ZDB/eeziZTR+cpIdOSnXO/3PJh93aNP
         dGnyyG4NP5qCGKbetNWfNEPPS2a4Jcb5q6KWS39tpv7YGU24nMFPax63LZ5P3Qy5lCCG
         aE1MhbClA8A0o/nbvbM2yXc/p0mqwBeR/AbqY/QZVn04Pa3TTMd9BKMMEDb5N/nIouyu
         TqTjo1FyUDrI+/LVzb479o/cN96I+BpEGOXsbq6WZJOq3bgBE+r3mp9SvW///n+yLdkP
         ocWF+J07s3ecge7Dg2c0bOVZmS9cyv9eqkJQXm7ZIVE7sMbokO3Pu6iazd3HCeGZbgeD
         mlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOeZH0S60js3KWDHVt/98HgMJwy/gNIt6M4GLg3vImo=;
        b=KvelM5Et3AWx7W0DKHcof2MPtEvEwWugdxnUBqFPzivssV2tnIS0vORRFOO4PTR9FF
         XfF0WFZqi7n8K5iB6svBQGsNJTcqqe9nNhsvCxgfI3puwqQMqO6zxMV0KvDeXXu7xsEp
         +P7uakVj4HFCSKixeM37NfYOJV5wobgdrDo17voS+HubvTWfB596KOmmBk+x818i3cSv
         FY9CECuT9Dwau63GMti1BXLVtubjap7gFer7s1c5X0xjwLmty8FSOuxjlFs94nK6jZ1Q
         ME4RYWThILQRO+zNJN6dbzccCR3BWa6ebfXa7CiKnF+jv21YAu+2oHmymdd2/6fvPeAJ
         5q8Q==
X-Gm-Message-State: AOUpUlFUW2T2xvonuT6mtrZhU1IW5PVSh05u6lqw8EsCwzjoCSvqFpgG
        5rhYWA5u3hpouctbxBg112KmsQ==
X-Google-Smtp-Source: AAOMgpdFKh7IS+edRdRsbVecel/bKvU1hKxiG3H5+Q8IN1Y5hUGwga3uwsCTPinuCkY75pgTOVP5/w==
X-Received: by 2002:a65:5106:: with SMTP id f6-v6mr3220006pgq.72.1531865657485;
        Tue, 17 Jul 2018 15:14:17 -0700 (PDT)
Received: from [192.168.1.56] (206-212-239-179.static.onlinenw.com. [206.212.239.179])
        by smtp.gmail.com with ESMTPSA id w72-v6sm7049128pfa.26.2018.07.17.15.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 15:14:16 -0700 (PDT)
Subject: Re: [PATCH] pktcdvd:checkpatch:Remove assignment if condition
To:     RAGHU Halharvi <raghuhack78@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20180717170212.17197-1-raghuhack78@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96cc7712-bbc3-25fa-06ce-876bd8068f61@kernel.dk>
Date:   Tue, 17 Jul 2018 16:14:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180717170212.17197-1-raghuhack78@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/18 11:02 AM, RAGHU Halharvi wrote:
> * Remove checkpatch errors caused due to assignment operation in if
> condition

Applied all three patches, thanks.

-- 
Jens Axboe

