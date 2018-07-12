Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8620C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E8620C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeGLHCh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:02:37 -0400
Received: from ozlabs.org ([203.11.71.1]:52851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbeGLHCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:02:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R69r4NSwz9s1R;
        Thu, 12 Jul 2018 16:54:24 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Several suspected memory leaks
In-Reply-To: <877em1alut.fsf@concordia.ellerman.id.au>
References: <468d3c5b-d71d-c95b-dab4-ea8c2cebe129@molgen.mpg.de> <877em1alut.fsf@concordia.ellerman.id.au>
Date:   Thu, 12 Jul 2018 16:54:24 +1000
Message-ID: <87601l7xlr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Hi Paul,
>
> Paul Menzel <pmenzel@molgen.mpg.de> writes:
>> Dear Liunx folks,
>>
>> On a the IBM S822LC (8335-GTA) with Ubuntu 18.04 I built Linux master
>> – 4.18-rc4+, commit 092150a2 (Merge branch 'for-linus'
>> of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid) – with
>> kmemleak. Several issues are found.
>
> Is this the first time you've tested it?
> Or did these warnings only show up recently?
>
>> ```
>> $ grep KMEMLEAK /boot/config-4.18.0-rc4+
>> CONFIG_HAVE_DEBUG_KMEMLEAK=y
>> CONFIG_DEBUG_KMEMLEAK=y
>> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=10000
>> # CONFIG_DEBUG_KMEMLEAK_TEST is not set
>> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
>
>
> I'm not seeing any warnings on my machine here, maybe it's something
> config related. Can you send your full .config ?

Scratch that. I just didn't wait long enough.

cheers
