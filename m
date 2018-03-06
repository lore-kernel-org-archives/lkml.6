Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293838-1520306614-2-9898354479565944172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520306613; b=FnAjr/VEqqYiYS/peGjOOWrTiivUP/LwK44HOqrNkwTdfkL
    jciVcT4Imfc7WwlRork+Li9nmL2S9epNXL8vanCgiotIETZeP1pdX4rxeKbv/JRM
    /0om0OgikJEXo04mMazjJX/Hc9jhW/yDAQZjszkjJQ+zT9yXPr5+stCo/tijY04e
    3hBy9RkMO0FTnXcJWjvkVzU+YhuWVjNlU/9RuV4jT10yZF99tdXg13DOnbJKaIui
    4J8lAbFMbfj+cizMeychXRvhrPyLgHk441k3bgNT2yZ+DECAYD0WInj0sadButPy
    PPAObYBa/YFo6tkL2ZpYOCo9yuZDOhsZRacs46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520306613; bh=rjm7prJIK2wLKeArCxVcC+Pe4oWbca9rYeM9c/NHPoo=; b=P
    svfuIO68TnHFXOPpWeVW/7xJmcIBWfxz2eZjzEjKOxZGFc02Ggyze2mZZpr27J4v
    rpsYM9p+vOXlXs4Px2oS6vl3xomqBZG/Mqy6NBdkJQVE5ZQVifymnS2I1FBQwnxX
    Q4UVO124QCYVmC9RuxBFaHzPtAklYzqYdmuhC73eITDpi1HSze96RdKkB7a1EK1+
    meJ0RkIlaIy9N+pn+KDUWt/t23yX5DTsTo0aIIMsV0qKHIG8Z0yQeAnbmZIUb+CU
    HoD7F02VsG8RYk8cpyaynZ3s/Wo9kEHrjfxRxlYavo200giOtmyI42gqxC+X63i7
    xVAQV4nmoVpuWkf+b4N+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeCFDXb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 22:23:31 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:42806 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeCFDXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 22:23:30 -0500
Message-ID: <1520306605.2786.123.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Date: Tue, 06 Mar 2018 03:23:25 +0000
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Patch #132 (which didn't reach the mailing list) was:

> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 26 Oct 2016 15:55:02 -0700
> Subject: Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
>
> commit ea4348c8462a20e8b1b6455a7145d2b86f8a49b6 upstream.

This appears to introduce a regression, fixed upstream by:

commit 9dd46c02532a6bed6240101ecf4bbc407f8c6adf
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon Feb 13 15:45:59 2017 -0800

    Input: tca8418_keypad - remove double read of key event register

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
