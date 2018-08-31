Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626AAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE65B20843
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/9mMmrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE65B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeIAEDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:03:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33447 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeIAEDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:03:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3-v6so4886470pgv.0;
        Fri, 31 Aug 2018 16:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Dzh6X1LeduszbJqJBX4HPFELRK/l+JfoD9XBMT39dE=;
        b=f/9mMmrONaw3756VsZHYnD9lPNuRAIpZXV5H2BlWr1Xr6igLZ0FpFHlXCRbBtojtNy
         GpwCwKuL+uqd1AcMMFO/SobXCvuw+yVasiYZb18HOAVNCjywWYAcPEKmExEU45i6SOFz
         9iGQsDmX5CoWvyN0m+MGtOVn57yLekRTuVuLDwMA/6NUAS7FCic6Y6OKLr880N/AYBTY
         qQmtebskBCnx5OkjmxXx6ULGZHTTJaq63ejOGWqxpP2tvkNbw6azdyTOIYHyI3Iw6q+T
         C4Kx42hI6O1JkzQZJKVarvuraMyc6PLMWDzJaH47OVfYKZPh2DT95y5TaFPHPa5GBa6S
         8hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Dzh6X1LeduszbJqJBX4HPFELRK/l+JfoD9XBMT39dE=;
        b=QsG4fEtXzzFZotgSwuW1g+iTy0FTTYxMEHn294fbDGLbsBJKMj9oDrIRun6qnIMHJs
         8CprmRAenkCEEoNCjTy3w7bu0Q/Y1wtGAL/Uu96avosOfvKNjzTKwwwK9kx26Ktv4H5B
         FI39SfXBsp0QLkNAwai2nOq6TJEU3F0zzbylvShiojQ0mm79kWA+Qme4YLUokTxMcZg7
         OdYGsvnVQuqTPkalQ1umRdbbyXAXKz9LQIgQdu4z/gc2lk8l3Dn88+ASx84ZMErBK1cr
         GFodUQnjQRwKOSz2jg242an9GgH4Su2nUNVoS1VWs5vZtg+TQKKc2e36kt9QEHU7v6sl
         yRig==
X-Gm-Message-State: APzg51D2VGqt9XFcW66jyZWAzDNh/p4LaWDkyrBf/0mlelkAjnvhl+IO
        fNF0a8V3jUd37MGW+E08AZA=
X-Google-Smtp-Source: ANB0Vdb5V0w6e0iWptA96twrC9ynCXYuX3lieOuGp4Bgh9rCsGM8vxgZfiNQRDDJimSnkcAkS0aZwA==
X-Received: by 2002:a62:46c8:: with SMTP id o69-v6mr18498978pfi.21.1535759611718;
        Fri, 31 Aug 2018 16:53:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id f67-v6sm46037699pfe.75.2018.08.31.16.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:53:31 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:53:28 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] blkcg: associate writeback bios with a blkg
Message-ID: <20180831235328.GG1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-10-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-10-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:50PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> One of the goals of this series is to remove a separate reference to
> the css of the bio. This can and should be accessed via bio_blkcg. In
> this patch, the wbc_init_bio call is changed such that it must be called
> after a queue has been associated with the bio.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
