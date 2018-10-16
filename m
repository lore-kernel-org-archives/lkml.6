Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3AC5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F0A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nu6FobEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F0A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeJQEGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:06:17 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:45248 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:06:17 -0400
Received: by mail-vs1-f68.google.com with SMTP id g201so19294939vsd.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSEu6X7hWWRXraD4hyC9zqeiDYm2llfUiFc7cxK5bl8=;
        b=Nu6FobEQTICCWAxQHA0ohrffBeNxfJkc9di8GcMbipLHkJcB9cwtxvtSXVjs2qtfmZ
         m7fvRMo+abyO5qusZ98sf3K8HriTXQEU59b2N0mMD/c5g+OfJ5n/jxO8GWPg9ctch+WB
         GyqZI7V+FyeBWv5jYgYCI/FHkJjew37n4LPj5LGcxwOoEBnCnSFJayjNFOQuxJa/4UH4
         h/frVNe/dudo0d+hrbfEwdBIQT64Bn93ORSUR5Qy1vVpK+7m15jBkGY2ZpDT/L2U+ZvX
         vNdVV9BP3U0gm4vNNZncHjEdGTHXe6K0R8OLeCP3h+TfIQa03SafpY4+9RCDJA93bd7t
         VySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSEu6X7hWWRXraD4hyC9zqeiDYm2llfUiFc7cxK5bl8=;
        b=l23q6YVfjiAQShD1TtvepxyJHvY51WUPQqJ2efbP+R8ylhdcbS0stsjYX+iY0pK8Ms
         zXYk3tFohUpEGQdiiMF1Op25HO+Ptj/hJcDppVDDr42Vg1q93vPMwJeR39BX8ixJZAvh
         HYJcNRv+4x6eArJPGr5jL7Uqpc4QeeRIKSIL0Gfi+RMXlecVOtkSxz7sakeEUtNFAqcM
         l0zAzmsouzYaDuxx6SRgyHy4ggEjGRfiyvmhI65I22rBkrfC0gqzCdLC+Bp5VCPvq9XX
         YK8pY6JM1uuJCMYthgAfYnGpK9vRcXIFNoVZTvs7ondQnRca3PI+noDqnnjLlQelYli4
         LkLg==
X-Gm-Message-State: ABuFfojwHn/YvdoQXGNQbMH7cvaY4703piD+ERbOl0gXqQ42vG2rHioE
        Yw2LnmYXjho1WQjmInktm+hfQ53OizDXwlgo+8eC4w==
X-Google-Smtp-Source: ACcGV62/O722AieAVx6KKfK/kHNNTyCrrUzQv47VE4e099xkUNjzOXmycwrhcSIxJReSWkUYRvV4O2qd0uPZK6T3cOY=
X-Received: by 2002:a67:7988:: with SMTP id u130mr7748972vsc.119.1539720852128;
 Tue, 16 Oct 2018 13:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <1539696848-21988-1-git-send-email-msavaliy@codeaurora.org>
In-Reply-To: <1539696848-21988-1-git-send-email-msavaliy@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 16 Oct 2018 13:14:00 -0700
Message-ID: <CAD=FV=UZhVni2S1utd=-aAJ3V8+-+TV57-FjrwVJB=jc6Ka8QA@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Add suspend support to non
 console UART
To:     msavaliy@codeaurora.org
Cc:     alokc@codeaurora.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 16, 2018 at 6:34 AM Mukesh, Savaliya
<msavaliy@codeaurora.org> wrote:
>
> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>
> UART driver checks for the PM state and denies suspend if state is ACTIVE.
> This makes UART to deny suspend when client keeps port open which is not
> correct. Instead follow framework and obey suspend-resume callbacks.
>
> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 36 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 30 deletions(-)

Looks like this patch was re-sent about an hour later with a different
subject of ("tty: serial: qcom_geni_serial: Rectify UART suspend
mechanism") at <https://lkml.kernel.org/r/1539699060-3055-1-git-send-email-msavaliy@codeaurora.org>.
The subject of the later patch seems better.  I'll do my review there.

-Doug
