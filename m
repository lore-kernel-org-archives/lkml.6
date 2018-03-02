Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2196896-1520015048-2-12940298500068029694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520015047; b=uBTrYUppFfCnk+iki1T54/bosA2DlKM0hAq5Kns1BFa+/1u
    zCOBQLopI4TAXoLUe198NhMR/ccuHOsBo56KW/Ix2rC0PSXCHhutcJWotYqPrzNN
    bP5qmJ7Bx4OjE7qR/VcGkBkdNwet/NPDHuMTmG30Exh9nPYuEIUKk3ZYaJIscFGX
    rtnPHeA9uLOuvA5ykS3hhNhVR7XDxKel3VKDKt7WEbHnzXpo4YfzhvUs3/IVK0+j
    VBamJPPVisQEH8cqxHcYK3CknxCLKMU8hIEmwQKWEJLBGuCZ8jKxahnq6QB9GEYP
    tfxQ/0+GS4NW67j+XcZuuCETPs0WtYls5VTT73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520015047; bh=J1Zv7UMWNb+2lHN7AIv+nST+fG
    fmoKK0r42TJUxIIRE=; b=jNKdyizCiXHicU744uP1rNYHO1WN8uDkVEdVhV4Yh3
    ijOcEjYT2auANFsCsQzkFTeSD3zV7r7RsHL5AnsFY9He3VptzKVkUQLjc4TPgB38
    +MGngAR2C9ldEojbKkULUPuzSJEs/bZjUy2KZuaK3CF3G4Im32gQ3VOsmNwnQgUR
    HTEfRg2bihl44oLp+ZAsIJ06xB1ILWsjgoM5KMa4ZqgoQo1yYMZ49dnaPGD2nhoK
    dqZKNFgBrb5yXf+nBfX6JGceib9nQ8ee1h4lV9ApL10GyVj7asEPbUFpThH7Hh9N
    aGyqiKNr2dgXnx29/SjXcpIuyfJh2wejicpDcVDwI9+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=EXsyjtqi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=EXsyjtqi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947213AbeCBSX0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:23:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947195AbeCBSXZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Mar 2018 13:23:25 -0500
Date: Fri, 2 Mar 2018 10:23:21 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, ebiederm@xmission.com,
        simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, luto@kernel.org,
        Eric Paris <eparis@parisplace.org>, trondmy@primarydata.com,
        serge@hallyn.com
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
Message-ID: <20180302182321.GE31400@bombadil.infradead.org>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <20180302014101.jtfd2eeyxmvxcjpf@madcap2.tricolour.ca>
 <CAHC9VhQi2QC8_e1fgYr=bfTACdtpgXZubc6S18r+1+9qf6TJ8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQi2QC8_e1fgYr=bfTACdtpgXZubc6S18r+1+9qf6TJ8w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 10:48:42AM -0500, Paul Moore wrote:
> On Thu, Mar 1, 2018 at 8:41 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-03-01 14:41, Richard Guy Briggs wrote:
> FYI, I think you may have a problem with something in your outgoing
> mail path; I didn't receive the original patchset you are referencing
> and it doesn't appear in the mail archive either.

I have those patches.  Which mail archive is missing them?
