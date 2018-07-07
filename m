Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BABDC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D755922479
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D3HVffht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D755922479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeGGCyl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:54:41 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39615 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932524AbeGGCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:54:39 -0400
Received: by mail-it0-f67.google.com with SMTP id p185-v6so19693732itp.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1nKjGlpH5jQKRmyhR/ECNjvVoni1Lqxj/g4DdgjouMs=;
        b=D3HVffhtd8sHBAswjbdIlG5eP8m9RthFQFmOHnbTEZdNsYUYOjXEXcifOMBzg9ZX1N
         Qdu084IIGSQnccTA2bkvjU5866dnP8oxUMPXDLXDlkMDDz3bRgDmZYAq+NitV2b9peHC
         ndDiJIRFFP8fR+SHsAqOtybGZvdXI0bB5hcxj4B3EywjO5CdxgaXP3MzzDrYdYopvsIB
         CqMLxudSP57f7Dxbx1k52dYn5eLURp7qs+Tf8NADUgTNtyVa2ZcAgJMD3YLNuYzOtjtt
         GBxbguLjIrNljF5aHFOMoeFtbTmV7q7t1RJlAfPhESmlVCYqg+dUZFIABmBMzvU6KrBN
         GYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1nKjGlpH5jQKRmyhR/ECNjvVoni1Lqxj/g4DdgjouMs=;
        b=okxCWUqd1/qtdLxDDT4wxQzlIiCDldP0yCyg1W9FzMhBEiC9h4hXfCNqX+ZkAyoilI
         RVAmBEwzMwXcbAkP8IJldDH4LDMsjA6j/cbe6QSzf7cI8deTioQ2NA7MtBvVoxpm8cef
         6F1oMTcyj/WnlZcy5uFP3Eb8yQXnXMtbUbKUpGYIxb5p0U4s0/mF+hkF5GuxJ4YRZbL7
         2VhhKDCfvr2/3YKPqVTMimoIsLHAGyKWjlH/7A8QE0IHzaiMQuKQAGbxjmHdSO+DHilF
         lmCbgC/ZJ+QDPc6VbbJ5Ca/CVG/8fDjRWs4qwJIFhKceQMUFn4yNw87jRb8iYTvh7Gfi
         IXaQ==
X-Gm-Message-State: APt69E2F+UPAukRfnFBqD206orUI1pOThwLVidhjsGeLaB8zjFdQTivA
        dwur32i8zvV092ij2NFqk+jF1zF1QHY=
X-Google-Smtp-Source: AAOMgpf5S822ciFblnXuZ/rASh175BkH4kjo6E6kQK36ueCdgFrcJRe4+GSkyE3Xg2LHz7DEOr3NsA==
X-Received: by 2002:a24:715:: with SMTP id f21-v6mr4324392itf.92.1530932078531;
        Fri, 06 Jul 2018 19:54:38 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id u129-v6sm1282413ita.5.2018.07.06.19.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 19:54:37 -0700 (PDT)
Subject: Re: [PATCH 0/2] null_blk: zone support
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, damien.lemoal@wdc.com
References: <20180706173839.28355-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dcfcc786-5023-8817-e6fe-26e04099d0a2@kernel.dk>
Date:   Fri, 6 Jul 2018 20:54:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180706173839.28355-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/18 11:38 AM, Matias Bjørling wrote:
> This series adds support for exposing a zone block device using the
> null_blk device driver.
> 
> The first patch moves core null_blk data structures to a shared header
> file. The second implements the actual zone support. The patchset adds
> two new options. One to enable the zone interface, and another to
> define the size of the zones to expose.

Thanks, should be useful for verifying write pointer violations.
Applied for 4.19.

-- 
Jens Axboe

