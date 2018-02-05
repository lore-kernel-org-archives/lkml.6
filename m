Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3708267-1517871727-3-4860059122593901300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517871726; b=b1enKIDfcmYRRFqmjnxUz14hzCatFlfqntlVq05yX0KT7Vk
    1qk3SZ9EUxXaqxhJF2Ju2b5jYxiZkr58AgunFltgSvftYasJ7bFgGSPzRn5w9nio
    ZOkUxhaRSlgst6jHqhstxelqtjn/skxAhiLR10lb3Cz39OZq9LqeB8oOq+2uApw5
    Wd6CRQdMDDOtuQvwDBm9w2jliSmLpHeQ++XHfcxfs6XAMb9QkNNlBaoEYOYppJsD
    TrXf2mJ4Cv/gGP55Pu41SvUILrCd58VfXAjFKZV+IxmwDwzzRx48U6O1Doxc3Aep
    F/NMtXHKFlhAWrqbR9GdBCvZikCxDstazJYZRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517871726; bh=iGosVKkEQxYiJq71p2wL7QDklI
    ntuOyThbxQ3Qc8WmM=; b=PrCrCPvS8LqiVSqyZECJyqRcUhMOR0+9pJO8Uq0R5C
    24ioRTNB7ZC/ylHQWV5jGJ+bpgEi8q7vgLjbEnPfF2BZkYxtytZV0fJYI8hELIbZ
    trk+NkR4vO3bVHX7Ez/Vf2BmwiYbnm3ueNchCRG2a63zowHPijIDAQtYs7I74btT
    qP9oSXfOOZ2mlht8KhgCAg18/36k9EFAqgJ9YN14JiOrvSRWHgTcamKz/9JgS9kH
    hOZbNf2GCE+QEmyYCeKWOHgvFIBSiGwOsAqLlosPkCpHHJmlUX8EsJW0rwa2RRse
    51A9XWinoZEl06ehAdypZH4y0YuIdJFDfEURlJc7L34g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=XnrjjtiN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cmpxchg.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=XnrjjtiN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=x;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=cmpxchg.org header.mx.error=NOERROR header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBEXCC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 18:02:02 -0500
Received: from gum.cmpxchg.org ([85.214.110.215]:45874 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeBEXCB (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Feb 2018 18:02:01 -0500
Date: Mon, 5 Feb 2018 18:02:31 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        Joshua Miller <joshmiller@fb.com>, kernel-team@fb.com,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] bdi: make sure congestion states are clear on free
Message-ID: <20180205230231.GA24824@cmpxchg.org>
References: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202175328.GL1121507@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 09:53:28AM -0800, Tejun Heo wrote:
> FUSE has a bug where it fails to clear congestion states if a
> connection gets aborted while congested, which can leave
> nr_wb_congested[] stuck until reboot causing wait_iff_congested() to
> wait spuriously.
> 
> While the bdi owner, FUSE, is primarily responsible for clearing
> congestion states before destroying bdi_writebacks, bdi layer can
> ensure that congestion states are not leaked beyond bdi_writeback
> lifecycle.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Joshua Miller <joshmiller@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: stable@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
