Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3570355-1527871309-5-11188286009770606956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527871308; b=NUfhywbP49wY4b4oYKmCUtgTs8CCve0+rXe84tr8Q8DUsUCbqy
    DGxwHjjv6+alG06XPDqQOLkMmXPbPsyRSUwmoJH0dNbzy6r715PwwI6cyQ6SEj+Y
    Rlcl8lcIWqT9wAv8pb7kvPkDCO5RTJHR5OT4QrKaCAygFz62thU7wCgM38GfN3bn
    pN1l75UTTrQC/ZA9k0eHnjB6U6Om2RJYSn587bp6GAL92jY30XMGZNuSKL+iHKCy
    mvNiJ3rtBKQapz8Jd/sRUtyRHquByJA5FAwmShcJGz6Pl8yx079i3U55UYbxSH8H
    f5MANWLrMOIh8BX2SHHFsgcfldpoa+bXJ2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527871308;
    bh=EfhpnoDH2EZ3cpLdTpa3rzP+jggh289gR/LIGl4BoDA=; b=fYIXAjA1b2of
    0KBGVsZNKFB25UtRctQJSURM1mIbrUmq5owN9bYMBUdl7nmz0wmjSUdoYbSKPlwp
    05TwqbZzZba+XFxgjMrmJI9CtCm1n63PEe4xBGVvkF87DV9JivwlTCyszwjzOQfD
    rUnCR7U/TaT+Um+xuH060525r+gB5BGBprWIGBk5NvdiVeA/UQkoomBgoohAhiD6
    mioua7vUaCfnX7pXykMq8Msxnkitc9SxfgSH3zEgNR5pUZHoTXimHke5dJ/9hCvh
    /w+9JO4dn34DicW6hHBpUfOCW5O8Nu9bgUuZSk8j3CJYgJ6NIhjj9yfF4BDrKCXe
    ua3OOFajEg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=JY4Txr6G
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=JY4Txr6G
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
X-CM-Envelope: MS4wfI82lF4IMsQs8JXfZjz5D4d3nytST2swNgsqS8fSxPX4LmVR1xTu/KFsNLPHKe/jHY7FIzj1gaIFfzUe+434LvttbqLekFOJ/C3BXAaBfQUMevmh/lvu
    8x5xP8WzAgs3oGNvlJoUt7MiAwsImNHoO/IAqfegdKd/PXqFDKLUQVhYNFcpbF8PSR6FuM39y9uFkA8nhQhzGkx3CwujORgnRZ0Wt3hmSGZwl2gWPDdua/c1
    7hk0WjFSgitngjB3td5sDQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=7mUfYlMuFuIA:10 a=We03CPWqHyUA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=VwQbUJbxAAAA:8 a=0dkv9SIndkvFNZI6wDEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeFAQlo (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 12:41:44 -0400
Received: from sonic306-26.consmr.mail.gq1.yahoo.com ([98.137.68.89]:42603
        "EHLO sonic306-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752453AbeFAQlm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 12:41:42 -0400
X-YMail-OSG: bYfU9rcVM1nUASJSbLG2p49jd8q6CMyEZR2TjtIOPLNs46zpYSe0Tji7INLUXIO
 8Cx1KyIjBHMys2cUYvjd7jTmpRAFj_5LDKcZ8N2_zRIs0DHmpbwmNLlVnUInDMIz60Lhwxxb2zRz
 f_ZY8FRkk385TuCpoRKZ_ydUQxOBN_6cvmgyjae6W7NyJ87s8CrcvVoQmHYlW4SsGlFXoYxYJis3
 6m66e8QYPbO59QUd6scVqJMP_29NG0g_9OkqfuBw.p8LDL7aPQLJANDOEY1r3wBYvXn8rClGnPFS
 Ac6d8mBeYm0VYY54h3zKuUbLF1AioVqEHY5.tjpRQnGyCH4TyjlslcxtkM4ZYH5bI6IncTSnV6Xu
 PLzXcgN49vj2cbcQSscV7tbgdlIhUNb9ZhTVDo33sBo23HiYxJ43wcYZqaXyG1hVyB9v9Zv5zD1s
 TJx.uAkpJejuOPBeT6aUgJNEvam9HIQ1pD_E1hPAb4d6pobJD5Jgw7ae1Q2b3bmDkCq.Nk8iXaFh
 kQjkHPtUYGeSjwSc1gu9MXyC5kBTiuGruYNHSufOcdG10CbE8fbCrziEuzcfGSk5zDBhHeaszdNy
 zX497IvinYfTav4.Q3ukeTmaJizcnMnd_1CkYeAUoVtOYnK_d.PCvKBTwTY2JL1mh7g6pDxR82BX
 ivl_9TJ8pE9Qzeq1m1Un44Edp_8S1QqH.iRhnKLNN7Zs-
Subject: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
 kernfs_security_xattr_set
To: chandan.vn@samsung.com,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        CPGS <cpgs@samsung.com>,
        Sireesha Talluri <sireesha.t@samsung.com>,
        Chris Wright <chrisw@sous-sol.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <02d9878e-65bf-5de8-9658-cf0f692f358c@schaufler-ca.com>
 <1ced6bce-92cc-7e0c-fab4-0aaa3d03b82f@schaufler-ca.com>
 <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
 <20180531153943.GR1351649@devbig577.frc2.facebook.com>
 <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
 <20180531161107.GV1351649@devbig577.frc2.facebook.com>
 <20180601085609epcms5p5fefac0156a4816e9e48751211ab595ee@epcms5p5>
 <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcms5p7>
 <20180601162913epcms5p7737f5b4376d8865af1eae119aa866550@epcms5p7>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5b0b157a-0e8c-d8f5-901e-836d545a8e4c@schaufler-ca.com>
Date: Fri, 1 Jun 2018 09:41:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601162913epcms5p7737f5b4376d8865af1eae119aa866550@epcms5p7>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6/1/2018 9:29 AM, CHANDAN VN wrote:
>>>  I agree that the fix can be done simply by using "false" for 
>>>  smack_inode_getsecurity(), but what happens with kernfs_node_setsecdata()
>>>  and smack_inode_notifysecctx(). kernfs_node_setsecdata() is probably ignorable
>>>  but smack_inode_notifysecctx() is sending the "ctx" to smack_inode_setsecurity()
>>>  and since "ctx" would be NULL because we used "false", smack_inode_setsecurity()
>>>  becomes dummy.
>  
>> Thank you for pointing this out. You're right, there's more
>> at issue here than changing the alloc flag will fix. I think
>> that calling smack_inode_getsecurity() from smack_inode_getsecctx()
>> is making the code more complicated than it needs to be. I will
>> have a patch shortly.
> If you think the patch would take time or is complicated, I suggest that the kfree() fix should go
> to fix the leaks for now.

Heavens no! The patch is very simple. I'm building a kernel with
it now, and should have it tested and posted within a few hours.
The implementation of smack_inode_getsecctx() that's there is
understandable, but wrong. There's a much better way to do the
job.

