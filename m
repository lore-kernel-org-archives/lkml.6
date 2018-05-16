Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134448-1526457792-2-15230187376285958270
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526457791; b=iuSuvUNQB3h+eJskZWMs0C3kdZNgf9Pu8Co2EpAO51hk04Ajcj
    Wfk7PO1IOMkzvkdKMCMOX/KEWxe474KXJ0FUQAeojltqGssuPIX2W/knbGJvxTCc
    aTTyEx0UVQus1VgiVWIiV1iIZFUSfZz50btCgzwnCfzWvA43S8fN1glWg8xtRX80
    PR6l+Te+CXvlARLSehy17nsOy1fCFV0bS0K1vDIQYSG18Sw2fz0tsF9xi7XvOITl
    eWxRsEIxDHlZzV4OkrmyP+EOaKiKAY35Cfjg2VIS0xbpzLMD1tzHGtjG0jE9rqvu
    kCmGL7oy7Bl/omu1ejmZf9UbMGfLKGoTnBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526457791; bh=tG7yHtzL91O
    LRGOdpFWLUqEDl0amChM1rxVSAvFY3jM=; b=TzKJ1f0PiM3YO3OPRII1GnaMTca
    sFZZBd8otHuI+T8aV9lUo5BYxiiOB+G1DqtOy0qB+8Ws92ERSqGfIswtylCfPw6w
    /6z51z78eSnnFLD6U6JmPK49TREsdBWu3f8ZIsURN4EGUPX9nMM86rYD4Jqa801V
    Ni5kAwSdt8Bbc1U5xrWQVBc1XvJcXNveoAJxyOfBx2gjppcGaaF+pekLEV1ryNfT
    Ow48BurK3M6VdZS6OjQYBwTfDA5F+zes0zDmGqBc8ybiNs+nv+z/KQr4rpkIsSJs
    1e/MjC4HvcsiK+d5QYvRV/XnsWm8ok+bU9CYrLVcSqnSos9ZAzLbA0cFBOw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=messagingengine.com header.i=@messagingengine.com
    header.b=NBFC//zI x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=messagingengine.com header.i=@messagingengine.com
      header.b=NBFC//zI x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAbGwipqu6yLapIZE3AFC365xSe0Je9pPt7TaQzZ5ONb7e5O0C7c3bNB7d/bsYMNCa0Ko+8umyI8Q2iAavoXK7PHRI4+1cTFlzpNa8aO/hKhtn49eD2s
    Iogsa2mi+OdqQFmZIoLLE8ufxBO9aaPCxFghQA02q4tB5XsxAca10kp4IZxDwvwgGg7joQ1obI1KRksv0AConQhlevkvu0Bsp1q+UYiYBM67+MxleXYzE6wh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=jlKVozcPpbhpnrNmKWgA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752761AbeEPICu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:02:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51145 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752506AbeEPICr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 16 May 2018 04:02:47 -0400
X-ME-Proxy: <xmx:pOX7WmIr72wM8ErHVwLYSsTzaEWeFYeAi_9Rn3FtYtowoOabohTX-g>
X-ME-Proxy: <xmx:pOX7WltxlhdC0NJY9bWxnCTuKKYhlEUMQCxG2orMIhW4tl5kBCAvHQ>
X-ME-Proxy: <xmx:pOX7Wo8c1UBZ17-N7V6kUaNWcEQmgckAN-0uc358mLE6b8eIyP4jqA>
X-ME-Proxy: <xmx:pOX7WmBDNRDHuJ6-DDsBiSAWIyUeg0tsnSMo4yQwF0TxzDrYVmWE2w>
X-ME-Proxy: <xmx:pOX7Wt4AMIPJolLA5eCQkCEqAsBwm_2nLQ0sGcSb7ZG0fRh39Q3Qnw>
X-ME-Proxy: <xmx:pOX7Wt9a_e0IOs4KauRQPrnkvGu4EyhZbi-JxUVmCZN01cznAhAjRg>
X-ME-Sender: <xms:pOX7WnqOslXc6Gt9CnxGScg_VFWy6V1OyMT60KP3gv8vBPcHhnALnA>
Date: Wed, 16 May 2018 10:02:26 +0200
From: Greg KH <greg@kroah.com>
To: Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Message-ID: <20180516080226.GC3536@kroah.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com>
 <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 06:47:37PM +0200, Paul Menzel wrote:
> Dear Greg,
> 
> 
> As always, thank you for the prompt response.
> 
> 
> On 05/15/18 18:00, Greg KH wrote:
> > On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
> 
> > > Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with Debian
> > > Sid/unstable.
> > > 
> > > ```
> > > […]
> > > [    0.440240] usb: port power management may be unreliable
> > > [    0.441358] usbcore: registered new interface driver usb-storage
> > > [    0.441367] usbcore: registered new interface driver usbserial_generic
> > > [    0.441369] usbserial: USB Serial support registered for generic
> > > [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested 0x2, got
> > > 0x0
> > > [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -12
> > > […]
> > > ```
> > > 
> > > 1.  Are the ioremap and ucsi_acpi error related or is a separate report
> > > needed?
> > 
> > The ioremap error is what causes ucsi_acpi to fail the probe call (-12
> > is "out of memory".)
> > 
> > > 2.  Do you know the reason for the ucsi_acpi error?
> > 
> > the call to ioremap failed.
> > 
> > Does this device really have a working typec connector?
> 
> Just to avoid misunderstandings, no device was connected to the laptop
> during my test.
> 
> But, from other boots, the Dell docking station TB16 kind of works with it,
> so I’d say the USB Type-C connector is working.

Ok, good, this might just be the acpi tables not set up properly for
this type of connection.  Odd that the tables show it should work,
Heikki should know more about this.

> > Does normal USB devices work with it?
> 
> Sorry for being ignorant, but could you please tell me what normal USB
> devices are?

If you plug a USB typeC device into this port, does it work?  A docking
station is a little bit "different" in that it usually uses the PCIe
connection, not the USB connectors.  Or at least that's how my Dell
docking station works last time I tried it[1]

thanks,

greg k-h

[1] When the power supply for the docking station is bigger than the
    laptop's power supply, you begin to wonder what is in that thing and
    stop using it after a while...
