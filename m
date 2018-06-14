Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E5545C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933D2208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvmy9DSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933D2208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeFNQdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755085AbeFNQdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:33:42 -0400
Received: from mail-yb0-f172.google.com (mail-yb0-f172.google.com [209.85.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99614208D4;
        Thu, 14 Jun 2018 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528994021;
        bh=Cpo4FsfYz6dBatpPFAHcg0PTD5cpJWmx7aGwuFp2MMk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nvmy9DSwIUcklaslhm6RB4kQ/91RuNuS1ar9xecXGTfcJEEhFGM4T7mOJH0tgKYZf
         YlgcZnDCCwtAJwkmTuzkxCiisTW+htq4mgaqs6cZNAIQUYb1hbPvNf86A52TrvheIG
         SOD65P0HEqBcMgqTgyQyg0XpTqMuBmB4Pr4P+7uI=
Received: by mail-yb0-f172.google.com with SMTP id p22-v6so2445601yba.13;
        Thu, 14 Jun 2018 09:33:41 -0700 (PDT)
X-Gm-Message-State: APt69E1OC6UZRW+VKS7ir9BpoX/P+0HmZFCzBTRPCjpH9TwneqEP91iZ
        EMKZNQ2gnbJIpf2UwozizwSH8MFcJNpk55D6sR4=
X-Google-Smtp-Source: ADUXVKJ6CG/cX8AuObY4M2RG/tCrG578bCYmo1kFcE7iQaljOr7/iu08k6OtlrRzXyn0323ERv8hKRUQu00OfNBO5fM=
X-Received: by 2002:a25:d647:: with SMTP id n68-v6mr1797037ybg.113.1528994020751;
 Thu, 14 Jun 2018 09:33:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 09:33:00 -0700 (PDT)
In-Reply-To: <20180614010713.fivl64pirawrnrhc@derp-derp.local>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-18-git-send-email-hao.wu@intel.com> <20180614010713.fivl64pirawrnrhc@derp-derp.local>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 14 Jun 2018 11:33:00 -0500
X-Gmail-Original-Message-ID: <CANk1AXRU9yXhgWu9_CZLLRQfNKedR22ghoPLGeTRUeTX24XtWw@mail.gmail.com>
Message-ID: <CANk1AXRU9yXhgWu9_CZLLRQfNKedR22ghoPLGeTRUeTX24XtWw@mail.gmail.com>
Subject: Re: [PATCH v6 17/29] fpga: dfl: fme: add partial reconfiguration sub
 feature support
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 8:07 PM, Moritz Fischer <mdf@kernel.org> wrote:

Hellooo,

This probably could use a comment, please see below.

> Hi,
>
> quick question for Alan inline below.
>

>> +static int fme_pr(struct platform_device *pdev, unsigned long arg)
>> +{
>> +     struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
>> +     void __user *argp = (void __user *)arg;
>> +     struct dfl_fpga_fme_port_pr port_pr;
>> +     struct fpga_image_info *info;
>> +     struct fpga_region *region;
>> +     void __iomem *fme_hdr;
>> +     struct dfl_fme *fme;
>> +     unsigned long minsz;
>> +     void *buf = NULL;
>> +     int ret = 0;
>> +     u64 v;
>> +
>> +     minsz = offsetofend(struct dfl_fpga_fme_port_pr, buffer_address);
>> +
>> +     if (copy_from_user(&port_pr, argp, minsz))
>> +             return -EFAULT;
>> +
>> +     if (port_pr.argsz < minsz || port_pr.flags)
>> +             return -EINVAL;
>> +
>> +     if (!IS_ALIGNED(port_pr.buffer_size, 4))
>> +             return -EINVAL;
>> +
>> +     /* get fme header region */
>> +     fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
>> +                                            FME_FEATURE_ID_HEADER);
>> +
>> +     /* check port id */
>> +     v = readq(fme_hdr + FME_HDR_CAP);
>> +     if (port_pr.port_id >= FIELD_GET(FME_CAP_NUM_PORTS, v)) {
>> +             dev_dbg(&pdev->dev, "port number more than maximum\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (!access_ok(VERIFY_READ,
>> +                    (void __user *)(unsigned long)port_pr.buffer_address,
>> +                    port_pr.buffer_size))
>> +             return -EFAULT;
>> +
>> +     buf = vmalloc(port_pr.buffer_size);
>> +     if (!buf)
>> +             return -ENOMEM;
>> +
>> +     if (copy_from_user(buf,
>> +                        (void __user *)(unsigned long)port_pr.buffer_address,
>> +                        port_pr.buffer_size)) {
>> +             ret = -EFAULT;
>> +             goto free_exit;
>> +     }
>> +
>> +     /* prepare fpga_image_info for PR */
>> +     info = fpga_image_info_alloc(&pdev->dev);
>> +     if (!info) {
>> +             ret = -ENOMEM;
>> +             goto free_exit;
>> +     }
>> +
>> +     info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
>> +
>> +     mutex_lock(&pdata->lock);
>> +     fme = dfl_fpga_pdata_get_private(pdata);
>> +     /* fme device has been unregistered. */
>> +     if (!fme) {
>> +             ret = -EINVAL;
>> +             goto unlock_exit;
>> +     }
>> +
>> +     region = dfl_fme_region_find(fme, port_pr.port_id);
>> +     if (!region) {
>> +             ret = -EINVAL;
>> +             goto unlock_exit;
>> +     }
>> +
>> +     fpga_image_info_free(region->info);
>> +
>> +     info->buf = buf;
>> +     info->count = port_pr.buffer_size;
>> +     info->region_id = port_pr.port_id;
>> +     region->info = info;
>> +
>> +     ret = fpga_region_program_fpga(region);
>> +
>> +     if (region->get_bridges)
>> +             fpga_bridges_put(&region->bridge_list);
>
> I'm wondering if this should not be done as part of
> fpga_region_program_fpga() (It's not at the moment).
>
> Alan, am I missing something obvious? :)

It is up to the caller of  fpga_region_program_fpga to put the bridges
before programming again.  That prevents something other than the
caller from reprogramming a partial region or messing with the bridges
until the caller puts the bridges.

For example, for DT support, applying an overlay calls
fpga_region_program_fpga() which gets the bridges, disables them, does
the programming, and reenables the bridges.  Then the bridges are
held, preventing anything else from disabling the bridges until the
overlay is removed.  This was important in the DT case since the
overlay could include child nodes for hardware in the FPGA.   Allowing
anyone else to play with the bridges while those drivers were
expecting hardware access could be bad.

I can't remember for certain, but I think this code has to put the
bridges here because this patch set allows userspace to reset the PR
region's logic by disabling/reenabling the bridge to clear things out
between acceleration runs (which Hao promises is OK to do, it's
documented elsewhere in the pachset).  It probably could use a comment
right here to explain why the bridges are put here so future
generations know not to break this.

Alan

>> +
>> +     put_device(&region->dev);
>> +unlock_exit:
>> +     mutex_unlock(&pdata->lock);
>> +free_exit:
>> +     vfree(buf);
>> +     if (copy_to_user((void __user *)arg, &port_pr, minsz))
>> +             return -EFAULT;
>> +
>> +     return ret;
>> +}
