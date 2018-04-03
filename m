Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2009890-1522777320-2-2832732736790092193
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522777319; b=JKqGJAzGHxMOB75qG2R6N5cXOdVNWHGleehCxgnfRiVphOS0+w
    6fc75m0WWRW1h3ggWp6yBunyiBIWa7qTntEEBY8z4BDWqz7P5UQJUckiFhBsNJXu
    s5C4M2ykN/ETqlJmUcmInO2MdLiTVwznILbd+4IUkn/pKOvy1VwN6W601KCU0EIg
    tuEkWzR2e+3N+wTn38QPRzMl2x15aRdvhZavGlYKD6VYPY2v0gVX3xs7QUaZ5JiN
    fDe3PQDxLLFopWwb4+D3fk7E8XpJdMc0KLQ1C3QMURXE40ChVwODeS3BiPM1+s8G
    87G3gt76zQxZFsPLiSkEIoDUUeYN4TNnNX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1522777319; bh=dsxN+q/SICJ
    6KJeF35dodQ7c343ZDhvd5lOxxUtO//0=; b=BLAg/4F4VTzyisJcffC8rJueR/W
    w0nvFEhlN/56RA5VGV8j3z3UgI23nQB77PuwRYEEN76nnPMEj5J2yzFTKxZ+SkYE
    jj1AihpQBBbcg4cxR/UntDJ7C3wNWjdVx7jS6PQzXUI55TMelmf/04gGF5++AocU
    Iz++hm6N14ri/OXohHBCLb+cY1OjcYAWHH/EWtMys5oZyVo46dK1N7ZDfeiwnPMw
    FVS/j+CAB6M2n69p7gCDVS0zLdPCLM8rCaZmcPZTYaPErPzTKHu8yG7JXvaVhxCQ
    +/op2QqO+hiZvElw5JZswEJ23Uhqy4OTs+SZRpFIl2muICQmor52Lp/tdzQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
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
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOMp0sZwLx+phG4APnKjQpGrwi42Z+gQBnDdUVb+hL9F01sTnW6W/KR2N0NTYVFFAdNMdVorimVQHYHZqVnpRxRxMxY5aigTQDc2v56chU5F0aOZvJJt
    kEdFe0mAEeNHbd1JBeoT/XpvoHD1g+G/NznoEBIysqxISS6fpKi6NbbLCw4SNmwWTDsTN2nBGeyJ/LUuQxY8L+uzd0zdsNfQ0+CCnWuDYfgv/DCLHFzGFp75
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=V9HRiJnqRYG0AzxUIgoA:9 a=wPNLvfGTeEIA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeDCRl6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 13:41:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57246 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbeDCRl6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 13:41:58 -0400
Date: Tue, 3 Apr 2018 19:41:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wei Xu <xuwei5@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        John Youn <johnyoun@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chen Yu <chenyu56@huawei.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 068/134] usb: dwc2: Make sure we disconnect the
 gadget state
Message-ID: <20180403174156.GC32709@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171859.057406471@linuxfoundation.org>
 <1522597785.2654.54.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522597785.2654.54.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 01, 2018 at 04:49:45PM +0100, Ben Hutchings wrote:
> On Mon, 2018-03-19 at 19:05 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: John Stultz <john.stultz@linaro.org>
> > 
> > 
> > [ Upstream commit dad3f793f20fbb5c0c342f0f5a0bdf69a4d76089 ]
> 
> Maybe we should also have:
> 
> commit d2471d4a24dfbff5e463d382e2c6fec7d7e25a09
> Author: John Stultz <john.stultz@linaro.org>
> Date:   Mon Oct 23 14:32:48 2017 -0700
> 
>     usb: dwc2: Improve gadget state disconnection handling

Good idea, now queued up.

greg k-h
