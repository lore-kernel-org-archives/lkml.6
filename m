Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4763EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD77C21019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t19tGjry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAAS6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 13:58:02 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39858 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfAAS6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 13:58:01 -0500
Received: by mail-qk1-f181.google.com with SMTP id c21so966662qkl.6;
        Tue, 01 Jan 2019 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uQREUZ6BgyFePgsewAIYKcQY31MSRnOhm5COcKjBVo4=;
        b=t19tGjryoNGXMIe6MdUHJRKJYKvAlYdIg+nuW0mTvRMKMFG2bZiiHlZ6F+YZeq/DZD
         y/6OlK1Y8uOgcS7Hwl599+i42J8eJqH/uGeoIfxCsDD35cjIf81qriIQWL+/TwQecBgV
         9VtQGdDkRj1IZCb/gWSeGghliS5tvA4uNClXHq2ISZ1lJpTQK/nXGktn/pSeqK2INKYo
         sz72PJzwSRLLOGGq4hLUSJIkHPjJKtXe7QoWDRF2oYWxDoHsFc8/RWZO4XOTSiIp25bS
         ZNVSnePsg+z3JXZ6JNYNdzjb50ayMoFz0ylQbJKVb1OjRq8/v+xr9yXkqcaLLlN+DCsp
         Gf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uQREUZ6BgyFePgsewAIYKcQY31MSRnOhm5COcKjBVo4=;
        b=QC7vzK5R5qViynbIxesboBej1QD+qeLgJ7KaryUrExhIsSk8+LMgiNAclu3n4cLZI0
         aUKKBwwdExmE5R5Ub8DrsuJk8j7LL4PfhI93X2CRGBoBUEqiLdYXV8V6xR5iak6R45fZ
         mRtLeYtp/QrNkg/Y3KNO3O2l23saI9fG+9Co54DREKY77exZu8KNdz0wR8o5QRA+xYVq
         gqbanbGW9wuA3hbXp2SFHjrSVuRYvd5GhNFqRLN1+J4YAkYbhvdcVitlfA3yPmv+5f4l
         sNjp0zjOrRC6AfrQMj2yql6QkyERgVWkricO0SMtUrKRTR1uCN33ActkZSDORqs8nM4G
         ELkA==
X-Gm-Message-State: AJcUukcH9FgnhZEsjc4T7EZrziJT/f9FUjqpNGzdDKOwugx8DV2QmAEX
        cuUj6/Gs6BmS7m7geUWzAn2ZgEktyIlR0oKCOeys/ruk
X-Google-Smtp-Source: ALg8bN7aevfM7yWCz4NYxPinEdqqwmJ6jn7tWFMD2bMol58JxkKi3/JOVIV6cty9BvqVWL0ypCV3hpo/bmbeIFPkzDs=
X-Received: by 2002:a37:6cc6:: with SMTP id h189mr38297196qkc.186.1546369080649;
 Tue, 01 Jan 2019 10:58:00 -0800 (PST)
MIME-Version: 1.0
From:   Nathan Royce <nroycea+kernel@gmail.com>
Date:   Tue, 1 Jan 2019 12:57:49 -0600
Message-ID: <CALaQ_hoq+QfxGTi5aggfm6RehsiZOvmYk-Mz-Geu3TLdNrRXcg@mail.gmail.com>
Subject: kernel: xhci_hcd 0000:00:14.0: ERROR unknown event type 37 - Kernel 4.19.13
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 4.19.13

00:14.0 USB controller: Intel Corporation 9 Series Chipset Family USB
xHCI Controller

Around 400 "unknown event type 37" messages logged in a 2 second span.
*****
Jan 01 02:08:07 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
Jan 01 02:08:00 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
Jan 01 02:07:56 computername kernel: xhci_hcd 0000:00:14.0: ERROR
unknown event type 37
...
Jan 01 02:07:55 computername kernel: xhci_hcd 0000:00:14.0: ERROR
unknown event type 37
Jan 01 02:07:55 computername kernel: xhci_hcd 0000:00:14.0: ERROR
unknown event type 37
Jan 01 02:07:52 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
Jan 01 02:07:44 computername tvheadend[2370]: linuxdvb: Auvitek AU8522
QAM/8VSB Frontend #0 : ATSC-T #0 - poll TIMEOUT
*****

I question whether this also caused kemleak to crash as well (will
post after this).

Regarding my tv tuner, it isn't supported by the kernel specifically,
but is close enough that all I have to do is alter a single source
file to include my device's pid, and it works just fine almost all of
the time.
