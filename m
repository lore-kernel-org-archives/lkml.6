Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A65C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE162098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE162098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJDO1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727206AbeJDO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79877ACC5;
        Thu,  4 Oct 2018 07:35:36 +0000 (UTC)
Date:   Thu, 4 Oct 2018 09:35:35 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] hid: hid-core: Fix a sleep-in-atomic-context bug in
 __hid_request()
In-Reply-To: <6bea4185-3325-b04d-56ed-2fdf4c74d8ae@gmail.com>
Message-ID: <nycvar.YFH.7.76.1810040935090.14430@cbobk.fhfr.pm>
References: <20180913033432.16336-1-baijiaju1990@gmail.com> <nycvar.YFH.7.76.1809241124480.15880@cbobk.fhfr.pm> <4c0096c6-3745-963c-5086-5f579792599b@gmail.com> <nycvar.YFH.7.76.1809292118240.15880@cbobk.fhfr.pm>
 <6bea4185-3325-b04d-56ed-2fdf4c74d8ae@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018, Jia-Ju Bai wrote:

> > Why? Forcing all the report buffer to be limited to be non-sleeping
> > allocations just because of two drivers, looks like an overkill, and
> > actually calls for more issues (as GFP_ATOMIC is of course in principle
> > less likely to succeed).
> 
> Okay, I thought that using GFP_ATOMIC is the simplest way to fix these bugs.
> But I check the Linux kernel code again, and find that hid_hw_request() are
> called at many places.
> So changing this function may affect many drivers.
> I agree to only change the two drivers, and explicitly anotate __hid_request()
> with might_sleep().

Thanks. Are you planning to submit a patch to do that?

-- 
Jiri Kosina
SUSE Labs

