Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87E2217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo4DvkGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeLRWMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:12:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36781 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeLRWMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:12:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so8450767pgm.3;
        Tue, 18 Dec 2018 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JIj3M8SNGQRlpevrl1+kVXlEdHvhCX3P2AyVC9zWMM0=;
        b=jo4DvkGZe2Z8d5wVq504p8xdWIZkMeyWvHoJl/06kNQ544pJ1rDnC5VqqLh9MW5JJI
         CDjzfHDs552y4pEP6mQnlhS1xboc8ZiQ911eBTizKQlm1b+54vqOyRISLCbGWWh9bdeK
         gj5ZdFAwGv3Qve0UjpWjVdur4b0wC7afdJJeBOHTUAmbmDNreiAYyob3bfaS6pQclUnp
         3ZDuVFH8LWnOnY3gxa+VCu8ZgyJdPQTLEq7ZCCuPRAofWy7s11JOvU5bBXxay/2BvIe4
         648O/Qt9EcGG3rNwbrih6ayjJo69br0XkVJ6PCfXHz/zLYG58K62oAQAhCluhoLBOTvP
         5ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JIj3M8SNGQRlpevrl1+kVXlEdHvhCX3P2AyVC9zWMM0=;
        b=AdfAF8D8y9T3KcOsDe43jlgdwMYVm8tYJ5cOokG9I26fPVeTBc51b7v4IeNnueg+Cw
         Z8WUvuVSjgefY9JxcHEsYI4tcR9dwpgL0BeIOJZrIiluh6HDjyT/a6/GFaYz8zJ+EAkj
         vn3aQyik0+okhJ/EeB5n1o3lyy+KVaIWkCRfqK+9R3A+8PPBfmV+p3+nyR2cKf7H6opW
         x5igEjszmmWctuQVxTG0MuLNBuwJh/GSbRIXJ4L2Poecc1O9n5zf8h8gwa9ya3fQIjLG
         eAMVymHI19DY8ZWCPHisXEOcU2ZYb6VEJhBHfyUrBaSygICazTortVtXTmmZl2m26H86
         BNug==
X-Gm-Message-State: AA+aEWabL9t0DeYHT5un5tVWQhXIHWY/U/sBW/L/q2rxVInHm+AHcEUX
        7Dzir2iZtIEtnOylOx9SlZc=
X-Google-Smtp-Source: AFSGD/W6jasTdbj+Uw4FZ+H7cWVEjQu2XWRZ0boNF+uETD76o2V4sGrQO3OQ0VOCboQf2SHIKivPew==
X-Received: by 2002:a62:dbc2:: with SMTP id f185mr18058694pfg.235.1545171173232;
        Tue, 18 Dec 2018 14:12:53 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::7:6828])
        by smtp.gmail.com with ESMTPSA id q187sm28272072pfq.128.2018.12.18.14.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 14:12:52 -0800 (PST)
Date:   Tue, 18 Dec 2018 14:12:51 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matt Mullins <mmullins@fb.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        kernel-team@fb.com, Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: support raw tracepoints in modules
Message-ID: <20181218221249.d4jpktn2wezyyyc2@ast-mbp>
References: <20181213004237.3888568-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213004237.3888568-1-mmullins@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:42:37PM -0800, Matt Mullins wrote:
> Distributions build drivers as modules, including network and filesystem
> drivers which export numerous tracepoints.  This enables
> bpf(BPF_RAW_TRACEPOINT_OPEN) to attach to those tracepoints.
> 
> Signed-off-by: Matt Mullins <mmullins@fb.com>
> ---
> v1->v2:
>   * avoid taking the mutex in bpf_event_notify when op is neither COMING nor
>     GOING.
>   * check that kzalloc actually succeeded

Applied, Thanks

