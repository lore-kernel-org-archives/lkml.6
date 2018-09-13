Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED2FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F7520866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZbqiTUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F7520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeIMTlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:41:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40782 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeIMTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:41:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id v10-v6so1418268otk.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkGUmS9vIBnUyKuK2kh1pZO1tM4bGTQzcxbwLXk40GY=;
        b=OZbqiTUwOZZ1qHwyz90bNbKJ48HtcdyYeXaBFHeXA+JQWTFsA2dP2VJx/8BUvoxBHk
         4iktUlTRR/saRwc3GVO0B5NMPQWONhkXq0IHSvZiOYThhn20ICeBc8w+LU8WcuNrHdw/
         qwsAH2ksfp/ciMSsIxuDTgiEU3JmeetRNfO8X+8Ph8ygIKrhHYPlU9m8+u0XI81rb15Y
         cRil6axwKGtDwixftkxgEs8/snadHRL/RPa90WEqzEPpiozsfigpKtoRFdji496amWDk
         mK6AoPGkQCnNY9MHfhKT7w8A2AoBECMuZMVNdlnzu5SfKfcp4OhI74X9xPxPPli86J7w
         nGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkGUmS9vIBnUyKuK2kh1pZO1tM4bGTQzcxbwLXk40GY=;
        b=Qq4MI/A4cNsbNxkhyAufvPUwr0Z4R2eG3KaIbIb50fzoH2wxcHt8Idpf0OUnx1GXLE
         Zug3vcWBrHIL1i1vqwwUqouVeYdDKgOZWmXtH3Kw5OX+xNxbFQBjWpbGPwBMhZ5rPQUw
         2BdpFhXaDHczI83rcJAXM5KXeVprUGWHao9OIhSL1JDc52AfxRdIju8LOPTCR74oSamD
         XZ+VoexlLvU00pvBWJpjPuApF0zOIVGsc9PeIM0vav4OWgepEynmkBeEVuqs9CGms7bY
         CPdnxl3/gQ7N7s0exMWjMMf7QY7L5PXJdRbyzr8haVEyVhAVDTSHs4c6PQUTpoIlVAhR
         f7fA==
X-Gm-Message-State: APzg51BBEbZ2SIlmdESbHu9tJOpyYNrFWdYEeDCUslIhM0fItXxNKoVE
        i/ya9fmuSvSKXmlt+YuFqetHvSxAyC/S4fipxwnzxQ==
X-Google-Smtp-Source: ANB0VdbC2govOqI4McaTOoJamSVMYlgsI64WBr0csIIiEAi9ABvjDPBV1IrRTFONfQr/5rYfAGOYq7Ekr1PF28GBIHQ=
X-Received: by 2002:a9d:436a:: with SMTP id y39-v6mr1354508oti.166.1536849104762;
 Thu, 13 Sep 2018 07:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180912142337.21955-1-jlee@suse.com> <20180912142337.21955-2-jlee@suse.com>
In-Reply-To: <20180912142337.21955-2-jlee@suse.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 13 Sep 2018 16:31:18 +0200
Message-ID: <CAG48ez2pRwpv0V0MNbeBN26isW2peebf+S3cqLxUgdUfARfhiw@mail.gmail.com>
Subject: Re: [PATCH 1/5] PM / hibernate: Create snapshot keys handler
To:     joeyli.kernel@gmail.com
Cc:     rjw@rjwysocki.net, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, joeyli <jlee@suse.com>,
        rafael.j.wysocki@intel.com, yu.c.chen@intel.com, oneukum@suse.com,
        yu.chen.surf@gmail.com, David Howells <dhowells@redhat.com>,
        ggherdovich@suse.cz, keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc keyrings list

On Thu, Sep 13, 2018 at 4:08 PM Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> This patch adds a snapshot keys handler for using the key retention
> service api to create keys for snapshot image encryption and
> authentication.
>
> This handler uses TPM trusted key as the snapshot master key, and the
> encryption key and authentication key are derived from the snapshot
> key. The user defined key can also be used as the snapshot master key
> , but user must be aware that the security of user key relies on user
> space.
>
> The name of snapshot key is fixed to "swsusp-kmk". User should use
> the keyctl tool to load the key blob to root's user keyring. e.g.
>
>  # /bin/keyctl add trusted swsusp-kmk "load `cat swsusp-kmk.blob`" @u
>
> or create a new user key. e.g.
>
>  # /bin/keyctl add user swsusp-kmk password @u
>
> Then the disk_kmk sysfs file can be used to trigger the initialization
> of snapshot key:
>
>  # echo 1 > /sys/power/disk_kmk
>
> After the initialization be triggered, the secret in the payload of
> swsusp-key will be copied by hibernation and be erased. Then user can
> use keyctl to remove swsusp-kmk key from root's keyring.
>
> If user does not trigger the initialization by disk_kmk file after
> swsusp-kmk be loaded to kernel. Then the snapshot key will be
> initialled when hibernation be triggered.
[...]
> +static ssize_t disk_kmk_store(struct kobject *kobj, struct kobj_attribute *attr,
> +                             const char *buf, size_t n)
> +{
> +       int error = 0;
> +       char *p;
> +       int len;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;

This is wrong, you can't use capable() in a write handler. You'd have
to use file_ns_capable(), and I think sysfs currently doesn't give you
a pointer to the struct file.
If you want to do this in a write handler, you'll have to either get
rid of this check or plumb through the cred struct pointer.
Alternatively, you could use some interface that doesn't go through a
write handler.

> +       p = memchr(buf, '\n', n);
> +       len = p ? p - buf : n;
> +       if (strncmp(buf, "1", len))
> +               return -EINVAL;
> +
> +       error = snapshot_key_init();
> +
> +       return error ? error : n;
> +}
> +
[...]
> +
> +static int user_key_init(void)
> +{
> +       struct user_key_payload *ukp;
> +       struct key *key;
> +       int err = 0;
> +
> +       pr_debug("%s\n", __func__);
> +
> +       /* find out swsusp-key */
> +       key = request_key(&key_type_user, skey.key_name, NULL);

request_key() looks at current's keyring. That shouldn't happen in a
write handler.

> +       if (IS_ERR(key)) {
> +               pr_err("Request key error: %ld\n", PTR_ERR(key));
> +               err = PTR_ERR(key);
> +               return err;
> +       }
> +
> +       down_write(&key->sem);
> +       ukp = user_key_payload_locked(key);
> +       if (!ukp) {
> +               /* key was revoked before we acquired its semaphore */
> +               err = -EKEYREVOKED;
> +               goto key_invalid;
> +       }
> +       if (invalid_key(ukp->data, ukp->datalen)) {
> +               err = -EINVAL;
> +               goto key_invalid;
> +       }
> +       skey.key_len = ukp->datalen;
> +       memcpy(skey.key, ukp->data, ukp->datalen);
> +       /* burn the original key contents */
> +       memzero_explicit(ukp->data, ukp->datalen);

You just zero out the contents of the supplied key? That seems very
unidiomatic for the keys subsystem, and makes me wonder why you're
using the keys subsystem for this in the first place. It doesn't look
like normal use of the keys subsystem.

> +key_invalid:
> +       up_write(&key->sem);
> +       key_put(key);
> +
> +       return err;
> +}
> +
> +/* this function may sleeps */
> +int snapshot_key_init(void)
> +{
> +       int err;
> +
> +       pr_debug("%s\n", __func__);
> +
> +       if (skey.initialized)
> +               return 0;
> +
> +       hash_tfm = crypto_alloc_shash(hash_alg, 0, CRYPTO_ALG_ASYNC);
> +       if (IS_ERR(hash_tfm)) {
> +               pr_err("Can't allocate %s transform: %ld\n",
> +                       hash_alg, PTR_ERR(hash_tfm));
> +               return PTR_ERR(hash_tfm);
> +       }
> +
> +       err = trusted_key_init();
> +       if (err)
> +               err = user_key_init();
> +       if (err)
> +               goto key_fail;
> +
> +       skey.initialized = true;

Does this need a memory barrier to prevent reordering of the
"skey.initialized = true" assignment before the key is fully
initialized?

> +
> +       pr_info("Snapshot key is initialled.\n");
> +
> +       return 0;
> +
> +key_fail:
> +       crypto_free_shash(hash_tfm);
> +       hash_tfm = NULL;
> +
> +       return err;
> +}
> --
> 2.13.6
>
>
