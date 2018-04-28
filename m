Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352198-1524894639-2-3528252207724595402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524894638; b=azfdrwcHEmllbr+eZ8zozxDtNHed+zBogYQcWO5eVTDseNrrDk
    DkSdjNM1vpTKSOwmR2IOI7Mqmsz2olocNvmKJ2tZW0W96r8pmHDdpBYixOzvpxlH
    Zl8nPJaZKYTNTM84Is3XJVKzKfI4qxn5+VcK0KveThlTS6QRITBx3gCgxWAl/1d6
    EsMbVQLRBu9XCTRl2t9LhZ10bV5uKVsS1vY2Or8Ww7dmUx4rD1LPAEaAOWDhPL7a
    D+pQa/R+7n0ftzD4wk4GSsesqstCgDa+wPr7pjxJkICkOYIRVUY4he6EGXW5dJDh
    oOffg6d1et3g0v8jdi2HXPdR9o/5eNHDAtGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524894638; bh=3fT9nNOXWkR
    vA3Gx1o+q/x6VSRNfzEEil1qAd9j0RGA=; b=h0LvQBO+ewF5GhzKdnYT//QCUH4
    kF3t4hrP1Nr34Xl9jZgUaJLhOopXb2yOfrEEO7gwyvVIe68ysnU9lu7pDWxRGWQ0
    MqyEvP5zgdOyJoRJ29PAu8i+fmBJTwYHaqn54NYcNnRJvMHPuFQrim3GdfdqYkta
    +hgtYGv6+Hk52CxRrWF//9LyTYMODcWzArFsQHTsnIM46fQ1RRLbuMqEaDeC6hLz
    9DUdDF+raEozZ1M/bcUvAhOieHOJCHh+dYk/lwIK5HT4YZ/CKmQmg6dugz5aHKK6
    JNEwajdhuX1h8ZXprJnhZiNjdFURJ0oAthRxdekj7FUGcNNdhXxm5EC0mpw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfATnQRJPzKG0q+uoSssS2/nNJ5o2fvIjpxHoK8K/wpDXHqsahf44WICeLvanIul7xkSb8bRiamwPnCVEDFqB42Kz+GSKIAHTB0r3LSiY2aqrqsoKNnrt
    hVR7jCHrijjVnuwXuDbU+7ureNLqY339YKoW84Nol+alNYr38pwDJ60m3kZmrfZdJCoTaCXyOJGuY+ATjdeSY77CNXd/CLUreM4WoQ/854+vo9dw/1yCnGZ9
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=Lj2UpR8LITnV9XjfiVIA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeD1Fue (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 01:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752134AbeD1Fud (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 01:50:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8DB2195D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sat, 28 Apr 2018 07:50:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        "Hao, Shun" <shun.hao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 4.14 41/80] Revert "microblaze: fix endian handling"
Message-ID: <20180428055021.GA31162@kroah.com>
References: <20180427135732.928644313@linuxfoundation.org>
 <20180427135735.038395432@linuxfoundation.org>
 <20180427162524.GA27698@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427162524.GA27698@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 09:25:24AM -0700, Guenter Roeck wrote:
> On Fri, Apr 27, 2018 at 03:58:34PM +0200, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > This reverts commit ac3d021048be9edb825f0794da5b42f04fefecef which is
> > commit 71e7673dadfdae0605d4c1f66ecb4b045c79fe0f upstream.
> > 
> > kbuild reports that this causes build regressions in 4.14.y, so drop it.
> > 
> 
> I don't know about kbuild, but with this revert applied all Microblaze
> builds fail. There are endless
> 
> warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
> 
> followed by
> 
> lib/find_bit.c:185:15: error: redefinition of ‘find_next_bit_le’
> 
> I have to revert this revert to get successful builds.

Sorry about that, yes, you are right, it needs to be dropped, and I've
now done so and pushed out a -rc2 with that fixed up.

thanks,

greg k-h
