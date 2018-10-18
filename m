Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCDBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849A72098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwntYh15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849A72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbeJSCXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeJSCXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:23:48 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5740420658;
        Thu, 18 Oct 2018 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539886896;
        bh=Jcprgla023d7lE5IkLvgZpWUsiZYZ9YqPVoEwLYtc3U=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=VwntYh15BpY8AWv8caOyz9R6HW/6A4qjio1tkxyF8o+FU066wkBZLHs1GTSwc2VmL
         EjmrCfsTy/hHhNCIk2hQnDPjTvqKNVjzCLwQRZa9FkT6U/DdcIKr7ByEo0L6PlXmKi
         4TTA6+JIMO45V9O+CbNEaO5fAoTl3iCHoRYCntTg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181018085142.0fc1d2f7@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Craig Tatlor <ctatlor97@gmail.com>,
        Rob Herring <robh@kernel.org>
References: <20181018085142.0fc1d2f7@canb.auug.org.au>
Message-ID: <153988689564.5275.14828718879173741076@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: linux-next: build warning after merge of the clk tree
Date:   Thu, 18 Oct 2018 11:21:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2018-10-17 14:51:53)
> Hi all,
> =

> After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> =

> WARNING: modpost: missing MODULE_LICENSE() in drivers/clk/qcom/gcc-sdm660=
.o
> see include/linux/module.h for more information
> =

> Introduced by commit
> =

>   f2a76a2955c0 ("clk: qcom: Add Global Clock controller (GCC) driver for =
SDM660")
> =


Thanks! I silenced it.

