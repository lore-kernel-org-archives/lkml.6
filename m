Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3531692-1527870156-2-3654481133639471557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527870156; b=YKvUEqXdwAKEE58esj6YIXLw1NWBDAmweXKbA0o+sQH4jwrtM8
    ct6UhwUKhEY5J7L/s0y7mE30PMhhYH8DHrGgclSJdOAn55cAmRUsoZX1QxUhH3Q5
    ziXIIDYXe5a7WBlZksNM7GP7y2V6hMYJ4dINFcuyYg8FInfFRF4+/Hou8UkZNvgw
    lcgn5HB43y9sz0cRB8KiiYCxw8YubC2BIV6ddJVx8A6MLWsAxBI8e0r/IXOl4Z5E
    5NyHBnGXhfBnq2tm2alg3D03Q8yOstadknjw4o+GSx/H5l/b42d+/k/Ku2+BYj3l
    9lbJAV52jwrKxzO79ECRPGlKxEFMZ8RUqFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527870156;
    bh=3aoqBqmZT+wk664teSngpw3DXvJGgfR0YWpTDiRwKDc=; b=QUNVuqc35KUO
    7Qz7qs/GZhThL4VzV/t6LZasW2H0Z3fNvTrBugeecjiSVNSxdnuCkzdQaHC3AexN
    AmshY8ZycQbBH7hxunGJXOiEpDiu9qCJ3cKCE3vjbbySrvsw/U2JLN/WZjiW2jlp
    3kVf3UgBM7qkPVKZTCciXOTreaL4f190HHkOcpQqtY8BTiDp/7OhpO22dwJdpagk
    zhHSIyLTODrjRNLHiyvRm7I2nttS21sRVqwM9iEFMQEz+KJ3WR1pY7n4l+5WS7RQ
    naN7BhwyTKl0e95nCkA0sui0Bd2dMIMRLGH1wDCC8ZrEp/oYUT7TzvxmJcYYsBgz
    JYgPdpCthA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=P4sciPwU
    header.a=rsa-sha256 header.s=s2048 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=P4sciPwU
      header.a=rsa-sha256 header.s=s2048 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNW8ge7hXRhky7Q4PbfXN03dRH8DVXDiAJDTQBkuCVI4RSgT19Zn4eD+l0AIIceA+9WwXF3JqWIYduJ+Mv6IU9awMcuEtovFntjid9O9jEwYmQLPFiub
    hbKJvXpXESWYZlp6la3z9yGpnnIPbViFdaL3qb0cJV7y9UYNqmCqCts363pA5334BZHvqaydhA6+NtZ+G7FoApzM6TT4gswGZui5ZtuZ/ln+vE5GV575TisI
    bnwz64uRapilmIlwp+0lBw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=7mUfYlMuFuIA:10 a=We03CPWqHyUA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=VwQbUJbxAAAA:8 a=b-0EWbc89QySxbs8KeYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbeFAQWc (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 12:22:32 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:35685
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752525AbeFAQWb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 12:22:31 -0400
X-YMail-OSG: nXgaC78VM1nms47RJ7ETpA9V3qhR8OmICRXF4rgQTaqXNyEhsUMWci37qgqZUnQ
 NgPihj1aiwemZpVuQZoBFk0GV6CjMMVy3U9UBUN4uJ3nFwYVFj1o0j5bUuVgWDpmJr8bZIyQ7He2
 h0SjAFOW2ZT2De.gUKA_S87bV6zrdA_VVpZ50IgS32AysgSgH5PgfwrTx449YfUoATKth83b6kb5
 zbKGretnvNVmycpK2xABgwBdv0PytmOREis8yd0O6lYvzgRDUHu7KNqsAgCnwM2CCEGXaUu.Ma8W
 TDbhEC3214VY763h_oEvytn1JZZE1dv53oReTcXZRlb_VDLLqjIm.2RI4A6oN6nqhe9l7M4WuXC1
 VGj1GH2Z_bwWFEuSLH9Wf4jm9tza_4vZJf1rzjUqj4oPnmfNeW8nQEMdiE.QwLMuUuzgVL002NF4
 It76QpxXSqdoZVBrBQKo4XFswpr1T8oe4t8jHtUU3Je1eHOSm4Rx96oYcrGEsg5Gjg4y9rLHO6Cw
 LfI6uN8PM6zXHw6L14K30r7f8nrk5LWNSTpFRTpDTbDVfNUIgwdo0vmzpoZzJIhMpbQel6wlUhnq
 oU1mHRQF4w5CA18oZvLQsr3mv1wL4m2jH9pAFYBuNVeiC4sH0Xi9Fukezot1SKJ4YgzXPrhcUCpA
 MR_axoEsYgEL8l2tcHGc4EsHa_rNH.AI37YET1MIj_lI-
Subject: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
 kernfs_security_xattr_set
To: chandan.vn@samsung.com, Tejun Heo <tj@kernel.org>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CPGS <cpgs@samsung.com>,
        Sireesha Talluri <sireesha.t@samsung.com>,
        Chris Wright <chrisw@sous-sol.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
 <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
 <20180531153943.GR1351649@devbig577.frc2.facebook.com>
 <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
 <20180531161107.GV1351649@devbig577.frc2.facebook.com>
 <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p5>
 <20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <02d9878e-65bf-5de8-9658-cf0f692f358c@schaufler-ca.com>
Date: Fri, 1 Jun 2018 09:22:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6/1/2018 1:56 AM, CHANDAN VN wrote:
> Hi
>  
>
>> On 5/31/2018 9:11 AM, Tejun Heo wrote:
>>  On Thu, May 31, 2018 at 09:04:25AM -0700, Casey Schaufler wrote:
>>>>  On 5/31/2018 8:39 AM, Tejun Heo wrote:
>>>>>  (cc'ing more security folks and copying whole body)
>>>>>
>>>>>  So, I'm sure the patch fixes the memory leak but API wise it looks
>>>>>  super confusing.  Can security folks chime in here?  Is this the right
>>>>>  fix?
>>>>>  security_inode_getsecctx() provides a security context. Technically,
>>>>>  this is a data blob, although both provider provide a null terminated
>>>>>  string. security_inode_getsecurity(), on the other hand, provides a
>>>>>  string to match an attribute name. The former releases the security
>>>>>  context with security_release_secctx(), where the later releases the
>>>>>  string with kfree().
>>>>>
>>>>>  When the Smack hook smack_inode_getsecctx() was added in 2009
>>>>>  for use by labeled NFS the alloc value passed to
>>>>  smack_inode_getsecurity() was set incorrectly. This wasn't a
>>>>  major issue, since labeled NFS is a fringe case. When kernfs
>>>>  started using the hook, it became the issue you discovered.
>>>>
>>>>  The reason that we have all this confusion is that SELinux
>>>>  generates security contexts as needed, while Smack keeps them
>>>>  around all the time. Releasing an SELinux context frees memory,
>>>>  while releasing a Smack context is a null operation.
>>>  Any chance this detail can be hidden behind security api?  This looks
>>>  pretty error-prone, no?
>  
>>> It *is* hidden behind the security API. The problem is strictly
>>> within the Smack code, where the implementer of smack_inode_getsecctx()
>>> made an error.
> I agree that the fix can be done simply by using "false" for 
> smack_inode_getsecurity(), but what happens with kernfs_node_setsecdata()
> and smack_inode_notifysecctx(). kernfs_node_setsecdata() is probably ignorable
> but smack_inode_notifysecctx() is sending the "ctx" to smack_inode_setsecurity()
> and since "ctx" would be NULL because we used "false", smack_inode_setsecurity()
> becomes dummy.

Thank you for pointing this out. You're right, there's more
at issue here than changing the alloc flag will fix. I think
that calling smack_inode_getsecurity() from smack_inode_getsecctx()
is making the code more complicated than it needs to be. I will
have a patch shortly.


