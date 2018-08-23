Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3654AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67BA214FF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piQLyvK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67BA214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbeHWNch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:32:37 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:36909 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeHWNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:32:36 -0400
Received: by mail-pg1-f170.google.com with SMTP id h8-v6so2336793pgs.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4zngk/ovk4zRMNoeFWM7Pgz7CzofGXFpRqP4af0L6kE=;
        b=piQLyvK0RNd1I84K+KSheGosyzKAta8bbs5ar46IxsYoZ8DHDoqADf/EDxGtbMpBuK
         Ecog7cAWSnUZWZmZ4hVMMvW0iOFO1of4Hl1iPnqRCYCbl7P8SElp7rZludkBnChhJDGZ
         jM23QplY16Fx2J7kQ9TKMBSqunw0VrxYGb9MOUvgdh2RBoIeqF1e1TIMingQfg0J5z09
         8fw7HzMwqKkl9VXjf3RHnmIyLQormtDyVBHCA5KU4qXiKhxI//fckhsHLW25XoLa6QrD
         4k2maF/CxiC+SnuTDI2narxtcYfgoF7AhYZuBRPxJS6BPuwt+WiyqEtx+jvo3MfoiXFo
         +fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4zngk/ovk4zRMNoeFWM7Pgz7CzofGXFpRqP4af0L6kE=;
        b=s+a89727L2nYEPy6umRedPiBZ+lt2vKAaia9bbNmCmt/bH+z2ZMeng/Tr8Ah9TQALT
         0LUxhrrdUuiTGVgfRZTJmfieylVbRNExsyX012VxPB2kFNaRmWlQgpQxJuxwJ93115pH
         FI3JsqOnWTqjPvPhds9Vb872tf3bKaiF0NR/kzQ8vNanlhpGctTkU01NnwaYfmMkQT8D
         wVSFp/f8Wz4UbYfTpAB7dNFcLIJNTVUU83wOTxg71xlKInW78n7v1zH56xsGgTpc9WBH
         NNfnyizLSBW/MgWwZoEdxF3+W+vfdbeuKjYZXEawL1dMGaFTMfJFNKAZOWVAlw8sc25x
         2gZg==
X-Gm-Message-State: APzg51DyNflIVBUSBN2VbsvsmoKYi/GgByCkwju4XCJBe2DMjJ5tce1V
        +xEP9ZQPGKYcWhTdwwvDqvWvXD2jJSo=
X-Google-Smtp-Source: ANB0VdaM0mWFxN+Ul0TeCNYgW8DmESbSS2TIePgWyfY2EIPGGq13APd5YykyWFV4axY5YRI3DE6zpw==
X-Received: by 2002:a62:1d54:: with SMTP id d81-v6mr9796050pfd.139.1535018619819;
        Thu, 23 Aug 2018 03:03:39 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id i3-v6sm4264991pgq.35.2018.08.23.03.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 03:03:39 -0700 (PDT)
Date:   Thu, 23 Aug 2018 19:03:34 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: null-ptr-deref Write in binder_update_page_range
Message-ID: <20180823100334.GA17523@dragonet>
References: <20180822060704.GA12007@dragonet>
 <20180823052956.GA28628@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823052956.GA28628@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you test this patch? I found that bug a month ago but didn't submit
> yet.

I don't have a reproducer now. I manually analzed a root cause of the
crash using a fuzzer's log. The log reported a race on 'alloc->vma'.
Because I don't have a reproducer, I can't test the patch. I'm sorry.
