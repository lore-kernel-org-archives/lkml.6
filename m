Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CE920818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfBURrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:47:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbfBURrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:47:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC916C057F40;
        Thu, 21 Feb 2019 17:47:50 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B42D1001DC5;
        Thu, 21 Feb 2019 17:47:50 +0000 (UTC)
Subject: Re: [PATCH] sysctl: Fix proc_do_large_bitmap for large input buffers
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, netdev@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <53be40fc-6ec4-c714-a64e-f69c96f7058f@redhat.com>
 <76eca432-8dfc-18f3-4977-567ac1707ff5@sandeen.net>
 <20190221151854.GJ11489@garbanzo.do-not-panic.com>
From:   Eric Sandeen <sandeen@redhat.com>
Message-ID: <72a6d9bc-cfb9-a21a-960d-bb01331c0dd7@redhat.com>
Date:   Thu, 21 Feb 2019 11:47:49 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221151854.GJ11489@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 21 Feb 2019 17:47:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 9:18 AM, Luis Chamberlain wrote:
> On Wed, Feb 20, 2019 at 05:35:04PM -0600, Eric Sandeen wrote:
>> Here's a pretty hacky test script to test this code via
>> ip_local_reserved_ports
> 
> Thanks Eric!
> 
> So /proc/sys/net/ipv4/ip_local_reserved_ports is a production knob, and
> if we wanted to stress test it with a selftest it could break other self
> tests or change the system behaviour. Because of this we have now have
> lib/test_sysctl.c, and we test this with the script:
> 
> tools/testing/selftests/sysctl/sysctl.sh
> 
> Any chance you can extend lib/test_sysctl.c with a new respective bitmap
> knob,

Done

> and add a respective test? This will ensure we don't regress
> later. 0-day runs sysctl.sh so it should catch any regressions in the
> future.

As you know, learning somebody else's test harness infra is a PITA. ;)
Can you find me off-list and give me a hand with this?

Thanks,
-Eric
