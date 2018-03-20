Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646100-1521560067-2-1442271058315697205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521560066; b=ptMAbUJgwH8ZHMM+4xbKayL5DiqDW9Jm6T9RIbyp6WAlRTw
    G6HkuN9E2bBSe5HYBQQrqsPd+o8obyo1QA+QgTclXVOfwyJyDhxsZBDYz4v782IS
    r1MhZp20szZw+EiYifxvVGf4Y6kk0++0sOdG7iQ6hWWRa+96FDK1geCYuHl6fq/R
    az1FXGAFMt8mic/yFe0qJ4AILhFZuUxhCuWfJXiizhdt0+nTdVQh6ZDQgOWuuzVe
    i/IaDhzjfrMndJ3H5jHw32AdyxbgrSvjEIZPforu0FgxfdOGG5E4r35bqORQHRil
    PjwvpbQ6N8/9/0qq64CQnJydzX4HF58yJhmAjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1521560066; bh=3FlC2o4maSgITpsBcg+e3RJWDa
    kQctx+FBA2TFX4Zck=; b=EH/6yR5LkX6/PPUeOAA98ft7Z4n6wQeGoaC0xgO5Fk
    zxFBQnlnEmeWskFwqEOtXkrbkS6Cd8BaOK7jskWO6hbUZJUV3+6fBnAXQqW2vlXz
    QOgNFDbmFRFX8pxusHgjCZd0Fg0JSE749DuPyeta3llGcsvnA1RItFQNg6aoZf6T
    E+eDW2tOa+IUDy3yYcILy3A2HBjaCk+piMu/0qtwRUkjWBah6wb92vpFFBQilkPj
    +Aqkw0P+ZagKGnA9J/JUi3AQtIzugWwgCpHbF2prd80rB0rkvyLETwuCAPwUEuJN
    W48laZVupRpY/k8TNtBs0qRHNO+j3UuweKKKN9tjaG6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeCTPeY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:34:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751186AbeCTPeX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 11:34:23 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
        viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/36] aio: implement io_pgetevents
References: <20180305212743.16664-1-hch@lst.de>
        <20180305212743.16664-9-hch@lst.de> <20180320021241.GE7282@magnolia>
        <20180320152220.GC23920@lst.de>
        <x49muz2pxwq.fsf@segfault.boston.devel.redhat.com>
        <20180320153145.GA24313@lst.de>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Tue, 20 Mar 2018 11:34:22 -0400
In-Reply-To: <20180320153145.GA24313@lst.de> (Christoph Hellwig's message of
        "Tue, 20 Mar 2018 16:31:45 +0100")
Message-ID: <x49efkepxq9.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Mar 20, 2018 at 11:30:29AM -0400, Jeff Moyer wrote:
>> > In this commit:
>> >
>> > http://git.infradead.org/users/hch/libaio.git/commitdiff/49f77d595210393ce7b125cb00233cf737402f56
>> 
>> BTW, the man pages are shipped in the man-pages package, now.
>> Christoph, I can forward the change to Michael after this series goes
>> in.  Just let me know what's easiest for you.
>
> I'd be more than happy to send patch to Michael if we get these
> patches merged finally :)

hahaha, least of your problems, I know.  :)
