Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ABFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCEE214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjS9RBKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbeLQVA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:00:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54781 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeLQVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:00:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so581781wmh.4;
        Mon, 17 Dec 2018 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2iR26Anw0q/Shd7x+GZem69iVYECTkyxd8cvDGhgOiw=;
        b=UjS9RBKVLloqWRlzBEo8d6tbaX7Jw0fqea2bQ71kJBGWx76KyD68wR1VTwK4WajJPU
         sb5rYniFY732Mr8vq6FqLzEVSPxVzpoSdP69R06jDGUPUC1p/o2MBg/ynQ4OLFUK+rdQ
         gn8jBPqkSt3OnbQIUm4ggz6BrccbVfrXIDDk/PKWS3wZkYCpBO4nRgIBXQ0aREj6xbbk
         N3TbSuK2FAnEG8QQIYD8qPBKdkkmKVakeMrp34HF8H4zfLmRTzEHCbyP0S15NDZglZP7
         DIJMNUSymlOalHEa8PC8T+TBij/Sz5cyzNgIrZAYcGr/oHOMOvbbuwYVZVq+TuSUYg24
         fWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2iR26Anw0q/Shd7x+GZem69iVYECTkyxd8cvDGhgOiw=;
        b=XkS+OViAKmrAPFxXR2kc/V/sSEt8ej+eC+ZpNLpkFsGzJCHN/35lTBJKWuMWX1NJJH
         Zba3iT7MAYl6o0SeFXcezFnegCrvgS9HOz2Dgfn5h/LkLLcwpHpLtHdIHxbuqwPf1CDr
         e+qmi94OglC/EK+nxige8m/T3ip9xsi4FzFni9B0l/lx9LB369wpP4iwMDX2PVB31y9j
         nb5dnNHgOsGX+/dBVGDouXpm4uur1kVbKqgNh/Lt6jTDFtwBdY6yQt966hOTQgOsTVMA
         7z/3Y7EvcPVmBIL1Mc476C0F+JQ0mWTtCRJgGi88jy7TuzpPTS+F+MrA88LwAaF0GQ8d
         3aEQ==
X-Gm-Message-State: AA+aEWZwJsuGIH8Ea0sYXcswZ3VJ0kg3ftki+xF/wDqHIyxx9P+oOnFq
        wsBtUv2jrU0H62chlQHAWw==
X-Google-Smtp-Source: AFSGD/VJUlBRgfomCLATf6fWn80I/5+t9FC3HmsrdYEWecEMB3e6CYQUzUmqyUPe23XKWOYM90yXyQ==
X-Received: by 2002:a1c:f0e:: with SMTP id 14mr568281wmp.37.1545080424277;
        Mon, 17 Dec 2018 13:00:24 -0800 (PST)
Received: from kmo-pixel (p200300EE3F16D700DA69292E3BFD6CE4.dip0.t-ipconnect.de. [2003:ee:3f16:d700:da69:292e:3bfd:6ce4])
        by smtp.gmail.com with ESMTPSA id l197sm573743wma.44.2018.12.17.13.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:00:23 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:00:21 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: Re: [PATCH 6/7] sctp: Convert to genradix
Message-ID: <20181217210021.GA7144@kmo-pixel>
References: <20181217131929.11727-1-kent.overstreet@gmail.com>
 <20181217131929.11727-7-kent.overstreet@gmail.com>
 <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217125001.8e89ac2565417d55ef7a624e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:50:01PM -0800, Andrew Morton wrote:
> On Mon, 17 Dec 2018 08:19:28 -0500 Kent Overstreet <kent.overstreet@gmail.com> wrote:
> 
> > @@ -535,9 +470,6 @@ int sctp_send_add_streams(struct sctp_association *asoc,
> >  		goto out;
> >  	}
> >  
> > -	stream->incnt = incnt;
> > -	stream->outcnt = outcnt;
> > -
> >  	asoc->strreset_outstanding = !!out + !!in;
> >  
> 
> I'm seeing a reject here for some reason.  Using todays's linux-next,
> but there are no changes against net/sctp/stream.c in -next.  The
> assignment to stream->incnt has disappeared.  I did this:
> 
> @@ -535,8 +470,6 @@ int sctp_send_add_streams(struct sctp_as
>  		goto out;
>  	}
>  
> -	stream->outcnt = outcnt;
> -
>  	asoc->strreset_outstanding = !!out + !!in;
>  
>  out:
> 
> 
> We're at 4.20-rc7 and this series is rather large.  I'll merge them all
> to see what happens, but I don't think it's 4.21-rc1 material?

Yeah, agreed. Thanks!
