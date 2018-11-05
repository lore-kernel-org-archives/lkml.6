Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBDA2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="k2QKdkCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBDA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=scalemp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeKEP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:57:37 -0500
Received: from www.scalemp.com ([169.44.78.149]:50278 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbeKEP5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yGvX2qns2P7Z2vk+vvmv54KIa1VGENa0sVSJnMfHtBI=; b=k2QKdkCb6IbMMBlVV0NvyXsSNB
        ocwk/9+8ET0Xse2EqaOwKU06Y5PuftuddMzFdPaFPVhCKhejZFbldF6mqTLo8EuJM1r2CPT8NdDrE
        uIK1EF7QmJFBkdTWQRNZssuBa0gMdetbIeBkYP3xBJ5jJWHjko2/niD1dTMUo1SS5OBE=;
Received: from bzq-80-45-146.static.bezeqint.net ([82.80.45.146]:14328 helo=[10.100.0.120])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1gJYXm-0005qF-5E; Mon, 05 Nov 2018 01:39:26 -0500
Subject: Re: [PATCH v2] x86/build: Build VSMP support only if CONFIG_PCI is
 selected
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Shai Fultheim (Shai@ScaleMP.com)" <Shai@ScaleMP.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mhocko@suse.cz" <mhocko@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Oren Twaig <oren@scalemp.com>
References: <2130cd90-2c8f-2fc4-0ac8-81a5aea153b2@scalemp.com>
 <alpine.DEB.2.21.1811042202530.10744@nanos.tec.linutronix.de>
From:   Eial Czerwacki <eial@scalemp.com>
Organization: ScaleMP
Message-ID: <b7d4f31c-ac0c-ccda-4994-e3612fd28799@scalemp.com>
Date:   Mon, 5 Nov 2018 08:39:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811042202530.10744@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings Thomas,

On 11/04/2018 11:05 PM, Thomas Gleixner wrote:
> Eial,
> 
> On Thu, 1 Nov 2018, Eial Czerwacki wrote:
> 
>> Subject: x86/build: Build VSMP support only if CONFIG_PCI is selected
> 
> That's not what the patch does, right?
> 
you are correct, I'll resend it with a more appropriate subject.

>> vsmp dependency on pv_irq_ops removed some years ago, so now let's clean
>> it up from vsmp_64.c.
>>
>> In short, "cap & ctl & (1 << 4)" was always returning 0, as such we can
>> remove all the PARAVIRT/PARAVIRT_XXL code handling that.
>>
>> However, the rest of the code depends on CONFIG_PCI, so fix it accordingly.
>> in addition, rename set_vsmp_pv_ops to set_vsmp_ctl.
>>
>> Signed-off-by: Eial Czerwacki <eial@scalemp.com>
>> Acked-by: Shai Fultheim <shai@scalemp.com>
> 
> Unfortunately that patch does not apply. It's white space damaged, i.e. all
> tabs are converted to spaces.
> 
> Thanks,
> 
> 	tglx
> 

weird, it got applied without any issues on latest git, I'll verify it
applies well.

Eial.
