Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227FEC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D562089B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m48GysIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D562089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeH2DAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:00:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37357 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeH2DAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:00:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so1350314pfd.4;
        Tue, 28 Aug 2018 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xHx5VLu6Z0mCZNmt78FqfzLTB2ZB5JCnETBWgucb9mQ=;
        b=m48GysIjxKacYEyjyGBhHlFqcSw9D3MFihuwn481PRaDE0VqN0NZbkD0wj6foQuAu4
         EMPaB22BTbZ3qfXzC96/bROfqNyQm1Xa2vO8RL5AnwuKkHUdIsbQApehBUoOmhTEvd1Q
         6gb+znb6nLRKWXe2uOf1Rc3XmN4/q9KKfSwp6YnaGoLpC8mod9u0Lkhw55yhV3NxTtBF
         /J46CIK+MKNpBD/9eVsT3uZV1QR4Pqw3sE+xey1PbNUw32YYGq+XiIwpVXpwy40uAI+7
         r7MxQh++WaGfTMvQwkd6m9Ldbn1e54/1SBC45LSrYwzedSpRNcIR9tQXoRBA141AhgvX
         eIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xHx5VLu6Z0mCZNmt78FqfzLTB2ZB5JCnETBWgucb9mQ=;
        b=B2n0/69bf7Nxn1Yq+jhXdmtIpouGcV/eL+S/ucNYohgd83lj+ODTHBy1RpK1GAMmC9
         nCMpzb3F8J0ZlYU4hnjGXfMlUdhrhMgO8LVC19r6aMyXp3uCvMMHK1N9PnqxTzfcpTUv
         ge+TcBS7adRQnzaaH69cJWHSjn3v+7nRF90ot8ZLV4Z43o4S0hTbP5nJ1eUUkBqJsFdI
         TcS2mEwMi5sNsKK+hO+WBGAw6r1AUHQRV/05ib247K92BVo+IqegqIhoQRSgPb9svSNi
         prTqXGcova9zaoj3PYlRiaDkvorQF0T2cvZUr6spyE2WeyUfV/LgTWEQgJ9tESJhwQ0x
         N5UA==
X-Gm-Message-State: APzg51AoJzpZYwfCyulV5WOpBLJigV/ETo0nc7Nyrkiy34DGncTQ+80d
        0fijx9+MTKlZE8MX7+mdzaaQxdGO
X-Google-Smtp-Source: ANB0VdaNQ+kcxf43m52VoUgQx4HTB38EBhLoCv440lXWmJo3dYc/OVMyRKgqhgvECBfX8nH7hQQHFw==
X-Received: by 2002:a62:4fd9:: with SMTP id f86-v6mr3357361pfj.110.1535497616156;
        Tue, 28 Aug 2018 16:06:56 -0700 (PDT)
Received: from localhost.localdomain ([216.64.167.154])
        by smtp.gmail.com with ESMTPSA id s14-v6sm4628441pfj.105.2018.08.28.16.06.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 16:06:55 -0700 (PDT)
Date:   Tue, 28 Aug 2018 16:06:53 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management updates for v4.19-rc2
Message-ID: <20180828230651.GA4974@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.19-rc2 with top-most

152395fd03d4ce1e535a75cdbf58105e50587611:

  thermal: of-thermal: disable passive polling when thermal zone is disabled (2018-08-20 12:00:40 -0700)

on top of commit 2ad0d52699700a91660a406a4046017a2d7f246a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-19 11:51:45 -0700)

Specifics:
- Minor fixes on OF thermal, qoriq, and rcar drivers.

On top of my local tests, here are the results from kernelCI:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.18-10727-g152395fd03d4/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.18-10727-g152395fd03d4/

BR,

Eduardo Valentin

----------------------------------------------------------------
Anson Huang (1):
      thermal: of-thermal: disable passive polling when thermal zone is disabled

Fabio Estevam (3):
      thermal: qoriq: Use devm_thermal_zone_of_sensor_register()
      thermal: qoriq: Simplify the 'site' variable assignment
      thermal: qoriq: Switch to SPDX identifier

Kuninori Morimoto (2):
      thermal: rcar_thermal: convert to SPDX identifiers
      thermal: rcar_gen3_thermal: convert to SPDX identifiers

 drivers/thermal/of-thermal.c        |  7 +++++--
 drivers/thermal/qoriq_thermal.c     | 27 ++++++++-------------------
 drivers/thermal/rcar_gen3_thermal.c | 11 +----------
 drivers/thermal/rcar_thermal.c      | 16 ++--------------
 4 files changed, 16 insertions(+), 45 deletions(-)
