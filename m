Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1867EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DFD2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SmXm6mvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DFD2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeIGVS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:18:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42436 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeIGVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:18:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id g23-v6so6821677plq.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=2kbaJjPILeU0B1EdO0Pi2txBfrE8aWx+C1uzYIpdRII=;
        b=SmXm6mvt8j/P5n+OnDWBSFoxgiR9Mf+hK7XnRXiG5fK6TtaNGvpfAsQw0ka+a0ilzD
         MF6APVBrcVSUdNr2wKjwd0+izdNzo38pYAhawAPGJQ8CyDMuWMZ7h6d0uKmQ35TrjyM3
         ut9zuj3KY0b2MnC3DXAQM5Fotk4b8qXbvphkM0WjA1dDoVx81+wmcuCnDLS1bGAUig09
         g239egus7Nf/BnN4T+Qlc062XrKc/lqfgIW/kXM5K3+y0TXu05OYx/Yq8QNFg5BCIhVJ
         iMaRZylLl1qt2cWhT+omWe2hqMkGKmWQpt/B4hwVgqfdht7imMMAe3TpWq0rsgRtGOCS
         IUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=2kbaJjPILeU0B1EdO0Pi2txBfrE8aWx+C1uzYIpdRII=;
        b=VEPVQsTHUTLsrTi4W39gV2m2rcQCkX3w1ss8dzJDrlgyksQMfo0a6ioKl8P/o5bniV
         6va0Lsi/NKpPKcD4NSeUx6cLepIWsH8H2uf3N5s4FMInVg9nXc3fKzPyeGUBOQ/QJqGn
         tQZmFM20CrkMvo6UyqG8D++Z3HQB5tYnhWm0zo9cCkWHyHdBy6uyy5W+17eV6lYvT7T6
         ZV7vSXULN6QmPPMtwoj0NbGMlyv3GS2zHlErkroWS6zySHqOBqLQUJEa/7CnRQHmTDsh
         8lRSTfHDpkEoTs8ruzjpHw9nkDWRId6DyiCuctJQiCUgE2Yc+lniZG3tmkTNck3RwKmo
         2pbg==
X-Gm-Message-State: APzg51AoQzWIrGLTuynInzzQDyJxDvIlzJhYYj4yAlcdLJhpf/k7bLQl
        8ZJmkSChdSSzV6PnwAro53tgvA==
X-Google-Smtp-Source: ANB0VdbDGAX7wzFxQSbQA/CSutNCAeUq9GsvweD/lTt7Ww2AGdSj1QBmAECdiOCPDD+Dgi0DdF2tmg==
X-Received: by 2002:a17:902:b03:: with SMTP id 3-v6mr9023501plq.156.1536338204235;
        Fri, 07 Sep 2018 09:36:44 -0700 (PDT)
Received: from cakuba (89-66-82-92.dynamic.chello.pl. [89.66.82.92])
        by smtp.gmail.com with ESMTPSA id g21-v6sm22414133pfe.41.2018.09.07.09.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 09:36:43 -0700 (PDT)
Date:   Fri, 7 Sep 2018 18:36:36 +0200
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     jun qian <hangdianqj@163.com>
Cc:     Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet:netronome:nfp:move spin_lock_bh to spin_lock
 in tasklet
Message-ID: <20180907183636.48a681f4@cakuba>
In-Reply-To: <20180907162117.47361-1-hangdianqj@163.com>
References: <20180907162117.47361-1-hangdianqj@163.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Sep 2018 09:21:17 -0700, jun qian wrote:
> As you are already in a tasklet, it is unnecessary to call spin_lock_bh.
> 
> Signed-off-by: jun qian <hangdianqj@163.com>

FWIW you should put spaces after the colons.  It's generally a good
practice to look at the prefix previous authors used for a given piece
of code with 

git log -- $file_path

This would be a better subject:

nfp: replace spin_lock_bh with spin_lock in tasklet callback
