Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D64C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06AF20673
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mSKdECKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06AF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbeHBRuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:50:23 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38976 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387835AbeHBRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:50:22 -0400
Received: by mail-io0-f195.google.com with SMTP id o22-v6so2360096ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=34yS/K9j2BHERKv+QFc9VaC9uxmcijLNrX90DPOpGI4=;
        b=mSKdECKMLmHxMQvIHgBVaEFsfdt4yIyNWHnjQ8LBEX2M/riD6EuKGRp4+aZ8WVyfMI
         5xb6S7MdQKgrtPapKxFdp4p/puoJ2ncTGTSKYCNhTr+6Ru81Z7G930PxxUyq5VXySjCn
         +qqr60NZJjIdcMqpvRe92wZ73IIZ93NUwcAzAx3m9SfROi8Y6VMwdgaltrenrtX0WYwp
         0hjGAPXyLcuMhZi9KafuT+zN05pvMIfLC8mBv842FNMWdGv2gpfv/P152/zRf/QR3QpG
         J81MiX+sIRX64K/7SQw/nvp20VUctyYpyUI4dyfiIQtQySOmnvsc2Igml7TN05UOVtGr
         nRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34yS/K9j2BHERKv+QFc9VaC9uxmcijLNrX90DPOpGI4=;
        b=pT4zb2IMhCEknZbZVZMOVc+xwHabDazvIEvpOb7c6G4kD+fB0y4k4uyRPJ6kTIZ08X
         8HweRZWGUzmvHgAn0LIgQGNNhqolI5BLac2TlqCFlA3X5HvfjVb7JPrlI77okWnJ0/8B
         uWtzdi2CwQA4OBvANToaOJ42S820gv7HcK4KJNgwlTkponBEjRWfEpsDIdXuoueO37Gg
         xicQ1ybvMiE1Mtye0PLCFOV+Z8qLQABZacx/KzVUFSamGwNMCmvMXX8htLZMLOWeGz3T
         a12Zk6z+lV56p4QKHZDiX+WubNeLuFwKfbB9PBYQAudTNyz8CAKX4h7uJV5geZWryQHi
         8lpg==
X-Gm-Message-State: AOUpUlEHH8s7Oqjx8FEgvxdI9Ys0Xv8Q0AOMalSOdFb/25Shwj3MMMxZ
        LdD8QhANfHaijCGUC/6kgngavAFYQVo=
X-Google-Smtp-Source: AA+uWPxPG3jW9cnGKj0vKRKqCh4iuI7oHRulQAEAScHFM/x9vE/NRllpaC8ZtaqGT8Y8zgK3WYqMZA==
X-Received: by 2002:a6b:1c07:: with SMTP id c7-v6mr3059510ioc.298.1533225515782;
        Thu, 02 Aug 2018 08:58:35 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1381051ita.18.2018.08.02.08.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:58:34 -0700 (PDT)
Subject: Re: [PATCH v3] block: make iolatency avg_lat exponentially decay
To:     Dennis Zhou <dennisszhou@gmail.com>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180802061541.49173-1-dennisszhou@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24d21a5c-f061-63ca-4571-ed32f1c8e2d3@kernel.dk>
Date:   Thu, 2 Aug 2018 09:58:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180802061541.49173-1-dennisszhou@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 12:15 AM, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, avg_lat is calculated by accumulating the mean of every
> window in a long running cumulative average. As time goes on, the metric
> becomes less and less useful due to the accumulated history.
> 
> This patch reuses the same calculation done in load averages to make the
> avg_lat metric more lively. Unlike load averages, the avg only advances
> when a window elapses (due to an io). Idle periods extend the most
> recent window. Bucketing is used to limit the history of avg_lat by
> binding it to the window size. So, the window range for 1/exp (decay
> rate) is [1 min, 2.5 min) when windows elapse immediately.
> 
> The current sample window size is exposed in the debug info to enable
> calculation of the window range.

Applied for 4.19, thanks Dennis.

-- 
Jens Axboe

