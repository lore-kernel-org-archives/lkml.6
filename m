Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4503BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF022360
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UFScXvyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AF022360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeKOK6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:58:07 -0500
Received: from mail-pf1-f178.google.com ([209.85.210.178]:37331 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeKOK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:58:07 -0500
Received: by mail-pf1-f178.google.com with SMTP id u3-v6so6098978pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PH9TZWPv3eKyjOGYG8VjoG7+n0qNQyxSzNew9XQnMh0=;
        b=UFScXvycx1DdSuVOAXeAo7Pk00NnSUNCG0EMdWVKfzbdVKPowZqlD0krN0CD2WMmNV
         43do4TnS3iBn0DUSYxOd27tfdAM5x8hejIhR++0Uoz+GB3B0xU6xqvDpS7lrTSAjuMIj
         Zk81Kwo0Zpi3yWXOdxbfGG0tuHooPv9+uvqQ7rzZDD2cauMkYiSxmAECcMHvDrU6eD8C
         FaHqtPXUkNTGxrLK1ybi23/QSNnmA1e2L1/c+pu4MQXGLDF3oSv9ovF4BH1HsjbfPbAy
         3SwUx6pCS+mbA+7O799a+GZz8NASbnSvxEI1n7KfVQXLrbWrPmRyeoywSOlvm7K6lTTB
         18ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PH9TZWPv3eKyjOGYG8VjoG7+n0qNQyxSzNew9XQnMh0=;
        b=KYhn1m57rgtnBjhhZ+tW+2xGfjmMhUAoocg1N6weL2j9fNkVlS2l7f/ginZjF3bixj
         3PxJN0S1W0yPlFWzVCTPmIsWycZhkTDM2QELKWG3T+H07NxSXC7kIlmkzHtwrT8zfN3o
         eYNGYidDLL+2r2TU25F/+CNxhhrpuqPIpj3Yc7oCxdorraGs+K+r1kiiw5JyF1zO0KXz
         lwe82DcCGmyhuEOg5Dr4uqD+vRvgoqkhlJiC75LVrVAfd78iATeklidrvotbV200mV6D
         zPhBryEWlVe4rCC8bHeFDswHKHtAw2s3OKDhgNBtn5nwJhJqH6lmh1GX3XlhI89Kyf+h
         cTSg==
X-Gm-Message-State: AGRZ1gIp/ahzRix/Xr9gu3bAl5Lwkwfz6ea3osz5QOHLonaUwioDSegX
        NMIWl1hvckqGrW0TZWKRs8BstmSBakqSrg==
X-Google-Smtp-Source: AJdET5e5fWAs83u04HeHPV5YL57izn/eilh/5xeIPtbMDrS6d+Pdk1336gu5lIJbbtCscXOHvtOjcg==
X-Received: by 2002:a63:6483:: with SMTP id y125mr3767861pgb.91.1542243150569;
        Wed, 14 Nov 2018 16:52:30 -0800 (PST)
Received: from cakuba.netronome.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id j12-v6sm27520045pfi.61.2018.11.14.16.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 16:52:30 -0800 (PST)
Date:   Wed, 14 Nov 2018 16:52:27 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][bpf-next] bpf: fix null pointer dereference on pointer
 offload
Message-ID: <20181114165227.222663d5@cakuba.netronome.com>
In-Reply-To: <20181113092926.27081-1-colin.king@canonical.com>
References: <20181113092926.27081-1-colin.king@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 09:29:26 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer offload is being null checked however the following statement
> dereferences the potentially null pointer offload when assigning
> offload->dev_state.  Fix this by only assigning it if offload is not
> null.
> 
> Detected by CoverityScan, CID#1475437 ("Dereference after null check")
> 
> Fixes: 00db12c3d141 ("bpf: call verifier_prep from its callback in struct bpf_offload_dev")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
