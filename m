Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B778BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDDF2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CTYXInSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDDF2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLGWOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:14:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36573 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGWOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:14:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so4126982lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 14:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoLYODf8fFE0NFFOJSU1bdcRYzBTGE7/48iETDRTqMU=;
        b=CTYXInSF5Calt79/SwfQJTR+ZlSJE6SYh2Nlbgeq77RSkWs0g5zGh9un49XqpVH9iX
         bkB8S7ZPa5vrQcIB/fqlKq3BZqoQgrD5SDGUVBEISRgiJTppfvLALV9d7hTc/kZAUSZp
         1DlBpv2jhbze7esvJhHZhalqEg/NGtGFAlxew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoLYODf8fFE0NFFOJSU1bdcRYzBTGE7/48iETDRTqMU=;
        b=b36NIxhX334Qpe3M9DcM0xsPslxiW1VJCSU5osKDrGLLoupz+0RrrI1hwOm25Art8N
         KMIerG+G0icP2kIKmC1P8IcFtXR0ugcCO525eT3xavl1WHl59Srxb/14/aCtHu6WkNWX
         blhePQiTEA94QABYRtxH3wSiJxTq0+TV8Hkoh0JhuAniTGNAzbznnY7tmVEk3W3KFnHv
         uF/KgdOhFCRSA5/je479iZWWEIKVHSVgmWpm91ixNj48UTVMafdZELmRaFzjQTxCYEpk
         u//QcgLBQA8jLKSHdrB9MeEUQXMDrTVdLZWublU5v1OVzGWzJ++kbmeonRDhOt42nPXf
         d/bQ==
X-Gm-Message-State: AA+aEWYfugzL6wtIOzqCrcUIesJjjHbk2lyElNxpA50FibWhlahSCiUJ
        wF1BO1tBYBpRv79P8TfaNBb/PPE4zrc=
X-Google-Smtp-Source: AFSGD/ULI/hYFeBXGz/qRx0EIpZJJ/caEt50u0Vgxb6KM89PqBvDY95ObkAFgQCxAJajfx0XfPWH2g==
X-Received: by 2002:a19:280f:: with SMTP id o15mr2275791lfo.0.1544220882360;
        Fri, 07 Dec 2018 14:14:42 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id g17sm815141lfg.78.2018.12.07.14.14.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:14:39 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id e5-v6so4841415lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 14:14:39 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr2259659ljh.59.1544220878704;
 Fri, 07 Dec 2018 14:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20181207184423.1962-1-sean.j.christopherson@intel.com>
 <20181207195223.23968-1-sean.j.christopherson@intel.com> <CAHk-=wgtN9nQBimLuOmBxY8eYqDRhNeBOW_uvnhqtZSFycyHuA@mail.gmail.com>
 <20181207220646.GH10404@linux.intel.com>
In-Reply-To: <20181207220646.GH10404@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Dec 2018 14:14:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizzTem4B3muo+DV5JqPBD0n1JJ8-NDjyY1fn-N4WYHCg@mail.gmail.com>
Message-ID: <CAHk-=wizzTem4B3muo+DV5JqPBD0n1JJ8-NDjyY1fn-N4WYHCg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/fault: Decode and print #PF oops in human readable form
To:     sean.j.christopherson@intel.com
Cc:     dave.hansen@linux.intel.com, Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com,
        Ingo Molnar <mingo@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f111e6057c75f07f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f111e6057c75f07f
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 7, 2018 at 2:06 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Looking at it again, my own personal preference would be to swap the order
> of the #PF lines.

Yeah, probably.

Also:

> [  160.246820] BUG: unable to handle kernel paging request at ffffbeef00000000
> [  160.247517] #PF: supervisor-privileged instruction fetch from kernel code
> [  160.248085] #PF: error_code(0x0010) - not-present page

With this form, I think the "kernel" in the first line is actually
misleading. Yes, it's a #PF for the kernel, but then the "kernel" on
the second line talks about what mode we were in when it happened, so
we have two different meanings of "kernel" on two adjacent lines.

So maybe  that "BUG: unable to handle kernel paging request" message
should be something like

  "BUG: unable to handle page fault for address ffffbeef00000000"

instead? Does that make sense to people?

Anyway, enough bike-shedding from me, I'll just shut up about this,
since I don't really care all that deeply, and I wasn't really the
target audience anyway. Sorry for the noise, and I'll leave the
decision to the people who actually wanted this.

                  Linus

--000000000000f111e6057c75f07f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIT/AYJKoZIhvcNAQcCoIIT7TCCE+kCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghEQMIIF5jCCA86gAwIBAgIQapvhODv/K2ufAdXZuKdSVjANBgkqhkiG9w0BAQwFADCBhTELMAkG
A1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEa
MBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNh
dGlvbiBBdXRob3JpdHkwHhcNMTMwMTEwMDAwMDAwWhcNMjgwMTA5MjM1OTU5WjCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC+s55XrCh2dUAWxzgDmNPGGHYhUPMleQtMtaDRfTpYPpynMS6n9jR22YRq2tA9NEjk6vW7
rN/5sYFLIP1of3l0NKZ6fLWfF2VgJ5cijKYy/qlAckY1wgOkUMgzKlWlVJGyK+UlNEQ1/5ErCsHq
9x9aU/x1KwTdF/LCrT03Rl/FwFrf1XTCwa2QZYL55AqLPikFlgqOtzk06kb2qvGlnHJvijjI03BO
rNpo+kZGpcHsgyO1/u1OZTaOo8wvEU17VVeP1cHWse9tGKTDyUGg2hJZjrqck39UIm/nKbpDSZ0J
sMoIw/JtOOg0JC56VzQgBo7ictReTQE5LFLG3yQK+xS1AgMBAAGjggE8MIIBODAfBgNVHSMEGDAW
gBS7r34CPfqm8TyEjq3uOJjs2TIy1DAdBgNVHQ4EFgQUgq9sjPjF/pZhfOgfPStxSF7Ei8AwDgYD
VR0PAQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwEQYDVR0gBAowCDAGBgRVHSAAMEwGA1Ud
HwRFMEMwQaA/oD2GO2h0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNlcnRpZmljYXRp
b25BdXRob3JpdHkuY3JsMHEGCCsGAQUFBwEBBGUwYzA7BggrBgEFBQcwAoYvaHR0cDovL2NydC5j
b21vZG9jYS5jb20vQ09NT0RPUlNBQWRkVHJ1c3RDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTANBgkqhkiG9w0BAQwFAAOCAgEAeFyygSg0TzzuX1bOn5dW7I+iaxf2
8/ZJCAbU2C81zd9A/tNx4+jsQgwRGiHjZrAYayZrrm78hOx7aEpkfNPQIHGG6Fvq3EzWf/Lvx7/h
k6zSPwIal9v5IkDcZoFD7f3iT7PdkHJY9B51csvU50rxpEg1OyOT8fk2zvvPBuM4qQNqbGWlnhMp
IMwpWZT89RY0wpJO+2V6eXEGGHsROs3njeP9DqqqAJaBa4wBeKOdGCWn1/Jp2oY6dyNmNppI4ZNM
UH4Tam85S1j6E95u4+1Nuru84OrMIzqvISE2HN/56ebTOWlcrurffade2022O/tUU1gb4jfWCcyv
B8czm12FgX/y/lRjmDbEA08QJNB2729Y+io1IYO3ztveBdvUCIYZojTq/OCR6MvnzS6X72HP0PRL
RTiOSEmIDsS5N5w/8IW1Hva5hEFy6fDAfd9yI+O+IMMAj1KcL/Zo9jzJ16HO5m60ttl1Enk8MQkz
/W3JlHaeI5iKFn4UJu1/cP2YHXYPiWf2JyBzsLBrGk1II+3yL8aorYew6CQvdVifC3HtwlSam9V1
niiCfOBe2C12TdKGu05LWIA3ZkFcWJGaNXOZ6Ggyh/TqvXG5v7zmEVDNXFnHn9tFpMpOUvxhcsjy
cBtH0dZ0WrNw6gH+HF8TIhCnH3+zzWuDN0Rk6h9KVkfKehIwggXYMIIDwKADAgECAhBMqvnK22Nv
4B/3TthbA4adMA0GCSqGSIb3DQEBDAUAMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRl
ciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRl
ZDErMCkGA1UEAxMiQ09NT0RPIFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xMDAxMTkw
MDAwMDBaFw0zODAxMTgyMzU5NTlaMIGFMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBN
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
AaOCAfMwggHvMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBRjn/GS
Juh8DKxLx8YgPKopKgyxBTAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAgBgNVHSUEGTAX
BggrBgEFBQcDBAYLKwYBBAGyMQEDBQIwEQYJYIZIAYb4QgEBBAQDAgUgMEYGA1UdIAQ/MD0wOwYM
KwYBBAGyMQECAQEBMCswKQYIKwYBBQUHAgEWHWh0dHBzOi8vc2VjdXJlLmNvbW9kby5uZXQvQ1BT
MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYsGCCsGAQUFBwEBBH8wfTBVBggr
BgEFBQcwAoZJaHR0cDovL2NydC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGlj
YXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2Rv
Y2EuY29tMCgGA1UdEQQhMB+BHXRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnMA0GCSqGSIb3
DQEBCwUAA4IBAQAGi1sxlNUFKWBzuBr+awa5Pl46M0AHRkFPiu3VKUkaNu8XuIA2i6Pj6rgiT/3l
7ca/KvxohOUvFTYnq6Fr26H6BJT6XaMiC6LItbfoIMB2yzFOVuruxfTUO7TCJPCg4oLEtUUIMS1v
KrajMYuEaI5rVAY04ntAa9nRnjj8TqDg+OXupr8yHrkomt7qWlsyZQKExtmQ4DvfEUADDY2ue6Kn
qNa5FHY8uBWlYBSaHnnR90Rr0Rqd4naFPQ1Kkkxp35g0tcdGBN5Qcyli834X9rdyhj9CwSwOSnCD
KYvaXyUP3o7hBubLcdMz/VM9VKT5HnU6c3rFemJSmUc41Htu57YYMYICsDCCAqwCAQEwga0wgZcx
CzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZv
cmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVu
dCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAyRamH6VuTQrvgXSXzzbh6jAN
BglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgiCHv1q2nVe4UQRTtAsKOPCCz7/odrQ8u
qYUuNZlDtNwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgxMjA3
MjIxNDM4WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIB
MA0GCSqGSIb3DQEBAQUABIIBABy84Moca+5y/vgXCMpBujWELcOAkbQOxTRkaNweQoQr5x97ouwD
iRcdyV4I5FX0z6pH9+rT9Be5MJbSYv9GcHgCZpJwZE/6fB70/wudTy16UunyEnrtVQt78jrHxZDD
qpDCoPHDj/YjEdWFWB8DdhVzn1Wo6gfxLNvnbnSxedXrV7BH5Ngngep4LtVnTNmk5nuFbbw/cgEP
empDikVYMf+etPU2mEZnRfkD05LrkUfmrkPVJf+NKrEhgUEjQobf+bvM/job5uWN5+A6JhafVK5r
L1oyRC5A+euJm1vGcWOoB3APTcc+P4rP8WQl8kKCVd6ScVD8DzT7El+Bx0LO/mA=
--000000000000f111e6057c75f07f--
