Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D4BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4764120652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ETkEmbMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4764120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIHALr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:11:47 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33781 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIHALr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:11:47 -0400
Received: by mail-ua1-f67.google.com with SMTP id i4-v6so12804118uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOw/Rzmznnp7ezEw0iWH1J2IYoykMyAS0cnhK1NJ/Rg=;
        b=ETkEmbMfayjOhcTUVwdXLfDTbaf6dgVLzpsQID5DcLxfiHRDifyJrdqeTTmx/Kz6mT
         oErImMNtAMz4wXZuBz72qm+Yx6vX2dRo01waFSUURg1hxWXJ6bqfbdblgNbIdXjbf5BB
         3xp7ciUYPXwyKnn8kt1YFfsUORN/OgTjfnDkfSpdgDA604rxs9MKVgRu1S7PXM0EQEB+
         pFat3cu+34pBvhT842ob+ay6OgCBYxKPrJzRSA/lHUKY9YMUk1EECy7omHWFx63rTzJt
         yhRzNNFjPgWxddRuBLTcZlPPuwHOPv+fhF6H9BUhcs095RVh1bJNNv/mY59AVCn/57du
         uxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOw/Rzmznnp7ezEw0iWH1J2IYoykMyAS0cnhK1NJ/Rg=;
        b=YuYEd5tyJtCHohWbeilJEL46hLlmAyGVWFAdNru4OseHW8KG4plX3SC/1ySv/Mr6Ms
         LqDMWWHYhJPbvsKfnAAn8bpRPgEyC+lPby0gd5Mp9MxPwJIP+tFGdlSxgq1LfjXVf8cx
         /LT6SmlfZa2d51RILpec5G88h7hJ9lZz4gIV0tZJrGU6ZWkuf+m5VO7HZu7GVfS/vHXQ
         mUkkaNyRQn2Z4B/Cwp9mvyQ1FL98VcEtCTnD/0iBY2WmKK1Ts9vfrTbPwplI5HYsbCQr
         pjmHlC028ie8O9jIDitnrNm1I6KXoCUpxDrbqrX+9HppPN2MfXvjzU1RwTFRH7EMgsAC
         UFQw==
X-Gm-Message-State: APzg51BAJw35ewE4qzHCqM0FMPZm+pboRH2gVq8xZr1Qf7yn+eZ3B3bd
        trr5095Dx45S3ZcV1+5NFXNHOYtclrLLdq/rS8HY+dfE
X-Google-Smtp-Source: ANB0VdZrf33dTC63lEL6m9HoqqCgNKdtjHue6Kvu/u1zVSffPfI2bH5QIGHsNsZQWGNWAiOdAVGrtWZDBghiv3oAfgA=
X-Received: by 2002:ab0:7253:: with SMTP id d19-v6mr3076797uap.99.1536348563249;
 Fri, 07 Sep 2018 12:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180907182131.144514-1-vnagarnaik@google.com> <20180907143052.50ccfab6@gandalf.local.home>
In-Reply-To: <20180907143052.50ccfab6@gandalf.local.home>
From:   Vaibhav Nagarnaik <vnagarnaik@google.com>
Date:   Fri, 7 Sep 2018 12:28:57 -0700
Message-ID: <CAL26m8+0BC8Tbyaoh+VzGdE_ebr2_=hqV7eeH2m5=9v_v8=yOw@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Allow for rescheduling when removing pages
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Jason Behmer <jbehmer@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000066ad0705754d067e"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000066ad0705754d067e
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 7, 2018 at 11:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri,  7 Sep 2018 11:21:31 -0700
> Vaibhav Nagarnaik <vnagarnaik@google.com> wrote:
>
> > When reducing ring buffer size, pages are removed by scheduling a work
> > item on each CPU for the corresponding CPU ring buffer. After the pages
> > are removed from ring buffer linked list, the pages are free()d in a
> > tight loop. The loop does not give up CPU until all pages are removed.
> > In a worst case behavior, when lot of pages are to be freed, it can
> > cause system stall.
> >
> > After the pages are removed from the list, the free() can happen while
> > the work is rescheduled. Add a check for need_sched() within the loop
> > to prevent the system hangup.
> >
> > Reported-by: Jason Behmer <jbehmer@google.com>
> > Signed-off-by: Vaibhav Nagarnaik <vnagarnaik@google.com>
> > ---
> >  kernel/trace/ring_buffer.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 1d92d4a982fd..bc1789df7c53 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1546,6 +1546,9 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
> >       tmp_iter_page = first_page;
> >
> >       do {
> > +             if (need_resched())
> > +                     schedule();
> > +
>
> Hi, thanks for the patch, but the proper way to do this is to stick in:
>
>                 cond_resched();
>
> And that should solve it for you. Want to send in another patch?

Sounds good. Let me update the patch. Testing it first though.

Vaibhav

> -- Steve
>
> >               to_remove_page = tmp_iter_page;
> >               rb_inc_page(cpu_buffer, &tmp_iter_page);
> >
>

--00000000000066ad0705754d067e
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
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
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
AgweXXqQOwKL1mLnm0QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMBc6LHB3Doe
xaupE2R/dl6DDiqgT3pQhslXFW11yT6kMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTE4MDkwNzE5MjkyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBbEBNrr4Dq4B/DJXBE2kxao1/AaG6V
hQhVRrbrpZimEY6lNOfUKzn21Qsm3CCj1UYr17CJFi4hPc1ZqBBEzC5fHqc907j4bINF8qqvvHSh
cdNYv1UoQUpFZ9aoQ0YTeKeyPasddFdmixlIy496KnDIaNriMgrROnA79PshDzTzeCpfvnccKh5o
6PC+hU5ACvUR0mdzoKXdnWVEahofBka9yoJbb5/ObEtTeyu4mHSMcOFcM47wWKZ5uAE7tdmJNfmX
FGyIm6GLaTwhD87xkdHsZBlPu8GQWF9QMX9OdFYPhWey6ANGYXcZKuV79omAlUyOBpPHCS2m1U97
ZCzQC1un
--00000000000066ad0705754d067e--
