Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA6C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191BD20C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Def385J9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191BD20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeJSIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:10:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40624 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:10:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so14941574pgm.7;
        Thu, 18 Oct 2018 17:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hzSmIaAW2uKSQKBoPXgSJO+38CKDhJSh/7BFDbl+FK4=;
        b=Def385J9UNyd/klynrfA9FMk2Hij0g4CahUxF31JxRX2UOtq6V8zUg17nXh4nzIg9L
         m+HM2OJNIJu8U5KrJwJXzATju8HbbIgBpu4ox1omtYcDYjXZAmNPW9r0L/ssUkl9Ut95
         K1BY79nj69+EefXCRQdmwpDb5795FCflxl73VZDyLvFQOA0zgOTJz1VXrAM2ev4o2Tjo
         sHW9UFx8X0Jc+LobqJx1HYEAKwYkeOG40lMMJAMoQZXf4mb9Aiz4zwONu6DLE0mZlye0
         4DKDGfaZBKSVGDkyyp8jGlpwaKh8EOVYIfKutYJNTvCPyo85t1vhAkv6Ivm+7tNJ1UQ6
         4Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hzSmIaAW2uKSQKBoPXgSJO+38CKDhJSh/7BFDbl+FK4=;
        b=oZZaQEU5EoUjN7Yt8EkSMFZv6UfVk0kr32zafCIwSqF7e/8zdpi1h04bGRvPwELWoC
         MWy1aQ+1eLfbEpEOeLD9M51O4PHAA15sahF2Hy4mV/GdioM0x6OL9eLtQpgMw3nMuOXJ
         Em8nMyYXBR1D8+J4prW1AHZ+JC4DfFpj0aO8KdGqvrZUwQ00KhmJZi5+i3ej+AQVzMUK
         f9jQFwBNOWI/yhjek+VpsVU8hY5EHynYjDOLfJy7CUBIRHXZ4pdLTQjO0zLX7qJTFyHS
         cQp+Est6ofqDxl7U10bNB8IGggJOpTTgdqaXI8elp1T7pJ/dLn/kWHjkUz+xn7AuqYWZ
         VAAg==
X-Gm-Message-State: ABuFfojgq3o3m8y6/U3+hZ4rz1Q8xS7DQxRbBZcp7Q5jZ4y+BQARNEN4
        zoq2eh8eUZr6Z9YxOB7CaPc=
X-Google-Smtp-Source: ACcGV62M5n42djz1Jsh++/WQVUw+fJxnga701e0Dofuy/Uh2rjvPUnj/RMGj9w4G35zWz64ORlZTRA==
X-Received: by 2002:a62:1112:: with SMTP id z18-v6mr32468915pfi.200.1539907597999;
        Thu, 18 Oct 2018 17:06:37 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id y144-v6sm32543312pfb.81.2018.10.18.17.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 17:06:36 -0700 (PDT)
Subject: Re: [PATCH v3] of: overlay: user space synchronization
To:     Rob Herring <robh@kernel.org>
Cc:     pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Alan Tull <atull@kernel.org>
References: <1539736466-28638-1-git-send-email-frowand.list@gmail.com>
 <20181018193216.GA9971@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <2f99d700-6276-cfa4-8878-4eb161126330@gmail.com>
Date:   Thu, 18 Oct 2018 17:06:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018193216.GA9971@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 12:32, Rob Herring wrote:
> On Tue, Oct 16, 2018 at 05:34:26PM -0700, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> When an overlay is applied or removed, the live devicetree visible in
>> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
>> changes.  There is no method for user space to determine whether the
>> live devicetree was modified by overlay actions.
> 
> Because userspace has no way to modify the DT and the ways the kernel 
> can do modifications is limited.
> 
> Do you have an actually need for this outside of testing/development?

I do not know if anyone uses /proc/device-tree for anything outside of
testing/development.  If we believe that there is no other use of
/proc/device-tree we can simply document that there is no expectation
that accessors will see a consistent, unchanging /proc/device-tree.

That would be a much smaller patch.


>> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
>> user space to determine if the live devicetree has remained unchanged
>> while a series of one or more accesses of /proc/device-tree/ occur.
>>
>> The use of both (1) dynamic devicetree modifications and (2) overlay
>> apply and removal are not supported during the same boot cycle.  Thus
>> non-overlay dynamic modifications are not reflected in the value of
>> tree_version.
> 
> I'd prefer to see some sort of information on overlays exported and user 
> space can check if that changed. IIRC, Pantelis had a series to do that 
> along with a kill switch to prevent further modifications. At least some 
> of that series only had minor issues to fix.

The kill switch addresses a different concern, which was from the security
community.  The kill switch is on my todo list.

I don't remember exactly what info the overlay information export patch
provided.  I'll have to go find it and re-read it.


> Also, shouldn't we get uevents if the tree changes? Maybe that's not 

Yes (off the top of my head).  But a shell script accessing /proc/device-tree
is not going to get uevents.


> guaranteed, but I'd bet we can't handle cases where we don't get events. 
> A property added to an existing node comes to mind.> 
> Rob
> 

