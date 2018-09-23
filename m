Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620CEC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB121476
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RA6GO4Dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DB121476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeIWVHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:07:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53730 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:07:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id b19-v6so7272618wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=t0l+caL0jaQP3oVUj6ad6M66cbVZ/ycreckyNkTRI9w=;
        b=RA6GO4DckCNs22zOr9F6sdqMNlL7fUZdVBYwwj0nkm3dIwzOZry5YHFmpGklIZaDoF
         RJ4TUxajQ49+/jw8SvLlqxkgTo9HkzhcI8dHcTLgFt2AHeJ+p3uuY+T0/EwkwepJjENq
         1RiPiuFqafgvrExzPllzWFpTHA7gRXwP+zrLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=t0l+caL0jaQP3oVUj6ad6M66cbVZ/ycreckyNkTRI9w=;
        b=quCwuaxbASYRBpOt90Qa9eqZuoO58HOAAMR6C6TdLv1/DcmaBc/rnzT5rdWw7j/pJz
         j7IYOaW8xWRDpF/uztRPgadpTwOvC3eazZqbytv8bxxQnhL6vrxbD5Dbl4/R6HtdVI08
         g3a8NBLZX/P4i7/zbCSQHxBqC5MQ8Brk+xOVrYdnx1R8cGqG8WzlMB2qWXyzqgpSHolF
         V85jPxYVdaAHtqcDRj9iMWWz+OvlOWCZ4Rqxp+GNwdJ3Kulzqj/nG8G7CmSmKZbr3jXj
         Vds5QlkCwnOEcyEnRVMfr6EOwrx04kaRA36YU7OHdghfi9176e008pvdJ4X3ZUz7PAk2
         REVg==
X-Gm-Message-State: ABuFfohmHJVyxOe0P1LatYUUzFFftvLtcM5ryYk0/DTlg4628YmpNK0k
        og+kXVOputNBzwep0Ac5cvxq/Q==
X-Google-Smtp-Source: ACcGV621Fpc9JU3GS1bWXoS/VFvXTzvOXdMLogr/9DO688nt2eZHmSPEjMzlDWnzQ2g2bXo7zJ7xDA==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr4646218wmg.123.1537715351968;
        Sun, 23 Sep 2018 08:09:11 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id v6-v6sm7956865wmc.43.2018.09.23.08.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 08:09:11 -0700 (PDT)
Date:   Sun, 23 Sep 2018 16:09:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v4.19
Message-ID: <20180923150909.GH11050@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Morning Greg,

Enjoy!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-4.19

for you to fetch changes up to 10492ee8ed9188d6d420e1f79b2b9bdbc0624e65:

  mfd: omap-usb-host: Fix dts probe of children (2018-09-11 16:47:33 +0100)

----------------------------------------------------------------
- Fix Dialog DA9063 regulator constraints issue causing failure in probe
- Fix OMAP Device Tree compatible strings to match DT

----------------------------------------------------------------
Philipp Zabel (1):
      mfd: da9063: Fix DT probing with constraints

Tony Lindgren (1):
      mfd: omap-usb-host: Fix dts probe of children

 drivers/mfd/omap-usb-host.c      | 11 ++++++-----
 include/linux/mfd/da9063/pdata.h | 16 +++++++++-------
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
