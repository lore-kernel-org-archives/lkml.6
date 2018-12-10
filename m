Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB10C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B292082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n9OoqPBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B292082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbeLJUOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:14:51 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42764 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:14:51 -0500
Received: by mail-yb1-f196.google.com with SMTP id b4so2764277ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 12:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7pR7NseLfqUERYIosvnqyRaj6b1e3HHwXmrCpuxJD0=;
        b=n9OoqPBOqjhxpDl6hWg3TVwWy0adDM75EdORYDTLASSelgsz5nf1P+7EcXeWx6EICP
         jn0GrvngVxIQ4aGK+mPpSHh3FPiiTJ74tNiVU4Iehi7CP+nvSzvWd0qMiRnPOR0LqdYd
         OKAptUPrd+CKqxxYqlDsAJwjClcycMAAjcVDml2ntK/nmcRqiJrHRHJCZCUGxE8B3idN
         mZS6a6kHb94Z9R34guMKtjDPLYi4A2m5Hk1Ww4Licv7Z9n0U2FDtzQQ3QTITiv66Wp9v
         hC7libjPk+DICRWAYhCR1TPnq596BQfjLwgVKs1NhBL9GpVb8+J1zpGb76tduA7fxfdx
         ZYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7pR7NseLfqUERYIosvnqyRaj6b1e3HHwXmrCpuxJD0=;
        b=kAAqhbz8VwI5IT58pwWbNaHIJlYFmSW+Rr/m/p5Oz1XfYyLRCX9yP2eS+xJM8MY+Z3
         tcCOvHhfEbsQ9NtasFaU9TqKAzIquku0C7EDv1y+IV4ds1rvNqKRQp9So/ad7ybjFTil
         O4eqVnvrpk1LVXwzm9d45XBmg3uuc8kweeogoWiUZAxpfZsBRaRBq+BWO3rdJ2q5JcAU
         Y7ReJTBggHOouyAlsgdIOKX7PBvnkmpqFZYedjBoE5z0lLym0SFD6aUo5gIJPau6rsrG
         2dGhv3rUt0kDPDkQbytHfDzVwjZEIEif8BfZAt5l+6ryma5Iq3oCWnhjbGIiFPzYbO2V
         ugZg==
X-Gm-Message-State: AA+aEWY67TpUJxJHnntW4DtbsHUZWizFPZN4qxnjSjhsCeF0Xsl50ELM
        U22E24k00GNIqbwoPut2rtEC8mf4kiaIcdSEhwM=
X-Google-Smtp-Source: AFSGD/VmZYcSB+cOETPsdsAqTISilPPQeGZRhxNdtvaPXgtH5RPsjlfvo+5ujgt8R/fUY2o36eKn5zkYzRVu0vdkgmw=
X-Received: by 2002:a25:8311:: with SMTP id s17mr8492180ybk.84.1544472889691;
 Mon, 10 Dec 2018 12:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20181210042352.GA6092@altlinux.org> <20181210043041.GS6131@altlinux.org>
 <CAMo8Bf+s6xObgYoOOR0NTQZR-ReBbXmNv_5Jf=jX7J+bnDsTYQ@mail.gmail.com> <20181210125315.GB11942@altlinux.org>
In-Reply-To: <20181210125315.GB11942@altlinux.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 10 Dec 2018 12:14:37 -0800
Message-ID: <CAMo8BfLbk8wfUNVZ_Qa9XVTtg4f5k5Wj6LFauroheheoTCJPxw@mail.gmail.com>
Subject: Re: [PATCH v5 19/25] xtensa: define syscall_get_* functions
To:     ldv@altlinux.org
Cc:     oleg@redhat.com, Andrew Lutomirski <luto@kernel.org>,
        lineprinter@altlinux.org, esyr@redhat.com,
        Chris Zankel <chris@zankel.net>,
        Paul Moore <paul@paul-moore.com>, eparis@redhat.com,
        linux-xtensa@linux-xtensa.org, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 4:53 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Sun, Dec 09, 2018 at 09:02:50PM -0800, Max Filippov wrote:
> > How should we synchronize our changes?
>
> No problem, I can revert to the previous edition of this patch
> that just adds syscall_get_arch.
> Alternatively, you can just take that couple of patches (v5 18/25
> and v2 15/15) into your tree.

Sure I can do the second. Will it work for v2 16/15 that changes
syscall_get_arch adding an argument to it?

--
Thanks.
-- Max
