Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD26ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966B421557
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ6bTmnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966B421557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJTWxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:53:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37865 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeJTWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:53:02 -0400
Received: by mail-lj1-f195.google.com with SMTP id 63-v6so33285237ljs.4;
        Sat, 20 Oct 2018 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkSoupYwxfhc0zIBArMqGSzHK+gPEYJShdJnvqhYqXw=;
        b=hJ6bTmnYi2WblTqhJDlYbup76+3mDz6+G/UOYmz4M64Bi69Ndn/ZlylxCbBal/NjIa
         kcVJXNFX3dREq4U1jXDpnv5HDy2tVw9zuR3+AtiMppe389O2fzi3Ofi9aknPoQ1XhKY8
         qc/dLgjvcgYvv9nO3LECP4vPFjK5JNpONM/Lx11duF9MTwow100tfpFr/REXLgXn4H/Q
         aKnBMN7nfsaxGX8Scs/I0ctjRVzN8FQIyLkf/zg4ZVbHpj3br7pLWlsuwEszcv1Lzk2W
         7qxNT4FN7QnCSoHG5tPYcqfIFbEBDrms0FFllzUDPC22ftfxG/HtDFa9jebv6kH3bPvm
         v2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkSoupYwxfhc0zIBArMqGSzHK+gPEYJShdJnvqhYqXw=;
        b=lqFaJ9uuxgFgMXzMMnRhiS1VihAZqOaEJnxq3ETjl+o6MYoA/E6lOvffZ0VVkuSNQE
         noFmTf4onD4WbsDWObhmsJSDd2nccCo/YmA2nzAwJLVPER3plhQ5+Yb2HUeV2kqJhTud
         n6zrHk9ttaFoxd8Lk94Eblgy3YUDkPjHH9losa6567XDRcTpVe7Dj/RRSFxQRcvuU0x8
         ya29nlsQQPmfA9WMEIq+RKg8GEf6ZQ42ToH1BXDWTQbgIF7RoK5ru2swmi65SacC8wDE
         LD87GKMFyd1ueDDLFu/Smhh2YovXRFH0SnzMX06DExhDg8IfbncPRBrtdqvivgKNwfNd
         U4RQ==
X-Gm-Message-State: ABuFfoimUXoU3/p3tL506rBp0VbewY0NsFE8DqsNdbBYcaVac2g9TP7N
        H4a+UhRlNbPSzk9b2JYTS0Y8KMz4H1pBHfke2VE=
X-Google-Smtp-Source: ACcGV62i+jO4Y0+JJgvuk42Ns/drweVv/O7u0uGhH/3MgZXumB/VPxdDbIfZQKB7v7fE5rZoOttzn1AXY1xmR8Z3HvQ=
X-Received: by 2002:a2e:8684:: with SMTP id l4-v6mr27170498lji.52.1540046537867;
 Sat, 20 Oct 2018 07:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181017031241.669-1-kys@linuxonhyperv.com> <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com> <20181017050705.GE22447@kroah.com>
 <20181017062255.oiu44y4zuuwilan3@mwanda>
In-Reply-To: <20181017062255.oiu44y4zuuwilan3@mwanda>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 20 Oct 2018 16:42:07 +0200
Message-ID: <CANiq72kQwhOFC5=vaNZW9qpmohot3ATRJVnn95A8eJ2w2xCNMQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused by
 incorrect clean-up
To:     Dan <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, kys@microsoft.com,
        olaf@aepfle.de, sthemmin@microsoft.com, jasowang@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable@vger.kernel.org, Michael.H.Kelley@microsoft.com,
        Robo Bot <apw@canonical.com>, devel@linuxdriverproject.org,
        vkuznets@redhat.com, haiyangz@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+On Wed, Oct 17, 2018 at 8:25 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> It's not common at all.  It should be wrapped in a macro and put into
> compiler.h.
>
> But I hope it does become adopted.  It's better than randomly grepping
> for non-standard comments.

Using an attribute is indeed better whenever possible. In C++17 it is
an standard attribute and there have been proposals to include some of
them for C as well since 2016 at least, e.g. the latest for
fallthrough at:

  http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2268.pdf

I have taken a quick look into supporting it (typing it here to save
it on the mailing list :-), and we have:

  * gcc >= 7.1 supports -Wimplicit-fallthrough with
__attribute__((fallthrough)), the comment syntax and the C++
[[fallthrough]] syntax.
  * gcc < 7.1 complains about empty declarations (it does not know
about attributes for null statements) and also
-Wdeclaration-after-statement.
  * clang 7 supports -Wimplicit-fallthrough (not enabled in
-Wall/extra/pedantic like gcc, though) but *only* in C++ mode and with
the C++ syntax [[fallthrough]]. In other words, in C mode, no syntax
works and no diagnostics are emitted. It complains about
Wmissing-declarations. [IMO they should allow the __attribute__ syntax
for fallthrough (and enable it on C mode) to be compatible with gcc.
Maybe they are simply waiting for the C2x attributes... :-)]
  * icc 19 does not know about -Wimplicit-fallthrough at all (but
seems to allow [[fallthrough]] on C++17 mode to comply with the
standard).

Therefore, the only improvement we could do right now is starting to
use the attribute for gcc > 7.1, and a comment for everybody else.
However, even if that was worth the trouble of changing the 2500+
instances of fall through markings that we have, comments are replaced
before the preprocessor stage, so we would need some (probably
non-portable) macro magic.

So, I would say, let's revisit this again in a few years. Possibly,
when we move the minimum version to gcc 7.1, clang and icc may both
support the fallthrough warning in C mode; so that we can always use
the __attribute__((fallthrough)) unconditionally under a __fallthrough
#define.

Cheers,
Miguel
