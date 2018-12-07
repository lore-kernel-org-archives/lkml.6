Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273DCC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED6820882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0gqT+Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED6820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeLGJkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:40:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33217 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeLGJkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:40:24 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so3199408eds.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7M378AnH1U4XShbMr3Ac39wbBDDi3n07ADyOSds9Ju8=;
        b=j0gqT+ArMztTtfy2OsH0My3mvUb5fCCJYl2f57c7TESIG7Vq9JwE70MBSrXpGxlBF4
         XkVcCqVskHL+CD2MCPN3X4N+ZqcXjq9bkWrKi5nzWdRqzJWx45f4OUOXOcMw3nxhJmGW
         vjPvsPOEVHDfh3x3l96fu8Zdlyg3TwAsGKevrwLAqCL+rQbVnkSZj0eUiZNXHjomL9Xx
         ERPCW8mjjrwDwc23/kN+1NoY0/tp+2ye4knJm54ZWuE0/nFcLf+nwDKEGD+obp4gP5k+
         ntOoCU+CHYsvWJwPipQLi9id1xOO4cENlINwuhwc6zDw7y2j6ItUWNIw8BAsvZiD8xSi
         RKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7M378AnH1U4XShbMr3Ac39wbBDDi3n07ADyOSds9Ju8=;
        b=KHj6/1bCHnYIm+DQAzOjisWpgdJeXeNwvym+UQVR0HiIIPpl7sOP08K4bwGM7ijAZL
         MpssRMjYZw6NNgzyqpRhVZ9h/SUXMW3cvTSppnh+vWSs2Laws/Q/BIi7TD3p5b68idiD
         m7lKXg14wTQi4Eio39X/a/o88wKM+vexvCHXDc4sumGLXmfUZAtDqpiBXfGPdoUYiyrV
         VBhYOGAAfxV7ma/tKAQbML+hXvJbAyMgPZ8da/rWuQgDsQH1VQdG+Vw47ayMrYJnUApN
         MVcKdYha2uXHS2w1yH/uJSoojpPAR7AE+pcch7yKp1ehauBWIrmGkP0cGrUOb17G+6Q1
         Vcag==
X-Gm-Message-State: AA+aEWaQI+GAbLNb37rqovpQ+Y40j2X+0XGcIQ2NZvcf/D2EEL+juwiJ
        Oevtio6HtlRdmvDakqM54ETALdrS3VwLhX3TuvCRK60=
X-Google-Smtp-Source: AFSGD/XFS3NFCR1guiYCPQK59vjDUVKtzhY8N8I+DHgFgyrGpdvQeEgaEbWC3joenzr89hLjbgwnA0l4ptBQ3ex0z+E=
X-Received: by 2002:a17:906:838e:: with SMTP id p14-v6mr1403121ejx.94.1544175622027;
 Fri, 07 Dec 2018 01:40:22 -0800 (PST)
MIME-Version: 1.0
References: <CAFgQCTuyKBZdwWG=fOECE6J8DbZJsErJOyXTrLT0Kog3ec7vhw@mail.gmail.com>
 <20181205092148.GA1286@dhcp22.suse.cz> <CAFgQCTtj4m637tAzConCfeWQXSrWeNY-DLD5=f9-ZSmJMRe31Q@mail.gmail.com>
 <186b1804-3b1e-340e-f73b-f3c7e69649f5@suse.cz> <CAFgQCTv5-jeqwRVkJuDHvv0vq6uCzfdV2ZmVAU3eUzn2w2ReEQ@mail.gmail.com>
 <20181206082806.GB1286@dhcp22.suse.cz> <CAFgQCTsMdQSRFruZRGBuo30TjfiQ=sbrf9kUJAGgwN6uw+LsBw@mail.gmail.com>
 <CAFgQCTv7ADVW3WvB0tuqpL1U2MFGADA113MUm6ZmVcgvqyBfTA@mail.gmail.com>
 <20181206121152.GH1286@dhcp22.suse.cz> <CAFgQCTuqn32_pZrLBDNvC_0Aepv2F7KF7rk2nAbxmYF45KfT2w@mail.gmail.com>
 <20181207075322.GS1286@dhcp22.suse.cz>
In-Reply-To: <20181207075322.GS1286@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 7 Dec 2018 17:40:09 +0800
Message-ID: <CAFgQCTsFBUcOE9UKQ2vz=hg2FWp_QurZMQmJZ2wYLBqXkFHKHQ@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node offline
To:     mhocko@kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 3:53 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 07-12-18 10:56:51, Pingfan Liu wrote:
> [...]
> > In a short word, the fix method should consider about the two factors:
> > semantic of online-node and the effect on all archs
>
> I am pretty sure there is a lot of room for unification in this area.
> Nevertheless I strongly believe the bug should be fixed firs with the
> simplest way and all the cleanup should be done on top.
>
> Do I get it right that the diff worked for you and I can prepare a full
> patch?
>
Sure, I am glad to test you new patch.

Thanks,
Pingfan
