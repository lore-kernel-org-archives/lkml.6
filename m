Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-519562-1526289914-2-16145479998370337115
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526289914; b=Y67OeXFfkD/Mv94UfAayTXGUGkZyS942TxEITlo2dafUSC6hTP
    dWS3WCpLDeK72XwoB83rPPjnz/hewH3h9np2ljZlFJpjs0o8vA+TTH7mr3U6mR9L
    /V+VEBbEoDLEFqqkB/a8xuZ2fIdH7l/+Xvhi41IucYQ2a7vJt6PcvWv1GjRb1YSn
    WB7y6dLggaFSeS976uLn3oL0JVTmh2Dppzqhc9+fl/jiKcVlSXQVzodeo0r+k6I4
    6EfL2sC1fKs7jFswHXBl292KdC82oQ+ksuPS05l4IV79DGJHtVAxc3E1c4TUMS1P
    YTU4swIkaaFSzmkNttml4PAvnYq7vyxgPoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526289914; bh=yYVgZ
    Vbr5NTTaqISH/V7su6HpYrtKskiUZksGl3bgb0=; b=JndnoM3D2nd8aEOhed3BK
    ZqPx5XouyTRJM6SMdQBL47HHxKdPpI7JDc+pTrBfYHZnhEQXgP/8Z83unT73ebYW
    XxN/9wybdkgKDFjLxPPgOuvV6lBzYUgSMeGCs+VL8OvRKgSPcflLeOd7W7cyS2Fc
    0HF/h3vQFLk5o6DNiPfk8EePQ7gEVszYtDbgGFbaI/CTFKTGjpj/dMcVy8P/QIA6
    iw7b+DBMKYrrBx3Tw220DCWH1pqS5ufzSlDTdIy1H2bMOFjczMKbfCgqlWcw4RfS
    0cb9joA/Pvc3KjClzzfa9j2EFqlQvSqIdMK+Yqn2mVuK6Il6APoBFlzomkNgHiJp
    A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=SZPMOYo7 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=SZPMOYo7 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLfz4EeFpT4pM/M8dES0gjGmFaJM7CPKgUevYDFl3Eme2nXV5kG6qW8dJ/9nWx8sRj1Eqg3HR8BXxQ/foylInSKJ8MOwNHGBfuBSjkcunGuWrqZbtUZ1
    JDGgxm6ai9UcH24056VAHpekjoIrhnkRftyeYeBuqOhlkyfEimQjFzzSGdCuGd+wWixI8KnGyldkU++4yfD6cWlrWWumdCqkAodVG3JFFdUsvZgN4u97Fuhl
    pnApH5QsvKv8nAHNCRKouA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=rOUgymgbAAAA:8
    a=DDOyTI_5AAAA:8 a=11u7Y-Ddhi02XxGuGZ0A:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=MP9ZtiD8KjrkvI0BhSjB:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 11:24:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] staging: bcm2835-camera: Fix module section mismatch
 warnings.
Message-ID: <20180514092452.GA11384@kroah.com>
References: <20180514074411.21637-1-eric@anholt.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514074411.21637-1-eric@anholt.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 08:44:11AM +0100, Eric Anholt wrote:
> Noticed by Stephen Rothwell in -next.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: 4bebb0312ea9 ("staging/bcm2835-camera: Set ourselves up as a platform driver.")
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Should be:
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

I'll go fix it by hand...

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
