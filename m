Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB3BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF4F2157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmZ9w4sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF4F2157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbeHGPXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:23:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51365 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbeHGPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:23:46 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so17401704wma.1;
        Tue, 07 Aug 2018 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=V46jSAW3LK1RygBGOc4AtA+DWgUoK2VRppZwcGOHSwI=;
        b=RmZ9w4sj+FrI00SqaY2FuccSkFdzU4v6YYOTsjG44+E2cq3B5p7bh/Mvg4kNMxTnAh
         XA/2FSuuHiIg2hd4UqLdnMhtGV297Om2zrFscosvLpWxnmTBzC8tDdtKDPA+lxaCne5d
         f9onHJ9rKb1mYkTz06LbaJna+lDbvDOoK7mEvQ6oSaoXjEIo5/OUr3sD2Dsxnn7qfmFP
         IQ43K59gwu7GBz524UoFnFpqn0o/yGpuks2D9dxbvT0djIZRt3oK7KXSFqjr/aBex12f
         qFLPba4pKCbpQ1dXBABEPXjAWcbcSwi/XVUmd5jglTp5VXhK1GVJxlXp7o1+FnEwZTth
         CjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to;
        bh=V46jSAW3LK1RygBGOc4AtA+DWgUoK2VRppZwcGOHSwI=;
        b=RaS/zSkPt4lgcnMNWP2XxVaTkIHkGC6TxHOQYWSW+ZAEwdPTfFqUCWPm3QK/B1lCYI
         u3I3/3rzqut4Jy/01hQPnld9RfrpH+avQJFDtMv2B2RIDe1kFDo7fbRiE4V6eJypNkoV
         qyOemE2mr9+awEp+cHMR61Dl9m/8D94vL+1jL30e/gd4T6R1403RgpUo0jInBsu1Wa0w
         hASypAJlmrDY0LkoPlOk1uv1ZFlkD0BnJexm6RlTU4C/VtFROUXHxV/zhcOEhdQG72S+
         Vm7aOIxWCn1HxWycgfxszvstlefgOJR+jfRwYTRQljvA8YqaCVWUrsNCTkd9w22xXjVR
         iMJQ==
X-Gm-Message-State: AOUpUlGvZA17XxsowFtDIcXYf7+/BzTtpkmytkSV4OnEVsb7XS1R/jVs
        fs1LCuHR7iS+N8Ek+l/UgCDc7aoq
X-Google-Smtp-Source: AA+uWPwaabJyS3d627ajVPOIQ05Ddlh9qLw+TyRNRmlNeuHecSx+h46lCTCpJ0QsCMptIeNcIqZz2g==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr1721767wmd.36.1533647367848;
        Tue, 07 Aug 2018 06:09:27 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-235-128.clienti.tiscali.it. [78.12.235.128])
        by smtp.googlemail.com with ESMTPSA id 7-v6sm3156512wmr.16.2018.08.07.06.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:09:26 -0700 (PDT)
Subject: semantic conflict between tip and kvm (was Re: linux-next:
 Signed-off-by missing for commit in the kvm tree)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180807073922.665e1d63@canb.auug.org.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <8939315c-f509-ad12-3484-4650c7f3b351@redhat.com>
Date:   Tue, 7 Aug 2018 15:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807073922.665e1d63@canb.auug.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="91gCpN5DVlRuaBBbJ1VsyYqfUmbAzZOaf"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--91gCpN5DVlRuaBBbJ1VsyYqfUmbAzZOaf
Content-Type: multipart/mixed; boundary="gH6TBERMb1gtR7mLPYF2VUfk3UqhaVoX5";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <8939315c-f509-ad12-3484-4650c7f3b351@redhat.com>
Subject: semantic conflict between tip and kvm (was Re: linux-next:
 Signed-off-by missing for commit in the kvm tree)
References: <20180807073922.665e1d63@canb.auug.org.au>
In-Reply-To: <20180807073922.665e1d63@canb.auug.org.au>

--gH6TBERMb1gtR7mLPYF2VUfk3UqhaVoX5
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/08/2018 23:39, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   81781b6884bd ("KVM/x86: Use CC_SET()/CC_OUT in arch/x86/kvm/vmx.c")
>=20
> is missing a Signed-off-by from its committer.
>=20

Stephen,

there is a semantic conflict between tip and kvm:

const __initconst struct hypervisor_x86 x86_hyper_kvm =3D {
	.name			=3D "KVM",
	.detect			=3D kvm_detect,
	.type			=3D X86_HYPER_KVM,
	.init.init_platform	=3D kvmclock_init,
	.init.guest_late_init	=3D kvm_guest_init,
	.init.x2apic_available	=3D kvm_para_available,
	.init.init_platform	=3D kvm_init_platform,
};

Note that .init.init_platform is initialized twice.

The right fix is to keep the kvm version, and add a kvmclock_init() call
to kvm_init_platform.

Thanks,

Paolo


--gH6TBERMb1gtR7mLPYF2VUfk3UqhaVoX5--

--91gCpN5DVlRuaBBbJ1VsyYqfUmbAzZOaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAltpmgUACgkQv/vSX3jH
roPZkgf/WSDhT/epJdVQN7IDI2ERn4xIMqxdyqA1Y83Twpiz/WrsmFIa24SNTsJt
DTxN1oWINvMi55CLv1BNRlj1uby0EMHwZm59yKvZfm3KhaIgmE+KNtytvaZTErYH
n8qUcYMhwmDS4lIbrjXsgMUvU2+LjVd/AYC95uEavVdg5la5wk13Hc3Y2KUB1p5f
Xrw+12h+4A2n4ciTHXx6YZgMNKWAKRS1fnnAMAJh7nAUXmC7NBO7gpRRT+oJRE75
DrGin8zE7WWv35lIdwoc483WeQP4epztRs16+WLaKuEgQqgu1G3D+l56A4vKQA+1
jptE2eigJgtZbkV7pK0CvgCeKbYo4Q==
=XwHs
-----END PGP SIGNATURE-----

--91gCpN5DVlRuaBBbJ1VsyYqfUmbAzZOaf--
