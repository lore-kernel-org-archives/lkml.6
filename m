Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625927-1527357196-2-4543143509491334000
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527357196; b=Wu2Csed2cci/qAJsf81i5lEIncTdgqX5AFI/WlwKFBsZEKn7RJ
    8FwZtUq2lbZXz2P+vcgVSVpQNlhEPXyAq4KU/G8SXuMuUX8O3oshQ6s5JhcdZOME
    aZK7RKtYDW6ThbcW8Eob0J3tZMB2eXaRP792s4aiTz7VNne9B+omq2KPra5K+FR3
    PDIarqcTEjRkMzL1W0hROArE3Lq/u6hIf4Sm9mdD99y+Bl1MNg/r8e4JhGiuf0j2
    WBZDhOh2O2iHhF2S5tYcgeWVLXqlFXhoJmIgzQAJVwrE4LVwaeEfSTwexF0MKdsv
    k1IRzswLmDvHV6qqV1f5LRZhsS4+faNhx9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527357196;
    bh=HXKdePOYIWzHnjFQtHg+EmDhwMNxFnCQt1yDr7fN5lY=; b=CXNXdnHvQO80
    VeOJl9BuW8/f9Bc0vjH5DkIligCy8ivckj6uk9xtDv/7s9FefyR8EFSO2edGaL2w
    4f7fvwUeaOne6Wo3S5FDULXbeRVT2sGIBtw1cFgPkKG+knQRzvUZ/5f8ZcA9ZuGu
    d+gw4Fgjp2tKvIboVszctg7FomMkf4H1WwO1O+VrlNY06VNfwCZS5FJMF+v15pnU
    KHZx3VJQRYmF8tYit1YEeppF8TGuEw8wXvtSX/bzwCgddGjIxFndARDtMsGPPnqi
    88dMrgy8tR9fHdeZHUzrhBIyMCUVNuGpWgav/RQGgVtDHGOzirdlcrlzi44UBQ52
    THdv9+GnyA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=yahoo.com header.i=@yahoo.com header.b=uDFYTvi5 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=schaufler-ca.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=yahoo.com header.i=@yahoo.com header.b=uDFYTvi5 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=schaufler-ca.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI27MV55Bx2lDydD9/lo2unfYeQgBILBmP7Ku9mQhxgYN4KlEiHlvndEZ+VlSKjnPf9mcBvqFatKKu6Mg0wjkUhwIu2IspIcfwN8J65YpTsNMOQr01PR
    vh7JauCSLkMjNM/4MhWxT/CgpdNOxEFH5C5+uvQDZocnxOLzlGtQO2g7C8rrgGcKHpKw3rgEcCRr6ORIKWyLqUzdSUAlEuJdKD3Krb4+uwwy6TJu4wNX9zdi
    8cpcJAJ4Ldd7qFhvJzvKHA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=5HJ6KZJP-kkA:10
    a=VUJBJC2UJ8kA:10 a=TftV-o5MLXgA:10 a=3NGxsLzzGfgA:10 a=ZZnuYtJkoWoA:10
    a=pGLkceISAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=b8oQmyZUZ2kxXGd1OyIA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032230AbeEZRxN (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 13:53:13 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:42456
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1032115AbeEZRxM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 26 May 2018 13:53:12 -0400
X-YMail-OSG: m4YGGE0VM1kyTL9g.lgw83ZLkNDly6unPNA5wpQnigdWflt3E2INhsmzPozvpfU
 if4pZ2Z_Hw.509sEPUOAd6sJFWblTz9L4LOuBlJPbYsrYmrpb2Mus37EXIvK8KhqmPwonrnmP0Dn
 dEooyyVH1F64d2_R0W8dIiz.tSaXLnmiNf.p.GDECkEb2TTdGpsoKmgwBNLbkNCbaTT2HahdzA56
 faC.ywP8EQzmHEwsRdmayyQP5v.3vxznb9YfKGpTHrp6Q4XKNMy55e9lEedQYetO9_XmRhpaXQlo
 7M_zvKqz7pMlrGrEmf.5bgQtYUUlLPGdVYlRicDqvfu0quLc_3SqJZZKaSIFsJPzGF12K6xj0KLz
 Sde2EQKzO4bA48HSUMddkduoqmUVVsD76nFam1PXPx7fzvJHpxlEd7uVN1pwQvLI4rVmKl6d7adT
 YesOos8E6eT4yZKQoEuyU7J2piseNmKwYXK2j12Jd2DQWZToC24OFkTdgtDZbHTB8cNpD5RExQUL
 Sh_Ra1Py.49lIflFARtkKx553wSsvn6PmpgvzZGX.PUN0YKtI9UP7sBZgzdT7BY1cF9x_9xUbVL6
 kERr45UNAo5G65uvzsLdiOw7E.lQ9sT.JNvbuq17pWKN78ang1XLYBQb6aSPdwufKIFnP46cyFFs
 hbTBB.lkyDRvZ95s.6cpKu74KufaCxe2MfVo390t2UcF_lQM2SUckuFrxoX2e5U_MhZNLSByjcCO
 VfAxvw0O4LRpBNwpypwLnJAMrTSGPzg--
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
 <20180526154819.GA14016@avx2>
 <CAJHCu1LgSUJdiZEfParCH7aLERWM1bgwC7e8wQKgmkNE01_4KA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <df12287e-7c19-61a6-b94a-5b7186a1e2a3@schaufler-ca.com>
Date: Sat, 26 May 2018 10:53:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJHCu1LgSUJdiZEfParCH7aLERWM1bgwC7e8wQKgmkNE01_4KA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/26/2018 10:30 AM, Salvatore Mesoraca wrote:
> 2018-05-26 17:48 GMT+02:00 Alexey Dobriyan <adobriyan@gmail.com>:
>> On Sat, May 26, 2018 at 04:50:46PM +0200, Salvatore Mesoraca wrote:
>>> Prevent a task from opening, in "write" mode, any /proc/*/mem
>>> file that operates on the task's mm.
>>> /proc/*/mem is mainly a debugging means and, as such, it shouldn't
>>> be used by the inspected process itself.
>>> Current implementation always allow a task to access its own
>>> /proc/*/mem file.
>>> A process can use it to overwrite read-only memory, making
>>> pointless the use of security_file_mprotect() or other ways to
>>> enforce RO memory.
>> You can do it in security_ptrace_access_check()
> No, because that hook is skipped when mm == current->mm:
> https://elixir.bootlin.com/linux/v4.17-rc6/source/kernel/fork.c#L1111
>
>> or security_file_open()
> This is true, but it looks a bit overkill to me, especially since many of
> the macros/functions used to handle proc's files won't be in scope
> for an external LSM.
> Is there any particular reason why you prefer it done via LSM?

If you did a Yama style LSM it would be easy to configure.
Even though it might make no sense to allow this behavior,
someone, somewhere is counting on it.

>
> Thank you,
>
> Salvatore
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

