Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3158210-1524580085-2-660550623615854379
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524580085; b=jJO234ZIkDHV9tcSCKlL2b3plhb1mU4iHlNl3hfFK7gRBL6uNc
    M6rqhADsXiPqbQrayJ7Zpv+gm7Ze2F31JI/By9OYl+uA9ZvS5DfQV6bVH72a9MX7
    8DPpN3MpxA8hwTfnxBGMsizdqG8xsvLUstoprHIsNKjESn7aVbMtzAhdkgMnGqiv
    eyeZtx5te7hCpWs95rqxK9e8CHXZkbWQqXwVLO0x5tFSAVAy+0oxB4ZFEUtkabFV
    guJo8oZewca3+5m/2X8Ie15EB8tBbYx2VjVJUN/JdrwyQW81Ne4LInqXfB0pagWg
    cYrwG7pX79z2ssA2miNEP1JBaoVLIcJ/7nMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524580085; bh=EdlGw
    axUMthCEhblwSEnmzQ53O0dDtlIOv7Z8ExeF5Y=; b=SSUgywiHnkLx7AurRnKF9
    dHqjvlQcbhvKdx1EzsxLL08UgKyE8ooFunU3nqCXHuMSTJbIoVVtXuVeap780HhK
    lsg6NFc/fWB0zZwt/LvC37J8RJUd5bwXuKcK5NEWSfI87Fm/+FZERmnmW+uv0ucT
    sjOf05LGO68etDBebUZ+6MZxVJltUq9zgsl0lEmd+DZCMzIwb00LLgiFFQgXweEe
    OgylyDVhQtV2S9uf45q64D40yW4ZxTVLmxl0mj3FfMrEILJAgacL1GJaFub9rEW0
    eg8b4DSM/vDdiBjHL76F9xyd2xJtZTGuGe5IvgC5NtG+YL457bKmMCEoye0ll8cH
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDUXp+l4YBMh3oL0fuE0nQq6fB7C2aRxIbFB0QL7rO87dYWqpUgmweXTIZJryR1vmN8vHBoMWhpgEX0hAjq3ib10F1CWf3TeoFKzTAFe8mZo2eZ25dlA
    UlJ1qIiEYyew1Ep3nIwrUAUtCYk8OkTnasKFuFIm5t9sPMS+ZvsN9zXW3UbcIm05porWL3cV6Kr/e1JYvewebRi/BbuTtNavJaZ8r32ZWJwQilx2XTBOL8lr
    1mQI/csgBb5b+Pip6Ks5EA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=XbdgvRtvtzFr1dunoywA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 24 Apr 2018 16:29:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 02/39] proc: introduce proc_create_seq{,_data}
Message-ID: <20180424142922.GB26554@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-3-hch@lst.de> <20180419184106.GA2066@avx2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419184106.GA2066@avx2>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 09:41:06PM +0300, Alexey Dobriyan wrote:
> Should be oopsable.
> Once proc_create_data() returns, entry is live, ->open can be called.

Ok, switching to opencoding proc_create_data instead.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
