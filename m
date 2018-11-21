Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A704214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A704214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeKUWZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:25:07 -0500
Received: from ozlabs.org ([203.11.71.1]:60395 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbeKUWZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:25:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 430LW736LBz9s3l;
        Wed, 21 Nov 2018 22:50:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v1 3/6] powerpc: Add skeleton for Kernel Userspace Execution Prevention
In-Reply-To: <63177c72b94a653707d6b984ca789ecf8ebf0a95.camel@russell.cc>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr> <1b27e980fa8dda09955b35be09c99bb1e22fef70.1541568127.git.christophe.leroy@c-s.fr> <63177c72b94a653707d6b984ca789ecf8ebf0a95.camel@russell.cc>
Date:   Wed, 21 Nov 2018 22:50:56 +1100
Message-ID: <87ftvu1wf3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Currey <ruscur@russell.cc> writes:

> On Wed, 2018-11-07 at 16:56 +0000, Christophe Leroy wrote:
>> This patch adds a skeleton for Kernel Userspace Execution Prevention.
>> 
>> Then subarches implementing it have to define CONFIG_PPC_HAVE_KUEP
>> and provide setup_kuep() function.
>> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> An open question (with nothing to do specifically with this patch):
>
> For what reason would you ever disable execution prevention?  Clearly
> there must be something since "nosmep" is a thing, but I don't know why
> we'd ever do it.

Because depending on the implementation there might be a performance
overhead, and you may want to avoid that.

cheers
