Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D57B9C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CDE20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYe6r53V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CDE20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934820AbeFLXk0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:40:26 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33914 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934638AbeFLXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:40:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id g20-v6so389457plq.1;
        Tue, 12 Jun 2018 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wx5bqxl3F2zZMG1fSZT89cS7G5QnB6OBLzRhnuuJjik=;
        b=eYe6r53VWBDbqijlaihsuJWNvYQoN+YUabjZrmId3b6L0NkqzNSv9WrBV5TtSHVHXC
         cw7MhsC005mLVmPOL1nQ9CQ3iW9fVBF0Cak7Zq7ODS6XPTtdWmWaYKN8ByLEErDRJI1F
         cW23AOcqyWcebe5qT7AySK8knRrONY1Lgpg6HSeDxHl+A54/ms8Ne+SRffLnkPz9f3hw
         K7JVeymZUcDsXk+2YhkRPcpA+YRttKezrt6LbO2pHyqq24eLZtUVkDGKUwUCLRKaCGJq
         vg6yGi5N+igkq5tvGLBp+mILMX0SJP9gQjtlv/cKFlYbZET4+8/K06K5Wf8CChk9wZx2
         Gkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wx5bqxl3F2zZMG1fSZT89cS7G5QnB6OBLzRhnuuJjik=;
        b=aMyP1aUn1w4Cypnaq2nj8NW7GID5chbKfvOmuL+CTnr46xzl5ehAIb+3e+Zb0pjmv4
         wYM4DPH4zq+xHqzcUCoTOIH0J8Cf1CwsW5pedXzhdInG42BcPLHpA2sJgX2vC8Sw+kwy
         i3iLsdFeNW5wCL1ZQyxRYxbGPqsUVB6cKgbKoQp1hLENCfVYGvgopGB6DMxHx7ICQJJE
         MwSrE79ZX5I5E1dW9oeWupvBet1OWsArF6tWrGNGmrCwPvusFhFGDw5/OZgQSpi8roPr
         2b7ex1Kqq2PMgQ6dn+5JkmXROkQoVQxjOWJuhVU1iRANfm+4YbXYhYtG2CuaV2VndB5/
         +6YQ==
X-Gm-Message-State: APt69E0Wfv6zNsLa6ZO/TzIzwDLM7VQuIUA7ETbuSkboMEXyyPqoCDVo
        qbZcTtdMWKjjJRBchbrJYdg=
X-Google-Smtp-Source: ADUXVKIuTilOgz8prW/SAoAdEvORwCymVMlH4buGeeh+yNApOyBaoaxwt/zKxQiFLVC6ibW3mMlqiw==
X-Received: by 2002:a17:902:1347:: with SMTP id r7-v6mr2618297ple.62.1528846824060;
        Tue, 12 Jun 2018 16:40:24 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id n72-v6sm1922170pfj.68.2018.06.12.16.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:40:22 -0700 (PDT)
Date:   Tue, 12 Jun 2018 16:40:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, lyan@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol
 definitions in Xen
Message-ID: <20180612234020.GI38773@dtor-ws>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-2-andr2000@gmail.com>
 <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:46:10PM +0200, Juergen Gross wrote:
> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
> > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > 
> > This is the sync up with the canonical definitions of the input,
> > sound and display protocols in Xen.
> > 
> > Changes to kbdif:
> > 1. Add missing string constants for {feature|request}-raw-pointer
> >    to align with the rest of the interface file.
> > 
> > 2. Add new XenStore feature fields, so it is possible to individually
> >    control set of exposed virtual devices for each guest OS:
> >      - set feature-disable-keyboard to 1 if no keyboard device needs
> >        to be created
> >      - set feature-disable-pointer to 1 if no pointer device needs
> >        to be created
> > 
> > 3. Move multi-touch device parameters to backend nodes: these are
> >     described as a part of frontend's XenBus configuration nodes
> >     while they belong to backend's configuration. Fix this by moving
> >     the parameters to the proper section.
> > 
> > Unique-id field:
> > 1. Add unique-id XenBus entry for virtual input and display.
> > 
> > 2. Change type of unique-id field to string for sndif to align with
> > display and input protocols.
> > 
> > Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> I'm fine with this patch being added via the input tree with the other
> patches. In case I should take it via the Xen tree, please send me a
> note.

Juergen,

I created an immutable branch off v4.17 with these 3 patches in case you
would want to merge them into your tree without waiting for them to
appear in mainline:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/4.17-xen-kbdfront-runtime-config

Thanks.

-- 
Dmitry
