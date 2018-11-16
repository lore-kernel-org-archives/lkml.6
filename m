Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B51FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FC92086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS/YDBY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57FC92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbeKQKBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:01:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53041 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbeKQKA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:00:59 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so173555wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 15:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/UF+g9OxGHaeBCH0GF2XJ9svhdNBY8zg8XJGwMjSGD4=;
        b=HS/YDBY6PqDKN9c/9/zulOvotmnzHZlIkxnoQ5qjEEakxDT5QOHFLiUFQYYmKvqzBB
         kc4YLKErFei/y9+debfL9a1dym87PcV/pcEEwbeVu1M0rOnc6wN04PYnP7YupBfryrZX
         OpXT00T6vhJvdHn6pnXdAjT1ETa0Vjbi8R/A1tNc9pKAlJNtw7l6w4OOnKqISvzUvYQd
         mAuh3v4vkwgKAB+tmNMJwYWDf+o25DhwkUBCDo5fZbs/Zmj98uKe8/dmeNvhPMTwW+0I
         IHfqFUpSunt2MBVPtFHcpesoxlkoi6HEu4HE0rxq1281g9DdzCCUlYV5EfWHme1+Mgwx
         Xn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/UF+g9OxGHaeBCH0GF2XJ9svhdNBY8zg8XJGwMjSGD4=;
        b=ieQQzR5AfWvtPoW/rOapbFuxlQtX3kcE41dRp/awPlASMnpB91uQYkcmhyxys4RYRU
         IswmP9GC5/Xdcw+FSqXqBhmj9Lwe0N55RPu/ULV+NKGxTYsaudd1cspXTAENC/ZrRSA8
         3zULUECsK/Khmz/hNanbBSFC0xy2uErjN8x87jgqfc4eucA+MT/ifxHS6GDfispIyM7Q
         OigHJsHXr/iko69lac2bThYuwXODW3Juo25gc4UftEaSDXaRuH+oL93HSzlyyVuAOEAo
         vevboyyqNOtzeUhp4N8iXo49kWcjtQVNJxzKI5H4LdukbH2hBpkeOdUsNOYyFjtHbym5
         g3bw==
X-Gm-Message-State: AGRZ1gJDVYXiuO9iU2E0rrVSzLwIffBEIoSnD1AWSS2mOaJLP44Su6ce
        YUqmhJqhTlB6Fho5uK5iaR4=
X-Google-Smtp-Source: AJdET5fGHD6Gteyi49McXYdy3LX0Xwze8fTEaliMcch65+Mwj9oGwEwzM3d6c/wKuJEHSEP/FKUrwA==
X-Received: by 2002:a1c:5706:: with SMTP id l6-v6mr181174wmb.51.1542411991313;
        Fri, 16 Nov 2018 15:46:31 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id o15sm14913335wrp.12.2018.11.16.15.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:46:29 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Split line, fix eol parenthesis and fix functions
Date:   Sat, 17 Nov 2018 00:46:05 +0100
Message-Id: <1542411969-26570-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1: therea are some trying to split the line, but not shure about
         the result, like

1)
reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
                                           i));

2) 
regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum -
                                       1].EP_STATUS);
 

The second patch try to fix the function, removing the parenthesis at
end of line, and add new line only if needed (over 80 chars)

Cristian Sicilia (2):
  staging: emxx_udc: Split line and fix eol parenthesis
  staging: emxx_udc: Fixing function naming

 drivers/staging/emxx_udc/emxx_udc.c | 285 ++++++++++++++----------------------
 1 file changed, 106 insertions(+), 179 deletions(-)

-- 
2.7.4

