Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B34DECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F7A21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="XFtz6rek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F7A21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeIUG1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:27:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46059 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUG1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:27:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id t70-v6so398835pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW4UWCO2GVT8n20Jg/HY/PgpXg61cH9knszH6dzr9tc=;
        b=XFtz6rekOskTPYIbAjPEdF1y3AcLMHZX+EjSr1+gkEO9x5+cT5AdGYNqalLj61/RUv
         scO41c3dNhbsFvoY8j/wdGTqtysNA46J2maGbA3lhDSiQzBpqFDnpcgel7KDXDMddCqU
         jqFvu7I286Z0jSzol+lp3JRlyn1ibKB+UgPZYVcHjEEW2roV1Z0V/WGyLl11yabVd8fj
         8rpumW8IaY58X76HgvVXyJ7KchDG0m6jnBoYUtj3GpRoREWsxF5EqnudnAku4bLljWZt
         QGbFBBQPahm3tR3h9GP3USUHnxiB97n+WThJ1mAur2/Spe9ZkzWc0ao5coBfLRE0GzQL
         IxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW4UWCO2GVT8n20Jg/HY/PgpXg61cH9knszH6dzr9tc=;
        b=rst5Jag7A2vCMYEYlXe6ggth4AtTD18TzOFmIhS/Rz+KhrCKTEm40wPJIytrrapeER
         edDxyfgFjaqqFrGOArxNyT39jtOwCdDqbhKbkAkZGCXYfEabMJSgQYOQP65qiIP8eCoG
         LEOJuN+HVACQGOUdPPDx0bhD3y3IK8ZdSbscP4nubWkuN6zTtaH2fa5qr7yEaAFVUFum
         iCtTi4jSZNUHMevWo1vqw2p83bFj9sLwg4FTQqzHtKw70X/mEE+pXip53+h4XI1CcGW6
         9fRu9Ll4PqdBxTpraFxGwEytyAzwpxMUG5w6JLf9W4V0uwijsbgTPVEHPylAlGhYECBD
         Gz/A==
X-Gm-Message-State: APzg51CjKRm6a3tR8DoRsjxULlMuPXbyT8+rOx/9FXmHLorS+C0Zi4ae
        1Htn3WgV6lRb9/DUuJCInC+5KQ==
X-Google-Smtp-Source: ANB0VdZ92yl1Mgnt+QVJv2WKstQ0APXwYCG61Lro1UYPRRX7fYGI8TLL0Hp93B4WW821nv6yeVx6Eg==
X-Received: by 2002:a63:f941:: with SMTP id q1-v6mr8868932pgk.213.1537490490536;
        Thu, 20 Sep 2018 17:41:30 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id m20-v6sm54710432pfg.61.2018.09.20.17.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 17:41:30 -0700 (PDT)
Date:   Thu, 20 Sep 2018 17:41:23 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH net-next, 1/3] hv_netvsc: Add support for LRO/RSC in the
 vSwitch
Message-ID: <20180920174123.3b86623a@xeon-e3>
In-Reply-To: <BN6PR21MB01614DCE1099980A7B1286FFCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <20180920170701.9574-1-haiyangz@linuxonhyperv.com>
        <20180920170701.9574-2-haiyangz@linuxonhyperv.com>
        <20180920134725.3e149a0b@xeon-e3>
        <BN6PR21MB01614DCE1099980A7B1286FFCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2018 20:56:46 +0000
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Thursday, September 20, 2018 4:48 PM
> > To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> > netdev@vger.kernel.org; olaf@aepfle.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; vkuznets <vkuznets@redhat.com>
> > Subject: Re: [PATCH net-next, 1/3] hv_netvsc: Add support for LRO/RSC in the
> > vSwitch
> > 
> > On Thu, 20 Sep 2018 17:06:59 +0000
> > Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:
> >   
> > > +static inline void rsc_add_data
> > > +	(struct netvsc_channel *nvchan,
> > > +	 const struct ndis_pkt_8021q_info *vlan,
> > > +	 const struct ndis_tcp_ip_checksum_info *csum_info,
> > > +	 void *data, u32 len)
> > > +{  
> > 
> > Could this be changed to look more like a function and skip the inline.
> > The compiler will end up inlining it anyway.
> > 
> > static void rsc_add_data(struct netvsc_channel *nvchan,  
> 
> How about this?
> static inline
> void rsc_add_data(struct netvsc_channel *nvchan,
> 

Sure that matches other code in that file
