Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-500972-1517646013-2-2855741863014820586
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_03_06 1.592,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517646013; b=XFSDE1grKYS7dTpAyvzZaArlz3N/8Nvqz9058372vt474Yg
    I5vwV5h+cmZbCPqEEtmeyQbIgXccysMwJpj6dvfod+RXItGi/mHP1cKfmz+48H8d
    LkNHItSUHScNGqgsXM6oE+zBcxj6YvDXez+jSSWhJRfLKDkTDLlW1lrSMbei3ZoL
    5o6qij5KWRF4bMS0gvnDH8RtpaDqXdp3yCj1xtDgkp2Gafp/eamkzHzvcoNyi2e+
    QK8gHCx42BXKt61N2b2yHps/GytpkvdNzDP3hRKYGKBypSJuE4K4PPqs44SlFSrC
    bSyJ8pZrwTkVgjhWnu+nkaVzRYtdsd32tomTH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517646013; bh=qZlO4sp
    4MBUOnjCZ5K1RBO73+8KNJTKoSOgWjmaBuSI=; b=h938psUWSHMU0OTflERoZMu
    K/Z4CwP5UZMQk5jm0WS0oWR9EQkzEmzRSLk1dx3wDzwHBvUbEsxYg0yNq/igQ0t5
    h0AknLELiBsqfputVgl6zqKlo7fPyrMpX7KOoEn116DzLq2lII4jNW5u23TI9cmr
    fCXLZTFCGnGIQW3oDPzE/guyejdIyLjLD+rSMSWMczXS3h2aqx+KEf9LgHz/hVpY
    Z42cOR4iPk4kcgdEmNNycAPI+dS2RTQcqplgQmR+nxo3MkpnspIFL0qEkG2+uRoD
    l0W1JFdnjaZIgCRI52LtgLsvl9UhHVA9rAOX3ihw3wtx97jOPJr1OeZrrFyHLuw=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBCIUE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 03:20:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbeBCIUB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 03:20:01 -0500
Date: Sat, 3 Feb 2018 06:18:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, ben.hutchings@codethink.co.uk,
        shuahkh@osg.samsung.com, lkft-triage@lists.linaro.org,
        patches@kernelci.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.15 00/55] 4.15.1-stable review
Message-ID: <20180203051824.GC1329@kroah.com>
References: <20180202140826.117602411@linuxfoundation.org>
 <20180203043519.eut367kib3dwbybt@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180203043519.eut367kib3dwbybt@xps>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 10:35:19PM -0600, Dan Rue wrote:
> On Fri, Feb 02, 2018 at 05:58:18PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.1 release.
> > There are 55 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.1-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> 
> Results from Linaro’s test farm.
> 
> No regressions since 4.15 release, but you'll notice high failure counts
> in kselftest. These are because it was the first RC and I ran the tests
> multiple times - first without a skipfile, and then again with a partial
> skipfile. All of the failures look like known issues that we also saw on
> 4.15 release.

Why does kselftest need a "skip list"?  Shouldn't all of the tests that
ship in the kernel tree, pass on that release?  Is anyone looking into
the failures?  That seems like a pretty obvious thing :(

And was anyone testing the -rc releases to catch this before 4.15 came
out?  If not, why not?  I thought you all were testing rc releases
now...

Anyway, thanks for the reports.

thanks,

greg k-h
