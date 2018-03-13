Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3907840-1520971919-2-9551678481022019409
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520971919; b=R7H72JiKp7vFAuuImcp7DK5ekcNC7cFPJoAJ2t8ht7XDPxG
    25P8VFfvZst/D5wNPBc6AEUtEZfvNQ/zo7sIpgmQylQqMFs1nwN5NuNU2OBJEK81
    lPHYWcdnrn/qkNcjsixpEJ8HqijurF+kEXecHjnQAoHrdmUl9ijVOGD4bJHvSySs
    hzBzaxyYL87+XLqTuUM4z40Qw49PtimyD28TSVK5YVk9skTWWUCs62GQiEwXoJEC
    fJV/6Hwmr2JuSIkOnuXLlQG777whEWigkft/hXWU50p++tJEXsflEdkHBpZy8At2
    3ouODTLEhzbIIgy+mGcFva7/Ccd8EuJqULGxtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520971919; bh=egjo6KQYDvuxalBrlTvU8pYUBa
    07FJ25vdLHlfI5No8=; b=LWpzVCUp0+MbvIp1CrGzKQdK2cqna9Tt/apavE/Ppk
    tld5K0qnNh/5mUcnpB6Q7J3RyVjz3kta67iW0OnVBDaeZT+VofdHvxY5n6HgYaPe
    r2YG7IWNVyUX9j6rnEh9FNTh+0Aik9KMEaPaY953UAVkvGEN0xsOBov3WvPgwTsJ
    OBKLSZ2XBr5Hw/BBNZ6dasE7Ss1Q3xaNLXUH7LTsu8728idQDIHPz6xRRJwnHWZr
    PmLqbrbagDgHkU7hSqPzoJVq1REB3d37+BqPPl+fqJMciY5rl15/+bs30YVjVeVS
    Loz9jxHQ8iThi4HkWJXL8j49GCzUA8EWEwGEfXKnfsyw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XtHjetNE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XtHjetNE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932468AbeCMULm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 16:11:42 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:43961 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbeCMULl (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 13 Mar 2018 16:11:41 -0400
Date: Tue, 13 Mar 2018 15:11:39 -0500
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <ivo.g.dimitrov.75@gmail.com>, <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
Message-ID: <20180313201139.GN14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308221949.12054-1-merlijn@wizzup.org>
 <20180309141130.GM14921@uda0271908>
 <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b163041c-02d5-56c0-8f46-139b564a7280@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Mon, Mar 12, 2018 at 11:30:39PM +0100, Merlijn Wajer wrote:
> Hi Bin,
> 
> On 09/03/18 15:11, Bin Liu wrote:
> > Hi,
> > 
> > On Thu, Mar 08, 2018 at 11:19:48PM +0100, Merlijn Wajer wrote:
> >> This fixes an oops on unbind / module unload (on the musb omap2430
> >> platform).
> >>
> >> musb_remove function now calls musb_platform_exit before disabling
> >> runtime pm.
> >>
> >> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> > 
> > Applied. Thanks.
> 
> Thank you. Is there any chance that this patch and the vbus patch could
> end up in the 4.16-rc series? I was waiting for another rc to see if the
> vbus patch would land, but it didn't land with 4.16-rc5.

Those two patches are already in the upstream tree, hopefully they will
be in the v4.16-rc.

Regards,
-Bin.
