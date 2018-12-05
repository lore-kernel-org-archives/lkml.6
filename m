Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3EC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A603214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/1P3E1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A603214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeLEKJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:09:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47039 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbeLEKJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:09:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so18997567wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 02:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=i+xuE1gfyMXomwVNUBzYM7ahC9MyhTd1cIdmPNCtAbU=;
        b=F/1P3E1UwxDyEyYBNrO4wvKEfG0Ca+VdUPexzg6KW6T6WJsM7xoAtPAim7dVZ8RjJ5
         IqTy/PzwoF7uh+pMhRdvV//JeANsIDUyHnlcIIBGUFH+Ssbg9OSMofrRyk2d5kV8aMrx
         6/JZjRqq2VCcxHwNcK4ieBe+ZKm06bvdwaFos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=i+xuE1gfyMXomwVNUBzYM7ahC9MyhTd1cIdmPNCtAbU=;
        b=KqzraUkdb15Y3nlL6dB+bahA0qON8ru+A/efb2ZtWEPFyij6HPH5a2y7hzjK3yRGuJ
         gJH/nb6wL0Sopb61TY/XVB19F+ldsHFgL/udKl/Pz1QG22VG8Q6ijjNipaGjn0/yIRek
         /H9JeXv0itfAkYLjGSqwcGMJnZ0q5BHidlHfHRFw6vRPQql31RmMUw72e/0npK96B40H
         XNYc3dcKLtY1lBLDb3r4di5AH6PTVQQEBxRHEgt/h8bLaCL3QvUdTqs8tiR72wY1y0kA
         rO146mKWVNZu+6ViNLXXza5XhxPmmXl3Sy0r1BY2cD8egLNy8XdcfYMrGKz0iGsZnSRe
         ommg==
X-Gm-Message-State: AA+aEWZQF/BII/tDrN9IOOB4wUaZp66RZudEIYaelkHQ64QBflQqzhi8
        wdx0JSMQmEgpAr9gvpNtYbdPxa3SJEA=
X-Google-Smtp-Source: AFSGD/V43VMmDwbtHu1XPRIV5f3zMHYfqAbBD7FN7167poQgiY46CptpfVOToJEtKkxPo0QkxtmbWw==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr20654939wrv.236.1544004538818;
        Wed, 05 Dec 2018 02:08:58 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id y13sm3967115wrn.73.2018.12.05.02.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 02:08:58 -0800 (PST)
Date:   Wed, 5 Dec 2018 10:08:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v4.20
Message-ID: <20181205100856.GC26661@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Enjoy!

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-4.20

for you to fetch changes up to 48a2ca0ee3994df53da230c7079a18a70ec914f9:

  Revert "mfd: cros_ec: Use devm_kzalloc for private data" (2018-12-05 09:59:38 +0000)

----------------------------------------------------------------
Bug fixes:
  Replace release function: cros_ec_dev

----------------------------------------------------------------
Enric Balletbo i Serra (1):
      Revert "mfd: cros_ec: Use devm_kzalloc for private data"

 drivers/mfd/cros_ec_dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
