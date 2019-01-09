Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B445C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E172064C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547058899;
	bh=dlXnZa3nDJPSZdyMh4hNprdBHQyDydUkpi2tjV8FijI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OPMynUS1ms3yRBnJ9sEEOJR15f0ZIzqIckGg1vUtA8z9v8uh6EUGg47jsCoCl2pOn
	 7ooLa24bIiP3iCgYKbYFGancRfZKcddqOg9+S02jU05Vix041ptcP7uWk7TYsM6kEN
	 fvadt3SRqUNw9JIR10F1l7LbSmmWKsCOSfz097fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfAISe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:34:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfAISe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:34:56 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C543B21738
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547058896;
        bh=dlXnZa3nDJPSZdyMh4hNprdBHQyDydUkpi2tjV8FijI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sPZb257kSJKe3jMqzACczTBQMlWGX3avvw+lrtZDNFB8aaQT1G4MXlWRVchR5uN3j
         8HSPbs8OBPhhiySXg07eKiMNJ7atPPuNedh+M2FCh6UvMOKP0EJjfYDFo6bdVM7ngE
         tAlnx+b7gpN4ZXfwINMApOaK72/v3bR1QVAZ4tZo=
Received: by mail-wm1-f44.google.com with SMTP id d15so8743867wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:34:55 -0800 (PST)
X-Gm-Message-State: AJcUukceBquFu0jgUDznbs5w3mbSqiv2Q6jzSO3JVqmIJgPKm4KrCZ4G
        jTp3UomtvG/t4IDH5Kq2r586ZpOE/5SXed0tBXdT5A==
X-Google-Smtp-Source: ALg8bN63fuEapV+nvBlH+8aNVcij0+f48aZTMp4SvlnMQzT95K4Sa/ffbN29uvjg/uYK3xfhQW2u0CodUELIBjs7sJI=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr6597039wme.108.1547058894231;
 Wed, 09 Jan 2019 10:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20190103143227.9138-1-jlee@suse.com> <4499700.LRS4F2YjjC@tauon.chronox.de>
 <20190108050358.llsox32hggn2jioe@gondor.apana.org.au> <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net> <1546994671.6077.10.camel@HansenPartnership.com>
 <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com> <1547016579.2789.17.camel@HansenPartnership.com>
In-Reply-To: <1547016579.2789.17.camel@HansenPartnership.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 9 Jan 2019 10:34:42 -0800
X-Gmail-Original-Message-ID: <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
Message-ID: <CALCETrWoSAf4hHCXvqVZhQ5YAMBaZzaBCfnb6sC8JPrSs6FRog@mail.gmail.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Jan 8, 2019, at 10:49 PM, James Bottomley <James.Bottomley@hansenpart=
nership.com> wrote:
>>
>> On Tue, 2019-01-08 at 17:43 -0800, Andy Lutomirski wrote:
>> [Adding Jarkko because this stuff relates to the TPM.]
>
>> Anyway, if we're talking about the TPM, it seems like the entire
>> "trusted key" mechanism in the kernel is missing the point.  If I
>> want to encrypt something like a hibernation image on a machine with
>> a TPM, it makes essentially no sense to me that we would get a key
>> with a known raw value that is merely TPM-backed (i.e. the "trusted
>> key") and use that to decrypt the image.  The right way to do it is
>> to the use the TPM as it was intended to be used: generate a single-
>> use key that protects the hibernation image and seal *that* directly
>> on the TPM, such that it can only be unsealed with appropriate PCR
>> values.  Heck, we could even use one of the fancy NV counters such
>> that we *can't* decrypt the image later on.  And using HMAC or any AE
>> construction the normal way is also wrong -- we should *hash* the
>> image and sign the hash directly on the TPM so that the restore code
>> can validate the PCR values that were in place when the hibernation
>> image was created.  [0]
>
> Well, theoretically, trusted keys can be used for PCR sealed bundles,
> at least in 1.2 ... I'm not sure the 2.0 one actually works because you
> have to construct the policy session outside the kernel.

I suppose I should go read the 2.0 spec. I=E2=80=99ve read the 1.2 spec, bu=
t I
always assumed that 2.0 was essentially a superset of 1.2
functionality.

>>  Presumably we should at least try to replay the PCR operations that
>> have occurred so that we can massage the PCRs into the same state
>> post-hibernation.  Also, do we have any way for the kernel to sign
>> something with the TPM along with an attestation that the signature
>> was requested *by the kernel*?  Something like a sub-hierarchy of
>> keys that the kernel explicitly prevents userspace from accessing?)
>
> We're just growing that now with the TPM asymmetric operations.
> Attesting that the kernel requested the signature is harder.  The TPM
> can attest to log entries (as it does for the UEFI log and IMA) and it
> can certify keys, but that only proves they're TPM resident not who the
> requestor was.  Effectively the latter is an assertion about who knows
> the key authority, which is hard to prove.

Can the kernel filter TPM 2.0 operations?  If so, then a signature
that the kernel would have prevented user code from generating is de
facto an attestation that the kernel generated it (or that the kernel
was compromised, which is sort of equivalent).

>
>> [0] If you take some data, run it through an authenticated encryption
>> algorithm, and sign (key, nonce, tag), I think you're operating
>> outside of the accepted security definitions if you expect this to
>> guarantee that the data wasn't tampered with.  I'm reasonably
>> confident that there are quite a few excellent AE algorithms that
>> completely fail if used this like this.  In fact, pretty much all of
>> the modern fast ones probably fail.  AE is for when the key is
>> *secret*.
>
> Well, I think here, if we were actually trying to solve the problem of
> proving the hibernated image were the same one we would need to prove
> some log of the kernel operation came to a particular value *after* the
> hibernated image were restored ... it's not really possible to
> condition key release which must occur before the restore on that
> outcome, so it strikes me we need more than a simple release bound to
> PCR values.

I=E2=80=99m not sure I follow. Here are the two properties I=E2=80=99d like=
 to see:

1. If you have an encrypted hibernation image, the only thing you
should be able to do with it is to restore it. So only an actual Linux
kernel in hibernation restore mode ought to be able to restore it.  We
get this if the image can only be read with appropriate PCRs and then
only by the kernel.  This way, you can=E2=80=99t just read out secrets from
the image if you steal a laptop =E2=80=94 you have to actually boot the thi=
ng.

2. You shouldn=E2=80=99t be able to create an intentionally corrupt image t=
hat
pwns you when you restore it unless you have already pwned the kernel.

Maybe the =E2=80=9Ckernel=E2=80=9D bit in #1 can be relaxed to =E2=80=9Croo=
t=E2=80=9D without totally
defeating the purpose, but if some random non-root process that
happens to have access to /dev/tpm* can make a valid-looking TPM
image, then I think we fail.  Limiting it to the kernel is only
dubiously better than limiting it to root until we implement lockdown,
in which case it's important.

#2 only really matters with lockdown.

I suppose that a good summary of my opinion is that there is no point
to kernel support for encrypted hibernation images until lockdown is
upstream.

--Andy
