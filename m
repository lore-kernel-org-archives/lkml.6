Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CED4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19B321934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrRK5aph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfBMD0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:26:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37248 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfBMD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:26:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so478924pgq.4;
        Tue, 12 Feb 2019 19:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nCOn9Ve9yqBekVlO3yWesqhiTFbm7Op2/KRGt4tdhxU=;
        b=FrRK5aphrnXowaC3kuycwY1El3+MfaZkA0hRd0NLnlqeyzv/5g6+LSO8beJ56pBXAJ
         uqAjPqxp0PHRQZyuu22PH8qYH2GhyBACG2m26ClEQ8UnLJbTBC+V4qfYPdGOCySooj21
         jAZ8PmX1i0ccw7BzJ4Cto87o+/wlfzUoSHW6we112s8Ez4ZH9pmtKA37En9cQVAXwIdr
         YJH9KvRa2gLCiE/Z5ABIUfYBR2na85WBK+WEb3Zz7X7tjOumAs3sreYS/WvYwCNkY8mL
         +KeJwuIpIrGe9veZhUCUGXfFnrKyOxN31upUtimvnsPzbV52QHV6yQo82Uzvf5UXS6Ci
         fqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nCOn9Ve9yqBekVlO3yWesqhiTFbm7Op2/KRGt4tdhxU=;
        b=ZN65wC4AvThjAF7c8rg76c3xwfx1B0ZJW2lb7ZuKfX6sqju7VBEnnEOW+6wIBwncL6
         YNzsJQ51AyUzgHsUOahAGH6OoGxi2SAiZppwn11umA3UI55ppAfxxhGjqIh9/anbrAGG
         rpUc1Y4tpOSECr+hzBQBpHRSazh//lDyR/KRKfLcBwme953JpC6GzB2KI5x+91gkaSEt
         hmrM+YB2C+ZIoOFEqHDp8iFupvII31vO5mInQZ1GudkF9rZPJ+FdcKuDb9oVVlk15Ks+
         5OlOBQDHwouzbQSgARyVA4CKxJdVGA6/fCGPlyKwxuUruTAjLtyTGFF6mcaBB67e48Tl
         QI0A==
X-Gm-Message-State: AHQUAub+E4g/zpHqF609jLnMwc9mtd+0AtNyshY4VZByvaIvx5IV9Z2Y
        gywA1wR2vNws1ksbwGvc05E=
X-Google-Smtp-Source: AHgI3IajoNe6ZdbN6BhxD/APFkEzFG/WPPd/zkKEfB+F2m7GXsdH1CVjARLTZq0H7QubDuxe4fYVzQ==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr2332781pgd.231.1550028392433;
        Tue, 12 Feb 2019 19:26:32 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id q7sm17337396pgp.40.2019.02.12.19.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 19:26:31 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, willemb@google.com, tglx@linutronix.de,
        arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next 0/2] uapi: Add a new header for time types
Date:   Tue, 12 Feb 2019 19:26:02 -0800
Message-Id: <20190213032604.2655-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series aims at adding a new time header: time_types.h.  This header
is what will eventually hold all the uapi time types that we plan to
leave across the interfaces after the y2038 cleanup.

The series was discussed with Arnd Bergmann.

The second patch fixes the errqueue.h header, which has a dependency on
these types.

Note that there may be a trivial merge conflict with linux-next
c70a772fda11 ("y2038: remove struct definition redirects").

Deepa Dinamani (2):
  time: Add time_types.h
  errqueue.h: Include time_types.h

 include/uapi/linux/errqueue.h   |  1 +
 include/uapi/linux/time.h       | 36 +----------------------------
 include/uapi/linux/time_types.h | 40 +++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 35 deletions(-)
 create mode 100644 include/uapi/linux/time_types.h

-- 
2.17.1

