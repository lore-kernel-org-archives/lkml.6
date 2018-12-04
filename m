Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6554C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7320834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqVfXNDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF7320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLDWti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeLDWth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:49:37 -0500
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F1752151B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 22:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543963776;
        bh=G0dPhAX+2E8vTZIpLZYckxnxgOe/oV3yC8xyTK/SoxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GqVfXNDeosPvfiqsv5a3v8v/W06CfG4hczEdTYhbOeN9CdZoMtvkF/NjqHZS8yoBD
         DpZUKx0sErSuX2Ez+kZc2JUZun3+PiJ2hiav+4sGi+hJGZB3CIEtdKYoZb0YIMOaHG
         50O2IP79Pm//LAmhBQlhH9r66fz43VTniaQjEI4w=
Received: by mail-wr1-f44.google.com with SMTP id z5so17668559wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:49:36 -0800 (PST)
X-Gm-Message-State: AA+aEWbQ6d5psdFUeT3fAho0W1cH7lcxoCpx5nypQFr/BWA2KZ+Laggk
        X5GaDXVJYEEWiZ9IIFr3SrzoXTEZkJeOZ0Hpw/lsPw==
X-Google-Smtp-Source: AFSGD/XDaXdVWeHRZI9R7OUU3uvq3Jd3jiCHuReRWzlPqx2y8g+Ovcd9p8YdVPkM2kDl/4Y8NN2JUwVbKPpb83sMNoA=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr19172400wrm.309.1543963774637;
 Tue, 04 Dec 2018 14:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20181204212600.28090-1-sean.j.christopherson@intel.com> <20181204212600.28090-3-sean.j.christopherson@intel.com>
In-Reply-To: <20181204212600.28090-3-sean.j.christopherson@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 14:49:22 -0800
X-Gmail-Original-Message-ID: <CALCETrWmEOpgkNsKzXxHyS8+U1dVYTMMe5BUVY=fnckdfk-oJQ@mail.gmail.com>
Message-ID: <CALCETrWmEOpgkNsKzXxHyS8+U1dVYTMMe5BUVY=fnckdfk-oJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] x86/vdso: Remove a stale/misleading comment from
 the linker script
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 1:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Once upon a time, vdso2c aggressively stripped data from the vDSO
> image when generating the final userspace image.  This included
> stripping the .altinstructions and .altinstr_replacement sections.
> Eventually, the stripping process reverted to "objdump -S" and no
> longer removed the aforementioned sections, but the comment remained.
>
> Keeping the .alt* sections at the end of the PT_LOAD segment is no
> longer necessary, but there's no harm in doing so and it's a helpful
> reminder that they don't need to be included in the final vDSO image,
> i.e. someone may want to take another stab at zapping/stripping the
> unneeded sections.

Acked-by: Andy Lutomirski <luto@kernel.org>
