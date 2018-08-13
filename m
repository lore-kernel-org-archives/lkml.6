Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A013C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2195E218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 16:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtQihkIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2195E218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeHMTaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:30:20 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52780 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMTaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:30:20 -0400
Received: by mail-it0-f53.google.com with SMTP id d9-v6so14025426itf.2;
        Mon, 13 Aug 2018 09:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0ah28Y4g9AbJacStdc3sjq0WkcrnFKpb+tUdAS4ntb4=;
        b=OtQihkIhxnxGkJPc2hjDobsdxZhf6RIS0paMAUBlOEXEbMKoB2zjpAtiQ+8RFmBhif
         YblLAFiqhtkZdhpG52z7Uogc52IOUygCX1Gh1GH0xI7LKPElvketXay0Ldr91wx9n0CN
         LPMxccMevvS7dMkW0shanYF0O9ArfIPn/NNxOy15w4oA/DUP3cdxDsz39hkIGbGppr2H
         LEU8cwGwFoOQmlz3StQay8/nI4CRIoDqO7OxMvvG+JLT47EXnlBLFgExnJU1dtzsIFGH
         jaMcrCgJLAIRtNhotw8CoBy0TkeNhQK1aZjhIpgplPrFY2FfR5jYCYV2xy0Jy9RhDyOt
         dD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0ah28Y4g9AbJacStdc3sjq0WkcrnFKpb+tUdAS4ntb4=;
        b=TDf7EGN5BQcIAPBU3/9oEPJN2zt4xLS1udpdZVI9ivh3C2Cvnq9SUFQgIp0f9YpO79
         0vFGwe/QX5iBf2rgGdWfY8Sw4KwmAGZSAIVDAOZdfKL7l8+Xy8zuuemD4sJOfRFgeFfr
         cXHkLqvVKrgnwdO5y+jhHoo8ue8hmNZBmgeA35CBe5KwcGlwDym9WeVsZDmop+Hc6kS+
         V4r1d8iCxgq+DI10tcJ9mdV5u9vEmq+Bz5JF4t85itOmgXq7eFK3oOhJ1aQbrw4pRdWc
         O5LuN+8tP+Cmcakpvcd+sfELxagd/EWzfRAlPDZTJYI1IL/aL9BONAZhK3uapLteZfxS
         l9IA==
X-Gm-Message-State: AOUpUlE0wTKDBBepsqeirdiF3HgFpFN7umKw6Dce1vij/uR8ZSFtaLtW
        WCt2A6Vf5GR3eO0sPd2U0Inbvxd5kZNRar+uxRI=
X-Google-Smtp-Source: AA+uWPyO3Q6pD/i9XJY4fOtsAJxGkWtM7vZmo0Cd2D/ye3uVY9RWVBeTk8gvvPH3NBwnypwR1VvgJAPIom5ZnStk8Jk=
X-Received: by 2002:a24:92d4:: with SMTP id l203-v6mr11126374itd.63.1534178839579;
 Mon, 13 Aug 2018 09:47:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:5a03:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 09:47:19
 -0700 (PDT)
In-Reply-To: <68538d23-8880-29a2-decd-f63b48667274@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn> <cb1a56c95bbcc4d65a98378274ae34d826704a16.1533989493.git.puwen@hygon.cn>
 <CAO6F7DkdV1p59igFY3atTCRK62KH3_J-874oQw1v6ighaHOTXA@mail.gmail.com> <68538d23-8880-29a2-decd-f63b48667274@hygon.cn>
From:   Michael Jin <mikhail.jin@gmail.com>
Date:   Mon, 13 Aug 2018 12:47:19 -0400
Message-ID: <CAO6F7DnU=nB+mf458sRBH0ozub8bog9-zi8-awYBJumkEjDdXg@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] driver/edac: enable Hygon support to AMD64 EDAC driver
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 12:17 PM, Pu Wen <puwen@hygon.cn> wrote:
> On 2018/8/12 3:56, Michael Jin wrote:
>>
>> On Sat, Aug 11, 2018 at 9:30 AM, Pu Wen <puwen@hygon.cn> wrote:
>>>
>>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>>> -       if (pvt->fam == 0x17) {
>>> +       if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {
>>>                  __f17h_set_scrubval(pvt, scrubval);
>>
>>
>> Separating the vendor check as an "else if (pvt->vendor ==
>> X86_VENDOR_HYGON)" block would make architectural changes (future
>> hygon models, i.e. 19h, 20h, etc) less confusing.
>
>
> Your suggestion is reasonable, but that might make the branch a little
> complicated.If we explicitly testing Hygon family in condition case,
> will that be ok?
> +    if (pvt->fam == 0x17 ||
> +       (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18))

The condition case for family 18h and vendor Hygon looks better
because it is more clear.

Michael
