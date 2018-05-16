Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084986-1526513689-2-2553924665429040662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526513689; b=NPAJzcV0d6e3I5N1xRm2ku5nLjtCw+f+IbhxhJ/v4ibLYK3hFn
    6kY0xHg1gf1EC7DxKyUu5TUCBMbENzsOhkGELsxyS5np1sfSfmj2himXZM6vuP98
    cvp0InYIcXSeBjTHYlSB/ZpgV6DNcwPb+ImcYz3xGvbtkmim0duRhJjVYKXqg0sW
    kHiPegROqFoNvtcdouOWVHHGrvUTMNGLqmM9gtouv4SJYNGQrIwpkmY68OYc1b8s
    qv1zRZz/YZyb9/+oaQPL28xrCr7NIlFdzfdUErlLibr2jAjfxNRkrFaDcxvrLL3Q
    xjfun1ZvEh0w0BazlBIqz0cr4wREUh6JMsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526513689;
    bh=NRAuw9STdKTD3jYmApfr5OnOSoA0w0OXfJINKsSIgqk=; b=Azby560TUpAP
    NHaEZo2xHaEz6VcTtjuNBC159X+j1TUPLTgkHXm1wfNj8paAeNfwwA8uEhvw/Rs2
    tOa2CvnP/aqG5/ViBrVscaXmPmGKkHXvEwSiU06TzWMgYaycbFffXvytn3/CzXos
    riEXYqTOCI0GVmMXGahPlzgzJsW9mOvWlqF/MY6ZnapI2CpeJntLGsCKwmpzamVA
    CbnWY/haHSkfuo22WgIBjJGfUdiak74RLl3Sa5lucjq3p83tVlZTe/1CdwmHPVg2
    Cec1Bic7X7KMC7KE/t3JWr4iLCSjZzYJAdahflLlMunasmFAAHDxDeDCmqgBLsXz
    UVJDOdH2Jg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJQ9fy5p2BcSbZKVMb9SRaQKyVR9UkperhKjj7LhB7qeCaJCMNimkB04UqWqafmN8ecOWOU02CFcw4Ecmg4GjfI3gYHvd7IAZa0fJJGujM2TSQxFdI5r
    7jyw6MWADwpwtBRagqCmkbwBVnA+ITRgWw48OCGvGEJOVqxrNeXJEgEZv61SCQ23POKmSeCRY9qzdyWt4IOSAVswT8LbFX/3tphRbXsBkvWEZsSRWixwE5Gw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Hw7PWmS5VM4pKStVqn8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeEPXes (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 19:34:48 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52805 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEPXer (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 19:34:47 -0400
Message-ID: <1526513685.9159.155.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 60/97] clk: mvebu: armada-38x: add support for
 1866MHz variants
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Thu, 17 May 2018 00:34:45 +0100
In-Reply-To: <1526513565.9159.153.camel@codethink.co.uk>
References: <20180422135304.577223025@linuxfoundation.org>
         <20180422135308.591594256@linuxfoundation.org>
         <1526513565.9159.153.camel@codethink.co.uk>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-05-17 at 00:32 +0100, Ben Hutchings wrote:
[...]
> ...but this only adds entries to the lookup table at indexes 9-12
> inclusive.
> 
> It looks like this fixes the clock settings, but not the warning.

Sorry, I misread this, it's fine.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
