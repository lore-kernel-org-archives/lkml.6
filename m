Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA86C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1431B2242C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="P4VwI0vW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1431B2242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeHJU6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:58:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33378 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeHJU6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:58:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so4919753pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7VskxHEPgZDCrQfq0NuHw48BVZC5xgp7njWDBZoBW+0=;
        b=P4VwI0vWuR5BSz802yg1pxdW3PUO1Yx2+U2XKB39yGZn+MBawHz/wuioBVklKeM2YT
         SQbBsmUrahblTMr7nq+gYrZyrU3ctOBEBS9OJAYrXQ3X0Gi2TohFOl1UevBJeYr4RZ0x
         vfQNAnbhuZ53JZ+l70pftVtWSosesmIhnPlUytpa2fkzbNbJopZrufewtAZAyZzhGExB
         YpZRcxvbmb4lnzd5+YlccqcVr5+/jLkYrCMUvbTj/V5Ze9G+tQnn5b8K5oTNOg042seA
         uubKlNHfh3fZ0R04nxeVAVuJ1nE5Ez303m5BesoZboT8eCRow/7GiCxc+5+Y8NyVE0Or
         J+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7VskxHEPgZDCrQfq0NuHw48BVZC5xgp7njWDBZoBW+0=;
        b=VWc7vptIGnjALCnzq/wqAmivlAGYLVhyh57oa5Ybf+yGIzTp+K1hbzw+4D7M/nnTwB
         7hcGaEKjbCJctQrG6x0DMqFCz3KfEwph2sQFv+J4IJJKBuT2DRcUMRppdAikoVCyqxsO
         T/5Zjr3m8cSmdZdifVo1+cbuiU/LKaHd+UlT5kFw/cmqxd/C+xs4KgGwMPECQtrowkaE
         cz7jDY5KPg6/qt8QmQ8SA5udfHE4cbfN1/i3wwg+yA2Sq35uzMM2D2IvMDFuEXHytA1c
         /b11xWKP366kdQMeh9U/EKc9wwwnodGUjFRAXPNCenBhgZO/LzzxI2mCDxi/WU8d1+WW
         xVMw==
X-Gm-Message-State: AOUpUlHm3rdXQPcbwZA4at3BG5AC251mRmNO+rzGtkYHTuRJzpqhQfdP
        3orCvpZVXPO7JT9Id3MJ3qO79A==
X-Google-Smtp-Source: AA+uWPzG+TmWSFljgdEcfnOvkxdKWai99TBClzXq81YY/P0e/CMHxrXCuNyjwskgFNdGi/GuF8kPQQ==
X-Received: by 2002:a63:8341:: with SMTP id h62-v6mr7257334pge.298.1533925658392;
        Fri, 10 Aug 2018 11:27:38 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id c68-v6sm23626231pfj.51.2018.08.10.11.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 11:27:37 -0700 (PDT)
Date:   Fri, 10 Aug 2018 11:27:37 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 11:23:15 PDT (-0700)
Subject:     Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
In-Reply-To: <20180810083804.GA20415@infradead.org>
CC:     aou@eecs.berkeley.edu, Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, Christoph Hellwig <hch@infradead.org>,
        dan.carpenter@oracle.com, tklauser@distanz.ch,
        linux-riscv@lists.infradead.org, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-341b5b76-2cd6-41e3-859a-6b1d926ba770@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018 01:38:04 PDT (-0700), Christoph Hellwig wrote:
> On Thu, Aug 09, 2018 at 03:19:51PM -0700, Palmer Dabbelt wrote:
>> This would be necessary to make non-SMP builds work, but there is
>> another error in the implementation of our syscall linkage that actually
>> just causes sys_riscv_flush_icache to never build.  I've build tested
>> this on allnoconfig and allnoconfig+SMP=y, as well as defconfig like
>> normal.
>
> Would't it make sense to use COND_SYSCALL to stub out the syscall
> for !SMP builds?

I'm not sure.  We can implement the syscall fine in !SMP, it's just that the 
vDSO is expected to always eat these calls because in non-SMP mode you can do a 
global fence.i by just doing a local fence.i (there's only one hart).

The original rationale behind not having the syscall in non-SMP mode was to 
limit the user ABI, but on looking again that seems like it's just a bit of 
extra complexity that doesn't help anything.  It's already been demonstrated 
that nothing is checking the error because it's been silently slipping past 
userspace for six months, so the extra complexity seems like it'll just cause 
someone else to have to chase the bug in the future.

But I'm really OK either way.  Is there a precedent for what to do here?
