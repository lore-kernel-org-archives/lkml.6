Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-253802-1527712412-2-8360640410747625570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527712412; b=N34afRcl74ue5zLhNl8I1ucW8JnuWNdoFoWL9afyULQUzt0tiq
    v00iitludE8POiOcgrlR9Yp207KU1zTi0x/deuLSQohJEF+39Vsae3n54VPYrLSr
    m1Ast4YRBa4M0RNDbf6Yz/ZcMb9fBu8eHVwvzyRnXLjPQWlEyHugG+5snATQ3Uwy
    oKZajDFCjwz1VcrW9UleAmyu/XT0uJBPgSd++kwAL1SVSn5m4IywqWnq2Igr9UEu
    gI0dtl3XHc48dj36Rjw4I06bHRw7I1xN31iOZ5c2UZDJ9Vtg5Oyh56SuasRgNmxc
    bCVXwDC8zryJEa8XRDAetTFcIfXDA+8N95PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527712412;
    bh=1t/Em4Q7E8tBTU3GMFUW/DdkQztP2J46e6TpuMR8Dng=; b=Y9lnXWItjwwJ
    GV67AgX4fCBX5gzuvWT6W/Huln0ixf4r9C2AzhHovphp9/T1Nawkh4yTgiDlPz43
    6yb0Br2NBOiNmYtNhA28iRq0xxgL6dRie3eTVJDVyWF9epoViWODhFwafmRTgq2B
    2/bOu/7V58hlq6ga1UsD0c883cwcfWRYKy/hME4t1HxT1/68GMINZEtdurfXD6ne
    rnOELUWqO5B6KMG2TPsKOAUqNrOgWVPBqsQV4D0UxJGnJfLCuPvzaRJr1urNgW3G
    4QvhLCM22S5Ua1NklNSSb1YXLdU1wO22LaLGQVt7nr6DraMhit5/aRnnlxSC/KwE
    3rOys3Bq2Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfEsM9V6RoGPKSvom7ggwPDMV+SJtIMugO7WcwaX6un33VoQfHeBFfnMU6yV0iB3HP4NlbGX5Oqx1Bp8YXpSq8O82M92RokF5CECeBxLClh1MnRDzVMrM
    emtNgQVF6FrN2oAdJYWVhnhIKpET2oLQ0Q5pPrjRH3ULWc1wY06sZh+w72zl3DUpiVQITi+M7gU39hLlJ1zuZ2ybBlGKQmb3tkFgFO4wyI5secVs5ey8bEeM
    VrH6JpoYwA57JO5AjTUJrw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QQoPp5U2Mh6wbbvzcL4A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeE3Uda (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 16:33:30 -0400
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:13112 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932191AbeE3Ud3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 16:33:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,461,1520899200";
   d="scan'208";a="13956088"
IronPort-PHdr: =?us-ascii?q?9a23=3A+LX1/RF6jn9Sv4P0vFSHF51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76oM+zbnLW6fgltlLVR4KTs6sC17KL9fi4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCa9bL9oMBm6sRjau9ULj4dlNqs/0A?=
 =?us-ascii?q?bCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3TbpDDDQ7KG?=
 =?us-ascii?q?81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUj?=
 =?us-ascii?q?m58axlVAHnhzsGNz4h8WHYlMpwjL5AoBm8oxBz2pPYbJ2JOPZ7eK7Sc8kaRW?=
 =?us-ascii?q?5cVchPUSJPDJ63Y48WA+YfIepUqo/wrEYMoxSjHwmhHP7hxCFGhnH23qM03e?=
 =?us-ascii?q?ouHg7E0wM8ENwDq2jUodfvOasOTey4wqvFwDPeZP1Wwzf9743Ifwg8r/GQQ7?=
 =?us-ascii?q?1wacrRxlcpFwjYk1uQrJbqPzeR1usTs2mQ8u1tVfmyhG48sAxxvjiuydssio?=
 =?us-ascii?q?nOnI4VzEvE+j9jzIY6It24Vld2bNi5G5VTryGXL5Z6T8wtTm1yuCs216cKtY?=
 =?us-ascii?q?C0cSQU0pgr2hjSYOGdfYeS+BLsTuORLC99hHJiZb2wmQ6/8VOlyu3gTsm010?=
 =?us-ascii?q?tKrjZdntnMqH8N0xvT59CbSvRn5Eeh2CuP1xvJ5uFYIUE7iarbK5k7zr42ip?=
 =?us-ascii?q?UTqljMEjXzmEX3iK+abkQk+u625OT7erjqu5CROoBuhgz+L6gigNKzDOsmPg?=
 =?us-ascii?q?QUQmSX4eG826fi/U39TrVKlPo2kqzBvZDBOMsbvbW0AxNV04k/6xa/CC2q0N?=
 =?us-ascii?q?IDnXYdNl5FdxWHj5bxN1HUPP/4Feu/g0irkDpz3/DJIKHhDYvXLnTZjrjhe6?=
 =?us-ascii?q?ty5FBGyAUoytBf/Z1UB6oaIPL0XE/wtMbUAQM+Mwyx2+znEsly1psCWWKTBa?=
 =?us-ascii?q?+UKLvSvkWV5uIrOOSMfJUauCv5K/Q84v7uing5mUUDcqWzwZQXb3W4FOx8I0?=
 =?us-ascii?q?qFeXrsnssBEWASswUgVOzlkkeCUT9IZ3upR6Iz/Cs7CIO9DYfbQoCimqCO0z?=
 =?us-ascii?q?mhEp1RfGBGBUiGEW30eIWcR/cMdCWSL9djkjMeULiuVZQh2QuqtAPgzrpnKf?=
 =?us-ascii?q?DU+jcZtZL4z9V14PfTmgsu+jxwEcuRyX2CT2ZxnmkQXT85wLh/oVBhyleEya?=
 =?us-ascii?q?V3nuZXFdpS5/xXVgc6N4XRz+lkBND2XgLOZNGJSFGpQ9m8HT4xSdcxyccUY0?=
 =?us-ascii?q?lhA9WikgzD3y2yDrAIk7yEGoE78qzb33jrOslw0GzG27c8gFkmWMRPKXeqib?=
 =?us-ascii?q?J49wjWH4TJiVmWl762daQA2y7A7GODzWuIvEFFXw98SL7FUm4DaUvLt9T551?=
 =?us-ascii?q?/CTr+3BbQiNQtO1NOCKq9UZdDyk1VGS+nsOM7Eb2KyhWiwHxCIya2IbIbwfG?=
 =?us-ascii?q?UdxirdAlAekw8P5XaGKRQ+BiC5rmLaDTxuE0/vYkz1/el9tny7VEk0wB+Ob0?=
 =?us-ascii?q?B6ybq19QAaheaGR/MQwL0EoiEhpCtwHFqn2NLWEdWArRJ7fKpAedM9/EtH1W?=
 =?us-ascii?q?XBugxmIJOgNa9iiUAFfgR3pUzu0xF3C4VGkcQwsHwqyw9yI7qC0FxdbzOYwY?=
 =?us-ascii?q?zwOrrPJ2nq5h+vdqrW2lTC39aV4aoP7PU4q1P+vACmDEYi7XNn3MdJ03eG55?=
 =?us-ascii?q?XFFw8SXYjtXUYw8hgp743dNxEw+47OnVBqPaSuuDjY1Jp9HOY5xwzmctFTPb?=
 =?us-ascii?q?mOExX9O9YdAdnoI+svzRzhVhsZOKh386kuMovyb/Kb3IazNftk2Tehin5Kpo?=
 =?us-ascii?q?t61xTIvwdmS+WA558fwurQigafXi39l3+5u9r2gphAbDofWG2lxn6gTKxYY6?=
 =?us-ascii?q?BpNaMME32vOIXjxNx7ioWrXzhd80S5Bkgu39Wgch6fKVf62FsUnWgep32qnW?=
 =?us-ascii?q?Oa0iZ7njcy5v6T1SrPzuDgXB8KPmpCQm5yy1zrJN7wx/wdQUfgSwUlmhy/6Q?=
 =?us-ascii?q?6uy6xWqKp4NWX7W0pEfyHqaWplV/30/qGPZ89J9YMArTRcUOP6Z0uTDLH6vV?=
 =?us-ascii?q?9S1yLlAnsb3z0waiurpoS8mht2lWaQBGh8oWCfesxqwxrbotvGSroZ2jsAWT?=
 =?us-ascii?q?k9ijTNAFW4F8em8M/SlJrZtO26EWW7WdkbOxLm14yN/AbzoyVKCBm7jvb50o?=
 =?us-ascii?q?n8HBI13Af73t1uRCOOpxH5NM2jnZyzLOYvUwEuTHr3yMd8HIxv2MNknJgN3X?=
 =?us-ascii?q?0Rhb2R/HwagSHtN9hHn6P0aTwGQjtdkPDP5w2w41FuNnKEwcrCU3yZxsZwL4?=
 =?us-ascii?q?2hbng+xjM278cMDrydqrNDg30m8RKDsQvNbK0lzX8mwvw05Stf2rtRtQ=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2BvAwApCg9b/wHyM5BcGgEBAQEBAgEBAQEIAQEBAYMZK?=
 =?us-ascii?q?2J/hB+UZEgBAQEGfwghgQ+TUIFkNgGEQAKCHSE4FAECAQEBAQEBAgFrKII1J?=
 =?us-ascii?q?AGCTgEBAQECASNmCxgCAiYCAlcGAQwIAQGCXkACgXIFCKYughyDeAEBXoNtg?=
 =?us-ascii?q?WiBCoctgQyBB4EPJAyCXYRbgxiCVAKYZQmOWgaBO4ZShH8rkkAhgVIrCAIYC?=
 =?us-ascii?q?CEPgn+CHxeNYQFRI4EqAQGOeQEB?=
Subject: Re: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable
 holds
To: Peter Enderborg <peter.enderborg@sony.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
References: <20180530141104.28569-1-peter.enderborg@sony.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8bbb095e-31c3-0062-d17c-662e4832cc17@tycho.nsa.gov>
Date: Wed, 30 May 2018 16:34:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530141104.28569-1-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/30/2018 10:10 AM, Peter Enderborg wrote:
> Holding the preempt_disable is very bad for low latency tasks
> such as audio and therefore we need to break out the rule-set dependent
> part from this disable. By using a RCU instead of rwlock we
> have an efficient locking and less preemption interference.
> 
> Selinux uses a lot of read_locks. This patch replaces the rwlock
> with RCU that does not hold preempt_disable.
> 
> Intel Xeon W3520 2.67 Ghz running FC27 with 4.15.0-rc9git (+measurement)
> I get preempt_disable of about 1.2ms in security_compute_av().
> With the patch I get 960us as the longest security_compute_av()
> without preempt disabeld. There are very much noise in the measurement
> but it is not likely a degrade.
> 
> And the preempt_disable times is also very dependent on the selinux
> rule-set.
> 
> In security_get_user_sids() we have two nested for-loops and the
> inner part calls sittab_context_to_sid() that calls
> sidtab_search_context() that has a for loop() over a while() where
> the loops is dependent on the rules.
> 
> On the test system the average lookup time is 60us and does
> not change with the introduced RCU usage.
> 
> The boolean change becomes a lot more heavy with this patch,
> but it is a very rare usage in compare with read only operations.
> The lock held during a policydb_copy is about 1ms on a XEON.

This has a very substantial performance impact on setsebool, e.g. time setsebool httpd_can_sendmail=1.
That's because you are doing a full vmalloc();policydb_write();policydb_read();vfree() sequence on it.
In comparison, KaiGai's old attempt to replace the policy rwlock with RCU only duplicated the conditional policydb state (via a cond_policydb_dup) that he introduced.  Is there a reason you couldn't use that approach?

> 
> To use RCU the structure of policydb has to be accesses through a pointer.
> We need 5 patches to get there.
>  
> [PATCH V3 1/5 selinux-next] selinux: Make allocation atomic in policydb objects functions.
> This patch change the allocation for policydb objects. They are in its own patch
> to make the complicated part easier to read.
> 
> [PATCH V3 2/5 selinux-next] selinux: Introduce selinux_ruleset struct
> This makes the access for the rule evaluation going though a single pointer.
> 
> [PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to use rwlock.
> We need to make sidtabs copys so this patch change the locks to a rwlock
> and create a copy function.
> 
> [PATCH V3 4/5 selinux-next] selinux: seqno separation
> This patch adds separation of the read and write and uses
> the pointer to switch rule set. It uses seqno for error handling
> since there are a possibility to have multiple access.
> 
> [PATCH V3 5/5 selinux-next] selinux: Switch to rcu read locks for avc_compute
> All the preparation is done so this patch do the change of locks to rcu.
> 
> History:
> V1 rwsem
> V2 did not handle all policydb objects, solved with the policydb_copy
>    did not handle sidtab for booleans, I think this one does however
>    shutdown is not used but not removed. 
> 
> 

