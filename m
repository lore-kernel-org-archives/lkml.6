Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A75C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02EE206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byDy9IwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02EE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbeLCClz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:41:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41264 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbeLCClz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:41:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so5567026pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 18:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ruamIwVU62U70nQ3x0f5qZ2ooxRzfwyGjKOqMHIMYrg=;
        b=byDy9IwHC2D3Zi8JH8s5xaCaPbMtQSAM3a7YTuGcTbXLVtDlUZxh9vxpRe2y9zqM5q
         LkDIzjCbSfOy+tgyILgAlw5rUjXatV7rluSvH79sgzQCpmKnAvYiUyvsjKNZdu0qSTWJ
         GRNVYvXSBiMO3bs7Xiiv26l0C2dU5m73VhoHhiadfP64zjNn/I8MxxkBYbPAWBd/dwGz
         GH+APGqK5hZ2FxdwX9MRgiRGuVFOO/v+fxz89owvQbV+Un8d8wyTZ7qe+JeHD0g+qbve
         fZspVdSnksR6tyFAcAOdpGr+2S4nEEkNrQROS2o9JOKQ0cySigl/VTA9ms7v1QehJGmu
         WEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ruamIwVU62U70nQ3x0f5qZ2ooxRzfwyGjKOqMHIMYrg=;
        b=MBDFMCBk+JY86zNFHFmM36ZBADULsR/FBDfjtPEWJIIHK8Kx3D/foCIY0Oz/4KzfHD
         tOu2z1tPwuvG8nnTWHXytA1lx+ru78bX3RBO6sMlVZYAgvr/V1G6IMNckDXg/p/0Q+V5
         kbeby5UIOlqCShcjcFw7M7bOhkxL39Vc4voXu2XqMjiD+hrbNTjjGzwz35Nxsqv/nHjk
         MXeCbphuBWj4sJaTJDqEx2OXJlqBHuF5WJWBCG/2jXCZDUmMzxVwEuPxW333YYeFSzYO
         9XRMIHAa1FATgMk+G7TAQno2hzd6JRPqoxUdP14WxuRaxbLoCWJlviuKNlReHY2OvYX3
         7r2w==
X-Gm-Message-State: AA+aEWawm7b8Jc64xO6L5TklgvnhODnZ5o+8MlxVS9VgCy1JK/grU8cE
        nSZit6LznmANQMalyiSt6UM=
X-Google-Smtp-Source: AFSGD/VPyUq1l+H+e81+BjqEVzG6cZ4ab/kyR1Z4wqNNChn1TYdoOoWgneaaYwKN8iPz7ktHOtVyew==
X-Received: by 2002:a63:4384:: with SMTP id q126mr11773799pga.160.1543804911360;
        Sun, 02 Dec 2018 18:41:51 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id l3sm17250244pga.92.2018.12.02.18.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 18:41:50 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:41:46 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: writeback throttle
Message-ID: <20181203024146.GA149587@google.com>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-8-minchan@kernel.org>
 <20181129022358.GA6379@jagdpanzerIV>
 <20181202231829.GA21560@google.com>
 <20181203023040.GA427@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203023040.GA427@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:30:40AM +0900, Sergey Senozhatsky wrote:
> On (12/03/18 08:18), Minchan Kim wrote:
> > 
> > Per andrew's comment:
> > https://lkml.org/lkml/2018/11/27/156
> > 
> > I need to fix it to represent 4K always.
> 
> Aha.
> 
> Then we need to increase bd_writes PAGE_SIZE/4K times in writeback_store()?
> 
>    wb_count = atomic64_inc_return(&zram->stats.bd_writes);
>    ...
>    if (wb_limit != 0 && wb_count >= wb_limit)
>        zram->stop_writeback = true;
> 
> bd_wb_limit is in 4K units; but in writeback_store() we alloc a full page
> and write it to the backing device. So the actual number of written bytes
> can be larger on systems with page_size > 4K. Right?

Hey Sergey,

I changed interface in recent version v4. I belive it would be more
straigtforward for user. Could you review it?

Thanks!
