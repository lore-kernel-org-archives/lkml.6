Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF4C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099D72150C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JgsjeKf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099D72150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeHIXKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:10:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33223 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHIXKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:10:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so3298506pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=Z4dyBxEt5FooNveGZjxF0rpsxFTmDxwdX3K+dlCaWhk=;
        b=JgsjeKf0x59WNV91oqw2pPu2quT4i6DGSilD/WP7h967BKbetmOuE3v3iAfiFFHzGP
         Dizw9AmtcCCr1Ia5JBkmx5ZzzSzdLeWzhDdeFFAS4HPHHQ99/tTxoDz1UVTcpboqTl62
         EZPjyEL5e8FSyz4YsRa6P9lQiUHShQWEGca8TRPu+hqlPbV/574M1k1QSyXXfZT9dPdM
         K01ddRxIplq6G1duAhbFTge778JNOoXS7yynOwma1umXZr8nADalM55fvlCm5NPKVDP4
         +ZZHE1h6NLHU9sNYFiDMmzx/pEj5m9G+vv+WiC7mfuWbyDFpieLWYKTQU21Tks8ETZBm
         5QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=Z4dyBxEt5FooNveGZjxF0rpsxFTmDxwdX3K+dlCaWhk=;
        b=e6Q42sJlaIrR3XJfsRT4MZAs9+YFp9jMhRN740zcxwNv/Sr8U/CHlyTqahXitnawxP
         Z1bmrAiSRL2TzKiuOLRai+wpEeZNRmqnXIohz4M4mSrcOH2Ew6uCQxnASgiLbG956Grr
         FZHUHve21lAa9/+IauN3hper4N1Ib1IojJ+bWG2fpbUkTtVoiEDzdMyJ9lqc+lRruUXf
         2BDvZ8wHYVwJGWDSURyWu7kUJgzzf6sYm3NlKXzrZhAnlr/NIoudw+wrfZXe7OiIWvK4
         ND/eYwi12HtPa8DPzenOjK8mENSF6qgDlL8rnl0QoytzbszIatKwwKk8USqScsiRHXSG
         WRBw==
X-Gm-Message-State: AOUpUlFE0P6vu4uV1H286QPHh/OjimSGXRqKTZRnaByLmmVvIkNFRJbm
        1Sx1a/MyPUosc/AvXYZ/OabpvQ==
X-Google-Smtp-Source: AA+uWPzgHYMPhmPid0rSt1BOhoPPDW2Hj8wAAlS7PKzpW0gyemMu7G3XiGrTgwfbPHQPCHoLlImx2w==
X-Received: by 2002:a63:f804:: with SMTP id n4-v6mr3623936pgh.106.1533847419032;
        Thu, 09 Aug 2018 13:43:39 -0700 (PDT)
Received: from localhost ([96.76.210.210])
        by smtp.gmail.com with ESMTPSA id t76-v6sm12356889pfe.109.2018.08.09.13.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:43:37 -0700 (PDT)
Subject: [PATCH v2 0/2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.
Date:   Thu,  9 Aug 2018 13:25:22 -0700
Message-Id: <20180809202524.1702-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, linux@roeck-us.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that we weren't actually hooking sys_riscv_flush_icache
into the syscall table, which results in any flush_icache() call that
escapes the vDSO to silently do nothing.

Changes since v1:

* sys_riscv_flush_icache is now defined even when SMP=n, which allows
  this patch set to build against SMP=n and SMP=y.

