Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C790AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC87208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC87208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbeHWR7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:59:12 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:13420 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:59:11 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7NEStWn004802;
        Thu, 23 Aug 2018 23:28:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Thu, 23 Aug 2018 23:28:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7NEStwa004799
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 23 Aug 2018 23:28:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] apparmor: remove unused label
To:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180823140917.3060915-1-arnd@arndb.de>
 <CAGXu5jJpuPuu+QYhzGc3MbVU7zL0kWfGMOQRf7zg++8WX4TMgw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <af63df0d-4b06-4095-4a7c-de3f4c1b9026@I-love.SAKURA.ne.jp>
Date:   Thu, 23 Aug 2018 23:28:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJpuPuu+QYhzGc3MbVU7zL0kWfGMOQRf7zg++8WX4TMgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/23 23:21, Kees Cook wrote:
> On Thu, Aug 23, 2018 at 7:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> After the corresponding 'goto' was removed, we get a warning
>> for the 'fail' label:
>>
>> security/apparmor/policy_unpack.c: In function 'unpack_dfa':
>> security/apparmor/policy_unpack.c:426:1: error: label 'fail' defined but not used [-Werror=unused-label]
>>
>> Fixes: fb5841091f28 ("apparmor: remove no-op permission check in policy_unpack")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
>> ---
>>  security/apparmor/policy_unpack.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
>> index 3647b5834ace..96d8cf68ce65 100644
>> --- a/security/apparmor/policy_unpack.c
>> +++ b/security/apparmor/policy_unpack.c
>> @@ -423,7 +423,6 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
>>
>>         return dfa;
>>
>> -fail:
>>         aa_put_dfa(dfa);
>>         return ERR_PTR(-EPROTO);

If these lines are unreachable, please remove together...
And that is what Gustavo A. R. Silva reported before this patch?

>>  }
>> --
>> 2.18.0
>>
> 
> 
> 
