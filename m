Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0891C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35287208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjJOkW7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35287208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeHYBa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:30:56 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38817 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeHYBaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:30:55 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so3747143ite.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v424ShiyTLXftwcsDxGFlIW3vyt+xOhu1ZOiBoXjA98=;
        b=YjJOkW7NfqETCaYJzbEpwQZK/SOMjumTj5i44m1okSqwNYDkNkvsycD0aq5+D8VFLC
         d+mLApLk9uJXvHRDErbx9vPepvkH06MD1uDCMox9M1NYroMulgWNP0Q/miktZh5wtOFl
         RbuTiLuuEahIoHaC6I+kToS52PgQLv2tyErIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v424ShiyTLXftwcsDxGFlIW3vyt+xOhu1ZOiBoXjA98=;
        b=qj8CnHmCGKVEH/oYVtVHMQcRbVs4rymeCOCD2OMQLuc2nkNyaAvLaurfEaJzFXUVHg
         x9z4MC8sthAQKZFbyDwZYa04d3OB4ZTK+J9bMPW9KSksSdAXzldjpyQ0zCQQzyUYoxgX
         rxwqTPJOt0Evh+O5M98aLEP9GC8R+XkbOf9bYJwKWASdcDDxr8aSWJ2tmq6y0+rDOqfB
         RN0RyRTJJ8FDgi2sLFN3HtPx760LyTntS3WrtixCkcuTPmnH/Wh1yr8LAp+krgJWqa4x
         9xq3b9/W/1y/vm+03/6i7b4OijOu4Fht5Td/0wUDiObK93uSnFpIfh00Sq0aIGO0IKeb
         Ju0g==
X-Gm-Message-State: APzg51BiK8HAjB1gGtROhKkpj9By9NBhJrFpR2pHM5xoDQhFq3FEqjWX
        6g7ftUbaGjgMVFw2FBFOpPiFqjumOMEznybK1ZT4XQ==
X-Google-Smtp-Source: ANB0VdaF9lHmY5Eb3MTUCl8X4sV63IRXy3vBOeCCqVVR8lo9x+JGw1czsZewRPGLxy1iURzpox8Qon3wy7dHBoAhVhE=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr2833556ite.123.1535147667684;
 Fri, 24 Aug 2018 14:54:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 14:54:26
 -0700 (PDT)
In-Reply-To: <yq1tvnj780o.fsf@oracle.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com> <yq1lg8zb2lp.fsf@oracle.com> <20180822062016.GA10356@infradead.org>
 <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
 <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com>
 <yq1a7pb9196.fsf@oracle.com> <CAKv+Gu8Y7YmyB5rmxaj-SGB7q03in7ijv2cOifwYnhP5CNastw@mail.gmail.com>
 <yq1tvnj780o.fsf@oracle.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 Aug 2018 22:54:26 +0100
Message-ID: <CAKv+Gu8dMBUKmw+5rxWoiRKXngPeAsNyXzOY-nZwd3GPi1S5FA@mail.gmail.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jeffrey Lien <Jeff.Lien@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 August 2018 at 22:46, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Ard,
>
>> I'd prefer to handle this without help from userland.
>>
>> It shouldn't be too difficult to register a module notifier that only
>> sets a flag (or the static key, even?), and to free and re-allocate
>> the crc_t10dif transform if the flag is set.
>
> Something like this proof of concept?
>
> diff --git a/lib/crc-t10dif.c b/lib/crc-t10dif.c
> index 1ad33e555805..87d0e8f0794a 100644
> --- a/lib/crc-t10dif.c
> +++ b/lib/crc-t10dif.c
> @@ -15,10 +15,50 @@
>  #include <linux/init.h>
>  #include <crypto/hash.h>
>  #include <linux/static_key.h>
> +#include <linux/notifier.h>
>
>  static struct crypto_shash *crct10dif_tfm;
>  static struct static_key crct10dif_fallback __read_mostly;
>
> +static void crc_t10dif_print(void)
> +{
> +       if (static_key_false(&crct10dif_fallback))
> +               pr_info("CRC T10 DIF calculated using library function\n");
> +       else
> +               pr_info("CRC T10 DIF calculated using crypto hash %s\n",
> +                       crypto_tfm_alg_driver_name(crypto_shash_tfm(crct10dif_tfm)));
> +}
> +
> +static int crc_t10dif_rehash(struct notifier_block *self, unsigned long val, void *data)
> +{
> +#ifdef CONFIG_MODULES
> +       struct module *mod = data;
> +
> +       if (val != MODULE_STATE_LIVE ||
> +           strncmp(mod->name, "crct10dif", strlen("crct10dif")))
> +               return 0;
> +
> +       /* Fall back to library function while we replace the tfm */
> +       static_key_slow_inc(&crct10dif_fallback);
> +
> +       crypto_free_shash(crct10dif_tfm);
> +       crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
> +       if (IS_ERR(crct10dif_tfm)) {
> +               crct10dif_tfm = NULL;
> +               goto out;
> +       }
> +
> +       static_key_slow_dec(&crct10dif_fallback);
> +out:
> +       crc_t10dif_print();
> +       return 0;
> +#endif /* CONFIG_MODULES */
> +}
> +
> +static struct notifier_block crc_t10dif_nb = {
> +       .notifier_call = crc_t10dif_rehash,
> +};
> +
>  __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
>  {
>         struct {
> @@ -49,16 +90,21 @@ EXPORT_SYMBOL(crc_t10dif);
>
>  static int __init crc_t10dif_mod_init(void)
>  {
> +       register_module_notifier(&crc_t10dif_nb);
> +
>         crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
>         if (IS_ERR(crct10dif_tfm)) {
>                 static_key_slow_inc(&crct10dif_fallback);
>                 crct10dif_tfm = NULL;
>         }
> +
> +       crc_t10dif_print();
>         return 0;
>  }
>
>  static void __exit crc_t10dif_mod_fini(void)
>  {
> +       unregister_module_notifier(&crc_t10dif_nb);
>         crypto_free_shash(crct10dif_tfm);
>  }
>

This looks like it should work, yes. It does rely on the module name
to start with 'crct10dif' but I guess that is reasonable, and matches
the current state on all architectures.

Anyone care to boot test this? Jeffrey?
