Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07171C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F1A21A5D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2P9KXLv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F1A21A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbeHFXf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbeHFXf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:35:57 -0400
Received: from [192.168.0.108] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B5121A5D;
        Mon,  6 Aug 2018 21:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533590700;
        bh=yhkDgsTfy1ZktJoO418qCamfGvA1A6mk58X+QkXKKQI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=2P9KXLv0DN21NautZiHUVbRcUWsfl7bdpCxCQLYQEDSgUdjGovvJVzCutTTEl8mMd
         53O18khLsypYzJW07eM13Qi62EZs3RIj+NoUnn3wvIHtovBcVNkA4yBG1hGnTnRsQ+
         +t0sbG3MiHxbcWKhFZftqa3ebCgUT5QyL8RD4ySc=
Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
 <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <b50328a5-2def-d1ff-c202-8d4b44bd3e28@kernel.org>
Date:   Mon, 6 Aug 2018 17:24:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/2018 4:56 PM, Bjorn Helgaas wrote:
>> I remember seeing a similar patch before.
> Are you thinking of [1]?
> 

yup.
