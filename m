Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507A4C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FF4218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl1zYYLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbfAaPly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:41:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37421 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAaPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:41:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so1514333pgb.4;
        Thu, 31 Jan 2019 07:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9eb/DDIGJrrUN4reespc5rRrtGf6NGWspvQ3PZOhCN4=;
        b=Bl1zYYLA1ewY8ACzG3sMF/dOXyslwLNbzLJQ3dD2pItiBVVBNL1wMwgBwN9i6g5eSr
         3QnpaJ/cUuzvwTRQThtblOQd0A+e9wHmdLD2AUr0d23GReGujOpEO/MFAzkCN72HFz6X
         euL1NQnMqwHwGDwysT/T3LUTX8+TUGqT42UeIso5JnFvVjsXLTZrJEhAY3wVroajrsMG
         I1ulHPzHcS34CfaMqSA0kwQhIanjIA5WDEaMDizxsX30tnCS1Wul7zhHO7wav8xqRrUZ
         NuJiAAaEDGDHn5sju/WJFbOxqjB8SFPQa/O4HpE09e9e3+NLcYQ0vXiYcr60e9g58LgA
         HI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9eb/DDIGJrrUN4reespc5rRrtGf6NGWspvQ3PZOhCN4=;
        b=dLdgSXFjzsIdlWqe1ZfRNXqPRySCK6EmlwAPds5npTxBh8XaAHpcz5RrpdLYJo5xRw
         3XKReJCgdTBy3ynYZ1WQSad34qraGkoze8ehgkiMMYl3ccURDlcMtd3rUcHxWjlFs2FO
         +Tdcg2PXpql4JwqOe9rXmT8qgtRXYJ5N6pPsJdYRrlSUhWKaHHIbXXDf+YlPTcK8rI0M
         82nxA8MGa3G7jjTCmwsKoh8q3J5QLgP35K1b6XCEoPNkuFXjOypqQD4Bz9UxX467GnnW
         dcNXSP1T+inm3UgjVcXu8TO5FN32+GoMkku8LnKIXuxoC9/uvu1sDvsN7WxTl0rDyrOf
         rXCQ==
X-Gm-Message-State: AJcUukfYcw5RXIOOnL1G2Jqvq/hd2Zyi9bRQqiTJ+El3jCdNFRgEShdi
        FtYSAkhomr2fIg9qfyR7gSI=
X-Google-Smtp-Source: ALg8bN6Xctn+cx7EbW+0CGrcnDXt/wa+/2mYY+BsKawR+Dw0bAZZ9EwGxzdWoI1/3lqhh6tmdbznpQ==
X-Received: by 2002:a62:f907:: with SMTP id o7mr34732684pfh.244.1548949312982;
        Thu, 31 Jan 2019 07:41:52 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b2sm6622435pgg.87.2019.01.31.07.41.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 07:41:52 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        wendy.liang@xilinx.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: [PATCH 0/3] Enhance virtio rpmsg bus driver buffer allocation
Date:   Thu, 31 Jan 2019 23:41:17 +0800
Message-Id: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This series enhance the buffer allocation by:
1.Support the different buffer number in rx/tx direction
2.Get the individual rx/tx buffer size from config space

Here is the related OpenAMP change:
https://github.com/OpenAMP/open-amp/pull/155

Xiang Xiao (3):
  rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
  rpmsg: virtio_rpmsg_bus: allocate rx/tx buffer separately
  rpmsg: virtio_rpmsg_bus: get buffer size from config space

 drivers/rpmsg/virtio_rpmsg_bus.c  | 127 +++++++++++++++++++++++---------------
 include/uapi/linux/virtio_rpmsg.h |  24 +++++++
 2 files changed, 100 insertions(+), 51 deletions(-)
 create mode 100644 include/uapi/linux/virtio_rpmsg.h

-- 
2.7.4

