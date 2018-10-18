Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB53C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77912098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sie99PMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77912098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeJSFQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:16:27 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38556 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeJSFQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:16:27 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so2163427ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d1NjULrA80QMVncOGpJqnDhhqmjqxZbeyIBfFlyhzeo=;
        b=Sie99PMIckhr0eZoQmdLjjg8wv4P2PFf6L+ZK/8bwKx3sWv54l6Tywezrp846FXxaI
         adWcuyLDP1itbCIQR8Nj7zs8QjAGjTUsS5xCOYhSAvifn/0/j+eRR82lPpqaDFVxpcaG
         RAJY/N2C7jlt80sdCS7VjVykVd5Q2BGXP1ZEwyW171gY2w0FX2J2eAtzZ0TUWc7e/qAW
         ngjQy2sXLHeIh/0P0uQgYuMp7AlXt6yEBoo/udeIRyRc/EypH+2/SBbAA81fPdfNZDOb
         809rfofp6bxJNTCVo8QDSy4PqBo3Q120BTmVpyWbEbWFljzb4fUE4cjxKg7Xk7G3meCg
         N8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d1NjULrA80QMVncOGpJqnDhhqmjqxZbeyIBfFlyhzeo=;
        b=Xe+nxuh1PaA04fYOE5a3ahLTxqF+RW1hPeXQ0+y8nMlKi3RtMSHgbAhuYYJzYdK/B1
         Up9lfhbFkLAFqxrELSibMhBDOu20v03miCZ5du1NLo3V6gHajZGaU1jEjlY/qNcrQ0VF
         KkV28WwXihto2aFIM8mGlZpCSGNEaiiPU8dtkA+XmQH8ss+BKXqYQUavJcJcQ0xl7fAo
         4OS2VDIxnaSNLyLfX9+w8G0iJgZ72KFSgSyZLurFv6KBU2XNLGwOSE5CMbWoNiPoFN5r
         LlF1lwgLBKXJy+8sZ4IMrmqWzrf3bO863WuR1EnVJiCKkubcHzR8+EgIILs1yso1M89U
         Tt5Q==
X-Gm-Message-State: ABuFfohl7NeueVQ6ab//HiIh2Sdh1viTxPByCmEQUbVLC9+kMZhYKI53
        rwJFaq9cAiA+KWK390CMS4F0AA==
X-Google-Smtp-Source: ACcGV63N6YHIJJH4EaaOTEmUiywnQ/5+R1gHGJq/XEL40nyH/CwKYQIHYhwnrZ1EFwdSJWl5uybpjw==
X-Received: by 2002:a05:660c:40e:: with SMTP id c14mr1470235itk.119.1539897213842;
        Thu, 18 Oct 2018 14:13:33 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u132-v6sm788341ita.9.2018.10.18.14.13.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 14:13:32 -0700 (PDT)
Subject: Re: [PATCH v2] ubd: remove use of blk_rq_map_sg
To:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com,
        hare@suse.de, keescook@chromium.org, bvanassche@acm.org,
        jdike@addtoit.com, Christoph Hellwig <hch@lst.de>
References: <20181018205503.6206-1-richard@nod.at>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <421b4db7-b4dc-cd0d-1744-fdfad732d92c@kernel.dk>
Date:   Thu, 18 Oct 2018 15:13:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018205503.6206-1-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 2:55 PM, Richard Weinberger wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> There is no good reason to create a scatterlist in the ubd driver,
> it can just iterate the request directly.

Applied, thanks.

-- 
Jens Axboe

