Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA67C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B61213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrKrVEDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B61213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeIMGlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 02:41:07 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35703 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMGlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 02:41:07 -0400
Received: by mail-oi0-f45.google.com with SMTP id m11-v6so7674071oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=3SmVL1JNAIOa9ypuywBZuEz5CpuYKvwUb8xEU+zoT94=;
        b=MrKrVEDVh6sxYiWXh2H/lP6G+vj+aaxpIUPMNSF2cKfxEAoMNfn2i3m7iO7K7zGXAs
         CHgjXxD64sLANYCYWn/DxERONa9v/r7JT18m7wuPTBQK7oWUDjt5nxAWgE3rqMGGCB5E
         Llds5ySvpPCMj9CGdblNdM5G2teE7DiZQv/UZ5yq/f71fYf6Qyzg9jHuzDURjM436Bz9
         ei33jzpZZDQ8HiklD52qrIU7Z0whchZDsvjXWxa6BN6ldF24K+Ccopej4hj/HaSY+KIT
         HAQOMP1iReG5bwmKPV5ALxHehaGWu/dXKzTbbEnV4urOciHWXsEc5nI/ABYr5sAAqf/J
         uuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:to:cc:from:subject:message-id
         :date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=3SmVL1JNAIOa9ypuywBZuEz5CpuYKvwUb8xEU+zoT94=;
        b=UxImiHVUb1NYYNRgfCx0YjFs12o+qRwKnOzv1ww6FxhEWxE6OT/kvQFz1MPs0zxFRP
         Y8++R1NF6/exMAWAyLN08Dt7b0nHgNV5Gmo4FeDRo01PzjVqfzwGiz3f1PuHKIZK2Ona
         6utoUVIL4ccsMIgBa4hMWS6g1dy6vMTVSY8bHGWETy5pmoSSNhBaTzCxDr9l9CU6gEKZ
         jhEF66RmRmXx5JaldWgsNJpw+Pe4XdV+PjAwRTPehxZWbjJbkVTEoH/uWblkG0tgvDDX
         9WjbDWEWaEyUiRdamnlx7Z122kpgL3kYfTmkfD8B+kePLPwSJUb24ocEjNx/wV9TE0tu
         Il6Q==
X-Gm-Message-State: APzg51B5CYIB5qgWJLaaM2tZSY8Edq3insE3hMsqDRMx7JxPvafLSc+s
        Xmm8Wv04ZO3vTpdDTtAi20ER99U=
X-Google-Smtp-Source: ANB0Vda/sXhtMPwIwaABYlclZ2PnIKncgbkDUkgOkEOxQhUwD5GVLGoogJ3f7GqxceH2DqcajdP1ng==
X-Received: by 2002:aca:7c5:: with SMTP id 188-v6mr5236512oih.58.1536802436182;
        Wed, 12 Sep 2018 18:33:56 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id j125-v6sm4494428oih.53.2018.09.12.18.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 18:33:55 -0700 (PDT)
Received: from [192.168.21.89] (c-76-103-131-11.hsd1.ca.comcast.net [76.103.131.11])
        by serve.minyard.net (Postfix) with ESMTPSA id 644478F9;
        Wed, 12 Sep 2018 20:33:53 -0500 (CDT)
Reply-To: minyard@acm.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>
From:   Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] IPMI bug fixes for 4.19
Message-ID: <b22a404e-a462-7064-a789-4ae776a6afd7@acm.org>
Date:   Wed, 12 Sep 2018 20:33:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9f8f16c86e4d9e2afcbdcd6045981c4d9129450e:

   Merge tag 'mtd/for-4.19-rc2' of git://git.infradead.org/linux-mtd 
(2018-08-30 10:05:12 -0700)

are available in the git repository at:

   https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.19

for you to fetch changes up to a8627cda7cfffe1792c199660c2b4f03ba2bd97b:

   ipmi: Fix NULL pointer dereference in ssif_probe (2018-08-31 14:13:56 
-0500)

----------------------------------------------------------------
A few fixes that came around or after the merge window, except
for cd2315d "ipmi: kcs_bmc: don't change device name" which is for a
driver that very few people use, and those people need the change.

----------------------------------------------------------------
Benjamin Fair (1):
       ipmi: kcs_bmc: don't change device name

Corey Minyard (3):
       ipmi: Rework SMI registration failure
       ipmi: Move BT capabilities detection to the detect call
       ipmi: Fix I2C client removal in the SSIF driver

Gustavo A. R. Silva (1):
       ipmi: Fix NULL pointer dereference in ssif_probe

  drivers/char/ipmi/ipmi_bt_sm.c      | 92 
+++++++++++++++++++------------------
  drivers/char/ipmi/ipmi_msghandler.c | 53 +++++++++++----------
  drivers/char/ipmi/ipmi_si_intf.c    | 17 ++-----
  drivers/char/ipmi/ipmi_ssif.c       | 32 +++++--------
  drivers/char/ipmi/kcs_bmc.c         |  7 +--
  5 files changed, 97 insertions(+), 104 deletions(-)

