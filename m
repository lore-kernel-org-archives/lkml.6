Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF1EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5C4262C2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fy22VBVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5C4262C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934298AbeF0MSz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:18:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55234 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbeF0MSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:18:53 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RBCx0W017995;
        Wed, 27 Jun 2018 06:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530097979;
        bh=y37m/YpR4s9d72qfvE9e9Ap08MIKPozQ9dksjGaYkOw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Fy22VBVCOy9s1jwK7lRXiMgQekfd+Mr3+guAe0NnOpj1WdWppmnrbR2lmUfLrJJAc
         IG9BN/1UcAz0PRo4jNqdp4jRICTaOIp4usZxC7HswxJQE3DmwkorpEuAFlLt/sccOz
         dm1PdkJV0lhd/fss2QH8ZF6XV3rDF4IcS1Hmc9p4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RBCx7P020005;
        Wed, 27 Jun 2018 06:12:59 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 06:12:59 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 06:12:59 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RBCuC9008114;
        Wed, 27 Jun 2018 06:12:57 -0500
Subject: Re: [PATCH 1/2] ARM: dts: da850-lego-ev3: Add Bluetooth nodes
To:     David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Kevin Hilman <khilman@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180531202549.11255-1-david@lechnology.com>
 <20180531202549.11255-2-david@lechnology.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <961dab74-ccc8-aef0-bd71-c9b09a0631d8@ti.com>
Date:   Wed, 27 Jun 2018 16:42:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531202549.11255-2-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 June 2018 01:55 AM, David Lechner wrote:
> This adds nodes for describing the Bluetooth chip and connections on
> LEGO MINDSTORMS EV3 to da850-lego-ev3.dts.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Applied for v4.19.

Thanks,
Sekhar
