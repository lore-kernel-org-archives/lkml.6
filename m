Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D32720881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 08:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZbkdirS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D32720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeG3K11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:27:27 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:35961 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeG3K10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:27:26 -0400
Received: by mail-qt0-f178.google.com with SMTP id t5-v6so11254560qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HGz37AUYt2g09Jvu8rDOcVhZk4I9X8Y97jL7KXmjaDc=;
        b=pZbkdirStyDaEqPJt9PDUxLrfCFjSMdC2pVd2S+rXzkMhPlFxlZVxz3hGdwR58VXdZ
         OMS0W2q9eUYuvMEgJSerM2Eudl6H05oFoGGE5DYeoBixxqUEuH2k1MRZkkSiZBm/ppMu
         4AJh/2QhdEfKDtZnIxytEzlSSF91rcXnUtX561Ot7pjiprTQdAuQv1P/kGXO0/2mI+p1
         82R0ZpMRtOrqror7LBsQDKJS/lZ84nwBXnySh2O1hjaTvQ1vhmKFvPC9nWi2kOzJHnTN
         5I+pF91pYVigqB4/XvqniDHAZCa0B1jlR/FZFLHrDBZYU35oQR4vrzvdDVJMp6A1pRbj
         iiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HGz37AUYt2g09Jvu8rDOcVhZk4I9X8Y97jL7KXmjaDc=;
        b=ZWPSWORDyy+D7pmFDgd8w7oaIzxg9yjWdjJ7LmLOSyCrSeFU5M58FOufNMAJKHjKO2
         sUfjECCEHOOynDL5T/Iu8dAlfeI7Uh6kaDUCSfXqmD9XYl2yLmq/pHXe0331nfmwyqKB
         tS2w/0Bn/owPQfQybAjLr/+Eshxb53Pj0qIerXwYU6vFGwtlwV+DTr/xHja6sVp59lAN
         ziq37K+53ToNCX4N1hKKDrj+2cSLM4AT7N5dkqGzOI2pQn332frRWdUHMr7nk0eGbm89
         6D2ZOmtnuEQRTzAZVqIQ13Ayv72d4W3CqdsVksyuZHyjfHoRKRntYAESpPsytn5gzsed
         MHbQ==
X-Gm-Message-State: AOUpUlFPCEDZlBL9Sm6/1ZoNzJkO1c1cgEngDD0uV0RM0Xj75Pmuh2M7
        ul2lraK8hyxt0kyFk58N971MJCbGbcaGt5nzKMs=
X-Google-Smtp-Source: AAOMgpftmivMyHJZ6Aud285Ecu4hXlDKMvAktGST0O8myV01TXBokW5IoQ2mf6C7U9RSB9231JUC9kCu8OayR6pvSPw=
X-Received: by 2002:ac8:16ee:: with SMTP id y43-v6mr16202771qtk.148.1532940809062;
 Mon, 30 Jul 2018 01:53:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:21e1:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 01:53:28
 -0700 (PDT)
From:   Charlemagne Lasse <charlemagnelasse@gmail.com>
Date:   Mon, 30 Jul 2018 10:53:28 +0200
Message-ID: <CAFGhKbzXiAx3iaveOQhXCseH2kg1U=j-sp0B9jNSF2wPUjDtFg@mail.gmail.com>
Subject: checkpatch: SPDX integration breaks --root
To:     Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh@kernel.org>, Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am now getting python errors when using --root with checkpatch.pl
and not being inside the linux repository.

$ ./linux-next/scripts/checkpatch.pl --root=/usr/src/linux-next
--strict -f linux-next/Makefile
FAIL: /usr/src
Traceback (most recent call last):
 File /usr/src/linux-next/scripts/spdxcheck.py", line 230, in <module>
   repo = git.Repo(os.getcwd())
 File "/usr/lib/python2.7/dist-packages/git/repo/base.py", line 156, in __init__
   raise InvalidGitRepositoryError(epath)
InvalidGitRepositoryError: /usr/src

total: 0 errors, 0 warnings, 0 checks, 1726 lines checked

linux-next/Makefile has no obvious style problems and is ready for submission.
