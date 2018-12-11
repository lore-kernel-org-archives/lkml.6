Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6822AC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAFC20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+Ek+dMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAFC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLKVZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:25:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32855 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:25:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so7248139pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUG8wLqK3LkDCBK9Mi1GQnFqyXw85mqX04pXHST8jRE=;
        b=s+Ek+dMfmkYIRCxBn99R4Pmxr4+G0eJel6lofpVXMoUQsnyB04jJ5zWupwOlOV3Mlo
         58iihqdfa/Mg9ud/1gwMmNdceG97Xu82IU1bR0qdBw9nXKU5G7w9T+0kF11hVkgXg1nb
         MYl6rV1JWG5RsrJD1etzYabLl9eGhKwhHsV3bXk/ij1kX87Skh2+w1E+InLol6OSUCjg
         mfCmn+0nKkoGYc0QguxblBS/qdqh1ppQGa6VqNpPWRnLK7j6yfpw34OSUqrdFV0VfB3j
         RdwSJePLZNP6mUhxrR8fvNXkOJO/YdAO6wfNjQ2HWq0KUGy/HL4exl0Ftb7EXCz02Fhe
         uI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUG8wLqK3LkDCBK9Mi1GQnFqyXw85mqX04pXHST8jRE=;
        b=CCV3T5lJzN8xZuPNkgkRq/e9QBtZoBKw285pvIseiAnrP9Bpm7GGZjPbLmRxoKeTTK
         PNwrww9EsZWezzCxV33j5CF1OtQBj8E/4VbaRUoqpjO/38SaRMq/McJhd7ZScPinevh3
         63q6th329RJZfBjk/YfYcSSawaVNiIT/IVLbsfl7KZrlkwDd9Ga3t70fwIYNbRsx7iUJ
         Oyc3uoQffXQPFV7pS55kyWBKMxOE/7ogfO+303bxf2jlRFA2+DUWf9qEHkC99u1s699Q
         mQe8xM0FiiPBXZ6iNl8juq0ikL/5uUyX6c1jS8PD7DjIAaUw0omdOAz3dBd9aZJvpyBi
         mLnA==
X-Gm-Message-State: AA+aEWbaFxbcwR4RF/XxGjXfF31ZtN5S4aa4tuXiIKt50HcBUJ4pO6D5
        vDAUQOF8JNMxKlm8IxbQgbrHH66Bgdm53A7cCHps7g==
X-Google-Smtp-Source: AFSGD/WevDDcn/E44p/xzMoUY4wPhSV1VhQwGlfvFmXW17PYSScWt1GQFLIcyQZaq/xQHibHfnMJgapYT8oBC/qwK7c=
X-Received: by 2002:a65:4683:: with SMTP id h3mr15374396pgr.225.1544563511163;
 Tue, 11 Dec 2018 13:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20181210234201.4850-1-natechancellor@gmail.com>
In-Reply-To: <20181210234201.4850-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Dec 2018 13:25:00 -0800
Message-ID: <CAKwvOdkOwdrsOAADGp9To2F5o2AAW7123yADFzYLMawwsinmug@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Pass app_tf by value rather than by reference
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 3:42 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when an expression that equals zero is used as a null
> pointer constant (in lieu of NULL):
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
> warning: expression which evaluates to zero treated as a null pointer
> constant of type 'const enum color_transfer_func *'
> [-Wnon-literal-null-conversion]
>                 TRANSFER_FUNC_UNKNOWN,
>                 ^~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
> This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
> state using drm VRR properties") and it could be solved by using NULL
> instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
> pointer. However, after looking into it, there doesn't appear to be a
> good reason to pass app_tf by reference as it is never mutated along the
> way. This is the only code path in which app_tf is used:
>
> mod_freesync_build_vrr_infopacket ->
>     build_vrr_infopacket_v2 ->
>         build_vrr_infopacket_fs2_data
>
> Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
> modify app_tf's value and build_vrr_infopacket_fs2_data expects just
> the value so we can avoid dereferencing anything by just passing in
> app_tf's value to mod_freesync_build_vrr_infopacket and
> build_vrr_infopacket_v2.
>
> There is no functional change because build_vrr_infopacket_fs2_data
> doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
> as not calling build_vrr_infopacket_fs2_data at all like before this
> change when NULL was used for app_tf.

Nathan,
Thanks for sending this patch.  I was hoping to provide review sooner,
but have been quite busy lately.

Yeah, especially for LP64 targets, the pointer to enum is larger than
just the enum, and if it's not being updated ("in/out paramter")
there's no need to pass by pointer.

>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
>  drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 620a171620ee..520665a9d81a 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
>
>  static void build_vrr_infopacket_v2(enum signal_type signal,
>                 const struct mod_vrr_params *vrr,
> -               const enum color_transfer_func *app_tf,
> +               enum color_transfer_func app_tf,
>                 struct dc_info_packet *infopacket)
>  {
>         unsigned int payload_size = 0;
> @@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
>         build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
>         build_vrr_infopacket_data(vrr, infopacket);
>
> -       if (app_tf != NULL)
> -               build_vrr_infopacket_fs2_data(*app_tf, infopacket);
> +       build_vrr_infopacket_fs2_data(app_tf, infopacket);
>
>         build_vrr_infopacket_checksum(&payload_size, infopacket);
>
> @@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>                 const struct dc_stream_state *stream,
>                 const struct mod_vrr_params *vrr,
>                 enum vrr_packet_type packet_type,
> -               const enum color_transfer_func *app_tf,
> +               enum color_transfer_func app_tf,
>                 struct dc_info_packet *infopacket)
>  {
>         /* SPD info packet for FreeSync */
> diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> index 949a8b62aa98..063af6258fd9 100644
> --- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
> @@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
>                 const struct dc_stream_state *stream,
>                 const struct mod_vrr_params *vrr,
>                 enum vrr_packet_type packet_type,
> -               const enum color_transfer_func *app_tf,
> +               enum color_transfer_func app_tf,

Don't you need to update the callsite of `mod_freesync_build_vrr_infopacket` in

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#4949:

-                                           NULL,
+                                          transfer_func_unknown,

Maybe at that point the `if (app_tf != NULL)` could be replaced with
`if (app_tf != transfer_func_unknown)` hoisted from
`build_vrr_infopacket_fs2_data`? (There's only one caller of
`build_vrr_infopacket_fs2_data` today, maybe fine to leave the
unconditional call and check).

Either way, I suspect without the change to
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c, that this fails to
compile?
-- 
Thanks,
~Nick Desaulniers
