Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5D82081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="X5WliBnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5D82081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeKFIQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:16:55 -0500
Received: from mail.kdab.com ([176.9.126.58]:8707 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbeKFIQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1541458489; x=1542322490; bh=WH8FYCSKiBGxyIyxUY45MagYKO3
 fVZM23PbYWW91Evs=; b=X5WliBnM29mnQTwCm22Jgp5WsYKS8vjPCpUnFwyWCZz
 53oDJ1RvFxc9ASeLfaVrQsQiTLgnmxzSd2e0IbBFyItgtvrGvGBxwJUOw2woTbOT
 SFABFGVCovBKpnrr1Bdn70FPX3nHq+9/ciSk2q4mlmm1OMtAZleu7RLR8NedaC2s
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Date:   Mon, 05 Nov 2018 23:54:40 +0100
Message-ID: <3799078.YBnU1OB0PF@agathebauer>
Organization: KDAB
In-Reply-To: <20181105205119.GC25674@krava>
References: <2335309.gnWok9HYb4@agathebauer> <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2320365.l07J22gzEi";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2320365.l07J22gzEi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 5. November 2018 21:51:19 CET Jiri Olsa wrote:
> On Fri, Nov 02, 2018 at 06:56:50PM +0100, Milian Wolff wrote:
> 
> SNIP
> 
> > > > Note how precise levels 0 and 1 do not produce any samples where
> > > > unwinding
> > > > fails. But precise level 2 produces some, and precise level 3
> > > > increases
> > > > the
> > > > amount (by ca. ~2x).
> > > > 
> > > > I can reproduce this pattern on two separate Intel CPUs and kernel
> > > > versions
> > > > currently:
> > > > 
> > > > Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz with 4.18.16-arch1-1-ARCH
> > > > Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 4.14.78-1-lts
> > > > 
> > > > Could someone else try this? What about AMD and IBS - is it also
> > > > affected?
> > > > What about newer/different Intel CPUs?
> > > 
> > > I tried on intel and can't actualy see that.. how do the failed samples
> > > look like? like is there the stack dump attached, what's in the regs?
> > > 
> > > could you please paste the 'perf report -D' output for some of the
> > > failed samples?
> > 
> > See here for one case: https://paste.kde.org/prryvdilq
> 
> we should really print some helpfull debug output
> for this.. like to show some markers where the stack
> data starts

Further down below, the offset for the ustack start is given (0xe0). But yes, 
that would be welcome.

> > What Intel CPU did you use? What microcode version? Which kernel version?
> > 
> > Generally, isn't what I'm seeing actually a neccessary evil of the ustack
> > based unwinding in perf? I mean, the general procedure is as follows if
> > I'm
> > not mistaken:
> > 
> > - PMU triggers interrupt and PEBS stores RIP etc.
> > - code continous to execute, possibly changing the stack
> 
> I dont think the code continues to execute.. the stack is ok

Are you sure about this? I mean, isn't that the whole reason why we need PEBS? 
Generally, if you are sure about this, can you point me to some documentation 
on this to allow me to understand it better?

Also, how do you explain the scenario I am seeing, with `cycles:` and 
`cycles:p` not suffering from this issue, but `cycles:pp` and `cycles:ppp` 
leading to broken samples? It _has_ to be PEBS then, no? What else could 
explain this?

> the problem I saw in past is that the copy from user is not
> 100% and sometimes you might not get full stack data you
> asked for

But that would indicate missing data at the end of the ustack dump? In our 
case, the "problematic" data is always at the start.

Also note the apparent shift in the ustack copy which - in one case - directly 
correlatates with the code being executed, i.e. from objdump in libm I see:

0x0000000000029688 <+40>:    sub    $0x28,%rsp
(https://paste.kde.org/poywa7y2z)

The address of the expected parent frame is 7ffff7c7caf8 (hypotf32x+0x18). 
This can be found at offset 80 in the ustack dump (cf. https://paste.kde.org/
prryvdilq - ("f9 ca c7 f7 ff 7f" is found at 0x130, minus 0xe0 yields 0x50 or 
80).

From the libunwind (or libdw) debug output in perf, we see that the unwinder 
tries to access offset 32 (cf. https://paste.kde.org/prryvdilq#line-610), 
which is ofset by 48 from the desired value of 80. This offset is *veroy* 
close to the value of 40 we see in the libm disassembly for __hypot_function 
("$0x28,%rsp"). Is this really just a coincidence?

> have you tried with libdw unwinder? if one of the unwinder
> shows more callchains, we need to fix the other one ;-)

Yes, I've looked at both unwinders. Both try to access the same values, and 
both break due to seemingly wrong data being read from the stack. And if you 
look at my other patches, you may have seen that I've regularly fixed the 
libdw unwinder to bring it closer to libunwind.

Thanks
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart2320365.l07J22gzEi
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDEIw
ggXmMIIDzqADAgECAhBqm+E4O/8ra58B1dm4p1JWMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9u
IEF1dGhvcml0eTAeFw0xMzAxMTAwMDAwMDBaFw0yODAxMDkyMzU5NTlaMIGXMQswCQYDVQQGEwJH
QjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQK
ExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGlj
YXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AL6znlesKHZ1QBbHOAOY08YYdiFQ8yV5C0y1oNF9Olg+nKcxLqf2NHbZhGra0D00SOTq9bus3/mx
gUsg/Wh/eXQ0pnp8tZ8XZWAnlyKMpjL+qUByRjXCA6RQyDMqVaVUkbIr5SU0RDX/kSsKwer3H1pT
/HUrBN0X8sKtPTdGX8XAWt/VdMLBrZBlgvnkCos+KQWWCo63OTTqRvaq8aWccm+KOMjTcE6s2mj6
RkalweyDI7X+7U5lNo6jzC8RTXtVV4/Vwdax720YpMPJQaDaElmOupyTf1Qib+cpukNJnQmwygjD
8m046DQkLnpXNCAGjuJy1F5NATksUsbfJAr7FLUCAwEAAaOCATwwggE4MB8GA1UdIwQYMBaAFLuv
fgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSCr2yM+MX+lmF86B89K3FIXsSLwDAOBgNVHQ8B
Af8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADARBgNVHSAECjAIMAYGBFUdIAAwTAYDVR0fBEUw
QzBBoD+gPYY7aHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2VydGlmaWNhdGlvbkF1
dGhvcml0eS5jcmwwcQYIKwYBBQUHAQEEZTBjMDsGCCsGAQUFBzAChi9odHRwOi8vY3J0LmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FBZGRUcnVzdENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Au
Y29tb2RvY2EuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQB4XLKBKDRPPO5fVs6fl1bsj6JrF/bz9kkI
BtTYLzXN30D+03Hj6OxCDBEaIeNmsBhrJmuubvyE7HtoSmR809AgcYboW+rcTNZ/8u/Hv+GTrNI/
AhqX2/kiQNxmgUPt/eJPs92Qclj0HnVyy9TnSvGkSDU7I5Px+TbO+88G4zipA2psZaWeEykgzClZ
lPz1FjTCkk77ZXp5cQYYexE6zeeN4/0OqqoAloFrjAF4o50YJafX8mnahjp3I2Y2mkjhk0xQfhNq
bzlLWPoT3m7j7U26u7zg6swjOq8hITYc3/np5tM5aVyu6t99p17bTbY7+1RTWBviN9YJzK8HxzOb
XYWBf/L+VGOYNsQDTxAk0Hbvb1j6KjUhg7fO294F29QIhhmiNOr84JHoy+fNLpfvYc/Q9EtFOI5I
SYgOxLk3nD/whbUe9rmEQXLp8MB933Ij474gwwCPUpwv9mj2PMnXoc7mbrS22XUSeTwxCTP9bcmU
dp4jmIoWfhQm7X9w/Zgddg+JZ/YnIHOwsGsaTUgj7fIvxqith7DoJC91WJ8Lce3CVJqb1XWeKIJ8
4F7YLXZN0oa7TktYgDdmQVxYkZo1c5noaDKH9Oq9cbm/vOYRUM1cWcef20Wkyk5S/GFyyPJwG0fR
1nRas3DqAf4cXxMiEKcff7PNa4M3RGTqH0pWR8p6EjCCBlQwggU8oAMCAQICEAf6KCF9+1doL2oE
OTPysLwwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0w
OwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMB4XDTE3MDUyMzAwMDAwMFoXDTIwMDUyMjIzNTk1OVowggFZMQswCQYDVQQGEwJTRTEPMA0G
A1UEERMGNjgzIDMxMRIwEAYDVQQIEwlWYWVybWxhbmQxEDAOBgNVBAcTB0hhZ2ZvcnMxGDAWBgNV
BAkTD05vcnJpbmdzIHZhZWcgMjEPMA0GA1UEEhMGQm94IDMwMSYwJAYDVQQKDB1LbGFyw6RsdmRh
bGVucyBEYXRha29uc3VsdCBBQjEdMBsGA1UECxMUQSBLREFCIEdyb3VwIENvbXBhbnkxQzBBBgNV
BAsMOklzc3VlZCB0aHJvdWdoIEtsYXLDpGx2ZGFsZW5zIERhdGFrb25zdWx0IEFCIEUtUEtJIE1h
bmFnZXIxHzAdBgNVBAsTFkNvcnBvcmF0ZSBTZWN1cmUgRW1haWwxFTATBgNVBAMTDE1pbGlhbiBX
b2xmZjEkMCIGCSqGSIb3DQEJARYVbWlsaWFuLndvbGZmQGtkYWIuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAxrzfNBVvRbiAknuTBXuQnNm9sLIFLo0vbPB6kswk78A3tA++Zn5c
lQUHhGlQq1cdYxagnUpqwvG3Sod15mPSOLkAPf/mabLN7p+lFbRaUP+97ZkTZtvb4BCC3osIEFI4
G393OSFWqc2qmIPE/SwSASbAA20Fcaa2M6P1lhOk/ttUh2jIurTPF0wUycIA7lBddrOgaOA8e2m6
iLTNHtlrfRbBaUX91D5ebY+UWmIjXSQ9+CtutMzBkwnF0rZKririvOkklg9VzEGNQVHrQfDF2s/U
pOtmtuVSwElauGT/KALyCFuIrYC1pmaKH8S1xODJqiRaf6jH8E+KQzKjyM/ErwIDAQABo4IB1TCC
AdEwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFN+m99RtIuA1bSdw
6b1brOX7X3AJMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAgBgNVHREEGTAXgRVtaWxpYW4ud29s
ZmZAa2RhYi5jb20wDQYJKoZIhvcNAQELBQADggEBABf47LSJADqH+ow9INv3QM1NC/qq2bjxGvsZ
68iD11VEUAFlsYfsVTgQqUirwPVTYenXtwVBELHZyywsui1JxL7HKQetLQegDDP/RyfjReVaWxhy
3OpuItsgLVbru9QVgPifnoBFPtfZcwjeJDmeSbLT8oj4Rd0KYBOIve7WKvsfNPsNwfbLwY2zILkE
LjxZcVi2AwZHDyab+dzL/3YcLuJj1lSawBGn7ilpcdZydlv4aye51pD/MemLIYLcylt+ImrmjnTV
y+QlAHRF3s5FE8yAr+W1MBD/1bKZCSgFt8VQoAlz3hiQh8QqZp4Zl8WuVL4+mP/mT6VDEWgq/0Bo
cukxggJuMIICagIBATCBrDCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNV
BAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EC
EAf6KCF9+1doL2oEOTPysLwwDQYJYIZIAWUDBAIBBQCggZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMTA1MjI1NDQwWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgYuy77d75O0v8alWSS0AiE7T5NYgB
3Ha5iyUAFO5HZ0UwDQYJKoZIhvcNAQEBBQAEggEAr6T0Ea1iXAOWGz38jWF6LF9VentRInU0KvnT
QDftwgCSv9N7DeAYe/s5he6w5K7trIlATeSXAgSnk/GvChb4c3sOJXDmI21zGrNlw1bsYIsknE38
PHlwQGM07pjZhNpDWmLL9gzE+gPv3HoVe0rXpQBKjVz+jgSpKM1zWI40ExqZ3RSGrBdhMihimAfh
3xI++mQfrTFyTBOlSMzgbl5H1OYKqaE8PmTf+qOWtUE2T0e1qR+bJ7DsPv0ge9iwWzuVMiFQywC1
w2nobjxdPiWHdQnrrohcqKj62iDuMvAsdPH6fWICP5B9VtzteLEF8OepOKMVmRdagtUjbwlzS/UE
MAAAAAAAAA==


--nextPart2320365.l07J22gzEi--


