Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A1EC04EBA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3569121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="s6TA9BR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3569121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeK1IAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:00:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44709 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeK1IAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:00:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so15473118qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 13:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+oB3NQ6DcHGeIHckr9cxaNYbTfbF5HSphI11S9KWTQ=;
        b=s6TA9BR+Y6w/5h1lwrPObaaUUawuQqf64/Sa+x+v3JxRRzJ57egayvruUwD9bjd+Sv
         q52LBGdh9SNQPlHfTlKYm6TWbbJqF/smr6Ea9KRseqDzubjyjQ1sTanXW1BHYoOTuU5a
         3NZ8/eJE4EYKKA+LZUO4bnLBGQ1PCQDzG4/7UTKoQfoGKdM61nGItxtYEjl27flovFMS
         bPdZIhr4xB553ypzY21QJ6OAAn8rjTUX51v1ZGKGQi4Ingk2T74IA3yrxYbNeKZC31+F
         nNI3Ju76jqgUvDTysHyezpw4/DQuY6vCU2/AeUFqOTy2zTvTMQxXsSJuoUqJVc/CsX1G
         HQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+oB3NQ6DcHGeIHckr9cxaNYbTfbF5HSphI11S9KWTQ=;
        b=VMtWYd/3oXTJzeGQA6YRcMUc6rnPycy8XdtC/vn3nxpzF1+leuwuV9lfNBdZY4xi7A
         pEaYC4Yku0VSOEzdADqzmrRSNjreHfQiQ2LpH9Q9WaGNsTu2BHyLIdwBf+CVNHhDrP8d
         PwpXXFXNINcxd56L8oS+n+KMidsvLu6jnSfJVQWf8T8Bar7SsqtqyFPI1QmIHdJ1j6Hp
         3SCkejGH6Zdz3MZ8pjpv1p7tnauNBUTMGzxUqxk6tu7IgEy4RdFMk/hsXRlcHAmTpy8X
         z+8ZLnCS/dzmbZ0Lze6/luV8oWV7ALa5A+fPDmfTKOT+dxy3b45Ham5ZYpj16I1kjeJH
         877w==
X-Gm-Message-State: AA+aEWY1+H/PbwPv29I3EqJxBc+qDR5U6lTTiC30tRFmODf2dll2Pugp
        Fq/dt1X7NkmRLgeDvvgvul25oA==
X-Google-Smtp-Source: AFSGD/UTx+D9sHgOgVDvLn9iNz53MWss5o+Ab+zLZLpWM9J4WAS9cHQbtjjXKPmYC7yMNE7W1N5KTA==
X-Received: by 2002:a37:1b46:: with SMTP id b67mr31694458qkb.144.1543352495953;
        Tue, 27 Nov 2018 13:01:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4c40])
        by smtp.gmail.com with ESMTPSA id u16sm3672633qkg.14.2018.11.27.13.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 13:01:35 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:01:33 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] blkcg: convert blkg_lookup_create() to find
 closest blkg
Message-ID: <20181127210131.7cdgku7cmixxwdbc@macbook-pro-91.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-4-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-4-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:36PM -0500, Dennis Zhou wrote:
> There are several scenarios where blkg_lookup_create() can fail such as
> the blkcg dying, request_queue is dying, or simply being OOM. Most
> handle this by simply falling back to the q->root_blkg and calling it a
> day.
> 
> This patch implements the notion of closest blkg. During
> blkg_lookup_create(), if it fails to create, return the closest blkg
> found or the q->root_blkg. blkg_try_get_closest() is introduced and used
> during association so a bio is always attached to a blkg.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
