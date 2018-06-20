Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA615C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6A020875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bwRA7xCS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aQU03TzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6A020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeFTWfN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:35:13 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44182 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933555AbeFTWfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:35:11 -0400
Received: by mail-yw0-f193.google.com with SMTP id k18-v6so430075ywm.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=goL/kE6jWNPyenlWn/9GKinpPpxFWEcoT3NnCmCy0DY=;
        b=bwRA7xCSQMw+LmXh8z16ORKI2Bk6RONqt7NaMXOdBebPBIklgKdmm2r1e5JrHJQ7i9
         IYt6HXwFPzWw4mybf8+vROg5vAz4SdRKacKIbGwgMxL8OVcLsVLPA7B++PbGTGT1WKfY
         zFuhPyh88kBUb+uIMiSzSficlY7NGn1gNaZtek5tihfOPtM7zfIVh5CksU0kDzREOI8/
         E1bdtk++pstHv62xTO/nwmrNR/ul+Ozsgyce61J6VTasLRkKHhKgwAfgLJ1TbsryicXI
         nkyu2H/UziUF4IJhCA52OLFbCMU0yNNPy5Tu8IQeqVoldcoCzI2MdW3wLuWCR6AQHZRG
         GzSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=goL/kE6jWNPyenlWn/9GKinpPpxFWEcoT3NnCmCy0DY=;
        b=aQU03TzM3jEhCbDwAZJ6A5119aRlNdT3h9EYAT3QIlPKUMbVefmPUSI0BmtiryCWUO
         9OiGokCvdAGQYdp8F/0KaNYXJtKkrvQF69t+1Shao1OaWczWopM1HzpQSLYmiQTf1gUA
         M+sVkH4gTjdAyCr/TOXjoJgT9twMVJnMI655I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=goL/kE6jWNPyenlWn/9GKinpPpxFWEcoT3NnCmCy0DY=;
        b=Lfla4G6jpIQW3XvW8GUalMuYHGbw3LG6fzf4NP0zBYZK1W+WYGMmjasDUUZu1ncls+
         S17uiQYSKcbNOC+zT2bVNdCMj1d9Hyve0aQpDKUmxnvPV9rcDql9SL7/ViPsmY2BPxnC
         iEG0Da0lxP2qGl18bLstdJGVUrzR78cb34UgTnSKQTlvqoiWW4E9unjw+dYCDFiKVtr3
         oVI4nE0VqQp2/jvItNRLPIet7UCl9fVDqGwz5cw3vD6IR1VlQK/XWt/cLOUgHStP/WdM
         CnH9DEyiTcnDOiJhEiRFmwG7tKHYQxpoA1HF+O8SNu/AvwUKVb4IEzHL8dN6396cz/uy
         ESjg==
X-Gm-Message-State: APt69E1yYXLe24ObWOt+CC6X54BvIiM5ZLX/6oF5sV7ktofCc5B7draz
        /pc8/znUgwXO9tj79JcfWhsUsphbRypaD2l8ACtEvQ==
X-Google-Smtp-Source: ADUXVKKwzeVoP3DI6lAfhRM85eIy+/R0SLOYWkbEYKUnbiAYBfpQ0Nh5GNd7UZgjThsz7vCkZVHr6XleDvpNTMDdqPQ=
X-Received: by 2002:a81:3b04:: with SMTP id i4-v6mr10852027ywa.38.1529534111064;
 Wed, 20 Jun 2018 15:35:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 15:35:10
 -0700 (PDT)
In-Reply-To: <12014310-19f7-dc31-d983-9c7e00c8b446@infradead.org>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
 <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com> <12014310-19f7-dc31-d983-9c7e00c8b446@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 15:35:10 -0700
X-Google-Sender-Auth: FADzXAacuG9mF8uLVdRfCZGDqJ8
Message-ID: <CAGXu5j+RgbMKqiBcsWMOZ-ci-rT19imgCoHtPKgDURF1tC+COg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen Accardi <kristen.c.accardi@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 3:16 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 06/20/2018 03:09 PM, Rick Edgecombe wrote:
>> +void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
>> +                     gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
>> +                     int node, const void *caller)
>> +{
>
> so this isn't optional, eh?  You are going to force it on people because?

RANDOMIZE_BASE isn't optional either. :) This improves the module
address entropy with (what seems to be) no down-side, so yeah, I think
it should be non-optional. :)

-Kees

-- 
Kees Cook
Pixel Security
