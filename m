Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFC8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC82152B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="K3q6ZAE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAC82152B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHOV0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:26:46 -0400
Received: from webmail.newmedia-net.de ([185.84.6.166]:50302 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbeHOV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=JOahlOpf5RuPftJgp+bfwjST85+kqyaSWUUlCxuBNjA=;
        b=K3q6ZAE3/9y7j08UdI7S8/CNxuP9YrMmo6WnyJmeKThUxVDrFlTacvOFR3eEDuYCfRoMzl4/8M1ie+i8jJgzctaoQEwRAEkOmuzeSWBhn1HRz02ZM3INcYvzrx3DsGSH5UGZQ82lPWrsd1FVs65LNWJJ1qC4HKehd5lBhMBLaDo=;
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <e675976b-c23d-5bee-0583-cf241033d02f@dd-wrt.com>
 <CA+55aFyZz5jahQvHPjZebyfRNsZTP0+_0rm3tUR_2k6D26bzYA@mail.gmail.com>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <30ded8f9-5949-52db-7ef2-763b0e7a4abf@dd-wrt.com>
Date:   Wed, 15 Aug 2018 20:33:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyZz5jahQvHPjZebyfRNsZTP0+_0rm3tUR_2k6D26bzYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Received:  from [79.251.189.74] (helo=[10.88.193.131])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1fq0bp-00005q-I9; Wed, 15 Aug 2018 20:33:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 15.08.2018 um 20:26 schrieb Linus Torvalds:
> On Wed, Aug 15, 2018 at 11:22 AM Sebastian Gottschall
> <s.gottschall@dd-wrt.com> wrote:
>> btw. i found another compile error with x86 :-)
> This should already be fixed by commit d0055f351e64 ("x86/smp: fix
> non-SMP broken build due to redefinition of
> apic_id_is_primary_thread").
>
>            Linus

Hello Linus

unfortunatly there are numerous other non smp compile issues. this patch 
covers just one out of 3 found so far


Sebastian

>
