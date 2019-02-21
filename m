Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750092081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfBUTCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:02:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:46488 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfBUTCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:02:36 -0500
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id C5C9772D;
        Thu, 21 Feb 2019 19:02:35 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        axboe@kernel.dk, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] docs: Add some struct file refcounting information 
Date:   Thu, 21 Feb 2019 12:02:28 -0700
Message-Id: <20190221190230.17985-1-corbet@lwn.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro's recent "braindump" on how struct file refcounting works is too
good to lose, so let's capture it in Documentation/.  There are two changes
here:

 - Clean up the filesystem book, move stuff around, and generally try to
   create some order here.  No text changes other than some connecting
   text.

 - Bring in Al's text, with a fair amount of language tweaking and later
   corrections applied.

Hopefully this is just the beginning.

Jonathan Corbet (2):
  docs: Bring some order to filesystem documentation
  docs: Add struct file refcounting and SCM_RIGHTS mess info

 Documentation/filesystems/api-summary.rst | 150 ++++++++
 Documentation/filesystems/index.rst       | 395 ++--------------------
 Documentation/filesystems/journalling.rst | 184 ++++++++++
 Documentation/filesystems/lifecycles.rst  | 357 +++++++++++++++++++
 Documentation/filesystems/path-lookup.rst |  15 +
 Documentation/filesystems/splice.rst      |  22 ++
 6 files changed, 753 insertions(+), 370 deletions(-)
 create mode 100644 Documentation/filesystems/api-summary.rst
 create mode 100644 Documentation/filesystems/journalling.rst
 create mode 100644 Documentation/filesystems/lifecycles.rst
 create mode 100644 Documentation/filesystems/splice.rst

-- 
2.20.1

