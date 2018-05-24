Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2035870-1527170124-2-3120036135524196464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527170124; b=j5d//na9vywm+oQOY+qsmEyDodqN3FFto0qVng683W5Wo4c/p5
    B3nm5005qDoYAZHyidDpfL3+9P7rAEldzB4Fom79kgi35/4R5qahKXiiNsWmkmqx
    YlWS55hQdHDtqk5zLOkqurHp0MPkP7mQ4RqPn8xQEB3ykXOwaduPVmMofQ9Nf1Ax
    liq69is+CKgflToa6eycfncbZLrDYyqo/f0R4tY/RIBH4qKEcvQoRN3rei0CO9P9
    S3Bs3OTnZP9PWEuGcSm9hE1RbBa94gJnube4QBoCVzeXqw3Z8IT69mjYUjnILBHJ
    HHX1peyGtvVRr6DgG6oSOwXFNH732uoi7hlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527170124; bh=tSsTpYHs4J36ihKYOCn6NMQD9bLPZ8
    YmhhqvgSJxpTw=; b=NRZlgPVTTs6vn0VrajWqHCAGZsRaCubArDx8GyY7vIGVFC
    pqvqXmzG3OTrlBFgl0Wk6QHSIVSMS4SBRg+pUSvWU7zP+lwbgRWfAtyHzmOS4//F
    ifdXMT+qJ2GSKvpklr1mdan4WS2dZMLPtUH/dbDvkFGA1kc9nMwmsQSnUb2mTVM4
    TVsQbIZNHJkQm8kW8o3hWUkIs1ta4dixASeCjl22wfl8vChjLad+ZPuMMR69Qj5/
    1hgli/Mc0eHI4B6KV0F1FE/dr02lHqRNtAw6iTcn2PAuEbwRQdE4YYzlf+sjuLQQ
    vkXfv8bvmSZt/ZH0MomSMvrZv0sIyzLq+DPLDqwA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Y6bcKAbJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=canonical.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Y6bcKAbJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=canonical.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAbcJFMOryK6D/hyZIVQW6ewC7s9LsLbRUoWjR4URCffI3x7eKNZVYTjvRWl+FUwLoQFGMM5Ri2Gc7o8y4BiBV8UMmrsSyC/AGUCF5rNzrXd1dwB0ZIf
    v/EtuMtodjZIp4oQoBCCxaZsKsuOMtfCEwZsFOlHav6wtGEl4tCrpuwya9fuj0FQ5qKszYuT/xIXLHQPuXlDwjJN/gD3PTweC5f4ZinmiAZo1chmsPE6uUhH
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=PtDNVHqPAAAA:8 a=DfNHnWVPAAAA:8 a=OOIgMt4oVuNmGA3Vpt8A:9
    a=CjuIK1q_8ugA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966653AbeEXNzW (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 09:55:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49578 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966509AbeEXNzV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 09:55:21 -0400
X-Google-Smtp-Source: AB8JxZonxU/6I/TmeZpCRXKyl2wmNjObLcRBx1oPZ1z/I+X/HR+IAjlKcHjnuJKJKjGxiG83KXtP2Q==
Date: Thu, 24 May 2018 08:55:17 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 2/6] vfs: Allow userns root to call mknod on
 owned filesystems.
Message-ID: <20180524135517.GQ3401@ubuntu-xps13>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-2-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523232538.4880-2-ebiederm@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 23, 2018 at 06:25:34PM -0500, Eric W. Biederman wrote:
> These filesystems already always set SB_I_NODEV so mknod will not be
> useful for gaining control of any devices no matter their permissions.
> This will allow overlayfs and applications to fakeroot to use device
> nodes to represent things on disk.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

For a normal filesystem this does seem safe enough.

However, I'd also like to see us allow unprivileged mounting for
overlayfs, and there we need to worry about whether this would allow a
mknod in an underlying filesystem which should not be allowed. That
mknod will be subject to this same check in the underlying filesystem
using the credentials of the user that mounted the overaly fs, which
should be sufficient to ensure that the mknod is permitted.

Thus this looks okay to me.

Acked-by: Seth Forshee <seth.forshee@canonical.com>
