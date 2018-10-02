Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E8BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60782082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uusq6XEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60782082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeJCAGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:06:19 -0400
Received: from mail-it1-f172.google.com ([209.85.166.172]:39055 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCAGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:06:19 -0400
Received: by mail-it1-f172.google.com with SMTP id w200-v6so4772638itc.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHQEQ3TRdWo0jobQktmCheUOmU8tbgw5sdLwSkso9QM=;
        b=Uusq6XEGgTf7juG6ujeqip16Q6ZAjeFhlph2nF/bKcbRjsGCH9qX0PFjMqBmGRocvV
         jOZR4KCH4FH+EAgpgf9gK1/GaDDVNppbPfBuGmjUUN3XWJCodNxiaEsh+sjPdcrNOjNA
         FxXGzJK2nIZXrK1CUi5c83IclGsd8rnegMSgbiNfyI7/si7GZrBm8wvfL45Srk2JDWD2
         GULztKWKtrkPC1SqaARdOGPIIjbbmi3gn/aBHy/6VjcJaIeyBAgzyk1bRvxWxynjt6Ml
         DXr8SQb3RscX51hCUAPFlQy0GgceEqW9/MafrbVGe5mZCQLPjoWZhSAUq0BCPYIWIEot
         SB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHQEQ3TRdWo0jobQktmCheUOmU8tbgw5sdLwSkso9QM=;
        b=olYzDnCIlWnQkWGh/CKZt/xVnc3Wbk0D+ZmesFEmnlFQe5SmZRR105wyroV+BqKgKt
         Hz2IS/e8jAPD39nDkvktcpfsBcMl+nfEMHssEmprEUI2X9H7BzpIv+CR33pignSOB0jR
         oLrKbzIywMTQbZ6Xvzx1fOWddnGbN0rLe6NRtZsgW/b0NPhleIDhwQshex6Cu9hT4Nc8
         p4HrZxI+WrKXZ7TZvhRoRMgTgMqf9dqDLU6ecAVR+t/ovKebMRQYgphqKgp1yGSk62mL
         5ab2KZuSu+sTGeM72W1Z0mTzM8J2wQchzcMiV3u+f5fNvdQq+FS6iV4xvA44n4lZog7i
         P/iA==
X-Gm-Message-State: ABuFfogEpUumJiDU8KOA3p8JagNATUqdEUCn7tEIMALoHRwMp681T1IO
        Jo/LINkE83F6ZNvFGLPKQxytK8haZf2ZzJSO6j0Ixg==
X-Google-Smtp-Source: ACcGV609ZtSxfzmsrS+tr7gm1+amvB5NC9Np5iOoBnXGAXL8ZcwkT0xklYyCT5IAkXiTI/fM00vSkJvAODpMByXtvl0=
X-Received: by 2002:a24:2744:: with SMTP id g65-v6mr2837923ita.47.1538500911431;
 Tue, 02 Oct 2018 10:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180927194601.207765-1-wonderfly@google.com> <20181001152324.72a20bea@gandalf.local.home>
 <CAJmjG29Jwn_1E5zexcm8eXTG=cTWyEr1gjSfSAS2fueB_V0tfg@mail.gmail.com> <20181002084225.6z2b74qem3mywukx@pathway.suse.cz>
In-Reply-To: <20181002084225.6z2b74qem3mywukx@pathway.suse.cz>
From:   Daniel Wang <wonderfly@google.com>
Date:   Tue, 2 Oct 2018 10:21:39 -0700
Message-ID: <CAJmjG28m_MoMAPZetVuQTod6CQm75DSvj1=kvGMopF01WgKAcA@mail.gmail.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
To:     Petr Mladek <pmladek@suse.com>
Cc:     rostedt@goodmis.org, stable@vger.kernel.org,
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
        boundary="0000000000005540b805774228ab"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005540b805774228ab
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 2, 2018 at 1:42 AM Petr Mladek <pmladek@suse.com> wrote:

> Well, I still wonder why it helped and why you do not see it with 4.4.
> I have a feeling that the console owner switch helped only by chance.

So do I. I don't think Steven had the deadlock in mind when working on
that patch, but with that patch and that patch alone, the deadlock
disappeared.

> In fact, you might be affected by a race in
> printk_safe_flush_on_panic() that was fixed by the commit:
>
> 554755be08fba31c7 printk: drop in_nmi check from printk_safe_flush_on_panic()
>
> The above one commit might be enough. Well, there was one more

Thanks for the pointer. Let me test this out.

> NMI-related race that was fixed by:
>
> ba552399954dde1b printk: Split the code for storing a message into the log buffer
> a338f84dc196f44b printk: Create helper function to queue deferred console handling
> 03fc7f9c99c1e7ae printk/nmi: Prevent deadlock when accessing the main log buffer in NMI
>
> Best Regards,
> Petr


On Tue, Oct 2, 2018 at 1:17 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:

> Sorry, I'm missing something here. Steven's patch deals with lockups and
> I understand why you want to backport the patch set; but console output
> deadlock on panic() is another thing.

Understood. But it did fix the deadlock for me and without it I hit the deadlock
pretty consistently. Let me test the patch Petr pointed out and will update
here.

-- 
Best,
Daniel

--0000000000005540b805774228ab
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
TmnftMpllv264rvDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCVAuaeafEm7rhQ
8l2VMgn/Rt8cmkEIUNUtJGKJc5TwFjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0xODEwMDIxNzIxNTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEArx9advPmJ5Qk8YRNb/PoRJbPW3U9RQdc
voLPocC5Vc70jHON0lESlZn590I066GEEgxlziYwcGWZEEub/tDOakOfBfLXOtjLiWuHXFwG+fcH
Ph00tOtfe5ko+kAbIa7i23VaLMkhCb9hrF+Azfm2eiTXs5yJS1Pccdf9TBfYolxwst8S86tcyA9b
/yvSN9kmCZaIvod6NnY3/9wByh0C+i49S/RifyAc4qX5PbGjsCY6QiLpjLqZIIePX0E89rLzHphD
3VJgizm0r4LOWR1AucN7QIfeHtmNOtLei1eV5QVTEa/t626+tIGipzjpILO9JCcuLypyo1+UQmqv
2DZbOg==
--0000000000005540b805774228ab--
