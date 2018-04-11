Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479001-2-5925575283231453736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479000; b=laUQG7JMAGzd3+i/HCd9JVU2+VWzp3oE7ng3uHtjMKPFp1hoo2
    BG+mtMH8BVwteZFmevk3lmwOV7WBUgXBylwtyXg99HTN38vuOEbzP4870FguU6qS
    Dv4f8ugxwuwRYtVLcYhIqxDbW3yEvOo+0T2DtJSgkB7hDvWml9KX8C0US+0yk27z
    qgcuVKKMZAw7j5ZPm9vUOAhxqE3rFtBK/pCmfSAdTU79JCM1QN1cwQk7pjNEY7xg
    iQIFKH2bIk4kYUawoknxje6GWnHYQFjIiEgjqnQ9/qS/wDeyT1GkOTEoRRAv58FP
    94gtLtFpSrQcNm089NymG1t/7QBEzOMOyUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523479000;
    bh=/P7Znuy6bq1rWcHBGpSn/b7rTSAIBmHsQbjYC8ewDbc=; b=iPvRM9U1LzGA
    qOBifozpbj3XP7T0Uz+KvJLUDHemzXs6t/Q/zgQE7DsImb4jq9GUMmOcFR8dQ+8X
    Yo+z/6j6SSyDR2DSZ6EKGRQYzB8jwa117S3fAYFW1Pn2IHkuJnPyFgzcNxztgwGZ
    DEbvab3xzW0vlt7X7D5RlBKlQZp2VxFhPBdRCKIQCVKCT0wZzDEthvqTTC8VyrkC
    s+1CZOjt4wfN9HzhdDvys4QVKGSaaK7roXAAPvqFowzviixwmd7gNyijgQMM/qVK
    CjHOUH0M39ei2Cd5b+HUOYtTQ7lBGhKGae3pdEjgVsRgj8yvtyOJRoxCrRiiW/ue
    rTwVOoHGJQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK8m/PbUkY9Pz5lGoSY8VqkZOnEnKeLqxROQOr+y2btxjzKZoyiyg61lvRxebpJPIbcNyBUvhN3UBmpebvlT6IlVmI4F1wvfPvQ6OpjvIxSCcFoGdm82
    7mD+XD6SnhiFg6z6ScW0Jl90WpAesXoSUhzVqhI1xIRwl85/nlByAme9tlZCqReCkfMNtT5BVJOxt4OJCYJ4MkZb2JYHFHBrN7qPEhNbiErJowt2o7eFJ7EC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=rbY5Hf1s5mkA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Ikd4Dj_1AAAA:8
    a=Sg8HuZxHAAAA:8 a=wWdAtWtXpUVzLs5jrZEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=JFlNBosjgyz61O-hmi61:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754910AbeDKUgY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:36:24 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7662 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755724AbeDKUgX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 16:36:23 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 11 Apr 2018 13:36:22 -0700
Subject: Re: [PATCH] mmap.2: document new MAP_FIXED_NOREPLACE flag
To: Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>
CC: Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20180411120452.1736-1-mhocko@kernel.org>
 <CAG48ez3BS5EtnrhFQUGYY9MKGOUHzFbhauJQd361uTwy2pBEeg@mail.gmail.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <827ead33-5d93-7696-9c5e-1cd04f772476@nvidia.com>
Date: Wed, 11 Apr 2018 13:36:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3BS5EtnrhFQUGYY9MKGOUHzFbhauJQd361uTwy2pBEeg@mail.gmail.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 08:37 AM, Jann Horn wrote:
> On Wed, Apr 11, 2018 at 2:04 PM,  <mhocko@kernel.org> wrote:
>> From: Michal Hocko <mhocko@suse.com>
>>
>> 4.17+ kernels offer a new MAP_FIXED_NOREPLACE flag which allows the caller to
>> atomicaly probe for a given address range.
>>
>> [wording heavily updated by John Hubbard <jhubbard@nvidia.com>]
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>> ---
>> Hi,
>> Andrew's sent the MAP_FIXED_NOREPLACE to Linus for the upcoming merge
>> window. So here we go with the man page update.
>>
>>  man2/mmap.2 | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/man2/mmap.2 b/man2/mmap.2
>> index ea64eb8f0dcc..f702f3e4eba2 100644
>> --- a/man2/mmap.2
>> +++ b/man2/mmap.2
>> @@ -261,6 +261,27 @@ Examples include
>>  and the PAM libraries
>>  .UR http://www.linux-pam.org
>>  .UE .
>> +Newer kernels
>> +(Linux 4.17 and later) have a
>> +.B MAP_FIXED_NOREPLACE
>> +option that avoids the corruption problem; if available, MAP_FIXED_NOREPLACE
>> +should be preferred over MAP_FIXED.
> 
> This still looks wrong to me. There are legitimate uses for MAP_FIXED,
> and for most users of MAP_FIXED that I'm aware of, MAP_FIXED_NOREPLACE
> wouldn't work while MAP_FIXED works perfectly well.
> 
> MAP_FIXED is for when you have already reserved the targeted memory
> area using another VMA; MAP_FIXED_NOREPLACE is for when you haven't.

That's a nice summary, I hope it shows up in your upcoming patch. I recall
that we went back and forth, trying to find a balance of explaining
this feature, without providing overly-elaborate examples (which I tend
toward).

> Please don't make it sound as if MAP_FIXED is always wrong.
> 

Agreed.

thanks,
-- 
John Hubbard
NVIDIA
