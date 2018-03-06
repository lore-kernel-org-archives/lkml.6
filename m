Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754306AbeCFXTJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:19:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53670 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbeCFXTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:19:07 -0500
Date: Wed, 7 Mar 2018 00:19:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V2 5/7] thermal/drivers/cpu_cooling: Add idle cooling
 device documentation
Message-ID: <20180306231906.GB28911@amd>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-6-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <1519226968-19821-6-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> --- /dev/null
> +++ b/Documentation/thermal/cpu-idle-cooling.txt
> @@ -0,0 +1,165 @@
> +
> +Situation:
> +----------
> +

Can we have some real header here? Also if this is .rst, maybe it
should be marked so?

> +Under certain circumstances, the SoC reaches a temperature exceeding
> +the allocated power budget or the maximum temperature limit. The

I don't understand. Power budget is in W, temperature is in
kelvin. Temperature can't exceed power budget AFAICT.

> +former must be mitigated to stabilize the SoC temperature around the
> +temperature control using the defined cooling devices, the latter

later?

> +catastrophic situation where a radical decision must be taken to
> +reduce the temperature under the critical threshold, that can impact
> +the performances.

performance.

> +Another situation is when the silicon reaches a certain temperature
> +which continues to increase even if the dynamic leakage is reduced to
> +its minimum by clock gating the component. The runaway phenomena will
> +continue with the static leakage and only powering down the component,
> +thus dropping the dynamic and static leakage will allow the component
> +to cool down. This situation is critical.

Critical here, critical there. I have trouble following
it. Theoretically hardware should protect itself, because you don't
want kernel bug to damage your CPU?

> +Last but not least, the system can ask for a specific power budget but
> +because of the OPP density, we can only choose an OPP with a power
> +budget lower than the requested one and underuse the CPU, thus losing
> +performances. In other words, one OPP under uses the CPU with a

performance.

> +lesser than the power budget and the next OPP exceed the power budget,
> +an intermediate OPP could have been used if it were present.

was.

> +Solutions:
> +----------
> +
> +If we can remove the static and the dynamic leakage for a specific
> +duration in a controlled period, the SoC temperature will
> +decrease. Acting at the idle state duration or the idle cycle

"should" decrease? If you are in bad environment..

> +The Operating Performance Point (OPP) density has a great influence on
> +the control precision of cpufreq, however different vendors have a
> +plethora of OPP density, and some have large power gap between OPPs,
> +that will result in loss of performance during thermal control and
> +loss of power in other scenes.

scene seems to be wrong word here.

> +At a specific OPP, we can assume injecting idle cycle on all CPUs,

Extra comma?

> +Idle Injection:
> +---------------
> +
> +The base concept of the idle injection is to force the CPU to go to an
> +idle state for a specified time each control cycle, it provides
> +another way to control CPU power and heat in addition to
> +cpufreq. Ideally, if all CPUs of a cluster inject idle synchronously,
> +this cluster can get into the deepest idle state and achieve minimum
> +power consumption, but that will also increase system response latency
> +if we inject less than cpuidle latency.

I don't understand last sentence.

> +The mitigation begins with a maximum period value which decrease

decreases?
 =20
> +more cooling effect is requested. When the period duration is equal
> to
> +the idle duration, then we are in a situation the platform can=E2=80=99t
> +dissipate the heat enough and the mitigation fails. In this case

fast enough?

> +situation is considered critical and there is nothing to do. The idle

Nothing to do? Maybe power the system down?

> +The idle injection duration value must comply with the constraints:
> +
> +- It is lesser or equal to the latency we tolerate when the mitigation

less ... than the latency

> +Minimum period
> +--------------
> +
> +The idle injection duration being fixed, it is obvious the minimum
> +period can=E2=80=99t be lesser than that, otherwise we will be schedulin=
g the

less.

> +Practically, if the running power is lesses than the targeted power,

less.

> +However, in this demonstration we ignore three aspects:
> +
> + * The static leakage is not defined here, we can introduce it in the
> +   equation but assuming it will be zero most of the time as it is

, but?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqfIeoACgkQMOfwapXb+vJgIQCeN1Vb7x/SNVcdNPnNBZxaKBBS
cJkAnR3v6clzNbH+Nf4UGxn64j+Od/RJ
=LSB1
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
