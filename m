Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33C3ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F712098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F712098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeJRWSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:18:20 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60623 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbeJRWSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:18:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3101D4138F;
        Thu, 18 Oct 2018 14:17:06 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OqxPz_AVq4rY; Thu, 18 Oct 2018 14:17:06 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 432BF40189;
        Thu, 18 Oct 2018 14:16:53 +0000 (UTC)
Subject: Re: linux-next: manual merge of the kselftest tree with the kvm tree
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Shuah Khan <shuah@kernel.org>
References: <20181018155030.1d75c506@canb.auug.org.au>
 <2e7090d2-5c80-7fcf-6e50-7155280b998a@redhat.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <6b0dd0f6-ff79-97e8-9972-907cff0dcbcb@kernel.org>
Date:   Thu, 18 Oct 2018 08:16:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2e7090d2-5c80-7fcf-6e50-7155280b998a@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/2018 04:51 AM, Paolo Bonzini wrote:
> On 18/10/2018 06:50, Stephen Rothwell wrote:
>> Hi Shuah,
>>
>> Today's linux-next merge of the kselftest tree got a conflict in:
>>
>>   tools/testing/selftests/kvm/dirty_log_test.c
>>
>> between commit:
>>
>>   fff8dcd7b4a2 ("kvm: selftests: port dirty_log_test to aarch64")
>>
>> from the kvm tree and commit:
>>
>>   cda94d9ffa0e ("selftests: kvm: Fix -Wformat warnings")
>>
>> from the kselftest tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
> 
> 
> Shuah, I think it's best if in the future the
> tools/testing/selftests/kvm/ changes go through my tree, unless they
> affect many selftests subdirectories.
> 

Yes. That makes sense. Looked like an harmless patch that might not have
any dependencies. Should have checked with you.

Thanks for taking care of the problem.

thanks,
-- Shuah

