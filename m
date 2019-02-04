Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E945C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B122082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfBDOER convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:04:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfBDOER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:04:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6D7489AD2;
        Mon,  4 Feb 2019 14:04:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FD2A8923D;
        Mon,  4 Feb 2019 14:04:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190204135403.ttitgfy22cp7h2lh@fsr-ub1664-175>
References: <20190204135403.ttitgfy22cp7h2lh@fsr-ub1664-175>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     dhowells@redhat.com,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: PROBLEM: fs: hugetlbfs: boot failure due to specs sentinel missing on linux-next
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12005.1549289049.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Mon, 04 Feb 2019 14:04:09 +0000
Message-ID: <12006.1549289049@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 04 Feb 2019 14:04:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abel Vesa <abel.vesa@nxp.com> wrote:

> Your commit:
> 2284cf59cbcec "hugetlbfs: Convert to fs_context"
> doesn't put a sentinel at the end of hugetlb_param_specs.

Yes, I have a fix queued for Al to pick up on my mount-api-viro branch (2nd
from bottom, "Fix hugetlbfs").

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=container&id=e0e93001d88ab48b40923d926b2cc5e1534407f0

David
