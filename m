Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D41C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30699263AF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BsUKJYQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30699263AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeF0KyK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:54:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55330 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeF0KyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:54:09 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RArBYL040002;
        Wed, 27 Jun 2018 05:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530096791;
        bh=buQgOaZevNHCqOq7zkPuAdnaLPOgeKIGwS5W4dKb4cI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BsUKJYQOnAHDIvKI8cRzP6ACf0cOgvHnV6I1n/2nLhFUOtToKrcf1AD0AmATEQ/IF
         ci3zYDXoMBnoNClhZAl4wlJtjYbCzerCJ2BX9igLtIUQA1A4MBCedud9jIjySHFOLQ
         XCV/fydZHJZLPG9frawk7CHvx7/lsoAycBPUs5Wo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RArBg9002697;
        Wed, 27 Jun 2018 05:53:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 05:53:11 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 05:53:11 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RAr99V003873;
        Wed, 27 Jun 2018 05:53:10 -0500
Subject: Re: [PATCH] ARM: dts: da850: Add power-domains to PWM nodes
To:     David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kevin Hilman <khilman@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180626152817.16803-1-david@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <52fe7982-9bee-1b45-a939-59ec5cff756d@ti.com>
Date:   Wed, 27 Jun 2018 16:23:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626152817.16803-1-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 June 2018 08:58 PM, David Lechner wrote:
> This adds the power-domains property to both the ECAP and EHRPWM PWM
> nodes. Both have drivers that use pm_runtime to enable the clocks, so
> they need this property in order to find and enable the clock properly.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied for v4.19

Thanks,
Sekhar
