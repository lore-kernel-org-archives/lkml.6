Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604752-1520348653-2-14581147770550395934
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520348652; b=mqiPkHnYnGk4CNKpZwnVVjt5nwqhSlUvaY/xlSyRS3CWKhM
    3sPtLf3Ehy9PVZCCh9Mt/au3Y4C59c0wQ2yeChpq/v6wg7EeDlusMXn1HCz1xDHq
    aO/NkxxVVdBAVrSBrAQDeNgZeQwx5eGMt437fsaTQrMH54iJq791wvknuKWvAMUh
    jYiGpNG+m2+tvZo7C4HdT//tLqO5to/mwcRbAd4ety8SknRpgCi3miLBUhJg743V
    /88AWkHKYHpR3vfANFZAwy9r41ZsJgRRv1LuY5dN+eBmfhD9d2ditpsRaw0uBA9a
    a7FL9b1qcUZxMUMx+UGwLEmrZ+00X//v5c9s3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520348652; bh=DQDUbSHe77CreYk/tzjRo6kk3P
    6gk6CNdwe+dh6QX8M=; b=INIs/QLajh2sbsJML8BC7nP/dVe+sKY2jdtoaLjSfv
    SHMCxgOXexaW5gZyXnvgIWI+IOZSmcWcyDUdiXKIOOuhUy8egu10B/DlMiREE1qa
    kOCxQyiV7sQAsWV+SBJBdUhOjcmYq0D96qJXBStjoVKkRRDGJ2zlOI3bK1jGhMtN
    vEfdK4TEaFSirPheWA5dWuVbDeLYdjIZCNBC39cbeZBRi80BiMODCeafkFfUJW/B
    y3e+KaVUuX/9Nn3CBWqT9Eh9KnnXV+2rpJ3IMc6VwMWAFCDn3527viAsv7oUFpfg
    QnnAldRIEX1lZorPcggowrxC2amZrpC0hoTm2DUFH91A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeCFPEJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 10:04:09 -0500
Received: from h2.hallyn.com ([78.46.35.8]:60760 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753785AbeCFPEH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 6 Mar 2018 10:04:07 -0500
Date: Tue, 6 Mar 2018 09:04:05 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, trondmy@primarydata.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com
Subject: Re: [RFC PATCH V1 00/12] audit: implement container id
Message-ID: <20180306150404.GA22472@mail.hallyn.com>
References: <cover.1519930146.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Richard Guy Briggs (rgb@redhat.com):
> Implement audit kernel container ID.
> 
> This patchset is a preliminary RFC based on the proposal document (V3)
> posted:
> 	https://www.redhat.com/archives/linux-audit/2018-January/msg00014.html

Patchset looks good to me.

Acked-by: Serge Hallyn <serge@hallyn.com>

