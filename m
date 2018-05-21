Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-53684-1526876280-2-12841717764060143007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526876279; b=jb0f3Nu2KwL2YDPMpQSYc3u+hUpBPiEjJIzI7y99Gl0D0ahpn2
    WvIP06WBQiDrEzY7LFZStCAUzVVnd1CqtxPVd1JWS0lj9iF1uzQ7Rjr242LNo38H
    p8ygJB3AmlSn6YyS5v3l8dBzVapjoeB1DaUv/w4hAxH7PpJq4/knD6RaFb7vbFSr
    zRO5O6PbDRlg7UT/hTTzsScK5OzDlxbYAmDNJcyHJr+w4f2T2BW+9OPNT5nfgBb1
    wRJ930A7ul/HtTH4wU+esrvj3ZEOFOlDHEmXVn7pAo/tJRJ/wqCAz2bp3o+w/vLn
    yND92TJylGbrJzosx7HLchxBHZ7uJOwKpMuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526876279;
    bh=YlyPwUqWoRKxnO6fS9SR5XlruGR1mXNACBn8wW2TVUA=; b=YfzPFEmLbQwv
    VyJz/HCE5jOY7k+D+36yqRX03YtCBO2PHbhYFt+Yxh4wws9XwwQN9xIA4qVSN2Ha
    GQeF2/KjThkJwfAAwFyQivzh55GoOyTE03xMyyXzxbUxzCWbvW8mrj/ZBRsRbKXi
    Jz7lTp6CqxGu06GFWIrjrZJmpuUNCLAoi5CqBcahhrl+5Q3vpbnXUzWjnoiqVWZW
    myUqc8HnE0SUPA8dPUek3VdOy6OqTiL/iAM4C51NbdoFgXiUuj+w+iXE4XJp8bei
    hU2HdegmdM1IPd0xgJlG04X9fTJh8nP0xcGeBnOut7I1iDkwS4el9AA1wGqzyU0n
    pHQAJfJcRQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
    header.i=@messagingengine.com header.b=SjdTBPbW x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=themaw.net
    header.i=@themaw.net header.b=RZ5+Axtf x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=fm3;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
      header.i=@messagingengine.com header.b=SjdTBPbW x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=pass (2048-bit rsa key sha256) header.d=themaw.net
      header.i=@themaw.net header.b=RZ5+Axtf x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=fm3;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=themaw.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=themaw.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGhDSQ2wMwVjjPoOLt0Yxunx9IXCcg+b2iV/VRVBzHokuUtUAEu/nnpCfHzpsM9l/OXumhPNJiOz4er8q94IcB/FE2AbC7xzbE7ckJ1WyHj+pTngvUjG
    moFY/7MUxPU5+Ux0MHfj7qjhc9VE0Ti5qqnMExuxD76GAKwAg6IT/TN4Xg95kNYGAPlYRCx/8PKleUlsgZmyNAYmmo75TNpvEmLrx1tvQ+xjWKI/dernHRpf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=JfrnYn6hAAAA:8 a=UJ4jOSzL1uLZkbJGBZYA:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbeEUER4 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 00:17:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50993 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750822AbeEUERz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 May 2018 00:17:55 -0400
X-ME-Proxy: <xmx:ckgCW7fDsU6p0ziESbt8FYPCmPFgBbAH9Zh-x8-JbIVaVkVbdZu-ZA>
X-ME-Proxy: <xmx:ckgCW13eQSnxBucVwdKD7RW2W41_vgIxFnYWGxkBJcg5Pp6WcrjPJg>
X-ME-Proxy: <xmx:ckgCW3OkAqcpx6wGNi9Ratec-5W8vyCcZFJIW_eFLNDy0oMayJXn4A>
X-ME-Proxy: <xmx:ckgCW8T9kGIh6aMdCnw9Eq8HFzNJ_V5Bb870TJLJidsaJDOpYWNCiA>
X-ME-Proxy: <xmx:ckgCW9wU_WZsqp0-WSrKv9b4VNg66TzazD-ni57okqh-nUC2WeMGQQ>
X-ME-Proxy: <xmx:ckgCW_6EJSvXf0BxYuxlCD3dosm9NnRm1I8JKCvxDpL_GGwFMjf6oQ>
X-ME-Sender: <xms:ckgCWzrtFaKpZPd4tV2t41yQhmjtNSj5AD5FC6uFBI1CBmM6rgW-rA>
Subject: Re: [PATCH] autofs - make autofs4 Kconfig depend on AUTOFS_FS
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152686465885.5980.4013776735694914550.stgit@pluto.themaw.net>
 <c0eb4d04-9d75-7fc2-0bce-f2caac9d2056@infradead.org>
From: Ian Kent <raven@themaw.net>
Message-ID: <d6096c21-1c0f-266f-8541-29f0726fe349@themaw.net>
Date: Mon, 21 May 2018 12:17:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c0eb4d04-9d75-7fc2-0bce-f2caac9d2056@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/05/18 10:08, Randy Dunlap wrote:
> On 05/20/2018 06:04 PM, Ian Kent wrote:
>> Setting AUTOFS_FS and AUTOFS4_FS to y or m results in a compile
>> failure.
>>
>> It isn't possible to unset one if the other is set because it
>> introduces a circular dependency.
>>
>> But adding "depends on AUTOFS_FS = n && AUTOFS_FS != m" will make
>> autofs4 appear under the autofs entry which should call attention
>> to it. It also results in AUTOFS4_FS being removed from .config
>> for any setting of AUTOFS_FS except n.

Arrgh!

I missed that "&& AUTOFS_FS != m" in the description.

Andrew, let me re-post this patch with this fixed and with the
added annotations for Randy below.

>>
>> Adding a "NOTE" to the AUTOFS4_FS help text will hopefully raise
>> awareness of the change to smooth the transition.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.
> 
>> ---
>>  fs/autofs4/Kconfig |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
>> index 53bc592a250d..2c2fdf989f90 100644
>> --- a/fs/autofs4/Kconfig
>> +++ b/fs/autofs4/Kconfig
>> @@ -1,6 +1,7 @@
>>  config AUTOFS4_FS
>>  	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
>>  	default n
>> +	depends on AUTOFS_FS = n
>>  	help
>>  	  The automounter is a tool to automatically mount remote file systems
>>  	  on demand. This implementation is partially kernel-based to reduce
>> @@ -30,3 +31,10 @@ config AUTOFS4_FS
>>  	  - any "alias autofs autofs4" will need to be removed.
>>  
>>  	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
>> +
>> +	  NOTE: Since the modules autofs and autofs4 use the same file system
>> +		type name of "autofs" only one can be built. The "depends"
>> +		above will result in AUTOFS4_FS not appearing in .config for
>> +		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
>> +		appear under the AUTOFS_FS entry otherwise which is intended
>> +		to draw attention to the module rename change.
>>
> 
> 
