Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E04DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B60E2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 03:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B60E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tomt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbeJIKgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 06:36:20 -0400
Received: from mail1.ugh.no ([178.79.162.34]:38006 "EHLO mail1.ugh.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeJIKgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 06:36:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail1.ugh.no (Postfix) with ESMTP id 13348249B6B;
        Tue,  9 Oct 2018 05:21:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at catastrophix.ugh.no
Received: from mail1.ugh.no ([127.0.0.1])
        by localhost (catastrophix.ugh.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w54QYZhDNbtz; Tue,  9 Oct 2018 05:21:32 +0200 (CEST)
Received: from [10.255.99.10] (unknown [185.176.245.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andre@tomt.net)
        by mail.ugh.no (Postfix) with ESMTPSA id 6F684249B66;
        Tue,  9 Oct 2018 05:21:32 +0200 (CEST)
Subject: Re: [PATCH 4.18 000/168] 4.18.13-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181008175620.043587728@linuxfoundation.org>
From:   Andre Tomt <andre@tomt.net>
Message-ID: <966cae81-c3f6-1d38-5721-97dc317a3fde@tomt.net>
Date:   Tue, 9 Oct 2018 05:21:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. okt. 2018 20:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.13 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

   CC [M]  net/ipv4/netfilter/nf_conntrack_proto_icmp.o
net/ipv4/netfilter/nf_conntrack_proto_icmp.c:373:3: error: ‘const struct 
nf_conntrack_l4proto’ has no member named ‘ctnl_timeout’; did you mean 
‘get_timeouts’?
   .ctnl_timeout  = {
    ^~~~~~~~~~~~
    get_timeouts

The problematic patch is:> 
netfilter-conntrack-timeout-interface-depend-on-config_nf_conntrack_timeout.patch

The stuff the commit message talks about seems like it was added in 
4.19-rc1, so this should not go into stable.

Kernel builds fine with this one patch reverted.
