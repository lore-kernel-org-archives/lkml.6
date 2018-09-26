Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A868C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6D2214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jrKBveTs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pA9QFQ2K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6D2214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeIZMZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:25:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeIZMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:25:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 84DEE607C6; Wed, 26 Sep 2018 06:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942459;
        bh=kMWgVD23aF588dobBLNTVzHW95aMJOLT2L8pw0O9exQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jrKBveTsB67XDPC0ZxmC/qAoCQGdSkvnBmrnYv946xpAOcpziURc5pvAo8EB5tPjP
         b6GVrVMKKNDQC/5silvUcJ8a1rHA6DBAHNEdqS0FdMXdds2N6nqdGuZsXjZPtxfHzC
         Et3B4rCbnU3Agw9cscLSTlqMbqOUR1nzup10Z2Jg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BF32760116;
        Wed, 26 Sep 2018 06:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537942458;
        bh=kMWgVD23aF588dobBLNTVzHW95aMJOLT2L8pw0O9exQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pA9QFQ2KouZ33cTywfj5+ZkWnbhiaUtvpUh4Q/OCmtLqE6T1YByEfHZU/vFoxvSP2
         NRuTfobZFfksijDkBbjWnCeGIvowsocN5dNMi31QZ0v3N5yan0+KkT9+HpSKoYx8lF
         rLWbIZB9IjVMnGC8ulcV2xc72R1Tran1Pw2GZgLI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Sep 2018 11:44:18 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Rob Herring <robh@kernel.org>
Cc:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        arnd@arndb.de, bjorn.andersson@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v9 5/5] dt-bindings: media: Document bindings for venus
 firmware device
In-Reply-To: <20180925152415.GB21227@bogus>
References: <1537314192-26892-1-git-send-email-vgarodia@codeaurora.org>
 <1537314192-26892-6-git-send-email-vgarodia@codeaurora.org>
 <20180925152415.GB21227@bogus>
Message-ID: <ee4208e75eae8196318521976b861505@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2018-09-25 20:54, Rob Herring wrote:
> On Wed, Sep 19, 2018 at 05:13:12AM +0530, Vikash Garodia wrote:
>> Add devicetree binding documentation for firmware loader for video
>> hardware running on qualcomm chip.
>> 
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/media/qcom,venus.txt | 13 
>> ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> Something change in this? If not, then please add acks/reviewed-bys 
> when
> posting new versions.

Same as the one reviewed by you earlier. Will add your review-by 
signature.
