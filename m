Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1601348-1521425621-2-13622491999559597641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ca',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521425620; b=ajWHUfzRDuFpRCHiBikkXPCEzo9qmKDQ1bdKwzNjZZqj6IE
    OeQnBhkobcR7qczAxwghy92vOpMDNTJTQ3MoAbyc6yFSIxDkabecpX7ASi8jan4I
    tNat48Dz/gCmW2PazEwzHwE3lQNd9qr73UY4HetM7EiNNlbzHCofGKG6ztjij6C6
    sh4bNurzHvVJ7QdFNmpS6RmXEuEsOBqhgS2+pQFSP/3dsRjTVXSrq/aQeYtbbzq8
    R7TXTVLtY1hVopjq48cu+BkwjotDK1gqY7YjJoFQKE+0yzY3cKyhHeXaup9RfrZQ
    M+4z6qL87Y8V4m3i0h/a4+q0tK4n6coNmu7ZUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521425620; bh=yZR0g1is8rb0cTA5XtY2Yq/rqf
    ieI+uLBeHV3AgaExs=; b=dGMa6rU5ATyR0pdDVboapOaQSRB6QO7cjCslu27Bda
    gSJf1dyHQCZEm8XrkMAwQGW61oStpl1NXPmBt0J3+Yu/zUPAQLx08B/uLpWIC3Xn
    1cerHw76e9yf2SdIKdsjRx38QKuk89n0S4GG114A3WsgWQCJmxLYUZfRZAuHPEVZ
    6v0L38iv5A9WW9lizq1M4TYcQA3fYhuzKKGGL7pQjv0w7mGfW/b6sENAk1gsR0Ic
    ied/RNalEwilwgZmmRPuQ1uNA/bITYhl7E9PafmsPuTCL8x5bKKr0M5ETixZo6Jt
    XQrV2TUVZnlHOBrstbVodJJUYOTFN1a7zu0deGmdGhTQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=ziepe.ca header.i=@ziepe.ca header.b=aZ5yZyGW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziepe.ca;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YutSMxBl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziepe.ca header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=ziepe.ca header.i=@ziepe.ca header.b=aZ5yZyGW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziepe.ca;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YutSMxBl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziepe.ca header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754783AbeCSCN1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Mar 2018 22:13:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38776 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeCSCNZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Mar 2018 22:13:25 -0400
X-Google-Smtp-Source: AG47ELsYfRTCYWsqKacxrsOeygi2NZni5T4j+b2XZpJANpJWUfy6t8U+TRKDUL0L/lTjgK2Onl7udg==
Date: Sun, 18 Mar 2018 20:13:23 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Sahil Rihan <srihan@fb.com>,
        Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180319021323.GD27186@ziepe.ca>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca>
 <20180316125525.GB5035@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316125525.GB5035@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:55:25PM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 12, 2018 at 09:02:32AM -0600, Jason Gunthorpe wrote:
> > On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> > > TCPA log are can be empty when the TPM is disabled. This commit changes the
> > > behavior of tpm_read_log_acpi() to return successfully in this case.
> > 
> > The commit should explain why we'd want this..
> > 
> > eg Why does it matter to create the extra sysfs files to report an empty
> > log?
> > 
> > Jason
> 
> The initialization of the driver will fail otherwise. Not sure if I
> understand your question.

Well, I mean in the sense of what is broken and why is this the right
fix. Why not return -ENODEV?

Jason
