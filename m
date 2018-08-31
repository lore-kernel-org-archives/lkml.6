Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F73C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C23120837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtRFEywF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C23120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeHaIli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:41:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38416 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbeHaIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:41:37 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so4904834pfh.5;
        Thu, 30 Aug 2018 21:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2tboE3a2R3pfYj3H3lUAqibkfDCL7iLM6OKuWC3F+TA=;
        b=VtRFEywF3GC1AikV1ROCqzUL9mpGtgU/3YNX+SD7ni5UdMQQHJADdykNH2ixXf8oBl
         J/kRR3lQOKgvFs+PqxTDzOjsrWH9wRvVTvn4SBLc1R8evfqTG4CYQQevnSnvC05NwriJ
         3aC7cFxv2cR6KPgWL85s9KgyJUMyJPtWiMt9I+mIppLcs+1pjGSWV8RVzX7RK1JDHZk7
         MnreWRRIGv5/Ovaa5owMvS6U92KqastFOl7MPT+GcaWtoYOB2N3TYQaUu40MEPwtFBEI
         XWo2rfdswuZ6cmKe2hNECjxBE/JgEb14wzcGMBFvMTv1052Ip7v+8VSJoJhvmcLuvojt
         rx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2tboE3a2R3pfYj3H3lUAqibkfDCL7iLM6OKuWC3F+TA=;
        b=RNxG5iY7vUr2bjblE8R/AuE3z9EDikG23LCMaQzJOHIsHk4ex3kwrblNT5zzJTU99A
         +4CUdixjIG0J0kF4azqFQitqH4jfDGdv4tcvTWt/4BoyZKDPCcdAxgrR5ei7kPNUejFY
         Fd7blzmDhD/S9zxBZU/0Wrp/1NURMhovjP9FoRqC2e2DmQwTLv7araZUk4lpylaRZLQU
         byHoXpUWRbeMnA/0851Fl6Tj/cCEdx8sdq9tei7j8VlaRk20hhBB6fusg48Flh4vNhg5
         gH9LVqKGXNFczkCtmug+WY47qGKdB8641QylatKv8Hlpq5UUR3A7BQmQQzw9vMohMRLd
         ad7A==
X-Gm-Message-State: APzg51CXuCyNwggKUxy0gk+i3VOoQzt4ITIj30nUYf4ZIiBeMs6gryQ+
        zZZIsSBm/ZTPNr93ccBwMnE=
X-Google-Smtp-Source: ANB0Vdb/HPpByJYOrehPyq7/xjwWoGNlWVSwafuWyeLefxGOLGRHKNOvtwwcUpKXWJZ6DDSKnITEvw==
X-Received: by 2002:a62:d94:: with SMTP id 20-v6mr13751544pfn.202.1535690162868;
        Thu, 30 Aug 2018 21:36:02 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id n22-v6sm23804660pfj.68.2018.08.30.21.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 21:36:02 -0700 (PDT)
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Stan Johnson <userm57@yahoo.com>, Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
Date:   Thu, 30 Aug 2018 21:36:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On 08/29/18 17:44, Finn Thain wrote:
> Hi Frank,
> 
> Linux v4.17 and later will no longer boot on a G3 PowerMac. The boot hangs 
> very early, before any video driver loads.
> 
> Stan and I were able to bisect the regression between v4.16 and v4.17 and 
> arrived at commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of 
> of_find_node_by_phandle()").
> 
> I don't see any obvious bug in 0b3ce78e90fc or b9952b5218ad. But if you 
> revert these from v4.18 (which is also affected) that certainly resolves 
> the issue.
> 
> I did see this in the kernel messages:
> 
> Duplicate name in PowerPC,750, renamed to "l2-cache#1"
> Duplicate name in mac-io, renamed to "ide#1"
> Duplicate name in ide#1, renamed to "atapi-disk#1"
> Duplicate name in multifunc-device, renamed to "pci1799,1#1"
> 
> No idea whether that's relevant; I haven't done any further investigation. 
> Complete dmesg output is attached. Please let me know if there's any more 
> information you need to help find the bug.
> 
> Thanks.

I don't have any useful answers yet, but I am following the thread and have
also quickly scanned the two commits for any obvious cause.  I will look
into this some more, but have a few other tasks that I need to complete
first.

A long shot, but something to consider, is that I failed to cover the
cases of dynamic devicetree updates (removing nodes that contain a
phandle) in ways other than overlays.  Michael Ellerman has reported
such a problem for powerpc/mobility with of_detach_node().  A patch to
fix that is one of the tasks I need to complete.

-Frank

