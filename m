Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D659C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBF32087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBF32087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJJSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:41:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:51062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbeJJSlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:41:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32DC4ACD0;
        Wed, 10 Oct 2018 11:19:39 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     "Yan\, Zheng" <ukernel@gmail.com>, "Yan\, Zheng" <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: only allow punch hole mode in fallocate
References: <20181009175428.18543-1-lhenriques@suse.com>
        <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
        <CAOi1vP_HmqS3xgAdYSpQYhRg-2q6mhHEaRpQW2+-UyJs9K1UsQ@mail.gmail.com>
Date:   Wed, 10 Oct 2018 12:20:37 +0100
In-Reply-To: <CAOi1vP_HmqS3xgAdYSpQYhRg-2q6mhHEaRpQW2+-UyJs9K1UsQ@mail.gmail.com>
        (Ilya Dryomov's message of "Wed, 10 Oct 2018 12:43:40 +0200")
Message-ID: <87sh1evyii.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilya Dryomov <idryomov@gmail.com> writes:

> On Wed, Oct 10, 2018 at 6:21 AM Yan, Zheng <ukernel@gmail.com> wrote:
>>
>> On Wed, Oct 10, 2018 at 1:54 AM Luis Henriques <lhenriques@suse.com> wrote:

<snip>

>> Applied, thanks
>
> I don't think it should go to stable kernels.  Strictly speaking it's
> a behaviour change -- it's been this way for many years and, unless you
> are close to ENOSPC, it's sort of appears to work.  I'll take off the
> stable tag unless I hear objections.

Right, it can in fact break applications that rely on the previous
(bogus) behaviour.  But it can also be claimed that it *will* break
applications anyway with an updated kernel, so backporting it to older
kernels will just allow a consistent behaviour.

Anyway, I'm OK either way.  But if you drop the stable tag make sure you
also remove the 'Fixes:' tag as I believe the stable folks will still
pick this patch if it includes a valid SHA1 in it.

Cheers,
-- 
Luis
