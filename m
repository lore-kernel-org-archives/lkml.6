Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE17C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB6821874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfADMl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:41:29 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45341 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbfADMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:41:29 -0500
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EFAAA20135342C;
        Fri,  4 Jan 2019 13:41:25 +0100 (CET)
Subject: Re: General protection fault in `switch_mm_irqs_off()`
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
Message-ID: <65b3aa5c-c11b-6435-5761-3f1489f18ce5@molgen.mpg.de>
Date:   Fri, 4 Jan 2019 13:41:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <784ab00e-ed72-c1bc-bc0c-31264deb7726@molgen.mpg.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms010509010701040503000907"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010509010701040503000907
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


On 01/03/19 22:45, Paul Menzel wrote:

> On the server board Asus KGPE-D16 with AMD Opteron 6278 processor updat=
ing the microcode update in the firmware from 0x0600062e to 0x0600063e se=
ems to cause a general protection fault with Linux 4.14.87 and 4.20-rc7.
>=20
>> 46.859: [=C2=A0=C2=A0=C2=A0 7.573240] microcode: CPU31: patch_level=3D=
0x0600063e
>> 46.859: [=C2=A0=C2=A0=C2=A0 7.578507] microcode: Microcode Update Driv=
er: v2.2.
>> 46.860: [=C2=A0=C2=A0=C2=A0 7.578539] sched_clock: Marking stable (651=
0054745, 1068444659)->(7999876773, -421377369)
>> 46.860: [=C2=A0=C2=A0=C2=A0 7.593013] registered taskstats version 1
>> 46.861: [=C2=A0=C2=A0=C2=A0 7.598091] rtc_cmos 00:00: setting system c=
lock to 2000-01-01 08:01:51 UTC (946713711)
>> 46.862: [=C2=A0=C2=A0=C2=A0 7.606575] ALSA device list:
>> 46.862: [=C2=A0=C2=A0=C2=A0 7.609802]=C2=A0=C2=A0 No soundcards found.=

>> 46.865: [=C2=A0=C2=A0=C2=A0 7.615887] Freeing unused kernel image memo=
ry: 1564K
>> 46.871: [=C2=A0=C2=A0=C2=A0 7.627073] Write protecting the kernel read=
-only data: 20480k
>> 46.872: [=C2=A0=C2=A0=C2=A0 7.634366] Freeing unused kernel image memo=
ry: 2016K
>> 46.873: [=C2=A0=C2=A0=C2=A0 7.640297] Freeing unused kernel image memo=
ry: 584K
>> 46.874: [=C2=A0=C2=A0=C2=A0 7.645521] Run /init as init process
>> 46.877: [=C2=A0=C2=A0=C2=A0 7.652262] general protection fault: 0000 [=
#1] SMP NOPTI
>> 46.877: [=C2=A0=C2=A0=C2=A0 7.657931] CPU: 18 PID: 0 Comm: swapper/18 =
Not tainted 4.20.0-rc7.mx64.237 #1
>> 46.877: [=C2=A0=C2=A0=C2=A0 7.665514] Hardware name: ASUS KGPE-D16/KGP=
E-D16, BIOS 4.9-103-g637bef2037 01/02/2019
>> 46.878: [=C2=A0=C2=A0=C2=A0 7.673804] RIP: 0010:switch_mm_irqs_off+0xb=
2/0x640
>> 46.878: [=C2=A0=C2=A0=C2=A0 7.678948] Code: 48 c1 ef 09 83 e7 01 48 09=
 c7 65 48 8b 05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 =
00 00 b8 01 00 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7=
 01 85 c0 0f 8f 41 04
>> 46.879: [=C2=A0=C2=A0=C2=A0 7.698394] RSP: 0018:ffffc90006343e20 EFLAG=
S: 00010046
>> 46.879: [=C2=A0=C2=A0=C2=A0 7.703844] RAX: 0000000000000001 RBX: ffff8=
8981ca0b800 RCX: 0000000000000049
>> 46.879: [=C2=A0=C2=A0=C2=A0 7.711238] RDX: 0000000000000000 RSI: ffff8=
8981b87cf80 RDI: ffff88981ca0b800
>> 46.880: [=C2=A0=C2=A0=C2=A0 7.718665] RBP: ffffc90006343e70 R08: 00000=
001c81bec00 R09: 0000000000000000
>> 46.880: [=C2=A0=C2=A0=C2=A0 7.726092] R10: ffffc90006343e88 R11: 00000=
00000000000 R12: ffffffff82479b40
>> 46.880: [=C2=A0=C2=A0=C2=A0 7.733494] R13: 0000000000000000 R14: 00000=
00000000012 R15: ffff88981dd50080
>> 46.881: [=C2=A0=C2=A0=C2=A0 7.740853] FS:=C2=A0 0000000000000000(0000)=
 GS:ffff88981fa80000(0000) knlGS:0000000000000000
>> 46.881: [=C2=A0=C2=A0=C2=A0 7.749318] CS:=C2=A0 0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
>> 46.881: [=C2=A0=C2=A0=C2=A0 7.755281] CR2: 0000000000000000 CR3: 00000=
0000240a000 CR4: 00000000000406e0
>> 46.881: [=C2=A0=C2=A0=C2=A0 7.762761] Call Trace:
>> 46.881: [=C2=A0=C2=A0=C2=A0 7.765369]=C2=A0 ? __schedule+0x1b9/0x7b0
>> 46.882: [=C2=A0=C2=A0=C2=A0 7.769253]=C2=A0 __schedule+0x1b9/0x7b0
>> 46.882: [=C2=A0=C2=A0=C2=A0 7.772930]=C2=A0 schedule_idle+0x1e/0x40
>> 46.882: [=C2=A0=C2=A0=C2=A0 7.776744]=C2=A0 do_idle+0x146/0x200
>> 46.882: [=C2=A0=C2=A0=C2=A0 7.780181]=C2=A0 cpu_startup_entry+0x19/0x2=
0
>> 46.883: [=C2=A0=C2=A0=C2=A0 7.784274]=C2=A0 start_secondary+0x183/0x1b=
0
>> 46.883: [=C2=A0=C2=A0=C2=A0 7.788409]=C2=A0 secondary_startup_64+0xa4/=
0xb0
>> 46.883: [=C2=A0=C2=A0=C2=A0 7.792766] Modules linked in:
>> 46.883: [=C2=A0=C2=A0=C2=A0 7.796105] ---[ end trace a423e363fe1ecf67 =
]---
>> 46.884: [=C2=A0=C2=A0=C2=A0 7.800939] RIP: 0010:switch_mm_irqs_off+0xb=
2/0x640
>> 46.884: [=C2=A0=C2=A0=C2=A0 7.806048] Code: 48 c1 ef 09 83 e7 01 48 09=
 c7 65 48 8b 05 8e 34 fc 7e 48 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 =
00 00 b8 01 00 00 00 31 d2 <0f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7=
 01 85 c0 0f 8f 41 04
>> 46.884: [=C2=A0=C2=A0=C2=A0 7.825440] RSP: 0018:ffffc90006343e20 EFLAG=
S: 00010046
>> 46.885: [=C2=A0=C2=A0=C2=A0 7.830855] RAX: 0000000000000001 RBX: ffff8=
8981ca0b800 RCX: 0000000000000049
>> 46.885: [=C2=A0=C2=A0=C2=A0 7.838230] RDX: 0000000000000000 RSI: ffff8=
8981b87cf80 RDI: ffff88981ca0b800
>> 46.885: [=C2=A0=C2=A0=C2=A0 7.845614] RBP: ffffc90006343e70 R08: 00000=
001c81bec00 R09: 0000000000000000
>> 46.886: [=C2=A0=C2=A0=C2=A0 7.853047] R10: ffffc90006343e88 R11: 00000=
00000000000 R12: ffffffff82479b40
>> 46.886: [=C2=A0=C2=A0=C2=A0 7.860427] R13: 0000000000000000 R14: 00000=
00000000012 R15: ffff88981dd50080
>> 46.886: [=C2=A0=C2=A0=C2=A0 7.867862] FS:=C2=A0 0000000000000000(0000)=
 GS:ffff88981fa80000(0000) knlGS:0000000000000000
>> 46.886: [=C2=A0=C2=A0=C2=A0 7.876320] CS:=C2=A0 0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
>> 46.887: [=C2=A0=C2=A0=C2=A0 7.882351] CR2: 0000000000000000 CR3: 00000=
0000240a000 CR4: 00000000000406e0
>> 46.887: [=C2=A0=C2=A0=C2=A0 7.889746] Kernel panic - not syncing: Atte=
mpted to kill the idle task!
>> 46.888: [=C2=A0=C2=A0=C2=A0 7.896907] Kernel Offset: disabled
>> 46.888: [=C2=A0=C2=A0=C2=A0 7.900558] ---[ end Kernel panic - not sync=
ing: Attempted to kill the idle task! ]---
>=20
> Please find the whole log, including the coreboot messages, attached. T=
he time stamps in the beginning are from the script `readserial.py` from =
the SeaBIOS repository.
>=20
> Do you have an idea what is going on, and how to fix it?

Decoding the code, give the output below.

```
$ scripts/decodecode < /dev/shm/test.log=20
[ 7.806048] Code: 48 c1 ef 09 83 e7 01 48 09 c7 65 48 8b 05 8e 34 fc 7e 4=
8 39 c7 74 15 48 09 f8 a8 01 74 0e b9 49 00 00 00 b8 01 00 00 00 31 d2 <0=
f> 30 65 48 89 3d 6c 34 fc 7e 8b 05 9a ef a7 01 85 c0 0f 8f 41 04
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:	48 c1 ef 09          	shr    $0x9,%rdi
   4:	83 e7 01             	and    $0x1,%edi
   7:	48 09 c7             	or     %rax,%rdi
   a:	65 48 8b 05 8e 34 fc 	mov    %gs:0x7efc348e(%rip),%rax        # 0x7=
efc34a0
  11:	7e=20
  12:	48 39 c7             	cmp    %rax,%rdi
  15:	74 15                	je     0x2c
  17:	48 09 f8             	or     %rdi,%rax
  1a:	a8 01                	test   $0x1,%al
  1c:	74 0e                	je     0x2c
  1e:	b9 49 00 00 00       	mov    $0x49,%ecx
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	31 d2                	xor    %edx,%edx
  2a:*	0f 30                	wrmsr  		<-- trapping instruction
  2c:	65 48 89 3d 6c 34 fc 	mov    %rdi,%gs:0x7efc346c(%rip)        # 0x7=
efc34a0
  33:	7e=20
  34:	8b 05 9a ef a7 01    	mov    0x1a7ef9a(%rip),%eax        # 0x1a7efd=
4
  3a:	85 c0                	test   %eax,%eax
  3c:	0f                   	.byte 0xf
  3d:	8f 41 04             	popq   0x4(%rcx)

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:	0f 30                	wrmsr =20
   2:	65 48 89 3d 6c 34 fc 	mov    %rdi,%gs:0x7efc346c(%rip)        # 0x7=
efc3476
   9:	7e=20
   a:	8b 05 9a ef a7 01    	mov    0x1a7ef9a(%rip),%eax        # 0x1a7efa=
a
  10:	85 c0                	test   %eax,%eax
  12:	0f                   	.byte 0xf
  13:	8f 41 04             	popq   0x4(%rcx)
```

So the problem is with the instruction *wrmsr* [1].

The content of ECX, which according to [1] is written to, is not
in the logs though, as far as I can see.


Kind regards,

Paul


[1]: https://www.felixcloutier.com/x86/wrmsr


--------------ms010509010701040503000907
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
SIb3DQEJBTEPFw0xOTAxMDQxMjQxMjVaMC8GCSqGSIb3DQEJBDEiBCCtE+ktAHfntpQtB9kK
FVP8J3Bb+EelwrXTsKWJzERjXjBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAG/f
MWP2xJFkgVytGmaRJy/iGy3xXx4qx4RcejGYs1znLJ2jCarhT+g6AcSN9pUR4AaY14CQOEn1
ubawWtchWLYrPxsjr6IdTVMH0m2Jsr13kHdKYFgdnqirY1QC7RnzGJEDL7sl9UxB+EH528XH
U4ukeGTGNagK6oNrdZgRiw6GaoCI9v+egtCn87uIwKGhctgaVAgKw+GH7m8rJ/lhMevMhvng
4MTz9wUBiFextloFbcXbh372whZPCWaZM9CuLvlAnEqv/LQe2PQ4hFQkOZ8VBzPxV7Vlkg8g
gqzwo8lF354FW342TSQ2YmkXs1I/l7SIwEHhm2q4F0OougS0JwEAAAAAAAA=
--------------ms010509010701040503000907--
