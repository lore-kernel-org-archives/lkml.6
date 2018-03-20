Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646100-1521559837-2-14288459355761070799
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
    t=1521559835; b=UHpe+SXtlPoFoFJccrZGT2CH7Gl9LJ5RfP8rIrRYYsdKEeb
    4RQTexlp1LI9TtmKJc4bmWFTgtIE/WnvXoqjnNgMAbJbsqFMp9ihqgwSvnCMS6rH
    FkR3MvTfPcow6d4HWWmcy3CWIONODb50wKhXqv9a3vLTVe/IfVEXxyljMRxJ3qQ7
    kG8Htaj3+pFb+ihKzsH+JZ/ptOUdHAhPXKFY9t5tmT7E2qF249hFUEQHmwa2PcwB
    qP3qPK+biVmQq44aJCcSeP71JS5/9DNhj9aqyK3frl3XOOhwUMlimw0eSGHLVSQf
    U44EEFydDYQQflY/TZBVdEQctC7ELTBrYbc4rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1521559835; bh=ZVRGR15VvU01CV9SNKMtkC4dCM
    61MOtu+EkhmEUsOPo=; b=hDpNasaCdYmd0W5w622Hv4/S+NNIoNmU0j6HT+4fbm
    VHUK+5EyiWyUfAHLNPa9+DjMSmx54Qm+R8p7TDqV0i+52uAZRfSe5UHy2r2Z93ik
    Aj1SqlJz7q+YsKh60ig/bWbg6U5tKj0kHHqQ/fsKgOoAsY1zKvYcE8ctVinCz9Rj
    83SefNgS/A61O4tNjK6InScRbatW4cPdstEddIXoZd+mDtkJekLGU6SGePBbuHw7
    cuJHz1ZjHRc0VVZ4MV6ej8QinhCJSk/f5OUD0hA15a1uAaISzT2iIBdieq8vHQC5
    QviUNx+EhsxkiC7TMlT4BEpeWauIrhB28l/QDIgrksZg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1751514AbeCTPac (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:30:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750991AbeCTPab (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Mar 2018 11:30:31 -0400
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
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Tue, 20 Mar 2018 11:30:29 -0400
In-Reply-To: <20180320152220.GC23920@lst.de> (Christoph Hellwig's message of
        "Tue, 20 Mar 2018 16:22:20 +0100")
Message-ID: <x49muz2pxwq.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Mon, Mar 19, 2018 at 07:12:41PM -0700, Darrick J. Wong wrote:
>> > Note that unlike many other signal related calls we do not pass a sigmask
>> > size, as that would get us to 7 arguments, which aren't easily supported
>> > by the syscall infrastructure.  It seems a lot less painful to just add a
>> > new syscall variant in the unlikely case we're going to increase the
>> > sigset size.
>> 
>> I'm assuming there's a proposed manpage update for this somewhere? :)
>
> In this commit:
>
> http://git.infradead.org/users/hch/libaio.git/commitdiff/49f77d595210393ce7b125cb00233cf737402f56

BTW, the man pages are shipped in the man-pages package, now.
Christoph, I can forward the change to Michael after this series goes
in.  Just let me know what's easiest for you.

Cheers,
Jeff
