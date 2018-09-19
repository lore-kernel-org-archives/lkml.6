Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167B3ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D2C21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5f8SPtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D2C21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbeISUwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbeISUwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:52:41 -0400
Received: from [192.168.0.101] (unknown [117.62.222.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E4F2151B;
        Wed, 19 Sep 2018 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537370058;
        bh=/sYUfSrRHgb5LtszeXE6MR1CdqiuMq5Rm6n2voBunZI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M5f8SPtCnS11kcBgvrzep0MiQA3fvgCPGwipzzQsqmYmi2jC/mWDcTuMDr4kEQ/uh
         uszcbBE//3PW35zxGERn3oEJaYipiN8UV8MwmuMRsjm0azYLCB6c9J24h119Fcq2Fk
         I8xKlzIyS9eJ+wwQPoTawXQPRnsrxmttZoA1VMdg=
Subject: Re: [PATCH 2/6] staging: erofs: fold in `__update_workgrp_llen'
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, devel@driverdev.osuosl.org
Cc:     Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
 <1537336150-90604-2-git-send-email-gaoxiang25@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <3c48456d-4770-eba2-9b54-c8a153dc1ad2@kernel.org>
Date:   Wed, 19 Sep 2018 23:14:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537336150-90604-2-git-send-email-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 13:49, Gao Xiang wrote:
> There is the only one user to use `__update_workgrp_llen'.
> Fold it in `z_erofs_vle_work_iter_begin' and cleanup related code.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
