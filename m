Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4150EC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DC92075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="Q33Jcndq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DC92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeJLBwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:52:14 -0400
Received: from mail.kdab.com ([176.9.126.58]:58100 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbeJLBwO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1539282226; x=1540146227; bh=AZz19uKaPCdbN7IG/zXkGvqqAEG
 rSQZJuiTgEuAbtqU=; b=Q33JcndqKgW59EtACAnVq69RyCsdpzlW+f7VwUsAKH/
 gxMH/YjVopIJt3StpbGcDlcN/aI+PHpa+t844CEy9vz62IMK2JNmr/NNIWK856wD
 cUUdxyYtWPEu/maGi+xQNEw72G+2YkAe9JhiajxYOpoRAHowCsMlZhmGyMQ6Q8c0
 =
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf report: don't crash on invalid inline debug
 information
Date:   Thu, 11 Oct 2018 20:23:31 +0200
Message-ID: <1768601.Weh5pZyhPy@agathebauer>
Organization: KDAB
In-Reply-To: <20180927191037.GG25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926135207.30263-3-milian.wolff@kdab.com>
 <20180927191037.GG25764@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5685400.uM0MzGOifb";
 micalg="sha256"; protocol="application/pkcs7-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5685400.uM0MzGOifb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 27. September 2018 21:10:37 CEST Arnaldo Carvalho de Melo 
wrote:
> Em Wed, Sep 26, 2018 at 03:52:07PM +0200, Milian Wolff escreveu:
> > When the function name for an inline frame is invalid, we must
> > not try to demangle this symbol, otherwise we crash with:
> > 
> > #0  0x0000555555895c01 in bfd_demangle ()
> > #1  0x0000555555823262 in demangle_sym (dso=0x555555d92b90, elf_name=0x0,
> > kmodule=0) at util/symbol-elf.c:215 #2  dso__demangle_sym
> > (dso=dso@entry=0x555555d92b90, kmodule=<optimized out>, kmodule@entry=0,
> > elf_name=elf_name@entry=0x0) at util/symbol-elf.c:400 #3 
> > 0x00005555557fef4b in new_inline_sym (funcname=0x0,
> > base_sym=0x555555d92b90, dso=0x555555d92b90) at util/srcline.c:89 #4 
> > inline_list__append_dso_a2l (dso=dso@entry=0x555555c7bb00,
> > node=node@entry=0x555555e31810, sym=sym@entry=0x555555d92b90) at
> > util/srcline.c:264 #5  0x00005555557ff27f in addr2line
> > (dso_name=dso_name@entry=0x555555d92430
> > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/
> > elf", addr=addr@entry=2888, file=file@entry=0x0,> 
> >     line=line@entry=0x0, dso=dso@entry=0x555555c7bb00,
> >     unwind_inlines=unwind_inlines@entry=true, node=0x555555e31810,
> >     sym=0x555555d92b90) at util/srcline.c:313> 
> > #6  0x00005555557ffe7c in addr2inlines (sym=0x555555d92b90,
> > dso=0x555555c7bb00, addr=2888, dso_name=0x555555d92430
> > "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/
> > elf")> 
> >     at util/srcline.c:358
> > 
> > So instead handle the case where we get invalid function names
> > for inlined frames and use a fallback '??' function name instead.
> > 
> > While this crash was originally reported by Hadrien for rust code,
> > I can now also reproduce it with trivial C++ code. Indeed, it seems
> > like libbfd fails to interpret the debug information for the inline
> > frame symbol name:
> > 
> > $ addr2line -e
> > /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/e
> > lf -if b48 main
> > /usr/include/c++/8.2.1/complex:610
> > ??
> > /usr/include/c++/8.2.1/complex:618
> > ??
> > /usr/include/c++/8.2.1/complex:675
> > ??
> > /usr/include/c++/8.2.1/complex:685
> > main
> > /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/mai
> > n.cpp:39
> > 
> > I've reported this bug upstream and also attached a patch there
> > which should fix this issue:
> > https://sourceware.org/bugzilla/show_bug.cgi?id=23715
> 
> Millian, what about this one, which is the cset it is fixing?

Hey Arnaldo,

just noticed this email and that the corresponding patch hasn't landed in 
perf/core yet. The patch set which introduced this is a64489c56c307 ("perf 
report: Find the inline stack for a given address"). Note that the code was 
introduced by this patch, but then subsequently touched and moved by follow up 
patches. So, is this the patch you want to see referenced? Otherwise, the 
latest patch which gets fixed is afaik: 7285cf3325b4a ("perf srcline: Show 
correct function name for srcline of callchains").

Can you please pick either of these patches and amend the commit message of my 
patch and push it to perf/urgent and perf/core?

Cheers
-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts
--nextPart5685400.uM0MzGOifb
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMDExMTgyMzMxWjAoBgkqhkiG9w0BCQ8xGzAZMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAvBgkqhkiG9w0BCQQxIgQgP1eo3YNsQ356bKf4kTQISsNrjeT9
UXttxnXzYdsRTLEwDQYJKoZIhvcNAQEBBQAEggEALV/vxC1h8SpOOGwjhb/Du8a8/gCCFiiVZozC
hdd7oEjXtb8GftTfgiFvM6W6zINZ28RrohE44d+Dhm5hTrK/h6qL/TIg6ptoG37mcJ7NG4EwEz5I
XBMRDSLSUAUPpXfIMjq+6HqWASBqed8kf/hc39GFCOcbI9cgwiR2eLRgGkCEHhnbOSM/5jV9Cqoz
n8j1h4Ya7XzzPSZJB0X8KmXcUZ67knBSHwrOzauRypDOy+SO0XO7kvGBde5985PId5q+1J7SuEhd
npW7z0DpK0rKe/qMET1OhCEhykelraUPyl/5YoyWIrF+NN9eyl1AYa41dIC2RtGwEhEj/d+G6uhz
XAAAAAAAAA==


--nextPart5685400.uM0MzGOifb--


