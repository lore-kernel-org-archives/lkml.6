Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1014489-1524074964-2-12100241210074064408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524074963; b=ec60YuWpzVYzMP9t426DYjwC43k9vZmWkmyxQneD0IbiyY0z0C
    GZtlXK8UX3YteZME/M0IPVImh3NHgzBsWeXlsvTpW01ac89vxpgZg3AiNwzKQ5u2
    A/1UCaZ9YVOAtHTlCD+1Pcinr6dR6++kj+5O/nbCuVnWUEZ66QpGKLlotPZAuEms
    vMXgpQHdEE18SerY5bwizSfUG/YQRdgNZE5XPKuGE1OG6KyreOm6kWIZhmQF9DKy
    YvPmiMx60FKBMBxnbaE5d+gvUP3K1udwX65fGnatYw52ZaUzE2R94vJhAqYDg4qF
    nIRAl35hJ6qoaQ0Y+f18EYI1bY0R7Su7hoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524074963; bh=9HRXpKf1BtrADjNdh8hE1bCH6yfK0X99q5+OSCN8/Z
    M=; b=Yr8uRy0eRW0KvsGDpsHp/TlLpV3mZsaIsrjlVVg5+qODvWr4XfRTGhtTgC
    g3/gyA/9tLzscMrxkw/g86CRXwxlBiQhsgtn2vqKCexsWoGvAGwseskfsqCZ81w5
    R5IQuPCoW+RWNUfZRWXqS7dtpPWRa9qRV4J2iyfEyqX1aLcrFDf/SzN3up3C2nPC
    3qti48vZztNpdi2I1KZEOzDhSMGnQFzxO1/8UZZu3+PmGS2CYbmyGmZNiCXP39UQ
    9/4yymhrtB3v5KW9RmRTIk44xo1OFobUR8oFmqFdQBAFYsQJTT8NSaNP4zu2uMOn
    MEy3fCfj0Km4Ux/pdIP7UGVFbNiQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cwCYU9Yj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RwUIp/F/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rzL9hB2L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cwCYU9Yj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RwUIp/F/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rzL9hB2L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGyAVTSNgeCrKdyBCdWylyIFpJvbX97HT6M9Bp+txiRbyDYMUbOnS5PK5zCQpp8uXmbAzTUKDurvH7y4/ytpPQnll8zy0h0MdV9Oq1KuiSsU8EKBgHPc
    Zj9F0kdKASEk4SO0ef5xPhVyQq/k1r2PY86vYeCV4fzJBZOYiS1CUhrDpbiIyxzgI+ZFzxR+E47SGcMV1obIE9OVQaAndgeah4t0UWcgbcxSsSamGYtyK4+s
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=zvY-6yGpGOWjf7jQIyYA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeDRSJJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 14:09:09 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35434 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeDRSJI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 14:09:08 -0400
X-Google-Smtp-Source: AIpwx4+O4k2oDOa8j6bvWbIWbqYWI/fVvfdNtSpfGbSgU3+7ThL0kev3xPAH/0O42r9WHbObOXQAspU9EUIoY9yPeJ4=
MIME-Version: 1.0
In-Reply-To: <20180418132138.4xzgnwi6k3uojghv@redbean>
References: <20180418071436.21392-1-tmricht@linux.ibm.com> <20180418132138.4xzgnwi6k3uojghv@redbean>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Apr 2018 11:09:07 -0700
X-Google-Sender-Auth: Nndb0AdSz6iDiFdcbtB8kovtwWA
Message-ID: <CA+55aFwkcCQ82GNunmZCiVfJRjX-V-APNbx6d1=OnfNs5tdkYQ@mail.gmail.com>
Subject: Re: [PATCH v3] module: Fix display of wrong module .text address
To: Jessica Yu <jeyu@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        tcharding <me@tobin.cc>, Kees Cook <keescook@chromium.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 6:21 AM, Jessica Yu <jeyu@kernel.org> wrote:
>
> Otherwise I can take this up my tree.

Take it through your tree.

It's not some recent thing that stops people from testing other stuff
(which is when I tend to try to take it directly just to short-circuit
any delays), so it might as well go through the "proper channels".

Thanks,

                Linus
