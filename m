Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD75C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC6621773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545692276;
	bh=LUql6knGzn7ff3iAj10k5Lay4S6LmBh3s3COv5O36TY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nRsiJMbppBCoIhNI+MmDb6ZMA5F6vYpZ4WvcM+Z+F3MAxdEw1H2ZAwnk/UvFEnj+P
	 wML+WRTWGZRLuNLTyUKx/ONZ4EQFEpZgrZjyWfHj6pcqAncENUb3DBMNZsSyNIcSA5
	 WfsvrgasDWd9iDvFphm0nYgvKwTbaVDCGxsfvkCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbeLXW5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:57:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46929 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXW5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:57:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12590245wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Uf8JVqcP6NEQrrj13e8e0EuEGoViOXOi+8gPXZdR4I4=;
        b=R9kS3lC3rvh6RWPzaNDVcAOxoSPeRJfF2MfBkDxCm6cGVljwAgCy4gkEkvNdSY0nFg
         7TWqYJetUvuxlykb4k6VB6EtsLPwyyWIhgNC31g3JGTKdUhHfcLoeCkdYg07OOyuyhil
         pEWysviZaIxmmoJlHE81/pFum5lIymtivYsUPWzuA4j3Hf3T8TCOjuf6JKo/b59+UDaD
         0VKTAylgwzVM+TgxDzzqVPhGTtvqg6fiXX8r5xY/A3r95OjdkB7fEt1VG1UbhGh8BmuT
         xUmJT50q5BHS6NkzlWhbA8hebLgigog/pSIgGsMQEVzKuLdq2XYLY+DLN0BEmcIGbi1U
         XL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Uf8JVqcP6NEQrrj13e8e0EuEGoViOXOi+8gPXZdR4I4=;
        b=kUtTQxo6xzSDupD3G8j9AkSOPIRaBp0qLM0ABzV09oqZeBFTedW/p4qR1lHc60g7q/
         Oh7vmHcd7XriursF0eLqyF8tkw5kqYGpMZxFiVelTsKtBh2OHu+EJe1+eL++81aRVsBH
         kGQDkTmVySTrgX4vL3T2zbNfU2JVxS/ihvFwsUwltza7Zz76T643EnXjC61JlJDlwVo+
         xwZ7rWmqSHrWlxufNHPrfRvMccSyN3faBU1QWskZ4HQkBgFMDC+H5dagNpy5s2LDphbu
         vzN1nJy8R47TYocUER2jRnH8oDotBqujAvWRJtkpcrwA+HKE/DQI3NGi8w6pqsj4Chs8
         wQOA==
X-Gm-Message-State: AJcUukdBX3YwwkIltX64QgCVYZnX2F7uldwf7pSmQVZpFsZKQFd6HZcx
        amcHfDjCSUtNXiglMPLSdP0=
X-Google-Smtp-Source: ALg8bN40oKIYNG3+L/7sLO3mCm0xY+x5u8NUv4toJHXdfwMEIFOZqOsKU+FqweGOkAHqYyDy/NmS/Q==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr13481864wrs.279.1545691807725;
        Mon, 24 Dec 2018 14:50:07 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o17sm48542385wmg.35.2018.12.24.14.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:50:07 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:50:04 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] x86/amd-nb changes for v4.21
Message-ID: <20181224225004.GA96500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-amd-nb-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-amd-nb-for-linus

   # HEAD: 210ba1201ff950b3d05bfd8fa5d47540cea393c0 hwmon/k10temp: Add support for AMD family 17h, model 30h CPUs

Update DF/SMN access and k10temp for AMD F17h M30h, by Brian Woods:

  "Updates the data fabric/system management network code needed to get
   k10temp working for M30h.  Since there are now processors which have
   multiple roots per DF/SMN interface, there needs to some logic which
   skips N-1 root complexes per DF/SMN interface.  This is because the root
   complexes per interface are redundant (as far as DF/SMN goes).  These
   changes shouldn't effect past processors and, for F17h M0Xh, the
   mappings stay the same."

The hwmon changes were seen and acked by hwmon maintainer Guenter Roeck.

  out-of-topic modifications in x86-amd-nb-for-linus:
  -----------------------------------------------------
  drivers/hwmon/k10temp.c            # 210ba1201ff9: hwmon/k10temp: Add support f
                                   # dedf7dce4cec: hwmon/k10temp, x86/amd_nb: C
  include/linux/pci_ids.h            # be3518a16ef2: x86/amd_nb: Add PCI device I
                                   # dedf7dce4cec: hwmon/k10temp, x86/amd_nb: C

 Thanks,

	Ingo

------------------>
Woods, Brian (4):
      hwmon/k10temp, x86/amd_nb: Consolidate shared device IDs
      x86/amd_nb: Add support for newer PCI topologies
      x86/amd_nb: Add PCI device IDs for family 17h, model 30h
      hwmon/k10temp: Add support for AMD family 17h, model 30h CPUs


 arch/x86/kernel/amd_nb.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/hwmon/k10temp.c  | 10 ++-------
 include/linux/pci_ids.h  |  3 +++
 3 files changed, 50 insertions(+), 16 deletions(-)
