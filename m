Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57375C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B728206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ij9zRF1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B728206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeJDB1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:27:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34720 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbeJDB1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:27:44 -0400
Received: by mail-io1-f67.google.com with SMTP id k19-v6so5897829iom.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usPvgQB8wbZCwTYWZp18vroBozZi5rc8LTGjIvugodk=;
        b=Ij9zRF1LxS9/YM1qC2tXKTWI6sqmoTTL1612vGypKgMVFGIXEcdnFoa3aOAfPkE53v
         mU9dq4U1iyMA25RhL5/Bgc4L92Pd5e5rAJoRsJc+WL8udXVppGxCDvtSAxLXTvHO2mar
         /JU0mdlNuxGeN0Fpui9fF4kUymOsFYLoKLy9NM7CLRCbH27kBod+AKU3YpzwjdvRb1Bu
         Dt+OiVPQrG8R72N1KKE3imcLsOwkN48vs23HQ29AKQUxYVn/Ds3zaLjJd2kYWuhhLU/a
         8Za4F8+pEkIhmi8Kc248z9gTFNlMQetI0KKLDSMSc8FZI8vLetv/CPbjkhtfDwkL7GD0
         gcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usPvgQB8wbZCwTYWZp18vroBozZi5rc8LTGjIvugodk=;
        b=etoFWNTudPmbVtWtzZmk8SRZ2JuSopnKyhc3ssuvbo9CzDAaOD8a0KJpeoHRSg3AK9
         GcyxDFogHUOzKlEW5zQEOHIrQsTX1/WbYZnbHeinz7csIJgR0O6xSzxKWG0quT5ozF25
         6FTZ2t+imQHEuSjKm4b+ZkFn/ZKsCoE8JhywBYlssZ2KlQ+qdo1gqCdTOlCr1EoZ5XHz
         +xtS4ClJvSHoQDLR9WMaw6OM1IOOHh08o0qJM0AMQ78zvokdLyai8cp6Nv93j1ef2+FT
         0gJ61UPs6/oqPjMCd5MISOgw5VAipfrHYjA3CBO22cXmA/TEwsYlujjjzI7IQnZ0rX9E
         gTfg==
X-Gm-Message-State: ABuFfojLe1EdadoxTY3ZlOSWH7iOPelcHiybxx9dFAIHaEG52iD6QWQi
        HkxFDbzUKWbrLR0L6yW52gJZCKmb6h79WyRmkV2mpA==
X-Google-Smtp-Source: ACcGV61WZVj/XS72C2uu3a27F9lyfDDxIoxh98TnAEWeFTg63cLpJnpS/PCYfj7dZDaZt7oKUtcbjPA14Sx1Z59T6+g=
X-Received: by 2002:a6b:9286:: with SMTP id u128-v6mr2007967iod.289.1538591889698;
 Wed, 03 Oct 2018 11:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180927194601.207765-1-wonderfly@google.com> <20181001152324.72a20bea@gandalf.local.home>
 <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com>
 <20181002084225.6z2b74qem3mywukx@pathway.suse.cz> <CAJmjG2-RrG5XKeW1-+rN3C=F6bZ-L3=YKhCiQ_muENDTzm_Ofg@mail.gmail.com>
 <20181002212327.7aab0b79@vmware.local.home> <20181003091400.rgdjpjeaoinnrysx@pathway.suse.cz>
 <CAJmjG2_4JFA=qL-d2Pb9umUEcPt9h13w-g40JQMbdKsZTRSZww@mail.gmail.com> <20181003133704.43a58cf5@gandalf.local.home>
In-Reply-To: <20181003133704.43a58cf5@gandalf.local.home>
From:   Daniel Wang <wonderfly@google.com>
Date:   Wed, 3 Oct 2018 11:37:56 -0700
Message-ID: <CAJmjG291w2ZPRiAevSzxGNcuR6vTuqyk6z4SG3xRsbaQh5U3zQ@mail.gmail.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
To:     rostedt@goodmis.org
Cc:     Petr Mladek <pmladek@suse.com>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com, akpm@linux-foundation.org,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        tj@kernel.org, torvalds@linux-foundation.org, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000010ad350577575703"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000010ad350577575703
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 3, 2018 at 10:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> Just so I understand correctly. Does the panic hit with and without the
> suggested backport patch? The only difference is that you get the full
> output with the patch and limited output without it?

When `softlockup_panic` is set (which is what my original repro had and
what we use in production), without the backport patch, the expected panic
would hit a seemingly deadlock. So even when the machine is configured
to reboot immediately after the panic (kernel.panic=-1), it just hangs there
with an incomplete backtrace. With your patch, the deadlock doesn't happen
and the machine reboots successfully.

This was and still is the issue this thread is trying to fix. The last
log snippet
was from an "experiment" that I did in order to understand what's really
happening. So far the speculation has been that the panic path was trying
to get a lock held by a backtrace dumping thread, but there is not enough
evidence which thread is holding the lock and how it uses it. So I set
`softlockup_panic` to 0, to get panic out of the equation. Then I saw that one
CPU was indeed holding the console lock, trying to write something out. If
the panic was to hit while it's doing that, we might get a deadlock.

>
> -- Steve
>


-- 
Best,
Daniel

--00000000000010ad350577575703
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7QYJKoZIhvcNAQcCoIIS3jCCEtoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBTMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
9w0BAQsFAAOCAQEACskdySGYIOi63wgeTmljjA5BHHN9uLuAMHotXgbYeGVrz7+DkFNgWRQ/dNse
Qa4e+FeHWq2fu73SamhAQyLigNKZF7ZzHPUkSpSTjQqVzbyDaFHtRBAwuACuymaOWOWPePZXOH9x
t4HPwRQuur57RKiEm1F6/YJVQ5UTkzAyPoeND/y1GzXS4kjhVuoOQX3GfXDZdwoN8jMYBZTO0H5h
isymlIl6aot0E5KIKqosW6mhupdkS1ZZPp4WXR4frybSkLejjmkTYCTUmh9DuvKEQ1Ge7siwsWgA
NS1Ln+uvIuObpbNaeAyMZY0U5R/OyIDaq+m9KXPYvrCZ0TCLbcKuRzCCBB4wggMGoAMCAQICCwQA
AAAAATGJxkCyMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAt
IFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTExMDgwMjEw
MDAwMFoXDTI5MDMyOTEwMDAwMFowZDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24g
bnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVyc29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hB
MjU2IC0gRzIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCg/hRKosYAGP+P7mIdq5NB
Kr3J0tg+8lPATlgp+F6W9CeIvnXRGUvdniO+BQnKxnX6RsC3AnE0hUUKRaM9/RDDWldYw35K+sge
C8fWXvIbcYLXxWkXz+Hbxh0GXG61Evqux6i2sKeKvMr4s9BaN09cqJ/wF6KuP9jSyWcyY+IgL6u2
52my5UzYhnbf7D7IcC372bfhwM92n6r5hJx3r++rQEMHXlp/G9J3fftgsD1bzS7J/uHMFpr4MXua
eoiMLV5gdmo0sQg23j4pihyFlAkkHHn4usPJ3EePw7ewQT6BUTFyvmEB+KDoi7T4RCAZDstgfpzD
rR/TNwrK8/FXoqnFAgMBAAGjgegwgeUwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8C
AQEwHQYDVR0OBBYEFCYkkosf00SvsbAbba/udNKMeAADMEcGA1UdIARAMD4wPAYEVR0gADA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzA2BgNVHR8E
LzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24ubmV0L3Jvb3QtcjMuY3JsMB8GA1UdIwQY
MBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQACAFVjHihZCV/IqJYt
7Nig/xek+9g0dmv1oQNGYI1WWeqHcMAV1h7cheKNr4EOANNvJWtAkoQz+076Sqnq0Puxwymj0/+e
oQJ8GRODG9pxlSn3kysh7f+kotX7pYX5moUa0xq3TCjjYsF3G17E27qvn8SJwDsgEImnhXVT5vb7
qBYKadFizPzKPmwsJQDPKX58XmPxMcZ1tG77xCQEXrtABhYC3NBhu8+c5UoinLpBQC1iBnNpNwXT
Lmd4nQdf9HCijG1e8myt78VP+QSwsaDT7LVcLT2oDPVggjhVcwljw3ePDwfGP9kNrR+lc8XrfClk
WbrdhC2o4Ui28dtIVHd3MIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAw
TDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24x
EzARBgNVBAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAw
HgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEG
A1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5Bngi
FvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X
17YUhhB5uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmm
KPZpO/bLyCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hp
sk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7
DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQF
MAMBAf8wHQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBL
QNvAUKr+yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25s
bwMpjjM5RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV
3XpYKBovHd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyr
VQ4PkX4268NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E
7gUJTb0o2HLO02JQZR7rkpeDMdmztcpHWD9fMIIEajCCA1KgAwIBAgIMTmnftMpllv264rvDMA0G
CSqGSIb3DQEBCwUAMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSIw
IAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxMB4XDTE4MDYyNzE2NTUyN1oXDTE4MTIy
NDE2NTUyN1owJTEjMCEGCSqGSIb3DQEJAQwUd29uZGVyZmx5QGdvb2dsZS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvqTn5fjMyxd2JmEjHMdHZc/D9hSkUVivZIYkBNkexkbC6
v4DDP8HCdjKkGNNKLJWJQCHLyGTJv2uwnQHTThlEJYrvATCkg2y1SSapaXqMlgSYSskrQM/D2mfY
TnDa0NzJ/Vy1jqzvmLBpacy3D/RqV2seky2k3x3nVC4bzGaJ+IPxKTRjIccixTxvWU+S64NK3jek
VaUPAqG9D59xbHOEbEsu/F0rpqhvVfl733hzS37eBlUmTdDTpgDox/kApF1hI7WMyijIp77fuLbr
Q9C6hetDKotdJX1jmZg9TifwJaDf1HFyrzHzl3jkxELVqvLS3n3nKvNf1PWlDVB5H9zrAgMBAAGj
ggFxMIIBbTAfBgNVHREEGDAWgRR3b25kZXJmbHlAZ29vZ2xlLmNvbTBQBggrBgEFBQcBAQREMEIw
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFHswV6b+EY77vBWQKD6Dmp9n2Jp7MB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQCKdekZm8Fn
LFr+VBrtMVdmg4uKT25UuNxBxtgYJNqP/hYvkbGxHZnbTeQs63W5u+DW++SIfXI0aP1Lp34TFidR
bIL+4+xzfrlWGFcPb1IBl0fdNr5mnUdluXE78N0zwUiv3qa66dwP8oVooeDmRHOHO0A20C5/24q7
GIWfW2K2CeBWRj0OI1P6XUm+unjVNzVz6fE9J91Xf13NxK9Pc647cBIP4eiHNVa7ErprHQoDevx+
OHFHle2OOiJZoAqFNvKbQSuWBg+Obv3CjPLZ7lwdB9VBg3F5qEaD+BsyHwj+kMinP7wCI+mIc1nU
PcdI0z7gBtGEit9qr9qcJrdKjDlTMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
TmnftMpllv264rvDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC+VV0nCWNK7jcf
R8vegnTXnm8xW7ahhaVL6cVOWe58HDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xODEwMDMxODM4MTBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAr6g+2ygm1pGc/s/4v7n4Nlw1fMVnoDwJ
uGAQcS52x/hMl8E4Kfj5Qnq85ryHsdFt5dpwRqY0eL2v3hqsv2cmS7vCrBNX6rDgTxEoNi5LGx/B
Z7GhGHh430YVnoSe6mTUdGmd9onrksnu0PUp03FWNTzHGVleCoSttaJhphWfapC/K+I0D8TKcaxT
9gy93fwgldtOUcuMojEcmQN5ppbeDdoCJ+i3pyVID2MXLStCUkwTLjW6Dgc1Sge4XY97HCBLQuQL
F+UfXDUimzakg49DuBVoNQy7yje53kL4p6ZItVqasmBIG1kV6DCjQU+2v1k1YJD34/gX9JX7s6Io
COlqcg==
--00000000000010ad350577575703--
