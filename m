Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2870489-1520293558-2-9213747371577945024
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
    t=1520293557; b=CKH6N45gvAzcUEyCx8yqjZK+/W38DHq2Wu7egqww/3x3ZYw
    BGjqqMNTw0DjUBu56RbWgS3baUSjuhNAHgOu+5EQth4az+WjwNNzVJzfWD+bgloK
    DT4OSnajF7NOKXuWlqPThDmg5StGA6Jjtq10gQ9rRUiPUur8L1FH1pXEuMYaXQuX
    YX3aebTABKg0DyzNpoIFOfid+Stl1ghT7LmgHklQ4e1T4bmz0lW1jPEOSJn2lKZA
    ExTnR8+gFJIUqOXP9lM8cyOGwJEzkPo8BCiEIwLbBEPDzZmJUzAa4n4XSob9EEap
    0W1XZt8Dqv/4htK6TpA+pFnhw0Quf5gShofB9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520293557; bh=6m5m5VgjSSxLz5GqN8d/8eWHK4JY/3bt1E2Ugy+le+s=; b=O
    pBhZgHsrxgzPLE3yaGuBzGcqBDgYKc9/HJDlQuff7Q5caWu/Y92iTPTtRh+cqFAM
    EjC2Zw/tadh/hvD4+gqWS5+quU3JtzXPC/ABSDJLRFOIWVJFWZApjI4DeosN6qrt
    fB8zQtQIHQasRj+DiTVsWgvCVE+GeqFaL1mKTkOhGJD/Sz+tZGRXuBYnZ6zIXExJ
    70qdoj1j8P0KGiSTljuozMkhC2sY7e4dkOytaGzulaJTg+1Fn+0p/k7ZN0JFVtIi
    O5xzpS+a0lxc2rebbGRKXE6j9L8LjaPjeldn3mAvVrieQ3CaigaQEY5RS2hWt03+
    X9rJFOIfMEkxPWVYKWcgQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932287AbeCEXpz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 18:45:55 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:41689 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCEXpy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 18:45:54 -0500
Message-ID: <1520293551.2786.101.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 031/193] ARM: OMAP2+: Fix SRAM virt to phys
 translation for save_secure_ram_context
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Mon, 05 Mar 2018 23:45:51 +0000
In-Reply-To: <20180223170330.941688300@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
         <20180223170330.941688300@linuxfoundation.org>
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

On Fri, 2018-02-23 at 19:24 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Tony Lindgren <tony@atomide.com>
> 
> 
> [ Upstream commit d09220a887f70368afa79e850c95e74890c0a32d ]
[...]

This apparently breaks the build for some configurations.  Fixed by:

commit 863204cfdae98626a92535ac928ad79f4d6b74ff
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Dec 6 14:17:17 2017 +0100

    ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
