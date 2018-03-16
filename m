Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3171573-1521210909-2-14323264749230662965
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521210908; b=gjhistn7/5Ufw2mTkViiJukHg/6OQDbTPpIwdEyK1dgo2va
    LZS4ntLqzeOsZEbgarvqKGHd/6CZyMX89PAFYa/FDKq0ONcdM7pNBFMguFs+inEJ
    l2UYW60jOgieC3MiroqHXuD7A7dhWgQ2alSG/Hem8x5STVPJ+dL1xx99aaIdNKN3
    5ACj715GTMJ4SFR29CkLDqj9/2p0N2EGCgFensW17MKb2aTFJMu/hHOf46dw46su
    PiRqX3HO7d5neLfM84EClBrUt7jIE31g0B2Y3zdNMX9t2AASCCh+1izptAyLpSb7
    3IHzk0pCescXBu4uviHV4Dm7Inmn4iEBgyrFe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521210908; bh=+mIzqX7puu+hAKMc+ATDgI2U1o
    nACaBi+StIObQtf1M=; b=XJ7/3++WfwiHZE4Io100aN+LLV8vp9vwnF9Npn3koc
    Lzm1v5RIiTPYwlv956O2XKTr3imPq7aJaSZDfPuqNdLwA0uO/AjaQUvroVzNVCB/
    SD25JSN7WyLrcYzhkdsy9vk8umGIzt9/5imoEpOykgzU5i8MGdHGX8Jispm5m9mm
    To/x2c8p4/YT84zEp5Ob6S9yNPqfbW4dVE28r+gSOg/BeatUlay71axZD5T4b7X7
    hgD9UrdG8VnYToeTVzQUfwJb8wVLnu1TxNU5E7zCM+6/9WBHnH/LN7A7orhAE/e8
    FJ7EIysCeigVV7Aon2eU9JRuMv5EHuqB4zEgnLMPv1Fg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeCPOex (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 10:34:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbeCPOev (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 10:34:51 -0400
Date: Fri, 16 Mar 2018 15:34:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] usb: gadget: Add NO_DMA dummies for DMA mapping
 API
Message-ID: <20180316143450.GC29333@kroah.com>
References: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
 <1521206744-1504-4-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521206744-1504-4-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 02:25:42PM +0100, Geert Uytterhoeven wrote:
> Add dummies for usb_gadget_{,un}map_request{,_by_dev}(), to allow
> compile-testing if NO_DMA=y.
> 
> This prevents the following from showing up later:
> 
>     ERROR: "usb_gadget_unmap_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
>     ERROR: "usb_gadget_map_request_by_dev" [drivers/usb/renesas_usbhs/renesas_usbhs.ko] undefined!
>     ERROR: "usb_gadget_map_request" [drivers/usb/mtu3/mtu3.ko] undefined!
>     ERROR: "usb_gadget_unmap_request" [drivers/usb/mtu3/mtu3.ko] undefined!
>     ERROR: "usb_gadget_map_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!
>     ERROR: "usb_gadget_unmap_request" [drivers/usb/gadget/udc/renesas_usb3.ko] undefined!
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
