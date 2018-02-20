Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757788-1519127807-2-17216220755273059986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127807; b=nefSHln1jjtEz4CNsch9QJtAwvz450dCo2g+F8/zqJvpGCG
    Dlvo8xSlHG8nQqvS2vAUl28Q5AdFdH1rpF4u8Yx6S9ISJzIq0XUirED6rR/ILmLW
    IapjZe033qKuZCPErWwQ5RG2R2cZ6/RAUqCzPiUwFaMFQQXiqyCubLXzY4u75esj
    fpUGYE6NHfk4fb50FqmcEMGXmTr+TmWhr52N0T6gYP1V0CpNcZqBmQDiraPHsw+L
    cU2m1BRKmvpocB1EzthkuA7BDG15NtbteKscy8uQILDw2kz+kqtpWJqcT/cB1AfR
    e/5wYVFyGgNKTuV23SSKYK7gYt1sod6se/DWvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    arctest; t=1519127807; bh=lzWcb+H6RvluGEawnCK3fxCX9qTSooqqeHxN0k
    z4AyQ=; b=uxhCjsoNOujGlTgPxfclL79Y/9c/jlstEj5UsMiNokjM/y71eJbp0N
    Q3C1BN9Q1IvruMw2ZgVQYHWUzjO2jo6BguokT8QHw3LX0AwlhQHFehjdpoQwXi/T
    Ta91BjiJeOG5C9Fjb4lETyN0htpWdRjCX3gyp6hE+bGU+e72dL35uBULc+GGTTaW
    hUcod7vkJjnSwW/65Vc6auh9zuDGxzdd0XfWTE2HgozjJLUgtXh6jv6tk8S90X54
    oIGaS7Dp8lDcOdjB6wcr8HJidfoLN4DnBJjUtVpML8K2Nnhf7+6cpuvt7bbqtBgH
    R+Uo+V3KnE1rT/QHv5Ion4sYr3aFS3pQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeBTL4d (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:56:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:34314 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeBTL4c (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 20 Feb 2018 06:56:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,539,1511856000";
   d="scan'208";a="202406582"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Richard Leitner <dev@g0hl1n.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux@roeck-us.net, mathias.nyman@linux.intel.com,
        johan@kernel.org, ekorenevsky@gmail.com, peter.chen@nxp.com,
        drake@endlessm.com, joe@perches.com,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2] usb: core: introduce per-port over-current counters
In-Reply-To: <20180220115033.29496-1-dev@g0hl1n.net>
References: <20180220115033.29496-1-dev@g0hl1n.net>
Date: Tue, 20 Feb 2018 13:55:54 +0200
Message-ID: <87k1v7q3hx.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi,

Richard Leitner <dev@g0hl1n.net> writes:
> From: Richard Leitner <richard.leitner@skidata.com>
>
> For some userspace applications information on the number of
> over-current conditions at specific USB hub ports is relevant.
>
> In our case we have a series of USB hardware (using the cp210x driver)
> which communicates using a proprietary protocol. These devices sometimes
> trigger an over-current situation on some hubs. In case of such an
> over-current situation the USB devices offer an interface for reducing
> the max used power. As these conditions are quite rare and imply
> performance reductions of the device we don't want to reduce the max
> power always.
>
> Therefore give user-space applications the possibility to react
> adequately by introducing an over_current_counter in the usb port struct
> which is exported via sysfs.

why don't you just provide more than one configuration with several
bMaxPower fields? Then host OS should choose correct configuration based
on power budget.

-- 
balbi
