Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE7C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F212086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="1lX6soWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F212086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeKJBhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:37:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45170 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbeKJBhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:37:24 -0500
Received: by mail-pf1-f193.google.com with SMTP id p17-v6so1092734pfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 07:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mxx5WuIUvaQwFiENotIEM2iGleF0g1KX+oZn8G3t8HE=;
        b=1lX6soWqNWTeDdHoozarxggKRx8fItPikjPkVq6R7EgJnzRdLjk4hyWRriBdI+qcEa
         mdHL75fteeem0A6ZdnlrjkTWBozSDNTeNKLluni2Qop/Oma5VRyyWB+YSGBQc31CEuwI
         4THFWfVobySu8qhJq8uqb6kmjd/NG41co6MzPIgT/yfFGrRgUW3pveXiS1dcES7fdyOp
         UnTpnbVFxVuvckj1BibJEmZxYOO0C/IM6IxN2mXd4teFmy+UtHPANiQaW21PqUlRmcpH
         //3vql2jO9K7Sfll7oJI3Ea5tml+mEBNUaTAg/WWoAiMsE5ARkQjWQppoz4SZEoEpeDn
         oi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mxx5WuIUvaQwFiENotIEM2iGleF0g1KX+oZn8G3t8HE=;
        b=SeCrJ7/jWRBZ+wiSuiKEMew0NAt36BhAd9XPqhDHXPowBUmY06xe4h7xECuVE7hz7f
         rqOPAr3OaR4Z9ltJknIALVbnEBiknXRiBvNYfM+aLRqDqD+hlA0xOVCdEfRcMFSPGCjK
         6gPNNyc6NabWOo73Um7hTysRhuITVwGNXZNPlESi/Mg6eY8PgtoQ3SHeybf56cNmlFmB
         G/Ov4UDEqxjWZwjvfBh0rLAB9gG3KN0kJg50tSgvbHa8DSPZyG8X1zomMDOIF+x8CeIp
         hvpqO+iK8T1fTvr8ajm8cv8KpmiG6tRkzNF5bUdoawCxfrluctFb9u9EYz48AqTzRnuZ
         H91w==
X-Gm-Message-State: AGRZ1gID5ZFrEEW+Ch0xEkoIPM0Gedoj3OI3B+kWSkUkS2BRhByODZsB
        kqP4sdX96Br+vkuF2kq5/Uie9w==
X-Google-Smtp-Source: AJdET5e9hmWvn5qpPET8sJL9EW1SpVue6M5UpIYpnH5JM+u/ZooGCZxypBSGTNBgR5jZbrOPQMqmYA==
X-Received: by 2002:a63:d252:: with SMTP id t18mr7976033pgi.133.1541778975058;
        Fri, 09 Nov 2018 07:56:15 -0800 (PST)
Received: from ?IPv6:2601:646:c200:7429:5da1:e35c:4291:b7e7? ([2601:646:c200:7429:5da1:e35c:4291:b7e7])
        by smtp.gmail.com with ESMTPSA id f32sm6365186pgf.80.2018.11.09.07.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 07:56:13 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 06/13] arc: define syscall_get_arch()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <456a69c6e01a6ab5b1af6d459a249388f8b4c1f5.camel@synopsys.com>
Date:   Fri, 9 Nov 2018 07:56:12 -0800
Cc:     "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "ldv@altlinux.org" <ldv@altlinux.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "lineprinter@altlinux.org" <lineprinter@altlinux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6CF3942-3307-431F-B76C-B550BB48F472@amacapital.net>
References: <20181109031605.GF21511@altlinux.org> <e729da9ed78b6b62463a27d3012ac63c7b66be08.camel@synopsys.com> <CALCETrUzfOcLYDUW6s1Ra2xduDCQSbscKBw=vApCP2HNmfDmMw@mail.gmail.com> <456a69c6e01a6ab5b1af6d459a249388f8b4c1f5.camel@synopsys.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 9, 2018, at 7:27 AM, Alexey Brodkin <alexey.brodkin@synopsys.com> w=
rote:
>=20
> Hi Andy,
>=20
>> On Fri, 2018-11-09 at 07:17 -0800, Andy Lutomirski wrote:
>> On Fri, Nov 9, 2018 at 6:22 AM Alexey Brodkin
>> <alexey.brodkin@synopsys.com> wrote:
>>> Hi Dmitry,
>>>=20
>>>> On Fri, 2018-11-09 at 06:16 +0300, Dmitry V. Levin wrote:
>>>> syscall_get_arch() is required to be implemented on all architectures
>>>> that use tracehook_report_syscall_entry() in order to extend
>>>> the generic ptrace API with PTRACE_GET_SYSCALL_INFO request.
>>>>=20
>>>> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>>>> ---
>>>> arch/arc/include/asm/syscall.h | 6 ++++++
>>>> include/uapi/linux/audit.h     | 1 +
>>>> 2 files changed, 7 insertions(+)
>>>=20
>>> [snip]
>>>=20
>>>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>>>> index 818ae690ab79..a7149ceb5b98 100644
>>>> --- a/include/uapi/linux/audit.h
>>>> +++ b/include/uapi/linux/audit.h
>>>> @@ -375,6 +375,7 @@ enum {
>>>>=20
>>>> #define AUDIT_ARCH_AARCH64   (EM_AARCH64|__AUDIT_ARCH_64BIT|__AUDIT_ARC=
H_LE)
>>>> #define AUDIT_ARCH_ALPHA     (EM_ALPHA|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_=
LE)
>>>> +#define AUDIT_ARCH_ARC               (EM_ARC)
>>>=20
>>> Similarly here we need to have:
>>> ---------------------------->8-----------------------------
>>> +#define AUDIT_ARCH_ARC         (EM_ARC|EM_ARCV2)
>>> ---------------------------->8-----------------------------
>>>=20
>>=20
>> Huh?  How does the bitwise or of two ELF machine codes make any sense?
>=20
> Oops... I didn't read examples of AUDIT_ARCH_ALPHA above :(
> Indeed that was stupid.
>=20
> But what would be a proper fix then?
>=20
> Something like that?
> ---------------------------->8-----------------------------
> #define AUDIT_ARCH_ARC               (EM_ARC)
> #define AUDIT_ARCH_ARCV2             (EM_ARCV2)
>=20
>=20
> static inline int syscall_get_arch(void)
> {
> #ifdef __ARC700__
>       return AUDIT_ARCH_ARC;
> #else
>       return AUDIT_ARCH_ARCV2;
> #endif
> }
> ---------------------------->8-----------------------------
>=20

Maybe, but I know basically nothing about ARC.  Is the syscall numbering or c=
alling convention different on ARC vs ARCv2?=
