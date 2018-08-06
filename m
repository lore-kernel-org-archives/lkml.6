Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E7C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0721A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA0721A56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbeHFTpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:45:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41575 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeHFTpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:45:38 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fmjPn-0002bB-6f; Mon, 06 Aug 2018 11:35:31 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fmjPm-0001Fr-KB; Mon, 06 Aug 2018 11:35:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180620123905.348181b2@canb.auug.org.au>
        <20180806175047.5b612a77@canb.auug.org.au>
Date:   Mon, 06 Aug 2018 12:35:20 -0500
In-Reply-To: <20180806175047.5b612a77@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 6 Aug 2018 17:50:47 +1000")
Message-ID: <87lg9j8kkn.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fmjPm-0001Fr-KB;;;mid=<87lg9j8kkn.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+2EmHDNwJTPtGLixFjl7Vwlw9Nsplb2Pw=
X-SA-Exim-Connect-IP: 97.119.167.31
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
> On Wed, 20 Jun 2018 12:39:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Are there any comments on this resolution.  I just had to do it all
> again due to slight changes in the vfs tree.  What are you guys going
> to tell Linus when he comes to merge this?

Currently that the fscontext changes have a gaping security hole in it's
userspace API.  Granted the security hole is copied from the existing
mount api.  But I have had multiple real world problems with the
existing behavior, and I have reported it to David Howells multiple
times.

So I honestly don't think David Howells changes are ready to be merged.

The changes to proc exhibit the security holet and I expect they will
have to be redone to make the patch functional.

Eric

