Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-733295-1521794561-2-3917796235759437473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521794560; b=ezNqF0jzxTgM9gKQZa+lGXKB2buvWANsQO9sdSjZ9j1KglC
    h5CkUJB5AO5kQu5XhxBGp/GD7VX+SchxmsTcR5K7jfQt5iW1LA49HrFFiEVhD+RN
    xGVkalInkPfiQlwr1eN93ufRRRR1+X2i9O1cgdM9rh24Pq5nKdLLmpz4rwYr/1cQ
    Raue9xQwNEX7WhljkVz4NnTBSC+DyDN5+4vJt5llLfVi2WINZ/QqxdAA5UnT6m1N
    Cm9YeAKLQFLKB0bU/Ea/btZWfiJpbqkWMFva0DRS83/KjoIDCnWiAXHyEK3Kdfmj
    bj63Eg3QfA4RrJU+3OHPfg1Bhvi1K8+brLB8mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521794560; bh=sDSSlaU6a6rO+72ZYydyZ9+m+QbgzfX9m12d4+ZBq5E=; b=D
    zI6azbaZari3fzrdjrwvkMvploASdXgdbq/flwbZlrDdWnKScgWHZF1Stmf6vhYI
    z2hbuL293Kwr+eS79Z1jrI+3Qu66Mx3z7+UKa4MsnzXXIgNtPWLUMtgVIss3PhUZ
    Zz8audDsiSGxwwcihOLZvXF1g6UzqOB7uHzd8KpFY0UulKT/lSgXYekp/zj1zSQb
    /39rngzqln2y9xuzza5b1BZpGFT5PH9Lp87VppuI3GfTq/ZXmqgIfaLTLkabVuUT
    EjujFsF+UoAe1BpcjAg4wB8UaCEMRmW7KuZiTYYHVPrQCJ2Tymfkj0sxKW1520aC
    hE1g4PxtURt/qnho6zqIQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nZ19AFP9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nZ19AFP9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCWImi convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 23 Mar 2018 04:42:38 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33267 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeCWImh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 04:42:37 -0400
X-Google-Smtp-Source: AG47ELtXdP3E4Js12Mo0bYg+HBr0SRY66tLbObqfqV4SC2Dva/w9SVqAf0f/RAQSmBjdw7Jgm4v1HuAlYzQBpKsVel4=
MIME-Version: 1.0
In-Reply-To: <219A03D6-7375-4577-90BA-45DCF2A29289@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com> <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com> <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
 <CAHcwAbSijSmeU3WnznAC+ZaF9iCmYkizqiJNuvLcrYm-YCWxRg@mail.gmail.com> <219A03D6-7375-4577-90BA-45DCF2A29289@vmware.com>
From: Oleksandr Natalenko <oleksandr@redhat.com>
Date: Fri, 23 Mar 2018 09:42:35 +0100
Message-ID: <CAHcwAbQ4y3vWp7p7GayfdbzbomLrqLKMfu0egEoEODJ3LN5qOw@mail.gmail.com>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is off
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "ldu@redhat.com" <ldu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.

On Thu, Mar 22, 2018 at 9:02 PM, Nadav Amit <namit@vmware.com> wrote:
> Actually, rechecking the bug description, I might have rushed. The bug that
> I encountered is related to the vunmap() but it is only caused when batching
> is off, while the bug you reported has batching on.
>
> It seems that your sources support batching but do not include b91f108a3d54
> (“VMware balloon: Treat init like reset”), which I think would have solved
> the problem. I don’t see a mainline kernel that supports batching and does
> not have this patch, so it would be helpful to see the exact module that you
> use.

Correct. The hash is d7568c130d0d0ff1fc5b364fc879b91f108a3d54, actually, though.
Yes, we miss this commit in our code base, but also we've already
provided a test kernel
with this commit included to the customer. Unfortunately, we have no answer yet.

-- 
Best regards,
  Oleksandr Natalenko (post-factum)
  Software Maintenance Engineer
