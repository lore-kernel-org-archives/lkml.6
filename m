Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CC0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF122133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF122133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeISDyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:54:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34214 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeISDyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:54:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2OL0-0001Zl-QX; Tue, 18 Sep 2018 16:19:18 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g2OKk-0006ye-P2; Tue, 18 Sep 2018 16:19:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180914105310.6454-1-jlayton@kernel.org>
        <87a7ohs5ow.fsf@xmission.com> <20180917155948.GA25565@redhat.com>
Date:   Wed, 19 Sep 2018 00:18:53 +0200
In-Reply-To: <20180917155948.GA25565@redhat.com> (Oleg Nesterov's message of
        "Mon, 17 Sep 2018 17:59:48 +0200")
Message-ID: <87o9cuh2k2.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g2OKk-0006ye-P2;;;mid=<87o9cuh2k2.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ia9qrzIEiH2Ja050oCQNoqQQz2BVPVBY=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH 0/3] exec: Moving unshare_files_struct
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/16, Eric W. Biederman wrote:
>>
>> Oleg's patch to remove get_files_struct from proc means we don't need
>> two counts in files_struct.
>
> So it seems you agree with this patch at least in general.

I do I think in the context we are looking at things finding a way not
to need to bump files_struct->count looks like it will simplify a lot of
things and there are not many cases we need to consider.

I have been thorough and mentioned the binder case and other case but
that isn't because I disagree I simply don't want us to overlook weird
or tricky cases.

It appears that the more often that we look at these bits the better
a solution we wind up writing.

> OK, if nobody else objects I'll split this patch and send the series
> tomorrow.

No objection from me.

>> Eric W. Biederman (3):
>>       exec: Move unshare_files down to avoid locks being dropped on exec.
>>       exec: Simplify unshare_files
>>       exec: Remove reset_files_struct
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Eric
