Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E71ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F132E214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX3yvX14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F132E214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJQV2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:28:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33288 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeJQV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:28:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so12727950plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2vVRehv+/DK5t8nD9otaP27r6ueRtDust8bHJl4AYsk=;
        b=ZX3yvX14LitvTHVLZdIKo1LK68pcqVNwi06851FLU0lBON0O312tFzGczlJIfxDXRN
         cyA2EtigYsD7gBUU34bWHZnt9DO10TB1tjTnjhnq+Urzxf/gMEwJxrp0SnzrtfTrTQXR
         jaUtcrLa78t0NM0FmO3fbg9X7mL73Fuzaem8FMS0oT7J+TVQCnu1l+mwK5dyopa8+A58
         vWZp5I8gVpyZmsOuAPUayPiNLZWSDWizFz5bbgK+9v8KUdM7FLNGj6GP9Ss2c/gVAniK
         MSaonvxfF1At9+ABOUS+QxsJWYp4JfbgQezI7NsseQqyQiSzUygBlW7l4astW+AhNJ9T
         nQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2vVRehv+/DK5t8nD9otaP27r6ueRtDust8bHJl4AYsk=;
        b=s5A5BAFIPqo5/ieoczLp3Ol6+tsZ/4LJqIaGTDSDdosfTUdnPBjgQLn/gGB6hmV++c
         aiGAipe9FWoWJ7K5WPAUpUxcHuNwLQrwvH6DUoz/z9P9QyJqQ4rffKaRZ76iUgIGe4h3
         KcPV48m0nkrPm+AQ310pbLnzrmCw4gjvFUnrHN/xdgtF2h99Uv4uKnn36TEKr3cZXdVa
         XvwIOruu3Iq4pr/+sC87Dlodk6xLld6Qy4ViBFcz1ToMjum3Wdo7hpERYbfX7YcP7ZkI
         Rw0C0eD7wg+gbOroRAYZaQUWaGO7A1df4afE6N63Cw70d+iw0EqpjRD6I6Rr4Vwx7EQO
         7d/w==
X-Gm-Message-State: ABuFfogYLE+U7tc+uqJt0IM0q9NXOYTQT7qmRmOWs56Jtk9oMU1Zeavo
        2ePCNiEZhvhNKoAHpbkH0PM=
X-Google-Smtp-Source: ACcGV61bbmiAZI82DE8BeqWHkXJtWAzA4EmkbohxaqmmsSILEqufJpr2XdxKsC+VQA+CsbVjLtJxgQ==
X-Received: by 2002:a17:902:708b:: with SMTP id z11-v6mr26673694plk.151.1539783159322;
        Wed, 17 Oct 2018 06:32:39 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d3-v6sm2429412pgq.16.2018.10.17.06.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:32:38 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org, tomi.valkeinen@iki.fi
References: <20181017071902.30102-1-geert@linux-m68k.org>
 <20181017091325.GA15991@localhost>
 <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1a51fc4c-882c-59ef-7497-262e595af10e@roeck-us.net>
Date:   Wed, 17 Oct 2018 06:32:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX0G767xYYcd8TDMLBp3cY9+fz_aJFAuz8OxgmCmhbNrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 02:31 AM, Geert Uytterhoeven wrote:
> Hi Josh,
> 
> Thanks for your comments!
> 
> On Wed, Oct 17, 2018 at 11:13 AM Josh Triplett <josh@joshtriplett.org> wrote:
>> On Wed, Oct 17, 2018 at 09:19:01AM +0200, Geert Uytterhoeven wrote:
>>> Providing an explicit list of discrimination factors may give the false
>>> impression that discrimination based on other unlisted factors would be
>>> allowed.
>>
>> This impression is, in fact, false, as has already been discussed
>> elsewhere. I had hoped that discussion would suffice.
> 
> The CoC FAQ is not part of the CoC, and not part of the Linux kernel.
> If the CoC is imprecise, it should be fixed in the CoC, not in a separate
> document hosted elsewhere, as discussed elsewhere.
> 
> Comparison with the GPL and the GPL FAQ is not appropriate, as the GPL
> is still the precise legal document, while its FAQ is a clarification using
> laymen's terms.
> 
>> As mentioned there: The original commit explicitly said "Explicit
>> guidelines have demonstrated success in other projects and other areas
>> of the kernel."; this is precisely the kind of explicit guideline it
> 
> Given the original commit was not submitted for and objected to public
> review, nobody had the chance to question these statements, and ask for
> pointers of proof, which would surely have happened.
> 
>> refers to. Listing explicit cases to cover does not imply other cases
>> are not covered;
> 
> It does, if not accompanied by "examples of...", like in the other sections.
> 
>> it does, however, ensure that the listed cases *are*,
>> and helps people know that they're covered.
> 
> So you agree people cannot know if the unlisted cases are covered or not?
> 
>> This patch is not OK, and defeats one of the purposes of the original
>> change.
> 
> So the purpose of the original change was to list a number of factors,
> without saying that it was just a list of examples?

One could consider adding something like "discrimination factors such as",
or maybe "or any other discrimination factors not listed here" to the
original text. Or a simple "regardless of, for example, ...".

Guenter
