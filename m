Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960B223C1F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oC7qlSG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960B223C1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeGBQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:39:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbeGBQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RGaZgCfxMyWHOa6t24Pv1xEj8VNuq03jyZuAdMrEkZ4=; b=oC7qlSG5pQt31mLZ+L7CpXbdQ
        uTZZOeMfkFHxmC/MNQd4WxCkuvmoZstqLJ4afw75cDN2mICbINlt4SbHmrz9RzIkoEUSe1N75LBwA
        ND3I4JkiTLFVDUW9mTgCG2CcwxUx4lcPvlQCYWGvaG2TPvXY1ycKqoni3qjpbCgptxJjsQjseRNoP
        9T97YfsKjMPDKSaoyH+JJJ3+JHAf+N93R87dcyf89VpSt6x0m4oVxGzY43gscj5YvtSrm821a/+xv
        uWa6DtGdbjXVqPrqMCNoDcSGu8oqm5JudIbLdZnMIf2yW/6dfW9sJV8mOpPyNHDsHameAxWElHu85
        UBxOhKl6g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa1qx-0005zo-It; Mon, 02 Jul 2018 16:39:03 +0000
Subject: Re: linux-next: Tree for Jul 2 (media/pci/meye/)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20180702145158.10190101@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c38838a6-5582-6b33-5b6b-8938cfdce571@infradead.org>
Date:   Mon, 2 Jul 2018 09:39:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702145158.10190101@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/18 21:51, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180629:
> 

on x86_64:

drivers/media/pci/meye/meye.o: In function `meye_s_ctrl':
meye.c:(.text+0x710): undefined reference to `sony_pic_camera_command'
meye.c:(.text+0x736): undefined reference to `sony_pic_camera_command'
meye.c:(.text+0x75c): undefined reference to `sony_pic_camera_command'
meye.c:(.text+0x782): undefined reference to `sony_pic_camera_command'
meye.c:(.text+0x7a8): undefined reference to `sony_pic_camera_command'

when
CONFIG_SONY_LAPTOP=m
CONFIG_VIDEO_MEYE=y
CONFIG_COMPILE_TEST=y


-- 
~Randy
