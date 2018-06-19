Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9A9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E09E20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E09E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937535AbeFSKMS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:12:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52893 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756569AbeFSKMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:12:16 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fVDcU-0000GY-0d; Tue, 19 Jun 2018 04:12:14 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fVDcE-0004Y1-LC; Tue, 19 Jun 2018 04:12:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20180619145605.1eb8e86f@canb.auug.org.au>
Date:   Tue, 19 Jun 2018 05:11:45 -0500
In-Reply-To: <20180619145605.1eb8e86f@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 19 Jun 2018 14:56:05 +1000")
Message-ID: <874lhz9jby.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fVDcE-0004Y1-LC;;;mid=<874lhz9jby.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX183fVYYfAKDl4/NtHg6snwxtdrbrrB6vHo=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: linux-next: manual merge of the userns tree with the vfs tree
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> Today's linux-next merge of the userns tree got conflicts in:
>
>   fs/proc/inode.c
>   fs/proc/root.c
>
> between commits:
>
>   0223e0999be2 ("procfs: Move proc_fill_super() to fs/proc/root.c")
>   83cd45075c36 ("proc: Add fs_context support to procfs")
>
> from the vfs tree and commit:
>
>   cc8cda3af2ba ("proc: Simplify and fix proc by removing the kernel mount")
>
> from the userns tree.
>
> I don't know how to fix this up, so I just dropped the userns tree for
> today (since it only contained that one commit).

The userns tree is a fix for a regression that I am sending to Linus
ASAP.  I don't remember any fundamental conflicts.  After we get 4.17
sorted out I will worry about this.

Eric

