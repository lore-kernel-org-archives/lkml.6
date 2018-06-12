Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06BCCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE19208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE19208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933705AbeFLIJv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:09:51 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:5940 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932497AbeFLIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:09:49 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH 00/13 selinux-next] selinux: Cleanup printk logging
Date:   Tue, 12 Jun 2018 10:08:59 +0200
Message-ID: <20180612080912.7827-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces printk with pr_* for the selinux files.
I get a lot of checkpatch warnings when doing my other work,
lets get rid of the warnings.

For the policydb.c there also a removal of KERN_CONT with
two longer prints.

I have NOT cleaned up splitting lines with long prints. I think
the current conclusion is that it is better to have long lines
that it to have splitting print lines.

There is one patch per file for this files:
conditional.c
ebitmap.c	 
policydb.c
avtab.c
hooks.c	  
avtab.c	  
services.c	  
selinuxfs.c	  
netlink.c	  
sidtab.c	  
netport.c	  
netif.c	  
avc.c	 
netnode.c   

