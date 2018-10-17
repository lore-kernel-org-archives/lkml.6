Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA2DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463CC21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVel2bXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463CC21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJQQQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:16:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43107 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeJQQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:16:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so23974037eds.10;
        Wed, 17 Oct 2018 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ms9d1niz/4VScBsJqzALxhkeGS1pF6S1ndIf0eoHiuw=;
        b=dVel2bXxIbVpddElkux8ISXLJCh5Hzfz9TCd1Ydq6ym3hvbjVaWTBEatnwX3HGz/Ea
         6OdMqC7oP/JKNK4ClX7MizVrFWZtZQPk7F/SeLiq2AIpP1lRABsSpaD8ri6MGM9jJ0iz
         EaTQRGHsKbIq3k+RI7Q0+/GRCsHG38J0+cYfJICKrAe8qyibSGwWY8cNjisfojDZ2v5w
         PCCtDuKfsbxBoTILFEd2mCrarZYuxjKWbPrXJxWP3JbPesLXuMGXyHhfkwkhBT6/jwUi
         RLee8/zefaagqlNknN9XpSJi0J0oK2eWfRSXbIPxzKNpzt55Bt6p5s7SAbK1OAl/rHgw
         gxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ms9d1niz/4VScBsJqzALxhkeGS1pF6S1ndIf0eoHiuw=;
        b=jHXG+bII87cBw69XgLw3yj4GBI50YbkiRjxizLtMzlbpGwFnXiHf1GHUXpdKNUSyuV
         LlezT5XiYZEb3pwvH3U5AHrFlPILraDqBWAqjhGm9CV4CRK8oSbqHAGVmDaUjdhFQLe5
         Wb3eiArMmRhhvSy1vsn0rq7zk9lzSyzu6OJlaP+oMA2M623kfogehJSzWEO9/daaIAyv
         5IMln2lfTeP8DVt4rNRK0UBMreLaPhJ+0YtOCDoKq/iwEpecc72PUwQstIy5UqW+Iyd4
         ptLT5aYHw1SjFHUYbNDN2frJLuuEpLLKZfzSUTZDckiLBWxlLgHAyhhqvUw0hRbfLRK2
         gdCw==
X-Gm-Message-State: ABuFfohCNA6kw+ADnPPj4uhrv0IJOLBoDGEs9wfPnM1CfrwxSdGhK73S
        wsTYZqA4QYUg7esyG553epE18TdT8UV5thsrd1K9DYWb
X-Google-Smtp-Source: ACcGV615iXG64pXDkewjaqV0xQ0OWlAt5gdzs2sPc0/OsjTSxdWLuUEeI93PW+sjkvuq1PdyFF2tSddpHhhNvXtbb7w=
X-Received: by 2002:a17:906:731d:: with SMTP id d29-v6mr26413049ejl.26.1539764495098;
 Wed, 17 Oct 2018 01:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181016225522.13077-1-pbonzini@redhat.com>
In-Reply-To: <20181016225522.13077-1-pbonzini@redhat.com>
From:   Wincy Van <fanwenyi0529@gmail.com>
Date:   Wed, 17 Oct 2018 16:21:23 +0800
Message-ID: <CACzj_yWW1q+oQ8Wuf1n_hRgQFVFJLQ0oPZO2Ze18eoJaER+YZA@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: enable nested virtualization by default
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 6:57 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> With live migration support and finally a good solution for CR2/DR6
> exception payloads, nested VMX should finally be ready for having a stable
> userspace ABI.  The results of syzkaller fuzzing are not perfect but not
> horrible either (and might be partially due to running on GCE, so that
> effectively we're testing three-level nesting on a fork of upstream KVM!).
> Enabling it by default seems like a nice way to conclude the 4.20
> pull request. :)
>
> Unfortunately, enabling nested SVM in 2009 was a bit premature.  However,
> until live migration support is in place we can reasonably expect that
> it does not offer much in terms of ABI guarantees.  Therefore we are
> still in time to break things and conform as much as possible to the
> interface used for VMX.
>
> Suggested-by: Jim Mattson <jmattson@google.com>
> Suggested-by: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index e665aa7167cf..89fc2a744d7f 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -107,7 +107,7 @@ module_param_named(enable_shadow_vmcs, enable_shadow_vmcs, bool, S_IRUGO);
>   * VMX and be a hypervisor for its own guests. If nested=0, guests may not
>   * use VMX instructions.
>   */
> -static bool __read_mostly nested = 0;
> +static bool __read_mostly nested = 1;
>  module_param(nested, bool, S_IRUGO);
>
>  static u64 __read_mostly host_xss;
> --
> 2.17.1
>


bravo!   :-)

Thanks,
Wincy
