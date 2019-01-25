Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A5C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66112184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 00:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnzBcq7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfAYAEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:04:15 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41154 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfAYAEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 19:04:15 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so4454851qkj.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 16:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=irrrj1aIRm1Xathl7FhqoMhu6j8f0JSUgmySPpo0TJk=;
        b=TnzBcq7B9dj4hDWYhAdrx715udUh48w0TME8rdoDnyJg7e/O66OZ/uqb+2A1+FYq+7
         AAxxvrbaNhm6p9N7PDL8sH+IQDZDjqCIrZzbR0JxSjMAtPqp1VnDGsp+BEMFstBcm553
         KuLyNdGijyGwGxTzRiibJk8FbJzllRZXNOltaoQFIb7wAPL91TjdZPlb4yrrJ+wR9e+o
         PVDjB1d7mKVlHY+zu38jUJlTX1uAT2uM3N5ySWTYv8FT7SrrGbti1MET9ytPZKR4sEDM
         c3DofTr+n2IJUQpDyBUYvF/I7Ach8Kb/S5FFaXJXxGWX1aRCfmNHjNQvorNFvPg32ByO
         soKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=irrrj1aIRm1Xathl7FhqoMhu6j8f0JSUgmySPpo0TJk=;
        b=qZ1EnheYltRapA0cj4X3gS0DbyY4jb5ZFw/P2FQy4yDktPi+YETRpUpo8NuSNXgiZ8
         zZGsLrRmYuioNoRDcvR4XH38FiF5O9igbmtnmuDPy4mF24FVB8x+azue4/e0yAxk2v1d
         CNYKj2q0vAKBITXeOB6haZdP0I/HBUqRalRCDWx4dfo/6LdCWg8Lgt1eOCJFFXmwCjjp
         31I+7RlIeSNH+VenKuQCkOYjBvExGPtDJnQUib7/RnxDeixcf47CjjbgpFmLFuy5Uc+p
         MQMhpyWevsT4vfQ7aPYB311XAqk/2yGsJN7Usy7A+UMVXJXgwhUhi1DbjVYarVm+ib6i
         ZkZw==
X-Gm-Message-State: AJcUukd8gX9iazyquKoJTZbTWUuPGNOgLF9ogmr8eYrNTCsdHklkYJgG
        Hu+42C9JUGrx00nToLTQr+8=
X-Google-Smtp-Source: ALg8bN7F1X0jZrlK49XHVFQiN5j5GBjQLRNlGbXa8EFtP6jrRoxRo77yWgZNrRz1pJlMMTLHd5suuw==
X-Received: by 2002:a05:620a:9:: with SMTP id j9mr7795813qki.144.1548374654125;
        Thu, 24 Jan 2019 16:04:14 -0800 (PST)
Received: from oc6857751186.ibm.com (c-24-20-82-131.hsd1.or.comcast.net. [24.20.82.131])
        by smtp.gmail.com with ESMTPSA id g25sm51998796qki.29.2019.01.24.16.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 16:04:13 -0800 (PST)
Subject: Re: [RFC 1/6] powerpc:/drc Define interface to acquire arch-specific
 drc info
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Juliet Kim <minkim@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
 <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com>
From:   Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <e7030879-59e4-88fd-3785-fdd98b7f0a3b@gmail.com>
Date:   Thu, 24 Jan 2019 16:04:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181214204957.16435.29255.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/2018 12:50 PM, Michael Bringmann wrote:
> Define interface to acquire arch-specific drc info to match against
> hotpluggable devices.  The current implementation exposes several
> pseries-specific dynamic memory properties in generic kernel code.
> This patch set provides an interface to pull that code out of the
> generic kernel.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
>  include/linux/topology.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/topology.h b/include/linux/topology.h
> index cb0775e..df97f5f 100644
> --- a/include/linux/topology.h
> +++ b/include/linux/topology.h
> @@ -44,6 +44,15 @@

As far as I know pseries is the only platform that uses DR connectors, and I
highly doubt that any other powerpc platform or arch ever will. So, I'm not sure
that this is really generic enough to belong in topology.h. If anything I would
suggest putting this in an include in arch/powerpc/include/ named something like
drcinfo.h or pseries-drc.h. That will make it visible to modules like rpaphp
that want/need to use this functionality.

-Tyrel

>  
>  int arch_update_cpu_topology(void);
>  
> +int arch_find_drc_match(struct device_node *dn,
> +			bool (*usercb)(struct device_node *dn,
> +				u32 drc_index, char *drc_name,
> +				char *drc_type, u32 drc_power_domain,
> +				void *data),
> +			char *opt_drc_type, char *opt_drc_name,
> +			bool match_drc_index, bool ck_php_type,
> +			void *data);
> +
>  /* Conform to ACPI 2.0 SLIT distance definitions */
>  #define LOCAL_DISTANCE		10
>  #define REMOTE_DISTANCE		20
> 

