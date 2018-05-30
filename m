Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4069958-1527693737-2-11593952537168304244
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527693737; b=jrxvD53H2E54ZDMpS31G27XxOl0I54WdoTzGi6Pwd/Xex5mqCt
    TQx/LG5STXIekDWSMYuN7WEvVWxHyZwrSIg/vAXbBjBwW34V67TkZ3WPTKhh/kt4
    kuIKFFM2h4Yt0JJ/SzAU/e69QHSP9S5QETNVbXcVUnQXjhv4FKbPGslruRPlWqcr
    VGzYLzHbevTp7npaBJBnvM6JB6oZePrFEqNJLx5umfFCVnJDee26r/soUneMtXXC
    Jb7KYHawnYj27fZF/nEK6nFFEOSJ86o6dhwghK0QWkdkiRq9vKp31+aT72HyDZMg
    XW0/++AL6oAvKyiRrc71FHrLr3iCQyZJ4HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527693737;
    bh=lFlpBM8lfPmCtgROD1WhL/RAEN092bQoFh436qYM6Yg=; b=coTYOG31QknJ
    OnTgnu+jS+/5H5JcD+Jy/VH08eT8ElGDYgN/oViNf2gepLYNDTmE5lLphXFKcmT3
    zxquy7IHqFctRipCRnAR9XQpvujiXt+pW0GlPRDnEV+Y3hsYljzc7CLSGcvj5KKi
    wMWtZK/7egRtyUfD+j5kD4IIK+NuRYsrsu5miUmm7DihxkRfVemIFesCy8NZN1wj
    PjLg/b++JNfppzT2zSDYAtJTfqqzfmUWCclNMCSq8rquLrQ1y2ms5RUSLljakMJW
    sk0PLP7MdqjnvD5GuPlDGyT6SZgHOrmOKiXRYhmMgNkzCfqqIoPZxr3JEcpkzbfx
    Ju77mk1Hjg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=tycho.nsa.gov header.result=pass
    header_org.domain=nsa.gov header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-110 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.nsa.gov;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=tycho.nsa.gov header.result=pass
      header_org.domain=nsa.gov header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-110 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGdLsc5f0tBtIE4tbC6Qxhy7xEAkqwpAbgJ1UmzN0HBAfB0RsMKgsNQ625FCptUMXSeAxCFwJS9WCOw3HIGZkrPy6EQlkA95c+XuaONSCYuhoJwerJJ2
    D1R8N3/aTCMe64C092BsRPlSeO4UIEZpbeudKtcYvDoNbGTl//dIeToQfRJJzb6VnGeq5Up+jqTrshlRIE6ZxRUKPENrBrePAe+GbmI0SWm9B+3ztDXnogvM
    m50ct1NJy05xy+/Xl8SqmQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=q838TCl1jJi5F8SuH4QA:9
    a=29PkY2qMqBEO0txU:21 a=lJO9VxcGxWW9W0im:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeE3PWO (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 11:22:14 -0400
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:18119 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753276AbeE3PWL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 11:22:11 -0400
X-IronPort-AV: E=Sophos;i="5.49,460,1520899200";
   d="scan'208";a="12294245"
IronPort-PHdr: =?us-ascii?q?9a23=3AxbvepR1xa7MilRpAsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWLvvxwZ3uMQTl6Ol3ixeRBMOHs68C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwVFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jky0kDhx2vDGOqbsAo3XIXjelLftZL?=
 =?us-ascii?q?N960lbyAop099T/Y5bCrYEIPjrQE/+qMTYDgMlMwyz2+vnE9p91pkZWWKRHK?=
 =?us-ascii?q?CZKrjfvkOP5u0yPeaDfpIVuCz6K/g//fHil3g5mUUSfaOxx5sYdGi4Huh6I0?=
 =?us-ascii?q?WeeXfshtYBEWEXvgsxVeDqk0ONXiJOZ3aoXqI8+jE6BJujDYfEW4+tnbiB0z?=
 =?us-ascii?q?mgE51IaWBJFEqMHW3rd4qaQfcMbjydIst7njwDT7ihRJcr1Quyuw/i17pnMu?=
 =?us-ascii?q?3U9zUctZLi0th1+uLSmQgx9TNqFcSd1X+CT2Vvk2MWSD85wrp/rVZ+ylidy6?=
 =?us-ascii?q?h4heJXFdhJ6/NOSAc6Os2U8+svM9nvXkrkedCTRR7yWty7BRkpR881htoJZF?=
 =?us-ascii?q?xwXd6li0aHlxGjCL8UkfSkHpsq/7iUi2P+PcFjxmzu364tglA7WMxVPCuhnK?=
 =?us-ascii?q?EppCbJAIucqFmUj6anc+wn2SfJ8GqShT6VsFpwTB97UaKDW2sWIETRs4KqtQ?=
 =?us-ascii?q?v5U7ayBOF/YUN6wsmYJ/4PM4exgA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AMAgCFwA5b/wHyM5BcGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?YMZK4FhKIN3lGRIAwZ/CCGBD48bhhk2AYRAAoIdITgUAQIBAQEBAQECAWsog?=
 =?us-ascii?q?jUkAYJOAQEBAQIBI1YQCxgCAiYCAlcGAQwGAgEBgl5AgXQFCKV3ghyEWINsg?=
 =?us-ascii?q?WiBCoctgQyBB4EPJAyCXYQ8gzeCVAKYZQmOWgaNDCuSQCGBUisIAhgIIQ+Cf?=
 =?us-ascii?q?pBqIzB6AQGMU4JHAQE?=
Subject: Re: [PATCH] selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
To: Paul Moore <paul@paul-moore.com>,
        Sachin Grover <sgrover@codeaurora.org>
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
References: <1527237099-9728-1-git-send-email-sgrover@codeaurora.org>
 <CAHC9VhQui+U1wzms2=XSW7MeRZg-faAzZyG8XU8wc+bWAoVzJg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0aac0a96-8565-1d9e-c53a-38bd5c861fd4@tycho.nsa.gov>
Date: Wed, 30 May 2018 11:23:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQui+U1wzms2=XSW7MeRZg-faAzZyG8XU8wc+bWAoVzJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/30/2018 11:19 AM, Paul Moore wrote:
> On Fri, May 25, 2018 at 4:31 AM, Sachin Grover <sgrover@codeaurora.org> wrote:
>> Call trace:
>>  [<ffffff9203a8d7a8>] dump_backtrace+0x0/0x428
>>  [<ffffff9203a8dbf8>] show_stack+0x28/0x38
>>  [<ffffff920409bfb8>] dump_stack+0xd4/0x124
>>  [<ffffff9203d187e8>] print_address_description+0x68/0x258
>>  [<ffffff9203d18c00>] kasan_report.part.2+0x228/0x2f0
>>  [<ffffff9203d1927c>] kasan_report+0x5c/0x70
>>  [<ffffff9203d1776c>] check_memory_region+0x12c/0x1c0
>>  [<ffffff9203d17cdc>] memcpy+0x34/0x68
>>  [<ffffff9203d75348>] xattr_getsecurity+0xe0/0x160
>>  [<ffffff9203d75490>] vfs_getxattr+0xc8/0x120
>>  [<ffffff9203d75d68>] getxattr+0x100/0x2c8
>>  [<ffffff9203d76fb4>] SyS_fgetxattr+0x64/0xa0
>>  [<ffffff9203a83f70>] el0_svc_naked+0x24/0x28
>>
>> If user get root access and calls security.selinux setxattr() with an
>> embedded NUL on a file and then if some process performs a getxattr()
>> on that file with a length greater than the actual length of the string,
>> it would result in a panic.
>>
>> To fix this, add the actual length of the string to the security context
>> instead of the length passed by the userspace process.
>>
>> Signed-off-by: Sachin Grover <sgrover@codeaurora.org>
>> ---
>>  security/selinux/ss/services.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks for reporting this and providing a patch.  It's small enough,
> and passes all the regular tests, so I've merged it into
> selinux/stable-4.17 (adding the stable metadata) and I'm going to send
> it up to Linus today.
> 
> If Linus doesn't pull the fix in time for v4.17 I'll send it up during
> the upcoming merge window.

NB Such a setxattr() call can only be performed by a process with CAP_MAC_ADMIN that is also allowed mac_admin permission in SELinux policy. Consequently, this is never possible on Android (no process is allowed mac_admin permission, always enforcing) and is only possible in Fedora/RHEL for a few domains (if enforcing).

Fixes: 9a59daa03df72526d234b91dd3e32ded5aebd3ef ("SELinux: fix sleeping allocation in security_context_to_sid")

> 
>> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>> index 66ea81c..d17f5b4 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -1434,7 +1434,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>>                                       scontext_len, &context, def_sid);
>>         if (rc == -EINVAL && force) {
>>                 context.str = str;
>> -               context.len = scontext_len;
>> +               context.len = strlen(str) + 1;
>>                 str = NULL;
>>         } else if (rc)
>>                 goto out_unlock;
>> --
>> 1.9.1
> 

