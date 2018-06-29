Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C27C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A16524CFF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ASrU1dzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A16524CFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755144AbeF2Vrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:47:32 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40120 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936356AbeF2Vr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:47:28 -0400
Received: by mail-lj1-f177.google.com with SMTP id a6-v6so8374970ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/diIn9PSQQDdiu5lLwyHBDlAWY5d9ZEuPqeIXXYaAQ4=;
        b=ASrU1dzEYSteQX31oQQF8OkTgcnSv8HTLVt6xzF6cDTf3bQtwZK8RiClK6JtmFiKRQ
         SjhoHF8ON5Eg5Lnnb99VS5BFlrCB1ecj371lRyhg1Oqqlq5V5JHbzTrWkmEBtb6Mevpt
         +2nT6b4oeDIkVjWYa6ux399+DXx7ggXOHNQN2vykXQaPsvuNyuBiENzgins2NH5fFUZo
         gZY2nWPQgcajFI5VHpJr7Rtl5kkFK0M8Z9hEbBPgAuueiFeoGoWR9bs6TISZYELfK1cc
         O3G4vSG7RiEglJabjk+/s28I/ooaOjSHRpYrWwkYcQOe+BfFPuo7pyXLdSQiMgTAfzH7
         92oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/diIn9PSQQDdiu5lLwyHBDlAWY5d9ZEuPqeIXXYaAQ4=;
        b=Flqc1Q9+pKnyCY4JZu1M7ri4dC2y0kQAjZdP1EtHo2577dvfvw31OM/stgfslnWhis
         RHpD3Np85G2do33uvn6c/cW0hYgOQREBR/amCCIUM36HoYi+fseB4TW02n4O+vU89sbP
         Xr1e6pUc/jNFueLJ8ocMLre+a7FhkAjrTJs7oJpCH9K+hCoFZTkT8eDISh1PEmNSA7Rc
         BOxE/2iM/0myl0aM9SbmVR7osM2PdUoO1qcGT+sEcrgIShewtz9Hd6TKdHVzQuo5LqWK
         G3Uc/yP6BxCzv+BHilifX0mdcEM1weP/l4BZ1nMYby/3xu2i9meOImN9q3AkL88lRvSr
         KGeA==
X-Gm-Message-State: APt69E1TOnMmrzXdKe+AueENXg8ZrGEfcXdGK6lJrl0ta7dppiFA3DAg
        5m0vvTa8fydL7LG1sEkqDLvE7BUaCaEtjCToN7vTWilc/A==
X-Google-Smtp-Source: ADUXVKJmJybBM0ead3eaVi6yU4IQuD5Y7+4KYnsKY2ki6aiMaJnDypGQqb0+lkO/RC/chaEurO16JqW4Bz5ceDabGlo=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr11041799ljd.72.1530308847319;
 Fri, 29 Jun 2018 14:47:27 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 29 Jun 2018 17:47:15 -0400
Message-ID: <CAHC9VhQZ+zRQ+LER=BCx1_Z-Z+LQuYaeEUxQ8YMQoNdNgt=cwg@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.18 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One fairly straightforward patch to fix a longstanding issue where a
process could stall while accessing files in selinuxfs and block
everyone else due to a held mutex.  The patch passes all our tests and
looks to apply cleanly to your current tree.  Please pull this as a
fix for v4.18.

Thanks,
-Paul
--
The following changes since commit d141136f523a3a6372d22981bdff7a8906f36fea:

 audit: normalize MAC_POLICY_LOAD record (2018-04-17 17:54:11 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180629

for you to fetch changes up to 0da74120c5341389b97c4ee27487a97224999ee1:

 selinux: move user accesses in selinuxfs out of locked regions
   (2018-06-28 20:39:54 -0400)

----------------------------------------------------------------
selinux/stable-4.18 PR 20180629

----------------------------------------------------------------
Jann Horn (1):
     selinux: move user accesses in selinuxfs out of locked regions

security/selinux/selinuxfs.c | 78 +++++++++++++++++-----------------------
1 file changed, 33 insertions(+), 45 deletions(-)

-- 
paul moore
www.paul-moore.com
