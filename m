Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3872180-1524301222-2-13952747767596595265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524301221; b=Fqq7rd4rsOckmEqLwd2SHF0AiuPEH7iBU4lYFRvtR42fzqX4mQ
    +xpQjDbwqN1cWI/6H2gpNs6ToCt01GEM06alUUHARyq9R4yPHwameTqdj38eZNXr
    gKEv4i5QsyvbC0sJEI30i98RgELDTouLW/tZFRjG4PfSMQAP/g35I+RVmGHbw3wN
    qgIgSbQe2c1ExhdRIYDb8YyoJYvYA/glZp8TVqbqfjcCeOHg1NyaSj7W3pawPUgj
    6MctTa64InGv615iDdDiJR0M+eQcQ4218ryEyx5LgDHO5fS80h+gblNtJ+c7CBdr
    nBT/4M+323XYwe5b2qvjJRsKdlmr/Pu2xH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524301221; bh=Z+Dgs6CmYNDrVRuMqGu3n2jc0GAdyB
    dBom/dFX9un8c=; b=BucUo6/Avv4N7g4mXquwaOF7d/7UOKNCOM7D4eq/M42qyj
    KsyJI9amMWWggoiapzXIKGifRKCms9I7fg1wABcxNTo5Ood0maXLFgVRekFPX5rJ
    luf/IzJlqu0EYO8We4qlHJfybUkunznYhhOx1fseAplOrjZXAhtAcX5jEUOrh4yv
    hOZAd7mIHVnnuioYJdi/XKHLemvYGdRwIF+tMSWdl/yN74h5OzoISkVz3bEdzty6
    HzOY6rmepyqzMTTxx3+adivBSSOJPOX/gZ1Hk0xDOOzXh+7XoMIC9/NQ6jAnk24o
    7IvbzNUpHcM58V3OgwVIs7+nOo0Q1ojNVs5UKTqA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI0uktM/T7nKSVf2F6YWcevENuPiNWmIg4iRYqBPjOCeMX8FPB6MUMy6IhDvjm6Zb2SCx812Yu1uRjAC3oU97DPgpG7qA9Mu4J7enzkDYRfim5pNNlzY
    XjrYdkd7vqFAib6pHWItaz4fc4etorN3tlsuLvbW/Arn6BLnMZq2BlxGD4zyz8lg7afNRy/RVNkiI0cQE5DckDCYEfTjvP5JXuS2G87gGY8+rLnB217EuNxb
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=ciqRXFcFJmd8jc1dilcA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeDUJAG (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 05:00:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeDUJAF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 21 Apr 2018 05:00:05 -0400
Date: Sat, 21 Apr 2018 10:59:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: stern@rowland.harvard.edu, martin.blumenstingl@googlemail.com,
        ravisadineni@google.com, chunfeng.yun@mediatek.com,
        johan@kernel.org, arvind.yadav.cs@gmail.com, dtor@google.com,
        anton.bondarenko.sama@gmail.com, f.fainelli@gmail.com,
        keescook@chromium.org, mathias.nyman@linux.intel.com,
        felipe.balbi@linux.intel.com, ekorenevsky@gmail.com,
        peter.chen@nxp.com, joe@perches.com, tbroch@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, bleung@google.com
Subject: Re: [PATCH V5] USB: Increment wakeup count on remote wakeup.
Message-ID: <20180421085956.GA8081@kroah.com>
References: <Pine.LNX.4.44L0.1804201325430.1407-100000@iolanthe.rowland.org>
 <20180420180821.194380-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420180821.194380-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 11:08:21AM -0700, Ravi Chandra Sadineni wrote:
> On chromebooks we depend on wakeup count to identify the wakeup source.
> But currently USB devices do not increment the wakeup count when they
> trigger the remote wake. This patch addresses the same.
> 
> Resume condition is reported differently on USB 2.0 and USB 3.0 devices.
> 
> On USB 2.0 devices, a wake capable device, if wake enabled, drives
> resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
> The upstream facing port then sets C_PORT_SUSPEND bit and reports a
> port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
> has resumed before driving the resume signal from the host and
> C_PORT_SUSPEND is set, then the device attached to the given port might
> be the reason for the last system wakeup. Increment the wakeup count for
> the same.
> 
> On USB 3.0 devices, a function may signal that it wants to exit from device
> suspend by sending a Function Wake Device Notification to the host (USB3.0
> spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
> wakeup count.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
> 
> V5: Added the description of changes between different versions of patches.
> V4: Moved the wakeup count increment logic to the existing if which is
> safegaurded by hcd_root_hub_lock spinlock.
> V3: Added a gaurd to check if rh_registered is set before accessing
> root_hub pointer.
> V2: Fixed the build failure error due to uninitialized dev pointer.

Is this needed in older kernels?  Should I submit it to the stable
trees?

thanks,

greg k-h
