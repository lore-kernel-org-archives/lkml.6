Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D819C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F2C240C6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F2C240C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeGERg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:36:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59174 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbeGERg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:36:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fb8B7-0004Kh-Cn; Thu, 05 Jul 2018 11:36:25 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fb8B6-0004mS-Rb; Thu, 05 Jul 2018 11:36:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, seth.forshee@canonical.com,
        serge@hallyn.com, containers@lists.linux-foundation.org
In-Reply-To: <87lgapwrw4.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 05 Jul 2018 11:48:11 -0500")
References: <20180705155120.22102-1-christian@brauner.io>
        <87lgapwrw4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Thu, 05 Jul 2018 12:36:13 -0500
Message-ID: <874lhdwpo2.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fb8B6-0004mS-Rb;;;mid=<874lhdwpo2.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+AaQRG8OK9zxbnR09NTH+Phy7lJS2DbSg=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] Revert "vfs: Allow userns root to call mknod on owned filesystems."
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Your description is usesless.
>
> It needs to detail exactly what breaks, what regressions and why.
> All I see below is hand waving.
>
> We need to know why this does not work so someone does not come in and try
> this again.  Or so that someone can fix this and then try again.
>
> You do not include that kind of information in your commit log.
>
> Calling mknod to create device nodes can not be widespread.  There are
> not that many privileged processes and calling mknod outside of being
> a specialed process like udev is broken.
>
> Therefore I refute your assertion that this is a widespread issue.
>
>
> I expect somewhere there is a reasonable argument for reverting this
> change on the basis that it causes a regression. You have not made it.
>
> Until that time I am going to oppose this revert because your
> justfication for the revert is lacking.
>
>
> It has never been the case that mknod on a device node will guarantee
> that you even can open the device node.  The applications that regress
> are broken.  It doesn't mean we shouldn't be bug compatible, but we darn
> well should document very clearly the bugs we are being bug compatible
> with.
>

Further from what I have seen of this issue, there is a compelling case
that what the applications that are broken what what is enabled by
allowing mknod to succeed.  So we absolutely need a good description of
what is going on, because at best a revert to fix today's breaking is
temporary until userspace gets their bugs fixed.

Eric

