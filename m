Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313562-2-10805822080903774391
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313561; b=m1DWLjoQfJgoe5qbJeEDpETGVxT1XUGQ9JIIW1fRosCcVu8xZc
    NLVSfY6/erQFIvaATyXB/Qk/ebugPmvdWn3HSBFFyW2lfBYSf80tE3/Op3e3M5SA
    j1Sh5egcYCmTH1DvKdgY1rd+ahtQTgs3FwHwXj0nfFeksYJFqpecw5KVDWduEN9r
    dGvh1JIB8/xYjJsnJSAvh4K9+w1dkIALlcrtGh+AjvFikmc5uoTLC+822WTK7ekP
    GR4AhkG5NEm1nW0UT4YZYiBxyMaXlEcFPqjKZaXXpJO40Bj6YQm3PBjzOMwjDaVY
    roBzZWGE54cRqKH6PGo7uMAsbENCqtlkX7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313561; bh=V+X9s
    ORwcfX7NE2XGF6hmUhlG7LRFEqeyzaxJfA0QLU=; b=aITcBh0Pfk92YqMQ7+/du
    fvdGcgOrfJtr5HH6PJjoFtFLgtbPkdlQjRsGtG0o7iYUlYakymsW0fjMKgV4xRxL
    yngepXtf8kJ09P/QjPsX7jfoWcJNHPrzfPML3bUYzTQoKynV5q0PKYziNJ737yvP
    YhRbjbZ3bsPebOMQ50bG51yfUlh3BdWwnskkaSVCrZQWYbfjnZRgNPpR3IPmJhoE
    dLyU7dyoJTcLVaB3gTkVvQWDTojCdm1+PtjOr7IewGZRlfoHK9I1bphS3r7b7MfC
    /B6/PlDiSkRO16JtyM74oB3QYwWmzZps85s5PQ/dYVwVbMZB9aQQy8jKlVBtWjOX
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=2OLnu9O7 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=2OLnu9O7 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGPehQxEfjEQ/HGlp0Ie7Zap6mLUDFLs0dqyz8aqSAZfK+ZgIElkrtqNaC8CHmPhsLYvSzbeGvZ+uIY7IPxDLthBC+ZFaFgB3SRRsDak1hwdRzejMWt8
    rIp5qihwkMnfo1ihZH2ORmv6SQT5sLf9PkVefHSApdPq8n66/tr20b1I8zN2+VUPQ5HPMB3p4/vCmgmaZXzHlewoiInA43yjSOI27/3UWhOiZsOVfEhfzyV4
    JuKXxWjQMQw2JijolcwrmA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=p5PzfHiyweZ2E6kWszwA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 17:58:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH 01/13] Coding style changes to block comments
Message-ID: <20180514155858.GA30973@kroah.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
 <20180514155318.32195-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514155318.32195-2-johnfwhitmore@gmail.com>
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
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
 tglx@linutronix.de, linux-kernel@vger.kernel.org, colin.king@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 04:53:06PM +0100, John Whitmore wrote:
> The file drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c has a lot of
> coding style issues, this will be the first of many small patches which clear
> up some, if not all, of the problems with the file.

This isn't a good changelog comment.  It should explain why you are
doing what you are doing, and maybe what, at the very least.  Saying
something will happen in the future isn't good.

Also your subject line should have the subsystem/driver in it, to make
it more obvious.  Something like:
	Subject: staging: rtl8192u: fix block comments in rtl819x_HTProc.c

There are thousands of good examples of good changelog comments and
subject lines in the email archives, and in the kernel log itself :)

Please fix this up and redo the whole series and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driver
