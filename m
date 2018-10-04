Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9463C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CACE21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOT/7C+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CACE21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJDN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:57:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37068 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:57:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so8607844wrr.4;
        Thu, 04 Oct 2018 00:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tEHC8y6mIxZUp8OhJen1ryOfCRT1a/gGNElnmzVsNIg=;
        b=WOT/7C+HhPk7YRPcn4Pv/8cL7LqjzK5tj468vQRrbrGyFpN9Ek15B7Nd2XxfGAjbxc
         HfT+oK4plhg73HmqCBo7nNvtWchQDXl+qcL/zf/m7YjxBQF2KXDkfdAxjF+Pu5qjUh/+
         Cg3lNGcOBQwQfllvRsSSu4qRseFYxEdkNtdIDGWvUP+Edf3CFZ4BfmTW0GVggDCionKL
         OSRj0xB7/a7J4fIXhw00X2h8zW1i1L//+3MTQ10DA68kl+CElAbOTzW/qTQrt93gm1Jf
         tBugaI5uZSJ4ckYASIgTu9TcA4vNRfXJZn/FzkymTG2NzBzTvIKmtO4zQQH6JbTKtG1K
         8nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tEHC8y6mIxZUp8OhJen1ryOfCRT1a/gGNElnmzVsNIg=;
        b=kp3uUyZ1uPCb31litJeMkDh4Xi7zLUnNz4/zaxWlUu14z1aHLhjL3yFZGPqKNPuDDU
         CSmEbfnbvVU7N3RJDAnsgbJ7sCbbB1ypbyATQ7Wi2gsjDz8kjAynf+LNHJfq7iC0qRpN
         dPYEN9fzasbLHDIMAucrjXmxgy2OBb37zlAnpGQcoxrFAGOKGtIzXJ/soNLA+X9MjaL1
         Em2MSRuV71dNyFEazKX51BxoNCpFJ0ICd8g17OVMZYFH9FKSfwAbjtdlzj9zhcI5C2cf
         93gnULV3HIiR1US0/uGK8VbHAx5pBFnh6PKzWsOvR7nAmvA1NISOt5eoyB/VOcxN8mMy
         SvAg==
X-Gm-Message-State: ABuFfognvnorrCryej8r4LBo73jJ6cqDwBbZ48zZOkIkOyX1bD8oz9rl
        beDnDDAFTdFcgnwha9zuMSRJ7q/VBV8=
X-Google-Smtp-Source: ACcGV60Fb5d86hJTauAUwWok+MKxDzzzOsQHTkLi9qN+WYUMaAeG/lWLkkQAV9GRYceyucFqQsCbzw==
X-Received: by 2002:adf:f88d:: with SMTP id u13-v6mr3482367wrp.311.1538636760640;
        Thu, 04 Oct 2018 00:06:00 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 204-v6sm4113542wmh.25.2018.10.04.00.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 00:06:00 -0700 (PDT)
Date:   Thu, 4 Oct 2018 00:05:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dept-GELinuxNICDev@cavium.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Clang warning in drivers/net/ethernet/qlogic/qla3xxx.c
Message-ID: <20181004070558.GA6535@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In an effort to get the kernel compiling warning free with Clang, I came
the following warning:

drivers/net/ethernet/qlogic/qla3xxx.c:384:24: warning: signed shift result (0xF00000000) requires 37 bits to represent, but 'int' only has 32 bits [-Wshift-overflow]
                           ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
                             ~~~~~~~~~~~~~~ ^  ~~
1 warning generated.

This particular statement has been present since the introduction of the
driver in 2006 so I am unsure if this was intention or if maybe the
statement should have been removed since ISP_NVRAM_MASK is defined as
'0x000F << 16' in drivers/net/ethernet/qlogic/qla3xxx.h and it's the
only enum to be shifted. This is the only location in the driver that
has this warning.

Perhaps this diff would solve the warning and keep the driver
functional? I'll be happy to send a formal patch if that is the case.



diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index b48f76182049..10b075bc5959 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -380,8 +380,6 @@ static void fm93c56a_select(struct ql3_adapter *qdev)
 
        qdev->eeprom_cmd_data = AUBURN_EEPROM_CS_1;
        ql_write_nvram_reg(qdev, spir, ISP_NVRAM_MASK | qdev->eeprom_cmd_data);
-       ql_write_nvram_reg(qdev, spir,
-                          ((ISP_NVRAM_MASK << 16) | qdev->eeprom_cmd_data));
 }
 
 /*
