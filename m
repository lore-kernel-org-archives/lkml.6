Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9985920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547742345;
	bh=DP4X3b76RoSDfuEoITi6Z6Kedg41xbZ0lwfBl4cU1uo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rKUJtnBb5D82zSYRWRvR2VDjsWXA8v2pJsLRQfMhLOczQd8LdK+dcmgAZUr5+dvk2
	 RLLsJhwnFXsIYKH3qzCwfvxiCEZYYXPTIC8CfLCUkUWf9Ji5dCKwsTtqEQPyVMJdPz
	 3obPRoPvbIcmZh+VbNcFFKUwUtZg3jBaqMGOAitA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfAQQZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:25:44 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:44818 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfAQQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:25:42 -0500
Received: by mail-ot1-f51.google.com with SMTP id f18so11602696otl.11;
        Thu, 17 Jan 2019 08:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E//4eBJBqqAWyVDqY++P+ol3f8CvDIv+MgsFQ4gxZrI=;
        b=cBFKa3kyTP7+NpmWKbQ7VHc0FnpprMKg0YQPHqO+9iIxF0vLQZ50dM5JjH3gYAMABe
         cTyFK3lWQ08aMf4JCTbuwpa+48xCalGXW+WaoWqEntx3fTMcC3AsQP3Gn0fOiXg80zKT
         +bV5j6f6JhQkyUXTLNGJDAzwDCCK1pcrshe3a9M4LpiwFHQG3bfTtpc7ndtQ2ffIIrF7
         YxeX2meMZs2Veu5LPBZaMGafXd1FzI4ud5UNqbL4TWpSDMID2EGFNm3jI1lJfqdBQgS6
         iYcabZgqcDJJowtX/sF5/+8mfLMU4IPcUZ+GR7fDy2VOtTdjBPmsMKpM+FjXxqA4rIRc
         ja9Q==
X-Gm-Message-State: AJcUukeFyXIX3MbTBA/bddt0+X3eegdKSovwWjgLhovHS7ofdt4/g3C/
        +t1GJAMGoQyMKsoI2JUir+W+Qt9B/2toDej2abo=
X-Google-Smtp-Source: ALg8bN5cQoDyBKjTUBH4XX90aC0QC8ljsrgq2cm+rOCtUJMhKGrFHk4+xXBVuPjn8+os6Yh9WWe/q2dtTJmLN/9ESOg=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr8855039otn.200.1547742341916;
 Thu, 17 Jan 2019 08:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-12-keith.busch@intel.com>
In-Reply-To: <20190116175804.30196-12-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jan 2019 17:25:30 +0100
Message-ID: <CAJZ5v0hYx_fG6UW+MXfLtdBAyWc_qi4A0h5xVTpTSAbo4ntz7g@mail.gmail.com>
Subject: Re: [PATCHv4 11/13] Documentation/ABI: Add node cache attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Add the attributes for the system memory side caches.

I really would combine this with the previous one.

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 34 +++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 2217557f29d3..613d51fb52a3 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -142,3 +142,37 @@ Contact:   Keith Busch <keith.busch@intel.com>
>  Description:
>                 This node's write latency in nanoseconds available to memory
>                 initiators in nodes found in this class's initiators_nodelist.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/associativity
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The caches associativity: 0 for direct mapped, non-zero if
> +               indexed.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/level
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               This cache's level in the memory hierarchy. Matches 'Y' in the
> +               directory name.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/line_size
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The number of bytes accessed from the next cache level on a
> +               cache miss.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/size
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The size of this memory side cache in bytes.
> +
> +What:          /sys/devices/system/node/nodeX/side_cache/indexY/write_policy
> +Date:          December 2018
> +Contact:       Keith Busch <keith.busch@intel.com>
> +Description:
> +               The cache write policy: 0 for write-back, 1 for write-through,
> +               2 for other or unknown.
> --

It would be good to document the meaning of indexY itself too.
