Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-458642-1521522547-2-7824771024162240624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ennlro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521522546; b=RRxBIjwi5VC/AgtqThRIs+RtJFj1Svtm3RiSRLhY2FLffyv
    /3089+NxNqeHOrne/jlj0OGyki3RjYqzE7xUtMrdUgpCeOijAKbOpudTsD20L6Gm
    dYHqQg7jINnNH5Ji8zw+pU9nEIJOZkodBX37Jdgb7QqZxJixuYbBenHqqAjR/R/+
    rWM4ZPXJWUEfHXGc9sa/h1FSZZZ4OyF43b22S/CnfTnKPYLdvoMPNQdcHuzdOS+o
    v1oaZx9afR+CQFOyM9p42Z5/gz7LZtDIjZ01HZhXyTqV4jEEyssyGhDG5gGYntTS
    UCh0UBwPQTfBQU4wao/EeBYI8KCuYlxueYqqfng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521522546; bh=JAdhYakm9m3kD4VtMpvf/fig3PUVwJoNovqvJP1GVfA=; b=g
    cs84kEYt1PgILd2mP3wdf8mrEn9DM19FGLE1Rw7kiRobD9voeITdZNGJcNMbTLry
    2EnxHXI2R41RCMGLv2kdLMsCBLpKCgGUlUtuWwfXRubOraeDn13jpGqiKywdpblx
    sX1Nzi1hdioX31bVDcCjKnAbvoZQslBniCbWjqNUrw2RX1MBlB+45mfOcHEe0Vvu
    n/SAoPRmr+8Qy9LSSCZp+N0dw7Dz/qCc90efeRROUbKLwHtApxTgBY7cgNtMV4rd
    cM7Re6tQlsi32O8PKkrJ+GrZ678B8/XYE+wlqwMz5nwHRnY8d6Ok80uLsKQKRWbW
    4nNoLfaWM0KFGrTwlTmig==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=cqewb7m2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=cqewb7m2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeCTFJD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 01:09:03 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:43333 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeCTFJC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 01:09:02 -0400
Subject: Re: [PATCH 4.4 038/134] ARM: DRA7: hwmod_data: Prevent
 wait_target_disable error for usb_otg_ss
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180319171849.024066323@linuxfoundation.org>
 <20180319171854.858515505@linuxfoundation.org>
 <20180319235251.ui2gf3nlg2icbbdx@xps>
From: Tero Kristo <t-kristo@ti.com>
Message-ID: <f43909b9-e4d2-2279-9857-1e10a03197c7@ti.com>
Date: Tue, 20 Mar 2018 07:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319235251.ui2gf3nlg2icbbdx@xps>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20/03/18 01:52, Dan Rue wrote:
> On Mon, Mar 19, 2018 at 07:05:21PM +0100, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Roger Quadros <rogerq@ti.com>
>>
>>
>> [ Upstream commit e2d54fe76997301b49311bde7ba8ef52b47896f9 ]
>>
>> It seems that if L3_INIT clkdomain is kept in HW_AUTO while usb_otg_ss
>> is in use then there are random chances that the usb_otg_ss module
>> will fail to completely idle. i.e. IDLEST = 0x2 instead of 0x3.
>>
>> Preventing L3_INIT from HW_AUTO while usb_otg_ss module is in use
>> fixes this issue.
>>
>> We don't know yet if usb_otg_ss instances 3 and 4 are affected by this
>> issue or not so don't add this flag for those instances.
>>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This fails to build for me on arm32 with default config.
> 
> #
> # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm multi_v7_defconfig
> #
> #
> # make -j10 -k -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=build-arm
> #
> ../arch/arm/mach-omap2/omap_hwmod_7xx_data.c:2243:12: error: 'HWMOD_CLKDM_NOAUTO' undeclared here (not in a function)
>    .flags  = HWMOD_CLKDM_NOAUTO,
>              ^
> ../scripts/Makefile.build:269: recipe for target 'arch/arm/mach-omap2/omap_hwmod_7xx_data.o' failed
> make[2]: *** [arch/arm/mach-omap2/omap_hwmod_7xx_data.o] Error 1
> make[2]: Target '__build' not remade because of errors.
> /home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/multi_v7_defconfig/label/builder/Makefile:969: recipe for target 'arch/arm/mach-omap2' failed
> make[1]: *** [arch/arm/mach-omap2] Error 2
> make[1]: Target '_all' not remade because of errors.
> Makefile:152: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
> make: Target '_all' not remade because of errors.

This again has some dependencies, at least:

8ff42da41147 ("ARM: OMAP2+ hwmod: Allow modules to disable HW_AUTO")

-Tero

> 
> Dan
> 
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
>> @@ -2240,6 +2240,7 @@ static struct omap_hwmod dra7xx_usb_otg_
>>   	.class		= &dra7xx_usb_otg_ss_hwmod_class,
>>   	.clkdm_name	= "l3init_clkdm",
>>   	.main_clk	= "dpll_core_h13x2_ck",
>> +	.flags		= HWMOD_CLKDM_NOAUTO,
>>   	.prcm = {
>>   		.omap4 = {
>>   			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
>> @@ -2261,6 +2262,7 @@ static struct omap_hwmod dra7xx_usb_otg_
>>   	.class		= &dra7xx_usb_otg_ss_hwmod_class,
>>   	.clkdm_name	= "l3init_clkdm",
>>   	.main_clk	= "dpll_core_h13x2_ck",
>> +	.flags		= HWMOD_CLKDM_NOAUTO,
>>   	.prcm = {
>>   		.omap4 = {
>>   			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
>>
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
