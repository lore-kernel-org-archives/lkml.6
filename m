Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3399165-1526624395-2-15853538749881704717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526624395; b=OrqBB5Rnirt/cLvBHQns7aL/XLwZzaZ6tIIp4XpTqVDpgccISZ
    fBKGwdJSjbWwmFdjsw3wRnZXLXG8NJ1HJfmqbI/gEHXDD3ozzP/ZBrH8bVtnckx/
    2GJ3wVmOtNXTrds1OvwU1Sd1MSukxpGLwoTGt75pmgNbmbKUrTbS/JG+haJ+c6fz
    MfNL7zSQm3xJZo2GVPnnD2drYMzkEO0Cgxyf9McNtL3Ku+BmYiNCTTmOcLuKg/km
    K4xrchNUZwRAWHEi/gjcqURqyfzWwEA6nU9DTo6ue3YxgWL1yJy0a0LLehzX1llO
    iAU+hbk16L2t8Uje3rP/6yoCr+gdIoLOIBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526624395; bh=ul4sFNIqQSKgwQIw7ERlFCekXlw46N23az1r5GSmQ5
    s=; b=KLU1U4lsDepIL3iO8smgDxcwQR86kuI2yFX3sfwTlt4o+obDy41rtJqL/M
    8S0ohWUorrldqA4Xs0NqlO22QtvgGk8pxo1QwHq1DIRyPv89nBHSizJ0J//KkDY9
    Zora2+MigMHPOK2ExebkB9iCQiG6sQi8DVmEJH6+y/SftJ+TSCort5zluwgK+gHe
    IpfMzVUk3KyPPKuTU3MfN+YnFOhnP6ekbgjTunP7OIhR9S+Nwygm5P1HqBj2c5st
    RnvK1y2Mp3aRFCGmO9rWF2BxwgzN5uPPSoTcbShhdn5I1ZneVzce7VYbvTVBIun7
    jVjDO90KmFPQMFv9Ka9dLmQb/yAQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=o+4SYlyE x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=IbFL6i2O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=o+4SYlyE x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=IbFL6i2O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFWN6HY6tegfpHMg/yAgb4Ug+TRo7k0qqKH+KGyLb2TMnp+ZKHVSXpeBKt/sgGGO0cQFYmW61et/qYiV4FmCHNdTNWvSIVP6O2A2v1Xa1xaPVqyqKtUP
    gT+BYWVrCbMdTB6Nx+BYASGqSJqGb/RaVOPXDtg+QkJzCVn//pJhHGcotcCjjzRVii17SqUklxGSGfOxgt23QTAyax16nXEtuY7dDeFLVS5sDR4YAqa5rysn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=W_uslV63yMIA:10 a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=0KjX9oB341Vq9vexk-EA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeERGTx (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 02:19:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44156 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERGTw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 02:19:52 -0400
X-Google-Smtp-Source: AB8JxZrhUyovA4jB7GFms1kcWW07r6YatAVngDA5JsDL80XodHlOug2D9X+WwZAxijpZgiTnVoo6yF89gtZ/AZ1E9Cg=
MIME-Version: 1.0
In-Reply-To: <1169121702.2774727.1526614091337.JavaMail.zimbra@redhat.com>
References: <CAH2r5muobq1gDbGcPE1AYeeKmdFx681=mpCyAZWfSPUa5wLjSQ@mail.gmail.com>
 <1169121702.2774727.1526614091337.JavaMail.zimbra@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 18 May 2018 01:19:30 -0500
Message-ID: <CAH2r5mvW50EzjoU2uXiUC1Z=ShbHpCyYh7GicmwtWOP8cGEXdA@mail.gmail.com>
Subject: Re: [PATCHv2][SMB3] Add kernel trace support
To: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 10:28 PM, Ronnie Sahlberg <lsahlber@redhat.com> wrote:
> Very nice.
>
> Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
>
> Possibly change the output from
> pid=6633 tid=0x0 sid=0x0 cmd=0 mid=0
> to
> cmd=0 mid=0 pid=6633 tid=0x0 sid=0x0
>
> just to make it easier for human-searching. I think the cmd will be useful much more often than pid/tid/sid
> and this would make it easier to look for as all cmd= entries will be aligned to the same column.

My instinct is to preserve the consistency by beginning with the the
fields that will be in 90% of the commands: tree id and session id
(tid and sid), which would cause pid to move after sid or after cmd,
but I would prefer to wait on reordering fields and fixing alignment
till we add another set of tracepoints (e.g. in FreeXid, and in
SMB2_open and in the caller of negprot/sessionsetup) - we should then
have a better idea what formatting would make it slightly more
consistent and readable.
