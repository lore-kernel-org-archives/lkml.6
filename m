Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B569C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8D4207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="SyOOUP0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfBEQcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:32:19 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:55967 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBEQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:32:18 -0500
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 11:32:18 EST
Received: from hatter.bewilderbeest.net (hatter.bewilderbeest.net [IPv6:2001:470:c3f4:1::1:1])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 102B780536;
        Tue,  5 Feb 2019 08:23:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 thorn.bewilderbeest.net 102B780536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1549383835;
        bh=EqbUr0rHoWSHOZM1uIy4w3iv/UhHwddLJhsy4qMYXKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyOOUP0tvBAvAo805s/FbQdI2q3DlWMBYKbKJztwF+VuX3gEYwQzYX4nnMpjvKu/C
         T4Kr5Ld5W9KEpRxvyYSf4/7/cR6hh+DnUHHrtxHI7alzl/n4KzZAcjYAI75cR4OBn/
         z2sBoa3kWMqJeqSlh93Du2nk+SxKtrer3xF+2VMo=
Date:   Tue, 5 Feb 2019 10:23:52 -0600
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] sysctl: fix range-checking in
 do_proc_dointvec_minmax_conv()
Message-ID: <20190205162351.c2ihwydd6hkum7ub@hatter.bewilderbeest.net>
References: <20181227111231.12912-1-zev@bewilderbeest.net>
 <20181227111231.12912-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181227111231.12912-1-zev@bewilderbeest.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...any thoughts on these patches?  (May have slipped through the 
cracks over people's holiday vacations I'd guess.)

Thanks,
Zev

On Thu, Dec 27, 2018 at 05:12:28AM CST, Zev Weiss wrote:
>Hello,
>
>After being left with an unusable system after a typo executing
>something like 'echo $((1<<24)) > /proc/sys/vm/max_map_count', I found
>that do_proc_dointvec_minmax_conv() was missing a check to ensure that
>the converted value actually fits in an int.
>
>The first of the following patches enhances the sysctl selftest such
>that it detects this problem; the second fixes it (wasn't entirely
>sure if this would meet the criteria of something that should be sent
>to -stable; input welcome).
>
>
>Thanks,
>Zev Weiss
>
