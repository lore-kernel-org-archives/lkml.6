Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-313747-1519829906-2-9953246153837109695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519829905; b=cx8PDIKkT/CXUj80f2CQz0H9I2TEMm1oYD2UHSyApnDkH2+
    Ckh5RFJR5D2muTuDG5iTGMEi2k8h2DuN8A37Vzp1svAC6H8kB/Gz0UgLcRlNcbpZ
    yP21MuF935h9Uwn1CD6yo4x6fY7v5GBWBTzKEHTG307SqxILR+plVPFwuyp7kLfG
    vqZZPTlsF0IQSKvQKJu+8G44TrdC8e4AeJ8B5HdBWVpBEqCwvQEkkfQsBHfV5kIa
    cSZ+cfiS3n/71Np4lM9ZgXrNt8YrIRImTkbLn7BkgOmK+FYtbgoXAZ5G14hRn2OO
    ez0eY6dVH6bc6DC6maRfYq5SDuWZgxvbYw4EJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:subject:from:in-reply-to:references
    :to:cc:message-id:date:sender:list-id; s=arctest; t=1519829905;
    bh=8q3Eb8rpMkplUaVc+ebfBZ+4wxdUs5grtYBAMSMbsS4=; b=uGd4k8tykVUI
    99UkhWaSohniW1gsoZeYmgGHt8XXOP51kvHhIfuAC3iXQIgS2aH7Ds/X1TOEtOXG
    b+MfH4FDz0px7ouCUD5Cl6Jg3Zb/Jz3nm8ZjaRU6weU0nfGt1+Ocy7Q7USgIvAcS
    5S3Nae78lz5TQzOaqlOgXzL6EpeG5n/5NABMw+nGN/LpCKlnP5wk8DKPVGWpUh8/
    d0g/KzqUxWkFaFVU8z48T2/e3iPb0U4epaVkO4stI8WnKBFr0hnbKh5voVD66BLl
    YzmIw3jx2e1r5EJ1CU33oAkoDtJ33L5Xj8Do0Hp3bfi1ojvw2HhjdngxVO0lyDLt
    VvW/JVlCnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=VkzMkail x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=aGCqaX4q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=VkzMkail x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=aGCqaX4q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeB1O6W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 09:58:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54778 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbeB1O6U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 09:58:20 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,MISSING_DATE,MISSING_MID,T_DKIM_INVALID autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C385607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtl8187: Fix NULL pointer dereference in priv->conf_mutex
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1518679365-15697-1-git-send-email-ssreedharan@mvista.com>
References: <1518679365-15697-1-git-send-email-ssreedharan@mvista.com>
To: Sudhir Sreedharan <ssreedharan@mvista.com>
Cc: herton@canonical.com, htl10@users.sourceforge.net,
        Larry.Finger@lwfinger.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudhir Sreedharan <ssreedharan@mvista.com>,
        stable@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180228145820.3D42F60867@smtp.codeaurora.org>
Date: Wed, 28 Feb 2018 14:58:19 +0000 (UTC)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sudhir Sreedharan <ssreedharan@mvista.com> wrote:

> This can be reproduced by bind/unbind the driver multiple times
> in AM3517 board.
> 
> Analysis revealed that rtl8187_start() was invoked before probe
> finishes(ie. before the mutex is initialized).
> 
>  INFO: trying to register non-static key.
>  the code is fine but needs lockdep annotation.
>  turning off the locking correctness validator.
>  CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
>  Hardware name: Generic AM3517 (Flattened Device Tree)
>  [<c010e0d8>] (unwind_backtrace) from [<c010beac>] (show_stack+0x10/0x14)
>  [<c010beac>] (show_stack) from [<c017401c>] (register_lock_class+0x4f4/0x55c)
>  [<c017401c>] (register_lock_class) from [<c0176fe0>] (__lock_acquire+0x74/0x1938)
>  [<c0176fe0>] (__lock_acquire) from [<c0178cfc>] (lock_acquire+0xfc/0x23c)
>  [<c0178cfc>] (lock_acquire) from [<c08aa2f8>] (mutex_lock_nested+0x50/0x3b0)
>  [<c08aa2f8>] (mutex_lock_nested) from [<c05f5bf8>] (rtl8187_start+0x2c/0xd54)
>  [<c05f5bf8>] (rtl8187_start) from [<c082dea0>] (drv_start+0xa8/0x320)
>  [<c082dea0>] (drv_start) from [<c084d1d4>] (ieee80211_do_open+0x2bc/0x8e4)
>  [<c084d1d4>] (ieee80211_do_open) from [<c069be94>] (__dev_open+0xb8/0x120)
>  [<c069be94>] (__dev_open) from [<c069c11c>] (__dev_change_flags+0x88/0x14c)
>  [<c069c11c>] (__dev_change_flags) from [<c069c1f8>] (dev_change_flags+0x18/0x48)
>  [<c069c1f8>] (dev_change_flags) from [<c0710b08>] (devinet_ioctl+0x738/0x840)
>  [<c0710b08>] (devinet_ioctl) from [<c067925c>] (sock_ioctl+0x164/0x2f4)
>  [<c067925c>] (sock_ioctl) from [<c02883f8>] (do_vfs_ioctl+0x8c/0x9d0)
>  [<c02883f8>] (do_vfs_ioctl) from [<c0288da8>] (SyS_ioctl+0x6c/0x7c)
>  [<c0288da8>] (SyS_ioctl) from [<c0107760>] (ret_fast_syscall+0x0/0x1c)
>  Unable to handle kernel NULL pointer dereference at virtual address 00000000
>  pgd = cd1ec000
>  [00000000] *pgd=8d1de831, *pte=00000000, *ppte=00000000
>  Internal error: Oops: 817 [#1] PREEMPT ARM
>  Modules linked in:
>  CPU: 0 PID: 821 Comm: wpa_supplicant Not tainted 4.9.80-dirty #250
>  Hardware name: Generic AM3517 (Flattened Device Tree)
>  task: ce73eec0 task.stack: cd1ea000
>  PC is at mutex_lock_nested+0xe8/0x3b0
>  LR is at mutex_lock_nested+0xd0/0x3b0
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>

Patch applied to wireless-drivers-next.git, thanks.

7972326a26b5 rtl8187: Fix NULL pointer dereference in priv->conf_mutex

-- 
https://patchwork.kernel.org/patch/10220507/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
