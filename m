Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A32C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9C720892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bAT5mi0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9C720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLGUcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:32:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34323 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGUcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:32:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so2470212pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3IOnEKSmrS7SeIEZTNze+oEiPhQkMUoqtxG5jbOrw+o=;
        b=bAT5mi0lhZeGn4610XYS43mYau35PD8p9vhKgY2R3NYfJJfSEuyj4LfCwotEo7zMEm
         kQA79rkf9/V9DXDiPBJGw0Cv2PDKynMgmNuZqFoGZO/+JEKxSNMDYOpbIJlYWMjstRbg
         tIyvRl0JIJZH8bEKktWLrXwBszWN9lSplG6W5qxJN6vgS6lNSZfnFlsgJJEgp/0LZl8m
         ST+MdrYWhmF2CBO34QA1vYHIAv9C7ITY1VB3edsXMM2GB9S3OQGmw5mchUTHhvLqiOdU
         INXkuDNkN2MGB7pk/7QuWM0tTZ30Y994GUYJU0tIJOz+zf6dTRxTvtjzOioDvx3SaSY8
         5YWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3IOnEKSmrS7SeIEZTNze+oEiPhQkMUoqtxG5jbOrw+o=;
        b=a68oU3a904rI2325O7nfysjTOd2aRMTxAbgwufX6SFp5Ino1xwyMP/0fJhWzWVmE+B
         DBxf1GWb67+I7F9junpjRCKrSUVT2R4wlDQX+IWY8VzPV9ffjZoBS1B6TXaTYXHD0hXQ
         M83VYCvwX/TYtS29zFRlyV52A8O1eUA7dOGOo19uByLVcd95Ve+YJgr2GCjxE3nHHZlp
         vEjJASxmiF1NeqWKbqe2S8HzeDj2bXJWp80pPba9CUsyD9m8mp9di5NTr2/rG9J8YIOb
         l/EryLBPBSfzm/d4qoOA6mYcDc3WXt9FZNKI+NcrAtWxmighU6SC2qGb2pdlX9h8GLbn
         nRRQ==
X-Gm-Message-State: AA+aEWbWNsBRNeUhURq3uxtEiK0v1BgAnJecK78m7/NNAic+lAo732ZF
        Agumzw1BfZSbVVwc3ULJGcbkpw==
X-Google-Smtp-Source: AFSGD/XqYyFxNezWTXtDxTSkba7Ux+INkp46I+QzTZHMJTnszb/hhHrev4gxe3BG+br/InBJHjAobw==
X-Received: by 2002:a63:441e:: with SMTP id r30mr3257031pga.128.1544214765042;
        Fri, 07 Dec 2018 12:32:45 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id w88sm9721642pfk.11.2018.12.07.12.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:32:44 -0800 (PST)
Date:   Fri, 07 Dec 2018 12:32:44 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 11:30:17 PST (-0800)
Subject:     Re: [PATCH 0/2] riscv: enable syscalls tracepoints
In-Reply-To: <20181206152635.1869-1-david.abdurachmanov@gmail.com>
CC:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-49f84968-18a7-4acb-b41a-f056d1ee7034@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2018 07:26:33 PST (-0800), david.abdurachmanov@gmail.com wrote:
> Depends on audit patch:
> http://lists.infradead.org/pipermail/linux-riscv/2018-October/001931.html
>
> audit patch is already merged into linux-next.
>
> This simply fixes compilation error in do_syscall_trace_exit() and
> enables syscalls tracepoints.
>
> David Abdurachmanov (2):
>   riscv: fix trace_sys_exit hook
>   riscv: add HAVE_SYSCALL_TRACEPOINTS to Kconfig
>
>  arch/riscv/Kconfig         | 1 +
>  arch/riscv/kernel/ptrace.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

I've attempted to add this on top of next-audit, which I've merged into 
for-next.  Let me know if something went wrong.
