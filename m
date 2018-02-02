Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-842278-1517531790-2-5415302991347011287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517531790; b=MhxS/7AzzOVmyWOue8UXvxJIbGNyQAHHq3E3gvgMOe7Sj0V
    8g2p55g5BaKpi72X8LqHeS05301dnA+GKVzTbJi5oma0c+wZcLhYhnmUbxKKIZBM
    x813hgQbq4s1+h7mxjL/gurRpbTS/NCiVvuZezQ2cDiR9R4OgYU4lEaPSDwnBN/Q
    EhtejP+czRmBDIxs0qbfXypGA2M/9OQpzzHwcnzSQvj+/OTPlf68KrXbxzAIdKvJ
    hKrAFppzdIpRvlVCQDCExfve9lxRGbu5HD5JzRDnL4xqXjueh7S3oYEfDd6Z79z5
    HT86vWDt8QJFcNchfZ1km80Rz86B6f39XeDfw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517531790; bh=Gjyi/E06TUaaR6sZ725jnqPEMGJ7cjIAfvh5tw
    hzi4A=; b=R7i6lR7pd9njajdVu7N1fcL29XQXwE90g5Ue8QXeOunHjT4ihILjbV
    u8tideAYqMjzTlpwrU5Lw/BwmyhrkNu3JRhIqtcqdH9kmU4Dr+wTx+BUmDAGQWLs
    oVBeyezBV8rmwU79tsgFoFyxFPhD4lfLHTauTjNTnmcX2HfDEqZjUUFR2z+hIwi1
    B5KDsgKDY3DMQWhIjOFDc7opJYbX409cYNbQVFyaqBM6ETmCeyON+WRb3MWOiC5Q
    gwH9dzSDRcrSGOigRJtNlUW+2ARHMelclQFqdhuC9Zws1/JqVXpLAHzk1MvsGgN4
    82mCgGSqpRzZHe7WkULSEqVF9xWLB32A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=itw5fc/S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U8LjTzbD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=itw5fc/S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=U8LjTzbD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeBBAg1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 19:36:27 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:34899 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeBBAg0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 19:36:26 -0500
X-Google-Smtp-Source: AH8x224mzPIfLHpdgVh3Dx9052rKNNlWaih4cYl2ZzB8gA8JYqzdob0Xgf/KTqM82Nyazg52lH+USv4ZrlVhe477Dwg=
MIME-Version: 1.0
In-Reply-To: <b8f04374-97f1-76d5-81b5-3583441833f4@oracle.com>
References: <20180201124019.11693-1-jgross@suse.com> <b8f04374-97f1-76d5-81b5-3583441833f4@oracle.com>
From: Chris Patterson <cjp256@gmail.com>
Date: Thu, 1 Feb 2018 19:36:05 -0500
Message-ID: <CABZSBQcmKBGZ2-i-YRL=Ux6hcAP0peR1zfaVh4Go9vr=JTRThQ@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v2] x86/xen: init %gs very early to avoid page
 faults with stack protector
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Works great, tested it and it fixes booting Linux v4.15 kernel for me :)

Cheers!

On Thu, Feb 1, 2018 at 3:17 PM, Boris Ostrovsky
<boris.ostrovsky@oracle.com> wrote:
> On 02/01/2018 07:40 AM, Juergen Gross wrote:
>> When running as Xen pv guest %gs is initialized some time after
>> C code is started. Depending on stack protector usage this might be
>> too late, resulting in page faults.
>>
>> So setup %gs and MSR_GS_BASE in assembly code already.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
