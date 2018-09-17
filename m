Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68277ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17126214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GI+8h/sZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="npkTg0hU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17126214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeIQWoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:44:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeIQWoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:44:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35BFB60C5F; Mon, 17 Sep 2018 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537204560;
        bh=zUie+YyzwT5RG0b3Cq443RoWK/CIr6/eZQMkM0epaag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GI+8h/sZ5+cDmun5YUmx07zhg3jDtOuLk8o0d8bNBbzqqF9HLn8JjPtTfeFJMiUEf
         M4oyHrOHpl5CJyrpXAa0FMMR554RWB3maA/hvc46AHgnUMacg8Pg36Ox6EdgZvJMZ5
         R/tjx8w6I0aLJDlz5uDQwB5RmqBz/pJlsuOC2OX4=
Received: from [192.168.43.47] (unknown [27.59.117.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 350C260C5F;
        Mon, 17 Sep 2018 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537204559;
        bh=zUie+YyzwT5RG0b3Cq443RoWK/CIr6/eZQMkM0epaag=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=npkTg0hUBdjCZDAU2uBiq5VbBic7pL/iLe6em1ZzdQwSVjpdDATtyC9/6yPVQtFxX
         T2Mgxp61aqp+BzgZsjcbyMPNTUelihrCgVl8u1DuNIkhkZk0BvTFTN49Qt5qDvaqkQ
         /E/deiFzt1cu6jJjhKuEvwhcw2r1DQIkEQZ39OSk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 350C260C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 1/6] dt-bindings: ramoops: Add event-size property
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <4ec22906649fb3f6ab9570d8d4bf214e61512664.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <5b9f3f67.1c69fb81.3125b.c205@mx.google.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <fa192e16-67e7-412c-96d1-ab781acd8092@codeaurora.org>
Date:   Mon, 17 Sep 2018 22:45:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5b9f3f67.1c69fb81.3125b.c205@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 11:15 AM, Rob Herring wrote:
> On Sun,  9 Sep 2018 01:57:02 +0530, Sai Prakash Ranjan wrote:
>> Add an optional property called event-size to reserve
>> log buffer for trace events.
>>
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
>>   .../devicetree/bindings/reserved-memory/ramoops.txt        | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks a lot for the review Rob.

- Sai
