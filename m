Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4006321-1523909031-2-4270477544524009908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523909030; b=vf37hVA3VAfVhueYFNsxNvKzrScANP9AMxlx5rmQ+F+GjiDorK
    9JasAZd7iiiqTQePmsvJjQQb+ZxJxhrMK/e62In9uJOZEO55ier+7gy+Bi7k2kU7
    7uOgy2uWNnR+676rKSDduWR/UeIO76TcxYA8LlT5waSBXbOzDnH5HxQYBWvOTbe9
    EQQcYTRN3kUdpUpkAhgaumg6RlcMSGH5pkPs022dIELKSOZ2HI8uMTA/vFiEPDOX
    BDZSgqddMElt5II6y08t5dD4mKttBTXVWgTY5RN8TAxeBkJ+hZe+66a3RVS7mK8H
    sLZKUXi+mmRaxWYxbfcMHVADL9PJDUwQ7i9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523909030; bh=H3U0iy6K9Oq38KvFRMlQN9h1w8J2vr
    eWbK44ofYeWA4=; b=KzqhHgQuOMg1BAZF8r63UCycs+DlO1iBUCDL7wIzYOLNra
    UQlXNkD32dIKCHgj+Jtme4KMiKJz5xaS4wEs8+zBPOKuopPQLZKiqlYiEaUMuFOF
    SI125Ik87vYdiLM+jKR3R9BPQqeTDL03AXg7+rT6xNqkTcK5OqKURs7kVhGwumO7
    CNpHQdssWHxlONnBN9g2agpnhsqAxsZ4JzVQgvYf2LraolAnpRxDeEYugBakb4TK
    LG0k2ys3FB6cL1OVTCg0IdqNjxMNrkpVfHSPBDRE71fYozgGvaQnVqrQYvX7QC8y
    YRxROFIPfSZYfYGmgOWmuOYmesNfWkg3eUtVIWWQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=iACeK8qx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=iACeK8qx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCUoEuXXXclD0K9X/q/XqWwBCWuSAbMmOiL42/b7n8+U5v7oXrTWj0jx7mx+oaS3uCJ60RvLZzgEI4FTxQfFUTC8PAKOhb4gZY3WKrE5IT+FYzp7vqBp
    N0lCl7Z7Lyck/GEh2KH4ollXSUcvsQw0x8UK+xjSqEWdSlyJi3dYlShk65aArh14GEJJ83xOSoqaxNEB+q7q6iDMwu6Eab1Btp2ah7QQW1jDt7/DCvr+tbRO
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=NSqh5MaUhHqVC-xbr1cA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDPUDV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 16:03:21 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:22028 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbeDPUDU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 16:03:20 -0400
Date: Mon, 16 Apr 2018 15:03:12 -0500
From: Bin Liu <b-liu@ti.com>
To: Johan Hovold <johan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] USB: musb: dsps: propagate device-tree node
Message-ID: <20180416200312.GB14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180413151505.32663-1-johan@kernel.org>
 <20180413151505.32663-4-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180413151505.32663-4-johan@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Johan,

On Fri, Apr 13, 2018 at 05:15:05PM +0200, Johan Hovold wrote:
> To be able to use DSPS-based controllers with device-tree descriptions
> of the USB topology, we need to associate the glue device's device-tree
> node with the child controller device.
> 
> Note that this can also be used to eventually let USB core manage
> generic phys.
> 
> Also note that the other glue drivers will require similar changes to be
> able to describe their buses in DT.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

I will take other two patches for v4.17 rc cycles, but is there any
problem if I take this patch for v4.18-rc1?

Regards,
-Bin.
