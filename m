Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1042341-1526512269-2-13401053643809542901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526512268; b=FSgLHL0NjeGbGoynxAbBgdSXEXQa8qWxqVznks/av0x6rqFc84
    drD0wCA6tk0RpMqQOqekCf0S0Hh6DnojT/ki5zMDVGi+PzBBnFfCGgi3uPE88C/I
    L1p0n5rccgOoyY6YC6HZ9rFYTS/CNudlG5LdapaGKmelDZclClXvt7OD5BuFFB+Q
    d+C6oyPy2+sgT142KwYPF0BwEbnmvOFI8nH56Pul+VNYxt1TnmX1VEysJtFSpc3L
    DPMm+Un/YV295/+Qi6xfWEho37116VNCr58y6XwrMRFylfAx0cGJBxz2tZVSg3gb
    wZe05FZvMVd6sWZAE8gJbbT/ewFYyylWR1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526512268;
    bh=+ZtDTF/rUXYY5eyLstoGavzlkA6k6cFDjIvAw02+Tfc=; b=CUncyqg22do8
    9JFwKNFMvoemMzzAIuHl3iYQtAF+6CWEPMdQsqCWLZFUMLLNQMVjuTk7EmcK+kc2
    o3aVGlP/Xlq4cPRthjtH0DLDVW0apF5Hc0hFx0w/SMzq3yW7TJFGIMp5quq0xDcW
    AxDeByGmnEBnAqnD8AiQQ4UpYRFEMH8fL3Wa+SHCb2wSTY+WxttP54rE9ZaRVeh9
    hgvQT7+aSyebWJF9YbGMKvHiRZz/X0fEUZNPixyPnmmVtmVr/GzB5IFAmtsuMsb5
    RM++SjV6sGkoffGniP2OO6BDsyRwxqNlILUWvrmB1iMRHolUEKU9gL1gMfViAHV2
    S5O+4t3IQQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNsMORzsXvwFBEYVRHpvSA5gr6McwC0VIubhJYxyDokNIB+6PS+Zj45w1C2k5vEbI9zHg/lw6oLG36gu0eoSGg9XCFAniffsR63RRdW+6CiL6JXtVtgI
    KZhQ0fqlvx47WQ5cOfLD6mACGdj+lUUDwSXClnRcBzPo/sjBilUiSjogW75Rbf36wizPF/r8460XU6TnK3HEyuF/J2v+fZDgD0zFZTPMoTuXUoBFrrIao/Fx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=xv2qexK20-1u3vdo0i0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeEPXLE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 19:11:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54059 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751013AbeEPXLB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 19:11:01 -0400
Subject: Re: [RFC PATCH] UAPI: Document auxvec AT_* namespace policy and note
 reservations
To: Dave Martin <Dave.Martin@arm.com>, Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
 <20180516152913.GY1392@brightrain.aerifal.cx>
 <20180516154957.GT7753@e103592.cambridge.arm.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3e291fda-b27b-7002-9374-23196f18a38f@zytor.com>
Date: Wed, 16 May 2018 16:09:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516154957.GT7753@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/16/18 08:49, Dave Martin wrote:
> 
> Since <linux/auxvec.h> only contains #defines, it may be enough for arch
> <asm/auxvec.h> headers to include <linux/auxvec.h>.
> 

<asm/auxvec.h> doesn't seem to have any reason to exist at all. If
anyone includes it now, they are Doing It Wrong[TM] since
<linux/auxvec.h> includes <asm/auxvec.h>.

	-hpa

