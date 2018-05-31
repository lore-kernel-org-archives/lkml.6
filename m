Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733878-1527784757-2-10556420155874377879
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527784757; b=gepAapRJ7A7ZsHUXCbMyXZ49z4oRPKzKj4ATb6TpatchLKQEVI
    ntU+YP105kzHL65BSVLceUMXf2EMRiqqVdVd1D00rKO/zJ2NTOGKbW3R9fHzpYZU
    Nw/0cWKu1Xln0eMaEWmbsCiPSVQdzp2byZJJSWLS+QYBa39D8h6DYqkBBEzfPZ18
    NfMdp4/HFxgPaUyAzbCLO+Gf2C6FQHGsAiVsZKenyBeMQ0VqDhPEDWWmLM5IODh9
    /ixQyYZc9dcMwoqc47OiVC4hTQTbcvPJYEMsvLUkR4SiXiN3Nthk0Cv9FgpXebbi
    m8Q8byugygl9Zbl+dkCK7zRiTkO44+atLlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527784757;
    bh=MAZCGdsP5rnIQEvxB7xHIdOKCu7kxQL/L7goQZ3lv4U=; b=X0BbGzVhshwc
    Id9wkwcTB/hgaa0u6/i3sCqRRBfLWyHWVulfzybU0AcTJW00tl/3aveR1GIadqJF
    b9gY9ihjMiUi22bRnHFEf+l1uA/963LE6CFtHnNl5uMv7r8LXbF46j7y27qLwYMI
    4IWqw7evzwgAcxrTzZZ2Du7R+I3p99vV2L+5oGjzEHM+breC4GX3Xf6Ei8f1aAjO
    WtGcyfSH+/TxtMGj+ZfFeFKVQeH1p26+QSMz5moecjpWk0inKOEcte/MTUVqtvc0
    /ZRrb3Jl/ZyrhzQUr5NGXVpK5i+b9uXKa8Drj6b95vDunsxXsppBL9TLEzvb5w5c
    G6QwfsjVXw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfMhYbU0eApY+FII2UwwPJMRMY2JrjEG44Q66xSC57bX1azNcd8rOnjg4T39+UbAecQ8XvYkbd8Y7SMFlBVYVnhUU2Ju4fKhQ+iduMxseewwlRt5Pi2k/
    MNHTMGr38WAk8nGAT/vCL6yQ7eud74AObHvqFdbOFb94n3hQoHGjKouSVolejnQkfVFH077PvSFFBr9tkiqrW1G4YBHByruEreldJ5y54rjFNfEo9lOgZtuN
    zd/fdq/ftqLVzSOY17ACMw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=4ojHytHMPNLOTZOFeOYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755691AbeEaQjO (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 12:39:14 -0400
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:56534 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755618AbeEaQjN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 12:39:13 -0400
X-IronPort-AV: E=Sophos;i="5.49,463,1520899200";
   d="scan'208";a="571966306"
X-IronPort-AV: E=Sophos;i="5.49,463,1520899200";
   d="scan'208";a="12351470"
IronPort-PHdr: =?us-ascii?q?9a23=3AZZ+MMBfI4ztkqZ2G0ympQDa8lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc29ZRGN2/xhgRfzUJnB7Loc0qyK6/2mATRIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfbN/IA+qoQnNq8IbnZZsJqEtxx?=
 =?us-ascii?q?XTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ7NYCi8mM3?=
 =?us-ascii?q?0u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xy?=
 =?us-ascii?q?mp4rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNwUX2?=
 =?us-ascii?q?pBWttaWTJHDI2ycoADC/MNMfhEo4X4oVYFsBmwChS2BO731zFGhmH43aM53e?=
 =?us-ascii?q?ovHw7J0w4vEM4BvnnPsNX4N70fXfypwKTGzzjOae5d1zfn6IjPdxAsueyCXa?=
 =?us-ascii?q?5ufsrJyUkgCQXFhUiNp4zgJTyV0uANvHab7uF9Uu+vkHMoqxpqrzizxsYjlo?=
 =?us-ascii?q?nJhoUPxlDC7iV22pw5JdK/SE5leNOpFoZbuSKCN4ZuX88vTG5ltDw6x7Ebo5?=
 =?us-ascii?q?K3YicHxIo9yxLCbfGMbpKG7Qj5VOmLJDd1nHdleLWiiBms6UWg0ej8VtWs0F?=
 =?us-ascii?q?ZNsypFjsHAtnAT2BzX7ciKUud98V272TaOygDT8ftIIVw0lKXHK54hxaQ8lp?=
 =?us-ascii?q?wPvkTYAiD6gkD2jK6Sdkk8++io7froYqn+q5OBOIJ5hRvyP6QzlsClH+g1PR?=
 =?us-ascii?q?YCU3KG9eik0b3s50z5QLFEjv0slanZtYjXJd8Gqa6iGAJVzoYi5Aq/Dzehyt?=
 =?us-ascii?q?gYm2IHI0hfdBKIiIjpJUnCIOrkAvenn1SsjDBryujePrL/HpXCMGLDnK3/cr?=
 =?us-ascii?q?Z79kFT1hAzwstY55JOBbEMO+nzWkj3tN3YFBM2Lwu0w+P/AtVnyoweQX6PAr?=
 =?us-ascii?q?OeMK7KqV+H/P8vI+2XaY8Nojn9Nvwl6+frjX8+nl8dZ7em0YELZ3C/G/RsO1?=
 =?us-ascii?q?+Zbmb0gtcdDWcKuRIzQ/LyiFKYSz5TZm2yUrkk5j4hEoKmDJzDRpipgLObwC?=
 =?us-ascii?q?i0AIdaZmdcClCDCX3obZmLW+8QaCKOJc9sij4EVb2mS487zxGutRT6xqFhLu?=
 =?us-ascii?q?XO/y0Xq5Pj2MJy5+3JmhE47SZ0ANiF02GRU2F0mXsFSCIs06B5oExy1FOD0a?=
 =?us-ascii?q?pjjvxdC9NT4/dJXR08NZ7bwO12Ecz9WgXEft2RUlapXs2mAS0tTtI229IBfk?=
 =?us-ascii?q?J9FMu/gRDN2CqqGaIamqeRBJMq763c32L+J9pnx3na06khikEsQtFTOm2+mq?=
 =?us-ascii?q?5/6w/TCpbNk0WYkaaqaKsd0DfW9Gid0WWOoVtYUA9sUaTFRHwfY0zWosnk5k?=
 =?us-ascii?q?PGUbCjEqonMgRfxs6YMKdKacPmjU9ARPj9PNTSeWWxm32/BRyQ3LODcJLqe3?=
 =?us-ascii?q?kB3CXaEEUElwET/XCbNQkxHyuhoHzRDCZoFV3xZ0Ph6vd+qHylQU8u1Q2KbF?=
 =?us-ascii?q?Nu16Cz+hELgfyQUfQT3qgLuC05sTV7AE69387KC9qHvwdhZ7tTYcky4FhZzm?=
 =?us-ascii?q?/ZtxZyPpikL6FigF4SaRh4v0Tr1x9vEIVPjdAqrG82zAp1Ma+YyElOdy6c3Z?=
 =?us-ascii?q?D1JrLXKXL//BSua67Qx1Hf38ya+rkJ6Psmt1XvpgCpGVEn83l9z9ZV1H6ctd?=
 =?us-ascii?q?32C18KXI78SA468RR3vbvdeCZ1s5vZyXB2d6SyvjLY0dUzC8M+zRCxOdxYNf?=
 =?us-ascii?q?XAXDf7DslSIs+pMuFiz0CgcxYsJOlP8OsxOMS8er2N36v9eK5NhjOtxVxO+o?=
 =?us-ascii?q?FmmhaB7yNmS/Xgx58fwuqA2gKMWnH7llj39ojVkIVJfnk3GXClyDOsUIxUYb?=
 =?us-ascii?q?dofJ0jD26rLszxwc9x0dqld3de9VOnT3EbwsCkfwHaO1D02wxd0UY/pHGjnS?=
 =?us-ascii?q?K+yCwymDYs+O7X8CvTzKzGeRYJPXRHDD1uiVrgL4+ug/gAUUSoZhRvnxygsw?=
 =?us-ascii?q?Ky3KVfpaJiP0HPUExIeG7wNGgkXayu8vKGYshS+NYzvC5KSuWgcBWfTbLgpx?=
 =?us-ascii?q?YyzSzuBS1dySo9ejXsvY/221R+iWSAPDNwoWDfdMVY2xjS/prfSORX0z5AQz?=
 =?us-ascii?q?N3zXGdPVWmMNTh0J3S37fKtuSvUSjpAoZeaybm5YOJsC+q4ythBhjp27j5ot?=
 =?us-ascii?q?T6FUAXmWmz8tJJWCPOoQe2Kt3z3rm+NOlkVk1pAkLsrdR8F504k4E1wpoX3C?=
 =?us-ascii?q?5JqI+S+C88jWrrMdhdkZn7ZX4JSC9Dl8XZ+yD5yUZjKTSP3Iu/WXKDlJgyL+?=
 =?us-ascii?q?Kma38bj3pup/tBD72Zufkdx3N4?=
X-IPAS-Result: =?us-ascii?q?A2ALAwCLJBBb/wHyM5BcGgEBAQEBAgEBAQEIAQEBAYMZK?=
 =?us-ascii?q?2J/hB+UaEYBAQEBAQZ/KYEPk1CBZDYBhEACggQhOBQBAgEBAQEBAQIBayiCN?=
 =?us-ascii?q?SQBgk8BBSMPAVYLGAICJgICVwYBDAgBAYJeQAKBcg2neoIcg3gBAYRIgWiBC?=
 =?us-ascii?q?oc3gQyBB4EPJIJphDeDPIJUAphpCY5bBoE8hliEfyuHLosUIYFSKwgCGAghD?=
 =?us-ascii?q?4J/gh8XjWEBUSOBKgEBjB4qgh0BAQ?=
Subject: Re: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable
 holds
From: Stephen Smalley <sds@tycho.nsa.gov>
To: peter enderborg <peter.enderborg@sony.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
 <8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
 <1cf240b9-57ee-eee3-228f-5ad4a3a39e57@sony.com>
 <9332801c-6102-2486-ab60-b48bb38ae207@tycho.nsa.gov>
 <71925d61-743e-76a1-b0dd-1948468e2773@sony.com>
 <b4101249-af8e-579c-63f7-d0bc514c31dc@tycho.nsa.gov>
Message-ID: <e0d14aba-c63a-327e-afeb-a56a51fb0ade@tycho.nsa.gov>
Date: Thu, 31 May 2018 12:40:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b4101249-af8e-579c-63f7-d0bc514c31dc@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/31/2018 10:21 AM, Stephen Smalley wrote:
> On 05/31/2018 10:12 AM, peter enderborg wrote:
>> On 05/31/2018 02:42 PM, Stephen Smalley wrote:
>>> On 05/31/2018 05:04 AM, peter enderborg wrote:
>>>> On 05/30/2018 10:34 PM, Stephen Smalley wrote:
>>>>> On 05/30/2018 10:10 AM, Peter Enderborg wrote:
>>>>>> The boolean change becomes a lot more heavy with this patch,
>>>>>> but it is a very rare usage in compare with read only operations.
>>>>>> The lock held during a policydb_copy is about 1ms on a XEON.
>>>>> This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
>>>>> That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
>>>>> In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?
>>>> That one did not make it, so I went for a other path. Make it simple, using the same serialisation that exist. That also make it easier to maintain.
>>>> We do not  use the booleans in android since they are not allowed so im not aware of any use case where this administrative function are
>>>> used in such frequent manner that it would have an impact. And it must be some other large overhead with interprocess communication and
>>>> a multiple writes to sysfs during a boolean settings?  However my concern is/was memory pressure, setting booleans will generate pressure
>>>> with lot of atomic allocation and large vmallocs.
>>> Yes, that is also a concern.  I would prefer to only duplicate the conditional policydb state as in KaiGai's patch.
>>> Keeping temporary setting of booleans lightweight is desirable for other use cases than Android.
>>>
>>> I'm also concerned by the implications of switching all of the allocations to atomic.  KaiGai's patch did not take that approach either, and it obviously could make policy reload more prone to transient failures.
>>
>> On the version 2 of the patchset you pointed out that I did a shallow copy, so I did a "deap" copy. As I see it the KaiGai cond_policydb_dup also do a shallow copy.
> 
> In your earlier patch set, you just did a memcpy of the policydb and then proceeded to mutate parts of the conditional policydb state, which would have modified the original too.  KaiGai was performing a deep copy of the conditional portions of the policydb I believe.
> 
>> You dont happend to know exactly why KaiGai's patch never was accepted?
> 
> As I recall, there wasn't anything wrong with the code itself; he just wasn't satisfied that it ended up being a worthwhile tradeoff based on his own performance testing.

His use case however was different - he was concerned with networking performance, and the introduction of the netnode/netport caches largely eliminated the policy rwlock as a concern there.

> 
>>
>>>  But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
>>>> administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
>>>> of copying the policydb.  About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
>>>> is policydb_destroy() of the old copy.
>>>
>>>
>>>

