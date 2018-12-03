Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B23C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C75C20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QZL3wQ+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C75C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLCR3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:29:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50517 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbeLCR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:29:15 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so10580522iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JWDQuEjTBB9IBO6LdSktANapsZoe/1zjhceEpfNoVA=;
        b=QZL3wQ+vyrW5w1j9a++jKr8hMstTytPUCxGGhqcJwWbdvx0T1gfWHVn8Ek3fQ25Rn9
         9OTS/vrTnwdK76bU9XDRiUbXhbQ9MYn2jJ0M5NHlAjnNdFJfugMzMcEhTmRXU069dBjr
         ItWqjrjvCsLpZCqo1lJjKFJKA94O5KHPW8TD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JWDQuEjTBB9IBO6LdSktANapsZoe/1zjhceEpfNoVA=;
        b=a2n4fzJM/HCJx0ZbBHBn4RQ6zJhwmUjoWivG6FEGRAhHEbCjvHnhKXdxKedU28Laif
         p117QuweTrZMWb5DrU8oTvkO84eeF3DwWt4KMskiIUbEHE/QhVJtfGe5jJxQiMRAAmLD
         KGeRoShcyRfXJWnfL4RcXPBiDVggEcwiiYUAQnUHeal76y99Vs5AVIVFrP/88pOfqms2
         Cv1AmUME/wa97U2hn7oJBo/xTFDTscXCqwudpmySgod67BIMEhB8dZBI0mQw3THFdHtY
         fJZ/3NIuGX/1uCjgbdtZdTl+5E3GhhXqwROq0Kpn80qA4D58zzvlJmXilx9Sm8dnKwXP
         qypQ==
X-Gm-Message-State: AA+aEWbFkukWWK6XhXKFbog3ElcIEnf7sebGQKEoYhihGGE4Q7xvhuIq
        XMI54BHSsVkLtQ+oc1OyblUIBzF9DlWacRe4jqReNg==
X-Google-Smtp-Source: AFSGD/VSweZvBLVQ+0bCuuOGBFdvpQiIsYD8xHzX5l7Eqe3PWC4Q3yszw3NILSKVw4Fu3GYI79x6rWB9Z6DO0XKPQQw=
X-Received: by 2002:a24:130a:: with SMTP id 10mr8580532itz.58.1543858149677;
 Mon, 03 Dec 2018 09:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20181201005759.28093-1-eric@anholt.net> <CAApk1dXwAtoFRRq971fwsE+yrbJT1kcYnjzSwShHBrXkU+nv_g@mail.gmail.com>
In-Reply-To: <CAApk1dXwAtoFRRq971fwsE+yrbJT1kcYnjzSwShHBrXkU+nv_g@mail.gmail.com>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Mon, 3 Dec 2018 17:28:58 +0000
Message-ID: <CAApk1dU5+Lf3oJhGUQQuWMA3iNpM3JBhbB8Vu5+tH7nHnWHicg@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/v3d: Document cache flushing ABI.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018 at 17:22, Dave Emett <david.emett@broadcom.com> wrote:
>
> > + * The caches (L1T, slice, and L2T) will be flushed before the job
> > + * executes.  The TLB writes are guaranteed to have been flushed by
>
> I would say before *each* job executes, as the caches are flushed
> before both bin and render.
> I wouldn't say "the caches" as not all of the V3D caches are flushed
> before executing a control list. In particular, the VCD cache is not
> cleared by the kernel driver (not even sure if there is a register
> interface to do this); it is expected that the control list will do
> this itself (using the CLEAR_VCD_CACHE instruction).
> On 3.3 and earlier there is a separate L2C for instructions/uniforms
> and a GCA. These do need to be flushed, and it looks like they are, so
> they should be mentioned here.

Correction: on *3.2* and earlier there is a separate L2C for
instructions/uniforms. On 3.3 and earlier there is a GCA.

It looks like we're currently unconditionally writing the L2C clear
registers. We should really only be doing this on 3.2 and earlier.
