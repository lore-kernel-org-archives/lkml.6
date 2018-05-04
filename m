Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3986429-1525419668-3-7085093231842250006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525419668; b=bNYQ9pbuWN2pli3LF09A6/LYxIWtgeMsY0vo0NiuH2URm1U8wk
    rQKCRuG/CaqLdHovKibtCA/pdNaJj94VEplJZIMbs0NSkF45oYwrWOiBkNG8BxJx
    2XEvNaJU5z/bBLvW2qeNGS72fx4gJI2lxIA1fd5Zf3ADZ2xILmfXLOjieM3KWRmo
    LMZNoR2aaeeYBfH/0HmiXwz//O7jWqDFOmd8HVzbqN16omhqZirpFT1uQNQZuq9R
    a6VSkMUQJURrvM+rf89nU8D4ubKbDIJYRtOqigYUUUVGF6nPR+e5SpT3Ubv/nlBR
    S/XeXFkWLLUl0h42BDF2Hnirai0owimnL5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525419668;
    bh=w88gA1JSh+ZmrdjJ1gWUAwjfZc5f0CA0xHmdORYe+y8=; b=MRMYLXAfy5PC
    dd8Zp3HeqTSfilFSIhcnMVtY0po4E63KnXaS2p4vk/p5y7GuSpnPpdkC09uu5TqX
    LVBQ2FI6M5Atu3glfLiufZ8W0CMwai4ewE+mEyqvKHsKmiJY2EXNMzYykdgkp/lh
    usmgUuuwcm/klwmzTbTP74d0VutmcVX0PQ9ZBMN1sLcRuvkO/HtCj25BNOfNDuky
    fRrgWH4gKCrDf+nqh76LwB2hhBOWnPLRHE75CJv6EpqjCbBQgHjeYuYWP6suyDAr
    uzYa5zpZyAKRO/A2OjXcO/HKiS1hYAu9x0Y4SD1h1eyIz+jdtpNQKsM0yB7+kYTY
    FWym2nYbKQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=blKlwByS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=blKlwByS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMPaVkgg4DTioFTvpGPbnh2V3jSuKyUTQcj2Qev10xLKaHJxpWD+QGEVJGvNQqOZjfqZuLjkYef3WHOg6EbI1cbTGIRtfXIjRGERp/EjAhTOmN+nVsud
    DcbEQm5y5gMK23ZiJv59cjExtEoABzHVyCf8px/WF86L08rRW1Z/gQVYe6Zllfur0Zo7AkrypkuOR/yzPnjOek0rtc2Raj86G6Lcb+WZWN8syCl9x6Oy9YoZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8 a=DIfcUdl_LKM-nV-XLHMA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeEDHlF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 03:41:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43240 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeEDHlE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 May 2018 03:41:04 -0400
X-Google-Smtp-Source: AB8JxZprFKoGzqBxGQMWDZ06I0ORPsBsfvkIpR8xrWfw05BuJ36dMTPiYfX3wCQrKzxWy1Q2p2f1Rg==
Subject: Re: [PATCH 4.4 15/50] s390/alternative: use a copy of the facility
 bit mask
From: Jiri Slaby <jslaby@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.637526548@linuxfoundation.org>
 <ded98294-4341-2c96-7ed7-115721af8164@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a41ea716-82a6-9d0b-4246-6611129e4b66@suse.cz>
Date: Fri, 4 May 2018 09:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ded98294-4341-2c96-7ed7-115721af8164@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/04/2018, 09:37 AM, Jiri Slaby wrote:
> On 04/27/2018, 03:58 PM, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>
>>
>> [ Upstream commit cf1489984641369611556bf00c48f945c77bcf02 ]
>>
>> To be able to switch off specific CPU alternatives with kernel parameters
>> make a copy of the facility bit mask provided by STFLE and use the copy
>> for the decision to apply an alternative.
> ...
>> --- a/arch/s390/include/asm/facility.h
>> +++ b/arch/s390/include/asm/facility.h
>> @@ -13,6 +13,24 @@
>>  
>>  #define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */
> 
> I wonder if the below (plus __test_facility) is correct in 4.4, given
> MAX_FACILITY_BIT is defined as such and not as sizeof(stfle_fac_list *
> 8) as in upstream?

IOW, we should include this 4.12-commit in 4.4 too:
commit 6f5165e864d240d15675cc2fb5a369d57e1f60d0
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Mon Mar 20 14:29:50 2017 +0100

    s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT

thanks,
-- 
js
suse labs
