Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1882471-1523971205-2-5546225334680517848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523971204; b=IyLZePleZyU507SoYHdF6zJipVkxjJjwVLjBksSvqIP14FfEXd
    9GnNO342qvvmhnq/kg3Qe5QSbXm7nmFgwQOMfSrF/JYYM76PeryyxGZ82TE8mmqI
    FXbl+YC7gq1PCXYcDaBq+k04322GKkNM9l5fAEhuwb2XfaWMLxVUHfDkZAbGj5Mn
    9dD6ZvlPUArdHz3ORDOlC0QxxUinK64oQK/VzoIkPxsLX+lyCUVcwbmBxbL1tUpB
    5TzFaAtaUroD0PfsFfRZrQKtBqYujFTbw2yy3uThHUpwkFBdITUUx0ciEPtbAnkM
    bRD75mnP/UMa8qCeAzV6x98GMfAhTSPXU5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523971204;
    bh=k/A/tRgEO5TJXXHMWtt6yyNuskIXargvAq8JObQlgVc=; b=JtaA+j+5EAmt
    fFoJX7S0F3dGIkEN+XO0FS6xpF7wPWm5hzUImSqP21Hs5IJiz9AlVdvHxV9noCMO
    Q80sWfJxWUIvEm90QQh0rQw2+2tiguTrw0d76Gk6W+LTcRHSJxcMbQkbEpKpchm8
    h9WVhPsqJmpHs/nV7UrRWlO35KLU0/whMo8p82wbaKhGdFmMJ2NaUSQyLTCOZQ9Y
    h8ba95r6qQZrtxf0Y66ohrp/kpeFdsYmGViMsjPMDaD+KSCTw8ar7EBekkXLrZXT
    LkHdKyoztBNm7nhXQEytkNw0pOk8OWYujoFf3kFYxiU/mFDgbvQjf0BSmCDH/O7o
    UoxOWHJPPw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD+5kCvRwvjkVuQjIS6pMR6G9+M/8ASd2OGHR8V13FX6TROWuAlfLpq1e3S1vG0zjohlBeSw/TbUZrd0oWTenmeW6Hfx0U+fTTpXZzc6DuiuKuMnM9TL
    xB+BTiDy2foJtEVz6U6uHgIV2PMbjMA4biC3BEC4w0Xc6eFPvgmYSYE7J357L5j2ixhEIGYqYiLuZnwargcpXTsUY3lBtcK0AjBzjRZxD9SZVzgk8YsN/sLx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IhDdiLrqHVMA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=WjOPJ5LTjyGwJpTw0swA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDQNUB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 09:20:01 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:39757 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbeDQNUA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 09:20:00 -0400
Subject: Re: [PATCH 1/2] MIPS: memset.S: EVA & fault support for small_memset
To: James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1522315704-31641-1-git-send-email-matt.redfearn@mips.com>
 <1522315704-31641-2-git-send-email-matt.redfearn@mips.com>
 <20180416202234.GA23881@saruman>
From: Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <cc6ab882-6862-2cdc-fdaf-cf0d0ba22728@mips.com>
Date: Tue, 17 Apr 2018 14:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416202234.GA23881@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1523971192-321457-31281-52157-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192080
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi James,

On 16/04/18 21:22, James Hogan wrote:
> On Thu, Mar 29, 2018 at 10:28:23AM +0100, Matt Redfearn wrote:
>> @@ -260,6 +260,11 @@
>>   	jr		ra
>>   	andi		v1, a2, STORMASK
> 
> This patch looks good, well spotted!
> 
> But whats that v1 write about? Any ideas? Seems to go back to the git
> epoch, and $3 isn't in the clobber lists when __bzero* is called.

No idea what the original intent was, but I've verified that v1 does 
indeed get clobbered if this path is hit. Patch incoming!

Thanks,
Matt

> 
> Cheers
> James
> 
>>   
>> +.Lsmall_fixup\@:
>> +	PTR_SUBU	a2, t1, a0
>> +	jr		ra
>> +	 PTR_ADDIU	a2, 1
>> +
