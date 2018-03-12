Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3600986-1520833585-2-17064421188532321758
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520833584; b=VQ7m6l841323BlZbSL9966vMzElYbbGeqoM666AKEIsNGZs
    qSP8lu3PsUZ0wi8IGeXJxB5TL7dTaFanoIbRvLn48sTbmKeqTAlZCrcwqpk+UheW
    QofEuqWBSTa/rcddKquehnM5/H3zoyjPDAHElvGhTuddL1zOCqvHaaAce2944gIi
    MCSsKcUjEeotjjMbh8Q3QUbDc4b45gmFY9/je2ZFLdXHpa0QG7snj9HVjqhB6nud
    tfkXKyJK9iV/R1oexbDPfv5In1JyZVAZw4GYonr2rxhEu4gxVyCzVv7egxFuCYGr
    2FMn8zczou7dle6VtS7An6QYzFQQxXVutL9lrFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520833584; bh=+
    oBNU+N+WT6pxE56+BvnsnASwK78vBCQLl03PjItmb4=; b=GRVUXflqvQ8FeTdQa
    7fLCCwHH6n4dfzb2uMHQNr/xc13AWCm+v9OIA7/lmKirCZOn7L6QMSfCfoAfmje8
    vv+tJUjtCzMNkc7vTmvKJ4lb6JY1vENVKP0gqSWIq7P/vOLS6anvB4ucOKlHQ9eh
    T8sY+te968SzkUX4IgZd8rA9fXcEaPUHvLDt/zhvhp7Tr24sxPqUKYWjqfOQpFGX
    rgDMtXINWwIr0peyEVfnlsUssAA8HrATTGGsU7sUmNhfP8v4TFBMWotluRu/CyYq
    xwEBF6L+/KtUaXpib+7Z0y7mYvH9Y0UaE9hcsrXps0g9Bv1epZ+tQzJIkb/mF+U2
    EOcNQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hB9jmPp7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=jq6RbYEJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=hB9jmPp7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=jq6RbYEJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:KBSmWpXIdmTcEtrvKYJcBUPO9Vd36kd0pJj6WpKsSXIDSPWAqKS2ng>
Date: Mon, 12 Mar 2018 16:46:13 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] staging: vchiq_arm: Clear VLA warning
Message-ID: <20180312054613.GG8631@eros>
References: <1520818673-14084-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520818673-14084-1-git-send-email-me@tobin.cc>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Tycho Andersen <tycho@tycho.ws>, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 12:37:53PM +1100, Tobin C. Harding wrote:
> The kernel would like to have all stack VLA usage removed[1].  The array
> here is fixed (declared with a const variable) but it appears like a VLA
> to the compiler.  Also, currently we are putting 768 bytes on the
> stack.  This function is only called on the error path so performance is
> not critical, let's just allocate the memory instead of using the
> stack.  This saves stack space and removes the VLA build warning.
> 
> kmalloc a buffer for dumping state instead of using the stack.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---

Drop this please, leaks memory.

thanks,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
