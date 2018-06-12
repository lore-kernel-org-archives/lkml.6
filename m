Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3A22C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CBF208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="r/EaSXCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CBF208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934746AbeFLUkv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:40:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50698 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933895AbeFLUks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:40:48 -0400
Received: by mail-it0-f65.google.com with SMTP id u4-v6so1047567itg.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=crFxz+Wlg1ILelHcc6DAiBl76WhEvV6olBbyZgNyuv0=;
        b=r/EaSXCx3PycTaO7n55Iq9DpNUgslkASV6LKQH1bVYI8fxjGMAK7uRjJr6rwR80JdY
         Ci5mMAmr8I5N0U0joHasziv1doL+PHdxMphH4762YFZUjHr+kvXI0Daq5qW74FfBOVxy
         WtRz9mMLw5Vt23KE8nk9BiAxnkZFoHop6zdA79rGJdKRE9sSz0tdBbv29A6lKSVYM+PT
         JkOGceQci4Mghxtk2CWbEOyB17aJfLok8bedqRNGTXx25U2BMYXj/IAfwJfPbCLMSHPh
         TBmKiu3jAvHAD6nouju5hRx7NqJ9aJAPQkzzefiyndoRRdDg4JkjWkmIbMvpMmNlMDJC
         ORzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=crFxz+Wlg1ILelHcc6DAiBl76WhEvV6olBbyZgNyuv0=;
        b=dr+BPfOXvtbkUtmSsbdDOFl5sPzjqB03v7zyQJCzOoyXPbOwSrgIaY67PN/PmDmLgo
         US7kY7hQ/lcTjCA9Kl+h4LQmqm74qz3NWjO9UN84cQBGsAiFQ0tE+WgIBB11K5WOgQ6n
         +6LlrDCiVnrTtZAa3ODzSrXwBJrN1ViFzLUl5MQePEuwlfNcl3/2JWg4MMI+9A0vQMoU
         96hDo9BbIl76F6gZdyD+e9m5IdhS8rBzZIUwhvh4DHyyxNzg2T8+l5g1Z332btkCeWRz
         SvGeY3h07HNIwQZ9U5fbgy5jqyOJealGyY0rsQ80fPeLnW+So5lZoqtyYtZ0i3d2mqNJ
         PeyA==
X-Gm-Message-State: APt69E2IcB/iC7fe2Y9ZeQZLemcxXZEnBjQkVPyfoUHf7kFU0uVC/Ckr
        o2u/lg6X4if5og2BaHriIAapWQ==
X-Google-Smtp-Source: ADUXVKJUThRqTv5ZBTv9WJ1MDtjaePMejFO6pwk75UJGlL0jivX9rcWvwaEXAMFFjnat6E8q5jZ1qQ==
X-Received: by 2002:a24:4d8c:: with SMTP id l134-v6mr2036771itb.60.1528836047923;
        Tue, 12 Jun 2018 13:40:47 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id e92-v6sm296568iod.29.2018.06.12.13.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:40:46 -0700 (PDT)
Subject: Re: [PATCH 0/3] Use sbitmap instead of percpu_ida
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20180612190545.10781-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7a9f7ad-843f-58fc-68f0-79dfd4019c18@kernel.dk>
Date:   Tue, 12 Jun 2018 14:40:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180612190545.10781-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/18 1:05 PM, Matthew Wilcox wrote:
> Removing the percpu_ida code nets over 400 lines of removal.  It's not
> as spectacular as deleting an entire architecture, but it's still a
> worthy reduction in lines of code.
> 
> Untested due to lack of hardware and not understanding how to set up a
> target platform.
> 
> Changes from v1:
>  - Fixed bugs pointed out by Jens in iscsit_wait_for_tag()
>  - Abstracted out tag freeing as requested by Bart
>  - Made iscsit_wait_for_tag static as pointed out by 0day

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

