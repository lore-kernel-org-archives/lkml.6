Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643183-1521226767-2-5096384365035357204
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521226767; b=op1lgrNwylL02QETVpb9kWB3z1CnpHWGhxu4Iu5b9XLTLDQ
    jiLH7aUTpL/oETggUMr570kfVAxiAy0Lm2jd1GF1YylI8hDzddYXCTLmuDEo3v/O
    Ncxw69shjrv4IlJEG1jii76sWknKzWwZVTr9Yi97yXNPHUqgKwKWJt9uo15LxEXA
    KMmfQKJSrFiSGRLG3VPl79XOehtk+gieStRejcyV1s1XhK8jJ7tAeXyckN0MCSK2
    6nO9vU2XC9x40icM3buqIq7xhX4qel5jEzut4jVD6M+4U+rv4t76n2VYZNFeUerS
    67NRTxgWSBfX2395ZMlO+ao2kfFGmpjd0vZc9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521226767; bh=WYs1nqPbpNBaofN+1S4D9kU36Q
    +gssfIPdDSCruAh78=; b=wQ1TTQ2vw9YBsScM2RRtg1jLrSy8MdKlVIM9wBGShE
    ucFB44DRhJ8OZIFwSydJ2B8rPmmKWl1HM1rC/Qd4Lp3bMPE+t6B8BB9FUmvnPjWC
    TR6ZeCLhn7Pid1YKkOMaamsLmmI/vdqGj3WR2Vchu+37gAMMWpdmYnCuTMnkCg0C
    iBd96Eu/b2tfoRGwCKa25DF7dhUQZeBH9QRd3DNuIjwL3HW3fZj/GHXP6bT5d+zB
    C5/IyRyjCecAWamTUqFqBBJINFtKVtGxjmLAuJUgkLuGBCcolLRiYmDBWaZVneXp
    hfaJbSjf5+o6RWHmuhABdXVYwOYkKasZTJMK4PzARRmw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeCPS7N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 14:59:13 -0400
Received: from verein.lst.de ([213.95.11.211]:48331 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbeCPS7M (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Mar 2018 14:59:12 -0400
Date: Fri, 16 Mar 2018 19:59:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allow compile-testing NO_DMA (core)
Message-ID: <20180316185910.GA3671@lst.de>
References: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521206744-1504-1-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks Geert,

applied to the dma-mapping tree for 4.17.
