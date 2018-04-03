Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389629-1522789272-2-12956791686675912155
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522789272; b=hLgbTuqeQ1/iI99Y7zIFwtGn57pE3Uqy+5a46/0y7D9NHY3dCQ
    1LMM0CShpFaXh5WYNXrLUeKJZ5Hi1nRIytQxQsVFOcQ4UE58ah/agtj32rcBR7CM
    56KXvzziMT5PvuXhJ9KgoIdGt0fVSSPzi7KWQvy9YIxC5qM95Wzx9x0Ns7W0OEwV
    Ie+TKUH/wU9eD7KGNy/ZHnSrK6pBqMN81VzAhXVNTjnaVOq3wMY5D+nmwxvN68w9
    KFDW7VrZ0FA3BmSPuLE3PEgV8xWtoYEVMAo1tDWf8elfmpT3HOe/rfD5Z8f5dM1R
    yMoN/xV8ZK5nE7KHM9okJE8mr3WY4jYLQzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522789272;
    bh=eNn1UdHg7iFpLkCL2n+OB4crHw/GdwPK10AVgUGbOro=; b=PZZEPo32ffeO
    8MRNawCrYNBYgaICfjrKPPLiAUyCMve0yOUB5mTsyjsPAC9TTBld2gzdLtQw++YT
    01XcrMbRnHuwY0h3hEQMe4u4Z4ByibHa2rwNrPIQYNttVDvTR3S8QpZwq1O5lTAQ
    pRDCIjrAVPvxLJYNsqbDJlRppSiwzheyQ/7+x0v16DcNVt/cnHDstVfVWb7AijM3
    4cRTDZlOXqWldg3IyTJDY/URtURb7ZW/+VrhVZefzn19JvtkJVDJGbh84IQDZt0p
    85xfrK1FeYQTk0PoozNQ6lSNuCCegGoV6wciK4d0DmOpxsLxEWTXEvEmA+z3LcVQ
    Kxl8EIp1eg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHkQAv8GY3FTCbfJqz9ON48L0r/nSuCh0mcWv2q27W91hTwTiSoOeLxJHNvMRG1Ch8M4bzg/nCHLCekplDaenLDh3aCf0ruJob38XaBiaGrVv750+bAd
    wa2mizQQDSHZR5kQIfYfDpRsIYInPoIySNIQcfIpU3j8lo7dlhKw6GFMjtm49TwiesHG7pbytQ/mNogCzRcZQtQ6ikf5Qr8hwJ1JNsZb3i0gTCverEjOdoky
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=ee-jC2Qz_BlDeFH7fFQA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeDCVBJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:01:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33628 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeDCVBJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 17:01:09 -0400
Message-ID: <1522789265.2654.129.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 52/97] mtip32xx: use runtime tag to initialize
 command header
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 03 Apr 2018 22:01:05 +0100
In-Reply-To: <20180323094200.569562172@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094200.569562172@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Ming Lei <ming.lei@redhat.com>
> 
> 
> [ Upstream commit a4e84aae8139aca9fbfbced1f45c51ca81b57488 ]
> 
> mtip32xx supposes that 'request_idx' passed to .init_request()
> is tag of the request, and use that as request's tag to initialize
> command header.
> 
> After MQ IO scheduler is in, request tag assigned isn't same with
> the request index anymore, so cause strange hardware failure on
> mtip32xx, even whole system panic is triggered.
[...]

MQ IO schedulers were introduced in 4.11, so this shouldn't be needed
in older branches.  It also causes a performance regression (fixed
upstream).  Please revert this for 4.4 and 4.9.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
