Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B022CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E9B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cns3pxBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfAQQ4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:56:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44992 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfAQQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:56:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so11700664otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rn9rsZuCSSjzYYPQ+62CJKuWjWxIhG5kt5EwxvzV0zY=;
        b=cns3pxBjqz2aeJW7ho3ts/fvTC5/fMjksg2ZBn3RDRN6Ce1LFr/eaNkkar5bCU2hD1
         AZTk8cC+zT9/gltc0y5w/xZH+fVckPgARXuwzx8/wGYnNNwcVBTYcGJcbrlCU9QoDODs
         OyLNR01z65fZ28+2QODVrb3NJ0PROp31Z30Oe4WEBUJaaCdonumn5bmrcBUF4/zDgV9c
         r2c7HwTUMf69pHmtSNr072Q6DiaLgp82NRO+Xnst8ocjX3vYAm1Gd72BlSqVptP538FK
         i9eMT6OKkSrShBWJ5zc9k4+rdybJnRVKJgDvlzSUqMPnwNFhYoQffmolStM0WYg57Spt
         7Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rn9rsZuCSSjzYYPQ+62CJKuWjWxIhG5kt5EwxvzV0zY=;
        b=r9iMKW9+hJwO5yJtsSoap24vW02wPO2iI21htWy7/FFpJ6TmKJq6Tkr73r9tdqzMAl
         6KbX0yx/l+q8Il2ZKx2RLb+Cqc4xLFzm1NiADhNuMyK+8983D5wK6MKezmxsKdueki8Q
         V69tB6nIlH8Z9+gywCr9GmvkQ1Ucz7LIZfO6OXfK5svdfC77s//jHqhFhXijVttXy+2s
         FewPndae54/AvYkAjWiEGSbUov+55NTXSEePTkQTYtzJXvODTn9Mxed4Zk0lf7SvYln1
         J+IXl+WK8TGRqJ+5x6bOQ6fDUmsKrQP+inP7bRf6sI8Q/8hw1ywL/PTHtWjFcVIP+e4x
         EDmw==
X-Gm-Message-State: AJcUukeywd0SSl8tS6axoDhIZ2mbIce7UApUtaHPaGO4l6hAYtjpSerK
        HuB+Pxa++tPuQBW6sXO/Q1MWkfNdc6PgDWo21sjY0w==
X-Google-Smtp-Source: ALg8bN5kBBgKK8xzyu7fcYVTWd5irm9JOMtTRrCCpfXvQofB7v7nUulz8yc18vhIDbNF+9CMOfZAkNghbfqL+ruYv40=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr9245443oti.367.1547744179510;
 Thu, 17 Jan 2019 08:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20190116181859.D1504459@viggo.jf.intel.com> <20190116181905.12E102B4@viggo.jf.intel.com>
 <5A90DA2E42F8AE43BC4A093BF06788482571FCB1@SHSMSX103.ccr.corp.intel.com>
In-Reply-To: <5A90DA2E42F8AE43BC4A093BF06788482571FCB1@SHSMSX103.ccr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Jan 2019 08:56:08 -0800
Message-ID: <CAPcyv4heNGQf4NHYrMzUdBRw2n3tE08bMaVKzgYrPYVaVDWE9Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] dax: "Hotplug" persistent memory for use like normal RAM
To:     "Du, Fan" <fan.du@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "dave@sr71.net" <dave@sr71.net>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 9:21 PM Du, Fan <fan.du@intel.com> wrote:
[..]
> >From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> >Currently, a persistent memory region is "owned" by a device driver,
> >either the "Direct DAX" or "Filesystem DAX" drivers.  These drivers
> >allow applications to explicitly use persistent memory, generally
> >by being modified to use special, new libraries.
> >
> >However, this limits persistent memory use to applications which
> >*have* been modified.  To make it more broadly usable, this driver
> >"hotplugs" memory into the kernel, to be managed ad used just like
> >normal RAM would be.
> >
> >To make this work, management software must remove the device from
> >being controlled by the "Device DAX" infrastructure:
> >
> >       echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/remove_id
> >       echo -n dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> >
> >and then bind it to this new driver:
> >
> >       echo -n dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> >       echo -n dax0.0 > /sys/bus/dax/drivers/kmem/bind
>
> Is there any plan to introduce additional mode, e.g. "kmem" in the userspace
> ndctl tool to do the configuration?
>

Yes, but not to ndctl. The daxctl tool will grow a helper for this.
The policy of what device-dax instances should be hotplugged at system
init will be managed by a persistent configuration file and udev
rules.
