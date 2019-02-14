Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04630C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACBA222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lW/TD5Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403759AbfBNPNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:13:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34632 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfBNPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:13:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id w4so7237559qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4/GGCh4RZlMR5SyrWkdWvTYyG9EGbSLw30UaI3s48Gw=;
        b=lW/TD5SiJ9kJpXT/G2j5K0FqWbz78OFofgMl+mpxgFXxoNFdSyIlv22LpHBpki44c0
         /yvrStrSx2cIMKr7Ej1Ub87plGyRMt17wPbSLMT1hJq68lnmIkanEv3k/eqPHmtLQ1FT
         FrJ4i0nNBhA8zh+ByZgNgyCUrIzSFk9RZjruQ0P4Ha9d9uM+VSLBfRCdIoGtjOPYliAQ
         ZtuoykbfSQW3Ou+RVcvVHN65MXTt12/QBEPCu+eiuc6SXJhd+RNO3jAcsNlUfoxDsP93
         tsnSjXQck92lbQwQ/CU6LYRqjwoXTPbNtoMlF/o+lgfyIAPgBuKYz3+NHTE2BUtIoIIA
         MoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4/GGCh4RZlMR5SyrWkdWvTYyG9EGbSLw30UaI3s48Gw=;
        b=dUxCYU3bm9oySx0EaBIrJDrSz4KpDMK9ZQnov3dmIU4wMPheKeL1vGaC22H8ds4BdK
         JPXfwLU+gEldp+Pn1KbgiFqgoKVoXWrJV8uk0gP5O+8ujBMf2+6mqOM8vKFdY+Mo7ILp
         O899uus4siJJq1O10b7d5dZI8WHnuR4e+M1+7KYByeJUlsmx5bZHf09mRjnOiksRslA/
         kTAoayk5U1aGtmKBFuNHgpDTaCaYRwipszslACJ0ZVaMG3hEXyv71ZXtinS65vrDUpJY
         pbjwDB8Ub6jZrLm3JNMPY7Bz71oiTiOjWNTZzmgio+b1FZ18XtUyrDRtepTh/UB6oKkl
         eHYQ==
X-Gm-Message-State: AHQUAuaDr4NpdptmJ34qhEehbNzWR4kDm1q3dkAjKHvNVI2KT/S/esdv
        t/vQYn0UaWefw20dulbX1/9MSPtunSpYrZ+Nn0CQjQ==
X-Google-Smtp-Source: AHgI3Ianxjt1jd3gCKX/FHO3PYDB8ZOBLHofgMPWyQQoUqus1FMx40iQC/kEexHDb88Q95tbUu5n9l167HgYoLJyMWg=
X-Received: by 2002:ac8:23a6:: with SMTP id q35mr3487933qtq.322.1550157183554;
 Thu, 14 Feb 2019 07:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20190214150130.3162-1-quentin.perret@arm.com>
In-Reply-To: <20190214150130.3162-1-quentin.perret@arm.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 14 Feb 2019 10:12:52 -0500
Message-ID: <CAJWu+oq=Jrh4wUE=v_ihsHUiDZPzDzv1L57qmiRypZWaD60fmg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix number of entries in trace header
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:01 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> The following commit
>
>   441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
>
> removed the call to print_event_info() from print_func_help_header_irq()
> which results in the ftrace header not reporting the number of entries
> written in the buffer. As this wasn't the original intent of the patch,
> re-introduce the call to print_event_info() to restore the orginal
> behaviour.

Needs a "Fixes:" tag, and a CC to stable.

Acked-by: Joel Fernandes <joelaf@google.com>

Thanks a lot Quentin!

 - Joel
