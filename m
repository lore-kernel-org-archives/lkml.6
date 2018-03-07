Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-306372-1520464757-2-1112068928978621456
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520464757; b=dLHHawm5RLUMIKegIKtLCoI2FEwhwoKTcGOBq9mgk8ginqU
    UKhz8u6Hua09Z2/kWIiTl4SFfdRC57rVNq2Rl/23BBYunFXmNvol9IimrBLi7oNd
    dG9Ehy4fCaOP1vof/7uTafMm+NdsFnrZlLzEcEyQHN2rPeKiopQpaLwVzgVOQOH+
    Ew+RZwWtEdgMM9whfHPC079Tl8eg3CKit08HsRtRfxVZgu0W5IKNygy4y31kNAu1
    5Cy2R2IwREXoz1fPnV7/BzNrmWbe2K19mJfuJfF1zUonOt5fNE35ZCoWdtERDSTY
    T4cHHIjtySNORNQdpHOl45yGNrNLbFbm1I4VKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520464757; bh=ShNWCl2dpmJtgpAaL3gr3WYKQQAQ9XTrwgYXR690Ph8=; b=r
    oZCItWx704nWfvqRpX/gLZSHNObyV18FxoZmbu8xDC4FBKc9yA6Qb0YeoQJyt2ib
    5pZekL5dLrlIAdYdvKRTXZbJ+q0VzMhtsRp6v7c9w6AxwlvzhadNy0PO1J6dusQg
    o1148kj2m7sIHZVGBY5xo106WXFKlaA0BH+iiZqGOlUq4FKuZl5YvZvhF5FIsY6Z
    xiVcVK48tQ2WBHHkOtKsriJoJOeFzus2Q+W2T17mQhUdq2VgMrocVfaXYMMTEcm0
    Jj3rI13t6W9sgl56TNspv66xqJYDjSoEQOkxsPOjxHIdSKBv3acQUrbVozwOeCq5
    bquPq9onaK2uQ0pMfQdfQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hNnJ4ScS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nXh/Ghsj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hNnJ4ScS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nXh/Ghsj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754834AbeCGXTP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 18:19:15 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38253 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeCGXTO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 18:19:14 -0500
X-Google-Smtp-Source: AG47ELuLhU87mYeICmSaH3y5DLHm1mFD08qweygGcR2Zc/WIv63BAqlPlQQtAzWCg1wFe0RUkKffQg==
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To: James Hogan <jhogan@kernel.org>
Cc: linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <20180307140633.26182-1-jhogan@kernel.org>
 <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
 <20180307202511.GT4197@saruman>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <a6c448df-c026-dafe-6d34-801f69ca64fe@gmail.com>
Date: Wed, 7 Mar 2018 15:19:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307202511.GT4197@saruman>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/07/18 12:25, James Hogan wrote:
> On Wed, Mar 07, 2018 at 12:11:41PM -0800, Frank Rowand wrote:
>> I initially misread the patch description (and imagined an entirely
>> different problem).
>>
>>
>> On 03/07/18 06:06, James Hogan wrote:
>>> On dtb files which contain hyphens, the dt_S_dtb command to build the> dtb.S files (which allow DTB files to be built into the kernel) results> in errors like the following:> > bcm3368-netgear-cvg834g.dtb.S: Assembler messages:> bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'> bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'> bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'> bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'
>> Please replace the following section:
>>
>>> This is due to the hyphen being used in symbol names. Replace all
>>> hyphens 
>>> with underscores in the dt_S_dtb command to avoid this problem.
>>>
>>> Quite a lot of dts files have hyphens, but its only a problem on MIPS
>>> where such files can be built into the kernel. For example when
>>> CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
>>> used (in the latter case it admitedly shouldn't really build all the
>>> dtb.o files, but thats a separate issue).
>>
>> with:
>>
>>    cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
>>    FDT (that is, the .dtb file) as binary data in the kernel image.
>>    This assembly source contains labels before and after the binary data.
>>    The label names incorporate the file name of the corresponding .dtb
>>    file.  Hyphens are not legal characters in labels, so transform all
>>    hyphens from the file name to underscores when constructing the labels.
> 
> Thanks, that is clearer.
> 
> I'll keep the paragraph about MIPS and the example configuration though,
> as I think its important information to reproduce the problem, and to
> justify why it wouldn't be appropriate to just rename the files (which
> was my first reaction).

Other than the part that says "its only a problem on MIPS".  That is
pedantically correct because no other architecture (that I am aware
of, not that I searched) currently has a devicetree source file name
with a hyphen in it, where that file is compiled into the kernel as
an asm file.  But it is potentially a problem on any architecture
to it is misleading to label it as MIPS only.


> 
>> Reviewed-by: Frank Rowand <frowand.list@gmail.com>
> 
> Thanks
> James
> 
