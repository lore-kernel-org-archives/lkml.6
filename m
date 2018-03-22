Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2590670-1521720221-2-14228109821701861500
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521720221; b=bpFPCShkME7/AHDhdiJvZWzHb3IyDPhkZZ02kvgHlMBs5I8
    RVzgDyAM/1NWZrNNHyPHokpzqESlZGvRmV8uhJdPyQp/Qd+i1Qa1Z6C7p+AlNbC+
    YynqQLZufDH4a2O12KNpcvla3onpLLfO4uyAb0TUwGhGcgZFnmavpduiEU1WHz+2
    yO2yVnHwrLyP5CfSgGLvrMiyky8OIyfNXmbS5S32IHkXxIbEe74FMUX2bVNIUwF7
    AZYtBbZWd3ne1kDcRngUBnG+b8HTyIJeZqBA+UIjeDgCG52TLrOdi3taG5x8pSel
    aVbqWeczbVdh+B6TZoHIawrGwFCakPuw1hYTHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521720221; bh=RghysHk
    uuEGX8AtGVx+fVCrwzditE/AnVZqLZ/RmcFw=; b=BWWSjuVR3PMriPsadUMYWPR
    Ime2xlsz1WEVr+zobnj0RhayjwMLLIJzPpPU5RzpCb9wN/RIYX4s0y2yEPeMpzcE
    8BIPzEmXTtaxP1BabR5o5mBWQwxH4mOGWtRaOQ+iac8zxkbD0p9Wr2j9rvm3vBRw
    +6JuvPe0VbgpdUu2MStTTqOGjZHQseHWNNivtydPfKdaGqfQiUpzqAdP4OsK4uod
    pX2y7Fy2phd3fKHPSxC75aD7cBdDzuCDd2lGnB57UxCmoobdavoVUdqxlNK3PlBJ
    W9l25R3O7oCA4eelA5myiZGvamRXVK0HEZXeOQGuhotMrSfwvGcOG7ly2m/NU8Q=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeCVMD1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 08:03:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754532AbeCVMD0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 08:03:26 -0400
Date: Thu, 22 Mar 2018 13:03:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Cc: stern@rowland.harvard.edu, mathias.nyman@linux.intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB:fix USB3 devices behind USB3 hubs not resuming at
 hibernate thaw
Message-ID: <20180322120323.GB3304@kroah.com>
References: <20180321052942.2853-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180321052942.2853-1-zhengjun.xing@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 01:29:42PM +0800, Zhengjun Xing wrote:
> USB3 hubs don't support global suspend.
> 
> USB3 specification 10.10, Enhanced SuperSpeed hubs only support selective
> suspend and resume, they do not support global suspend/resume where the
> hub downstream facing ports states are not affected.
> 
> When system enters hibernation it first enters freeze process where only
> the root hub enters suspend, usb_port_suspend() is not called for other
> devices, and suspend status flags are not set for them. Other devices are
> expected to suspend globally. Some external USB3 hubs will suspend the
> downstream facing port at global suspend. These devices won't be resumed
> at thaw as the suspend status flag is not set.
> 
> A USB3 removable hard disk connected through a USB3 hub that won't resume
> at thaw will fail to synchronize SCSI cache, return “cmd cmplt err -71”
> error, and needs a 60 seconds timeout which causing system hang for 60s
> before the USB host reset the port for the USB3 removable hard disk to
> recover.
> 
> Fix this by always calling usb_port_suspend() during freeze for USB3
> devices.

This should go to the stable trees as well, right?

greg k-h
