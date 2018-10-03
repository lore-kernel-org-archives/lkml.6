Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDB5C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8220835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0OPzy6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJCNm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:42:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33887 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeJCNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:42:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so4783412wrb.1;
        Tue, 02 Oct 2018 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZKHm8O7y9TI02rEKCCmFiWwt0kxX1dt30JyOq8XHDs8=;
        b=V0OPzy6vIS4qqxLE9tTf9jSgLz1iSQrn0lsVCArVu1P12vKnWGRFECI2tX+6fBT2Qf
         L0i0ykEnv5fGOI/egIgnenZC5V4aDuaigvt0kJQhG0Pys3LptGLfht0rQPMf0rAzOxnN
         v9pCKo0AYjwyQUADij8qaId3+SLfTuU/o3sdQApsztxAfgbBbAp9g1fGoMpd2JN+b+nM
         jFrOrqbsy4EzC4ns9rukXJaT8tM1t5grG4TLhyC1H09p+r7wlKI9n9JHGN0CqjQNkYq9
         7yCByvcc1PMSevvSHAcNll+lYpAp/Hx931xBovetf1vhTr+DHg1AaPZRlStYtlF4TQaf
         wWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZKHm8O7y9TI02rEKCCmFiWwt0kxX1dt30JyOq8XHDs8=;
        b=sjXie2D6i1aeZX2x5tQeDJCN3n2y5Y5LXPtnMYggANdoRRhM1r7g3BxT5/vpyk7mCE
         XlD62asL0NPMpbYK8KOVcMdVGlQ4HYD1w518y69m6ziIjzen4wc+wCQJMsfaLOfjqMPJ
         Nzb/Mo74NRLAbdgSUoEBCUarKMx7AkQkEWLNOvLDJNG6M4lfvkZ0lrmkVzT/eHYewclL
         X3iEYGIgEfjQXoj9TttPmi8eFTfE2egab3pGvu54zY3MqwMXN2XP006aCLXc+SQXNXz9
         tIIVfNW1dUZ625I7VFiHZPTxDCfVtBVAEY9H2Xs4eYOR/6hBqm6RYFIQRFfRE1x7m77/
         QY1g==
X-Gm-Message-State: ABuFfoh/hk5WFuViSVIxI9ItjSJOV6f+y3j7OWXq681dEHEEI/rlgDUw
        nUdXXByKmVE5h4b8NAiULFsLTz4m
X-Google-Smtp-Source: ACcGV627HfvhUcSLM8MWQ+MTJoudOlee6HUB5NUxJf6JUGWuhGtuc1faEDL2PkyuoRaH4qvGiOmzDg==
X-Received: by 2002:adf:9af5:: with SMTP id a108-v6mr82369wrc.125.1538549723972;
        Tue, 02 Oct 2018 23:55:23 -0700 (PDT)
Received: from [10.43.17.173] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w26-v6sm516048wmi.27.2018.10.02.23.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 23:55:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] tty: wipe buffer if not echoing data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build,
        torvalds@linux-foundation.org, w@1wt.eu, Greg KH <greg@kroah.com>
References: <20181002171708.1311-1-gregkh@linuxfoundation.org>
 <20181002171708.1311-3-gregkh@linuxfoundation.org>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gmazyland@gmail.com; prefer-encrypt=mutual; keydata=
 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
 vzRmJp4=
Message-ID: <bda5dd46-94bd-e8ff-d012-ac472a437f1d@gmail.com>
Date:   Wed, 3 Oct 2018 08:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
In-Reply-To: <20181002171708.1311-3-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 19:17, Greg Kroah-Hartman wrote:
> From: Greg KH <greg@kroah.com>
> 
> If we are not echoing the data to userspace, then perhaps it is a
> "secret" so we should wipe it once we are done with it.

Just to explain our test case for cryptsetup, where aszlig initially reported it:

cryptsetup reads a passphrase from terminal, derives a candidate key for keyslot
decryption and immediately wipes the passphrase from memory, because it is
not needed anymore.

And here is the problem - the kernel keeps this passphrase in a tty buffer memory
that is no longer available to userspace. It can be retrieved from memory dump
later, even after the crypt mapping is destroyed.
Almost all userspace tools working with passphrases through tty access have
the same problem here.

> This mirrors the logic that the audit code has.
> 
> Reported-by: aszlig <aszlig@nix.build>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> Tested-by: aszlig <aszlig@nix.build>
> Cc: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/n_tty.c | 20 +++++++++++++++++---
...

>  static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
>  			    size_t tail, size_t n)
>  {
>  	struct n_tty_data *ldata = tty->disc_data;
>  	size_t size = N_TTY_BUF_SIZE - tail;
> -	const void *from = read_buf_addr(ldata, tail);
> +	void *from = read_buf_addr(ldata, tail);
>  	int uncopied;
>  
>  	if (n > size) {
>  		tty_audit_add_data(tty, from, size);
>  		uncopied = copy_to_user(to, from, size);
> +		zero_buffer(tty, from, size);

I think Linus mentioned in some previous mail that there should be
  zero_buffer(tty, from, size - uncopied);
to avoid wiping of yet uncopied data.

I tested the unmodified version though...

>  		if (uncopied)
>  			return uncopied;
>  		to += size;
> @@ -171,7 +182,9 @@ static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
>  	}
>  
>  	tty_audit_add_data(tty, from, n);
> -	return copy_to_user(to, from, n);
> +	uncopied = copy_to_user(to, from, n);
> +	zero_buffer(tty, from, n);
> +	return uncopied;
>  }


Milan

