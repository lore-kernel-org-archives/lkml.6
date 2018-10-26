Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9545BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E8F20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRG/Sp75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E8F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJ0BIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 21:08:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40812 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeJ0BIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 21:08:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id m15so1617882otl.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WCQSbmDiSp2TikX+81KkfW5KaWUZgpU/q4zGiCgAHT8=;
        b=RRG/Sp751Ll7tAfqk3x0Fkc3eipuA4hbh81CcXiAjA/3ZP6DiIGOZMmbpsYne4POYA
         R/xbi+M+NBIXr4LVhg+UgbeYLAb3XTTwViu5RFkkOY0HkHDRc98ftKVimq8Btf5T3j23
         KCoHWzmBxJeLGLb5S/SaNwLfKhRPNnJ3EqiDOSonDVj/JPcfW8sOt8S6XU2Etz7kqqLE
         6q4Uju9mu2vz6u617VN5Ji5gPtd5i0eO9wqhIKDVRCc7xjWB/ZEW9lgkuiud8BLVfqNA
         STckfhqw4mEHVEOdmgNBbbOQ7gQSH/XkiFIE0X+xe3s2wkfYQf6Iq6gu+Ve6W/tScGKW
         CjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WCQSbmDiSp2TikX+81KkfW5KaWUZgpU/q4zGiCgAHT8=;
        b=BaF+iFcRWPcnASHjgRlCtUJAxQtgQnD2MjMTCHTEokYOLSy+Xs1fUh9DOX6BMXaXtD
         TCTyIzG+QZ8Q7iIxwaAkZiDyO957HxuBp1bI/wxg9Ty19FS0DX/ZZUMxXhZ4/MvsrrMi
         d8G52HlHZYph/bqILBAKbjq5d9VVEYA5VIzUP8u2IXgfRwjm/IO1qvU2byRPflNaJGVH
         OynPQbNRLa16Inlf8V2dFQFBN4G9x7ZFGd5Y97FYw3mUyIZioqylL6o/nhIF+B1pwkkA
         1QVmlRw2cD321ueRzN45eHziCqb+eoppCS7h2xYvwZLn/8q7xo0Y04RS6lw+hOcHn+mr
         lbHw==
X-Gm-Message-State: AGRZ1gJMU0JQ9+8YwEQbQttcr3w9Yl3+IhlnY5+mdvwrqun9e9+0tSVP
        ooFX/Z5GY4D4PKlGh31YVj86JOaBX3dLNqL9XoCwcA==
X-Google-Smtp-Source: AJdET5e+eWEA4Z0bEnv8KWhV+jX2Y7Cn+1Sr3vKSEjxzNoQkT7Hp0FkJWKmf/gof7t6PGSEvmMUWjeLBuwJ/XpaowiA=
X-Received: by 2002:a9d:4a5c:: with SMTP id d28mr1813095otj.38.1540571417587;
 Fri, 26 Oct 2018 09:30:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 09:30:17
 -0700 (PDT)
In-Reply-To: <20181026154617.GA23663@linux.intel.com>
References: <09986c98c9655f1542768ecfda644ac821e67a57.1540369608.git.jsteckli@amazon.de>
 <558fea0b4df498eefcaea5ae07a089ad9706c1a2.1540369608.git.jsteckli@amazon.de> <20181026154617.GA23663@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 26 Oct 2018 09:30:17 -0700
Message-ID: <CALMp9eTtB1te3kyHxZjm244BwdVKrVrjOTgiLufQFwD8Y2g_LQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] kvm, vmx: move register clearing out of assembly path
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, js@alien8.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 8:46 AM, Sean Christopherson
<sean.j.christopherson@intel.com> wrote:

> Since clearing the GPRs exists to mitigate speculation junk, I think
> we should keep the explicit XOR zeroing instead of deferring to the
> compiler.  Explicit XORs will ensure the resulting assembly is the
> same regardless of compiler, version, target arch, etc..., whereas the
> compiler could theoretically use different zeroing methods[1], e.g. on
> my system it generates "mov r32,r32" for EBX, ESI and EDI (loading
> from EAX after EAX is zeroed).
>
> And FWIW, I find the original code to be more readable since all GRPs
> are zeroed with the same method.

I concur. I really do prefer the explicit xors to the input arguments.
