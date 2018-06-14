Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9E0CEC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BA2208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 12:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BA2208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=feldspaten.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964800AbeFNMny (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 08:43:54 -0400
Received: from feldspaten.org ([78.46.71.109]:49262 "EHLO feldspaten.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754809AbeFNMnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 08:43:52 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 08:43:51 EDT
Received: by feldspaten.org (Postfix, from userid 5005)
        id BB6DC8C0865; Thu, 14 Jun 2018 14:37:46 +0200 (CEST)
Received: from [138.232.146.54] (pc54-c706.uibk.ac.at [138.232.146.54])
        (Authenticated sender: felix@feldspaten.org)
        by feldspaten.org (Postfix) with ESMTPSA id B91BF8C0805;
        Thu, 14 Jun 2018 14:37:43 +0200 (CEST)
From:   Felix Niederwanger <felix@feldspaten.org>
Subject: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Borislav Petkov <bp@suse.de>
Cc:     Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
 <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=felix@feldspaten.org; keydata=
 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
 bgu+FykyaCU=
Message-ID: <6a58d83a-c5c7-b706-79fc-b68e1e479bff@feldspaten.org>
Date:   Thu, 14 Jun 2018 14:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="GRJRHVooK1R4u47YSuEVSvGSBiUBCyDLN"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GRJRHVooK1R4u47YSuEVSvGSBiUBCyDLN
Content-Type: multipart/mixed; boundary="IScDJ4i7dgSF7tpcxnfEDioZmVIN3QGw2";
 protected-headers="v1"
From: Felix Niederwanger <felix@feldspaten.org>
To: Brijesh Singh <brijesh.singh@amd.com>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>
Message-ID: <6a58d83a-c5c7-b706-79fc-b68e1e479bff@feldspaten.org>
Subject: [PATCH] Use 'imply' with SEV Kconfig CRYPTO dependencies
References: <1526915573-22917-1-git-send-email-Janakarajan.Natarajan@amd.com>
 <20180523144621.GB25143@pd.tnic>
 <CAFLxGvyxHU_Xahwdf=0TYx8Nems78TLioLZGGLTkxNGCgxT4Dg@mail.gmail.com>
 <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>
In-Reply-To: <4f565a11-9e99-b861-06d2-b42922e44c7a@amd.com>

--IScDJ4i7dgSF7tpcxnfEDioZmVIN3QGw2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14/06/18 14:08, Brijesh Singh wrote:
>=20
>=20
> On 6/14/18 2:58 AM, Richard Weinberger wrote:
>> On Wed, May 23, 2018 at 4:46 PM, Borislav Petkov <bp@suse.de> wrote:
>>> + Tom and Brijesh.
>>>
>>> On Mon, May 21, 2018 at 10:12:53AM -0500, Janakarajan Natarajan wrote=
:
>>>> Use Kconfig imply 'option' when specifying SEV CRYPTO dependencies.
>>>>
>>>> Example configuration:
>>>> .
>>>> .
>>>> CONFIG_CRYPTO_DEV_CCP=3Dy
>>>> CONFIG_CRYPTO_DEV_CCP_DD=3Dm
>>>> CONFIG_CRYPTO_DEV_SP_CCP=3Dy
>>>> CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
>>>> CONFIG_CRYPTO_DEV_SP_PSP=3Dy
>>>> .
>>>> .
>>>> CONFIG_KVM_AMD=3Dy
>>>> CONFIG_KVM_AMD_SEV=3Dy
>>>> .
>>>> .
>>>>
>>>> When the CRYPTO_DEV_SP_DD is m, KVM_AMD set to y produces compile ti=
me
>>>> errors.
>>>>
>>>> Since KVM_AMD_SEV depends on KVM_AMD and CRYPTO_DEV_CCP_DD, the
>>>> issue can be prevented by using 'imply' Kconfig option when specifyi=
ng
>>>> the CRYPTO dependencies.
>>>>
>>>> Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for =
SEV")
>>>>
>>>> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>=

>>>> ---
>>>>  arch/x86/kvm/Kconfig | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
>>>> index 92fd433..d9b16b7 100644
>>>> --- a/arch/x86/kvm/Kconfig
>>>> +++ b/arch/x86/kvm/Kconfig
>>>> @@ -85,7 +85,9 @@ config KVM_AMD_SEV
>>>>       def_bool y
>>>>       bool "AMD Secure Encrypted Virtualization (SEV) support"
>>>>       depends on KVM_AMD && X86_64
>>>> -     depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_S=
P_PSP
>>>> +     imply CRYPTO_DEV_CCP
>>>> +     imply CRYPTO_DEV_CCP_DD
>>>> +     imply CRYPTO_DEV_SP_PSP
>>>>       ---help---
>>>>       Provides support for launching Encrypted VMs on AMD processors=
=2E
>>> Well, this solves the build issue but I just created a config:
>>>
>>> $ grep -E "(KVM|PSP)" .config | grep -v '#'
>>> CONFIG_HAVE_KVM=3Dy
>>> CONFIG_HAVE_KVM_IRQCHIP=3Dy
>>> CONFIG_HAVE_KVM_IRQFD=3Dy
>>> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
>>> CONFIG_HAVE_KVM_EVENTFD=3Dy
>>> CONFIG_KVM_MMIO=3Dy
>>> CONFIG_KVM_ASYNC_PF=3Dy
>>> CONFIG_HAVE_KVM_MSI=3Dy
>>> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
>>> CONFIG_KVM_VFIO=3Dy
>>> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
>>> CONFIG_KVM_COMPAT=3Dy
>>> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
>>> CONFIG_KVM=3Dy
>>> CONFIG_KVM_AMD=3Dm
>>>
>>> which builds but the PSP functionality is not there. And I don't thin=
k
>>> this is serving the user: she should be able to select what she wants=

>>> and get the required functionality added and not have build errors wi=
th
>>> any possible configuration.
>=20
> Yes, I agree.
>=20
>>>
>>> Now, looking at the security processor Kconfig stuff, it is somewhat
>>> confusing but maybe I didn't look at it long enough. A couple of poin=
ts:
>>>
>>> config CRYPTO_DEV_CCP_DD
>>>         tristate "Secure Processor device driver"
>>>
>>> If this is going to be the top-level menu item for the SP, call that
>>>
>>>  CRYPTO_DEV_SP
>>>
>>> to mean, this is the security processor. CCP_DD is confusing because =
you
>>> have CRYPTO_DEV_SP_CCP which is the crypto coprocessor support.
>=20
> IIRC, the patch series which added this support started with naming it
> to CRYPTO_DEV_SP but somewhere during review process we discussed that
> since the module name is ccp.ko hence we kept the config with same name=
=2E
> We can submit a follow-up patch to correct it to avoid any further
> confusion.
>=20
>=20
>>> And "DD" for device driver is a pure tautology - most of the Kconfig
>>> items are device drivers :)
>>>
>>> Then,
>>>
>>>  config KVM_AMD_SEV
>>>         def_bool y
>>>         bool "AMD Secure Encrypted Virtualization (SEV) support"
>>>         depends on KVM_AMD && X86_64
>>>         depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_=
SP_PSP
>>>
>>> that last line is pulling the required functionality for SEV but - an=
d
>>> I *think* we have talked about this before - having a hierarchical
>>> dependency should make this a lot clearer and fix the build issues al=
ong
>>> the way.
>=20
> The first set of SEV patches accepted in upstream was using select
> instead of depends on. I used select mainly to ensure that all the
> drivers needed to run SEV is either builtin or module.=C2=A0 A follow u=
p
> patch was submitted by Paolo to use 'depends on' so that we don't creat=
e
> a circular dependency - I agree with that patch.
>=20
>>> Because, IMHO, KVM_AMD_SEV should depend only on CRYPTO_DEV_SP_PSP -
>>> i.e., the PSP device because SEV needs the PSP, right?
>=20
> I think depends should look like this:
>=20
> config KVM_AMD_SEV
> =C2=A0=C2=A0=C2=A0 def_bool y
> =C2=A0=C2=A0=C2=A0 bool "AMD Secure Encrypted Virtualization (SEV) supp=
ort"
> =C2=A0=C2=A0=C2=A0 depends KVM_AMD && X86_64
> =C2=A0=C2=A0=C2=A0 depends CRYPTO_DEV_SP_PSP && !(KVM_AMD=3Dy && CRYPTO=
_DEV_CCP_DD=3Dm)
>=20
>=20
> Like you said,=C2=A0 the KVM_AMD_SEV should depends only on
> "CRYPTO_DEV_SP_PSP".=C2=A0 But when SEV support is enabled in KVM, we n=
eed a
> CCP driver at the runtime, hence we should ensure that if user selects
> KVM_AMD=3Dy then CCP driver is also builtin otherwise she will not get =
SEV
> feature.
>=20
>=20
>>> Now, the PSP device *itself* should depend on whatever it needs to
>>> function properly, CRYPTO_DEV_CCP_DD I guess.
>>>
>>> But SEV should not depend on CRYPTO_DEV_CCP - which is the top-level
>>> Kconfig item - that should be expressed implicitly through the
>>> dependency chain where PSP ends up depending on it.
>>>
>>> So that you have one-hop deps:
>>>
>>> KVM_SEV -> PSP -> CCP -> ...
>>>
>>> IOW, a config item, say PSP - if enabled - should make sure it
>>> selects/depends on everything it needs to function. The upper level
>>> item KVM_SEV - which selects/depends on that config item shouldn't
>>> be responsible for making sure the correct items for PSP's proper
>>> functioning are enabled - that's PSP's item's job.
>>>
>>> Makes sense?
>>>
>>> Maybe I'm missing something but applying this simple logic would prev=
ent
>>> such Kconfig build issues and make the whole dependency chain almost
>>> trivial.
>>>
>>> Thx.
>> *kind ping*
>=20
> Thanks for ping, sorry I was meaning to reply to this it but somehow go=
t
> dropped. Can you please try above recommendation and see if its builds
> and runs?
>=20

Hi Brijesh and thank you for your reply,

yes, I could solve the issue by setting CONFIG_CRYPTO_DEV_CCP=3Dy

Because at some point I got quiet desperate for not finding anything
useful on google, I wrote a small blog post - hopefully others with
similar problems can use the workaround as well.

Thank for your advice and have a nice day,
Greets,
Felix

>=20
>> Felix just reported me that build failure too.
>>
>=20




--IScDJ4i7dgSF7tpcxnfEDioZmVIN3QGw2--

--GRJRHVooK1R4u47YSuEVSvGSBiUBCyDLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElsYjfujFfHyZiaoDbnelkOP21xwFAlsiYZYACgkQbnelkOP2
1xy3lg/+ORCo49/9higld7r6AX86dL3yxAv+/2V0OjASE3+icvbGWxcrvJo6jWjx
k++IZ5KN7tO/N4NEFkOH72q6mj53/BD/FjbSgkDCd0HdU4Y//lImEp3J9DwMMggk
iJrvdSF6p2VBoy9jPBpZll/9BsT4c5g5SHgi//gTo8YX8p3ZPNFCY8Zqf0XaDQAT
J2YAd7+A8hHQbOoQ7ONkTeLzuO2mD8C146XdqMvch5yvwRMiBeXgMULng9B0yXP0
LGgfXE13eF++3XuDVoqdWdMeORZYL/l1zrBYrhXaZ6LZEyEeX9Mo8QR17fJsyKhZ
hJDeDo3SmJY5i7TACuxbBn+zas3PNPpb5kOaYk/8DMtLHezytd76PtAZ5kxHw9Ku
uzmB2vC7KrvASEfdnuZFw3AIC71OF2Tdkv0EqcxWGXRGXQsAwJ0ix1Vwf/cI8cA4
zDS/iKfSCC41ePjIhgjIz6y6r75a6sjZUckZeAOiP7GXOtY2E+xN1XJR08LcoFnh
+W3ClOwAAvDrSPL5+Ctpa3CXPVl8SonTEqyknBWbvxK/qH8rNrhI1FFCLeXQ0IwP
g92K9rAHX3/mtEbgLnDh4Nq6IFgPkSRaZuJIy0rstiyvLmX6xobOQ65D+diz/TBB
/hYbZfKcooZGXnOKP8626JxvzFHNRMDTl3U9KPfPxhxaeqz0zcc=
=H3OE
-----END PGP SIGNATURE-----

--GRJRHVooK1R4u47YSuEVSvGSBiUBCyDLN--
