Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313832087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313832087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJTSW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:18:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJTSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:18:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64AEA30820C2;
        Wed, 10 Oct 2018 11:56:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9663662A3C;
        Wed, 10 Oct 2018 11:56:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
References: <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com> <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk> <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30812.1539172590.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 10 Oct 2018 12:56:30 +0100
Message-ID: <30813.1539172590@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 10 Oct 2018 11:56:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> wrote:

> I replied last time to wonder about the MNT_UMOUNT mnt_flag. So I've tested it
> now :-), on David's current tree (commit 5581f4935add).
> 
> The modified do_move_mount() allows re-attaching something that was
> lazy-unmounted. But the lazy unmount sets MNT_UMOUNT. And this flag is not
> cleared when the mount is re-attached.

Sorry, yes.  I'm not sure what the best way to deal with this is.  Should it
just return -EPERM or -ESTALE if MNT_UMOUNT is set?

David
