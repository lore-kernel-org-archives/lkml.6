Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-898593-1522738620-2-11891663218732583946
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522738620; b=voloRadQrqySF8oU55OWSwJeZhjtEVY18amo70XY2O5UCEcMj1
    lLFkeXi/OSDDsoo/zMc6zFyRFlNaWdCj9KdXZEyid1x5UdlUDE8P4Jm4Bi73KCG1
    ux2Dw93Ral7HpJEzSU3hrg9p4dy2Idfg9qmda9n0znndTHnobtx0DHybC41o1F6n
    OmFQJYOcRnXmVDJqAxHkAMb3HlwiC+L37TO6VS7BKA3ddwWcDfHhyn5yvc0X0Kp8
    T09xr544Nav6fAKzDK8KOWqvx6Jl9lGMK6SBq5jrQS9JxTB3GFHiDxwA2dfxAOrj
    kckQdqJ/re05KgqNzGBY9n7KAd+mJe6VwAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522738620; bh=NnxqH2PXtZS1PuNaCUTpMkoSrJB/11
    iKZ6ZdcKt0sv0=; b=Oz5WzcAmt7kjwmISCR18PpJkZdLhjtVy7cYstfEUHdGb/C
    OEZtgqIO0Ha7/ACHErNZEss6rJ7gb7daD7iknWsksMiRbtejpexRbWRrrH5FWrbw
    6zP22kXsAcIW3WtIaa/V/hpmrv1J0JkCV/BosAo250vLZ9uuzShp7xtIp45VP9Zm
    NLEece69OTQAUqBz+rZ1+E06CeMJiBMiE7ZS0iIaWr3IeEbZ1Ph3nyTneSY3oNWC
    8MgwpjqDCnu62epFr15CdHirKnDIvfkS6MVuIinyaGUBq4U8PsgyZv27gq12g4Kw
    CobKwXwr5WCKp3TkQbkmf1bwKdjcRgE7E49eu+Ow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBoYnXXjeftDQJlT3dZozEtXg2SiesqypTA1WXvv0cl/Ss1GOqEbcu8ovmHQxRmeE8SA965okFwSHLPBeON6iyLX7p5N9uGwpURE7CE8I5se0g0oyU26
    esmG5g/mlJzPNfVWUOtRI/ATvrE7MY0l+GcbpAUJjmXongZcU61CeSZFnZtnkI0qZpFfb1VlUc5JrWDZcE6POl/al8g66Qq7yNjyesg1MZlESsyZ7HlIaO9E
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeDCG4p (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 02:56:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeDCG4o (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 02:56:44 -0400
Date: Tue, 3 Apr 2018 08:56:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci_hcd: Fix usb device and sockfd leaks
Message-ID: <20180403065642.GB1093@kroah.com>
References: <20180402205232.21659-1-shuahkh@osg.samsung.com>
 <20180402205232.21659-2-shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402205232.21659-2-shuahkh@osg.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 02:52:32PM -0600, Shuah Khan wrote:
> vhci_hcd fails to do reset to put usb device and sockfd in the
> module remove/stop paths. Fix the leak.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>

Should this be marked for the stable kernels?

thanks,

greg k-h
