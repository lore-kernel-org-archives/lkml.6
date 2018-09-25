Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40853C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE70D20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Br7xbS7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE70D20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeIYVbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:31:45 -0400
Received: from vern.gendns.com ([206.190.152.46]:56701 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbeIYVbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eTmfUEFM9DLXqCHPgb3FfQfk5JbxPLJIiVCQyeNOtn0=; b=Br7xbS7bESFdLRN34dgFCErB6d
        7fStRmDkStw4cKw4xfCI8klPenuBwZTEJdAvpVTS1os2eOlrbAhoGrC6AVyYPOU45iN9q27Bk2omn
        JREU9vu16kj65cZQLmzg4rNu5tNRaqHWn85unH7dkhDWcqQaWBDiin7au3qAX4//o7mKsMjgCC3PT
        jktvC+uR/IZDsGtzRWuI/ockjk/My3q2imbfW/rbrqhwSTOFCuhdJFJQ8eqHLcYdOnr28160o6TW9
        3RQfnkfT3zP9n1EEB7xmKDQcxgW3UoSWIH0gsLbVrbmqLso+ILRPD6PmQUE4bFsMQ/8rUl6oogqfQ
        Yt64aIzQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59380 helo=gerda.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g4pBf-005Q3Q-Qu; Tue, 25 Sep 2018 11:23:43 -0400
Subject: Re: [PATCH] ARM: dts: da850-lego-ev3: slow down A/DC as much as
 possible
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180924013146.18121-1-david@lechnology.com>
 <a6e9c7ce-8fc8-0ee2-2d3a-24c33b67bdcc@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <fda2606b-3c7b-539a-ae07-4d9b57c34335@lechnology.com>
Date:   Tue, 25 Sep 2018 10:23:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a6e9c7ce-8fc8-0ee2-2d3a-24c33b67bdcc@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/18 1:04 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Monday 24 September 2018 07:01 AM, David Lechner wrote:
>> Due to the electrical design of the A/DC circuits on LEGO MINDSTORMS EV3,
>> if we are reading analog values as fast as possible (i.e. using DMA to
>> service the SPI) the A/DC chip will read incorrect values - as much as
>> 0.1V off when the SPI is running at 10MHz. (This has to do with the
>> capacitor charge time when channels are muxed in the A/DC.)
> 
> So you believe this is an issue with the board design rather than the
> limitation of the ADC chip itself? Because if its the later, the fix
> should be in the driver instead.

It is the board design. There are external 4.7k series resistors that 
make the RC charge time so long.

> 
>>
>> Both of these patches mentioned have been picked up in the respective
>> subsystems.
> 
> Is this needed for the -rc cycle or can wait for v4.20?

v4.20
