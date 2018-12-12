Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15319C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61FF20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DrOgO8hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61FF20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeLLAxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:53:36 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35381 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLAxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:53:36 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so7201400itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/RsfP7vXkPcHE8sOFoMjSieEQuAbOaM86O/XnPxfAs=;
        b=DrOgO8hnL4yMpbkOBwfVJ6FGhYYDAjzBl9vaqjSQw26zMr5czxk7bvSmwU4V+OEqCo
         BDjrSfJxsmftp7Da+7N17MdVgNfmNCAzJwx0ie3aZq8PkgBZTwwqxj2mhumBboSbbr1q
         Nz2ymuJ38WPkXXOCmPPm3fVgKy8ed/ySUTz0y+gvBoXX0mZXLHeDFV9vkj1Ekv+4B2i/
         0r5VLp02z9dZwcjtqmaj8JgbT9Ld+KxhIkQ1Q0eJs/jz/0bGwFwOCmA5R2TIQmpU8r2l
         Iw12ZPEqXcyxCzWmY/lk1Xk/Hy4KA/9wn6ba2jnTngCd8aLJhLi+47lHip4jcopAkYyN
         oy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/RsfP7vXkPcHE8sOFoMjSieEQuAbOaM86O/XnPxfAs=;
        b=aji1GhVe1C4nmxE2e1msgu1LotQ2Z47ec3G9pbyr1npU9sUvdrELYByT2TA/TEErjG
         /MBVDSQxkyQaRAC/YgN83mxvmkwzw0VkHXCdB0YBtWJie8kW3wWliLUF6zIFutz3RTMm
         VjuJSR7PEUOnYAUKBbR2jQ7+q64DsoeF+QkR3cie3XH1JJXIQliel5dBmy9U8d9SFUMR
         s7Te4A2GsUVUDQtsA7YgDF36KZSiqoUYRB0ijICjAGW98KyliQ5agCV+yIhwsocJKE7P
         eDP7z5R4V1d1a87Nvd+g8r9jL4uo73b11H84H91gUcMkmdZnnmatdYD1ptHC3LmzWgvF
         Iu9Q==
X-Gm-Message-State: AA+aEWbNw2wQpdzJBLIHEm5k1sgyoRLmHu+Nh0aEDEE0uQfXjZ8xV+qY
        i9xoZ82+AWjF7N/rCubR0SYWCbIiYcRGH5YhvH+3Xw==
X-Google-Smtp-Source: AFSGD/WVW1yF/DLEaKVtcZREFjRX9sCfW6sm170ynU/Wqk3lGPXKDKTfaw4YZMulOwnie18ca2mBmpH2fptYqMJNfxQ=
X-Received: by 2002:a24:fd09:: with SMTP id m9mr4289190ith.81.1544576014522;
 Tue, 11 Dec 2018 16:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20181016050428.17966-2-sergey.senozhatsky@gmail.com>
 <20181025101036.6823-1-sergey.senozhatsky@gmail.com> <20181031122736.epbxu424l3xagge5@pathway.suse.cz>
 <20181101014821.GB502@jagdpanzerIV> <20181101080808.n73lrlnjd65nk4qf@pathway.suse.cz>
 <20181122131202.nkcurdt5k6jrhowa@pathway.suse.cz>
In-Reply-To: <20181122131202.nkcurdt5k6jrhowa@pathway.suse.cz>
From:   Daniel Wang <wonderfly@google.com>
Date:   Tue, 11 Dec 2018 16:53:22 -0800
Message-ID: <CAJmjG2-_8T6uJP54-+gUG7Aq7kNqkAKAEXbzzV9JVKyZFRh4GQ@mail.gmail.com>
Subject: Re: [PATCHv3] panic: avoid deadlocks in re-entrant console drivers
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b19631057cc8a048"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b19631057cc8a048
Content-Type: text/plain; charset="UTF-8"

Is it okay to tag this commit with `Cc: stable@vger.kernel.org` so
that it'll get applied to the stable trees once merged into Linux's
tree, if it's not too late? Otherwise I'll follow up on the stable
merges separately. Thanks for making the changes anyway.

On Thu, Nov 22, 2018 at 5:12 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Thu 2018-11-01 09:08:08, Petr Mladek wrote:
> > On Thu 2018-11-01 10:48:21, Sergey Senozhatsky wrote:
> > > On (10/31/18 13:27), Petr Mladek wrote:
> > > > >
> > > > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > >
> > > > The patch makes sense to me. The locks should stay busted also for
> > > > console_flush_on_panic().
> > > >
> > > > With the added #include <linux/vt_kern.h>:
> > > >
> > > > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > >
> > > Thanks!
> > >
> > > Since there are no objections - how shall we route it? Via printk tree?
> >
> > Good question. OK, I am going to put it into printk.git unless I hear
> > complains withing next couple of days.
>
> I have pushed this into printk.git, branch for-4.21.
>
> Best Regards,
> Petr



-- 
Best,
Daniel

--000000000000b19631057cc8a048
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
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
QAYIKwYBBQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWlt
ZWNhMS5jcnQwHQYDVR0OBBYEFHC1FT3LO6BpGtdIXSM5FWFPgFO+MB8GA1UdIwQYMBaAFMs4ErDH
mcB4koyzIZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0
dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAw
HQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQAp7ulGi+yb
H6Go2/IGeuxY5v6bGG9OgxOivBTos3k5ZBoWJt7BxDTYOLkA5gNLvh2tqsJVUJI5hQXwB4FFK0bI
/YuPUDxQxj9F2DBF6Mrgnclj5XLK3y9N5khy5/Ullth3jbDQ1dmyHQISh4olPbqtnHnWiUb6Mhf6
I3UgrUAhzwFXOlZSk57FgvAZ9472grnkSI8aW1mZp1gf5BNYEVb6y/e1hxlNeZbtIa0vvWDm+tK1
ENfcc+LgRCL4gqiu3v3MEyXXeq/eH/iibrGhissORpiy+nMuWzsTGYOkRRn9RtyEmJAh48WUKCt3
SR4lOce76r8Fd1Dg0XA0lCCwrFRzMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIM
IxVzVdM/KCmBJokVMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDHLD5WDh2PnVq2
c+Mv9TXJtLkHGXkUfBbFsTPuNcXqXDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xODEyMTIwMDUzMzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEKoq5IGhph/fd/Y+SlDttaK0WWXgLngX
xIhFX4hN/txdO/RrawPrpK9xPBARx/eHK/AhA/Kk14UGeUQylxnfQUQkZgiMf3TMujvF+WRGA5Fi
CQ7g6/90iO6WMIU4asPYknrvg/lbn4SD6mcjGlPSym9L36sf9DDrF6qdpwwEm21npgKem6jdzMI+
vp4vHbgTKX7EJxy1If1opDAPY8CoXSWbBYZOdKVI8ko0X3ocBEEEzZrXx+AhHWuMJzOSHgoiVpAA
O2cPvy3QE8LDMW0PM1dAwFk/7Kw9srTCklClYDAXtnwM2cR5mpqZMV4Mqpq1075zBCdOc1Dmio/B
8PEr6Q==
--000000000000b19631057cc8a048--
