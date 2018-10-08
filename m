Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6CCC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21F12087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a/0q8q/P";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z42/m1of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21F12087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJHOmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:42:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60842 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJHOmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:42:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C222D60769; Mon,  8 Oct 2018 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538983952;
        bh=KyaGqjK9pUAZZn0Q0RT7ctntx0JGRORgUcqfP3t8eb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a/0q8q/PeeBoBBD5v0N3Ns03gvnYZxfp/cjsuw09i3k1PJcimlZGWKpL5FugMn/Fx
         SgrlgVIDpteZFI12ObdC7qaWxkhGw3Swbj1w31DR4Zjxqq12fdZyStzznRePmY82hT
         OaAE5Fo77xTmUtB33tV520Daf+V8ptOw0911B72g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 91B0B60769;
        Mon,  8 Oct 2018 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538983951;
        bh=KyaGqjK9pUAZZn0Q0RT7ctntx0JGRORgUcqfP3t8eb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z42/m1ofUTCQZUpbk6DK8mp+tb4oWkVOi6RkyPQsbW0ww/+9HmWvKt6E4K3El/dgD
         RIHX+dTDXt8jW+wfSIb/dTWXmU9XY+KKUIot9uRSRzux6hf07aGTHIjG5GmbrCFjnM
         Gpybgg4E4Ukljanx9XsiqiPl/e4cp1raBPmoU2sA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Oct 2018 15:32:31 +0800
From:   cang@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     Can Guo <quic_cang@quicinc.com>, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, vivek.gautam@codeaurora.org,
        evgreen@chromium.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, Amit Nischal <anischal@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 7/7] dt-bindings: ufshcd-pltfrm: Add core reset string
In-Reply-To: <20180927150606.GA20771@bogus>
References: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
 <1537504081-29976-8-git-send-email-quic_cang@quicinc.com>
 <20180927150606.GA20771@bogus>
Message-ID: <1cf6d77f049c6dcd62b9d9758e06b186@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 23:06, Rob Herring wrote:
> On Thu, Sep 20, 2018 at 09:28:00PM -0700, Can Guo wrote:
>> From: Can Guo <cang@codeaurora.org>
>> 
>> Add core reset support string for UFS.
>> 
>> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt 
>> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> index c39dfef..6b697c4 100644
>> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>> @@ -11,6 +11,11 @@ Required properties:
>>  					  "qcom,ufshc"
>>  - interrupts        : <interrupt mapping for UFS host controller IRQ>
>>  - reg               : <registers mapping>
>> +- reset             : reset specifier pair consists of phandle for 
>> the reset provider
>> +                      and reset lines used by this controller. It is 
>> mandatory for
>> +		      QCOM SDM845 platform.
>> +- reset-names       : reset signal name strings sorted in the same 
>> order as the
>> +		      resets property. It is mandatory for QCOM SDM845 platform.
> 
> This already exists as of 4.19 under optional properties. (And you 
> can't
> add new required properties anyways.)
> 

Thank you Rob, I also found the newly merged change from Huawei on 4.19.
Then our code would need a small change to parse the new reset-names 
string.

>> 
>>  Optional properties:
>>  - phys                  : phandle to UFS PHY node
>> @@ -64,6 +69,8 @@ Example:
>>  		clocks = <&core 0>, <&ref 0>, <&iface 0>;
>>  		clock-names = "core_clk", "ref_clk", "iface_clk";
>>  		freq-table-hz = <100000000 200000000>, <0 0>, <0 0>;
>> +		resets = <clock_gcc GCC_UFS_BCR>;
>> +		reset-names = "core_reset";
> 
> And the name should be "rst" (or omitted).
> 

Sure, got it, thank you.

>>  		phys = <&ufsphy1>;
>>  		phy-names = "ufsphy";
>>  	};
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
