Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2852936-1526400101-2-9326792846286011355
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526400100; b=hIR88ogvZGIeZYeV8Be7W/sN3Is7wbwkkXb8wENImwUSh/p8Gm
    mVhXo5+yPa7K/jpeZIsihmIxGnnyypPqhlwPOU1YFtFRSlx8e/+decPasT5AdFFs
    RgWYxsg8AQLVW06i7yiGQR31CH6QiBHEv7li+513mAHKiZblHFZ0WcjRHwQ5dThP
    v/sBAF9FZRazJNOtftr2HSxzml+cq7coWz5U2jKiee2xeSLActdPCNA9/51bB/Of
    KFbo+96iHZNkQ5K+dMUMxWzncBV3t+n/6e968RSVy1ebYIgVdoAqEWlmr7M3vh9z
    CFIwKsrgPcO1PHXbHd1NdQfMQZ5DXUEE5JHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526400100; bh=leBfLunDmDA
    6s7k0l8lyGqjTHcX1TULQQIr1jCSU1/k=; b=CEeoNvkNNslcAqXayDpvE7p15R4
    bTkvuoOzB2YyBdgoWd4m2bF1KoVQMylFk90B+BiOKuGEG4DmY0Yea5TtjPujF78j
    mYLN71hsaAJfYO6lZH2sh6/RvralILYoWROmZHUs/+qw4d1YAzRCt4tVBKhjdBxe
    doyDgj07HkB5wcgKwECDe00j+sYHYW/fQ81j5m5qw/h6wsqpxVMJDZFp+5lrUI/n
    d/6/Ue0vbTE03NNXVjtj1/XRNorN/RhNBjglWqSgI32E2ZidHc/76wtCZgUbcilT
    igsa1F/2NTlIWqoQ6h7Jz3UmyZQapjVsSxHOEzY234BOpBlBeOUyONTANHg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=messagingengine.com header.i=@messagingengine.com
    header.b=nlA0tvFW x-bits=2048 x-keytype=rsa x-algorithm=sha256
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=messagingengine.com header.i=@messagingengine.com
      header.b=nlA0tvFW x-bits=2048 x-keytype=rsa x-algorithm=sha256
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
X-CM-Envelope: MS4wfFmmmSMLPdPmLmGHzxoQOUH80lammHjT5KJKGNjrp5PaxiNEBufS2YXxTJq2Jppz1ZbyCwGVMZbnXRvvYhqXZVvKR/2DDnmUp34udEpG3svJJDEFSdX+
    3MRBrdeP3rMsmA5HmdskXuc6iWXyliMIeeYvYAZSGF+IIWsyeOUhbcNyOG/6QQcv8aEOnBMoYrNb5CMZU3r0NDxXny1+nDgzX+ClNwEtnDRb+rQBbVsJilWW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=wcCTK-0mpgeQCbyhU0AA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbeEOQBE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 12:01:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47221 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752835AbeEOQBD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 12:01:03 -0400
X-ME-Sender: <xms:PgT7WrGnaj8OZ9UXz0IEGnSWYLBZtdlZI4BLGSPYBituinmbfm590w>
Date: Tue, 15 May 2018 18:00:47 +0200
From: Greg KH <greg@kroah.com>
To: Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9370
Message-ID: <20180515160047.GB26720@kroah.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 04:34:03PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Linux 4.17-rc5 shows the error below on the Dell XPS 13 9370 with Debian
> Sid/unstable.
> 
> ```
> […]
> [    0.440240] usb: port power management may be unreliable
> [    0.441358] usbcore: registered new interface driver usb-storage
> [    0.441367] usbcore: registered new interface driver usbserial_generic
> [    0.441369] usbserial: USB Serial support registered for generic
> [    0.441383] ioremap error for 0x3f799000-0x3f79a000, requested 0x2, got
> 0x0
> [    0.441518] ucsi_acpi: probe of USBC000:00 failed with error -12
> […]
> ```
> 
> 1.  Are the ioremap and ucsi_acpi error related or is a separate report
> needed?

The ioremap error is what causes ucsi_acpi to fail the probe call (-12
is "out of memory".)

> 2.  Do you know the reason for the ucsi_acpi error?

the call to ioremap failed.

Does this device really have a working typec connector?  Does normal USB
devices work with it?

thanks,

greg k-h
