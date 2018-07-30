Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD13C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6159120873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bXtwZSnQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bf8yM36o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6159120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbeG3JTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:19:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeG3JTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:19:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EB9716034F; Mon, 30 Jul 2018 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532936767;
        bh=MbgmtupYDTeVSnc8rmFt48Zq8EJTSg020yRqwfVnTBE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bXtwZSnQXeE7AAm6NjdiI/sPwl7astf+NcXYx1oWlaWt3kDlBYbLVlP0Q7dZFPWC8
         H66X4CfTb25Mmq1F7iDNcMiU6/3yAe3B1AwdlCCvv29CqNMv79GrERvCA2lXhSSSA6
         RxezhUGa6PC/msket66cppPy6QkvyCcpzqs4Zt2U=
Received: from [10.206.24.124] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0A7AB6034F;
        Mon, 30 Jul 2018 07:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532936766;
        bh=MbgmtupYDTeVSnc8rmFt48Zq8EJTSg020yRqwfVnTBE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Bf8yM36oZy3tcmYlit1zLoDGVHnoNB/kTLMfnVEWpvYUvigr+i5fEa1kvpcIy5YxT
         eToGav4vzdkG7wAdPPGo5Oz4QXu2fkvOazmnlsLdj6i+2XdhWuQa9W0MRn+yIvGqUn
         0IUnSTtMPHgtU44S2MT9Mhm3ycJ+KuliLbxwqQYQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A7AB6034F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
To:     Evan Green <evgreen@chromium.org>, Bart.VanAssche@wdc.com
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-kernel@vger.kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, cang@codeaurora.org,
        martin.petersen@oracle.com, subhashj@codeaurora.org,
        linux-scsi@vger.kernel.org, vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, jejb@linux.vnet.ibm.com
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
 <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
 <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
 <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
 <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <8e6af8ed-1ec0-f10e-69b2-08281b638a4b@codeaurora.org>
Date:   Mon, 30 Jul 2018 13:16:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,


On 7/18/2018 1:53 AM, Evan Green wrote:
> On Mon, Jul 16, 2018 at 5:04 PM Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
>> On Mon, 2018-07-16 at 16:46 -0700, Evan Green wrote:
>>> I see Bart has chimed in on the next series with a suggestion to break
>>> out each field into individual files within configfs. Bart, what are
>>> your feelings about converting to a binary attribute? I remember when
>>> I did my sysfs equivalent of this patch, somebody chimed in indicating
>>> a "commit" file might be needed so that the new configuration could be
>>> written in one fell swoop. One advantage of the binary attribute is
>>> that it writes the configuration atomically.
>> Hello Evan,
>>
>> I may be missing some UFS background information. But since a configfs interface
>> is being added I think the same rule applies as to all Linux kernel user space
>> interfaces, namely that it should be backwards compatible. Additionally, if
>> anyone ever will want to use this interface from a shell script, I think that
>> it will be much easier to write multiple ASCII attributes than a single binary
>> attribute.
>>
> Hi Bart,
> I'm unsure about the compatibility aspect for binary attributes that
> essentially represent direct windows into hardware. I suppose this
> comes down to who this interface is most useful to. Hypothetically
> lets say a future revision of UFS adds fields to the configuration
> descriptor, but is otherwise backwards compatible. If this interface
> is primarily for OEMs initializing their devices in the factory, then
> I'd argue they'd want the most direct window to the configuration
> descriptor. These folks probably just have a configuration they want
> to plunk into the hardware, and would prefer being able to write all
> fields over having some sort of compatibility restriction. If, on the
> other hand, this is used by long-running scripts that stick around for
> years without modification, then yes, it seems like it would be more
> important to stay compatible, and have smarts in the kernel to make
> writes of old descriptors work in new devices.
>
> At least for myself, I fall into the category of someone who just
> needs to plunk a configuration descriptor in once, and would prefer
> not to have to submit kernel changes if the descriptor evolves
> slightly. It also seemed a little odd that this patch now spends a
> bunch of energy converting ASCII into bytes, just to write it without
> modification into the hardware, and convert back again to ASCII for
> reads.
>
> We plan to use a script for provisioning, and could easily handle
> ASCII or rawbytes:
>
> # Some bytes, ready to go with the interface today...
> some_bytes="00 01 02 03"
>
> # Same bytes, now in binary format
> bytes_fmt=$(echo " $some_bytes" | sed 's/ /\\x/g')
> /usr/bin/printf "$bytes_fmt" > /configfs/ufs_provision
>
> I'm not dead set on binary, since as above I could do it either way,
> but it seemed worth at least talking through. Let me know what you
> think.
> -Evan

I am using ASCII format for reading/writing to config desc as it will be 
more readable for users and easier/comfortable to compare any value to 
default spec value(if required).
So I don't really see any harm in using current ASCII format for 
provisioning purpose.
-Sayali
