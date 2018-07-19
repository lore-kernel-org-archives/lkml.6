Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB4CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63F2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7m3D9Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D63F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbeGSQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:38:56 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37106 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbeGSQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:38:56 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so10595278itc.2;
        Thu, 19 Jul 2018 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MK+AghjjDRBj4gE7hWCPaTbcdqWC4IO66VxE4NyAcK4=;
        b=r7m3D9IeSPH5Z9wgFDIOnbDzLM0YluuPOKw/6/iYneJ6Q6X2yc8SO439FLcaiQ0No2
         NnVzf21nUqv+PokeqcrLmhVQcwsaYQC1UzuvJDxOvrM6RCaWZao0j5Vei8nFBpV4GWsr
         TXthg93nRQQjC+j8Wn5b7Gf43iU87by2w43b2Hq6utBTOc9zYYl/BNQFyUmJLqzZImGR
         j0hccNJnxstTXVkjfr6farBDlrjyk/PRV2YptpMWlYDxPSPlcgw8sae652pTWUGF00jR
         I43qK5H+4+n5ICEESGZXCLMMTNOa4kNEOxTKA6IKcNi0UYyNJ5CMcZilvGVRDfnOE0sz
         kdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MK+AghjjDRBj4gE7hWCPaTbcdqWC4IO66VxE4NyAcK4=;
        b=sIOKSIKLi9QLCgtOh3VLubOtBRMyFFzKMr1b3cDOur4SVGsbBlMLWZEruRS+aMacT6
         uacTypWBN84r39eH9BDy4b9gvdN2ImuZZGwsBrPHcDxKXEWyKcIrmDlBY7ueSero36sJ
         sdCYE3ICipogs/ocp9nZtbGfVgbieB04SsrNKg4xzoWyE+N/m6cdRw/RvpbCFCp8cb/1
         VJu7GX5bwA7LVGTdvnCMZMwljGR+cWBkGe2UAOS3ueqCoL7so4qu0sPtU0iK05eA8eyL
         xROW7g+jyAW9xwI7HSzqa7JUkXyS9vzC4LJH6rmPk5pYoHy6ToQ01Ys5lFlp5BKLn89T
         jjOg==
X-Gm-Message-State: AOUpUlFpnkeH1275lxxTzWcGfQx+GDu6Iv0g57kfeWdAhDAo+VHe9jIi
        004Dihd3mv3JXociLjKWRt1RH/ArC3Q=
X-Google-Smtp-Source: AAOMgpcUZtoZq3EmwhYFPdWB1l74JHFbIGP9ExKwWLjkkojzjkCs5ZPNxG2RY5uALGvkeCdW6eVGXg==
X-Received: by 2002:a02:3344:: with SMTP id k4-v6mr10284108jak.45.1532015708251;
        Thu, 19 Jul 2018 08:55:08 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id c5-v6sm3066835itj.9.2018.07.19.08.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:55:07 -0700 (PDT)
Subject: Re: [PATCH] PCI/AER: Do not clear AER bits if we don't own AER
To:     Sinan Kaya <okaya@kernel.org>, bhelgaas@google.com,
        keith.busch@intel.com
Cc:     alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <37509c44-64fe-4140-c776-53c3346cbfe5@gmail.com>
Date:   Thu, 19 Jul 2018 10:55:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <494a5df8-0987-3a6c-30a4-a3c9ef4ed1f3@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/17/2018 10:41 AM, Sinan Kaya wrote:
> 
> On 7/17/2018 8:31 AM, Alexandru Gagniuc wrote:
>> +    if (pcie_aer_get_firmware_first(dev))
>> +        return -EIO;
> 
> Can you move this to closer to the caller pci_aer_init()?

I could move it there. although pci_cleanup_aer_error_status_regs() is 
called directly from pci_restore_state.  Of course, aer_cap should be 
zero in this case, and we'd still bail out.
I find the intent clearer if we check it here rather than having to do 
the mental parsing of the state of aer_cap.

Alex
