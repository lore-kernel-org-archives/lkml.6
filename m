Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C2CECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBD9214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 05:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="X0a1xj2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBD9214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeGMGIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:08:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36758 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbeGMGIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:08:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id u16-v6so21985030pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 22:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wkm3bfzar6t14Nsc7DBsW/R43uGmUJ6STeuCrttpST0=;
        b=X0a1xj2UntRht/r+ZXDyH0uPVGBXhW/VtFs3sIeHqlmrl0kAVtwXxKqCcAK6pLh+56
         5bmv3i3XTqfxLlXhJAGyt3fJ5gYTv8aicqUkklOwgla4fh1qVLIULGG8ji+wZplyZngi
         ngJNbFX+zLsGwr2S+8NocmggEl13ThRr9qyhWafM+KUav/8dPJx/pcJ2kZuJfTmVtCar
         lYxyCz1UGm521jk1OsLeX8iXK7/eFS4lkS+35vtVuVtw+JxUuw1yzbHs3Bdjfq3dMPEM
         rlBbXmVhv2Hnj+bKyVf+HkBdeXmCHlnmK6cDIXeJKWJKInyaMny9HUaz3xcenFf+E9a3
         R+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wkm3bfzar6t14Nsc7DBsW/R43uGmUJ6STeuCrttpST0=;
        b=cp779Tn5hSXAeixd0nBImMr6hMGabR5O28xK6qeX3I13SW/6+lYBU/jQ7Gc6+b//q2
         7FwbOj1cqQ2o8FzxNI29yASmL+4fRccUceyW7JUnsH7ahG3xkHvva16WfbUjPArTnGNn
         +cDxGHz1TIPLNwYwCpwTrREB9/G97FSPK0gi3qwn08fGlceJj6sD7W3yzaJ8ync9ME2r
         JMMcpGXoB67JXGVgA8wwHSIS4/uvo3Hg8cQlQJY/Q6ISi5yl7U3686sJH9kqpwruiPXv
         4zQZ9Zd0ezxpmkGxUsugjMs4X2zZzbrdaHsjOoZeX8EwF3Fltj6e/Y9W+6iL9L/RKIg7
         /7NQ==
X-Gm-Message-State: AOUpUlGaVoEpzVeytqHahrUMKOwy7yzoJxB7bGRJgEQuitrFV4d3jUbX
        ubZ6qqTVxccjdlml9Am5RoAKyg==
X-Google-Smtp-Source: AAOMgpfKvk7f5PiZrazdyTcde4MHLo2S/RsYsWkVrGRemzosyBByLh+QeI90VLCK3p55DrHNSpRMhg==
X-Received: by 2002:a62:1016:: with SMTP id y22-v6mr5558534pfi.109.1531461334352;
        Thu, 12 Jul 2018 22:55:34 -0700 (PDT)
Received: from ?IPv6:2600:1011:b009:487e:8936:3ba4:5f0d:c82e? ([2600:1011:b009:487e:8936:3ba4:5f0d:c82e])
        by smtp.gmail.com with ESMTPSA id r16-v6sm45739335pfe.173.2018.07.12.22.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 22:55:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <66016722-9872-a3f9-f88b-37397f9b6979@intel.com>
Date:   Thu, 12 Jul 2018 22:55:30 -0700
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E04B6EB-8EEE-4A09-9C41-017D31A1A748@amacapital.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com> <20180710222639.8241-19-yu-cheng.yu@intel.com> <bbb487cc-ac1c-f734-eee3-2463a0ba7efc@linux.intel.com> <1531436398.2965.18.camel@intel.com> <46784af0-6fbb-522d-6acb-c6248e5e0e0d@linux.intel.com> <167645aa-f1c7-bd6a-c7e0-2da317cbbaba@intel.com> <55A0592D-0E8D-4BC5-BA4B-E82E92EEA36A@amacapital.net> <66016722-9872-a3f9-f88b-37397f9b6979@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 9:16 PM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 07/12/2018 07:21 PM, Andy Lutomirski wrote:
>> I am tempted to suggest that the whole series not be merged until
>> there are actual docs. It=E2=80=99s not a fantastic precedent.
>=20
> Do you mean Documentation or manpages, or are you talking about hardware
> documentation?
> https://software.intel.com/sites/default/files/managed/4d/2a/control-flow-=
enforcement-technology-preview.pdf

I mean hardware docs. The =E2=80=9Cpreview=E2=80=9D is a little bit dubious I=
MO.=
