Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A1EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4532146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fl7IzrvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4532146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeLAAz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:55:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeLAAz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:55:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so5355891wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfMLlyzJLzMRcsdjS04PcCKKbT6pMdj68ZoOqBxDJhE=;
        b=fl7IzrvXeP8UPOMWJ+IJ2UWeLq3Xe9OSFI60ffPIU8otSlGb4m6GiAtSgmZQkUEiK7
         AQTYuO2BzChZb74TKmwLLrDMR5bw2KgAIJjXVFmnkogFPbFsg1EGtQeN6pTkVo5kXaFp
         GIt6ogfoMZ7zCh1928Wnqw0nH1RGHQbcNFG2W/lHq6tGwS5l/rT3WSjqmS3D4jcWvs86
         snYNBGWoA0alxnVIjDJBrYNd/+QpulY98ZCJ8BU3NBP9zzf3w0FXAd9+AdMNpt9hylsq
         JDd4HhpTXqDQT/quihToZ2+lJj8jtJwEYXu7gvxibG7CGnfJpq/BHRvPxpsA8qrt/5fH
         UOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfMLlyzJLzMRcsdjS04PcCKKbT6pMdj68ZoOqBxDJhE=;
        b=fXp2g48RG0m7RV/4CG1EQKvUQ6GHB6PJDT9FV1AI3aXOHB2L8uRwvfQZsHouyh3JLE
         4DDcCZipxhMXS0v0KoJ61uA2niTaYk3WWDaQTBbI3GQOpSibKN/JNCA4aECOYI7UGgFg
         4ZnYT1GwQItfE0ccQJ2v/I6riR7BgpatKYcw6237drDOD08eO91Hm0bFhYx61vJ0UwR4
         bpHWXmb9/ZakF0alz/S8T/p327/C4ZNIZBNBS0FUCW1IFDnzp/bppAjN3IaJR+2Vt0Te
         xBSFty71hNH7bJBwcWURrPj+blUUFMjEaw9lTXt2GuP38X2vIbQEjFfz/pChD6FlzW1u
         dI3A==
X-Gm-Message-State: AA+aEWa1v989WWAiKTuU99usDrnro0jtkwOzSN6wD9f048K9OFbEpYjd
        CpLiqP81uHTr8tRa6fF9uguPWEtl+afE10XfjNmmVQ==
X-Google-Smtp-Source: AFSGD/Wtz2m2aRk3wZhy2PcD6CO9Goj0sN0vv/xt4CwvPCxPAvx+hq3f2+iuGVVtVEpyessihqEJcGoqCRPjzppuUCM=
X-Received: by 2002:a5d:6302:: with SMTP id i2mr4983267wru.14.1543585594007;
 Fri, 30 Nov 2018 05:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20181126172607.125782-1-rburny@google.com> <20181127011627.GI4922@garbanzo.do-not-panic.com>
 <87k1kzjdff.fsf@xmission.com> <20181130010928.GM4922@garbanzo.do-not-panic.com>
In-Reply-To: <20181130010928.GM4922@garbanzo.do-not-panic.com>
From:   Radoslaw Burny <rburny@google.com>
Date:   Fri, 30 Nov 2018 14:46:07 +0100
Message-ID: <CAFkxGoMjCQiQ93UyC9sjreR4dSS9hzxyzT44wmEUMPsMgTg4EA@mail.gmail.com>
Subject: Re: [PATCH] fs: Make /proc/sys inodes be owned by global root.
To:     mcgrof@kernel.org
Cc:     ebiederm@xmission.com, Seth Forshee <seth.forshee@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Sperbeck <jsperbeck@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000b8d87057be207f6"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000b8d87057be207f6
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 30, 2018 at 2:09 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Nov 26, 2018 at 11:29:40PM -0600, Eric W. Biederman wrote:
> > Luis Chamberlain <mcgrof@kernel.org> writes:
> > > Thanks for the description of how to run into the issue described but
> > > is there also a practical use case today where this is happening? I ask
> > > as it would be good to know the severity of the issue in the real world
> > > today.
> >
> > People trying to run containers without a root user in the container.
> > It atypical but something doable.
>
> My question was if there are generic tools / propreitary tools which are
> doing this widely *today*. Or is this just a custom setup some folks
> use?

We will soon start using this setup at Google to harden our usage of CRIU.
There are some more details in my LPC presentation:
https://linuxplumbersconf.org/event/2/contributions/210/

Although I don't know of specific tools using this setup, there was a
kernel patch in 2017 to support such use case:
7c6d78148fa0 - prctl: Allow local CAP_SYS_ADMIN changing exe_file
So, perhaps Virtuozzo people use a similar setup too?

> > We spoke about this at LPC.  And this is the correct behavioral change.
> >
> > The problem is there is a default value for i_uid and i_gid that is
> > correct in the general case.  That default value is not corect for
> > sysctl, because proc is weird.  As the sysctl permission check in
> > test_perm are all against GLOBAL_ROOT_UID and GLOBAL_ROOT_GID we did not
> > notice that i_uid and i_gid were being set wrong.
> >
> > So all this patch does is fix the default values i_uid and i_gid.
> >
> > The commit comment seems worth cleaning up.  But for the
> > content of the code.
>
> The logic seems sensible then, but are we implicating what a container
> does with its sysctl values onto the entire system? If so, sure, it
> seems you want this for networking purposes as there are a series of
> sysctl values a container may want to muck with, but are we sure we
> want the same for *all* sysctl entries?

The point is that these sysctls do not affect the whole system, just
an appropriate namespace.
For example, IPC-related files (e.g. shmmax) will always affect
writing process's UTS namespace, regardless of /proc mountpoint that
is used to access them:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ipc/ipc_sysctl.c?h=v4.20-rc4#n24

I presume the net-related sysctls that Eric was referring to have a
similar behavior.


>
>   Luis

--0000000000000b8d87057be207f6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFKYr3G9421V7QFZPsgvIMutuOc5jMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQCGnY0u3gtxJAVsMXGL
pl5DUgxReLZ+ttsXFfDrKoEn01tysaaBmnGOgwfdbo0wXd0MeWIOIj3uDNoZDIaDhdb4Vbacowf4
5Rm/vxmMeZWS89LEVkNnjiMUG2U+yBeEger3Qx3agNBHacA2B4MZZ8DMV2jwkD/NyTPHJ/v98CWX
oPs147M4iqPkYISfwzpFHm2teuUJN8P12i5iqtbh5GBfePoK5htK1e/C/wSeyMMiMov8MPwwgBjf
f35hRrayerXAqEEbQrL9WaBbXFsE8BEZRGf4a23gwfLBqglz2GOrDIo9B/nozryQj75fvMPu3lCx
mSB6P87yU5TNNsNJmuV9MYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMNv7l7pP5
ClmEH/FAMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCqOeYMHBNA47hliLHcFEBG
bila9vaxx/BHT2RfeXydpzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xODExMzAxMzQ2MzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEADazG3DTzrePiwSH5f2YW/ZWSvRCaXNx8YtPtZ9kP
QC3Oqs38PBZSu8696QSd5/8sM2hMlHe6tHsHOxrsoNtOzkuuOBxqzxjnWOSttYJ+Qdmt+QDRZtyW
/zDElzXYgM0Vo/C/tnnrMLPBv8RGnAyuPV8/keb9U9E8mBzTXL2S+L2Iu5mG0hlRKW/WRAsnZXNq
+TqCfCNyoRqeIutpWxrOYbjtfTMlZ9Zu9XlK6/HYnqtlHNuWFi3ChEBhovk+qr8J7B6ayKItBcS5
D6IK6m4EsDFiGnDkz+tSaBb4JNLTOgrWsaC6wTz7cP0Xcm4fLF/LSX0b7E+DiuUe5EpFql+sdQ==
--0000000000000b8d87057be207f6--
