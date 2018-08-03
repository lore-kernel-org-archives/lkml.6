Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E57FC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE362176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZiU2DZct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE362176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeHCRiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:38:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43484 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N+zge5o1nG5Ys2AFTx+HhqGUCTcB7Xk7+bo8rxfDdFE=; b=ZiU2DZct5lPyYRSLOiAzr2zX3r
        bzUsyPQnNHt+T+95RuwgZiYc1cejCdSuwVeOOs8T7o3HcbDFac0V1uhhG/KTVwGmjsvz1wdU4yip9
        WANUHHarSVrhCU/hLe+/woXcoPH3XlCWBRGObx8iD6H59F35G7nc+LVnoY1m8WQ2Zokj3h8q0OYV3
        XELxC3fTcSrij1zPHwGoUabN0oaQ0gIdHPBzcAO5KEjdmW46Tj/51DuuP7QhuzNnoLcI9e2/ker/v
        JuWWoCpv/qmrkgb2wrAr5tWIMvPyZI+I5TcyxkU9o6r/q18qj/P0NKdXgSZz1el3hFgathhgSLejs
        IO4eqzuA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flcCm-000715-WE; Fri, 03 Aug 2018 15:41:29 +0000
Subject: Re: kbuild: ARCH=um archheaders failed
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
References: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
Message-ID: <861c26a6-294c-755d-2396-e5d18b9bbcbf@infradead.org>
Date:   Fri, 3 Aug 2018 08:41:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <be4f41de-c27a-abac-4b23-369c400e016e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 05:13 PM, Randy Dunlap wrote:
> Hi Yamada-san,
> 
> I see this every few weeks.  It's not reproducible (it depends
> on the moon, Mars, etc.).
> 
> I'm using O=builddir.  The build log is short (below).
> 
> Do you see a makefile problem here?  (nothing to do with mmotm;
> I see it more frequently with linux-next since I do many daily
> builds with it)

BTW, this is just um defconfig with -j4.

-- 
~Randy
