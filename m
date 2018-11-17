Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B75CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CC92077B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="03TUpuz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CC92077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeKQMrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:47:41 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQMrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L6ciXQIeEmCRiMtAZkn9rIYkHk+4/GflDUAdtYCKTTw=; b=03TUpuz6SNRxh6HUHUUF+XQUCJ
        jqCm0Mc2K9IOumTChLy7sXYcmgHQppVSLWAC4ToSoePoab4ErpOVSk80N/LMfphnQOv5O7bTMbaXv
        oZXCyGd17pSMasyKgMdWHSM0gV16S17yckIOhlL0FmdDOIoSPVhfeixqJ1KbNrBHHyUJZU2TEt9hQ
        X6iajKIgZpXm7Vd4xHptYmmc+Tcg17ZH6l/y+R4zOULH5IaMS/2yeXwkHpbY6dcboXWbNOTdWl7uw
        A73jpQm6QIuT/zzSNllFv2HJzjNZ43CRECPN5eGRDm+/VJZfO3WjYLusPXUTAkuTFBE6SUYSlXkbV
        gJLvbtjQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNqPT-0001GE-Cg; Sat, 17 Nov 2018 02:32:35 +0000
Subject: Re: mmotm 2018-11-16-14-52 uploaded (gpu/drm/bridge/sii902x)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20181116225317.CcsXrZ5MG%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <78134da5-34dc-357e-dd92-8879281349ab@infradead.org>
Date:   Fri, 16 Nov 2018 18:32:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116225317.CcsXrZ5MG%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/18 2:53 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-11-16-14-52 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

(not caused by mmotm, just found here by make randconfig)

on x86_64:
when CONFIG_I2C_MUX is not enabled:

ld: drivers/gpu/drm/bridge/sii902x.o: in function `sii902x_remove':
sii902x.c:(.text+0x1f): undefined reference to `i2c_mux_del_adapters'
ld: drivers/gpu/drm/bridge/sii902x.o: in function `sii902x_probe':
sii902x.c:(.text+0x793): undefined reference to `i2c_mux_alloc'
ld: sii902x.c:(.text+0x7be): undefined reference to `i2c_mux_add_adapter'



-- 
~Randy
