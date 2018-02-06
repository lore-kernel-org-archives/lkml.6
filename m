Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970300-1517882085-2-6361194837562957396
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FSL_HELO_FAKE 3.2, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517882085; b=haB7QnfWNfwLdrb+iZpHulDeM2Vp5PkbGBpdwdpwDtn6gPJ
    dtyKcfBgigrseOoYjId/W7DxDLFbVKwELag1WntQ4UDjIw1nAZcSo8Lc50YKYDB8
    ucKUEpQ8H0b9HneMwlT3IchsKKSGNEFry0LNxgpXeTP9/75Gaff/FapPcECJxGjM
    4WkxBRzpu2vcuCdvA5S1ZynysWgzIjYKQRyqTbcmSaTbfIAg6hfLTB1M7tpGNKk8
    78jzeSHlOy4VJ+YIfvd8RFtUdHCzUXiwMNtT+Gk931O6ON1/Z7MQ8HUoY3ypBT8L
    2wOLq6zmvhd9eP2CpHYzfDcgjnxmFwrC9leQoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517882085; bh=NeLk3dfgP5qqlJxia4lCNQRoG2
    /4syvd7qwr4Jpl/5Q=; b=iEkx6U21RNFyBHXIB7p2emL88pfE+AM8aKcA2Bp2Xi
    iyxdoWzAz1g2P13Y6TeU2XN/X61Vh82F7spqAmdKZuUpEDAytYcE84zskbW6f10X
    Isi6vaz34v8ovtOwbPwSIu7tte8zF6i4nuOU/r+p/UIj132VeB2xHjmkrmhw4SSy
    BKnyd2XauesbfVFUsq+vkX5lVoDJahcmasti6HMvIsZ/4pi64I6NSYti9ntUSI/G
    9raakaNzKdlRUpesSIThuoWvEClJl66ewu0LN49aZEVmRVeMHAArGk5BU0UfmhS0
    u4xgKLeQNRvEThc+dI61vEN9/KrV70hyl8PIrHp9ZZpg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=XrMyhDIp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T+jDd7Et;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=XrMyhDIp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T+jDd7Et;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeBFByl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 20:54:41 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:52617 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeBFByk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 20:54:40 -0500
X-Google-Smtp-Source: AH8x227pHMlhaROQ+OBOJd+/izY5t1zkO0cv0buK0EwqgkaYdiWlLaU3mNz48nXBqs4VPZzkKiXdow==
Date: Mon, 5 Feb 2018 17:54:35 -0800
From: Eric Biggers <ebiggers@google.com>
To: Jin Qian <jinqian@android.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Safford <safford@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] KEYS: encrypted: fix buffer overread in
 valid_master_desc()
Message-ID: <20180206015435.GA91829@google.com>
References: <20180205200246.12253-1-jinqian@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205200246.12253-1-jinqian@android.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 12:02:46PM -0800, Jin Qian wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> commit 794b4bc292f5d31739d89c0202c54e7dc9bc3add upstream
> 
> With the 'encrypted' key type it was possible for userspace to provide a
> data blob ending with a master key description shorter than expected,
> e.g. 'keyctl add encrypted desc "new x" @s'.  When validating such a
> master key description, validate_master_desc() could read beyond the end
> of the buffer.  Fix this by using strncmp() instead of memcmp().  [Also
> clean up the code to deduplicate some logic.]
> 
> Cc: stable@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: James Morris <james.l.morris@oracle.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 

Hi Jin, see Documentation/stable_kernel_rules.txt -- patches for stable should
be sent To: stable@vger.kernel.org (and generally with a lighter Cc: list,
unless it's a complicated backport), and you need to say which kernel version(s)
it should be applied to.  Also for upstream commits that cherry-pick cleanly,
such as this one, you don't need to send an actual patch but rather just request
that it be applied.  The reason it should be applied is helpful too; in this
case the commit fixes a bug that caused a KASAN warning.

Thanks!

- Eric
