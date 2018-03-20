Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeCTKCu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:02:50 -0400
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:42318 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752027AbeCTKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:02:46 -0400
Subject: Re: [RFT][PATCH v5 0/7] sched/cpuidle: Idle loop rework
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC: Doug Smythies <dsmythies@telus.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Rik van Riel" <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Mike Galbraith" <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan>
 <001a01d3be0a$ad3a0ed0$07ae2c70$@net> <2043615.lCdO10SMaB@aspire.rjw.lan>
 <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
From: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Date: Tue, 20 Mar 2018 11:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h0wbu_hxCyBKLxFnWRFkK6ObqTmYRHAWgHyXTd57aH9Q@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
        micalg=sha-256; boundary="------------ms060405000609040303060803"
X-ClientProxiedBy: MSX-L101.msx.ad.zih.tu-dresden.de (172.26.34.101) To
 MSX-L104.msx.ad.zih.tu-dresden.de (172.26.34.104)
X-PMWin-Version: 4.0.3, Antispam-Engine: 2.7.2, Antispam-Data:
 2018.3.20.94217, Antivirus-Engine: 3.70.2, Antivirus-Data: 5.49
X-PMWin-Spam: Gauge=IIIIIIII, Probability=8, Report='__BOUNCE_CHALLENGE_SUBJ
 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0,
 __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC 0, __HAS_CC_HDR 0,
 __MULTIPLE_RCPTS_CC_X2 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0,
 __REFERENCES 0, __HAS_FROM 0, __HAS_MSGID 0, __SANE_MSGID 0, __USER_AGENT 0,
 __MOZILLA_USER_AGENT 0, __MIME_VERSION 0, __IN_REP_TO 0, __CT 0,
 __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __BAT_BOUNDARY 0, __MIME_TEXT_P2
 0, __HAS_ATTACHMENT1 0, __ANY_URI 0, __HTTPS_URI 0, __URI_WITH_PATH 0,
 LINK_TO_IMAGE 0, __MAL_TELEKOM_URI 0, __URI_NO_WWW 0, __FRAUD_CONTACT_NUM 0,
 __CP_URI_IN_BODY 0, __INT_PROD_COMP 0, __SUBJ_ALPHA_NEGATE 0,
 __MULTIPLE_URI_TEXT 0, __URI_IN_BODY 0, __URI_NOT_IMG 0, __FORWARDED_MSG 0,
 __NO_HTML_TAG_RAW 0, BODY_SIZE_10000_PLUS 0, __ATTACHMENT_SIZE_0_10K 0,
 __HAS_ATTACHMENT2 0, __ATTACHMENT_SIZE_10_25K 0, __MIME_TEXT_P1 0, __URI_NS
 0, HTML_00_01 0.05, HTML_00_10 0.05, IN_REP_TO 0, MSG_THREAD 0,
 __TO_REAL_NAMES 0, __CC_REAL_NAMES 0, MULTIPLE_REAL_RCPTS 0, LEGITIMATE_SIGNS
 0, __HAS_ATTACHMENT 0, MULTIPLE_RCPTS 0.1, __MIME_TEXT_P 0, REFERENCES 0,
 URI_WITH_PATH_ONLY 0'
X-PMWin-SpamScore: 8
Message-ID: <d9b202d75c484ef3b636ce181d1c04ca@MSX-L104.msx.ad.zih.tu-dresden.de>
X-TUD-Virus-Scanned: mailout5.zih.tu-dresden.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------ms060405000609040303060803
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-03-18 17:15, Rafael J. Wysocki wrote:
>> Doug, Thomas,
>>
>> Thank you both for the reports, much appreciated!
>>
>> Below is a drop-in v6 replacement for patch [4/7].
>>
>> With this new patch applied instead of the [4/7] the behavior should b=
e much
>> more in line with the v4 behavior, so please try it if you can and let=
 me know
>> if that really is the case on your systems.
>>
>> Patches [5-7/7] from the original v5 apply on top of it right away for=
 me,
>> but I've also created a git branch you can use to pull all of the seri=
es
>> with the below included:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>>   idle-loop

Thanks for the git repo, that helps alot. I have tested v6 on a
Skylake desktop and server system as well as a Haswell server system.
The odd idle behavior of v5 is gone.

Some of the other findings may be obsolete by the upcoming respin,
I will retest.

Our originally observed Powernightmare pattern is effectively
prevented in both idle and with a synthetic trigger. However, I can
reproduce simple workloads under which the revised menu governor
wastes energy by going into *deeper* C-states than advisable.

Consider the Skylake server system which has residencies in C1E of
20 us and C6 of 800 us. I use a small while(1) {usleep(300);}
unsynchronized pinned to each core. While this is an artificial
case, it is a very innocent one - easy to predict and regular. Between
vanilla 4.16.0-rc5 and idle-loop/v6, the power consumption increases
from 149.7 W to 158.1 W. On 4.16.0-rc5, the cores sleep almost
entirely in C1E. With the patches applied, the cores spend ~75% of
their sleep time in C6, ~25% in C1E. The average time/usage for C1E is
also lower with v6 at ~350 us rather than the ~550 us in C6 (and in
C1E with the baseline). Generally the new menu governor seems to chose
C1E if the next timer is an enabled sched timer - which occasionally
interrupts the sleep-interval into two C1E sleeps rather than one C6.

Manually disabling C6, reduces power consumption back to 149.5 W.

This is far from what I expected, I did not yet figure out why the
patched menu governor decides to go to C6 under that workload. I
have tested this previously with v4 and saw this behavior even
without path "7/7".

The results from Haswell-EP and Skylake desktop are similar.

The tests are with a 1000 Hz kernel because I wanted to amplify
effects that happening when C-state residencies and tick timers are
closer together. But I suspect the results will be similar with
300 Hz as the impact from the sched tick interruption seems to be
minor compared to the odd C-state selection.

Some very raw illustrations, all from Skylake SP (2 =3D=3D C1E, 3 =3D=3D =
C6):
power consumption
trigger-10-10 is the synthetic Powernightmare
poller-omp-300 is the parallel  usleep(300) loop:
https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v6_skl_sp_power=
=2Epng

cstate utilization with usleep(300) loop
(as per /sys/.../stateN/time / wall time)
https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v6_skl_sp_poll_=
300_utilization.png

average time spent in cstates
(as /sys/.../stateN/time / /sys/.../stateN/usage)
https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v6_skl_sp_poll_=
300_avg_time.png

detailed look:
https://wwwpub.zih.tu-dresden.de/~tilsche/powernightmares/v6_poll_300_skl=
=2Epng


>>
>> Thanks!
>>
>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: [PATCH v6] cpuidle: Return nohz hint from cpuidle_select()
>>
>> Add a new pointer argument to cpuidle_select() and to the ->select
>> cpuidle governor callback to allow a boolean value indicating
>> whether or not the tick should be stopped before entering the
>> selected state to be returned from there.
>>
>> Make the ladder governor ignore that pointer (to preserve its
>> current behavior) and make the menu governor return 'false" through
>> it if:
>>   (1) the idle exit latency is constrained at 0,
>>   (2) the selected state is a polling one, or
>>   (3) the selected state is not deep enough.
>>
>> Since the value returned through the new argument pointer is not
>> used yet, this change is not expected to alter the functionality of
>> the code.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>=20
> [cut]
>=20
>> @@ -354,6 +360,7 @@ static int menu_select(struct cpuidle_dr
>>          if (latency_req > interactivity_req)
>>                  latency_req =3D interactivity_req;
>>
>> +       expected_interval =3D TICK_USEC_HZ;
>>          /*
>>           * Find the idle state with the lowest power while satisfying=

>>           * our constraints.
>> @@ -367,17 +374,44 @@ static int menu_select(struct cpuidle_dr
>>                          continue;
>>                  if (idx =3D=3D -1)
>>                          idx =3D i; /* first enabled state */
>> -               if (s->target_residency > data->predicted_us)
>> +               if (s->target_residency > data->predicted_us) {
>> +                       /*
>> +                        * Retain the tick if the selected state is sh=
allower
>> +                        * than the deepest available one with target =
residency
>> +                        * within the tick period range.
>> +                        *
>> +                        * This allows the tick to be stopped even if =
the
>> +                        * predicted idle duration is within the tick =
period
>> +                        * range to counter the effect by which the pr=
ediction
>> +                        * may be skewed towards lower values due to t=
he tick
>> +                        * bias.
>> +                        */
>> +                       expected_interval =3D s->target_residency;
>>                          break;
>=20
> BTW, I guess I need to explain the motivation here more thoroughly, so
> here it goes.
>=20
> The governor predicts idle duration under the assumption that the
> tick will be stopped, so if the result of the prediction is within the =
tick
> period range and it is not accurate, that needs to be taken into
> account in the governor's statistics.  However, if the tick is allowed
> to run every time the governor predicts idle duration within the tick
> period range, the governor will always see that it was "almost
> right" and the correction factor applied by it to improve the
> prediction next time will not be sufficient.  For this reason, it
> is better to stop the tick at least sometimes when the governor
> predicts idle duration within the tick period range and the idea
> here is to do that when the selected state is the deepest available
> one with the target residency within the tick period range.  This
> allows the opportunity to save more energy to be seized which
> balances the extra overhead of stopping the tick.
>=20
> HTH
>=20

--=20
Dipl. Inf. Thomas Ilsche
Computer Scientist
Highly Adaptive Energy-Efficient Computing
CRC 912 HAEC: http://tu-dresden.de/sfb912
Technische Universit=C3=A4t Dresden
Center for Information Services and High Performance Computing (ZIH)
01062 Dresden, Germany

Phone: +49 351 463-42168
Fax: +49 351 463-37773
E-Mail: thomas.ilsche@tu-dresden.de


--------------ms060405000609040303060803
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EGIwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWWMIIEfqADAgECAgwcbjQkPzrYLBvMkTUwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjEyMTIxNDM5
MTZaFw0zMTAyMjIyMzU5NTlaMHMxCzAJBgNVBAYTAkRFMRAwDgYDVQQIDAdTYWNoc2VuMRAw
DgYDVQQHDAdEcmVzZGVuMSgwJgYDVQQKDB9UZWNobmlzY2hlIFVuaXZlcnNpdGFldCBEcmVz
ZGVuMRYwFAYDVQQDDA1UVSBEcmVzZGVuIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA5+CCc42Y1+0J5tpASWPSYx/0Pxqj97P1DdzCbTh3XwppRsAMtqNwS8sTxgHMmbNA
ol18t3EqIkTH/iSXEhd5cf6OSyHumVbgvZTvjMh/c7R3VGZiwqimlhk4/UJV8nVPvrL24Guk
D17Rsv+iLe5Mse7HIMJ7e9ciArdCBV5W6kk/5O24/ZhttIEs/2I3i8MTlGoBaesNgkUy/cRa
A0hw1BBTrDbfK1vhbxV/CWb+czy0F0M5W31LToGrXuwoFrhggn5X/LrFXvCb8/9w+jSk8WzG
vJw6MlPGXHwuTfjf7oei/S0j7iHq5fyIH3lEs58M4kwxlLViv2rc3KJkTX5xmQIDAQABo4IC
BTCCAgEwEgYDVR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDAN
BgsrBgEEAYGtIYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBRS/r63JMIbCh1GUo5E
JCr0SEA9ATAfBgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGE
MECgPqA8hjpodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWcyLWNhL3B1Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcw
AYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAC
hj5odHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQv
Y2FjZXJ0LmNydDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAEzY
RPywOGl/wZ/Mdz2gLDMbO39f7+iQcrVPRy/lbjjLt+0bouai8xTj1I9N+W4ZOhGww55gXMNO
nBiKouODdNcazTxW6+glA4+5K9bxkAKu9kl9J2ezpcMw1PNTFFcS1yG+thGQTtuy+3S3fI6V
Ifxi+RawFri9sC7010qS3RwOShmhsLk3iEjlDQ180zkBzsdevWHt1svALpqsc+7DcHuP+MgY
vkow/1uyHp3vyeTE9K7hdxcfXwRQ9IkeCo9xLJUeykuosqrTOQNe4Yw4hPhrJfRtoyH92SFq
deZenVeU6+rkquev61X3fPi+/ySpUOGyWPdggN65bQ81E8nLFYUwggWuMIIElqADAgECAgwc
vTmIr0re9lfFR20wDQYJKoZIhvcNAQELBQAwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1Nh
Y2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0
YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNkZW4gQ0EwHhcNMTcwMjEwMTMxMTIwWhcN
MjAwMjEwMTMxMTIwWjBdMQswCQYDVQQGEwJERTEoMCYGA1UECgwfVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgRHJlc2RlbjEMMAoGA1UECwwDWklIMRYwFAYDVQQDDA1UaG9tYXMgSWxzY2hl
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw5dKRIicycpBdQWviYlPQxn61uc0
dMnov1GqB3JoJpRyWICwOBn0EWcbKatI1VS6PbAbmCaXjujAZnhIppGj8NQdU15E4HaC0TDp
ucodW2vxb75srHBQ5WBwo3SDHF1gT1l6mAzr1fVddmLi2yV0kK6gaervW4gAh46l5Es6jjnp
ugT1eatFuUy2M/H/MXEeW/lWgOG3POatGOmOR/OC3c321z4OynPk2/LIEnPfrSvpCQZDrKsF
9miwvoXbkYWUAN/qhDEkyYPh/YPQ9YMg5Bgs4xz+EqEECOi8v0DWfxwgQ5zyfRW5aBj5bw0b
PLOydh4m2ufwM+Q7KQfgF04eZwIDAQABo4ICVjCCAlIwCQYDVR0TBAIwADAOBgNVHQ8BAf8E
BAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQ5omhFY59I
NNeLxf+a6i2MFhszdjAfBgNVHSMEGDAWgBRS/r63JMIbCh1GUo5EJCr0SEA9ATAmBgNVHREE
HzAdgRt0aG9tYXMuaWxzY2hlQHR1LWRyZXNkZW4uZGUwgY0GA1UdHwSBhTCBgjA/oD2gO4Y5
aHR0cDovL2NkcDEucGNhLmRmbi5kZS90dS1kcmVzZGVuLWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3R1LWRyZXNkZW4tZzItY2EvcHVi
L2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8v
b2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9j
ZHAxLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQw
SQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9w
dWIvY2FjZXJ0L2NhY2VydC5jcnQwQAYDVR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYP
KwYBBAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwDQYJKoZIhvcNAQELBQADggEBACfM
PajpRlVEBvEeDqkek2aRlU1xLCR1ulK4Z8WlMN+cPnjONaEfYp3oBwqiUNKjNa4VpniQLvXM
xDWgncPOavlajnIH5urkss7iDV9ImaZEyW6sU9ZemBXGN3PP5xI1xX4dKA32N/8J57D+0Im5
I2aa6wLpeFa24qr2b5tXke77ZQwAOxp0CryiVkVP/5rp4C8D43I7x/uRhWbmxzaj+/bMwyZ0
gTsJ/k9KQaR+8oqdDn/X/PI1e7GWNykhhjG+QP1hwj2HqRRAYlTN4S3OAedvNPxtBK+28TGu
bAfD2IQZdvYAqSQT6qt2W1KkUMN38bRKdcICdqm8+fUMe7yKuvQxggO6MIIDtgIBATCBgzBz
MQswCQYDVQQGEwJERTEQMA4GA1UECAwHU2FjaHNlbjEQMA4GA1UEBwwHRHJlc2RlbjEoMCYG
A1UECgwfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEWMBQGA1UEAwwNVFUgRHJl
c2RlbiBDQQIMHL05iK9K3vZXxUdtMA0GCWCGSAFlAwQCAQUAoIICBzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAzMjAxMDAxNDhaMC8GCSqGSIb3DQEJ
BDEiBCCToOK+flbBLbVOY8xpD+xOL1z/6rdwtszRadwJtoO4yzBsBgkqhkiG9w0BCQ8xXzBd
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCA
MA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGUBgkrBgEEAYI3EAQx
gYYwgYMwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNk
ZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMM
DVRVIERyZXNkZW4gQ0ECDBy9OYivSt72V8VHbTCBlgYLKoZIhvcNAQkQAgsxgYaggYMwczEL
MAkGA1UEBhMCREUxEDAOBgNVBAgMB1NhY2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNV
BAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNk
ZW4gQ0ECDBy9OYivSt72V8VHbTANBgkqhkiG9w0BAQEFAASCAQAhPpN5ufwXsYhRidNuFCHK
Zu3zvprF4cl6k831yUxX7pEg+0Pl6HpW5B9g21nhAeHCJJ96UzzJufDoXjcaC6Tfb1CXnV2G
JsBbLoGCLDaBJAor4AYKmCTqoxmr+Q8rmlFWeqSFG54vmFjqMmxyaS4w9/O+OR4YvjWARAKq
SymPrQjEkgr2Agiau222/rfD4oY14Pf44ms+YX+oCkYvB9SrcLXWNeW95Qa4mLpLD+oqRkzl
gksZ6XfivXnEldmBE7kolVGT+Vi3nyOEhGj1J1KVtjq9lgfo1ET93e6r+Z1H6QmCz2kKxNWv
w6jJ0jLkXqRYM495tdT3smfkXAvUnBLiAAAAAAAA
--------------ms060405000609040303060803--
