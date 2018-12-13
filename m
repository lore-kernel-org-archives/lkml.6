Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDC1C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F1720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gj6EOCMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F1720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeLMCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:40:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37998 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMCkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:40:02 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so1617289ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5bGKvlvkuY64J0iK6Ja4HOR/V42MJkGgtxmR3c5eU8=;
        b=gj6EOCMgIh/1pItaVcAnI+sUtCAXIV/H5cmwxZF9548B/tfXmGyHY/kaxFk94Bj4wR
         nGdsoNLzxxj2Syhg/v7pw/Il/XORzLMSSV5q8RlregJaLV4jeY4xmAu2zIqdmGi90cdA
         fZhaNzx/iQXPaMMYgusu4ohbsUnOmvTR2u2ZrE7I7IbsB+rHEjugdS14TMZQoYV9JyCR
         5pk63/DsNjWp/0bjLcmJNO27CRSjXP7sV7XN4Xyb6KFfSMAqqEZBX6izX348oQBp9xft
         DBUaH4KAD7VsEeJ31Sie6ZtTwBMcUGsqmxzNuLM+bXP7MDTcQcbsqe53EE0fNfGaPGwZ
         7SmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5bGKvlvkuY64J0iK6Ja4HOR/V42MJkGgtxmR3c5eU8=;
        b=HEfJ+SPjHa0WkwYEKk20vsgW9s3lwI0deNs3/5ixw5isFuUjZ1uNoN/VRQ5yLshDRA
         igrYxvW3nHU6ZVELf2egYg1h0AfJQffSoNfNs0k67OBOSO1ncdoZYlrtZR4LwXtCiL0t
         ln42fKxgnfiltY5lFCxR4TYZzY5LldK3Glv6MNA+P955tm3Mt7iiMW0WTiCLSxgMH+Kh
         n/tnJ1cdrvhmxxt0KF8NsFU/h5bdxT8URgWA/hXyUf5zlfXEmZwoBVUVOeJY/NypVOPO
         3F/VFXkIL6DhHy7jj8OAAVTK61FElVjDClsM2OQififOXVLpY2vuJvj23lZeOOR9ZmeN
         oRbA==
X-Gm-Message-State: AA+aEWbWjWvz2CK6CmyP6mg3cxEwbn8Bq71Tw4lPbtcW/QVDRhHSAVzu
        tsVIB41rS9fhRSBImcpsyWnjmLJDPS5Rk/ZjEvBEaQ==
X-Google-Smtp-Source: AFSGD/UzurEu0p0UIoclDPSPttVDP0LxGI64gloRu2ZUlXsQ8MFdrHLfDGo4M1pBqc1+ts3E0XRDNxP5Akaf23DR75M=
X-Received: by 2002:a24:97c3:: with SMTP id k186mr3552289ite.125.1544668801268;
 Wed, 12 Dec 2018 18:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20181212081034.GA32687@jagdpanzerIV> <20181212133603.yyu2zvw7g454zdqd@pathway.suse.cz>
 <20181212135939.GA10170@tigerII.localdomain> <20181212174333.GC2746@sasha-vm>
 <CAJmjG2_zey77QxMzq997ALkD56d0UtHmGjF4dhq=TbEc2gox5A@mail.gmail.com>
 <20181212214337.GD2746@sasha-vm> <CAJmjG2_C0YRtVmNh2sg4JqhJJ11LMmbRHqwADxyO9CGh9ixQbA@mail.gmail.com>
 <20181212215225.GE2746@sasha-vm> <CAJmjG28s9bz51k=5i8eoKH2crj8e7-qM_EYWMqtUKZ_nGREQOg@mail.gmail.com>
 <CAJmjG29PnAfkUsU4PuVaFvjW-okO=U-MbHZHg7Sj_bBJ6EO09w@mail.gmail.com> <20181213022703.GD4860@jagdpanzerIV>
In-Reply-To: <20181213022703.GD4860@jagdpanzerIV>
From:   Daniel Wang <wonderfly@google.com>
Date:   Wed, 12 Dec 2018 18:39:42 -0800
Message-ID: <CAJmjG2-eoKTHtChWK0fdWfy872h5N1c-NgxBKZra1+ujutF+Fw@mail.gmail.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003753c2057cde3b89"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003753c2057cde3b89
Content-Type: text/plain; charset="UTF-8"

> Additionally, for dbdda842fe96f to work as expected we really
need fd5f7cde1b85d4c. Otherwise printk() can schedule under
console_sem and console_owner, which will deactivate the "load
balance" logic.

It looks like fd5f7cde1b85d4c got into 4.14.82 that was released last month.

On Wed, Dec 12, 2018 at 6:27 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (12/12/18 16:40), Daniel Wang wrote:
> > In case this was buried in previous messages, the commit I'd like to
> > get backported to 4.14 is dbdda842fe96f: printk: Add console owner and
> > waiter logic to load balance console writes. But another followup
> > patch that fixes a bug in that patch is also required. That is
> > c14376de3a1b: printk: Wake klogd when passing console_lock owner.
>
> Additionally, for dbdda842fe96f to work as expected we really
> need fd5f7cde1b85d4c. Otherwise printk() can schedule under
> console_sem and console_owner, which will deactivate the "load
> balance" logic.
>
>         -ss



-- 
Best,
Daniel

--0000000000003753c2057cde3b89
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
IxVzVdM/KCmBJokVMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBftl1u53gmryV0
WLuWC4yDn7ZE2KcUQWGcw6S1NgZWZTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xODEyMTMwMjQwMDFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAKqSY1rQPIx8+WWMS8n/NCOglCrPSoQiM
ssk5/ihER0k9qppRi8O2bULf0iCD/1eLn6IKf+k2b6h+ne++QDLpVcsVKVdQ8pZIcwxKe5hsyIUp
6So9VAdxeaNMAHoz1DILSjB0Gkz39W0lXxXlYcjN4rQNTST3V5uoZlCBrhXOx7Fg1IfL5gfNKaBK
L35I9RrFcQtixVhhy8gWF8Q2byMgs/aRbwiXdoqyPe2W49CY2pr1TouEKdQxIcMiUVuAGiyV/D1v
ND4C1qco9MGtSe0t7Gdd2Hmt+o6DKTkPLfyXwRlU+j5U5qJb6CYJCv+TrPE4LkF+NJgWCE9Yjra3
1YKCig==
--0000000000003753c2057cde3b89--
