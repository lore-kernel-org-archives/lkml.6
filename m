Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4092842-1520210289-2-10086465211480053941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520210289; b=KpYD3tTQEefPP1a2LjTjpxv/xZQcp1/YjWAKVZLxKFOzFDz
    Xve2rHwPPsh5OvgS/AUoAglDF1ySrhIQxH43eefFvdsFdrEHqehZ++xznFpcXvQC
    w9lYV50MlL+Lz7BbRmluGYz9yclFSiKXDCZq3MswLvffFW+LJUYat7tlyIxEoiGx
    mPaz8a1PWNDSjI9/NBNn6/+2025ZTgvJEtB1wGXGFGMvMsl2A9ilfbzth18/wPAU
    A2rrxDHsCHfZ1W0pubj0O7IwtmUFp2h0cngg0ubrzlMlQrTkw7WHYAQ6/WghKWuk
    acih4vhihsluRgxz3SlbtJ/hH6Nk7mjzWyUr27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520210289; bh=1vTE5AxBg6H9zU37nWhg0bzNA4PzCG8X4kQIaalJ/f4=; b=G
    P5Db9gVyAYc4rHq+qX/cJno4eY7mN9kYDoYxwMHLg/+oz3qwxdvnFVnAZZ3RFpaw
    jx9Q6InKF3RhgC/aa2sIjSn9G2osLFESF4VxArgi/TY1SrLOGKtMDfy8Anoy7RVC
    BjgQ3oI7MwmaaaEMuQms+s4DdIxxymBeqCSIcOWac/ueRamdr3IRQ4ZLPbKS2H+C
    rdcV+fP5iXdP7d0w5IV/pHySZh3JDG6B3yKSMenAX350evWqZhZR0K9QElZFBOXV
    8yUWu8vAMWTMaTapjamv2qhoy0rK/F8lqq3hb0z86nQXyYw9lqP5ibUre/06W/sb
    KgV8AP8GBFS03/G1kHugA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932403AbeCEAiD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 19:38:03 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:49945 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeCEAiD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 19:38:03 -0500
Message-ID: <1520210279.2786.53.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 035/108] dont put symlink bodies in pagecache into
 highmem
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jin Qian <jinqian@google.com>, Jin Qian <jinqian@android.com>
Date: Mon, 05 Mar 2018 00:37:59 +0000
In-Reply-To: <20180215151227.323543261@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
         <20180215151227.323543261@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-15 at 16:16 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> commit 21fc61c73c3903c4c312d0802da01ec2b323d174 upstream.
> 
> kmap() in page_follow_link_light() needed to go - allowing to hold
> an arbitrary number of kmaps for long is a great way to deadlocking
> the system.
> 
> new helper (inode_nohighmem(inode)) needs to be used for pagecache
> symlinks inodes; done for all in-tree cases.  page_follow_link_light()
> instrumented to yell about anything missed.

Except that this backport only updates ext4 and f2fs (and doesn't add
the warning).  I suppose that's all matters for Android, but it would
be nice to get a more complete backport into 4.4-stable...

Ben.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jin Qian <jinqian@google.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[...]

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
