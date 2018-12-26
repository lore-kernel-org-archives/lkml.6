Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7EAC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6AA218AD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 15:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EBzweb46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeLZPN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 10:13:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39540 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbeLZPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 10:13:28 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so9452669qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 07:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zb0so+pcxIUl8OGx+WIK9Z4mk1eqnXZtUL3oIhSlR5E=;
        b=EBzweb46wZPgV1VB4w++afg80R5Fdf5blM3B3K7uAmS/gjCvIv3ikyv8yYNK9yNMHA
         vyLqRCxU+RamcitLdH9+2KL7DaRrNkOeO1tDxAMBPnMpKWzzuk9nU11UdPk1zOBJrZYT
         w3+3VSXUPyRLRKWPQBFiJDTQvC1VUBMLAHhQY2kyE9gLVIVIBX17GTrtcFIe0SEQT2tJ
         X0j5ATXejYzFnvecKgtWvgHfZBlPsTvnoxq4dfvVyk7LakAWudcUgU33VAJ0+cDLYiWE
         OiX2yh5a2LrABlD45eWVH6g+x7j/Ke9jNnRyHl//Vez+57si4XtmGYXZMkWoYnUkSOJP
         zPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zb0so+pcxIUl8OGx+WIK9Z4mk1eqnXZtUL3oIhSlR5E=;
        b=et/8ZKf8mk6nSzf/hlHpBtAZmiOK4JeJrpkEybK0WN+T78GM3IthNwWV18AFQf9XQH
         HaqHtoBGPlNE8sO3D84Jx1QGMLs/+Yoj1AmN6WjGGafQDuRQU8sg654Q19BZisE7aIbC
         VcYYWMna/NUTAK+ak3TFCLaklJblibJbv17UBCiUNrXY4PIeSaDylko1Xd8gEWQ6qPUI
         MzwzBhywsyAC2SIRYX8DnkA9RWRKWAX/JpOXnLqCAz4HALpbY5+OxfJGp8hKuaTVY6K+
         HPososoOgy1TmzbA2yZfUZLuGfEkj9q5TyEjTADlSF4/3nknrqYSHa1JhpxEzryuhv0I
         QFGw==
X-Gm-Message-State: AJcUuked8xHNTA3K8n0Icf1L9Ga2DVB8t8l3hshYa97LxSWMinq9iblh
        fXWsV/lOROsV3oUENn8UD/4RPTMUkgeQiw==
X-Google-Smtp-Source: ALg8bN5BOc/ZsaIz732JffN8Lg7DUxLrONw/PTWplpqpvztX55qqhDAAoF+YMxKD7Ql/+8F4ftH+pQ==
X-Received: by 2002:a37:8c04:: with SMTP id o4mr17456675qkd.165.1545837206561;
        Wed, 26 Dec 2018 07:13:26 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u67sm13305924qki.22.2018.12.26.07.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 07:13:26 -0800 (PST)
Subject: Re: [PATCH -mmotm] efi: drop kmemleak_ignore() for page allocator
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181226023534.64048-1-cai@lca.pw>
 <CAKv+Gu_fiEDffKq_fONBYTOdSk-L7__+LgNEyVaNF3FGzBfAow@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <403405f1-b702-2feb-4616-35fc3dc3133e@lca.pw>
Date:   Wed, 26 Dec 2018 10:13:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_fiEDffKq_fONBYTOdSk-L7__+LgNEyVaNF3FGzBfAow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/18 7:02 AM, Ard Biesheuvel wrote:
> On Wed, 26 Dec 2018 at 03:35, Qian Cai <cai@lca.pw> wrote:
>>
>> a0fc5578f1d (efi: Let kmemleak ignore false positives) is no longer
>> needed due to efi_mem_reserve_persistent() uses __get_free_page()
>> instead where kmemelak is not able to track regardless. Otherwise,
>> kernel reported "kmemleak: Trying to color unknown object at
>> 0xffff801060ef0000 as Black"
>>
>> Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Why are you sending this to -mmotm?
> 
> Andrew, please disregard this patch. This is EFI/tip material.

Well, I'd like to primarily develop on the -mmotm tree as it fits in a
sweet-spot where the mainline is too slow and linux-next is too chaotic.

The bug was reproduced and the patch was tested on -mmotm. If for every bugs
people found in -mmtom, they have to check out the corresponding sub-system tree
and reproduce/verify the bug over there, that is quite a burden to bear.

That's why sub-system maintainers are copied on those patches, so they can
decide to fix directly in the sub-system tree instead of -mmotm, and then it
will propagate to -mmotm one way or another.

