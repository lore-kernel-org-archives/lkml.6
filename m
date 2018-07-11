Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CA520871
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSYOMoLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CA520871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389883AbeGKQqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:46:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35839 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbeGKQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:46:12 -0400
Received: by mail-yb0-f194.google.com with SMTP id x15-v6so10261112ybm.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11p/DDb57kLyQ17vMuu0D5xmFYijV2Mc8klG2+MKUjM=;
        b=PSYOMoLa0J/g4xfSNiqijK0mp/jizWeSm2Rtd69yrHs14WMTOWRtVyxtXD19CKTRJB
         aRL3OCESiIHHcUPgNWyo4tDm79T0QpOLg0fRkG5UwShTr4Zawn4jjsyjDfpp/7dv6MPR
         MU33TOx67+8KM/9IUo6CncZsGFNefjhesN0TADrPsIpInwomb+YMeaPlpUP7qMAclO92
         Ml1vqVldWvO1LxEshbQSvWMZj2AKSBra12NxwrsKdbOHWMs2KR9SMA2TrUjDF9PIK7dI
         0Eddr0E1IViAMGtvl04cOhWDaXmGdMXhLm/pg7Yelu3+hP6g97LF22LAP9K1qSySElLm
         EL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=11p/DDb57kLyQ17vMuu0D5xmFYijV2Mc8klG2+MKUjM=;
        b=PpimT3URcG59I0pR9ewp+lUUDLRGHBU/PNFUYN9oFpjN1Ven7fpjAwAS9lqrZqKAqL
         n8rzOBRKnbzn/lsoie6J7tCkfMD2DMpPK5G9+9zPo+JjTAdWssRp3fzWiSvZUkbrRBwv
         Suz0tuuw+egy7EZ4VdNAqKwCGh357V5OZoupPmHO7zC241OTwKC7KQraVHTOosf/sGRB
         d35nlkvVlLzNKrddSoQlk+OIG7J/XmLTeR2EElLbzIaNoIJ9IdCUgIngIj1OBuelspZ0
         VbHHTEHItyVwFFNGYzFALDfYCr+aXv1K+C12Y4PSZucNaQECYBxbVfS/+kZKo1gHLq2i
         7Waw==
X-Gm-Message-State: APt69E2KjOc97elwcV8W+ZDXULUhAECYS57xvK+iCDgQRwmWoUriy/9C
        ZvAEbN0K6EMbBGtKFojDGv8=
X-Google-Smtp-Source: AAOMgpeyRBiPD4DD1zfgHLoPae9xySS+RHRjqb5+PPYa8nq+zD/g6t5WOkreed45Z7dEd1G0Wx4lIg==
X-Received: by 2002:a25:18d6:: with SMTP id 205-v6mr15358053yby.430.1531327262822;
        Wed, 11 Jul 2018 09:41:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7350])
        by smtp.gmail.com with ESMTPSA id j11-v6sm9585537ywk.44.2018.07.11.09.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:41:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:40:58 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/12] blk: use for_each_if
Message-ID: <20180711164058.GC72677@devbig577.frc2.facebook.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709083650.23549-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
> Makes the macros resilient against if {} else {} blocks right
> afterwards.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tejun Heo <tj@kernel.org>

Jens, it'd probably be best to route this through block tree.

Thanks.

-- 
tejun
