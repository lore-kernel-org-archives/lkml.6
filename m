Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3E6217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TDeoGHDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfBZSOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:14:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43906 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:14:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so6572564pgq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 10:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UU9ouvG2TIGPF3fDYsRD5ElRLKfR5G493p4aJwOGqdI=;
        b=TDeoGHDWjgaJlwXkTiph0SGuHgcAzG0SFtitnOL24sgdcOBTIrshgksjkXFTLQTko8
         z1IVymuS/duXQHKQ/RuvEaaZYHLfSDlnayjJDYmuol36SCf+AuQU6X67gVyDeqmPtuR9
         pTyy4WdNqZyNH8yo7VAAYss/CRuk9C2XnYvR3AF416YViHmljeNUg2cJCi+Wimflaxgd
         C/uA9tpPbfWoRZdmtRwJWmZFKfJJ3wi/0GUo+ngILersC9xWpE7F7wpCiomJVXDjDM2h
         6med9aNEKSniTCtPAI55qs3FM1UfCcjfZszhl/nm6jjtpjqH7Gg78ft6IOinQJuou45m
         v3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UU9ouvG2TIGPF3fDYsRD5ElRLKfR5G493p4aJwOGqdI=;
        b=ql8+Ry5GAaXp3akF8RBtVUS/99OWVatSMIH4OPbyamNwVnBwSajrXsDRCsFfk9dsCU
         1plZiJeXOjY7CYrMLqey93P6XT6mck7A07toTjm/O9rCA7L1VdMzADAT3RaiMm2Xfiha
         vH7Tw9HjZ4ndhA4bC0TL5FB+j+GVzdVMQo1cWhSwxz/b6+BNrloTh41Wtr2xjGsDQH3/
         2Ts6FImoLe8/CfO7Z1TRpjPO8Lw73/4IFEzmD/MAVIJoVDf5EbnhG3BIEBvH3nDHZOCX
         mRDl9I4w6LvhUHnGArTiPbhxGQEoUMphsoQcBtXOAhFruWca5Cx1lA+ucevsQHZQaeoZ
         HugA==
X-Gm-Message-State: AHQUAuZQ/pvfH2rRtRNk0UecgOqvGTjch92I03S8KcP39Fsi/Fv0U5fk
        Zb4idGGwcSxmkTW10lPOyYZwdQ==
X-Google-Smtp-Source: AHgI3IZ4/2HQCdS/TBBVx9T7Ypy+e7v2JVVwM1d4RvUS2L9x4yHDjvjg/0YC+de40g9EHHUmJc65Xg==
X-Received: by 2002:aa7:8c4d:: with SMTP id e13mr14838250pfd.53.1551204871943;
        Tue, 26 Feb 2019 10:14:31 -0800 (PST)
Received: from localhost (sjspeed.wiline.com. [64.71.18.60])
        by smtp.gmail.com with ESMTPSA id p2sm21804520pgs.7.2019.02.26.10.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 10:14:31 -0800 (PST)
Date:   Tue, 26 Feb 2019 10:14:31 -0800 (PST)
X-Google-Original-Date: Tue, 26 Feb 2019 10:14:03 PST (-0800)
Subject:     Re: [PATCH v2 0/3] Ensure inX() is ordered wrt delay() routines
In-Reply-To: <20190222180454.5992-1-will.deacon@arm.com>
CC:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.murray@arm.com, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, geert@linux-m68k.org,
        Will Deacon <will.deacon@arm.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Will Deacon <will.deacon@arm.com>
Message-ID: <mhng-1f3ce733-8498-47d8-9425-a6eaa3dfbb4c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 10:04:51 PST (-0800), Will Deacon wrote:
> Hi all,
>
> This is version two of the patches I previously posted here:
>
>   https://lore.kernel.org/lkml/20190211174544.4302-1-will.deacon@arm.com/T/#u
>
> Changes since v2 include:
>
>   * Incorporate riscv changes from Palmer
>   * Update macro definitions as suggested by Geert
>   * Extend to cover non-port reads via __io_ar() as well
>
> Feedback welcome,
>
> Will
>
> --->8
>
> Will Deacon (3):
>   asm-generic/io: Pass result of I/O accessor to __io_[p]ar()
>   riscv: io: Update __io_[p]ar() macros to take an argument
>   arm64: io: Hook up __io_par() for inX() ordering
>
>  arch/arm64/include/asm/io.h |  1 +
>  arch/riscv/include/asm/io.h | 36 ++++++++++++++++++------------------
>  include/asm-generic/io.h    | 20 ++++++++++----------
>  3 files changed, 29 insertions(+), 28 deletions(-)

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
