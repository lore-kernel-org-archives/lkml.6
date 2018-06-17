Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F8C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E0420989
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E0420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935091AbeFQLgz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:36:55 -0400
Received: from stumail.xidian.edu.cn ([202.117.112.40]:50784 "HELO
        stu.xidian.edu.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S934793AbeFQLgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:36:53 -0400
Received: from xry111-laptop.lan (xry111-laptop.lan [10.170.26.222])
        by stu.xidian.edu.cn (eYou MTA v8.1.0) with ESMTP id 67a6da812ee6021c976dd0185d1e5216
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 19:37:41 +0800
X-Eyou-Smtpauth: ryxi@stu.xidian.edu.cn
Message-ID: <1529235406.17103.2.camel@stu.xidian.edu.cn>
Subject: Re: [PATCH] Kbuild: fix mismatched if/endif pairs
From:   Xi Ruoyao <ryxi@stu.xidian.edu.cn>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     ryxi@stu.xidian.edu.cn, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 17 Jun 2018 19:36:46 +0800
In-Reply-To: <18061719212289a3d6de53ebc1ba6c4a188e1b0779da@stu.xidian.edu.cn>
References: <18061719212289a3d6de53ebc1ba6c4a188e1b0779da@stu.xidian.edu.cn>
Organization: School of Aerospace Science and Technology, Xidian University
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Eyou-Sender: <ryxi@stu.xidian.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-17 18:16 +0800, Xi Ruoyao wrote:
> In scripts/Makefile.build, there are two mismatched if/endif pairs.
> They stop the generation of orc unwind table if CONFIG_FTRACE_MCOUNT_RECORD
> is not set.  dmesg complains:

Duplication of patch 10455267 in patchwork.  Sorry for noise :(.

But let's fix this quickly, since the issue breaks ORC unwinder completely
(at least with my configuration).
-- 
Xi Ruoyao <ryxi@stu.xidian.edu.cn>
School of Aerospace Science and Technology, Xidian University
