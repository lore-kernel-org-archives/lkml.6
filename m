Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E81C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF442154F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SpCTH6iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF442154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbeIUVQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:16:54 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:44128 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:16:54 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 10B3410C10A0;
        Fri, 21 Sep 2018 08:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537543651; bh=PPPQ5Zs8RhCz7YPgtbxPsFZv/qTtcRkAwqLL0Hpp8LE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=SpCTH6iP81GlGvjxiiW6xBgg3oORqqWwdvLDSuxKdOpS4gkVRLaNXtLwmwZp3qjp0
         ahwyjCyxFMxneUEadoKi6uRIkFtEskWivGUbCPNwi0XFUOiITgoNUnNFiyQFzrAfll
         OrlThTUximhMJ//MDmp7+2pLSqdGWSzKRfqZLu+Rf4hMW1TGrnkDXgDfXGzA1Mq7Yd
         Xz9IgvHaq/SellGPmSnAA/cPD8JkLLdUe/h8F82PPddp4Ux6WSbnHuqL+Jn4VUk43L
         neYeYoQwwljYGokMQX4vA1p/YGb+q/xJYxulhMLuF8SP5w/A0A4pAzTZHXj3gqkNEg
         Ff76e8TnC2Ofg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id A273A3B39;
        Fri, 21 Sep 2018 08:27:29 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 21 Sep 2018 08:27:29 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 21 Sep 2018 17:27:27 +0200
Received: from [10.107.19.164] (10.107.19.164) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 21 Sep 2018 17:27:27 +0200
Subject: Re: [V2, 0/5] platform: dwc: Add of DesignWare MIPI CSI-2 Host
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Joao.Pinto@synopsys.com>, <festevam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>
References: <20180920111648.27000-1-lolivei@synopsys.com>
 <20180921143708.tw62sci3il5ydmlq@flea>
From:   Luis Oliveira <Luis.Oliveira@synopsys.com>
Message-ID: <efe3aeb4-af2a-a010-e8aa-12097e8816a0@synopsys.com>
Date:   Fri, 21 Sep 2018 16:27:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921143708.tw62sci3il5ydmlq@flea>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.164]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Sep-18 15:37, Maxime Ripard wrote:
> Hi Luis,
> 
> On Thu, Sep 20, 2018 at 01:16:38PM +0200, Luis Oliveira wrote:
>> This adds support for Synopsys MIPI CSI-2 Host and MIPI D-PHY.
>> The patch series include support for initialization/configuration of the
>> DW MIPI CSI-2 controller and DW MIPI D-PHY and both include a reference
>> platform driver.
>>
>> This will enable future SoCs to use this standard approach and possibly
>> create a more clean environment.
>>
>> This series also documents the dt-bindings needed for the platform drivers.
>>
>> This was applied in: https://git.linuxtv.org/media_tree.git
> 
> I'm currently working on some MIPI D-PHY support through the generic
> phy framework that could benefit your patches.
> 
> https://lwn.net/Articles/764173/
> 
> Feel free to comment on that serie if you have any particular
> constraints or if you believe that some issues should be addressed.

Hi Maxime,

I will check that, thanks!

> 
> Thanks!
> Maxime
> 

