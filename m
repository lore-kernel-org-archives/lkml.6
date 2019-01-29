Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56914C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD00214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7RmGArs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfA2RrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:47:16 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38514 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfA2RrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:47:16 -0500
Received: by mail-it1-f193.google.com with SMTP id z20so5863281itc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+MPER7OUWEZSr3gSZFzZR2zlSrOc+W4s1RExMQpoS4=;
        b=C7RmGArsZ9Jtvp0ml/XoY9lBdXOcjlMnUscG0WqPKYyPzSqaSXAGCM80CqHKfHD+wu
         qw6xqCcUBRTJ/xieuj3A9frA/48znA/hG8sdX03sClZZ8mOZXwbGSBuKwGR4878Dowz8
         LfTKY1ioAwOrIv/lTgddcM2Jr4myBtAIR9B1yhQTk1rTQzMIjmAJDR1XvaYM9C8oNAb3
         sbgxqecAxylH+hZpnzD3eibi6+QkQK5o2rHUX3YwSfaiO6YZIfU0W+w2Q9LZoXU0dZvL
         0UlS6cTaP1i2NbgZem1yo1eFGfnLknHXVbI+F5XweWeAR/IRZkA5cHxHre87zeaalvz1
         vRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+MPER7OUWEZSr3gSZFzZR2zlSrOc+W4s1RExMQpoS4=;
        b=pBlvRd9OiT3IzMEssLOkSGVp9D0lVgaGvj4KTuaYXyti7fH8CsviTg9TnAHGBWsW7h
         UXYbUAIykhPJfZvIya27Z02FxPfnrc/4m2LtmnHzU1ZQVDSddSx8osofM3p1cBW/mV8U
         ybgjhJ/B3KC5SAFOpEmDUGPfOcFTDKSI41BGQGpKsvIWKObGvkJCplM9fJwXSKEg9Cxp
         3+I3lkDkwpCejxRF9XlViWreaB2SmPckdX6MCUWTuobFQGU/VE7QSnVrQljZDiTBdEJk
         xTtcDVUY/coFVR7B2G5lwP4wkzRzAk4Dz5/fVUbIkiKs9zzGX5IHSsPLECnnOJd1gQ74
         xP3g==
X-Gm-Message-State: AJcUukfo2m5vyMcPMLg2NEY3H/ofL0Q6XWNKoRuIfGTxsQZPJs+IbJ21
        wjVU26VqphlJB7lOL5y4a6yGhK7l63auTgNkjLXlYA==
X-Google-Smtp-Source: ALg8bN5oRNAvY78s9cUhfI/RnsLBibTy5J+vsQ4ABBTRKK0YoNWfUwj3qL7KgWkxkfveS6Io7yFcApW0LGHa2Jxb5qA=
X-Received: by 2002:a24:5314:: with SMTP id n20mr12674710itb.132.1548784035483;
 Tue, 29 Jan 2019 09:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20190122205909.24165-1-weijiang.yang@intel.com> <20190122205909.24165-2-weijiang.yang@intel.com>
In-Reply-To: <20190122205909.24165-2-weijiang.yang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 29 Jan 2019 09:47:04 -0800
Message-ID: <CALMp9eQGg-g54zjWRcU3kkSR2kSHA0g18PURVvC1QLnC4fSYTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM:VMX: Define CET VMCS fields and bits
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, yu-cheng.yu@intel.com,
        yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 6:06 AM Yang Weijiang <weijiang.yang@intel.com> wrote:
> Note: Although these VMCS fields are 64-bit, they don't have high fields.

This statement directly contradicts the SDM, volume 3, appendix B.2:

"A value of 1 in bits 14:13 of an encoding indicates a 64-bit field.
There are 64-bit fields only for controls and for guest state. As
noted in Section 24.11.2, every 64-bit field has two encodings, which
differ on bit 0, the access type. Thus, each such field has an even
encoding for full access and an odd encoding for high access."
