Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD9CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6BB20843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X82506Kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6BB20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbeGKQuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:50:51 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38251 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbeGKQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:50:50 -0400
Received: by mail-yb0-f194.google.com with SMTP id i9-v6so10258148ybo.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8FMTy5UjD3+BoZ3alxy0OZDOaVqEVwqKbg+QGf0d8bc=;
        b=X82506KxPaFfrq/enYA0wLaoPjR4qtYRAGzNgv6b/gPA9KhyUGGSZ/E/OOybxbh+Rf
         JwFqUQJypJi4EahFDfNRuxh83rbqIXmmcqUc6XjrJjctAt7b7SITEuOIuZ3JW6/ZF9xQ
         Q7/tciTMaXc4K9ZvHZjv/VQY/SrxQewABSQAyjzvO5xhUBtFSA12Ht9xvm226N8ClCFi
         RUbnZzmYSPvfpeDewAzQLtHiT2nX6z2L0m+SKZUxBMcSg5A2Jb1JziAW3XW0qG+h/gDg
         8R08cqVe1VmeLUy7BkXc1SC9yLVnEjce5VWsah+6A1rvOfquKgon+4vt9zV+Y+gQM+eo
         DQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8FMTy5UjD3+BoZ3alxy0OZDOaVqEVwqKbg+QGf0d8bc=;
        b=bDXgLAlpPA5qiRpCY1ZPG6K4B6tinba/bLnCiBx0olXs+Yz0LkHJ+dQpwyAdgDKxYG
         Ampsnby5BFOvpHm+9LXm853hUxlzmLYLFmeZgE6qd5Nc7Sbpurx5UT8+7Olw9J8KEz4f
         OKB8k7MCzV3rZRmHkYgeN3oo0+cxUi9SC9fvoB2OAAR/FsJlEY28GNlzYVLfs8GIBTlq
         GZcqeqESKyuQqtWLFcY2R1MQAA+IRGTLTb/mvXxXuXCbk5HVRibTw1tE849X+B839vIa
         KtAhImw+iIvOmO/hyT4Gmx13hRMjON3+LxUPh1Izq0o8QTwviqvFsTJh1wEUTTjsgIgP
         7e0Q==
X-Gm-Message-State: APt69E2yuw0/NOqSGQAOAzMItTmfLOog6JROW3rd/ttI4bthugiUigiS
        iin/NibtrxJyAolsSEezMNw=
X-Google-Smtp-Source: AAOMgpecouqTtLZ7lfSi7NkA3meqM+SwwISPxzC8+JdYYaGRJqSP4PovylmS1P27xGdjkPyIN5vRxw==
X-Received: by 2002:a5b:bc5:: with SMTP id c5-v6mr15191500ybr.290.1531327539957;
        Wed, 11 Jul 2018 09:45:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7350])
        by smtp.gmail.com with ESMTPSA id f131-v6sm24220121ywf.12.2018.07.11.09.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:45:39 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:45:36 -0700
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
Message-ID: <20180711164536.GD72677@devbig577.frc2.facebook.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-2-daniel.vetter@ffwll.ch>
 <20180711164058.GC72677@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711164058.GC72677@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:40:58AM -0700, Tejun Heo wrote:
> On Mon, Jul 09, 2018 at 10:36:40AM +0200, Daniel Vetter wrote:
> > Makes the macros resilient against if {} else {} blocks right
> > afterwards.
> > 
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Shaohua Li <shli@fb.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Jens, it'd probably be best to route this through block tree.

Oops, this requires an earlier patch to move the for_each_if def to a
common header and should be routed together.

Thanks.

-- 
tejun
