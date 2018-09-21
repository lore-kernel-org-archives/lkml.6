Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6BECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C366521523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C366521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbeIUSXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:23:44 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46584 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeIUSXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:23:44 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g3KeF-0006sJ-Cy; Fri, 21 Sep 2018 06:35:03 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g3KeE-000671-2m; Fri, 21 Sep 2018 06:35:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-12-ebiederm@xmission.com>
        <alpine.DEB.2.21.1809182242380.1468@nanos.tec.linutronix.de>
        <ed6d5892-4a05-40b7-0ebd-58efc5cc7d3e@linux.intel.com>
Date:   Fri, 21 Sep 2018 14:34:49 +0200
In-Reply-To: <ed6d5892-4a05-40b7-0ebd-58efc5cc7d3e@linux.intel.com> (Dave
        Hansen's message of "Wed, 19 Sep 2018 09:33:42 -0700")
Message-ID: <87sh2358ra.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g3KeE-000671-2m;;;mid=<87sh2358ra.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18j717Z6wRF3a6Qtktc69lyaOL5b+IDo8o=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [REVIEW][PATCH 12/20] signal/x86: Remove pkey parameter from bad_area_nosemaphore
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> writes:

> On 09/18/2018 01:44 PM, Thomas Gleixner wrote:
>> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>>> The function bad_area_nosemaphore always sets si_code to SEGV_MAPERR
>>> and as such can never return a pkey parameter.  Therefore remove the
>>> unusable pkey parameter from bad_area_nosemaphore.
>
> The result of this looks nice to me.  It's especially nice to see the
> scope where we have to pass around the pkey get reduced.
>
> I also ran the pkey selftests against the current version of your
> siginfo-testing branch.  Everything passes fine on my pkey-enabled
> system.

Thank you for testing.  I was quite pleased myself when I saw that the
pkey scope was reduced.

Did you by any chance test powerpc?  As I also reduced the scope of pkey
there as well and that is also in my siginfo-testing branch.

Eric

