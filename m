Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF45C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CB72146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CB72146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeISE55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:57:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41230 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeISE54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB5CE36A5F5;
        Tue, 18 Sep 2018 23:23:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64AC430912F4;
        Tue, 18 Sep 2018 23:23:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180913010517.GB7632@shao2-debian>
References: <20180913010517.GB7632@shao2-debian>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [LKP] [ipc] 61224adcd2: general_protection_fault:#[##]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5175.1537312980.1@warthog.procyon.org.uk>
Date:   Wed, 19 Sep 2018 00:23:00 +0100
Message-ID: <5176.1537312980@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 18 Sep 2018 23:23:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I managed to run the job script for about 6 hours, but saw no problems.
I'm guessing it's one of those things that you have to hit just right.

I've updated my mount-api and fsinfo branches to remove the "shortcut" code
from mqueue_get_tree() and just rely on vfs_get_super() finding a duplicate
superblock.

I'll ask Al to pull it tomorrow if I can work out solutions to Stephen's
issues with building the sample programs.

David
