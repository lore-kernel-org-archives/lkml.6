Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4CA2188F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZhVzzKVh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZhVzzKVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4CA2188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeHQRlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:41:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54344 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeHQRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:41:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 355656263A; Fri, 17 Aug 2018 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534516683;
        bh=KvZGDdI9d79Ko9aMMWkqgXqJw+ZjKYPwalxl+JD2cUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZhVzzKVhLWF172f9sCRXDBqHINCZV939r1UYoTuhzxbOSU1/a7t9aDIk7mynu5qg5
         Zqq89blxeBNDl82NezNGh0r1+xOVlwDWQ1scFBKNVpGZaRFF+UHjXA9ukP9zO6byXD
         Cp8x+4JI6xJ36hB/pWKsC2fNZUgcI2azFVYqwNe0=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF3A1622CE;
        Fri, 17 Aug 2018 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534516683;
        bh=KvZGDdI9d79Ko9aMMWkqgXqJw+ZjKYPwalxl+JD2cUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZhVzzKVhLWF172f9sCRXDBqHINCZV939r1UYoTuhzxbOSU1/a7t9aDIk7mynu5qg5
         Zqq89blxeBNDl82NezNGh0r1+xOVlwDWQ1scFBKNVpGZaRFF+UHjXA9ukP9zO6byXD
         Cp8x+4JI6xJ36hB/pWKsC2fNZUgcI2azFVYqwNe0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF3A1622CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: Query on shrink list
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <301a5546-d326-d78e-3be6-41b5a6a08c0e@codeaurora.org>
 <20180817125812.GC6515@ZenIV.linux.org.uk>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b638d027-023a-d455-f77e-d66c10b8d9e4@codeaurora.org>
Date:   Fri, 17 Aug 2018 20:07:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180817125812.GC6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/2018 6:28 PM, Al Viro wrote:
> On Fri, Aug 17, 2018 at 03:39:22PM +0530, Mukesh Ojha wrote:
>> Hi Al Viro,
>>
>> Is there is reason we have kept data->found++, if the dentry already there
>> in shrink list ?
>>
>> static enum d_walk_ret select_collect(
>> ...
>>          if (dentry->d_flags & DCACHE_SHRINK_LIST) {
>>                  data->found++;
>>          } else {
>>    ..
>>
>> If the dentry is already there on shrink list, does it not mean that
>> data->found is already non-zero ?
> Nope.  It can be on *another* shrink list - if two processes are doing
> that...

Ok, if we go out simply,  letting others to do the job will break 
`shrink_dcache_parent()`
and if someone touched that dentry made the refcount > 0 while it is on 
shrink list
  then owner will keep on looping in shrink_dentry_list() until refcount 
becomes 0 .

Am i making sense here ?

Thanks.
Mukesh

>
>> Can't we just go out from here directly?

