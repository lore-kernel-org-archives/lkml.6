Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2085280-1524930741-2-14277320478272415113
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524930740; b=a2vq+N2doV2bP+W3ttAtfLkUtxWuTwKQ5/JEpL4PjumSSJcmRH
    ZmvJmc5xszSYLOT8pCkLt6vL2GiTB8sgTBPWB3ZUJaVouMJWSuuq11C6t/bKmedY
    2jKLLQTgGa9SvSIhH200ylH/SFYwzQ6930YdBhn0BbBtBJACqE/aaD/JgabQ8LlO
    gXKr3mE7zAZcRbnagTz6sdEkTRyRXZzBb38dN9XoCgicoYwlyb/JjhEFkBGhsGkK
    fGbcicJxFkl65N91YD06oCfgeql12w/JnycM3pCr2Q5zbXXEP2RDLsq6JZcwf/bA
    OJib3H1LvJS42E3aNP6OuWhZT9H4xtWgV0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524930740; bh=FsQumyDVBBmFrJ0v5E1i3S6IBcYPEj
    k/0K6V6k0h8tw=; b=TXdoVr4bHHVmuANJk4mN1aDfEOIXUHKvoyoffuxVqrQciQ
    Zv3/lX17cw+tZUA3CelL0WLCvDCIqlUvZSSNo6XdsBu/lXXvfk83ap88sQikDgi4
    BrNJ/LtPQTJv17rKrxnsHvlannJ+X4xcRjVWka7eoXhk/pOpWGRhMgHKo3GkhBmJ
    ya18GOvTrlveh/nBMXB4SWx2CATRaGfJCwvRmwNBzBmzOWvMsAm4Ki42OlQsYpR0
    PwsHSna5kQrx7dUIvgNN+H2JWog7emQm2T2cK2E3Ri8X1roYXafSe0qx9C1Lh8U/
    bAciTCA8HD534OsyD3L+Wq4vSCHbNOlzJcQWPJ+Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPQHjEq6sRGzyYfNR7MDrKWIlS1/Q8uUCpOiS7k798SNX4zIM/jyY9NZUGtaEQC/EGdvd8yeQfzfWLmUfJP8Pyi5Zi+NBuQZbQkLQnt2OmFyTabr086K
    qcJrryTEDxAKbq91PK4Ys4Ebd7lW7FnVwdGt+p+0/qfSBkrpG3TrYPRxRbGQsWg7a/7aXd5f9/cN/ZtM7LeIMJgGeA7rL0k1dJznl8PvvjYg+uupvmzKP5XB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=9hA1FEcAjjIA:10
    a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8 a=rJIbxagug93RUuAG7PsA:9 a=CjuIK1q_8ugA:10
    a=eX-Bu5Fvq_kA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757613AbeD1PwT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 11:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbeD1PwS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 11:52:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3ECE22574
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sat, 28 Apr 2018 17:52:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/81] 4.16.6-stable review
Message-ID: <20180428155208.GB14312@kroah.com>
References: <20180427135743.216853156@linuxfoundation.org>
 <fb2e3a46-bcb9-8b72-c5b5-92c9c91698ce@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb2e3a46-bcb9-8b72-c5b5-92c9c91698ce@roeck-us.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 07:32:18AM -0700, Guenter Roeck wrote:
> On 04/27/2018 06:58 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.6 release.
> > There are 81 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr 29 13:57:21 UTC 2018.
> > Anything received after that time might be too late.
> 
> Build results:
> 	total: 143 pass: 143 fail: 0
> Qemu test results:
> 	total: 139 pass: 139 fail: 0
> 
> Details are available at http://kerneltests.org/builders/.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
