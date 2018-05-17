Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2607644-1526584456-2-8830726772455634339
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526584456; b=WN5xs3pCbwGHMtQRpgDzImqtLAaB2CqBy8A9ucqLUzMmMD84o3
    kl9bOOiHMgp119UWgury02uW84v1GVzVpFyq6X1JZLhaQTtPexxIq+bDz+Sb0yke
    rUnoklozUqNX9cvKfeHIaFyOns5iOLsgojTUOOirjFebwOgOc9N9I3Cc0688jT21
    SEmqvNjN2iPPXin6wMXU9LlQdVRYzC5NOOEWdMRQZrkGmKUwwKbKOJbtmqWTZ0mj
    MQkK1pwmf6VJKxvf7nX0YABxZI3PL7/kUCpY73ZycdhFaLHfaWA3sHkM3WTDQbLN
    r92uCotGqxP1dhqTg3TgsWlI0/KPhQaSXb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1526584456; bh=jw/RCShRXBsKdHs2Wc3iZDy/rYOz9V05KYOmEf851qI=; b=J
    LqnxaHrG+Wzfw4BolEQRqx9pwyQVe5TbEFR8E3ewmlNnx0WUoP9P9fqoePJgGgV6
    Krc80Dbdmesaa8O+qtKm+WaZorWevsuNM8BuIj9VrSXL978PXNjelqNhGvEmdcVO
    aarthLqBntugSpjaxyFs5EGRr9VYAgyjLYfmkIrZ3b7t5qYPQx4/v7/D+89Jk943
    TMieVWbsp2j+VPLNeSmLuPXvxbZWeq9LMwGy2LikE0YjhiVmTvyDTUpsR06iz/RZ
    juNm2LUtRr7PDOE99jZvof8Qw1bVuLZUi+25uwDyrZ2q1cvL5jkcMkNwLuaT6UnM
    yjvx/KBRGx2u3ed6Wo8hg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rowland.harvard.edu header.result=pass
    header_org.domain=harvard.edu header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rowland.harvard.edu header.result=pass
      header_org.domain=harvard.edu header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCALmkYtX/ut8SdOCjiSGjzO2edZ4L3m/JH9DfQabvTnrK7E27yc76ShG1EpOIhFLUtbbmpdyjOFh7K3Adr8E+hMRVYgiQvV7Iu9quhWo6/z10BwY0Zl
    A/iTEdCWGzuptzVL8OuERURdr6tqVelBcoT8cX7vM4UtZP0PvDJl19/jF7prOLuLmWSERUTqVsAfrYrxyMsDeAIlMaj2p+5jRSkpYBgk/XtIxN7SHlZQO1N2
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=YtXVRFaMSTuayVte8NMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEQTN7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 15:13:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45170 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751671AbeEQTN5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 17 May 2018 15:13:57 -0400
Date: Thu, 17 May 2018 15:13:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alexander Kappner <agk@godking.net>
cc: Oliver Neukum <oneukum@suse.com>, <gregkh@linuxfoundation.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb-storage: Add quirks to make G-Technology "G-Drive"
 work
In-Reply-To: <7dc7ea60-81b5-3546-5a12-9b0ff0b734cb@godking.net>
Message-ID: <Pine.LNX.4.44L0.1805171507420.1294-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 17 May 2018, Alexander Kappner wrote:

> Oliver and Alan,
> 
> thank for investigating.
> 
> > this is suspicious. You do not actually whether US_FL_NO_WP_DETECT
> > by itself would make the device work. Can you please test that?
> 
> US_FL_NO_WP_DETECT without US_FL_IGNORE_UAS does not make a difference, 
> even with the patch you included applied:

Are you certain Oliver's new code was executed?  If you put 
US_FL_NO_WP_DETECT only in unusual_devs.h and not in ususual_uas.h then 
it would not affect the uas driver.

> > That's bizarre too.  Even though the only difference is a MODE SENSE 
> > command, the command that actually faliled was WRITE(16).
> It looks to me like the MODE SENSE simply hangs the drive, so anything 
> issued after that will fail. Of course the drive says it's the "current 
> command" that caused the failure, but I wouldn't give too much credence to 
> that. FYI -- this device is a consumer grade rotational drive that you can 
> get for less than $200, so I wouldn't be surprised if the implementations 
> have issues. 
> 
> Also, I noticed that copying onto the drive with dd works fine, whereas 
> trying to mount a filesystem immediately crashes it. I suspect this is 
> because check_disk_change is called on mount (which eventually calls down 
> to sd_read_write_protect_flag, which is where the US_FL_NO_WP_DETECT flag 
> comes into play).

Was this tested with uas or usb-storage?

Alan Stern

