Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F3B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="CQvC/oO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfAQAqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:46:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43904 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfAQAqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:46:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so3586182pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 16:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/JPwutdZOGHNIa3a27khUv254aBnRPfcI2+F7muCYWE=;
        b=CQvC/oO5wg9ZcwbuWlH0KE/b2lG2VxP8scWOswHzw3IRz7LDktkSvHJTY9ulRPBs/Z
         LgOh4od61s1WvyrNFY1EFav2ELy5Q11C04J3nlQbIX/MIx3iLadyuHTdAXTjjLqs813p
         J4wJIvVU6o0AXR5g2rgp7sfprf1xc1iyMwW0yhU70tnkXQqyCNi/wC1NnqGqR5EWmzKM
         Ns6lv3v5XlEKW9rSpeQJBhgQQFn4XVJ4p8UySxxhGpWD2kC3Lwt05McmBcx/gTgm9l8f
         cF36i0WhiP/InUDMUEJzmAxzCpF6frTfOqs6bRYag12OOHHzzmrD4N2q8hCa7c/UgnGq
         2HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/JPwutdZOGHNIa3a27khUv254aBnRPfcI2+F7muCYWE=;
        b=kxsIiO6QaV+3ecdWNbLEAjj8ZkWGLIFx97NU9UieunSjfEYvpZCPpa15Y+O2zJIqti
         8pLOGoJIGqc3weK+yAI/f2b1zE1zafV0ycgABT42640jWjQrXNbuOz/M+/yY3VUTQazI
         GMvKdIoj4fzzxpDZqWFQRSfbGv6cpchfSsacUn72itnCOgDTdsqNU/T0ZhW7A6lleCZb
         R6hmga9rXxE5YLQ+ZJyYabk8ZwVPG6VJVES/zAh7tQhVF35/9sENs/IROOy+ySlIjYeO
         0Oiw+vIGF0WP+fGeORfsDfKhCDruhqK1ynPO7W4MaME2obIwncF2l+RUavUdxatEnH0C
         heBg==
X-Gm-Message-State: AJcUukdXlF/ZRhVzWnAbiZJHWKbG9FfXVC1mJ6tAmOsKRJhP2l1M4XS0
        6KXYPnSz9lELfgREsb9nbSHCrg==
X-Google-Smtp-Source: ALg8bN50NdmjMkKbrBeywiHBB8pgCNxquDwI44PrnbcaKP4k0Fw74BMJpdET8WN5Cyn9OquZCsQAyw==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr11731445pgc.25.1547686013312;
        Wed, 16 Jan 2019 16:46:53 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:f990:e507:9c40:21df])
        by smtp.gmail.com with ESMTPSA id m20sm6903629pgv.93.2019.01.16.16.46.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 16:46:52 -0800 (PST)
Date:   Wed, 16 Jan 2019 17:46:50 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, James Morris <jmorris@namei.org>
Subject: Re: [PATCH] selftests/seccomp: Abort without user notification
 support
Message-ID: <20190117004650.GB17449@cisco>
References: <20190117003525.GA37918@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117003525.GA37918@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:35:25PM -0800, Kees Cook wrote:
> In the face of missing user notification support, the self test needs
> to stop executing a test (ASSERT_*) instead of just reporting and
> continuing (EXPECT_*). This adjusts the user notification tests to do
> that where needed.
> 
> Reported-by: Shuah Khan <shuah@kernel.org>
> Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")

The gift that keeps on giving :)

Reviewed-by: Tycho Andersen <tycho@tycho.ws>

Thanks,

Tycho
