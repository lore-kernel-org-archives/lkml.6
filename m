Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF933C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A8521479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3KBbxI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A8521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeJJTVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJTVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:21:16 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FDD21479;
        Wed, 10 Oct 2018 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539172766;
        bh=8LH3Yc4o34qXzXgYaycrFKqMpAIiNhIzG+SbeS3wY+Q=;
        h=From:Date:Subject:To:Cc:From;
        b=M3KBbxI94Yl3fDUOK/HdnxjjZbq0CZNt+C9YzopNg22gTbjz8OApi+RiemAoO65DD
         YZ43ue9OaKXoDnHeFk0m7D35LiUZ9OEI4cPaHpS0fGstlDI7KAa0vJmP3CvciK/X8O
         RmkqHtXPvFmznMH2QbMDdmHBRTaaUC0KVjsrw/us=
Received: by mail-qt1-f176.google.com with SMTP id b4-v6so5237661qtc.7;
        Wed, 10 Oct 2018 04:59:26 -0700 (PDT)
X-Gm-Message-State: ABuFfohXJBX7EVCIjvfe5/+IgIbX4iI4gWA0xWUfKhcW0KWZ4v8qsG5f
        grwmQpJMuYGLZr3pnOD73JhmpwfC+cDI3P/jHg==
X-Google-Smtp-Source: ACcGV63vOlxfZLHcbHj6Pa6Y/HtGVOVboiyoRJ5Kqsb0QcJPK6mtX2sIkSA0iO5RL9JDXqcStdhnittU7X5vvJ4dzrM=
X-Received: by 2002:ac8:1739:: with SMTP id w54-v6mr27533358qtj.76.1539172765490;
 Wed, 10 Oct 2018 04:59:25 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Oct 2018 06:59:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL4xQXoQubUEb9p2r5AEV+n1OAW=ss-DVQm4dmWU=n2hw@mail.gmail.com>
Message-ID: <CAL_JsqL4xQXoQubUEb9p2r5AEV+n1OAW=ss-DVQm4dmWU=n2hw@mail.gmail.com>
Subject: [GIT PULL] Devicetree fix for 4.19-rc8
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull this one DT fix for 4.19.

Note I didn't tag this for stable as I cherry-picked it from my 4.20
branch and wanted to not touch the commit msg at all. Maybe that
doesn't matter.

Rob

The following changes since commit e54192b48da75f025ae4b277925eaf6aca1d13bd:

  of: fix phandle cache creation for DTs with no phandles (2018-09-11
11:28:40 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.19-3

for you to fetch changes up to 8894891446c9380709451b99ab45c5c53adfd2fc:

  of: unittest: Disable interrupt node tests for old world MAC systems
(2018-10-10 06:43:37 -0500)

----------------------------------------------------------------
Devicetree fixes for 4.19, part 3:

- Fix DT unittest on Oldworld MAC systems

----------------------------------------------------------------
Guenter Roeck (1):
      of: unittest: Disable interrupt node tests for old world MAC systems

 drivers/of/unittest.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)
