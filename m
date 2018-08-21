Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D62C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5E82170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Oa3bn0DK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ln6TLzCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5E82170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHUSBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:01:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHUSBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:01:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4612B60F3C; Tue, 21 Aug 2018 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534862451;
        bh=zZz65kpgMfyCydCr36yjTID6hjD3olAxABU/ERodrqc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Oa3bn0DKOJBPvgXEmgRux0w7R02P/RqvNHdMQUx8alZbgAjGgdEIFS73TTs1qWcO+
         xPGWXY8GQB/zpfOmhmHvpDEhPB9Zmf2y2bmSt4F+qNcynszNF/wTngq+2TSb3cByMF
         xyXW86O1oz314V1kG50iNI6bbAhtiK24AtM3MKko=
Received: from [10.204.79.100] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F14F26145F;
        Tue, 21 Aug 2018 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534862450;
        bh=zZz65kpgMfyCydCr36yjTID6hjD3olAxABU/ERodrqc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ln6TLzCcNN6x63FRxsrff86Ea6Zy7Aapv9n4NwGJwVtK29LLAQksU8FBpKw2zlsSc
         Pt5o2B1m+GT+VxPyid1kBDKWzzX96YycPp/+blML15LkhXtvI+PRbgO8GyusLVl3V0
         pbcxGbZ4AMmycNtjOVUBOp4NqbFHG59ynsA3gZgA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F14F26145F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: Query on skip_onerr field in struct cpuhp_step
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <c228c495-63fa-5af9-32ff-355410d78cc8@codeaurora.org>
 <alpine.DEB.2.21.1808211557180.1535@nanos.tec.linutronix.de>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a8599754-5c8b-1667-1685-901f53319064@codeaurora.org>
Date:   Tue, 21 Aug 2018 20:10:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1808211557180.1535@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2018 7:27 PM, Thomas Gleixner wrote:
> On Tue, 21 Aug 2018, Mukesh Ojha wrote:
>> Hi All,
>>
>> This is about one of field in struct cpuhp_step
>>
>> * @skip_onerr: Do not invoke the functions on error rollback
>>   *              Will go away once the notifiers are gone
>>          bool                    skip_onerr;
>>
>> Why this field was introduced, can anyone explain the history behind ? As i
>> don't see it being set from anywhere
>>
>> If it is specifically was dependent on notifiers, did we missed to remove it
>> as the notifiers are gone or the usecase still there?
> As the comment says....

Thanks for your reply
Sorry, for further question but i did not get the comment ..did you 
mean, we can remove this from the structure as notifier are
not their now. ?

Also if you are aware with the history, can you tell , why would i want 
to avoid a call in undo_cpu_up path?

Thanks,
Mukesh


