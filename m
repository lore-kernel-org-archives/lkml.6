Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3379410-1519922786-2-1057736885426824225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519922785; b=QWKHp6j1mivq9UYvvHd5gaLEqrrZ+Ct4UQoufcCzR2Zm6ic
    UgvcrdeihcywQ1zR38k6mxQBqYGlgKYPJoF1B8SPnMQigoRaOE+ogUbCrYy64ONh
    lwaDJNbuaEvl+LDVONHz/p3c8l4dzSb/X/XhHa8QvZjeGodenihuLM651fLolvqL
    YSDKiZC8G/FmWUJOwd5VDFPFs1OERZPA/9Fn0Opj8gzwoMT4qxxvPfhoEuA2xj9P
    W+g02KI9iWqNucyXyIeMbOsc5fJi32zEK5RMwbv/TJ3s3GxAIPm4afZNmznygdkt
    8Rg0hCDPka9kD/kRSLtSx3E9zFZXnultGtI48Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519922785; bh=4aXOj+N7utPkKxb2h5yZJOG53+
    66/jrfxl2ZcDno7pE=; b=TZG4kxpuOee03xHnvVqOnkHFv1u5Q6VYQ8g4+mo86v
    xQk9/LgAoXQzivjyeqsRpg2nru0ujnNkpCj6XmJHUUC8ozQe24OwuowOfo0ZmeI2
    ciHLXpTs7aEgHDZW8eVkQS0DCXv7jnqnvRD7b9avIE7a5YaGjwHYtQ4RxOlPPXve
    zs1i2UPra8BflInTV7txgTcy8gAORpahU/gqj7WQDlviMQmUdIh4Bvy2nqnT7CQa
    U4sUjcRX/Fhppe6zu5uiXNDYAcBI59WNnq4K28cpbG1fHND/2RGVbOGm6ixTSLSZ
    u9ByfhKz96SG4jEa64AwDztZcWfhafY0rWzxp9KVGq/w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1poNa6b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1poNa6b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033027AbeCAQqA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 11:46:00 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37497 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033244AbeCAQpo (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 11:45:44 -0500
X-ME-Sender: <xms:Ny6YWgAs4CIteb2cIXK3jqOaOSdQ2hvf7kV1gVanAAdM0FbvTbtypQ>
Date: Thu, 1 Mar 2018 17:45:44 +0100
From: Greg KH <greg@kroah.com>
To: Alex Shi <alex.shi@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
Message-ID: <20180301164544.GA23321@kroah.com>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 08:53:37PM +0800, Alex Shi wrote:
> Hi All,
> 
> Resent without non-upstream patches.

Again, please start numbering these submissions like any other normal
patchset...
