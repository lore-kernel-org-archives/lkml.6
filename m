Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-672836-1520604699-3-6887068970778012204
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
    t=1520604699; b=ptjCNXSwOAmEwfUItJ8+tbOY8fNESXa4pHNxcqLyUaSqY0i
    UTxePST1X7ZnwGLEKGk5gfIRwkSetQw53wBI6BXvpO9wa7Kj8DNtgnpNq4ervYV6
    9scQrKIv6b7uRZU55ZhpYhny38b4q9arBHN4HmYBb12+OwER/7OyNlmg6JSiDYLr
    1ZgIlwQE/sjR9uynGy6m5Zejhlc2g6n171ekp2CEFl8Ju8o1F/kYSGssBlUcGc64
    IHVmdpSGJR//UKLnbQaHtd3hhmI09BhPSoHHcWyd2eAAwFTFJ/9HD6C67+BTmizn
    PpDHGpOXfyRpTB/xTCKbVUhh5qQLUdiVbUVxcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520604699; bh=2ksTy6diyy3C7Pqx7CS05Jr+fr
    6ubNiFw4WUje35QlI=; b=t78niuzSzoK5PDvVzdFNfGjLiBS8M3wN2pBr4M2uu9
    N1Qg0q7FdwAjhLNvS9UFYjAF4VzB+iRNyyPIjxQ5g9/tbQNTQtB21c9QkVphFZRH
    pBWUu/eJWAPX/E2GnP84z6acEMlhvYPUuX//+U5NAsOhmsyDSvrbWmqgCbeIa/MZ
    bPk44Y2lRPYpZwcDwhEg8h5Ed1HxVftvXBDSiAHA+kIBrNd2r2rugloBtnBzzFfL
    4Z6O9Z2bgJageZa5+z7bMcnxLmQ4s5HyjLu/RUxoLs19Kl3cixvNOkhydCfiGJ5S
    VwmUKyq3bNi1K1nD+AA2Xp89dW46bByrQE9u2rIs6mWw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Rrl9DOtv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=Rrl9DOtv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeCIOLe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 09:11:34 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:18307 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbeCIOLc (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 9 Mar 2018 09:11:32 -0500
Date: Fri, 9 Mar 2018 08:11:30 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <ivo.g.dimitrov.75@gmail.com>, <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: musb: Fix external abort in musb_remove on
 omap2430
Message-ID: <20180309141130.GM14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308221949.12054-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180308221949.12054-1-merlijn@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, Mar 08, 2018 at 11:19:48PM +0100, Merlijn Wajer wrote:
> This fixes an oops on unbind / module unload (on the musb omap2430
> platform).
> 
> musb_remove function now calls musb_platform_exit before disabling
> runtime pm.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>

Applied. Thanks.

Regards,
-Bin.
