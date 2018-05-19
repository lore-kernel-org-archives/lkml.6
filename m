Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-974401-1526711654-2-15889446348111968542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526711654; b=Dv2uuecHeDsF8gCrlNSxJr3NU/IN+APW1kjfn7ehIMDcR4VMsz
    t9BlYPxcMGqnAs25gb+HHVjJtCJpi4Zfbm2ylD3odgIWsAoXb1wmTHfWK5LdVh2p
    pIferzqjo1tXLV9ZADt8Fs5uId8oxuSgQjTk4VPmE/RJaKAxWOIJ7cwcZWTW0nDW
    RQ2uIc2k1dM4DQIm/rJ/cIIASSm78RenZW9CZFcv5CX03tckQM501D9sek50n4DS
    kP96XXcR29j2e5zo3zoidhjrsAnWPLl+a3oGEW+fmN/xOD5kHGwfF/Kv11hS5kJH
    9q7yamqbWWJF3Ws1wzja/mbJQ6fljOUhOY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526711654; bh=dPOT8i5XnoxjZ5Tg6b3BkR50HU5Xcf
    20YdL20KCJTio=; b=YSCHGwowOqtDsQfvmSi1Y3cGbsDZFDLYmpacyx1n5V/189
    gz030wzbEX+NHVFXGrleTiHU6db8+2KT9thzRWpSLoHbDgyEzKpjqxc5U+1ir2An
    FxSMc4qSfkhNiCkLxmYhjqS5JHskj4qelgTCs5g44a3jotWZ8YAaTSA6hH+tLhVE
    oxWGqNMx6WQjBq7q5CyCDUv1WF/b/hH7o7WPATvADZchnV+UHPiPhYxrYWS31llK
    RswYbED062XCBnWHbQgpVc1n6LmK/uuUZKjSoar28aAmablmeu4KxzJy08M7AOhS
    butFwxolDGDd8ntv47vDlTPoTtuP2KYA0wwaCQXA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJdKqHeR4pDSDB/fKNQSx6jeY6gBvzUnRcpucmtRY+Vba907l1gnqcfDvjzggt3xbao0iluwDfOn/kjsDh1QiBliKdvOmcN7yz+/A5jZWbKm3SCjCUA
    imtrmdo+4MgZQgvizM7lnNzNu5EpDqW/OyJqQF1OMKuD1XmpQi90q0mcTLX+PRzaY51kJlf9uvtQomkSmperw8/Wv1pC170TbdCcQMyQ7aZQmQWk1Uo06Bhs
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=DJUlVWJ9A4BmKpWlLPwA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbeESGeK (ORCPT <rfc822;linux@kroah.com>);
        Sat, 19 May 2018 02:34:10 -0400
Received: from verein.lst.de ([213.95.11.211]:34395 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeESGeJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 May 2018 02:34:09 -0400
Date: Sat, 19 May 2018 08:38:57 +0200
From: "hch@lst.de" <hch@lst.de>
To: Helge Deller <deller@gmx.de>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "hch@lst.de" <hch@lst.de>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
        implementation
Message-ID: <20180519063857.GA18076@lst.de>
References: <20180511075945.16548-1-hch@lst.de> <20180511075945.16548-3-hch@lst.de> <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com> <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5d27e9-2799-eb38-8b09-47a04c48b5c7@gmx.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 10:05:51PM +0200, Helge Deller wrote:
> This patch seems to fix the dma issues I faced on my 32bit B160L parisc box.
> 
> So it leaves only one open issue on parisc:
> Now every 32 bit parisc system is unnecessarily non-coherent.

I diagree with those comments, let me resend the refactored patch
to make it more clear.
