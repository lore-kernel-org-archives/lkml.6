Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C152088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdjjqmd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C152088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeH1X2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:28:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38589 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH1X2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:28:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so2615175wrc.5;
        Tue, 28 Aug 2018 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOQVTocrHK7+Hgf+X3ftMl9cALX2SXK+Qk7FPxQEWuc=;
        b=mdjjqmd1lGgnPkmNigTx5bKpmGWSNcLtKdJ8bTHM0Vn9R+JiWXELtKUQyBcwxo/wph
         RBwkUMmqztLkOEVV91sDCIeXk8cjRm1qWU7LJraWqsulARGHkYUnRPT9J+w+j3GI2V2l
         0RKlJZMS9Yc/EZdHpADttbUSSryfaYdv+oz6GBgogeG7iZRubFk+NIVTwc2I1QjB23NR
         fQrj974JVRi9L538+wK9ZiSWlDO7FypImFpQUfHScJlrwslxwFZ3ZyXHdcVs65ABX1NX
         nKo3k6kjtESegSDQgEtyn2LTWxIYgXcb3z05xazSwQa0iSs5jKMqmzVhV6naEAnmRXSG
         rBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOQVTocrHK7+Hgf+X3ftMl9cALX2SXK+Qk7FPxQEWuc=;
        b=HXMpTcIHq5W1hqriJZKL+N6tZrahYRfs5ig7LNsdNmj7PouFkpruT7DenVlQzmpF9i
         QPYDGecRTqwyh+df9TFqnBLcFwQ8d1woBzAk6EsFq7x4FTg22cDMczXc/jtmj6ERLbvR
         MgceYX3vwLa5jjjDSjaUWx+KZ2tvg9fQCvv78BLVfNdL2vhjB4mLU96GCp25gKxm+/gF
         PmVd++5DRMrllvbieENXHLv7xCDxjE3blB8+iUxFPgBXrrkMCrMa5KkgcwvRUsFc2gpZ
         2tT4+/pDGPkIwRfPHwM4LAXXS5velTSj1YMnbquu6df11j7NPFBAysPJCddV+XxlQ+lc
         pdGw==
X-Gm-Message-State: APzg51AnGTPr3QCZ1s8pEf+oK7Rx0QmGvMC5pFeWb1P9rw+hZypuulgz
        f4Rhxd4EsuLTxlr1PWzmRrYGf+DT
X-Google-Smtp-Source: ANB0VdZPJ8SzUQQVZ8boSIYLAUim6UEZtpmBIMr4y5J6phUL9DRncLD7V1Skx5729fvLMMJZVjiLSg==
X-Received: by 2002:adf:d110:: with SMTP id a16-v6mr2194589wri.17.1535484924711;
        Tue, 28 Aug 2018 12:35:24 -0700 (PDT)
Received: from debian64.daheim (p200300D5FBC8B7FCD63D7EFFFEBDE96E.dip0.t-ipconnect.de. [2003:d5:fbc8:b7fc:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id b10-v6sm1147603wrr.88.2018.08.28.12.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 12:35:24 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.91)
        (envelope-from <chunkeey@gmail.com>)
        id 1fujlr-0003ek-Bb; Tue, 28 Aug 2018 21:35:23 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Ivan Mikhaylov <ivan@de.ibm.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net/ibm/emac: wrong emac_calc_base call was used by typo
Date:   Tue, 28 Aug 2018 21:35:22 +0200
Message-ID: <13714694.2rXNjIIGUQ@debian64>
In-Reply-To: <20180827164336.8815-1-ivan@de.ibm.com>
References: <20180827164336.8815-1-ivan@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 27, 2018 6:43:35 PM CEST Ivan Mikhaylov wrote:
> __emac_calc_base_mr1 was used instead of __emac4_calc_base_mr1
> by copy-paste mistake for emac4syn.
> 
> Fixes: 45d6e545505fd32edb812f085be7de45b6a5c0af ("net/ibm/emac: add 8192 rx/tx fifo size")
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>

Always nice to see :) .

I do have a ot question though:
Since you are working for IBM and probably have access to all the
wonderful docs and the working hardware: Would you consider to be
the emac/emac4/emac-sync maintainer? From what I can parse from
the /MAINTAINERS file, there isn't currently anyone listed.

Thanks,
Christian



