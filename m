Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1547530-1527776407-2-3905434248890526277
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527776407; b=QWlDgAlZFhNjYkulf0yxuBsux2HAFf+4ffEwtmj+Ne/WmFhjwH
    PYDB7BBtyvr4VUkqOpJmBwFc9Iag8UGNyoxEZ93FE3dl7tYOYpWzdJIKxeVPHwDC
    zMDe/sP1+xY0BAH1o7y9AdJ/MvJqEfmCBNqatoLG+OfuQyN6EHYnA6xHK0MyzglE
    0hZ3JO0vKMVhHX3qFbATAzRA5Th66lQNWmHPx51IEVxCMV29fN9YqCEaHLcQ9AnA
    SHJYluQngtPSJS4UrynI6xFN5yiWtC4+GqRJ0uAgj0o9Ybbq0qEMimbeWrqOa9L0
    OZWg9YLm3N/os7zVLvD216OmP1eMogVRfmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527776407;
    bh=XZJlEn2QTn9/U1npRlZZBgRHnUpvdF0vrtLG1x2wCuI=; b=SCJfAoXAzuFR
    0mcYXBeCVdB3haa5mGBfpqMfIlhvs/nbQHBrSMUN2IKYekjpXYcvbtEUak8oMENe
    rGlOxdGXDN53EsW++aYLhK2hFzCJIdMhOk3zeRqHSa0eyMLQhICCmINPYrs18USS
    jndI0JUEL6x6Ysfx9Zr4MJG0aExncUwBbYvhKeepEGgTB7ZQlPvaOysxmTjUvksI
    oH4AjyX8v1XkwAw9v7vzexrP/ZqarjLn/+ahomnQv2XttPV8pU0RrrIjBv187eN+
    i0T6V2miloAXPl0Erqfs9MZQR7DHX4+E7Djug9745/m87IL/+d2rXpJ74ch5s1kA
    PWkaRyVj8Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfLK2yPb5eEMmaXhR60QwJv+pqHF+SQaD1t5llTKHSoVPB/fuPWhJJMEkMhilr0MYYEJPjcELt7Ia+sONM+yvgXIiR9w961Xi/aD5S5Az53PcP5cSGotf
    UR9JQ1LK+KOw5mbU1PBEQ6YJmb/zb//v2Miu732+Bd3zFoB6L93oJzCw3TsREiUnd4nBmxutLokEWYiGD3q/ZRncIADlxFDotXToIRXKVGFG3RrYJ2d5uDQ+
    uWQQPcqTO6jLeMzLuWVjfw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=4ojHytHMPNLOTZOFeOYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755195AbeEaOUF (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 10:20:05 -0400
Received: from uphb19pa11.eemsg.mail.mil ([214.24.26.85]:21268 "EHLO
        USFB19PA14.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755159AbeEaOUD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 10:20:03 -0400
X-IronPort-AV: E=Sophos;i="5.49,463,1520899200";
   d="scan'208";a="13987305"
IronPort-PHdr: =?us-ascii?q?9a23=3A8pgWER0XFWSInWTHsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesRK/nxwZ3uMQTl6Ol3ixeRBMOHs68C07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwVFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDs27ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jky0kDh12/DJIKfhDo/TIXjFjbjuY6?=
 =?us-ascii?q?x95FVbyAopwtBS/IlUCrYHIPPzQEP+qNvYDhohOQyu3+nnEMl91p8ZWW+XGq?=
 =?us-ascii?q?+WKr7SsVuT6+I3OeaMeYsVtC/4K/gi4P7ul2E2lUUBcqmu2JsdcGq4Eeh+I0?=
 =?us-ascii?q?WFfXrshc8MHnkSvgUkVuzqiUaCXCVLZ3moRaI85yo7CJqiDYjZWo+inqaN3C?=
 =?us-ascii?q?ChHp1ZfmpGEEyDEW/0d4WYXPcBcCCSIspmkjweT7ihSpQh2AqotADgzrpoMO?=
 =?us-ascii?q?vU9jcftZL529h///fTmg0q9TxoE8Sd1HmAQHxukWMORj85wqR/oU5mx1eGz6?=
 =?us-ascii?q?d4h/hYGsZV5/NOXQY2L4LTz+t/C9rqQALOYs+JSEq6QtWhGTw+U9YxzMETbE?=
 =?us-ascii?q?ZzHNWilA3M0jGwA7ALirOLBIY78r7G03ftIMZ9zm7M1LM9gFk+XstPKWqmi7?=
 =?us-ascii?q?Z79wjSAY7JjkqYm7+xdasCwCHN6X2DzWuSvEBYSQJwVKLFUm0CZkvSs9v0/V?=
 =?us-ascii?q?3CT7CwBrQ9KAdBytCNKrFMatL3iVVKXvDjOM7RY2ipgWe/GQ6Ixq+QbIrtY2?=
 =?us-ascii?q?gd2CTdCE4ZkwEc5HqGNhYxBj2no23ACDxjDkzvY0zy/ulksn+7TVE7zxuMb0?=
 =?us-ascii?q?J/07q54BkVheaTS/kLxLILpD8hqyloHFa6x9/WEMSPpxBufKpCet494E1I1W?=
 =?us-ascii?q?bdtw19OJysNbxthlkbcw5vpUPhyw13CplckcgttH4q1BB9Kb+c0FNEazyY3o?=
 =?us-ascii?q?v9OrnWKmn04RCuZLTa2k/Y0NmI5qcD8vU4pE7mvA2zCkUi9HBngJFp1C6E64?=
 =?us-ascii?q?nHFkIfV578SEww7Rcy86nXfiQnoY7S2XB2O66uvRfZ3NQ4QuAiz0DkN+9WLa?=
 =?us-ascii?q?fMMQj1CcBSU9CnNegCg1G0alcBO+dI+eg/OMbwM7Orwq+gdN5phjO9xTBK+I?=
 =?us-ascii?q?ln01mk7yNmS/XQ258OzrefxATRE3/ehVKsqYjSnppeZCpaSmi6zjL+BZV5YK?=
 =?us-ascii?q?R3cIdNDn2hdYn/6tx4hpPpE1xF7lGuAUhOjMOgfxufa17V2ABU0U0Rpmzhki?=
 =?us-ascii?q?y9mXg8vzY0oeK70SDAxP7uPE4LPmNHSm54gX/2LIS0hsxcV0+tOUxhjxah5E?=
 =?us-ascii?q?Dn14BHta9/KC/VWk4OcC/oaylmU62tpv+ZbsVS8pI0oGBSV+ihZV2yVLHwuV?=
 =?us-ascii?q?0Z3jnlEm8Ywyo0M3muu5Pkj1l5hXibIXJbsnXUY4dzyA3Z6diaQuRemnJMfy?=
 =?us-ascii?q?RihjSfKxD6d/mg+dGFkd2L5vuzTW2sfp1adS36y8WLsy7toSUgORSim7ie0p?=
 =?us-ascii?q?uvNAMZ3Cn92sggHXHQpQv4Z4Lo/6C7N/93OFduCUO66sB/XIp5l91jqosX3C?=
 =?us-ascii?q?0hmpiN/XcB2Vz2ONFf1LO2OGEBXhYX0tXV507jw0QlIXWXkdGqHk6By9dsMo?=
 =?us-ascii?q?HpKlgd3TgwuoUTUv+Z?=
X-IPAS-Result: =?us-ascii?q?A2AJAwBCAxBb/wHyM5BcGgEBAQEBAgEBAQEIAQEBAYMZK?=
 =?us-ascii?q?2J/hB+UZkUBAQEBAQEGfymBD5NQgWQ2AYRAAoIEITgUAQIBAQEBAQECAWsog?=
 =?us-ascii?q?jUkAYJOAQEBAQIBIw8BSwsLGAICJgICVwYBDAgBAYJeQAKBcgUIpxqCHIN4A?=
 =?us-ascii?q?QFeg2uBaIEKhzWBDIEHgQ8kgmmEN4M8glQCmGgJjloGgTyGV4R/K4cuixQhg?=
 =?us-ascii?q?VIrCAIYCCEPgn+CHxeNYQFRI4EqAQGMRiqCHQEB?=
Subject: Re: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable
 holds
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
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b4101249-af8e-579c-63f7-d0bc514c31dc@tycho.nsa.gov>
Date: Thu, 31 May 2018 10:21:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <71925d61-743e-76a1-b0dd-1948468e2773@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/31/2018 10:12 AM, peter enderborg wrote:
> On 05/31/2018 02:42 PM, Stephen Smalley wrote:
>> On 05/31/2018 05:04 AM, peter enderborg wrote:
>>> On 05/30/2018 10:34 PM, Stephen Smalley wrote:
>>>> On 05/30/2018 10:10 AM, Peter Enderborg wrote:
>>>>> The boolean change becomes a lot more heavy with this patch,
>>>>> but it is a very rare usage in compare with read only operations.
>>>>> The lock held during a policydb_copy is about 1ms on a XEON.
>>>> This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
>>>> That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
>>>> In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?
>>> That one did not make it, so I went for a other path. Make it simple, using the same serialisation that exist. That also make it easier to maintain.
>>> We do not  use the booleans in android since they are not allowed so im not aware of any use case where this administrative function are
>>> used in such frequent manner that it would have an impact. And it must be some other large overhead with interprocess communication and
>>> a multiple writes to sysfs during a boolean settings?  However my concern is/was memory pressure, setting booleans will generate pressure
>>> with lot of atomic allocation and large vmallocs.
>> Yes, that is also a concern.  I would prefer to only duplicate the conditional policydb state as in KaiGai's patch.
>> Keeping temporary setting of booleans lightweight is desirable for other use cases than Android.
>>
>> I'm also concerned by the implications of switching all of the allocations to atomic.  KaiGai's patch did not take that approach either, and it obviously could make policy reload more prone to transient failures.
> 
> On the version 2 of the patchset you pointed out that I did a shallow copy, so I did a "deap" copy. As I see it the KaiGai cond_policydb_dup also do a shallow copy.

In your earlier patch set, you just did a memcpy of the policydb and then proceeded to mutate parts of the conditional policydb state, which would have modified the original too.  KaiGai was performing a deep copy of the conditional portions of the policydb I believe.

> You dont happend to know exactly why KaiGai's patch never was accepted?

As I recall, there wasn't anything wrong with the code itself; he just wasn't satisfied that it ended up being a worthwhile tradeoff based on his own performance testing.

> 
>>  But my goal is the fast path for real time critical functions such as audio, and it will be a cost for
>>> administrative tasks. On the xeon it takes about ~98 ms to run the security_set_bools compared to about ~8 ms without the overhead
>>> of copying the policydb.  About ~6 ms is rcu sync and ~8 ms is the same as the original update of selinux statuses, and about ~25 ms
>>> is policydb_destroy() of the old copy.
>>
>>
>>
