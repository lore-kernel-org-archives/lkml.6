Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51475C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDF520817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 04:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tkdtgRzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDF520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbeKQPFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 10:05:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34377 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbeKQPFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 10:05:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so11207437pgg.1;
        Fri, 16 Nov 2018 20:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7iWpdyJV590O4cSCeR1t6B4S8oj3mdJVRzZM2wdQU3s=;
        b=tkdtgRzrXXnxwiknKQjiupdYzEeC9ZxCIkjm7/trJCfyTGMmmqTal+lfkrva4yakeT
         /5+7JIOfBY5CGY/p2b7caXQlytedhA88b7ZjWEoPg9aFdgkeJu/EFN8xOclNEMfKbkjO
         IvVK+4++gKmF3RyiC7xSdRdNyap2uK5uEyFSlKtFHkRgjPOvbwopnqY8uDNYO4RKvbru
         5F4riZquHa0HkD131yH2YoZV+1m7jjSqASDalvMGmUl/XxPa/AnMsjvzCZFpiClvhqm8
         HxetDKFwDTFczdeifogAK4w0f73kr2YjK3lmp4o+6eqNRun0lJzHr2E+DO8Fhnoh2g8A
         zStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7iWpdyJV590O4cSCeR1t6B4S8oj3mdJVRzZM2wdQU3s=;
        b=VtdOm9dlkOYdb2TThbZj0iWxE4H73SOVADWs1LsPcQRYa75bgdGW7tahShOiH5Hzqj
         Q1MWaX1R/Ak77g8EUsz2PJdXXwKzbWR368XidSy/9eL2c3r24bgVlGD8uQ/SHnMgR9XX
         kVvJdvidoIHHHikn/lR7BuSus8ziNil2mXJkXtDPVLuwt0cjIptw5nMKnbEcujVl34uT
         jCZpPQtB0gOks3E0yqysoTqhUgwsGTizT0HQxAo1gi1cQ/p7EDsEgOKlk+6GqFm1biWY
         R+0zzT7B4gra3k2YLsz7i+3XuhrNq2ruGB92VLhdlT+YctfbZhZhcG3XYn085JgYL05n
         hdow==
X-Gm-Message-State: AGRZ1gLmex+SlnLumQ0v4q/4j4xB4iYZsbKCy7PkdJt5Zh2P3+TmUzJI
        2ScXFBsLQHXmrF7/M9bY1qI=
X-Google-Smtp-Source: AJdET5chMF3L/a+HGwkZqUgVLiPHxclog76YH8cCBk5sxNKcSNNd21Yd35FejAU4cWqUwfFsgrLF/Q==
X-Received: by 2002:a63:484c:: with SMTP id x12mr12399807pgk.375.1542430200217;
        Fri, 16 Nov 2018 20:50:00 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:eb1f])
        by smtp.gmail.com with ESMTPSA id s22-v6sm60067166pfi.15.2018.11.16.20.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 20:49:59 -0800 (PST)
Date:   Fri, 16 Nov 2018 20:49:57 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][bpf-next] bpf: fix null pointer dereference on pointer
 offload
Message-ID: <20181117044955.c6x6lnajgrlnpoeq@ast-mbp.dhcp.thefacebook.com>
References: <20181113092926.27081-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113092926.27081-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 09:29:26AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer offload is being null checked however the following statement
> dereferences the potentially null pointer offload when assigning
> offload->dev_state.  Fix this by only assigning it if offload is not
> null.
> 
> Detected by CoverityScan, CID#1475437 ("Dereference after null check")
> 
> Fixes: 00db12c3d141 ("bpf: call verifier_prep from its callback in struct bpf_offload_dev")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, Thanks

