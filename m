Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255F1C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10EB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak48fdZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10EB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeLNGnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:43:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43703 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNGnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:43:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so2265253plb.10;
        Thu, 13 Dec 2018 22:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gA0jjFvqXawpO1c/FWHMHxoWZzQrmYYLnCnbfaTehzE=;
        b=Ak48fdZDPscI3Qhx1DAK4DG/Lv8F46+49EEd8YjVksMlMauCCPTaYSBM45NGUzJeBT
         fEj0EvnQijn9j0KNnphonzZPYmanio3BGJOlEAqDCUTKGscMeFZlwnS6ndzkbgfq441G
         wXMhRqOcyDEOo6yrb9vYuxIuJY4t5WK+OyVsVVh1haJ3JXysr1HP6G1p2Gf+GBtuuRjd
         xBMEDz6w9yy8o3+M+5bPFCoeQVk4RfYFr6KJIlCoi6X2si/PxuYrupKCJr0X7aW6as/X
         baLrv5PEGH2jgqmvn2eAJEUq6LOQQL4RsB6koyaqSs9YvQVxIhUhypzkR2SIz2fgDGBt
         8bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gA0jjFvqXawpO1c/FWHMHxoWZzQrmYYLnCnbfaTehzE=;
        b=pGu4ch+/zvQJGeibKODI/26WKM0mJen7SDYq3BvZLzJDLEu9RYYH1ruzAmHTFtspnL
         vSdOqQ1SEU3EEM4HR8XEBlCmSAlZqTxFzpYmyJY3JOTtHi+QMx5lT5tmT0opnWBhIN89
         yZmBmT1+VLaw4tJTXlD41+lNG40ga5E0ukYcQOIGx164wATuBc93mcOAp1+XAhJc52t1
         WGcyZ7oSIT0en1WyGDnlWyS2q/E0ROkimqB4t6ZKmIzbDs2jAh7zTMaiCApg4zeM2Uja
         DkrHHqoQUWJNJOQ9QfvAv4lJcNDihul+dpfbL7fpwrUBNFcZ986C7p22q+9QET0rahwA
         ZTwQ==
X-Gm-Message-State: AA+aEWZEjZv9atLF7XYZR59yUEGMbJiM+AesA4aWprYaL5mBUBgv83g/
        LrO87n4dK2cjNFh3CMzmSGE=
X-Google-Smtp-Source: AFSGD/Uzums1zq7oRmh4e5OOMk9lMXexedYaD0dtu3Fhpcn4gwhDe8IpveS0B0EwIHtUdalwzQyNCA==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr1762839plv.94.1544769787653;
        Thu, 13 Dec 2018 22:43:07 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e16sm5132645pfn.46.2018.12.13.22.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 22:43:06 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] of: phandle_cache, fix refcounts, remove stale entry
Date:   Thu, 13 Dec 2018 22:42:49 -0800
Message-Id: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Non-overlay dynamic devicetree node removal may leave the node in
the phandle cache.  Subsequent calls to of_find_node_by_phandle()
will incorrectly find the stale entry.  This bug exposed the foloowing
phandle cache refcount bug.

The refcount of phandle_cache entries is not incremented while in
the cache, allowing use after free error after kfree() of the
cached entry.

Frank Rowand (2):
  of: of_node_get()/of_node_put() nodes held in phandle cache
  of: __of_detach_node() - remove node from phandle cache

 drivers/of/base.c       | 99 ++++++++++++++++++++++++++++++++++++-------------
 drivers/of/dynamic.c    |  3 ++
 drivers/of/of_private.h |  4 ++
 3 files changed, 81 insertions(+), 25 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

