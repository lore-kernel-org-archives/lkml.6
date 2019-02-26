Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC799217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfBZSMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:12:25 -0500
Received: from www62.your-server.de ([213.133.104.62]:55076 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:12:24 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyhDG-0007XY-Ue; Tue, 26 Feb 2019 19:12:19 +0100
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gyhDG-000LtZ-On; Tue, 26 Feb 2019 19:12:18 +0100
Subject: Re: [PATCH] bpf: decrease usercnt if bpf_map_new_fd() fails in
 bpf_map_get_fd_by_id()
To:     Martin Lau <kafai@fb.com>, zerons <sironhide0null@gmail.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1551190537-28694-1-git-send-email-sironhide0null@gmail.com>
 <20190226173355.chm6gwvwyer57yco@kafai-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f36d88ab-5f44-7365-ec7e-89c05067029a@iogearbox.net>
Date:   Tue, 26 Feb 2019 19:12:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190226173355.chm6gwvwyer57yco@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25372/Tue Feb 26 11:34:09 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/2019 06:33 PM, Martin Lau wrote:
> On Tue, Feb 26, 2019 at 10:15:37PM +0800, zerons wrote:
>> [ Upstream commit c91951f15978f1a0c6b65f063d30f7ea7bc6fb42 ]
>>
>> In bpf/syscall.c, bpf_map_get_fd_by_id() use bpf_map_inc_not_zero() to increase
>> the refcount, both map->refcnt and map->usercnt. Then, if bpf_map_new_fd() fails,
>> should handle map->usercnt too.
> Good catch!  Thanks for the fix.

+1

> Fixes: bd5f5f4ecb78 ("bpf: Add BPF_MAP_GET_FD_BY_ID")
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied, thanks!
