Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23645C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6841208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 05:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KqYxgUci";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aPs/KvNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6841208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeGaG46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 02:56:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeGaG46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 02:56:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1DDE3606DD; Tue, 31 Jul 2018 05:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533014312;
        bh=NMzJYSdj9reqKvdQFZDmu5GJ8A8H09mU9cX1SjYZsu4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KqYxgUcit2P1BpmS2Tz59AW62wdk8Hoyy41lO1vd6Pal8C/UpDIRHKyorKY5K9CRx
         SOGYGIW9RG/KRIDE78E/n5WEeeSuJ/ps3knn6ydIS+pdS1OUW9UxrolywB3XWN1yIX
         lBn/I20FvKCqms6LDNUtjkdWGhergY2iZu+xz17g=
Received: from [10.206.24.124] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9588660275;
        Tue, 31 Jul 2018 05:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533014311;
        bh=NMzJYSdj9reqKvdQFZDmu5GJ8A8H09mU9cX1SjYZsu4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aPs/KvNh6ol5MXlQdAjRLGbGuTi2AeQw2bRHWtVfkria89Eq7bluopqTHT1dq6J07
         /yol8m/vst/RIJciCXA4xYKSKhNJLxy3jqTr3rMzYKyUv9ZpSCyK0THm2OoAEteJVi
         G4WkQ8fJ16j/Q6cDNdgRU06PSshmbMPr9mewTQUY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9588660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
To:     Evan Green <evgreen@chromium.org>
Cc:     Bart.VanAssche@wdc.com, Vinayak Holikatti <vinholikatti@gmail.com>,
        linux-kernel@vger.kernel.org, asutoshd@codeaurora.org,
        riteshh@codeaurora.org, cang@codeaurora.org,
        martin.petersen@oracle.com, subhashj@codeaurora.org,
        linux-scsi@vger.kernel.org, vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        jejb@linux.vnet.ibm.com, gregkh@linuxfoundation.org
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft5U1-Jo-GvTF7sNAV3Q565AmuUrHpmBdxUL+UwkKxesqA@mail.gmail.com>
 <0dce9e9c-4f93-9857-72ee-f65ff195c41a@codeaurora.org>
 <CAE=gft6_=SQjgv7_kHXKJKa8_45NKKFwwE7UaXsijPpMd35LOg@mail.gmail.com>
 <4cb931e199599314829f5ff750797c88fc123f1f.camel@wdc.com>
 <CAE=gft6zm2mw3rnNuktDe0NWs-NM1CFQw1BUeGhaBi3eoEDXBg@mail.gmail.com>
 <8e6af8ed-1ec0-f10e-69b2-08281b638a4b@codeaurora.org>
 <CAE=gft4S9_H-PgpUHVrmjq4uah8pGKH+4A9xph+L=yButpqEpA@mail.gmail.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <cd621e88-99c6-b2a0-8ab9-84761fb0a1f9@codeaurora.org>
Date:   Tue, 31 Jul 2018 10:48:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft4S9_H-PgpUHVrmjq4uah8pGKH+4A9xph+L=yButpqEpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2018 5:09 AM, Evan Green wrote:
> On Mon, Jul 30, 2018 at 12:46 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
>> Hi Evan,
>>
>>
>> On 7/18/2018 1:53 AM, Evan Green wrote:
> ...
>>> I'm not dead set on binary, since as above I could do it either way,
>>> but it seemed worth at least talking through. Let me know what you
>>> think.
>>> -Evan
>> I am using ASCII format for reading/writing to config desc as it will be
>> more readable for users and easier/comfortable to compare any value to
>> default spec value(if required).
>> So I don't really see any harm in using current ASCII format for
>> provisioning purpose.
> I'm not convinced by those arguments, but ultimately it's between you
> and the maintainers. If you're going with the ASCII route, then I have
> another review comment. Currently in your patch, if kstrtoint fails,
> you print, but then break out of the loop and try to write the
> partially parsed descriptor anyway. That "break" should probably be
> changed to a "goto out".
>
> -Evan
Agreed. I will replace that break with "goto out" .
