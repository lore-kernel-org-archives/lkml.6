Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A2D2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550766691;
	bh=GfUET69bQlxNimWghg/ebVa/cRwAwVpkfyzLxyrQ5LU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iB9ygvWexUMeemBTDk2FOLN5+EvPOCvwbp8cHpy5p2A3jmszxHwiIWhJszgHUPS0y
	 yYUCiY/iRs/7pJkdwSbINQ2WScwCsx6CJarZefp3ZqiuvsROAZKgPV/R8EQKVLK23C
	 237ITT682efP7/hpNL/nmSbvxQ73+dOCWi92uqLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfBUQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:31:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36530 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:31:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so24560655ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vTd9YGB3ArQGTIcE561PAaJxIKNSWC9vrSBCVXgcsBo=;
        b=M5j7VWssH0U3rAGyM+DD8Lb5pXitZK0iIb7CAIzmhb7qSUU4iQuTt7VMzrl/0DZRFw
         3+bbyZmVbGkevpKP7TpB4WO7ml/FF7p0I5Pl04cqGXBqzbYcQt1CKvJtIluP1JmMJycE
         P4Bd6C8aDa5cMOoHlWZ/kyUmfSsNdqHHxKY1ABNBd/7DZdm5XmHYYLzKmQq+Jt8pvIYM
         5wYA1wADSojtnAqScEjn2B2uNAJ/HK0IIzW30OUUyaLKiG6R4K8VG8oaSFdIKWDBkfkI
         Ith4MwLPZo7kHsZkTWXTet+h6RklTvWes3vRrb5B4mnyXlVfZsoY0oV6WieAg5s2XcrI
         /GWg==
X-Gm-Message-State: AHQUAuboaMSxpX0khB2Z8wAQSyQ1oZtXZHecPS5VSRnEbrYNfebv9GUt
        0N4QiEaJ67n3BkcE3xWFl9bRrx6z
X-Google-Smtp-Source: AHgI3Ia5Sord9PaARByMnrTv/qG0j5NWGdXtc5RPgsafYDtvGlAfAWLAWV1fR7IIh8eEK48a8CMReQ==
X-Received: by 2002:a2e:9004:: with SMTP id h4mr17803128ljg.76.1550766687393;
        Thu, 21 Feb 2019 08:31:27 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h123sm5783967lfh.26.2019.02.21.08.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:31:26 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gwrFu-00052K-Od; Thu, 21 Feb 2019 17:31:26 +0100
Date:   Thu, 21 Feb 2019 17:31:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS updates for 5.1-rc1
Message-ID: <20190221163126.GA19338@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.1-rc1

for you to fetch changes up to d4584bbfcf2a8f5b6605be9eba465bba59ce68c8:

  gnss: add driver for mediatek receivers (2019-02-15 16:54:38 +0100)

----------------------------------------------------------------
GNSS updates for 5.1-rc1

Here are the GNSS updates for 5.1-rc1, including:

 - a new driver for Mediatek-based receivers
 - support for SiRF receivers without a wakeup signal
 - support for a separate LNA supply for SiRF receivers

Included are also various clean ups and minor fixes.

All have been in linux-next with no reported issues.

Signed-off-by: Johan Hovold <johan@kernel.org>

----------------------------------------------------------------
Andreas Kemnade (5):
      gnss: sirf: write data to gnss only when the gnss device is open
      gnss: sirf: add support for configurations without wakeup signal
      dt-bindings: gnss: add w2sg0004 compatible string
      gnss: sirf: add a separate supply for a lna
      dt-bindings: gnss: add lna-supply property

Johan Hovold (3):
      gnss: sirf: fix premature wakeup interrupt enable
      gnss: sirf: force hibernate mode on probe
      gnss: sirf: drop redundant double negation

Loys Ollivier (4):
      dt-bindings: Add vendor prefix for "GlobalTop Technology, Inc."
      dt-bindings: gnss: add mediatek binding
      gnss: add mtk receiver type support
      gnss: add driver for mediatek receivers

 Documentation/devicetree/bindings/gnss/gnss.txt    |   1 +
 .../devicetree/bindings/gnss/mediatek.txt          |  35 +++
 .../devicetree/bindings/gnss/sirfstar.txt          |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/gnss/Kconfig                               |  13 ++
 drivers/gnss/Makefile                              |   3 +
 drivers/gnss/core.c                                |   1 +
 drivers/gnss/mtk.c                                 | 152 ++++++++++++
 drivers/gnss/sirf.c                                | 256 +++++++++++++++++----
 include/linux/gnss.h                               |   1 +
 10 files changed, 420 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
 create mode 100644 drivers/gnss/mtk.c
