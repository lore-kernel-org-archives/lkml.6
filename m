Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A1CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C4320818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeSPhr/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C4320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407394AbeKWHtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:49:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39448 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbeKWHtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:49:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so2492514wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 13:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3fwIi1HS+B7IqHTnxe4GTaBPBU0ZPbNlR7rFtZhpXrc=;
        b=jeSPhr/YrQkmBYIUxP336rNiADqHILN1LHSlMWcRRSAoU7ZyDMMx+38FWmGQITz3du
         7fG9O4zR6mEp6XTqKeSn93s4WYy3d6TN2O/09zVAwdFGNJimbJdLdrej6kg/dhhd3XhB
         pvXU1GgHDXr94XKPb801kwMxMS8M+LgnJo8l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3fwIi1HS+B7IqHTnxe4GTaBPBU0ZPbNlR7rFtZhpXrc=;
        b=c7vo23XCc7zXbCIi4ZffYugV0KGfQPtZuGvmcRb2TVRJrK7MoVPfoPrmWOdL2mG7NC
         MSJ+g7o7a37EFrU91Y0yd0xxKzLlMi5tZW3eQSH4HOcsXyu2M9k2lqeigK/OURmvz/43
         W4hyZPevnGduH7EoOql94Z+U7jX34uo7TFiqZH2QMkdTVwJlcanBqDQeHSRlnBI0Wy4f
         h119zaOig7OlQWxw67CT6Fy1tZP9Hi8teutvuvAUV+kezTulXPaj7uUHmEiOvOlviCJQ
         dCUqVtzb7DS9RxqBJVZHiAQ4uM+nXJlnzyRZx+sJefNVUwjkyTQ4D0mx3qySLWuhSUso
         tv9A==
X-Gm-Message-State: AA+aEWaO6OHT9oN9ARS0bsYKgIgtzqRpuPmeBwwmKhulXhHW7n4W1tZI
        h1cdPiGx0p/cKw09WN4nO41BMQ==
X-Google-Smtp-Source: AFSGD/UnbNFGx3Xr1bxXeiHfwJN0Qq8HUi5bRAnMjW+VuCRJS/h2Egi8LR5ObpHXdM9ELyRsYTUzyQ==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr3230402wrw.304.1542920882556;
        Thu, 22 Nov 2018 13:08:02 -0800 (PST)
Received: from [192.168.1.54] (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id 60sm26154756wrb.81.2018.11.22.13.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 13:08:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] bpf: add __weak hook for allocating executable memory
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <201811230404.yavKPUOn%fengguang.wu@intel.com>
Date:   Thu, 22 Nov 2018 22:08:00 +0100
Cc:     kbuild-all@01.org, linux-arm-kernel@lists.infradead.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <800264DE-658A-46B4-8FA1-CD1CF314AA7A@linaro.org>
References: <20181121131733.14910-2-ard.biesheuvel@linaro.org> <201811230404.yavKPUOn%fengguang.wu@intel.com>
To:     kbuild test robot <lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 22 Nov 2018, at 21:01, kbuild test robot <lkp@intel.com> wrote:
>=20
> Hi Ard,
>=20
> I love your patch! Yet something to improve:
>=20

Ugh, apologies for this. I=E2=80=99m sure i build tested /something/ but cle=
arly not what i should have tested.

In any case, following up on the discussion I=E2=80=99ll have to respin this=
 in any case. I=E2=80=99ll triple check next time that what i send out was t=
ested properly.


> [auto build test ERROR on bpf-next/master]
> [also build test ERROR on v4.20-rc3 next-20181122]
> [if your patch is applied to the wrong git tree, please drop us a note to h=
elp improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/bpf-permit=
-JIT-allocations-to-be-served-outside-the-module-region/20181123-033144
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git m=
aster
> config: x86_64-randconfig-x002-201846 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=3Dx86_64=20
>=20
> All error/warnings (new ones prefixed by >>):
>=20
>   kernel//bpf/core.c: In function 'bpf_jit_free_exec':
>>> kernel//bpf/core.c:632:24: error: 'size' undeclared (first use in this f=
unction); did you mean 'ksize'?
>     return module_memfree(size);
>                           ^~~~
>                           ksize
>   kernel//bpf/core.c:632:24: note: each undeclared identifier is reported o=
nly once for each function it appears in
>>> kernel//bpf/core.c:632:9: warning: 'return' with a value, in function re=
turning void
>     return module_memfree(size);
>            ^~~~~~~~~~~~~~
>   kernel//bpf/core.c:630:13: note: declared here
>    void __weak bpf_jit_free_exec(const void *addr)
>                ^~~~~~~~~~~~~~~~~
>=20
> vim +632 kernel//bpf/core.c
>=20
>   629   =20
>   630    void __weak bpf_jit_free_exec(const void *addr)
>   631    {
>> 632        return module_memfree(size);
>   633    }
>   634   =20
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Cen=
ter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporat=
ion
> <.config.gz>
