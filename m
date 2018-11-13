Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AF2C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B2922507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B2922507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbeKMVHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:07:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32737 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732392AbeKMVHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:07:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF65930820DD;
        Tue, 13 Nov 2018 11:09:47 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-239.ams2.redhat.com [10.36.116.239])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F262F1974C;
        Tue, 13 Nov 2018 11:09:45 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Norov\, Yuri" <Yuri.Norov@cavium.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api\@vger.kernel.org" <linux-api@vger.kernel.org>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH RESEND] UAPI: move RENAME_* definitions to separated file
References: <20181113085102.3079-1-ynorov@caviumnetworks.com>
Date:   Tue, 13 Nov 2018 12:09:40 +0100
In-Reply-To: <20181113085102.3079-1-ynorov@caviumnetworks.com> (Yury Norov's
        message of "Tue, 13 Nov 2018 08:51:12 +0000")
Message-ID: <878t1xkzd7.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 13 Nov 2018 11:09:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Yury Norov:

> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 53a22e8e0408..dbf58bbf5bad 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h

Could you move it to a dedicated <linux/rename-flags.h> header?  Or add
a comment that the header is only for rename flags?

Then we can change glibc to include it if it is present and when
compiling under _GNU_SOURCE.

Thanks,
Florian
