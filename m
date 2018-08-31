Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460E920839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 02:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+riTWyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460E920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeHaGzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 02:55:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39934 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHaGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 02:55:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id g20-v6so4773096pgv.6;
        Thu, 30 Aug 2018 19:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zsM5j2ufHx7/h1XRWzM/NvzClxi5fvbax06qtEyqvF8=;
        b=G+riTWyVE2Y6OEdmfjFr5WdsKDNhPRID1/CW5YnMOgs5EL4+WjWt4Cy/c9lAs3apa9
         uucyWhJpRlTQO3oQngrgrnTEDAVMEezbDfUBoIHnYqrSRBxPW5WxemRDI88tomvPofe7
         IiMETaMBmCzKJ5d8kjN+ChriIdoBfNKM+wGnlG9aa4220/f1j2KP4O3uazeDqtfQ9FKS
         dPC5pyyjx1bNZtQjoDSpo3D/Zj5YMblkwnvarIs2+vcrZN9BLV5VEQ/UvtNOnQjeLpYY
         47yw7NldiDilsvjvVD1/MJOGOHewkIbD1GgPBx3mol/QVJ9NKRg2hFFwkk36UrOPDvqR
         eEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zsM5j2ufHx7/h1XRWzM/NvzClxi5fvbax06qtEyqvF8=;
        b=dfO3szphDOkRaClxprA1kzlxk8vwYgHqF73/TIoMJOlWzsr1B1FNdBdugy+55gDGvg
         LChidq0l/hZqpaB9r4nbJr2wa5zj0fYvr+bDLS/eSMY0AQjNIfea79htpe/cKk4keoKV
         BPhVLILLmFLb6Z74uqMGZlr37VRivBPcUHSagM3Uc8rwQvK5A+jHiOlM3ZCOg8YB+05c
         ZMai+zFxcgNrlbx1sKWAyA34KtxFAIl0bBlrs/Sd5z682KsdxZgr0t6MCcRcfEAyHqpK
         QeIUjOWJu0IcVBdj8NJZjliyBxr1cwVwfgc0YzAlkF7jwGQlmbR8/dFu3XNkM9WKnm80
         m4HQ==
X-Gm-Message-State: APzg51CsEoWqu4M7b8y1pV6ApsPj/vj1l60HR7rl06HJhiaAIpcHOxK2
        k3kpnaLGaln/NTWXAd5KuYc=
X-Google-Smtp-Source: ANB0VdYzRSTXrId+MTE4PV3JIEtTlkjUNzNdG5dARDOfH5v7s/fr5PI6j6EPXmc+sgy0jXUKv77Ouw==
X-Received: by 2002:a62:1f11:: with SMTP id f17-v6mr13474626pff.168.1535683818435;
        Thu, 30 Aug 2018 19:50:18 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::4:be0a])
        by smtp.gmail.com with ESMTPSA id s75-v6sm15817262pfd.108.2018.08.30.19.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 19:50:17 -0700 (PDT)
Date:   Thu, 30 Aug 2018 19:50:15 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Cc:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][net-next] xdp: remove redundant variable 'headroom'
Message-ID: <20180831025013.yiukmlw6o7gedevg@ast-mbp>
References: <20180830142718.10850-1-colin.king@canonical.com>
 <ec579a7c-345b-f462-95ac-f36de1072614@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec579a7c-345b-f462-95ac-f36de1072614@intel.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:37:50PM +0200, Björn Töpel wrote:
> On 2018-08-30 16:27, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Variable 'headroom' is being assigned but is never used hence it is
> > redundant and can be removed.
> > 
> > Cleans up clang warning:
> > variable ‘headroom’ set but not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >   net/core/xdp.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 654dbb19707e..4b2b194f4f1f 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -412,7 +412,7 @@ EXPORT_SYMBOL_GPL(xdp_attachment_setup);
> >   struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
> >   {
> > -	unsigned int metasize, headroom, totsize;
> > +	unsigned int metasize, totsize;
> >   	void *addr, *data_to_copy;
> >   	struct xdp_frame *xdpf;
> >   	struct page *page;
> > @@ -420,7 +420,6 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
> >   	/* Clone into a MEM_TYPE_PAGE_ORDER0 xdp_frame. */
> >   	metasize = xdp_data_meta_unsupported(xdp) ? 0 :
> >   		   xdp->data - xdp->data_meta;
> > -	headroom = xdp->data - xdp->data_hard_start;
> >   	totsize = xdp->data_end - xdp->data + metasize;
> >   	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
> > 
> 
> This should go via bpf-next. Thanks for the fix!
> 
> Acked-by: Björn Töpel <bjorn.topel@intel.com>

Applied, Thanks

