Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988481-2-6144432298569698667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988480; b=PhXBtmjr8xZH7hNUZOGIkgY8QhlG1aqo4OiCZ7BuPQQ8NOe
    qmkZHjMshQmDLyaWDJYmugnZ4JIzBfAMOD0uzvLk8TriRA+n0dmlfVONGi1kRSz4
    g1rs+QwJwyln5xrxSEeMHZWmU0LOObJNHiV+AbagsvckhrUlsqUg+J9m6EUXbZoD
    0ZtYwQK1iW7kKEN5wpCFcfgLPHm4gu4acu9zufhmvqLiy09umtlX8UYYCu7vrcXU
    b/KB/obPomaKf+z/0W5UudpWJfxQJzSABaSjmhkiDfNTZBEhzqFUGwmCe4Lva5YP
    TCeVmWNFncV4tTTofjWPUwdyIY6lmypRBWeF/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519988480; bh=/tpz7ljJxb+JbX8uvDaOlrnf7n
    sbD1RNtQibOyCjEHI=; b=ntruCV1HrOMz9KFD36Ccl+WzxPEkYrru6HZHcM8e4+
    ZU/++/I6oKfyJbCh6JAGky6+ozFjesvIAFeCJNjnBbiRElFrKpF47oSCqepJHUsq
    NOT8e0FFesz0RWztV5rFSFVIdJH5bCvhgXR2xWLCh7wxL7VH6gmHi7weaf3GCa9J
    +L31NY9kfqttoX+riEd9pOHITeTYblIiyrAH4x3ioiSnS7WqjjgdS8QlD9JSsJEQ
    vsbN9vwy27YETTZXYCeAPSXv5sysClNgeTuL6MBAkM2EvwbUT/VVrYKLWMkhOVyB
    fniMzIaxAjJz4E8Ir0BQYlXlQ1l78Wfz1Y6mwHmb5KdQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=A0ggkV6c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=A0ggkV6c x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426740AbeCBLAs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:00:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423712AbeCBLAp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 06:00:45 -0500
Date: Fri, 2 Mar 2018 14:00:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302110002.wmkvktobi7ssmin5@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302102926.fuqmfyaxiujjwill@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302102926.fuqmfyaxiujjwill@ninjato>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 11:29:26AM +0100, Wolfram Sang wrote:
> On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> > Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> > so do not treat it as an error.  If interrupt 0 was configured, the driver
> > would exit the probe early, before finishing initialization, but with
> > 0-exit status.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: stable@vger.kernel.org
> > Fixes: e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.")
> 
> Please configure git to use 14 digits here.

Wait, when did we decide that 12 wasn't enough?

I just did a `git log | grep Fixes | tee baz | head -n 200` and only on
my git tree tehre were only 2 which used exactly 14 digits.  The
standard is 12.

regards,
dan carpenter
