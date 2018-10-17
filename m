Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1C0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847362145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zg5xAggj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847362145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeJRFng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:43:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2105 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeJRFng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1539812759; x=1571348759;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8VlMOJnAuhPsAYJEs53Het/Qfc9+MZRrBMmO82hRXns=;
  b=Zg5xAggjfxIiCr4uBdblpC62yCcE6Jby2v1beAVcUm2lfSCz0bDf9H3r
   5BIOzy51RDEdTDxfwMpqrrhvzvUln1BQk5AWeMgdMVQK6ygMd/1NlMiQX
   Vjk6CRNC7jls1Q3UfpTWGoFoSWEwvRJzCh9djkWfs3LB7u0jn8RXymrg/
   WFoSCkol8D+NhJ3xe2xfBXG8IlWWxuIjCiWGa1DsSzS1aq6vOPvuAAd5+
   1DzSWFFoNj3hT6AbF4mY9nv28KcN210lrzWQbPMJ8Yl3jL8PVeLpsvGNa
   bvsIJYv98O/OGrHhdp8uUAYAtuao4E+VSlU7FBZOCaq29yD3C7nwwLVWp
   w==;
X-IronPort-AV: E=Sophos;i="5.54,393,1534780800"; 
   d="scan'208";a="93292976"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2018 05:45:59 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Oct 2018 14:30:30 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.73.114]) ([10.111.73.114])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Oct 2018 14:45:59 -0700
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Wesley Terpstra <wesley@sifive.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo> <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
 <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
 <20181016220437.GB31973@mithrandir>
 <7fc1168d-a840-032a-c0a9-2a610127c484@wdc.com> <20181017155818.GA21971@bogus>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <40c50c06-7a89-47db-1a5c-07c58b6c253b@wdc.com>
Date:   Wed, 17 Oct 2018 14:45:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017155818.GA21971@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 8:58 AM, Rob Herring wrote:
> On Tue, Oct 16, 2018 at 03:20:34PM -0700, Atish Patra wrote:
>> On 10/16/18 3:04 PM, Thierry Reding wrote:
>>> On Tue, Oct 16, 2018 at 10:31:42AM -0700, Paul Walmsley wrote:
>>>>
>>>> On 10/16/18 4:01 AM, Thierry Reding wrote:
>>>>> On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
>>>>>> On 10/10/18 6:49 AM, Thierry Reding wrote:
>>>>>>> On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
>>>>>>>> +Required properties:
>>>>>>>> +- compatible: should be one of
>>>>>>>> +	"sifive,fu540-c000-pwm0","sifive,pwm0".
>>>>>>> What's the '0' in here? A version number?
>>>>>>>
>>>>>> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive Guys
>>>>>> decided mark it as version 0.
>>>>>>
>>>>>> @Wesly: Please correct me if I am wrong.
>>>>> It seems fairly superfluous to me to have a version number in additon to
>>>>> the fu540-c000, which already seems to be the core plus some sort of
>>>>> part number. Do you really expect there to be any changes in the SoC
>>>>> that would require a different compatible string at this point? If the
>>>>> SoC has taped out, how will you ever get a different version of the PWM
>>>>> IP in it?
>>>>>
>>>>> I would expect any improvements or changes to the PWM IP to show up in a
>>>>> different SoC generation, at which point it would be something like
>>>>> "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
>>>>> the numbering is.
>>>>
>>>>
>>>> The "0" suffix refers to a revision number for the underlying PWM IP block.
>>>>
>>>> It's certainly important to keep that version number on the "sifive,pwm0"
>>>> compatible string that doesn't have the chip name associated with it.
>>>
>>> Isn't the hardware identified by "sifive,pwm0" and "sifive,fu540-c000"
>>> effectively identical?
>>
>> Yes.
>>
>> Is there a need to have two compatible strings
>>> that refer to the exact same hardware?
>>>
>>
>> The DT in the hardware has only sifive,pwm0. I have added
>> "sifive,fu540-c000" as that was concluded as the correct compatible string
>> from platform level interrupt controller patch(PLIC) discussion.
>>
>> (http://lists.infradead.org/pipermail/linux-riscv/2018-August/001135.html)
>>
>> "sifive,pwm0" is required to until all the Unleashed SoC gets an updated
>> firmware with correct compatible string "sifive,fu540-c000". I agree this is
>> a mess. But we have to carry it until all every DT(corresponding to each
>> driver) is finalized. I guess SiFive will release a firmware update that
>> contains all the updated DT once that is done. We can get rid of all the
>> redundant compatible strings at that time.
> 
> I don't want to repeat compatible string discussions on each and every
> IP block. I already have to do this with some vendors.
> 



> The RiscV vendors' needs and design flow are a bit different from
> traditional SoC vendors AIUI for the last discussion. If you need to do
> something that doesn't follow normal conventions, that's fine. Just
> please document a convention that works for you. This should explain
> where the '0' above comes from for example. And I'm not a fan of s/w
> folks making up version numbers.
> Sorry for bringing up the same discussion. My aim was just to reiterate 
the suggestion you made on the other other thread (i.e. PLIC compatible 
strings) and use the same format used in PLIC block. As these IP 
blocks(pwm & gpio) are also from SiFive for the same Soc (HiFive 
Unleashed board), I was just trying to clarify that this driver also 
follows the exact same convention adopted for PLIC IP block.

Regards,
Atish

> Rob
> 

