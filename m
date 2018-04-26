Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2242495-1524730863-2-2699373166910810457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524730862; b=D/plKD5hVyh5mE14E6iODS/Q36kdncToKGG1AS5upRO0jYgniV
    ZEJ4w+fh6XvQ5HKA6dQ4argGm7ZadMbNDgmIDVcRXraltafgB9rr65vzXjCaqO0m
    2Lw6ioivn2iPcG55zf/7fpHQTLeMjXIpRIrbd4KWe0PRxIErV5IjvJxtTGGpAAbb
    cCSgkyxlFHX9SmjNAFpbaJVsETQOHNzcGznc2VRUE0OAUyrGkuyIaAe/5ZaWTO0C
    vGiQ6Iy9hB/mNfW9Gbk8gDbSwxg3qMjaBsdR0Ac6dOlQy1dC0/icea2sexjSx2bR
    qOX/zio5UiWd2hEM16kviGAoaM8VNOXuqCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1524730862; bh=4FVXfKFQz0M7tOq/86oarpKufm6ep7IQTkesZrq
    ZjpU=; b=RFOnVsLX/tJu/Wl1Y+4VHv6h+WI9zgUxxp9Wr/5MzHC4QUcOsnlV0uW
    wlGVkXf5FUcodZ4IbivxHFyBqbK/2hSedklUzCOYU5CKxhoEtH6G5VgjHnQkoHb6
    PbTCiIQWj1v5IoV00aDt0hz4ZaGA1oVAHBn+DNdKYrRv0cY7xObcT7BKlduXoBYR
    yoiwNt5EMqFtJ7L2rQooUT/rY+m4C17rCUfY2tj7irgjuBSSoA/wJWAW3oLjeEAV
    jUGZTMxnSA75u+IWfH2MQWOVlvepbMUo1qxvmuco/vqTBaivCqrHY83ZJ+MFv45x
    zN0SWKuEBUaiPQz3g9bgRInDzC8V1eA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBUSK7CUfwOTxc8NxqJH7CqFwfHo83qVoUMVVhdwNaONCw8oVSF+kE0Uz5ebKXxf4HR52HK9Ko4N8xbcTnv1pi7vXlNDZPSCQqsscvNc+NRoPoVOBo8S
    km9hgxu7mqgXZgRAekWu2k12/7xHaTOKTRJyaR1BhCbqU5CXaMQlliWFbKHKmkLfunKIIgxD1N+4svIlufCBjlXzhHtvumSzil5ELE69J/if4RBZ3wcswhJi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=Asr1jIBIdJoQYT7MSCgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=JZBxSqCIBzwA:10 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDZIUl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 04:20:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33793 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeDZIUe (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Apr 2018 04:20:34 -0400
Date: Thu, 26 Apr 2018 10:20:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        Joey Lee <JLee@suse.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 07/24] hibernate: Disable when the kernel is locked
 down
In-Reply-To: <20180426072646.GA31822@amd>
Message-ID: <nycvar.YFH.7.76.1804261018030.28147@cbobk.fhfr.pm>
References: <20180413202234.GA4484@amd> <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk> <152346392521.4030.5108539377959227838.stgit@warthog.procyon.org.uk> <27926.1524148733@warthog.procyon.org.uk> <20180426072646.GA31822@amd>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 26 Apr 2018, Pavel Machek wrote:

> That's not how the crypto needs to work. Talk to Jiri Kosina, ok?

Yeah, Joey Lee (adding to CC) implemented it here:

	https://lkml.org/lkml/2015/8/11/47

I think there have been more respins, Joey definitely knows more details 
and status quo.

The design is specifically tailored for secure-boot environments though.

-- 
Jiri Kosina
SUSE Labs

