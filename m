Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-684189-1520607169-2-9460662257440714392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520607168; b=H/yH75RlLwPE5DRKVFv46ePWlbDR1X83c3Y/jayLWGA3pVB
    chfHiq62emufOOl5MQQ9fQBOMb3Vm3cYnKvCACuXu8Sd6yWLxPTRZW5WZkohtpdZ
    gbGISc4LC4T03+tqGiFGeok/GYaydMeUGyjppuG2B5bN7VvY0Hcy1pu76hB+veA4
    M2TGuZQ9x0S1nhGSyTogTur63KgVnXyKVjenoL/bkIrlc3PyaJJPax0XlI4H3DLb
    6TYGlohanhoM8q9quu6tZ86M8k+VSou+Xx51eQ5obD7VU/reOG0DmSwHlqSD6os4
    /VeuVS+CnCfQe6Ts5xQLnY7aIUwluN/WaSa5isA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520607168; bh=9swaPKw
    CnmnQeFvfm2ubXyBt0AID+k+9dKG/P1i+vwI=; b=d1jM/dFr3Xt6kBcHhnWB2wY
    u+E6Iog+J5hZCVQNLBv6njcTDw6+ME06FIc6RKEyfeOY6Ks9/gEYFymOg4GmJ3+c
    uuDt7PimVG1/SrO7G5Jkpwkp8amVPn7OZe1dM43+yzZgcZFAbrR85/LBtr8I/jEu
    ixumL95WZricj/eezQlu9vnffAo6Z7/+JDB1KsAHRgGLlLvbEwEeKu+m7DtUsURE
    rcDIEQAvKXC+M1j+ZlmZeOD7X+slwZZy2Shhhmv2S3Amiuq/dUoIYyBx7rZQN72W
    ZSsfsAK4/krY+EdeT3plCSrwNp9rOi6FcrLJLDnGv578zg8twKlFfSr38Jiw4DQ=
    =
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbeCIOwd convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 9 Mar 2018 09:52:33 -0500
Received: from muru.com ([72.249.23.125]:60228 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932464AbeCIOwb (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 09:52:31 -0500
Date: Fri, 9 Mar 2018 06:52:27 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180309145227.GP5799@atomide.com>
References: <20180309023750.108942-1-tony@atomide.com>
 <20180309094417.GA5970@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180309094417.GA5970@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180309 09:45]:
> Hi!
> 
> > Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> > It is used on some Motorola Mapphone series of phones and tablets such
> > as Droid 4.
> ...
> > So it seems that MDM6600 is currently not yet idling even with it's
> > radio turned off, but that's something that is beyond the control of
> > this USB PHY driver. This patch does get us to the point where modem
> > data and GPS are usable with libqmi and ModemManager for example.
> > Voice calls need more audio driver work.
> 
> Thanks for the good work. Looks like I'll need to get droid
> 4... fortunately it is not available in czech republic so I don't get
> excuse to get another toy.
> 
> Oh.. no. It is available in Czech republic. Is Motorola Droid 4 XT894
> the right one? Hmm, and LTE modem is useless in Europe, while the GSM
> one does not work, right?

Yup xt894 is the model number for droid 4.

Regards,

Tony


