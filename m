Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87D1218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIIgAV+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfBFHhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:37:04 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:54552 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:37:03 -0500
Received: by mail-wm1-f52.google.com with SMTP id a62so1355511wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 23:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0jiLWJvR07UYohmurHBI0X7tAXrT2siMhOCEtEiwCEA=;
        b=HIIgAV+xY4r6J6TVCEhTVgrgs5set8qPIr0U0FUEyupkOvJe9PVR1aydjhLmHIQyf5
         rxikVb5isdW0E6xaxij3Dp/mywMp28R5SbqUrez07/D+uTQoMLBS2Omx4ZBPEUo4AtRW
         WuIqC4DHbMN0WBRqs5FSr2Wf9i7q45wLSTsIPUJht7V64LVhcVsZUKDVdgNFZndKeehQ
         Ht857tukSizMAblq1HyB23U8jK4aRkLl2MA/YATH87cbeDSlGfnCkeEkA1bqK8KQFPL8
         HrYIc8P9UNjrDoCo6k8p6J11FQmf/CqgHGpjRltuxH/Xge7FyQVlz3eiypCd0KllfKWR
         qASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0jiLWJvR07UYohmurHBI0X7tAXrT2siMhOCEtEiwCEA=;
        b=STT6VEvtE6QgbroV6QIW3klh2sbXmz5Ph8HhYgrDr7T8WRbiDRh9BGDi/7lM99fvCL
         Y7+DAItYkGGAbP0/gieYtvrQJ8VnQn9rmAdFcBZf7X2hn6tjIqqDj8gHB7P6LAukC/Yq
         0e+DSWzn3bB2877htCsYljEcyvf+I5CsLJuWnsGUYn8jeeHseByz0gwQ1m8hOwXdxDSf
         4WHMVDkgw2Jc51lIl5hmwXd8pPylej0DEZ4upA3NVvPf7EJl4SE1KYfm9Y2Q5bqulYvN
         ydXKRr/DMTLpwh3+W4YRejyxb1Vt6o5fc3SbjqaQ/t4AiYbDr+PIfHLnAqlfnPp1bQos
         hnTQ==
X-Gm-Message-State: AHQUAuYhP78qtUqvFk9eM2q/ZcpLGqSknfXpp9yluI4XIVJyICL23KEJ
        X0P0vNTdgHFZvojIe8ud26AlqxU=
X-Google-Smtp-Source: AHgI3IbZ91qEfL1jLkX25SkVsnIN91khYSJyMDMAQZwwQ3da6P2ObzRxJyQvIVxXI66pFTgKra3i0Q==
X-Received: by 2002:a1c:494:: with SMTP id 142mr1899285wme.111.1549438621769;
        Tue, 05 Feb 2019 23:37:01 -0800 (PST)
Received: from avx2 ([46.53.242.9])
        by smtp.gmail.com with ESMTPSA id b13sm15673611wrn.28.2019.02.05.23.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 23:37:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:36:59 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 1/2] proc: exit correctly in /proc/*/maps test
Message-ID: <20190206073659.GB15311@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If open() or writev() fails, test will hang waiting for child test
process.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	fold into proc-test-proc-maps-smaps-smaps_rollup-statm.patch

 tools/testing/selftests/proc/proc-pid-vm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -189,11 +189,11 @@ static int make_exe(const uint8_t *payload, size_t len)
 
 	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_EXCL|O_TMPFILE, 0700);
 	if (fd == -1) {
-		return 1;
+		exit(1);
 	}
 
 	if (writev(fd, iov, 3) != sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + len) {
-		return 1;
+		exit(1);
 	}
 
 	/* Avoid ETXTBSY on exec. */
