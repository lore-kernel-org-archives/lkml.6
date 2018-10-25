Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31086C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBA120848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm/sZjQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBA120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeJZAus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:50:48 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:46803 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZAus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:50:48 -0400
Received: by mail-yb1-f170.google.com with SMTP id o8-v6so3908765ybk.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uNYrhB8InvHfItUHkU2voCkYIm4nm7FupVEQyUBT2L4=;
        b=bm/sZjQpOwgsUp3DPTzG6ksVtluwxHjvJZR3drnBl/SNs6JKiP29WGMTbXkj8KnbHA
         eEzu95bAXxXe56r44NEKw+jCP/1sSGpfG4R9rl9ntG0BXgtNwpSZsvNJrEjuzX0qy+/g
         XHgqrirj2k1djcL/eYkym96ChagYKo/LylPHfz4bEEhEK/59Ne0uHcO4dCON+1Uzs3W+
         uGByRS1NpmOPSaT6rRt/145yovPDpJZOgwclWD2g9NySjXYzwgPGzdqF/l/a3VsoSJAu
         Il/NMvto9c4czJD6D1tRoEipTF2dMnygNNG+q4t5UfOdDvkeEV7o6Pg/L0E7f/JyZdTx
         q/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uNYrhB8InvHfItUHkU2voCkYIm4nm7FupVEQyUBT2L4=;
        b=iJQmNge9RyYgAQu+liJ6sT/26VihTjfAkWS9mWHfEahgOVQ8jnRkSbSVI7fFscd8pk
         dXWG/PguYyo0XMzDY+S2d8fQqV+t30DAllXFYh61oB3fAdgluHaQsZMRJTP3ODXQMFp5
         CRhUA51h/xCcwr48ejPxP/6QG8Q8Tdd0HMLhjRQ64lm+Twb99EA5Ky5Y5lzgJEp47jyT
         88qomeU1UaUvG9AG4mbXqOMaAJ7i4A4DtoUWxrD+1OVXNUekOz4fW1qn95w2JXRX2OD+
         sj56H/uOLinlVNy8nKFvJoDzJ2x+Iiob74jqhaa+UfxMiT3IEDfU1c5J3SkIyIiL2ytf
         ENZw==
X-Gm-Message-State: AGRZ1gJVRBqST195CicwIyB1ROffD+wHq9lkB3ddWmK0H9zO2I3rLhNP
        cQrWUFODZQtSZkYj0F653zg=
X-Google-Smtp-Source: AJdET5eFCRiKn9KVPHhRVC14PatUAhdwRZnGE+0rBI1kCpFZcNV023KUZkRRLntv5nmP1quzm++iQA==
X-Received: by 2002:a25:c1c6:: with SMTP id r189-v6mr2110638ybf.29.1540484240105;
        Thu, 25 Oct 2018 09:17:20 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id n62-v6sm1937069ywf.105.2018.10.25.09.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 09:17:19 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, p.zabel@pengutronix.de, denis@eukrea.com,
        rmk+kernel@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC v1 0/1] imx-drm: match ipu_di_signal_cfg's clk_pol with its observed behaviour.
Date:   Thu, 25 Oct 2018 12:17:10 -0400
Message-Id: <20181025161711.13727-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

Request For Comments

We believe that the ipuv3 DI's pixel clock polarity is possibly being
misconfigured by the imx-drm driver.

We used an oscilloscope the observe the actual behaviour on our hardware,
and it is the opposite of what the driver is supposed to configure.

Some confusion could arise because the Freescale documentation does not
speak about data stable on rising or falling edge, but only of clock active
high / active low:

i.MX 6Dual/6Quad Applications Processor Reference Manual, Rev. 3, 07/2015,
page 3298)
  bit 17 DI0 Output Clock's polarity
  This bits define the polarity of the DI0's clock.
    1 The output clock is active high
    0 The output clock is active low

However, the supposedly wrong behaviour has been in place since April 2014,
and no-one has complained so far.
See commit 85de9d17c485c4196f74d45de2206d4802f8a3be

What are we missing ?

Sven Van Asbroeck (1):
  imx-drm: match ipu_di_signal_cfg's clk_pol with its observed
    behaviour.

 drivers/gpu/ipu-v3/ipu-di.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

