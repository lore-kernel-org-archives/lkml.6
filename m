Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB997C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D2E21486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXgvc7Z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D2E21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeHVS5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:57:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35539 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbeHVS5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:57:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10-v6so1780063ljg.2;
        Wed, 22 Aug 2018 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GixqUawec4jCklvh64zxrut6miWAx8Jobc9VGzNXnnQ=;
        b=KXgvc7Z2xnE6dkS4z0B0hm/S045sjDvwqrqfYLR50HfiLMKl0vuZjy9skZ0i3TNhdq
         oyZHqhdWZCS3m7L52tL5RCx//h7UHnoUp+bEgs4lTmiGSF2NnDj6Znrh2Uw89OHWKDvi
         bOY0Q9BBy2QxCmGelLzZarhIrlNLpNb+A51NSfK8EN0zsj+WbYBDPTZgjTDlJt+m/ikQ
         iqK7aKPeKCbMTfLDexIK7szMI00zXZ258tCpKahEo/RaqPE+5EILleyePPwuY5IwsB+x
         F9MqyzgtwZ1uCJT/wgbfsAcE3AMt8q13I3hQSqHjPNxz8BBGM+leqcHX6Bg57ac29Kk8
         03WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GixqUawec4jCklvh64zxrut6miWAx8Jobc9VGzNXnnQ=;
        b=TIa4q/R/B13bvWWAOh+oxWj46HBxucESEh2EBQrXHnPyUy8UWriI0gZMMITufjjMJG
         VjsPnF/8fI5olvP57wvxurXmPp0WASMzKByWn3RQb//E0goh6Rd3VrRqomEjIy2EB5UZ
         HlCuEyKVhvw04LJaSUfClHgCBRzYtA5Q7ZoLksgBbgE+4XoKpHRti3jHnoEZhSGk5e3z
         pWC0VwfhxiK0HIfLZ1J+W1eoDJtoeDyYZK5R5ujw7vKAgWAJd51U+rshtYsE/4lqufAL
         +Ml2ADewds8XTxPIhfYbLGZWNkSxykDteVsrdHhpBnKBDvMVKqcL2l2JLHweYwaNtXxB
         EeAg==
X-Gm-Message-State: AOUpUlGIT+hISS/MrETtBCYwL9VC+ZkvahTue3ReWvvbwX5ZaHoRuA0J
        BXT9vXJvJ4YbVOMeJpnISACOnQtvl8qB6570thQ=
X-Google-Smtp-Source: AA+uWPwAh8EWhNv71fHXSKMeaz2FBlbN+3asFFYWHT1s8DuO8yCWNabNzqZYlNZBfSVqK2UM1f4UElXOUGUUMouUq1c=
X-Received: by 2002:a2e:954e:: with SMTP id t14-v6mr34246238ljh.68.1534951930677;
 Wed, 22 Aug 2018 08:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <1534949580-38261-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534949580-38261-1-git-send-email-pbonzini@redhat.com>
From:   Jack Wang <jack.wang.usish@gmail.com>
Date:   Wed, 22 Aug 2018 17:31:59 +0200
Message-ID: <CA+res+SLL5iQKXNyrEy75z=eUSW+D2Hsr+RMT7b9VPR-bffrrg@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: fixes for vmentry_l1d_flush module parameter
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bsd@redhat.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Two bug fixes:
>
> 1) missing entries in the l1d_param array; this can cause a host crash
> if an access attempts to reach the missing entry. Future-proof the get
> function against any overflows as well.  However, the two entries
> VMENTER_L1D_FLUSH_EPT_DISABLED and VMENTER_L1D_FLUSH_NOT_REQUIRED must
> not be accepted by the parse function, so disable them there.
>
> 2) invalid values must be rejected even if the CPU does not have the
> bug, so test for them before checking boot_cpu_has(X86_BUG_L1TF)
>
> ... and a small refactoring, since the .cmd field is redundant with
> the index in the array.
>
> Reported-by: Bandan Das <bsd@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: a7b9020b06ec6d7c3f3b0d4ef1a9eba12654f4f7
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index c76ca8c4befa..8dae47e7267a 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -198,12 +198,14 @@
>
>  static const struct {
>         const char *option;
> -       enum vmx_l1d_flush_state cmd;
> +       bool for_parse;
>  } vmentry_l1d_param[] =3D {
> -       {"auto",        VMENTER_L1D_FLUSH_AUTO},
> -       {"never",       VMENTER_L1D_FLUSH_NEVER},
> -       {"cond",        VMENTER_L1D_FLUSH_COND},
> -       {"always",      VMENTER_L1D_FLUSH_ALWAYS},
> +       [VMENTER_L1D_FLUSH_AUTO]         =3D {"auto", true},
> +       [VMENTER_L1D_FLUSH_NEVER]        =3D {"never", true},
> +       [VMENTER_L1D_FLUSH_COND]         =3D {"cond", true},
> +       [VMENTER_L1D_FLUSH_ALWAYS]       =3D {"always", true},
> +       [VMENTER_L1D_FLUSH_EPT_DISABLED] =3D {"EPT disabled", false},
> +       [VMENTER_L1D_FLUSH_NOT_REQUIRED] =3D {"not required", false},
>  };
>
>  #define L1D_CACHE_ORDER 4
> @@ -287,8 +289,9 @@ static int vmentry_l1d_flush_parse(const char *s)
>
>         if (s) {
>                 for (i =3D 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
> -                       if (sysfs_streq(s, vmentry_l1d_param[i].option))
> -                               return vmentry_l1d_param[i].cmd;
> +                       if (vmentry_l1d_param[i].for_parse &&
> +                           sysfs_streq(s, vmentry_l1d_param[i].option))
> +                               return i;
>                 }
>         }
>         return -EINVAL;
> @@ -298,13 +301,13 @@ static int vmentry_l1d_flush_set(const char *s, con=
st struct kernel_param *kp)
>  {
>         int l1tf, ret;
>
> -       if (!boot_cpu_has(X86_BUG_L1TF))
> -               return 0;
> -
>         l1tf =3D vmentry_l1d_flush_parse(s);
>         if (l1tf < 0)
>                 return l1tf;
>
> +       if (!boot_cpu_has(X86_BUG_L1TF))
> +               return 0;
> +
>         /*
>          * Has vmx_init() run already? If not then this is the pre init
>          * parameter parsing. In that case just store the value and let
> @@ -324,6 +327,9 @@ static int vmentry_l1d_flush_set(const char *s, const=
 struct kernel_param *kp)
>
>  static int vmentry_l1d_flush_get(char *s, const struct kernel_param *kp)
>  {
> +       if (WARN_ON_ONCE(l1tf_vmx_mitigation >=3D ARRAY_SIZE(vmentry_l1d_=
param)))
> +               return sprintf(s, "???\n");
> +
>         return sprintf(s, "%s\n", vmentry_l1d_param[l1tf_vmx_mitigation].=
option);
>  }
>
> --
> 1.8.3.1
>
Tested-by: Jack Wang <jinpu.wang@profitbricks.com>
Thanks,

Jack
