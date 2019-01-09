Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F3EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60BF206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfAINT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:19:27 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42729 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730295AbfAINT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:19:26 -0500
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 93D0620135342D;
        Wed,  9 Jan 2019 14:19:24 +0100 (CET)
Subject: Re: General protection fault in `switch_mm_irqs_off()`
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
 <alpine.LRH.2.00.1901041737290.28043@gjva.wvxbf.pm>
 <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
Message-ID: <e2cbef46-d054-9bd2-5d8c-0b82457738ad@molgen.mpg.de>
Date:   Wed, 9 Jan 2019 14:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cb7ba667-562b-1e4c-f16e-7c11804bc98a@molgen.mpg.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms070306020309050804020004"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070306020309050804020004
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Jiri, dear Thomas, dear Borislav,


On 01/09/19 13:06, Paul Menzel wrote:

> On 01/04/19 17:42, Jiri Kosina wrote:
>>
>> [ added some CCs ]
>=20
> Thank you for your reply and taking care of that. I am sorry for the
> late reply. It took a while to test this.
>=20
>> On Thu, 3 Jan 2019, Paul Menzel wrote:
>=20
>>> On the server board Asus KGPE-D16 with AMD Opteron 6278 processor
>>> updating the microcode update in the firmware from 0x0600062e to
>>> 0x0600063e seems to cause a general protection fault with Linux
>>> 4.14.87 and 4.20-rc7.
>=20
> Just a minor correction. The previous microcode update version was
> 0x0600063d, and, it looks like, I am getting the same failure with
> that and Linux 4.14.87.

I was mistaken. Everything is fine with 0x0600063d.

> It boots fine, when not applying any microcode update (0x00000000).
>=20
> To answers, Thomas=E2=80=99 question, the microcode is updated in the
> firmware (coreboot). (Asus didn=E2=80=99t publish any updates.)
>=20
>>>> 46.859: [    7.573240] microcode: CPU31: patch_level=3D0x0600063e
>>>> 46.859: [    7.578507] microcode: Microcode Update Driver: v2.2.
>>>> 46.860: [    7.578539] sched_clock: Marking stable (6510054745, 1068=
444659)->(7999876773, -421377369)
>>>> 46.860: [    7.593013] registered taskstats version 1
>>>> 46.861: [    7.598091] rtc_cmos 00:00: setting system clock to 2000-=
01-01 08:01:51 UTC (946713711)
>>>> 46.862: [    7.606575] ALSA device list:
>>>> 46.862: [    7.609802]   No soundcards found.
>>>> 46.865: [    7.615887] Freeing unused kernel image memory: 1564K
>>>> 46.871: [    7.627073] Write protecting the kernel read-only data: 2=
0480k
>>>> 46.872: [    7.634366] Freeing unused kernel image memory: 2016K
>>>> 46.873: [    7.640297] Freeing unused kernel image memory: 584K
>>>> 46.874: [    7.645521] Run /init as init process
>>>> 46.877: [    7.652262] general protection fault: 0000 [#1] SMP NOPTI=

>>>> 46.877: [    7.657931] CPU: 18 PID: 0 Comm: swapper/18 Not tainted 4=
=2E20.0-rc7.mx64.237 #1
>>>> 46.877: [    7.665514] Hardware name: ASUS KGPE-D16/KGPE-D16, BIOS 4=
=2E9-103-g637bef2037 01/02/2019
>>>> 46.878: [    7.673804] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
>>>> 46.878: [    7.678948] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b =
05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 0=
0 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f =
8f 41 04
>>>> 46.879: [    7.698394] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
>>>> 46.879: [    7.703844] RAX: 0000000000000001 RBX: ffff88981ca0b800 R=
CX: 0000000000000049
>>>> 46.879: [    7.711238] RDX: 0000000000000000 RSI: ffff88981b87cf80 R=
DI: ffff88981ca0b800
>>>> 46.880: [    7.718665] RBP: ffffc90006343e70 R08: 00000001c81bec00 R=
09: 0000000000000000
>>>> 46.880: [    7.726092] R10: ffffc90006343e88 R11: 0000000000000000 R=
12: ffffffff82479b40
>>>> 46.880: [    7.733494] R13: 0000000000000000 R14: 0000000000000012 R=
15: ffff88981dd50080
>>>> 46.881: [    7.740853] FS:  0000000000000000(0000) GS:ffff88981fa800=
00(0000) knlGS:0000000000000000
>>>> 46.881: [    7.749318] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
>>>> 46.881: [    7.755281] CR2: 0000000000000000 CR3: 000000000240a000 C=
R4: 00000000000406e0
>>>> 46.881: [    7.762761] Call Trace:
>>>> 46.881: [    7.765369]  ? __schedule+0x1b9/0x7b0
>>>> 46.882: [    7.769253]  __schedule+0x1b9/0x7b0
>>>> 46.882: [    7.772930]  schedule_idle+0x1e/0x40
>>>> 46.882: [    7.776744]  do_idle+0x146/0x200
>>>> 46.882: [    7.780181]  cpu_startup_entry+0x19/0x20
>>>> 46.883: [    7.784274]  start_secondary+0x183/0x1b0
>>>> 46.883: [    7.788409]  secondary_startup_64+0xa4/0xb0
>>>> 46.883: [    7.792766] Modules linked in:
>>>> 46.883: [    7.796105] ---[ end trace a423e363fe1ecf67 ]---
>>>> 46.884: [    7.800939] RIP: 0010:switch_mm_irqs_off+0xb2/0x640
>>>> 46.884: [    7.806048] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b =
05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 0=
0 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f =
8f 41 04
>>
>> So this faults when writing PRED_CMD_IBPB to MSR_IA32_PRED_CMD, but th=
at=20
>> should be properly patched out on ucodes that don't support IBPB.
>>
>> This almost looks like the ucode you updated to would advertise IBPB=20
>> availability, but then fault when it's used.
>=20
> As it also happens with the previous firmware version, is it possible t=
hat
> the check is incorrect? Maybe there are not a lot of people running AMD=

> Opteron servers and latest Linux or Linux stable kernels?
>=20
>> I guess that booting with 'spectre_v2_user=3Doff' makes the issue go a=
way,=20
>> right?
>=20
> Indeed. That makes it boot with microcode updates applied.
>=20
>     [    0.000000] Command line: BOOT_IMAGE=3D/boot/bzImage-4.14.87.mx6=
4.236 crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS0,115200n8 =
console=3DttyS1,115200n8 console=3Dtty0 init=3D/bin/systemd audit=3D0 spe=
ctre_v2_user=3Doff
>     [=E2=80=A6]
>     [    3.809210] microcode: CPU0: patch_level=3D0x0600063e
>=20
>> What happens then if you manually wrmsr 0x1 to MSR 0x49 from userspace=
?=20
>=20
> With no microcode updates applied, I get.
>=20
>     $ dmesg | grep 'microcode: CPU0: patch_level'
>     [    3.817171] microcode: CPU0: patch_level=3D0x00000000
>     $ sudo modprobe msr
>     $ sudo ./wrmsr 0x49 0x1 # https://github.com/01org/msr-tools
>     wrmsr: CPU 0 cannot set MSR 0x00000049 to 0x0000000000000001
>=20
> I get the same with microcode updates applied.
>=20
>     $ dmesg | grep 'microcode: CPU0: patch_level'
>     [    3.809210] microcode: CPU0: patch_level=3D0x0600063e
>     $ sudo modprobe msr
>     $ sudo ./wrmsr 0x49 0x1
>     wrmsr: CPU 0 cannot set MSR 0x00000049 to 0x0000000000000001
>=20
>> Could you please post /proc/cpuinfo from such a boot as well?
>=20
>> Leaving the rest of the original mail for reference.
>=20
>     processor   : 0
>     vendor_id   : AuthenticAMD
>     cpu family  : 21
>     model               : 1
>     model name  : AMD Opteron(tm) Processor 6278
>     stepping    : 2
>     microcode   : 0x600063e
>     cpu MHz             : 1871.198
>     cache size  : 2048 KB
>     physical id : 0
>     siblings    : 16
>     core id             : 0
>     cpu cores   : 8
>     apicid              : 0
>     initial apicid      : 0
>     fpu         : yes
>     fpu_exception       : yes
>     cpuid level : 13
>     wp          : yes
>     flags               : fpu vme de pse tsc msr pae mce cx8 apic sep m=
trr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext=
 fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl
>      nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq mon=
itor ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave avx lahf_lm cmp_legacy svm=
 extapic cr8_legacy abm sse4a misalignsse 3dnowpre
>     fetch osvw ibs xop skinit wdt fma4 topoext perfctr_core perfctr_nb =
cpb hw_pstate ssbd ibpb vmmcall arat npt lbrv svm_lock nrip_save tsc_scal=
e vmcb_clean flushbyasid decodeassists pausefilter
>      pfthreshold
>     bugs                : fxsave_leak sysret_ss_attrs null_seg spectre_=
v1 spectre_v2 spec_store_bypass
>     bogomips    : 4799.84
>     TLB size    : 1536 4K pages
>     clflush size        : 64
>     cache_alignment     : 64
>     address sizes       : 48 bits physical, 48 bits virtual
>     power management: ts ttp tm 100mhzsteps hwpstate cpb
>=20
> Please find the whole output attached.
>=20
>>>> 46.884: [    7.825440] RSP: 0018:ffffc90006343e20 EFLAGS: 00010046
>>>> 46.885: [    7.830855] RAX: 0000000000000001 RBX: ffff88981ca0b800 R=
CX: 0000000000000049
>>>> 46.885: [    7.838230] RDX: 0000000000000000 RSI: ffff88981b87cf80 R=
DI: ffff88981ca0b800
>>>> 46.885: [    7.845614] RBP: ffffc90006343e70 R08: 00000001c81bec00 R=
09: 0000000000000000
>>>> 46.886: [    7.853047] R10: ffffc90006343e88 R11: 0000000000000000 R=
12: ffffffff82479b40
>>>> 46.886: [    7.860427] R13: 0000000000000000 R14: 0000000000000012 R=
15: ffff88981dd50080
>>>> 46.886: [    7.867862] FS:  0000000000000000(0000) GS:ffff88981fa800=
00(0000) knlGS:0000000000000000
>>>> 46.886: [    7.876320] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
>>>> 46.887: [    7.882351] CR2: 0000000000000000 CR3: 000000000240a000 C=
R4: 00000000000406e0
>>>> 46.887: [    7.889746] Kernel panic - not syncing: Attempted to kill=
 the idle task!
>>>> 46.888: [    7.896907] Kernel Offset: disabled
>>>> 46.888: [    7.900558] ---[ end Kernel panic - not syncing: Attempte=
d to kill the idle task! ]---
>>>
>>> Please find the whole log, including the coreboot messages, attached.=
 The time
>>> stamps in the beginning are from the script `readserial.py` from the =
SeaBIOS
>>> repository.
>=20
> Please find the logs attached.
>=20
> I=E2=80=99ll do one more test with the microcode update 0x0600063d, to =
verify
> that the panic also happens with that microcode version (I am pretty
> certain).

As written above, it looks like I was wrong, and 0x0600063d does not
cause the problem.


Kind regards,

Paul


--------------ms070306020309050804020004
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
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
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTAxMDkxMzE5MjRaMC8GCSqGSIb3DQEJBDEiBCAfx6773OY+/fy+vy7e
mLQ6EaaTBUc3/bg3JGLbBW8bmDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAIEc
ooVrBKhdddfnismpsUOsIg2y73OhjDG2uoomEpLHpCoJz68lOtRHQRsOv5nHmL6erPWXj0nj
7bz+0l8HI8Hw4exoaHcKg3nErvlM5HXe/QOPcZTpE10qUGeulRKTvpU9oeNSN4yLS65tw7T8
ilxPynWTPvnYvTXE9AOuD+aEKTv4RX2w6YazblWqBEc7kEyIL+PWHqjj0swnxMaRIdknyq59
7d/CqsynMW58cCAS7LJQs7EXJr8wVvtr0bl3PWFJUb05St0v/pdSr8DnSMygq1BeF89+JI4B
W7mVcnZbqdTpeXXXTafVubh7AnDLVa4yJCbPdd8/OXLRENGAGisAAAAAAAA=
--------------ms070306020309050804020004--
