Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1437685-1520499090-2-15413092908337129994
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520499090; b=CYsOLCGzbe4dNp39ivzTIL0GgeLhtU8UHtEbD+2vAQ8Zp5k
    Mq6ICtzzghYiipHO11COXwtpB2JRrjJCGuKsOzxix1+x9huvg9uC0oOu5iN4zFj7
    6pNXa5C99RzKFRiVsA4+5oIMdGalx99/OaS9QQzPgGpGZ5493nW5MT864xegLOOP
    unKX+oJP0jS7CQGsdUCde/8EA1wXvAV67NqAY6Z63N1Yx89E300WEjyeU9kJeAc9
    xzYBsP25XcT3C8mssFEAW9bfUO1bNFGOrWBfKkg9JVicHD24ety1A+YYRsZ3ON+0
    RzpazJapM6Zxn6kzDp3C7CKG7Ct9fX4eGRrhLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520499090; bh=8XC/oa4ahu/SxhlGmCIQpAgN80k28zywuO13LW
    7HfRY=; b=OGDXkB7HBgQW1UlWF+G6ni8Hy57EO9M590mv6KloheUjJHkak8G6I7
    Gspu7hoafCYR3B5lKpMY8Y3ZG/HMo0eL/EE6c71AGFOmiwG2aujby6sLFIGCm5pk
    Da6fFqaiOdWWvywsUnYgdmf7le8zzjPvLNAk70nSFffOaKVJjWz8j77JaZm+zvuj
    /UyDJhY3ANSVwQTLmbW+pOWbWpWyHSR5DNT86JM7ETDuHAE3AChBjPX49w8rAfJ8
    IbQ9jrrhl7LWv8Zxrf3Z+0N4JKebF22JSJ3xe25yQqGk+ayV3TfOSkhU/90NJl35
    pDhOGoPZRaD3u9g1OwkbTuhNDZvt8GDA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=eRsif4Q5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=eRsif4Q5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeCHIv0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 03:51:26 -0500
Received: from condef-04.nifty.com ([202.248.20.69]:56802 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbeCHIvZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 03:51:25 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w288g2da024610
X-Nifty-SrcIP: [209.85.213.43]
X-Google-Smtp-Source: AG47ELtr9BOsSz7eb14vj3ida0YEcxAyiyjo8dq3AbXvYuU07PFMQ0576eyDGtAQtfQjnrvoCt+CSPeWIf16bl7IRog=
MIME-Version: 1.0
In-Reply-To: <20180308070948.GA5187@saruman>
References: <20180307140633.26182-1-jhogan@kernel.org> <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
 <20180307202511.GT4197@saruman> <a6c448df-c026-dafe-6d34-801f69ca64fe@gmail.com>
 <20180308070948.GA5187@saruman>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Mar 2018 17:41:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
Message-ID: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To: James Hogan <jhogan@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-08 16:09 GMT+09:00 James Hogan <jhogan@kernel.org>:
> On Wed, Mar 07, 2018 at 03:19:11PM -0800, Frank Rowand wrote:
>> On 03/07/18 12:25, James Hogan wrote:
>> > On Wed, Mar 07, 2018 at 12:11:41PM -0800, Frank Rowand wrote:
>> >> On 03/07/18 06:06, James Hogan wrote:
>> >>> Quite a lot of dts files have hyphens, but its only a problem on MIPS
>> >>> where such files can be built into the kernel. For example when
>> >>> CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
>> >>> used (in the latter case it admitedly shouldn't really build all the
>> >>> dtb.o files, but thats a separate issue).
>
>> > I'll keep the paragraph about MIPS and the example configuration though,
>> > as I think its important information to reproduce the problem, and to
>> > justify why it wouldn't be appropriate to just rename the files (which
>> > was my first reaction).
>>
>> Other than the part that says "its only a problem on MIPS".  That is
>> pedantically correct because no other architecture (that I am aware
>> of, not that I searched) currently has a devicetree source file name
>> with a hyphen in it, where that file is compiled into the kernel as
>> an asm file.  But it is potentially a problem on any architecture
>> to it is misleading to label it as MIPS only.
>
> Okay I'll reword to make it clearer and do a v2.
>
> Thanks
> James


The code looks good.
If you send v2, I can shortly apply it to the fixes branch.

If possible, I want to send a PR this weekend.



-- 
Best Regards
Masahiro Yamada
