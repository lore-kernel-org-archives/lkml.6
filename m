Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60517C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B7022419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B7022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbeKOSsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:48:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeKOSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:48:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F89681F11;
        Thu, 15 Nov 2018 08:41:44 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A85CC60BF6;
        Thu, 15 Nov 2018 08:41:40 +0000 (UTC)
Date:   Thu, 15 Nov 2018 09:41:38 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: KVM selftests are failing
Message-ID: <20181115084138.m7oflwso6f72tgsx@kamzik.brq.redhat.com>
References: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
 <20181114180807.6crs7awhvo26ldbr@hawk.localdomain>
 <CADYN=9Jh10guVNFfhS8XH+RwZAouLJQu7Svg4+Tz3rQDexzDkg@mail.gmail.com>
 <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBxJ=G4xdF8ZOR4zyoX1edNa=jYxk1xrzoi+7Xgcqt9qDoM2w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 15 Nov 2018 08:41:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 09:23:41PM +0200, Ahmed Soliman wrote:
> Hello,
> 
> > > I couldn't reproduce this on a Westmere. Are you sure you're testing
> > > a clean compilation? Can you bisect the kernel?
> I don't do a make clean normally, but I will do it this time when
> bisecting,

Sorry, I meant a clean build of the kvm selftests, not the kernel. The
kvm selftests makefile is a bit lacking and I've noticed that tests can
assert in random places if they aren't built from scratch - ensuring all
changed dependencies also get recompiled. Fixing up the makefile is on
my todo, but it wasn't very high on it, since 'make clean && make' is
fast enough.

> also I only use shallow
>  clones so it will also take some time pulling. Also to note, The arch
> I am using is Haswell, I am not
> sure if that should make any difference though.

I'm not sure either, and unfortunately I don't have the same hardware
as you to try and reproduce.

> > What would be the difference in CONFIG_* fragments that you both have enabled?
> 
> Here is my config file:
> https://pastebin.com/fCNV2z8c

I checked the differences but nothing interesting stood out. I'm using a
defconfig config with a couple extra file system modules tacked on.

drew
