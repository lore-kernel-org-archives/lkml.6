Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB1C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCFE2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UxoSDt93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCFE2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeLLTGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:06:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37005 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:06:17 -0500
Received: by mail-qt1-f194.google.com with SMTP id z16so21764884qtq.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=E6ygtnTGKjPyEM/mrPmUWs3fnLR09sIg0h8IDij+0HU=;
        b=UxoSDt93+Fn3HPy2zGSEHGn0og+cnkHW5f8ZwRKt1T/P25V+uzyh8n2HEMS6+15cnp
         /Q+wjK3etDblaQ6hP7mig/jGWpAp1pCHs7u8/n2q+uQ9Jkyne6bAYRqTRqElrrS3wvpD
         olYQJaLwm7Lqwk3MTCWUqMq2jh1gt6YcqJiTcifduZBaCKNUBLJ3d4jkJXMbohkQonxr
         pRRWVrDEsxrdJV97yyW9Ww354GuQAISeG61ziGT8o9tzumGQSUJzO4GYEQuuOMOuReft
         gBSxpRn3cFL2mYvn2v/5Py6L/nQ4sOVx/2ExoN9vqc0WULY1o8vTdJMSAZsrOE1a3ulf
         sW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=E6ygtnTGKjPyEM/mrPmUWs3fnLR09sIg0h8IDij+0HU=;
        b=dG8Xng8XHCiOzAZT5mH/1L/OFHL8WNWwBO51cAOY8gFp3UKA5LxaLVCNBstqsdv9//
         HW8n1fh+uOelXc79A0p0mdCeL4ZbLGnR2Coc9RZR9tBB70NZyLcBLm+nY9d6LXQLAwD3
         k/oAAeEo36Ylurnq6C9hEcS3v0eVY78tzkgHBdvYVXDUZ6B0xP4Dce1hFeNoRVauw8OU
         I3czSf5pRBegWiyk4jOO2XlBtBUGPlA+KHgjJFU54O5T8qG04UwHbO0FKG95lbj8DhF7
         L+TnVs1jX2ga+ycxvZzlCUn/aML85iBZoA1auww+BWdeasJVCl21KyTqOzRxpcVWBcxY
         z68w==
X-Gm-Message-State: AA+aEWa+OWF+5CqOMRBWURYm5+9+IPkd8+AXQTKwwD51Pg368Kfm6pc6
        iyC5KwWtDZF6Ml9QWMFLBzgvtQ==
X-Google-Smtp-Source: AFSGD/WWO2t9ldZ0uW0FWUThOD2xZWtXFxD+nY1ESqGYyHC/bIVAYkVRAMS2QH7A/EOafpoBurQ4xw==
X-Received: by 2002:ac8:7094:: with SMTP id y20mr20871721qto.380.1544641576923;
        Wed, 12 Dec 2018 11:06:16 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m193sm9253384qke.61.2018.12.12.11.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 11:06:16 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:06:12 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alice Ferrazzi <alice.ferrazzi@gmail.com>, ast@kernel.org,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] selftest/bpf: fix E501 line too long
Message-ID: <20181212110612.58c013fe@cakuba.netronome.com>
In-Reply-To: <62f6127d-edf6-2d41-cd7d-1c1c20607b38@iogearbox.net>
References: <20181211115607.13774-1-alice.ferrazzi@gmail.com>
        <20181211115607.13774-8-alice.ferrazzi@gmail.com>
        <62f6127d-edf6-2d41-cd7d-1c1c20607b38@iogearbox.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 11:24:02 +0100, Daniel Borkmann wrote:
> > -        raise Exception("Time out waiting for program counts to stabilize want %d/%d, have %d bound, %d loaded" % (
> > +        raise Exception("Time out waiting for program counts to \
> > +stabilize want %d/%d, have %d bound, %d loaded" % (
> >              bound, total, nbound, nprogs))  
> 
> I'll leave the test_offload.py ones up to Jakub, but to me it seems
> this particular change here would actually make the code look worse
> and harder to grep for error messages, so my preference would be to
> at least leave the error messages as-is. Also seems it's not a 'must'
> in pep8 [0].
> 
>   [0] https://www.python.org/dev/peps/pep-0008/#maximum-line-length

Thanks, agreed, this has been run through checkpatch, so the line
lengths should be fine (and we don't want error messages split).
