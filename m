Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896FA21928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550165430;
	bh=ASf4pYfYVWSJ0s9v+bOJe5mxCUCfKnH/BFxEAGaaE7w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TZAdFSkhVlPMZwhGJJpyWmbN0iy+bPNqk/YJjjsHotnNkJTwYurMAWpneP7bd+3YL
	 qvmyE8qLQeHDkKFsDRrEwHb/ilnnKh80m4jiiC10zeIh71T9zyvX3IzUOeXF0qBDcF
	 mrH9JWPhDSP4WyX2dwPJmbHqW6Ak7Uh7r/VuWthc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391854AbfBNRa3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:30:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33314 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfBNRa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:30:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so11909881otl.0;
        Thu, 14 Feb 2019 09:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ur4rPsJElo5qisAM9X+lHUboSZFPsVJFS133hJiSNNc=;
        b=OdQ1hxF+f632omFJhIdmfLvcbXcLJaqP/HEB1JFSMjfskgFuJyQVkqdnlXLX2TZDqk
         hQGfaZBjR/7oVDA8+1OksuWFtcgFl3zmV3sLG4N3AgNHHP52y1BzxhVu9Pbp2VlL1Ppv
         WTDbw6beE0dlmy0D9hqRsSdksStXAwhZI7HyWucs3Vk7X0KY0XE4qrpVXLxseisdp4K0
         T/HHQQSdgFBlGfn46mtpIEWdUzwHw45LzOgqTWTpbQmspBefdCNWmPFVs6uUdrhdFuyZ
         ZyXAioA59NYLUASi6DH+4yzQIJTlRUoOpjju/4L45HCg6mafGkvhJ/EPqpmhbuVkcCeh
         FRSg==
X-Gm-Message-State: AHQUAub0BmXiMVos5nnSizyeLzcsDAyhJVv1wsXubgFA9Saj/JWzUvtM
        PeVJix3qclGyIG/SnKJHf/OKub2lRlu3k+v+QlUEHrT4
X-Google-Smtp-Source: AHgI3Ia9XUHEN3+oQNRsXlpkor+ChSZr045xNcpcC18vxuWY9UhRWSo4QsrC/UO7U+hXFATe70TMLW7gTmQv433O4Hc=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr3072357otl.343.1550165428024;
 Thu, 14 Feb 2019 09:30:28 -0800 (PST)
MIME-Version: 1.0
References: <20190213122105.14270-1-e.velu@criteo.com> <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
 <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com> <4c1e9d87-6e4c-2bca-f069-c071ad561788@criteo.com>
In-Reply-To: <4c1e9d87-6e4c-2bca-f069-c071ad561788@criteo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Feb 2019 18:30:16 +0100
Message-ID: <CAJZ5v0g64Zw9LZ5v7yo_Df0Dh2w0md+OTQB07jw4k7t+eXWQfg@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
To:     Erwan Velu <e.velu@criteo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erwan Velu <erwanaliasr1@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 4:18 PM Erwan Velu <e.velu@criteo.com> wrote:
>
>
> Le 14/02/2019 à 11:22, Rafael J. Wysocki a écrit :
> > On Thu, Feb 14, 2019 at 10:28 AM Erwan Velu <e.velu@criteo.com> wrote:
> >> Hey rafael,
> >>
> >> Does the V6 looks good to you ?
> > I've queued it up with some manual changes.  No need to update.
>
> Ok, cool. What kind of changes ?

Nothing fundamental:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=076b862c7e4409d2dcacfda19f7eaf8d07ab9200

> I'd love to understand what I missed.

It's more about my preferences.
