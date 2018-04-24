Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeDXJIm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:08:42 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:32823 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753068AbeDXJIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:08:37 -0400
Subject: =?UTF-8?Q?Re:_How_to_disable_Linux_kernel_self-extraction_=28KERNEL?=
 =?UTF-8?B?X0daSVAsIEtFUk5FTF9CWklQMiwg4oCmKT8=?=
To: Adam Borowski <kilobyte@angband.pl>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>
References: <9468be0e-5eb9-246c-e60e-3d8019a42fd1@molgen.mpg.de>
 <20180422102033.GB26243@amd>
 <b22efb58-b63e-7130-f2d7-a9d28225ef9b@molgen.mpg.de>
 <20180422205208.GA8672@amd> <20180423170230.GA22412@amd>
 <20180424020824.2vsddcdndjnvdm46@angband.pl>
From: Paul Menzel <pmenzel+linux-kernel@molgen.mpg.de>
Message-ID: <bb5bf465-bf71-4ddb-2a7e-866bb0f76606@molgen.mpg.de>
Date: Tue, 24 Apr 2018 11:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424020824.2vsddcdndjnvdm46@angband.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050708010705080802070600"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050708010705080802070600
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Adam,


Thank you very much to join the discussion.

On 04/24/18 04:08, Adam Borowski wrote:
> On Mon, Apr 23, 2018 at 07:02:30PM +0200, Pavel Machek wrote:
>>>>>> I try to decrease boot time, and my system has an SSD and enough s=
pace, so
>>>>>> loading 18 instead of 12 MB doesn=E2=80=99t make a difference, but=
 the
>>>>>> self-extraction is noticeable. So, I like to disable it.
>>>>>
>>>>> How long does GZIP extraction take on your hardware?
>>>>
>>>> It=E2=80=99s hard to measure =E2=80=93 at least I didn=E2=80=99t fin=
d a way to do so =E2=80=93, but counting
>>>> from the last GRUB message to the first message of Linux (with `quie=
t`
>>>> removed from the the command line), it takes roughly *two* seconds.
>=20
> I took a somewhat different approach: I recorded the output from grub+k=
ernel
> to ttyrec over serial line, and rigged ttyrec2ansi to output timestamp
> difference from the last checkpoint every time an '\e' or '\n' is seen.=

> '\e' is important, as there's no other marking for when grub stops the
> interactive phase and starts the actual boot.

Nice work. It=E2=80=99d be great, if you shared these patches, so others =
and I=20
can reproduce it.

(Also, `scripts/extract-vmlinux` needs to be updated for LZ4.)

> Turns out that, reading from SSD, grub is way way slower than it should=
 take
> normally.  The machine is old (AMD Phenom II X6 1055T), SSD is Crucial
> CT240M500SSD1.

What firmware does the device (mainboard) have? Legacy BIOS or UEFI (or=20
even coreboot ;-)). It=E2=80=99s my understanding, that GRUB does not hav=
e a=20
native driver with the legacy BIOS and UEFI, and just uses the BIOS=20
calls or the UEFI equivalent.

> I also have the zstd patch applied, which adds another data point.
>=20
> The two "Loading XXX ..." lines come from grub, those timestamped withi=
n []
> brackets from the kernel, =E2=8C=A9=E2=8C=AAare ttyrec timestamps, =E2=A4=
=B8 is wrapped lines.
>=20
>=20
> zstd:
>=20
> Loading Linux 4.17.0-rc2-debug-00025-gd426b0ba363d ...=E2=8C=A90.739823=
=E2=8C=AA
> ^MLoading initial ramdisk ...=E2=8C=A90.402010=E2=8C=AA
> ^M[    0.000000] Linux version 4.17.0-rc2-debug-00025-gd426b0ba363d =E2=
=A4=B8
> (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 2=
3=E2=A4=B8
> 10:25:58 CEST 2018^M=E2=8C=A90.785922=E2=8C=AA
> [    0.000000] Command line: BOOT_IMAGE=3D/sys/boot/vmlinuz-4.17.0-rc2-=
debug-00025-gd426b0ba363d=E2=A4=B8
>   root=3DUUID=3Db7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=3Dsub=
vol=3Dsys syscall.x32=3Dy=E2=A4=B8
>   console=3Dtty0 console=3DttyS0,115200n8 no_console_suspend^M=E2=8C=A9=
0.020199=E2=8C=AA
>=20
> gzip:
>=20
> Loading Linux 4.17.0-rc2-debug-gz-00025-gd426b0ba363d ...=E2=8C=A90.724=
988=E2=8C=AA
> ^MLoading initial ramdisk ...=E2=8C=A90.357951=E2=8C=AA
> ^M[    0.000000] Linux version 4.17.0-rc2-debug-gz-00025-gd426b0ba363d =
=E2=A4=B8
> (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 2=
3 =E2=A4=B8
> 23:15:07 CEST 2018^M=E2=8C=A90.777977=E2=8C=AA
> [    0.000000] Command line: BOOT_IMAGE=3D/sys/boot/vmlinuz-4.17.0-rc2-=
debug-gz-00025-gd426b0ba363d=E2=A4=B8
>   root=3DUUID=3Db7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=3Dsub=
vol=3Dsys syscall.x32=3Dy=E2=A4=B8
>   console=3Dtty0 console=3DttyS0,115200n8 no_console_suspend^M=E2=8C=A9=
0.020117=E2=8C=AA
>=20
> lz4:
>=20
> Loading Linux 4.17.0-rc2-debug-none-00025-gd426b0ba363d ...=E2=8C=A90.7=
99969=E2=8C=AA
> ^MLoading initial ramdisk ...=E2=8C=A90.424959=E2=8C=AA
> ^M[    0.000000] Linux version 4.17.0-rc2-debug-lz4-00025-gd426b0ba363d=
 =E2=A4=B8
> (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Tue Apr 2=
4 =E2=A4=B8
> 00:34:59 CEST 2018^M=E2=8C=A90.732925=E2=8C=AA
> [    0.000000] Command line: BOOT_IMAGE=3D/sys/boot/vmlinuz-4.17.0-rc2-=
debug-lz4-00025-gd426b0ba363d=E2=A4=B8
>   root=3DUUID=3Db7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=3Dsub=
vol=3Dsys syscall.x32=3Dy=E2=A4=B8
>   console=3Dtty0 console=3DttyS0,115200n8 no_console_suspend^M=E2=8C=A9=
0.021019=E2=8C=AA
>=20
> zstd again:
>=20
> Loading Linux 4.17.0-rc2-debug-00025-gd426b0ba363d ...=E2=8C=A90.728852=
=E2=8C=AA
> ^MLoading initial ramdisk ...=E2=8C=A90.399968=E2=8C=AA
> ^M[    0.000000] Linux version 4.17.0-rc2-debug-00025-gd426b0ba363d =E2=
=A4=B8
> (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #1 SMP Mon Apr 2=
3 =E2=A4=B8
> 10:25:58 CEST 2018^M=E2=8C=A90.786964=E2=8C=AA
> [    0.000000] Command line: BOOT_IMAGE=3D/sys/boot/vmlinuz-4.17.0-rc2-=
debug-00025-gd426b0ba363d=E2=A4=B8
>   root=3DUUID=3Db7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=3Dsub=
vol=3Dsys syscall.x32=3Dy=E2=A4=B8
>   console=3Dtty0 console=3DttyS0,115200n8 no_console_suspend^M=E2=8C=A9=
0.020071=E2=8C=AA
>=20
> lz4 rigged for no compression:
>=20
> Loading Linux 4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty ...=E2=8C=
=A90.479834=E2=8C=AA
> ^MLoading initial ramdisk ...=E2=8C=A92.246985=E2=8C=AA

Just to be sure. The 2.2 seconds are from loading the 27 MB Linux kernel =

image, right?

> ^M[    0.000000] Linux version 4.17.0-rc2-debug-none-00025-gd426b0ba363=
d-dirty =E2=A4=B8
> (kilobyte@umbar) (gcc version 7.3.0 (Debian 7.3.0-16)) #5 SMP Tue Apr 2=
4 =E2=A4=B8
> 02:57:18 CEST 2018^M=E2=8C=A90.711949=E2=8C=AA
> [    0.000000] Command line: BOOT_IMAGE=3D/sys/boot/vmlinuz-4.17.0-rc2-=
debug-none-00025-gd426b0ba363d-dirty=E2=A4=B8
>   root=3DUUID=3Db7c38da9-ae84-4083-a1f8-6d7b4fc33961 ro rootflags=3Dsub=
vol=3Dsys syscall.x32=3Dy=E2=A4=B8
>   console=3Dtty0 console=3DttyS0,115200n8 no_console_suspend^M=E2=8C=A9=
0.021902=E2=8C=AA
>=20
> Sizes of relevant files:
>=20
> 14826134 initrd.img-4.17.0-rc2-debug-00025-gd426b0ba363d    (zstd)
> 14826352 initrd.img-4.17.0-rc2-debug-gz-00025-gd426b0ba363d
> 14826909 initrd.img-4.17.0-rc2-debug-lz4-00025-gd426b0ba363d
> 14826761 initrd.img-4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty
>   6567408 vmlinuz-4.17.0-rc2-debug-00025-gd426b0ba363d       (zstd)
>   7230960 vmlinuz-4.17.0-rc2-debug-gz-00025-gd426b0ba363d
>   8775152 vmlinuz-4.17.0-rc2-debug-lz4-00025-gd426b0ba363d
> 27821552 vmlinuz-4.17.0-rc2-debug-none-00025-gd426b0ba363d-dirty
> (I did not alter initrd compression, which is zstd in all cases).

Does the size of the uncompressed image match the size in=20
`arch/x86/boot/compressed/vmlinux.bin`?

>>> So yes, looks like uncompressed kernel image may be good idea.
>=20
> Seems like the time to actually read this far bigger file from the disk=

> using grub's inefficient way, takes longer than the gains from faster
> decompression.  You can eliminate the decompression step altogether by
> avoiding copying, but it still looks like it's not a win.
>=20
> I've seen u-boot taking ~60 seconds to read from a SD card, too.

I could test on my coreboot systems, if GRUB is faster with the native=20
AHCI driver.

> Another surprise is that zstd is a notch _slower_ than gzip (in userspa=
ce
> it's drastically faster for the same compression ratio), but reduced di=
sk
> space is still nice.  It's worth investigating why it's not as fast as =
it
> should be.

Maybe that should be done in a separate thread. I=E2=80=99ll split it out=
=2E

>> Actually... Compressors usually have a mode when they store the data
>> uncompressed. So you should be able to prepare .gz image which is not
>> really compressed inside, and thus really fast to uncompress.
>=20
> I can't seem to find any.  IIRC xz format can store uncompressed blocks=
 but
> the tool doesn't appear to expose this as an option.
>=20
>> Or maybe even better -- there should be some compression algorithms
>> that are fast enough to uncompress that there should be no
>> slowdown. Maybe use one of those?
>=20
> Perhaps my method is totally wrong, but differences in decompression sp=
eed
> are surprisingly small, dwarfed by whatever else the kernel does betwee=
n
> messages.
>=20
> I did not test xz, nor ran tests more than once, but it's 4am so these =
are
> things to do tomorrow.

It=E2=80=99d be interesting to find out, what is happening in the first 7=
00 ms,=20
before the first Linux message is transmitted over serial line. It could =

be, that the serial line affects the time stamps for example, or takes=20
so long to set up the serial console.


Kind regards,

Paul


--------------ms050708010705080802070600
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
SIb3DQEJBTEPFw0xODA0MjQwOTA4MzRaMC8GCSqGSIb3DQEJBDEiBCBofWmy0O3xpRS6ZoIP
Lr5iW7xi1AR0PvgQRDxYo8F+ijBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAHTu
de21RSDtYo4RVKaJMr5zjyQkGrIUSfUpLjvQvYiUKOBSaTcwj3VU3hOSTAg9YmkMOaSop390
Jna3w1pvuz1TSs4Jgat4PbqvDSVTMuWCrpU9DLVQLM7EojAt3afNUOVdF063nN0BbZDbSR7H
IqmEEOib+k5mjblLn7l5YDd/hOFPJlicdaNkMCXbzaKHJyyFRZ2NVDnfi+WQh+RlXDx4wdbp
IaQ5AiwA0fdIGL6UdMQ/Gy9GOHe5wd42rGlIjAk+p1UqnAIJCcu0SUYYWIWjxDc7+mscis1o
yqQEyS/bVn9GwanGTxOKy2uxephEtqU8hUk/7sS4Fm7KKrMNLygAAAAAAAA=
--------------ms050708010705080802070600--
