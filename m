Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AEAC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5987120844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCBfP2Bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfBHOV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:21:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34597 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfBHOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:21:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id z15so3799019wrn.1;
        Fri, 08 Feb 2019 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gUB+JDm6ngiH7o/TLxKdajNKMy82xD79okyW720Fx4o=;
        b=dCBfP2Bl6sEEV2XB0tvMDTPMhI7JZV+ZdqUhYwSgXilslQaMWWOQC/NgjXWr9KZ3EG
         8rAIHkgYebOgUm4tGQtgmHRdevpRD20Me6jpPvR9du4QIP99ZmcDdJJPz5HoZo+UbJJp
         cthQ13YPDw8VbqjqPeQMTglam4PyaD0GC1UdKJx2/Ri3IOjZv8BdB/wXtoHPQXgFuuhx
         s/enl9O9pWP0cI4zbc6RpsvfD986co7mvEFeLhE7LBR7eAcUkWbBS9H/xhV4KL+kkLLk
         0s3kKgXGQaZcaond9eQHuuRoNX8a8Ge42iucrSn6mO51TsyieaevMGCNQlE2b1lArxze
         VPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gUB+JDm6ngiH7o/TLxKdajNKMy82xD79okyW720Fx4o=;
        b=HWpxOc9GIEXRCBrZ6TsQe9G3T4M+XaZ9l2i2RDlUT+15cD0x5IwsVSHpnKOJI6MU0F
         efBXYtqvDWHMi/N6RHEZ2O7xPLfRLofz8HoCSTqSCk5zdozGAzH58zS2clMHmbIKCEOH
         VkZd6tNOeBh5ynS1GTkKbFXDFABdDdr9TH4TEYwFokB3IHa+8Q/G+fOk2ANKLBC8XjNM
         SM6WQOq5dW5DyuMWbh1Nir+rZH+/Hu9aVSBNHW4Wj8oV1Jn6njqKKczIV1jCSQBNuBK8
         F1Z5FzbSgtho9JxrnQ6V+h0Suc0+kzEM6mff+79lfXNRU/TLybr7WxCPAEu2dkrm+7PY
         mEjw==
X-Gm-Message-State: AHQUAuYfAddFdfYe8YhWten77RlW5is4Tvwc/Ld6E2utiMSfkQIgODjg
        289WHxIbFUPjZr9RmMK60Ry7N/dO5tjCoCw21kA=
X-Google-Smtp-Source: AHgI3IZFonL3sS/Cr+dH8CglD0FOVZyVKaxHxvxhj1aWHh4mkbsJURtrwBHlBsaNv5cM4zjpGNQ1xzv/8s9RGX1LQBo=
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr16409541wrv.132.1549635686355;
 Fri, 08 Feb 2019 06:21:26 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 8 Feb 2019 15:21:15 +0100
Message-ID: <CA+icZUUs-OYuSs184jC+RivsyLmB5sLZdkfxckSTYrq2ibJS=w@mail.gmail.com>
Subject: Re: [PATCH 3/4] Makefile: lld: tell clang to use lld
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

why don't you simply check for CONFIG_LD_IS_LLD existing (when [1] applied)?

If you want a specific version of ld.lld (you mentioned kernel module
linking failure was fixed recently) why not transfer this into a
scripts/lld-version.sh file?

Greetings,
- Sedat -

[1] https://lore.kernel.org/patchwork/patch/1039719/ ("[1/4]
init/Kconfig: add config support for detecting linker")
