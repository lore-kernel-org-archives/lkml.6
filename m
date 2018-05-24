Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2656378-1527201051-2-7511250096357577992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527201051; b=H2O6Y8Guic1ubyd3TlI4B7CvrtJpGy+kOrelK6nYwhOGwjME9i
    O01NNpcJOPLxZs4kfksuOxGMmFexWPtzHeIbjp8s5jh6qXG88o8FlFFlUjLHXwdf
    RzD2t4BMIuePo/AB2vgffHJlRFsQCa/xcsEBbvU8jSSyzIY6zFxxMZAPx1sk1iaO
    7+y7p8JTm5Ju+9qx2rjN+JBPIgT+mSRoFRXzgF2e0gLijkoKMUbe//AIzzWjq5vo
    Vq9WQNLgdhzDKd53GbkCJQR/RGjldOr4mwlyZ4MJCinznmHVytXZPaC58s9sWsEv
    TeCCeMHN4oCXhm1JSih/xZpfikNXcU5w+I7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527201051; bh=XoSldGDKIhwnfaoTjnqIqc+wRnIMU1
    M+bil0D6KmDL0=; b=BQOkjv6W/IQH+43944crM5+hQWlehdA3dl5wNYUglZrlQV
    WN9GL8zw5PgbP5YIdQbzri+2jDB3Lkgep+L9Aqz+9MJ8ozuWbebi4hGdLQ/b4e06
    u8evaVxbZ+Ei0y8ySUOrlQ5BmMHm1Yx3BbMdLlF4TSfUfn5hVgY20F65aektfWF9
    yPPGYRRHkmLxBafDEfzYpwmK1/Ytfx/PSIB6pIygsQD2R+M8b1CHORcPxvA2Efs+
    Sx5QtrK3shgsU1PIb2GsYq63QKU66mxB2JzDck18I/IlQJda3FWYPFh5GaQJBWiY
    Y63kcxXPo2xkdZjr7+w3h4Xyyza2cAgOv0u3pMfQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brauner.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=brauner.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brauner.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=brauner.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAAbinwpKrB2D+DZkP++kEFDjr1NQTfGOhUCJ/3V6+U9R543YVGKmW4GUa4iWwR78luMqBVuXc22LUfbBRHsqdquaW2Qk4+xeL32sAAvHlYV5lcIDAPu
    rZaH/bPG1/yCn+aPQRo8r5OufVDdPm8rPEmbszk8vw6qxt1R8uVBPMVJhCHFWvIdza+kb4ccwVGKQ7CFirJWFPySOSUQUFSJ2523ezkoNNIROkbotwki7w/w
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PtDNVHqPAAAA:8 a=DfNHnWVPAAAA:8 a=1Yz-86lCXWLZWnNqPJUA:9 a=QEXdDO2ut3YA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034770AbeEXWaq (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 18:30:46 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:40418 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966192AbeEXWap (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 18:30:45 -0400
Date: Fri, 25 May 2018 00:30:41 +0200
From: Christian Brauner <christian@brauner.io>
To: Seth Forshee <seth.forshee@canonical.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [REVIEW][PATCH 1/6] vfs: Don't allow changing the link count of
 an inode with an invalid uid or gid
Message-ID: <20180524223040.GB17493@mailbox.org>
References: <87o9h6554f.fsf@xmission.com>
 <20180523232538.4880-1-ebiederm@xmission.com>
 <20180524125832.GP3401@ubuntu-xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524125832.GP3401@ubuntu-xps13>
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 07:58:32AM -0500, Seth Forshee wrote:
> On Wed, May 23, 2018 at 06:25:33PM -0500, Eric W. Biederman wrote:
> > Changing the link count of an inode via unlink or link will cause a
> > write back of that inode.  If the uids or gids are invalid (aka not known
> > to the kernel) writing the inode back may change the uid or gid in the
> > filesystem.   To prevent possible filesystem and to avoid the need for
> > filesystem maintainers to worry about it don't allow operations on
> > inodes with an invalid uid or gid.
> > 
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Acked-by: Seth Forshee <seth.forshee@canonical.com>

Acked-by: Christian Brauner <christian@brauner.io>
