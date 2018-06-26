Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD03CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B0826EAB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="DsBFfOWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B0826EAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933181AbeFZSRE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:17:04 -0400
Received: from vern.gendns.com ([206.190.152.46]:50746 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752419AbeFZSRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hwMdOuQocVPzLDfHh1zOiHx8Of/Y2mj9opWpKwIWUYw=; b=DsBFfOWtdWQBBea41SIq3U3W+8
        /7YfbUtVNcFhtEdikgL3v/Cfdkh8EQHI86aRGZUiH//wAQcdW33A2hAUMg2v7pgnYX6D4rHfvCAoS
        heoTBPqOMO5ieg0AX2U4GqNYKH7B5rZ88iGPstsZycv5tjIu9u6MZtB8lakuPmEOsqoTn8aCloWDB
        k9N8QR3LrhKkW1IbUtsYUogZKDntKQIizPGeKF14T+WHHY+ylIBYzkBljk7EpLP4XcnynPbNfxCqm
        KxOG8u3Ya3Y+QWeIfoN4/r3eCDiTfztcUCgNrXCJwRoyBTCwPdOMLdeXOqsHS+zWh36hHfq/j9BL3
        NIieseaQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52080 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXsWT-005uP6-04; Tue, 26 Jun 2018 14:17:01 -0400
Subject: Re: [PATCH v2 0/4] drm/tinydrm: new dirver for ILI9341 displays
To:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nitin Patil <nitin@mindsensors.com>, limor@ladyada.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20180525193623.15533-1-david@lechnology.com>
 <8840212b-fd46-e700-58a1-cb1b882c5771@tronnes.org>
 <d5297fc5-94f2-edcd-5a11-95d7a9dca78d@lechnology.com>
 <ecd75b89-14a6-12f7-0ec4-222b1f984e49@tronnes.org>
 <5a2bc4e7-c6cd-b270-61d3-61bfa5d9e90d@tronnes.org>
 <CAKMK7uF-hBjqnRG28fX7NXOJDc5YEWhq+G6s0M8usA+TXM1BKw@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <bc3429d4-44e3-29dc-3588-209ba30fb2eb@lechnology.com>
Date:   Tue, 26 Jun 2018 13:16:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uF-hBjqnRG28fX7NXOJDc5YEWhq+G6s0M8usA+TXM1BKw@mail.gmail.com>
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

On 06/20/2018 04:07 AM, Daniel Vetter wrote:

> I acked and forwarded the account request, sorry for the delay. Next
> time around, poking maintainers on irc helps if this stuff is stuck.
> -Daniel

The account was supposedly setup, but I am not able to use it for some
reason. Are there any particular nicks I should ping on IRC?

