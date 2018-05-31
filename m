Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1708975-1527783748-2-4605477526147645060
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527783748; b=fPRbTx5U5RB4KqhCWizpsjwu7DEU5DLGv9YadH/22EnhwROJM3
    b63YF7XG5Rjw86dqFlrsSeqriZHIjGx/z2HYt4LAYyzTUIFVY0USndItyQbeC5Ti
    qXOsIC5Wn7gXiGDiwKPfQe/Wy4GFSL8RywUKXW9XilB3xsafqfXIu+O5d4XKg1rk
    pArnAIudLIe8Imv2h8qoyWCzswH+r9rE1l5mtGwPLWM9DBuv9qQnb550XnnGojcf
    f3JeU60L3MshzxaJvxsgQaCq2gC3C4vpdkWNdN+iZlAVWVReZGExj4mpycJ9gr86
    bUwObOxsGlMmrEW/M/mY+7IhS8/0UKaqreHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527783748;
    bh=AgXj8AArfBcW9SMKhn6tAyeWgVAT0/cBt0S6wV38W3c=; b=Ow/SDv0X2Qu1
    HdTNX8qtR9PrT2EnrNRmzOdJcOnlhvq5ahiymBbvOKh5ynmQNJb4KDZBnszmOX6J
    Odpy3yu5EaL/NkAZrVuC/3G102FLNT4L0Y7nmkbJA7qViPXhCdNO2/6NMK+qcXsB
    0aJlhccG9v4adVoCVEY08Y8+umEB1eiO8uJFPGSYH24/H0uLkG+QvKImJVkoyxUf
    Iy77QdBy+70M85WwFO/7+O7oiQ8YOYmQHmN1RJKQKiVuxMITbfHi6xC9tfndMKet
    HdcYYSdsJFuIe57nS1QRvrwpqexfhHw3Msnx6qW2E+PhtBUqXr8WMbGzCw0sHTrz
    5ajqK2q+RQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=QMO9A2oM
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=QMO9A2oM
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
X-CM-Envelope: MS4wfAU8FaZWue72/Sw4/awaNWjVJ8pIdQ/9O39yM4Y/1z6IWSjrOH2WCjInnKKtgcoQWVyCGlqP22bc2X0Jul2eyTbw8hEHgNVBYAR6+4mlFw1Gp9SfnQVF
    /bv+TGSqzTEVrPjTIAyLCmhT1vWqQXAaswZ6RwdrfkAi/wFiSW9ccEGT1JQAwn9UADQldfIchM9TdEYT7G2IoXcuQRTDT1mSINY41MLJBJmSpqJHVCdfhwf4
    3HGpCX6CJC9+AZE19dkbRQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=VUJBJC2UJ8kA:10 a=We03CPWqHyUA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=VwQbUJbxAAAA:8 a=fpOHQEl9X1u3KMRq2TkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755636AbeEaQWY (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 12:22:24 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:42772
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755632AbeEaQWX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 12:22:23 -0400
X-YMail-OSG: 4QD9H7UVM1leSF1nzd4B3LsQ_GyF6b62rjBPUqgXWHWCEIVmehnvYm7illxkI.D
 4AICOMyfutbwba1aLNahbKxkPS6ct23c1cFpN7O101otRJJiAb0MW6Fhno68y66f1d.FWgvUmhJm
 9e7UXCPvBp6mrBEl78idF9xLxKIMVWLGMG7E8wim.PmWotXuZmyLRtO3cUM5J8ldsBM5ygQNsDpz
 iQsn4K9Xvt0LvSU4dqmTbMqmDvbEqMyn2MG6UXqB3FoZAtpV2FQ_GOb_i7rye.SZ2_tUAoyyYayY
 bUWvJCX2YI6IxvDuELg1C1LsXbxCTYydVUaU_ARdyIPUl1eYr4gURdMPV0UdUEqKRNDgrPqfoNsZ
 CdPalXForSmR4kvVbwL0VviA3.eBDwtYCJcbpJ0th48xCj83qgEYbznr4GYhFPOHvJ_iE7Nw3EHh
 ILGQKR8.j3DiDzl_2w4NoIA93SAd6teuFovFjc1.fGH2dpU.nbnkKqzPekStyIN6a5alz4fHtccR
 qoVR1bJKoYN6g_QlY7TdrNrmesriBDIygL30RwrDPE8z03CtVUO9rJuYEb1oU5saUlZ3mDNINUln
 492wB88RR7fTdi9rhrsQLw0g1y5qBziXaHOJ90iKDAtfl8u39BBDn8erToanuLyCdCNAfW.QXonQ
 arlaFX7zg2g5FFLgohIc459n5Q8pTpobDirTKbKEZSZk-
Subject: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
 kernfs_security_xattr_set
To: Tejun Heo <tj@kernel.org>
Cc: CHANDAN VN <chandan.vn@samsung.com>, gregkh@linuxfoundation.org,
        bfields@fieldses.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        cpgs@samsung.com, sireesha.t@samsung.com,
        Chris Wright <chrisw@sous-sol.org>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcas1p2.samsung.com>
 <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
 <20180531153943.GR1351649@devbig577.frc2.facebook.com>
 <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
 <20180531161107.GV1351649@devbig577.frc2.facebook.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
Date: Thu, 31 May 2018 09:22:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531161107.GV1351649@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/31/2018 9:11 AM, Tejun Heo wrote:
> On Thu, May 31, 2018 at 09:04:25AM -0700, Casey Schaufler wrote:
>> On 5/31/2018 8:39 AM, Tejun Heo wrote:
>>> (cc'ing more security folks and copying whole body)
>>>
>>> So, I'm sure the patch fixes the memory leak but API wise it looks
>>> super confusing.  Can security folks chime in here?  Is this the right
>>> fix?
>> security_inode_getsecctx() provides a security context. Technically,
>> this is a data blob, although both provider provide a null terminated
>> string. security_inode_getsecurity(), on the other hand, provides a
>> string to match an attribute name. The former releases the security
>> context with security_release_secctx(), where the later releases the
>> string with kfree().
>>
>> When the Smack hook smack_inode_getsecctx() was added in 2009
>> for use by labeled NFS the alloc value passed to
>> smack_inode_getsecurity() was set incorrectly. This wasn't a
>> major issue, since labeled NFS is a fringe case. When kernfs
>> started using the hook, it became the issue you discovered.
>>
>> The reason that we have all this confusion is that SELinux
>> generates security contexts as needed, while Smack keeps them
>> around all the time. Releasing an SELinux context frees memory,
>> while releasing a Smack context is a null operation.
> Any chance this detail can be hidden behind security api?  This looks
> pretty error-prone, no?

It *is* hidden behind the security API. The problem is strictly
within the Smack code, where the implementer of smack_inode_getsecctx()
made an error.

>
> Thanks.
>

