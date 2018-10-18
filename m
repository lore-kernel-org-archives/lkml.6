Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A59EC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D5A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D5A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeJSBL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:11:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41564 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeJSBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:11:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id c32so30500261otb.8;
        Thu, 18 Oct 2018 10:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HXcWGVzkOfaVHlss2GLVKMCrtIPoMyYNFPKDV+16whQ=;
        b=AcPoc8Qy+Ht/492PPBg0muOjLkB+EjOKE2RVlMX5Ot0zpTzbb7tY2/88mitPtekug8
         wnpZZLRYEp/jQUwt/B3kEAPTlQVjYoTgQBO5GirCjUauqdzMOZOtaVmGdRe8Jfh3kIKc
         GkmHPk69efDjYdx+sCEta5f9oXwYZIzS/rc2vsmkRl2uzEs3t9JZPchjlkebrzEGD1An
         5/WIdySkDTC+gr0T1JZEkwV3LBs6YixZkTc8ahRtXozeCfe52iQg2J3tO1uzBxbPVmBN
         ySNVea0xga8GK2ratrAFxtj3vXeM8pe+XL2l9g+na80pxAWqG+AOzolfb/sAy6LM/ivN
         3gMA==
X-Gm-Message-State: ABuFfogr+enlI197BguOD00WzujtnJMDGj4sqU8XgrAVltpb7Bxbw/lM
        +4ERLozVFUidjM/zXCnI3wRhv7A=
X-Google-Smtp-Source: ACcGV604rMfo3OfFb/7pa7GuBL6T7JBbycfNuE1EBytvF7LFox1KN+GieJOMROEZqKdpbXic1gms3w==
X-Received: by 2002:a9d:2014:: with SMTP id n20mr20468462ota.308.1539882572821;
        Thu, 18 Oct 2018 10:09:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u123-v6sm7422757oie.22.2018.10.18.10.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 10:09:31 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:09:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v4 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Message-ID: <20181018170931.GC15557@bogus>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539657458-24401-5-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 07:37:24PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> "of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
> added a missing of_node_get() to __of_attach_node_sysfs().  This
> results in a refcount imbalance for nodes attached with
> dlpar_attach_node().  The calling sequence from dlpar_attach_node()
> to __of_attach_node_sysfs() is:
> 
>    dlpar_attach_node()
>       of_attach_node()
>          __of_attach_node_sysfs()

IIRC, there's a long standing item in the todo (Grant's) to convert the 
open coded dlpar code. Maybe you want to do that first?

> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> ***** UNTESTED.  I need people with the affected PowerPC systems
> *****            (systems that dynamically allocate and deallocate
> *****            devicetree nodes) to test this patch.

Can't we write a test case that does the same thing?

> 
>  arch/powerpc/platforms/pseries/dlpar.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index a0b20c03f078..e3010b14aea5 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
>  	if (rc)
>  		return rc;
>  
> +	of_node_put(dn);
> +
>  	return 0;
>  }
>  
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
