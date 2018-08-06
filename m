Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91170C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B0721A28
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="M2Eqb9jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B0721A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbeHGBAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:00:33 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46497 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbeHGBAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:00:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so6221344ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=r3feb0xVehgEMXeqb+ZD18mOfjK+il5remYD912wusA=;
        b=M2Eqb9jDKkKlvK3i/GeyIHg8oKd/IKkGRX6596tQGbVUxfHNQRow0IoLwWvZQNEz4O
         TUcRQulAwahOaO2TthGD7qtPhyK0Lz7Zp/QaRiF7tYYB/4se0wcOPpJaAdCG+caUIiwC
         YeShk1x3yLMEe6BGAIhnIzz1yOYJeS7JVafRIKQ1r24/GKqU2duGOqQw4fkYBhOVU4Cr
         ei3NkX7WPzkNK7iELbcr7dsH/EjWNZRJwxy4wBkgMk+18P8z/soQmZp1p33uLERpNaqt
         jzVeCaUg2AxOXkgsi85LBKcwPlqyKvVUO64w4Vk/6gku/KM3S25J6KGAMHdZAv3kL7sd
         Nw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=r3feb0xVehgEMXeqb+ZD18mOfjK+il5remYD912wusA=;
        b=KUsM1pXmTqRT4W3DK0lamX5y6pkY93De2rWYkNDbnA0JR3HHwUPvXGsCxcnMlIXGGD
         JUxjjYfn74oVTUewFY0NKczousPXnfz9nryLPKXsahT4re54hIraHpWapRKdxvlgqeAz
         vYZ98mR57mHOTL7IusjDP4RRpswCAt7zISbXadchgxxuujcECQeIsmKDEMwVSxw1gDkt
         7scVFB0ZTD1KGnFgiEUx5O09WU0fgUCB5GHtEbg2Wx3VAolYQyLs22PU4+Av55cpXbkT
         kneQXVFDqkuTPs7jbgShwXuYPd9VzEmgUwUUgzyN+d0xtVxW6q8fI+WSUCHRW6277b9B
         1/WA==
X-Gm-Message-State: AOUpUlGK/z+9km5vFvI55ennZl5wBnWzjyv3GocX8Cr21gzg+Zj3P/e0
        c78GZbs026bix7fCPfkcuACGhQ==
X-Google-Smtp-Source: AAOMgpddbksH2ta7u75ENi+nPKWKn4XNZY56hq1xi2JQVYV0KeH/xIMBFYG1sm5dbSke34hl/pziVQ==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4-v6mr15243275plo.257.1533595756430;
        Mon, 06 Aug 2018 15:49:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l85-v6sm23091762pfk.34.2018.08.06.15.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:49:15 -0700 (PDT)
Date:   Mon, 06 Aug 2018 15:49:15 -0700 (PDT)
X-Google-Original-Date: Mon, 06 Aug 2018 15:29:36 PDT (-0700)
Subject:     Re: linux-next: Signed-off-by missing for commit in the risc-v tree
In-Reply-To: <20180806073705.27b861bb@canb.auug.org.au>
CC:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <mhng-7ffa4856-27f7-4f39-9e78-4a881729f9ab@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Aug 2018 14:37:05 PDT (-0700), Stephen Rothwell wrote:
> Hi Palmer,
>
> Commit
>
>   bce17edfe6af ("fixup: ".  " in PLIC docs")
>
> is missing a Signed-off-by from its author and committer.

Oh, sorry about that.  It should be gone, it was just meant as a review 
comment.
