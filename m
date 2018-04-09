Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1194497-1523281503-2-16859757723820005952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523281502; b=mmPXKCrycv4FarggMieIfNEAqX3xg9tczu6IVdmCjn+C3LYG5J
    h0DkXTs6j9VWzvN2IHoVeidEn5xvcMle5250c6atUKpl4RRoU2YI+ZdKYn/a/QgX
    aGJ/wtYNQJnLMYQAZp+JKZt4Ysr1/5wkRo7ODb6psjDPLzzxugAeypmuBt79mfsJ
    V+pW4FyypXxtM2HJY1z8bhQ2wmTVR3yauiw/jKQ6/R7tEwbAUMIx5zzTD/teqaQH
    ScAGXYlSmsn1JAocEGaJf6sm7NYWwqoNpsLscz32Wbt/FA6R2y3R9iL1a/ibgwkK
    TynX9xmPoLYs8L91RFlHTEsN4vrXDep+68JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523281502; bh=/hHYBQpSXsCaqQnfpmO1rOeFhn0qk0uBF++H4vZ7Kp
    o=; b=Ugi66kgJgfBFh2t69l0pJwpvlg8EPotH1v0sh1kbxd/g9MzoZwNeFd4rVo
    Ik10e/FwUgWY7rnLp55HKrtvjiRhpVu/ZpsZFJeMG0o0EZFMfUc6qbnhzn0Da06C
    rEMSxOQnfNbgv19OTsRriKxEy26zsrIq5ytqXDfCrzdrG+PBYu/JQNJ+c2moSRKO
    6fXtK54nNnZ+o85Jk8g/6NPGJ6s0G8aIRsmX/gyNoXdffsFUDL/+ER3cCfDmCiny
    RjDWyXlhnyz3r3sfs1qMoAwBf6TwNJxHsrLhUXB8+DLEKpValkXEoDbyHe7hUjsW
    skL5trEHh43JFPxPeEYXH1uG7Jyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=olnmPblC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OgycoRn5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=olnmPblC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OgycoRn5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfErmYFAZfm9E78xyMjRjemfeBCKBUtO8mAodpsOagcAyesFC5a2v7DrhLAchuBdQ0Nt/GywO8ytZCdyl34KYkqwFGC2h7ebpdJcoYXGYjEVbjM5PLxQY
    DbkvPAkKPKUuJwKwiMcLO7eclYyALOjG4ZBKWptdzDh9yB/KZrL0NVqufe/b1dVeo4NH1f4Tni2NGl+nXjPkngmVq58qPIQN22mvzuQUyTvmmCopMKOrGoNs
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=-LxJmRj0Z4cA:10 a=Kd1tUaAdevIA:10 a=m_Sayh0VZNAo3gMqpVgA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeDINpA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 09:45:00 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:41268 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeDINo7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Apr 2018 09:44:59 -0400
X-Google-Smtp-Source: AIpwx49M7Of39vR9KsbhzSQ9ckP+ipYvpTBfCR9BD4FBZS7ZHLJkoxWNudefCtwjRklTpIv9ZDUYgtl9CFNfpFHKc48=
MIME-Version: 1.0
In-Reply-To: <20180409144803.08293fe4@endymion>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-142-alexander.levin@microsoft.com> <CAPxHnE3uPVC684DzGbdNRsJNsfHN8WF2H7m8GkKz7Z22-V+1yQ@mail.gmail.com>
 <20180409144803.08293fe4@endymion>
From: Parag Warudkar <parag.warudkar@gmail.com>
Date: Mon, 9 Apr 2018 09:44:28 -0400
Message-ID: <CAPxHnE3RLALDXA6OwMT6CKUM5U9vPo_--Wq8t7MZRwz04Gzu=w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.15 142/189] firmware: dmi_scan: Fix handling
 of empty DMI strings
To: Jean Delvare <jdelvare@suse.de>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 8:48 AM, Jean Delvare <jdelvare@suse.de> wrote:
> As a conclusion, it's doable, but the benefit is very small and limited
> to a few broken systems, and it has the downside of not discouraging
> low-quality tables, so my position is that it's not worth it and not
> desirable.

Thanks for the explanation Jean, I just wanted to make sure we are not
going back to the original problem of allocating lots of memory for
lots of spaces. Given the limited benefit and low likelihood of
encountering lots of strings with lots of leading and trailing spaces,
I agree, it's best to stick to the spec. And it's also no longer a
static 2048 byte array we are allocating from anymore!

--Parag
