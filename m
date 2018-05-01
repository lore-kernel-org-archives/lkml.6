Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3390839-1525192058-2-10623950010358160992
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525192057; b=E2uSorW97I3XlJMa4R4psY5ifG+CIB2Zq/MlWOQzXHsFMPaOlK
    Fw1h5hI3QgkuUwmrVNYeTt/Y/Ym/RAkbdEkEbmVpdwtvuJYtzmlpvgXrNAV+p2n3
    kSEc6omrHsBRQ9A/mz9RnzeIFDyIYHXjl8jREyWPHqAJsDvmTEdNlyGYkreYTEEF
    3Au2WqXEYS5VtbV39tGwLBQLZQicrnt+kOU1FfKD+ihMtvChiYjy6TozwT3tJQ9z
    OeCuTmcRqz+B1/GnQozGbDo2swW83R1ovWG/thBu2jZ+K9M6Hn/S60Xh2M5C0Erm
    QeSaEuAmCc3bPOqoNSL4UVIQ8uMGN7Z63DoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525192057;
    bh=SbGtr9KnEt4nBSlG19WLJqGO6lZ2uWQZjsrh1L6tYqo=; b=B3fyDZ/JDIzL
    I+wPeDTEwQeIGe/t/g4U+J8VbUiqcINrH1oskcFGfTPDcG1jM/e7gDfpTZAEBaC+
    bMuE4ziMVJX/v8FIpGJAnht36CdHFPvtZ+RM7Zc+FywGWJcI5CAR5BN5YUICjYrm
    rssJUYOrxW/rasmqyYUVqrMjGv0+7VieqLbk7+7WkbaLu/1D/ZxNmBMXBFugTm5V
    DX5wPt1JiBQByHa2UnhnkD5hWfCOqEYYMB/GuBynn6R6RjeSBOPT54emMk6B53s0
    XjI+a8/+gbDBBfsmmDMfqx4ouHNY4A5th9zkqjUxdhhd5UF3i+z9KcJAARmW6t6N
    +8wQO2zUnQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOVDJPGgeJoXhVy9JCwmpmnz1K0EPW92Sc0zhTV+qIEZYTBj+tZ31rftnzrKaE1XgiRf8ZjLyKon3z5hKfuy1zz2z+cue7C+ZUurtTbVLojOuCZjpOOX
    4uZq91MnWZ/4idc75F28umaxwhugAEIasGrPmXvB3gc0tna0jfMw6RbtKC0ewZFithv3whR8uYzeLOy73GCtUPv+yvH2EXeL0J4eE5Tn33wi9r8t8XV10yTG
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pmxv_ynd5a0dMasF_CwA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755132AbeEAQ1f (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 12:27:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:33612 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755276AbeEAQ1e (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 1 May 2018 12:27:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,351,1520924400";
   d="scan'208";a="47462746"
Subject: Re: [PATCH] clk:aspeed: Fix reset bits for PCI/VGA and PECI
To: Rob Herring <robh@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable <stable@vger.kernel.org>
References: <20180426172232.12535-1-jae.hyun.yoo@linux.intel.com>
 <20180501150236.GA15330@rob-hp-laptop>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <5a449d93-eef0-4243-9889-bd13786edde1@linux.intel.com>
Date: Tue, 1 May 2018 09:27:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180501150236.GA15330@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Rob,

Thanks for your review. Please see my answers inline.

On 5/1/2018 8:02 AM, Rob Herring wrote:
> On Thu, Apr 26, 2018 at 10:22:32AM -0700, Jae Hyun Yoo wrote:
>> This commit fixes incorrect setting of reset bits for PCI/VGA and
>> PECI modules.
>>
>> 1. Reset bit for PCI/VGA is 8.
>> 2. PECI reset bit is missing so added bit 10 as its reset bit.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
>> Cc: stable <stable@vger.kernel.org>
>> ---
>>   drivers/clk/clk-aspeed.c                 | 4 ++--
>>   include/dt-bindings/clock/aspeed-clock.h | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
>> index 5eb50c31e455..2c23e7d7ba28 100644
>> --- a/drivers/clk/clk-aspeed.c
>> +++ b/drivers/clk/clk-aspeed.c
>> @@ -88,7 +88,7 @@ static const struct aspeed_gate_data aspeed_gates[] = {
>>   	[ASPEED_CLK_GATE_GCLK] =	{  1,  7, "gclk-gate",		NULL,	0 }, /* 2D engine */
>>   	[ASPEED_CLK_GATE_MCLK] =	{  2, -1, "mclk-gate",		"mpll",	CLK_IS_CRITICAL }, /* SDRAM */
>>   	[ASPEED_CLK_GATE_VCLK] =	{  3,  6, "vclk-gate",		NULL,	0 }, /* Video Capture */
>> -	[ASPEED_CLK_GATE_BCLK] =	{  4, 10, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */
>> +	[ASPEED_CLK_GATE_BCLK] =	{  4,  8, "bclk-gate",		"bclk",	0 }, /* PCIe/PCI */

This is the clk/reset combined setting for PCI/VGA and '8' is the reset
bit for itself so no additional reset bit setting is needed. A reset
will be triggered when BCLK is enabled.

>>   	[ASPEED_CLK_GATE_DCLK] =	{  5, -1, "dclk-gate",		NULL,	0 }, /* DAC */
>>   	[ASPEED_CLK_GATE_REFCLK] =	{  6, -1, "refclk-gate",	"clkin", CLK_IS_CRITICAL },
>>   	[ASPEED_CLK_GATE_USBPORT2CLK] =	{  7,  3, "usb-port2-gate",	NULL,	0 }, /* USB2.0 Host port 2 */
>> @@ -297,7 +297,7 @@ static const u8 aspeed_resets[] = {
>>   	[ASPEED_RESET_JTAG_MASTER] = 22,
>>   	[ASPEED_RESET_MIC]	= 18,
>>   	[ASPEED_RESET_PWM]	=  9,
>> -	[ASPEED_RESET_PCIVGA]	=  8,
>> +	[ASPEED_RESET_PECI]	= 10,
>>   	[ASPEED_RESET_I2C]	=  2,
>>   	[ASPEED_RESET_AHB]	=  1,
>>   };
>> diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
>> index d3558d897a4d..8d69b9134bef 100644
>> --- a/include/dt-bindings/clock/aspeed-clock.h
>> +++ b/include/dt-bindings/clock/aspeed-clock.h
>> @@ -45,7 +45,7 @@
>>   #define ASPEED_RESET_JTAG_MASTER	3
>>   #define ASPEED_RESET_MIC		4
>>   #define ASPEED_RESET_PWM		5
>> -#define ASPEED_RESET_PCIVGA		6
>> +#define ASPEED_RESET_PECI		6
> 
> You can't really be changing these as they represent an ABI.
> 
> Is there no PCIVGA reset?
> 

This is a bug fixing. Previously, PCI/VGA used PECI reset bit so this
patch corrects the reset bit for PCI/VGA from bit '10' to bit '8', and
it adds PECI reset bit '10' here as it can't be combined with a clock
gate bit.

Thanks,

Jae

>>   #define ASPEED_RESET_I2C		7
>>   #define ASPEED_RESET_AHB		8
>>   
>> -- 
>> 2.17.0
>>
