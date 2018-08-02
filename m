Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E876C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0112154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iLTd929v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iLTd929v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0112154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeHBUhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:37:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeHBUhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:37:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 93B6360AFF; Thu,  2 Aug 2018 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533235491;
        bh=RaIU8sXArN6xF6tbF+b40cT1tJWv2mcYcRXSAG6vZbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iLTd929vo84j1flbGWdE9UriXvyQ+ry2yuVLTM3ZzVDen3yKpT1MIDVE/VHfj/bxI
         hRkmu4n5amhHazydIFQ0P9sNn1XT8ZXz04BJ4JHSNEevyj1sjiVqLc5jLwRhlRo8xB
         NDXewcz2ImSchh4joz8ZEhf74NHL28GuRQkGRzPM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 06E766024C;
        Thu,  2 Aug 2018 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533235491;
        bh=RaIU8sXArN6xF6tbF+b40cT1tJWv2mcYcRXSAG6vZbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iLTd929vo84j1flbGWdE9UriXvyQ+ry2yuVLTM3ZzVDen3yKpT1MIDVE/VHfj/bxI
         hRkmu4n5amhHazydIFQ0P9sNn1XT8ZXz04BJ4JHSNEevyj1sjiVqLc5jLwRhlRo8xB
         NDXewcz2ImSchh4joz8ZEhf74NHL28GuRQkGRzPM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Aug 2018 11:44:50 -0700
From:   pheragu@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, ckadabi@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        satyap@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: Documentation for qcom,eud
In-Reply-To: <CABGGiswcMicPypOz2eW01NosuAHUw2B3KVxzrOfanEfT=Srf9A@mail.gmail.com>
References: <1533061333-7680-1-git-send-email-pheragu@codeaurora.org>
 <1533061333-7680-2-git-send-email-pheragu@codeaurora.org>
 <CABGGiswcMicPypOz2eW01NosuAHUw2B3KVxzrOfanEfT=Srf9A@mail.gmail.com>
Message-ID: <4d6732e9172431bbf24ff470be345481@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-01 07:04, Rob Herring wrote:
> On Tue, Jul 31, 2018 at 12:22 PM Prakruthi Deepak Heragu
> <pheragu@codeaurora.org> wrote:
>> 
>> Documentation for Embedded USB Debugger (EUD) device tree bindings.
> 
> If you want bindings reviewed, send them to the correct list and
> people (hint: run get_maintainers.pl).
> 
> New bindings should not use extcon.
> 
Why should we not use extcon? Are there any alternatives which you
would suggest? We were looking at graphs instead of extcon.
>> 
>> Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
>> Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
>> ---
>>  .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 28 
>> ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt 
>> b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
>> new file mode 100644
>> index 0000000..ea63f1c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
>> @@ -0,0 +1,28 @@
>> +* Qualcomm Technologies Inc Embedded USB Debugger (EUD)
>> +
>> +The EUD (Embedded USB Debugger) is a mini-USB hub implemented
>> +on chip to support the USB-based debug and trace capabilities.
>> +
>> +Required properties:
>> +
>> + - compatible:  Should be "qcom,msm-eud"
>> + - interrupts:  Interrupt number
>> + - reg: Should be address and size of EUD register space
>> +
>> +Driver notifies clients via extcon for VBUS attach/detach
>> +and charger enable/disable events. Clients registered for these
>> +notifications should have extcon property set to eud.
>> +
>> +An example for EUD device node:
>> +
>> +       eud: qcom,msm-eud@88e0000 {
>> +               compatible = "qcom,msm-eud";
>> +               interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
>> +               reg = <0x88e0000 0x4000>;
>> +       };
>> +
>> +An example for EUD extcon client:
>> +
>> +       usb3 {
>> +               extcon = <&eud>;
>> +       };
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
