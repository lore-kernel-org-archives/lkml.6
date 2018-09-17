Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41030ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0E206B2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8lv332J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B0E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeIRCWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:22:33 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42659 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRCWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:22:33 -0400
Received: by mail-yw1-f68.google.com with SMTP id n207-v6so6046762ywn.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7pF/WPCLtolEdUsaHEbLPi8B2rlff7aUicWKDqTdTU=;
        b=F8lv332JS1/fIRLfOgrjZTrJKQHAWe+w7gMQNslnZzwsKKh61fnQwyIXzkSqZiqcMz
         Y9j6sDVuiyhSRTAZetWnLpPsKy8iK776w1rC20SFM3s8Pbyx+c0lCJPxTEWMJ40xm7AA
         Dg7kQyWzVnPaITSXSbOBHdhiyC/20K1OwKStiWoX+Kh3cj1uUS4Cdv10lv3QWgEC9YYC
         H5wCigUwwxTi32GeqlHeEwJbAVysrh8lWcwpqeyvhCoYiiC3ZNhkgoswgbbF6sv1UhbC
         MnztTFY6wm65ZZmH+kPY2KG+oZMJvI/3lmMBy5fWeCdY6zhn4exzV3Eoh/L27B93eB2G
         y8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7pF/WPCLtolEdUsaHEbLPi8B2rlff7aUicWKDqTdTU=;
        b=aRzpyv8ZhLLFwXZRcNGPuSXAhFGlUCepP3mZljn8Xjqi3ydEuS2TH8vN9DZEn8iWu0
         6BWub+1rx3H8lenxMawV4kofKe4ap2h4I62jtAxcmPAXSWqzN9f3e+fAYPbsJg2md9Or
         tIFpLh2GWkAZdRxgJ2iXwk45YhNWMLu/C8BvqUcnuuLDBKVFgR+jUYNUFwPqIR5TW6iy
         Uu1/+cRNohXPYcS/M176+lcU7ihREhvkAckdr5DmW4qwp3J7fNr+pRjyabmf7pB66XXZ
         rUu3Wo6xj1xrNPfcyt5E/LFp+hLlfKHBute1t6IgPCpQXi2tnPJxDXW7Gv8FtKc+C2Pw
         8yrw==
X-Gm-Message-State: APzg51B+mrEGnkuUdLS2fptAeNf8oFZrTBiVr2cSh2bu0b4zODXEJJdo
        e526xL6mrPJQM7FxwXd5DeLbCL/WBCFl5i5xpnSXWg==
X-Google-Smtp-Source: ANB0VdYV5CHxZrVQm94EkfOQqBTe8G0fRyFr/R4IRe8Un1ExIoQeookYDViR7KGUi/SHxUVRPXnX+ord2rP6F+H07lg=
X-Received: by 2002:a81:5f04:: with SMTP id t4-v6mr270405ywb.98.1537217612206;
 Mon, 17 Sep 2018 13:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180907182131.144514-1-vnagarnaik@google.com> <20180907223129.71994-1-vnagarnaik@google.com>
In-Reply-To: <20180907223129.71994-1-vnagarnaik@google.com>
From:   Vaibhav Nagarnaik <vnagarnaik@google.com>
Date:   Mon, 17 Sep 2018 13:53:05 -0700
Message-ID: <CAL26m8+C3tPJLy38i4LajM1_9B+x_AOOvUTot-VUkpHTZfFKmA@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Allow for rescheduling when removing pages
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Jason Behmer <jbehmer@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000be9cc80576175d1f"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000be9cc80576175d1f
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

Does the patch look good? Can this be picked up in the next rc?

Vaibhav

On Fri, Sep 7, 2018 at 3:31 PM Vaibhav Nagarnaik <vnagarnaik@google.com> wrote:
>
> When reducing ring buffer size, pages are removed by scheduling a work
> item on each CPU for the corresponding CPU ring buffer. After the pages
> are removed from ring buffer linked list, the pages are free()d in a
> tight loop. The loop does not give up CPU until all pages are removed.
> In a worst case behavior, when lot of pages are to be freed, it can
> cause system stall.
>
> After the pages are removed from the list, the free() can happen while
> the work is rescheduled. Call cond_resched() in the loop to prevent the
> system hangup.
>
> Reported-by: Jason Behmer <jbehmer@google.com>
> Signed-off-by: Vaibhav Nagarnaik <vnagarnaik@google.com>
> ---
>  kernel/trace/ring_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1d92d4a982fd..65bd4616220d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1546,6 +1546,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
>         tmp_iter_page = first_page;
>
>         do {
> +               cond_resched();
> +
>                 to_remove_page = tmp_iter_page;
>                 rb_inc_page(cpu_buffer, &tmp_iter_page);
>
> --
> 2.19.0.rc2.392.g5ba43deb5a-goog
>

--000000000000be9cc80576175d1f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS7wYJKoZIhvcNAQcCoIIS4DCCEtwCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBVMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
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
7gUJTb0o2HLO02JQZR7rkpeDMdmztcpHWD9fMIIEbDCCA1SgAwIBAgIMHl16kDsCi9Zi55tEMA0G
CSqGSIb3DQEBCwUAMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSIw
IAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxMB4XDTE4MDcxNTA2NDcxNloXDTE5MDEx
MTA2NDcxNlowJjEkMCIGCSqGSIb3DQEJAQwVdm5hZ2FybmFpa0Bnb29nbGUuY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvIbZti3F+ZBzCfvFTEKbau2Tey2/vP1vw9Yv/12pYta5
c6ANbvAdCesQgF12FefrukOzrdq1WZtOR09P2IaoI9/uf6Zbwkv94wfiAGoDjeCc+3t/GmiWTo8j
UAnuURR2HaLUZ69MU2t4y1VfzGwk7dHIC8t9JdTg+JNbwHXlhVvPA8CpaRhTcsHXHITDjjEafCla
GLKIU+doA+CAWv/5VwzfjKw87GgxiBxFGmJkTanfZ1+Tv9cJ/g33/YK6hCEu2ZY+ZnCVYy+m3S/z
JrihBuqJoM27sVVva44/sF9x5PkT+eViDyXRChx8ZKRr/AMOFLilWVIayjBYKY1R/ceOswIDAQAB
o4IBcjCCAW4wIAYDVR0RBBkwF4EVdm5hZ2FybmFpa0Bnb29nbGUuY29tMFAGCCsGAQUFBwEBBEQw
QjBABggrBgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNt
aW1lY2ExLmNydDAdBgNVHQ4EFgQUH+edOUi4Dg/4BcEaQBhbxUlT6H0wHwYDVR0jBBgwFoAUyzgS
sMeZwHiSjLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYq
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIF
oDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAHB9OW0w
X+D4D4ogfYFLq3P7W8JPCIZjkKIlA92Leo7WRm+s0dRYcHcXohr0NdEODLvR1QFO0+gB9IjecZ2t
8SfMEX3qMLJtfOkymSy9dRGQ0M3PiHix30Ux29GUOXDB8ZP1mJ3jzKUnqns/0jSY55YQ50qqhCky
gexjBpT4khyoLIGPnHEognAHQgZyAkOTCFxFyhJmIlYRjfM5p6UJUhoZWVmQmkhW4N59WDvbDGBb
0xoGU5Hrsm9UOHPMrSGNTbm+l+GZNWly3ZRlfSsEihAUzo3SmDBKyXMt+0t0QgKKbwpcPzYMiqjL
WvBlcrqdOIcj9luM9egtNIiDRRJfuKExggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAx
AgweXXqQOwKL1mLnm0QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJVhC12KEXmz
qAIAS/I1ZTLpDDv59KdglY0V4OUcJWEoMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTE4MDkxNzIwNTMzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCxYNjwRNEhgnreBhprCH1XIhJtFY61
sEkQ3Yj79F+/nCJ6duQfUtYEX0FG/KnTD58DCZyxCwlHT8v1VNuBmWk0fDvX41IQAzn/cg8PhP0V
Ltdlks6hcxmF46RIZuRyKyXqYAOcy8oSGjUQcAdGRINkBgqruYGESwmmIeCKTVqd7tI/D00iLZ3m
/K8UssTvMGylry4mtvy2ePIBTDzpcDIqRSriYm/G+YSLQOEYmJbC1lUNbBxC0efTJ0L2cXHLptEk
7zH9kfafhqceff/BtK5kOuwTM4O8fNkNCWaFLf4yvCQRM5wV5CWYFyR09W4iLsKa8Lf6sTl5Mosk
eCTA97uf
--000000000000be9cc80576175d1f--
