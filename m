Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeDQILU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:11:20 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9132 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeDQILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:11:17 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Apr 2018 01:11:16 -0700
Date: Tue, 17 Apr 2018 10:11:10 +0200
From: Thierry Reding <treding@nvidia.com>
To: Stefan Agner <stefan@agner.ch>, Russell King <linux@armlinux.org.uk>
CC: Stephen Warren <swarren@wwwdotorg.org>, <linux@armlinux.org.uk>,
        "Stephen Warren" <swarren@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>, <ard.biesheuvel@linaro.org>,
        <arnd@arndb.de>, <nicolas.pitre@linaro.org>, <marc.zyngier@arm.com>,
        <behanw@converseincode.com>, <keescook@chromium.org>,
        <Bernhard.Rosenkranzer@linaro.org>, <mka@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked
 function
Message-ID: <20180417081109.GA5804@ulmo>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
 <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
 <f627177c-f813-9e10-ade5-c7654375639b@gmail.com>
 <cf9b916103c0dba1e67682efc69f5bae@agner.ch>
 <498de826-6e6c-63d8-00d6-f394b2725a34@wwwdotorg.org>
 <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
MIME-Version: 1.0
In-Reply-To: <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.21.62.139]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 08:21:09PM +0200, Stefan Agner wrote:
> On 16.04.2018 18:08, Stephen Warren wrote:
> > On 04/16/2018 09:56 AM, Stefan Agner wrote:
> >> On 27.03.2018 14:16, Dmitry Osipenko wrote:
> >>> On 27.03.2018 14:54, Robin Murphy wrote:
> >>>> On 26/03/18 22:20, Dmitry Osipenko wrote:
> >>>>> On 25.03.2018 21:09, Stefan Agner wrote:
> >>>>>> As documented in GCC naked functions should only use Basic asm
> >>>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
> >>>>>> not guaranteed. Currently this works because it was hard coded
> >>>>>> to follow and check GCC behavior for arguments and register
> >>>>>> placement.
> >>>>>>
> >>>>>> Furthermore with clang using parameters in Extended asm in a
> >>>>>> naked function is not supported:
> >>>>>>  =C2=A0=C2=A0 arch/arm/firmware/trusted_foundations.c:47:10: error=
: parameter
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 refe=
rences not allowed in naked functions
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "r" (type), "r" (arg1), "r" (arg2)
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^
> >>>>>>
> >>>>>> Use a regular function to be more portable. This aligns also with
> >>>>>> the other smc call implementations e.g. in qcom_scm-32.c and
> >>>>>> bcm_kona_smc.c.
> >>>>>>
> >>>>>> Cc: Dmitry Osipenko <digetx@gmail.com>
> >>>>>> Cc: Stephen Warren <swarren@nvidia.com>
> >>>>>> Cc: Thierry Reding <treding@nvidia.com>
> >>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >>>>>> ---
> >>>>>> Changes in v2:
> >>>>>> - Keep stmfd/ldmfd to avoid potential ABI issues
> >>>>>>
> >>>>>>  =C2=A0 arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
> >>>>>>  =C2=A0 1 file changed, 9 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm/firmware/trusted_foundations.c
> >>>>>> b/arch/arm/firmware/trusted_foundations.c
> >>>>>> index 3fb1b5a1dce9..689e6565abfc 100644
> >>>>>> --- a/arch/arm/firmware/trusted_foundations.c
> >>>>>> +++ b/arch/arm/firmware/trusted_foundations.c
> >>>>>> @@ -31,21 +31,25 @@
> >>>>>>  =C2=A0 =C2=A0 static unsigned long cpu_boot_addr;
> >>>>>>  =C2=A0 -static void __naked tf_generic_smc(u32 type, u32 arg1, u3=
2 arg2)
> >>>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
> >>>>>>  =C2=A0 {
> >>>>>> +=C2=A0=C2=A0=C2=A0 register u32 r0 asm("r0") =3D type;
> >>>>>> +=C2=A0=C2=A0=C2=A0 register u32 r1 asm("r1") =3D arg1;
> >>>>>> +=C2=A0=C2=A0=C2=A0 register u32 r2 asm("r2") =3D arg2;
> >>>>>> +
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm volatile(
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ".arch_ext=
ension=C2=A0=C2=A0=C2=A0 sec\n\t"
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "stmfd=C2=A0=C2=A0=C2=
=A0 sp!, {r4 - r11, lr}\n\t"
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "stmfd=C2=A0=C2=A0=C2=
=A0 sp!, {r4 - r11}\n\t"
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __asmeq("%=
0", "r0")
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __asmeq("%=
1", "r1")
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __asmeq("%=
2", "r2")
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mov=C2=A0=
=C2=A0=C2=A0 r3, #0\n\t"
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mov=C2=A0=
=C2=A0=C2=A0 r4, #0\n\t"
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "smc=C2=A0=
=C2=A0=C2=A0 #0\n\t"
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ldmfd=C2=A0=C2=A0=C2=
=A0 sp!, {r4 - r11, pc}"
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ldmfd=C2=A0=C2=A0=C2=
=A0 sp!, {r4 - r11}\n\t"
> >>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "r" (type), "r" (arg=
1), "r" (arg2)
> >>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "memory");
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "r" (r0), "r" (r1), =
"r" (r2)
> >>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "memory", "r3", "r12=
", "lr");
> >>>>>
> >>>>> Although seems "lr" won't be affected by SMC invocation because it =
should be
> >>>>> banked and hence could be omitted entirely from the code. Maybe som=
ebody could
> >>>>> confirm this.
> >>>> Strictly per the letter of the architecture, the SMC could be trappe=
d to Hyp
> >>>> mode, and a hypervisor might clobber LR_usr in the process of forwar=
ding the
> >>>> call to the firmware secure monitor (since Hyp doesn't have a banked=
 LR of its
> >>>> own). Admittedly there are probably no real systems with the appropr=
iate
> >>>> hardware/software combination to hit that, but on the other hand if =
this gets
> >>>> inlined where the compiler has already created a stack frame then an=
 LR clobber
> >>>> is essentially free, so I reckon we're better off keeping it for rea=
ssurance.
> >>>> This isn't exactly a critical fast path anyway.
> >>>
> >>> Okay, thank you for the clarification.
> >>
> >> So it seems this change is fine?
> >>
> >> Stephen, you picked up changes for this driver before, is this patch
> >> going through your tree?
> >=20
> > You had best ask Thierry; he's taken over Tegra maintenance upstream.
> > But that said, don't files in arch/arm go through Russell?
>=20
> I think the last patches applied to that file went through your tree.
>=20
> Thierry, Russel, any preferences?

I don't mind picking this up into the Tegra tree. Might be a good idea
to move this into drivers/firmware, though, since that's where all the
other firmware-related drivers reside.

Firmware code, such as the BPMP driver, usually goes through ARM-SoC
these days. I think this is in the same category.

Russell, any objections to me picking this patch up and moving it into
drivers/firmware?

Thanks,
Thierry

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrVrBoACgkQ3SOs138+
s6GbOQ//WP3A9NdZ7/dzBjl9WgJQHUequIACSLiTFS9VkDydpaOvvneRYS/9Di1/
hCax1zl/AjFRbXVTOkVBiZbU3bWtBplKuhw/mZ0PNYpV7DBzqIQiU52TzMwEBi5G
sGal0lUaSGdIluOU5RTuINmUqO+DmthvbfVx6WC75bEuzSoS30n5ubOpmtkTnMWT
5RC/6VopAt98UrW7VIjC3xLK4KG/Ec52BBSt38uIHDw5ivx4eI/2Tq1iKpxAI39f
he34A2AS8tpZHFGxaVIH63FL0F4c8kaVH009NG9F54S2xIDULWMH/eYTQCs6fNY9
BAv9VUlGXdwWbyR7ZsF8T5QTPc+Lx2Z+XWRSRWL8wDLZSyJCFw1ixJcGOybShRiI
JW//Ba2OFvuGCPrOJ9jg0HQqC2n105MxAsbiPhQ/oiv8P+vAF5+NMS3y59uK29e4
9EKLq8CefaFa7P6Rc9oo8uD14U2Rd3RThPngdQ4rzeNS1O/oyL7RVPv6gFHMhqSE
GP6PFvsvFfeQwo79VU3VK4PUgL8k5SWPFS/pmvEe4rpNNfluXBEZpr5IuzoTVGnU
nV/i3cUQvhfNazzHYTmBBHd8Shm15A076O0j1R0BXl5gS3Sh3R8qz1n2elxQovI+
UJhYopby04REO8N0NLFNtSp2R3pmAWgnbpWHcNvCStwttOsKVjE=
=RTR/
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
