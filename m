Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D00ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D96C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 21:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgnddg0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D96C20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJYGUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 02:20:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36640 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeJYGUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 02:20:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so7498434qth.3;
        Wed, 24 Oct 2018 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyA95IYjaTpWJ0+EEWrAyDyBdCOZt9AJTGSa/SLi4Zs=;
        b=Kgnddg0YVOoX4l1cR3d65cs/2PlIRJvizzquuE5kzbzyrecBFSktSNQ8Z/Km1vhn+h
         frpcaHgv5PzySVg5ffcRNPQEKvdlD/mRdz5llWh7hUeCGr0CDaNnMVpaNFMBqyapCBlh
         VTKdLftEhnc5Kb0UQ2BfwLZ2PY+FQFKpO+/KDIF/9+rtN2UP45g5r0b1elsuVba/6RlY
         EK4HEqEC7O6LGaQI8E8YMvrtxsGdyWZUfjxuENPU0JnNsYgc/YN+EAhatpDZlPoqmST2
         B8jMP0YFS8EGnBTakEPzP6iQ7jor7Vx8V36NxzT4TIphUVqRzk4eOPX7nkvrg2zOPr89
         jrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyA95IYjaTpWJ0+EEWrAyDyBdCOZt9AJTGSa/SLi4Zs=;
        b=C4QTSgIp43jQZq130+FO3g8OUDVqpBQ27Wz2Al4SfZ821tTrtfxALU72l7QWb+47ME
         q7qY/2D3jgFTUpU5bDh4Mi724ZdXtaoKwonGl7HOugo7rH5hCfxTG+KuZJrsgmhErDSg
         RC5gqz8ceRE2n0x1jWPNEcTY70RNyB6tPJdmGPgbzfyDfQ3wPAnxq/x0YVigjhh3f/EG
         85uoMcLjOJNRLhsLvcTU4IZimvym9FWmPr4lJTMaQO7rmmdaAsGDyzEHgznhdbRa73Dx
         ybhOSgijpFS6TvE6bGpBspEIGk45XNDTI5xcyh5PlnQXdIE73mwiQQi03EJRki5DQeUY
         eoBw==
X-Gm-Message-State: AGRZ1gLPbZ7lpdk2zRDHE6T/OlxEBD6bNALptOd1ITIWQm2kIDUiHYPN
        M9dRsNMl8jmsTVHFZhAwZhrLhmz6bbL7VCKX76rD2Gz+
X-Google-Smtp-Source: AJdET5dwk63JjXLrxbrxhllqWK1MxGDts3kUWmxWqTsmKWk1MpmONBc5btVkjty7VLURPFp98ZLxdfPe7xzsIX2hZ3s=
X-Received: by 2002:ac8:3317:: with SMTP id t23-v6mr4242095qta.225.1540417863918;
 Wed, 24 Oct 2018 14:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <1540386020-30680-1-git-send-email-wang6495@umn.edu>
 <20181024172514.l33dsaqdvs5yewvm@kafai-mbp> <20181024182239.lz7uicceihzmxabh@kafai-mbp>
 <20181024203548.glxgu3bqd47minmg@kafai-mbp>
In-Reply-To: <20181024203548.glxgu3bqd47minmg@kafai-mbp>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 24 Oct 2018 14:50:52 -0700
Message-ID: <CAPhsuW6pz6YoNRWah=nPrVRbyd=Sbh6tYDTGqP5aOxxSHw54pg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: btf: Fix a missing-check bug
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     wang6495@umn.edu, kjlu@umn.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 1:45 PM Martin Lau <kafai@fb.com> wrote:
>
> On Wed, Oct 24, 2018 at 06:22:46PM +0000, Martin Lau wrote:
> > On Wed, Oct 24, 2018 at 05:26:23PM +0000, Martin Lau wrote:
> > > On Wed, Oct 24, 2018 at 08:00:19AM -0500, Wenwen Wang wrote:
> > > > In btf_parse(), the header of the user-space btf data 'btf_data' is firstly
> > > > parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the header
> > > > is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
> > > > verified. If no error happens during the verification process, the whole
> > > > data of 'btf_data', including the header, is then copied to 'data' in
> > > > btf_parse(). It is obvious that the header is copied twice here. More
> > > > importantly, no check is enforced after the second copy to make sure the
> > > > headers obtained in these two copies are same. Given that 'btf_data'
> > > > resides in the user space, a malicious user can race to modify the header
> > > > between these two copies. By doing so, the user can inject inconsistent
> > > > data, which can cause undefined behavior of the kernel and introduce
> > > > potential security risk.
> > btw, I am working on a patch that copies the btf_data before parsing/verifying
> > the header.  That should avoid this from happening but that will
> > require a bit more code churns for the bpf branch.
> >
> It is what I have in mind:
>
>
> It is not a good idea to check the BTF header before copying the
> user btf_data.  The verified header may not be the one actually
> copied to btf->data (e.g. userspace may modify the passed in
> btf_data in between).  Like the one fixed in
> commit 8af03d1ae2e1 ("bpf: btf: Fix a missing check bug").
>
> This patch copies the user btf_data before parsing/verifying
> the BTF header.
>
> Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/btf.c | 58 +++++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 378cef70341c..ee4c82667d65 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2067,56 +2067,47 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
>         return 0;
>  }
>
> -static int btf_parse_hdr(struct btf_verifier_env *env, void __user *btf_data,
> -                        u32 btf_data_size)
> +static int btf_parse_hdr(struct btf_verifier_env *env)
>  {
> +       u32 hdr_len, hdr_copy, btf_data_size;
>         const struct btf_header *hdr;
> -       u32 hdr_len, hdr_copy;
> -       /*
> -        * Minimal part of the "struct btf_header" that
> -        * contains the hdr_len.
> -        */
> -       struct btf_min_header {
> -               u16     magic;
> -               u8      version;
> -               u8      flags;
> -               u32     hdr_len;
> -       } __user *min_hdr;
>         struct btf *btf;
>         int err;
>
>         btf = env->btf;
> -       min_hdr = btf_data;
> +       btf_data_size = btf->data_size;
>
> -       if (btf_data_size < sizeof(*min_hdr)) {
> +       if (btf_data_size <
> +           offsetof(struct btf_header, hdr_len) + sizeof(hdr->hdr_len)) {
>                 btf_verifier_log(env, "hdr_len not found");
>                 return -EINVAL;
>         }
>
> -       if (get_user(hdr_len, &min_hdr->hdr_len))
> -               return -EFAULT;
> -
> +       hdr = btf->data;
> +       hdr_len = hdr->hdr_len;
>         if (btf_data_size < hdr_len) {
>                 btf_verifier_log(env, "btf_header not found");
>                 return -EINVAL;
>         }
>
> -       err = bpf_check_uarg_tail_zero(btf_data, sizeof(btf->hdr), hdr_len);
> -       if (err) {
> -               if (err == -E2BIG)
> -                       btf_verifier_log(env, "Unsupported btf_header");
> -               return err;
> +       /* Ensure the unsupported header fields are zero */
> +       if (hdr_len > sizeof(btf->hdr)) {
> +               u8 *expected_zero = btf->data + sizeof(btf->hdr);
> +               u8 *end = btf->data + hdr_len;
> +
> +               for (; expected_zero < end; expected_zero++) {
> +                       if (*expected_zero) {
> +                               btf_verifier_log(env, "Unsupported btf_header");
> +                               return -E2BIG;
> +                       }
> +               }
>         }
>
>         hdr_copy = min_t(u32, hdr_len, sizeof(btf->hdr));
> -       if (copy_from_user(&btf->hdr, btf_data, hdr_copy))
> -               return -EFAULT;
> +       memcpy(&btf->hdr, btf->data, hdr_copy);
>
>         hdr = &btf->hdr;
>
> -       if (hdr->hdr_len != hdr_len)
> -               return -EINVAL;
> -
>         btf_verifier_log_hdr(env, btf_data_size);
>
>         if (hdr->magic != BTF_MAGIC) {
> @@ -2186,10 +2177,6 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
>         }
>         env->btf = btf;
>
> -       err = btf_parse_hdr(env, btf_data, btf_data_size);
> -       if (err)
> -               goto errout;
> -
>         data = kvmalloc(btf_data_size, GFP_KERNEL | __GFP_NOWARN);
>         if (!data) {
>                 err = -ENOMEM;
> @@ -2198,13 +2185,18 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
>
>         btf->data = data;
>         btf->data_size = btf_data_size;
> -       btf->nohdr_data = btf->data + btf->hdr.hdr_len;
>
>         if (copy_from_user(data, btf_data, btf_data_size)) {
>                 err = -EFAULT;
>                 goto errout;
>         }
>
> +       err = btf_parse_hdr(env);
> +       if (err)
> +               goto errout;
> +
> +       btf->nohdr_data = btf->data + btf->hdr.hdr_len;
> +
>         err = btf_parse_str_sec(env);
>         if (err)
>                 goto errout;
> --
> 2.17.1
>
>
