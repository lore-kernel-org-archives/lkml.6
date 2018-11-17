Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16032C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A572089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoCrclDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A572089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbeKQMmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbeKQMmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:11 -0500
Received: from [192.168.0.101] (unknown [49.77.232.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7955F2087C;
        Sat, 17 Nov 2018 02:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542421636;
        bh=0g9ud2wOujXg6eZHAU7mkaxLzas4rKU7KM6bxZXf6s4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AoCrclDpnPTm+MYKa0W7gi66D/2DqkpPC8Lkxacwi3cOIyqLXPUWFBJGaCXk0ri9D
         S0im3X5OTu+GB+Jiy3iqU2LS0m3ZpCNxELOXLMmUDqHh8lNtTJCeIsm2gpiKzm2fDI
         NscTrDOUReO0XCrP6PQpHPIEOmKnp/6o4DXJ9uNs=
Subject: Re: [f2fs-dev] [PATCH] f2fs: check memory boundary by insane namelen
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20181115075040.83500-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <239446e9-2d75-cc9c-8315-999b3641c336@kernel.org>
Date:   Sat, 17 Nov 2018 10:27:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181115075040.83500-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-15 15:50, Jaegeuk Kim wrote:
> If namelen is corrupted to have very long value, fill_dentries can copy
> wrong memory area.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
