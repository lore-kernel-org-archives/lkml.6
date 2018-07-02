Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32222C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4106250AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KcKGQ2jA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hDdlIomR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4106250AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeGBO60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:58:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41254 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeGBO6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:58:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2DD28607EB; Mon,  2 Jul 2018 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530543500;
        bh=ImFkgu7fNyRTmVi15Jb7pwSpNDE2r1ODZuutoKBMdLc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KcKGQ2jA7wuRWvOUqaaJideEYIBSvvS14cjuOPy3VjUnYwB7q/E4XK315n6O29dpd
         9VK4PaafT7FYcZbEnpDKMKCo2pyuFS35FnTneO5fwX9Lypo9DLuV0zosCyE/bEbkKe
         HU7+7jw1A0GZi6fCHk46YpoPKEaekEnOpeDEFMnc=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEBE76037C;
        Mon,  2 Jul 2018 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530543499;
        bh=ImFkgu7fNyRTmVi15Jb7pwSpNDE2r1ODZuutoKBMdLc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hDdlIomRtPfg39A7M9nMYGQ7gWlpv4QtOUA3KmVJEZ18tpE/z7Z5Wv51RrNjdBtZr
         gq7yGI3F57yMF+TBHxcidWSWG7PRJ/3dK+tYP2Bgtjhgwv/wpAJaszHDqW1MIY56vm
         YREaOj+zlSqYsRQ73s5nhk+swuX2JgidbCEsRRO4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEBE76037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] arm64: acpi: reenumerate topology ids
To:     Andrew Jones <drjones@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     shunyong.yang@hxt-semitech.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        yu.zheng@hxt-semitech.com, linux-arm-kernel@lists.infradead.org
References: <20180628145128.10057-1-drjones@redhat.com>
 <a38fb684-c023-1a96-464e-dd268f3132ea@arm.com>
 <20180628173243.obydzakh2stfs26w@kamzik.brq.redhat.com>
 <20180629102927.GA18043@e107155-lin>
 <20180629112354.hefdl2pe72frl6x3@kamzik.brq.redhat.com>
 <20180629132934.GA16282@e107155-lin>
 <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <3a393398-b340-84f0-3478-ebd7dba9a0ae@codeaurora.org>
Date:   Mon, 2 Jul 2018 08:58:17 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629154608.nqudibf54ti6dpjc@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/2018 9:46 AM, Andrew Jones wrote:
> On Fri, Jun 29, 2018 at 02:29:34PM +0100, Sudeep Holla wrote:
>> If it matters a lot, vendors must use UID for consistency. Since OS doesn't
>> use those IDs for any particular reason, OS must not care.
> 
> That depends. If you look at how topology_logical_package_id() is used in
> x86 code you'll see it gets used as an index to an array in a couple
> places. If we don't remap arbitrary IDs to counters than we may miss out
> on some opportunities to avoid lists.
> 
> Also, we're talking about what's visible to users. I think it's much more
> likely to break a user app by exposing topology IDs that have values
> greater than the linear CPU numbers (even though properly written apps
> shouldn't expect them to be strictly <=), than the opposite.

Libvirt has the assumption already that the sysfs numbers correspond to 
linear CPU numbers, and has an arbitrary limit of 4k.  When spinning up 
a VM, if libvirt sees a CPU ID > 4k, it fails to init the VM since it 
assumes the host has more than 4k CPUs, which is unsupported.

We found this when we were making our UIDs to be the same as MPIDR in 
MADT.  We changed our UIDs to be sequential 0-N numbering to workaround 
the issue.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
