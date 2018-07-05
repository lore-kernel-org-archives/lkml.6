Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23FCC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A653723FCE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HRaGzJVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A653723FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbeGEUeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:34:03 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34071 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeGEUeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:34:02 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so19389746ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iSABVVj1pZRAHgcg3NG9bZXaRtIml7FC6mKMGSiU3ak=;
        b=HRaGzJVP9rfk0EQE1aI6jwf0KCraDB2pCymOCj3zr29R5qWerkuGQeCfih/e55jDhV
         5r3Rdjj+n96aH6tLNw2JDgepeMW6m6rrYRDFc361a9C5SBgvHQNRZFTYBrgfWBaoNMW6
         bv4iN6UaGVN+zdric0Nv8FNj6BFhwGw+MwGGQtZ4epbQ5C91T0UrwlJcQFmEaaYf+fvh
         vcSwPCqHbQtSQoMGSPb8FkoMWLwzwlAygAYjpwtpxnX7Mnnkj+2OG1oEHFNz4l5wYNOd
         tjJHWB4H86jNxe7P6+b/ejG+xfOyix+MBqMINJZCRmlKxGtjwsKtu//C1WRNWRw/bbPQ
         lUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iSABVVj1pZRAHgcg3NG9bZXaRtIml7FC6mKMGSiU3ak=;
        b=CziPQfm+QCT/CXlvFj2uJY/DdmgPk/JYRBpppYXp5HF1Zr8hpljePaU7J4OcNLNXb6
         byAPozgFs3oNjR1s3Q6JIPplT3u+qnLfmGHyxp3NZnHJuE87x71ZkxbdxxVPP6T5JrqW
         Of1Ebqqm1SiVfMbinx0HZIRnMwoqQpp02ClpW8aseUWtv2VME/a8jf1ULfDFO8eiRAEd
         ebJsP/TKe5ldpEdo1dR/aIicmJxT95+OD5aHfDqpeR86JdeiXYzXn17DmCcQbAEpfLaF
         g5vgjR+VtCEwd+hR4SOjxae2BLqiB7I+1M6/OD5xc4fl65Qy2az11mjuSaN/i6ddJOo+
         PKTQ==
X-Gm-Message-State: APt69E2Or44uooXTZq+0AjNQoDvWTfu2TAdsOdW+fLSOhiin3EuRfra4
        M1kqObOFXyE3hQUPrfJn3oSnpQEitR11pH7Te3BNZg==
X-Google-Smtp-Source: AAOMgpc8Dy6AEMYL+y5HagV5F/RmZi1JucIRG2KXQGHf/m7NnBdP7nxYUWRSGkaF9SQmJA7tDcDUDTFC5Vreqo3nCis=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr8898120oib.115.1530822841945;
 Thu, 05 Jul 2018 13:34:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 13:34:01 -0700 (PDT)
In-Reply-To: <20180705132455.2a40de08dbe3a9bb384fb870@linux-foundation.org>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082931.echvdqipgvwhghf2@linux-x5ow.site> <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
 <20180705144941.drfiwhqcnqqorqu3@linux-x5ow.site> <20180705132455.2a40de08dbe3a9bb384fb870@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Jul 2018 13:34:01 -0700
Message-ID: <CAPcyv4h973nANXOUFe9rE7pn0tKxy=Csh=XYsyA6V_bPF0eRAw@mail.gmail.com>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 1:24 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 5 Jul 2018 16:49:41 +0200 Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
>> On Thu, Jul 05, 2018 at 07:46:05AM -0700, Dan Williams wrote:
>> > ...but that also allows 'echo "syncAndThenSomeGarbage" >
>> > /sys/.../memmap_state' to succeed.
>>
>> Yep it does :-(.
>>
>> Damn
>
> sysfs_streq()

Nice... /me stares down a long list of needed cleanups in the
libnvdimm sysfs implementation with that gem.
