Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389629-1522788564-2-13008641099554716830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522788563; b=sskKlQ4X75HfHKYgNNp36mVr/Rqkbj7td2NN7PwbSwilYOycF1
    sfOt9Fq30uNVFWdUfvXXs/8Fl8vCiSHJjxGOIRkGDJ8kK78DjRAKEn2As80RPjxj
    ltRhHPjkZbbW3FLZsHtcFVLJqoUYiVYxNvkOWLDYAgEGUfZmV6rX8nr+lHfMKyGS
    GBTgOVA7dMTGs/BeC2b98pBlorP/SAPAzmdSZC7KqpErH0XApkcGtFDJRpWTqioN
    8dtX2Crc6QBhwdDPiLrJZzVa9g3xnpqtX/niS30KSxbx4Tk7PzYNFVQUHuFfCDwb
    DKlwXvDNcjrezivd//k69SYQTPu2ZZ/o4Oag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522788563;
    bh=Ul/SesffAPT9fBfFhUgXsi5ux/V+7wDTUH8fP7GlK8w=; b=Vfgz+Ey73PzG
    0Mtr+yxCkxsF4X5iBzjA5iDgSPNZCWbkA0+BPPbGnMvKbvo9GTzlQzKFDgxIb75w
    FVFd6CGzscHqHgDzWl6ADxNBCqu3BGz6UwT8JVRbQuS3vH8xZwt71l+WK7o9Uj3V
    fOLLU1yzfVORWqST2bAM/cRzfu22kYuk0bbpp17ufMTpEhUfP4k4U/GIHOLNDSis
    /DbzDLWUusDDOI7r0t+mxX5fdW7KrN+tcad/4iWVc2r+aWWYfepXDgBbPnoroe8K
    XGtAcocspaaNill8zoGaTAOrqkBugNZUJo/hSEi4/RGdQE/07g9XR9a/sOaEbWls
    dFGxx4KDZA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK3pbrWDnW/Bj8m2xSzKzmfli9zSjIF+MpwLFRDxlXJFgNFqj8vqC6fixKvLaBJuuPlBTGj5cBR+dufeysp3UvgbSESG72C0pDoPyYcClaF0s5J8QETx
    k5Y8D9pJtkrPbjG96w0MnXC6wPD0EeH6K1x0qctt6WUL5mgnmII5fPHK9a+CyeAG0b0DXA8F9q7/vfYr1AOuvjDwLTWvQbM2OQgm/2ZRMb3381huu7mKahCH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=vuD7zweAyiCsswxBm9cA:9 a=QEXdDO2ut3YA:10
    a=aeg5Gbbo78KNqacMgKqU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbeDCUtV (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 16:49:21 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33447 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeDCUtU (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 16:49:20 -0400
Message-ID: <1522788554.2654.127.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 51/97] mfd: palmas: Reset the POWERHOLD mux during
 power off
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 03 Apr 2018 21:49:14 +0100
In-Reply-To: <20180323094200.471499547@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094200.471499547@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Keerthy <j-keerthy@ti.com>
> 
> 
> [ Upstream commit 85fdaf8eb9bbec1f0f8a52fd5d85659d60738816 ]
> 
> POWERHOLD signal has higher priority  over the DEV_ON bit.
> So power off will not happen if the POWERHOLD is held high.
> Hence reset the MUX to GPIO_7 mode to release the POWERHOLD
> and the DEV_ON bit to take effect to power off the PMIC.
> 
> PMIC Power off happens in dire situations like thermal shutdown
> so irrespective of the POWERHOLD setting go ahead and turn off
> the powerhold.  Currently poweroff is broken on boards that have
> powerhold enabled. This fixes poweroff on those boards.
[...]

This is not very useful by itself; I think you should pick these too:

[3.18]
0ea66f76ba17 Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
7c62de5f3fc9 ARM: dts: dra7: Add power hold and power controller properties to palmas

[4.4]
0ea66f76ba17 Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
1f166499ce00 ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
- apply the changes in am57xx-beagle-x15.dts
7c62de5f3fc9 ARM: dts: dra7: Add power hold and power controller properties to palmas

[4.9]
0ea66f76ba17 Documentation: pinctrl: palmas: Add ti,palmas-powerhold-override property definition
1f166499ce00 ARM: dts: am57xx-beagle-x15-common: Add overide powerhold property
8804755bfb1f ARM: dts: am57xx-idk-common: Add overide powerhold
property
7c62de5f3fc9 ARM: dts: dra7: Add power hold and power controller properties to palmas

None of the above are needed for 4.14 and 4.15, but they do have one
more board that needed this property, so please pick this:

aac4619d028e ARM: dts: DRA76-EVM: Set powerhold property for tps65917

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
