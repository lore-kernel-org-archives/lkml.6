Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCE6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FC1276FF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bN7ItlbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FC1276FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967663AbeF1SLi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:11:38 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43401 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965800AbeF1SLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:11:37 -0400
Received: by mail-io0-f194.google.com with SMTP id i23-v6so6087488iog.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLV7guX8V4ePBnkAcqjMK2jrM5nw2uRIOVCu1zyaYZ4=;
        b=bN7ItlbP7Gt+B4492iOQb6wdu+DbGtWOf0zsp2Lb24HP5YbU2FsI1RlfwbtlrGXLhf
         L7GYgI9qf9NejZRhYEWho+WiZZUdm1FCeMfMAMlkHklqhC5qJDJmVMwb/YTwYQG4vYIR
         ImZiKuPQXnn8H3kwnFszOxkPPFH8VBEbazlmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLV7guX8V4ePBnkAcqjMK2jrM5nw2uRIOVCu1zyaYZ4=;
        b=k3IahjUOzP84hZbRJcjDlAyTQQc7PyPGmwlF1cmOWVnQETXL/V1/qvzgA3cizTW0jw
         Xx7kSO3IEyfXdDCdI2uQFneYNXBnUu1Kh/ihMuH+a0eWtseLSDNTnRSXRElOQHDT8+by
         GXZ5OIK5MGSxqREV5TxywPJind53PkPDf1oZ0Ehu8Ee+0zSb7CxBbYHEZRCNRe2NEVuf
         FGy6U9eCmqOEN+owx+EOi88HVnnU0mHrljPRmfAGKIfEAO3L/t6wJsgjedSk0qpH1Xac
         uWv+W01Jn4VhF1Klx7MMIxMY8+Eo7X0f7/2teYeTsQZ7voQCuSenqh0/nHwhhh1h7H5T
         uh+Q==
X-Gm-Message-State: APt69E1lYFWILCJHGpNd9X+pTeTtFEihCKvxiC8AFcgUbWc+ZjNGemac
        7W9mScTAGXw1JoCk4+DYKPVc+4V2FgmwsYF+YMauoA==
X-Google-Smtp-Source: AAOMgpebovo+0OuhAnk82QzlYbO9XICLjlx7I3b9PJL2rF+TAo4ufRR33pP3oIeeD1Db2Q9Sk+5lc/BH/OZjxBjVaJA=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr8835850iob.277.1530209496669;
 Thu, 28 Jun 2018 11:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1529563351-2241-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <CACRpkdZiY2vAXQSuAgjKfHKtYT_UZD-apEbpS1RT5ZGFutYQeA@mail.gmail.com>
 <MWHPR02MB2623C017D4A632F7A25FFD27AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <MWHPR02MB2623984A51810CCAB597A9B5AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623984A51810CCAB597A9B5AF4F0@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jun 2018 20:11:24 +0200
Message-ID: <CACRpkdY+UdSp7_brDMNvv5G53p_Jo3yDurxxZH0vN7CESCrsRQ@mail.gmail.com>
Subject: Re: [[LINUX PATCH v10] 2/4] memory: pl353: Add driver for arm pl353
 static memory controller
To:     nagasure@xilinx.com
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>, ada@thorsis.com,
        honghui.zhang@mediatek.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nagasureshkumarrelli@gmail.com, michals@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 2:11 PM Naga Sureshkumar Relli
<nagasure@xilinx.com> wrote:

> Sorry for the wrong name.

Hehe.

> > Hi Linux,
> Linus.

Everybody does this. Even myself.

Yours,
Linus Walleij
