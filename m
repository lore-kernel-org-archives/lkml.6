Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8BCECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1612146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVsyYvZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1612146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeIRCc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:32:29 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38527 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRCc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:32:29 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so2760955ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GldVd3N/+/4SFZPRX7RzxQlwwJfqjD4/hT/jkJHWpB8=;
        b=AVsyYvZFM2wtr26Q4dM52hilr2r+frHoPuMNkn41lelFhYlH+ANSeDrb6/eRkbB6jb
         GRyyoNCPrm5y6Mk2XTYDHFKHDa3t4DCYyxEEz9T86WmIOrewqIdLIV5xfsf1Gv7qlXN0
         letTOFRrawLII4yGruZx3orAOxnAqO/MeGO3RFrHnDo725KdDfCuI+dqg6l9p1fHD+b7
         M0Gd7ATsDdhkalsQTc7uGXsmnvZY0saw5ymniFfhFAVaSy/PJDc9RuoWS15gYpUEoIFX
         r/LtlxCuoyhZeKgrXAN/wWdKuGA945y+7XPRNZNDm1LWNCB7DJ+5lGVfvaP4RxNeSAS+
         Nv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GldVd3N/+/4SFZPRX7RzxQlwwJfqjD4/hT/jkJHWpB8=;
        b=DW9RZHhle+hNehqO+zJdC94sUu+MIIeol2N4VS3eAo92xUELW0oqMijZljJ4/UjeI/
         V1swtARdHWg4yf6/asCmm91X7LR/WLk+QGeuwka49l9IFZZVq9X41KYzhBcYlwDgMsXK
         hq8YDB6OclJ7sy/93SzIPRaYfqNTaUpdD8Qjt5mWDNgIx9lnXZFpIlInRrx/wURJFW5/
         mOHugLmuxSDbhlHbwVmwF1JekV39hG2ViWFp4mmJ3CUwYf33UcA+3kpPP5eX3iCbtdga
         31oYLtdI+6gLq7CODstyZlRtrTP7gBxXX7R9dKyfEamUP4ZTtPM1P/OTVnIDe/jRHNAz
         GUog==
X-Gm-Message-State: APzg51AFPKiwrnN0meiFwBu4iyLLK8HpLoptEzKHhWk10tsIxdpbJw8N
        /1AyuYDJKAGuUczbsOORJFGsIzmqTEA4v71TDf++Eg==
X-Google-Smtp-Source: ANB0VdbPv4Wch37Uq+Bo10iBIvWV+haIssoNGUWnicjUU9eIyPYj2cS1we3at8kZaWFuLkmkVSVOcODmfvfPtMDJKBA=
X-Received: by 2002:a5b:1cd:: with SMTP id f13-v6mr11203974ybp.363.1537218206147;
 Mon, 17 Sep 2018 14:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180907182131.144514-1-vnagarnaik@google.com>
 <20180907223129.71994-1-vnagarnaik@google.com> <CAL26m8+C3tPJLy38i4LajM1_9B+x_AOOvUTot-VUkpHTZfFKmA@mail.gmail.com>
 <20180917170055.1f1d161f@gandalf.local.home>
In-Reply-To: <20180917170055.1f1d161f@gandalf.local.home>
From:   Vaibhav Nagarnaik <vnagarnaik@google.com>
Date:   Mon, 17 Sep 2018 14:02:59 -0700
Message-ID: <CAL26m8L7f5iw_eNqbB2OVJX4vYebHcjiBJCQxyd_L4WjNFMb7A@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: Allow for rescheduling when removing pages
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Jason Behmer <jbehmer@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000253d4605761781eb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000253d4605761781eb
Content-Type: text/plain; charset="UTF-8"

On Mon, Sep 17, 2018 at 2:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 17 Sep 2018 13:53:05 -0700
> Vaibhav Nagarnaik <vnagarnaik@google.com> wrote:
>
> > Hi Steven,
> >
> > Does the patch look good? Can this be picked up in the next rc?
> >
>
> Yes it's fine. I can pick it up. Does it need to be marked for stable?

Thanks.

It'd be great to be marked for stable, since older kernels are also
affected. But I can't judge if it crosses the threshold as a bug fix.

Vaibhav

> Thanks!
>
> -- Steve

--000000000000253d4605761781eb
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
AgweXXqQOwKL1mLnm0QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKeO2J2B8iQe
sBWcbcEx1kBwqGNwPcTjjh6f9GaycbFKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTE4MDkxNzIxMDMyNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBYfTyAqBgr/qyVQuqiHhv7+5Uwv/2q
XY+oJaU+zUMAOr0t/8tbSE23d5kolu5CxrnOPuxjY5fxmCA/h+k35aZ3ImAAt7py2bGQcNYIjM+E
40IpPFnXPicJ9/f9vHkca+njWy076YwUe/qqXPTaIs98wKQaGDW69kjmzDHkotFEO5400ZgTJR6i
OB4B6xZKpq/RskuKw2jP09kNDyj8giz7fHcJMzI4/XPtBNz38+b71xdyjmefXUpzixeUi/XvYvgU
of5TsOu7v3X2tBQwgvpo32zlu1AEtwkOGPS+4XESEYIxGsN4i+SLMQpJGcBoJqUoc5ABBL9Nz7+i
zMObzTex
--000000000000253d4605761781eb--
