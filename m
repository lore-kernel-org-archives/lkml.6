Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125DC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A0E21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545692642;
	bh=3XKGQE1q5WfJ/IIeEIYY261U7ouVtKs25bXNbt3mP54=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=n3I6bUT4nx+Uq+Nl6bytg/GpwKLY7Cx4O9ZmxHuct6WA3PX0LTiTb7cprMGMPuovC
	 GcHpw8s+NfgmOLv7SUfq44rMl86yUX7bzNwxGDXDMJlfSySBSUWafJrIL7v3GGi9OB
	 bTGBKbxAdiHxSnM3czh9s7UboC77LS6XCTAExrsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLXXEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 18:04:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35951 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXXEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 18:04:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so12611265wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SaJoDWoMrb037gHqfAUohjpDJAF+bCFGc3l0xsSWaIs=;
        b=FJJKrXEufAp34N7ybYbO0Rsf8GgINKJM/GdI0QYk1HlCIlLmkrJqyimemQVJAs8WcR
         UxJQVyRC0+uj0azU9dGKzFT3yRP0YeKRS2B/mBmO9gXIgIjbNzUnMGGrX8X3x4xiM6iA
         Gsh6VFS6e+EIKZ84vIx216zTGsFrxvEbxn793uvrjJmX7jI1zPX533CMxolk0nFi74/Q
         6a6whFgxwLepgFqA0V9RSwK0RjdFI3OC9ujQik+0WfKryepma1dX0lD3Hb8eTfX3RXJn
         A3cBiyr2qcyXAwPmtUH5ccRTKOFm8yREhPAkwf8WibDjDy0zT2yOPs3Y8NjUta3L7RIC
         CYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=SaJoDWoMrb037gHqfAUohjpDJAF+bCFGc3l0xsSWaIs=;
        b=exHmKtN0TMD832IBwTVLZN7xHBnMg4Xc71ka3mWP60IbwAgcTwAVlTZUQBOujGy1Bd
         R8KPMrJPeF3DF5RPDROM2AJS3OraXVBdOwrf2CvB81Z9zRh25ZYMMgX4+qTXMtLrUTWG
         aJk1kNULV/yYh18oLwGY/o3vrpj9EqAXMi68sVua6nj+LOSXPklBxiU604g8UHTufF1b
         Xmnu/EMXckhqnTa8400OAoXJJquZdGcPU5llhm3kaICJWYZ5cSYQcWLE5ewOJ88lOv0q
         9f8NzBbgnyh8IMqQxlI1bpXWNAGo5PE2HgE3uiavBHp5GhoguSSCReZ9rQhCA8DRBJEJ
         06Pw==
X-Gm-Message-State: AJcUukccSAnVUwXn2KQ3dTOiEl4mMEO4P3GmelIEwxCpHFIBYdqX47f8
        5uOQ4wAbUJqKqRFcZsRYBiY=
X-Google-Smtp-Source: ALg8bN5TTXUHzmTTIw7yDUWfoRjlGnCZLorZjEoJR8Ejpe+tKxEY7ErJ7vYC5WPQPzvKzh1tDj323g==
X-Received: by 2002:adf:8506:: with SMTP id 6mr2900509wrh.128.1545692639783;
        Mon, 24 Dec 2018 15:03:59 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f192sm33124491wmd.12.2018.12.24.15.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 15:03:59 -0800 (PST)
Date:   Tue, 25 Dec 2018 00:03:57 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v4.21
Message-ID: <20181224230357.GA96402@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

   # HEAD: aa02ef099cff042c2a9109782ec2bf1bffc955d4 x86/topology: Use total_cpus for max logical packages calculation

Misc changes:

 - Fix nr_cpus= boot option interaction bug with logical package 
   management

 - Clean up UMIP detection messages

 - Add WBNOINVD instruction detection

 - Remove the unused get_scattered_cpuid_leaf() function.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/umip: Print UMIP line only once

Hui Wang (1):
      x86/topology: Use total_cpus for max logical packages calculation

Janakarajan Natarajan (1):
      x86/cpufeatures: Add WBNOINVD feature definition

Lendacky, Thomas (1):
      x86/umip: Make the UMIP activated message generic

Sean Christopherson (1):
      x86/cpufeatures: Remove get_scattered_cpuid_leaf()


 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/kernel/cpu/common.c       |  2 +-
 arch/x86/kernel/cpu/cpu.h          |  3 ---
 arch/x86/kernel/cpu/scattered.c    | 24 ------------------------
 arch/x86/kernel/smpboot.c          |  2 +-
 5 files changed, 3 insertions(+), 29 deletions(-)

