Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB1EC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628F82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544745928;
	bh=sMND/x7hKAb5z66ZliYJ5py8rFZ5Dys/023i38ACwRk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=k4wIwFWMWFUb87jDpa/k+uF/ZYMETY4t3SC8xdO2Wxydo4ox+617ne4jVVOzhtF7d
	 YlBt7AsMs5Lts0cq9F3oir5QmkWb7AEnsEXMwuAHl0EZObi6Hijcg75gjFpOE+FiVa
	 lsx9BfdwUa/G16HzIWMMsKTOU7dcnJKzMFXgBCf4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628F82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeLNAF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeLNAF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:05:26 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B7E20870;
        Thu, 13 Dec 2018 23:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544745416;
        bh=sMND/x7hKAb5z66ZliYJ5py8rFZ5Dys/023i38ACwRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hF2hKORxr5rcjdZf1IuEe59rRLTyC6ol07NHo4FOsiBhxtGj5C90pMoWHuYTNL7BS
         moVwoEaDplhHG50ulxYzKm2R4t2qYN4FwY8ZzON1hI5captZJSms5XlMPPa3hoWZ/4
         MgBgzE8b45+OOqc7fnDoZWBWCUqyzOv/MD1/lQJo=
Subject: Re: [PATCH] selftests: Fix test errors related to lib.mk khdr target
To:     Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        bamv2005@gmail.com, brgl@bgdev.pl, fathi.boudra@linaro.org,
        anders.roxell@linaro.org, daniel.diaz@linaro.org,
        pintu.ping@gmail.com, drjones@redhat.com, hofsass@google.com,
        peterx@redhat.com, peng.hao2@zte.com.cn, wei@redhat.com,
        davem@davemloft.net, dcaratti@redhat.com,
        akpm@linux-foundation.org, mhocko@suse.com, khalid.aziz@oracle.com,
        mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
        dima@arista.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, stable@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20181213200011.10779-1-shuah@kernel.org>
 <623cdf7b-fc3c-2a93-c61a-a043e3d7f75b@redhat.com>
 <25593aa4-a2a7-6567-11f2-b702b6e5563c@kernel.org>
 <f4dddfa8-1493-5fd5-58a9-ea6ff2b25f9c@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b6ed53db-981e-9d9b-8838-fcd7773e7f42@kernel.org>
Date:   Thu, 13 Dec 2018 16:56:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f4dddfa8-1493-5fd5-58a9-ea6ff2b25f9c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/18 4:40 PM, Paolo Bonzini wrote:
> On 13/12/18 23:50, shuah wrote:
>>>
>>> Looks good.  Could you please provide a topic branch so that we can
>>> avoid conflicts between our trees at the next merge window.
>>>
>>
>> Thanks. The topic branch is
>>
>> git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
>>
>> I will apply it in a day or two to get ready for the merge window.
> 
> There are already other patches in that branch; a topic branch only
> includes this one on top of Linus's tree, so that it is independent from
> other changes being made in both your and my tree.
> 
> You should create a new branch in linux-kselftest.git, pull it into
> next, and tell me the name so that I can pull the same branch into kvm.git.
> 

You can find just this patch on top of 4.20-rc6 in

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git 
khdr_fix topic branch.

thanks,
-- Shuah
