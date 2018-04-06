Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1200889-1523014584-2-14834292926707670863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523014583; b=ApRyVkeMWPBIzlig0Fx+kqIT8y2PDNPvRtfRK2FJT+YyWFIuMc
    zvrKEecg1Ut/9psqEKkvhWgTk1mp/F8xiTly99D8FHQyThglWN5vCZ2SVEb/K2p+
    HunLhYN7+zf/FzPqmFmGkayZ8vviBGSy2WuXm/QnNidg9sSNJ6gFyptXFqiBY+Wh
    TygdTFuy/yDZrKwOrQdNG2oeUTBkcPwhZkBxYmMC3Z0wvqabNynRjsrCPcQMvmDC
    PujLOqQXKFk7wIE+RB8XlOOmlk5zPZsxdnKWUkCHoAhJwNKU9R5jjzGEtjDLq8Kc
    gtnQDRANULQLz5K8dCuD01n+mLGIUcoGkseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523014583;
    bh=sfeyfF1xtHPyS0WcnodkzNHz0ap+oqjYcbcOw7Uagb0=; b=bA5qieTTmmxH
    WILANjB1+hFW0dyKF49IcGUs+QMooYBaRIOrlzaCSISsvwwTehHjfY9AA5aq2UqW
    K3bCuMmFd4NfOnV/N3NXcmZsGq7kwNP5gPPNwHTP5FJ6g8CRzQjd6MU6mnJ9fJJ+
    m0ZdIiuIfDP6ompCMlq5PP1iCloCwdvvBvX/snqzh+x6kbdSFJStPgQwtCs8aLYG
    fCI1gKFlPCEqt7WCriRCKgmUU/5P/MpuOHMvhwl/hK4EkEJY26HJL1ciW8OgMF2q
    ihksSP6x2Zo+K9/tZHR3Eqt+0raVWHgr3Dnmtv4jtw6a2Nb76/yzUPa9HZWmHZZ4
    mXGXBVIZ5Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMIdqaGDHSS0B7u37axY2yCajVtuc56r5MNWtdrhTlaMhqildPy0Gmaccx2Du90SX31pIE6POSd3cll5K5r6FOjvU98WoJ4ddo3MbMRx3ixXPZGpuHZj
    44OnSjX5+vZ3J0IPLEfxIr+3U6pB0++FktJVm5XhFiBoNZrHC3d/ig5Yu6sNIfWy7meRIDM9b5wAE6bnOHc/iDy3GNMkWaYqju2eeLXsMMA+5ucqgKCQkQca
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=lsHB2OPDwKBnqkcg8lYA:9 a=2ewNNs0RZt3LqCdP:21 a=HAGOQ6od6eQ3hwBq:21
    a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDFLgW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 07:36:22 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:54210 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeDFLgV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 6 Apr 2018 07:36:21 -0400
Date: Fri, 6 Apr 2018 12:35:45 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        linux-mm <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] gup: return -EFAULT on access_ok failure
Message-ID: <20180406123545.24953eb4@alans-desktop>
In-Reply-To: <20180405211945-mutt-send-email-mst@kernel.org>
References: <1522431382-4232-1-git-send-email-mst@redhat.com>
        <20180405045231-mutt-send-email-mst@kernel.org>
        <CA+55aFwpe92MzEX2qRHO-MQsa1CP-iz6AmanFqXCV6_EaNKyMg@mail.gmail.com>
        <20180405171009-mutt-send-email-mst@kernel.org>
        <CA+55aFz_mCZQPV6ownt+pYnLFf9O+LUK_J6y4t1GUyWL1NJ2Lg@mail.gmail.com>
        <20180405211945-mutt-send-email-mst@kernel.org>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> so an error on the 1st page gets propagated to the caller,
> and that get_user_pages_unlocked eventually calls __get_user_pages
> so it does return an error sometimes.
> 
> Would it be correct to apply the second part of the patch then
> (pasted below for reference) or should get_user_pages_fast
> and all its callers be changed to return 0 on error instead?

0 isn't an error. As SuS sees it (ie from the userspace end of the pile)

returning the number you asked for means it worked

returning a smaller number means it worked partially and that much was
consumed (or in some cases more and the rest if so was lost - depends
what you are reading/writing)

returning 0 means you read nothing as you were at the end of file

returning an error code means it broke, or you should try again
(EAGAIN/EWOULDBLOCK)

The ugly bit there is the try-again semantics needs to exactly match the
attached poll() behaviour or you get busy loops.

Alan
