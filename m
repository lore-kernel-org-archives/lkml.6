Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCOPP2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:15:28 -0400
Received: from mail-ve1eur01on0069.outbound.protection.outlook.com ([104.47.1.69]:23943
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752018AbeCOPPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:15:23 -0400
From: York Sun <york.sun@nxp.com>
To: James Morse <james.morse@arm.com>
CC: "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Topic: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Index: AQHTu/Mc+CsInsRsN0uQgig0C2tI2A==
Date: Thu, 15 Mar 2018 15:15:20 +0000
Message-ID: <VI1PR04MB20780A707157E71922BD72BA9AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <5AAA7640.3010506@arm.com>
Reply-To: York Sun <york.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
x-originating-ip: [66.235.47.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3983;7:seF6epaxq+DGxcNtUTNpKV/yvjWqqg8mf5iMJCinodK8JGuAAAntaJqOYp2aMsWHoQPucDAhk2BUXDCFTpLdfyUY1l82w+bDAkvUVZjsFypbJlIftwGnlpX+o/1tl4JOSC5WlZneRrkLHTFHtb4UKvC8bRt/DqitcNqhIks93AoCDmoXz2KW8mWbTdPNUEe2+4tE58ziwkSjeyQfXmWmIjuY0PuKKB80hUZMQs3sVu0cmCCnakyAmz/MrSzQ6CkG
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 954a8452-86f2-49e2-8ca2-08d58a87916c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3983;
x-ms-traffictypediagnostic: VI1PR04MB3983:
x-microsoft-antispam-prvs: <VI1PR04MB3983755BFFEF15E0E128C84C9AD00@VI1PR04MB3983.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(189930954265078)(185117386973197)(45079756050767)(211171220733660);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR04MB3983;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3983;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(39380400002)(189003)(199004)(66066001)(6306002)(3450700001)(105586002)(81156014)(8676002)(8936002)(81166006)(45080400002)(2900100001)(316002)(3660700001)(5660300001)(68736007)(575784001)(55016002)(6116002)(5250100002)(86362001)(3846002)(9686003)(102836004)(6506007)(229853002)(53936002)(6436002)(6246003)(53546011)(3280700002)(97736004)(59450400001)(54906003)(2906002)(478600001)(99286004)(43066004)(25786009)(106356001)(6916009)(7736002)(305945005)(14454004)(7696005)(966005)(74316002)(26005)(186003)(33656002)(76176011)(4326008)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3983;H:VI1PR04MB2078.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: k+jzzw7KLaLHTPiekXo5YCXIP5coJxkQI//BWEHK8bcMCR1Mt11Y89WLgNi7pR53Ou591q1ods3XoV+yTwASY5MDGUO5C3EnEFe9xKEvO+HK9aT5V3FTGbPXuPsYD+UUzYNvCw+THzXktwbwk58R0W1UTa14b1LvmRAKKjNa+uxBg4+s4iaV+7Z1Nni9PhCW5RsalgSF6V39qDSQMpoprv7sj10683+MFtD4YaWf4JdxtJp1ZUsna9aEH8Nmz2ydrd5MbGLxIiGvoI4GV/0XKH4+Nmhu61Y0l7Jr4sg+8DJ7t94s8DQ6HOnWSLAPbIaS0UEuY4vIoNg/YqyG5kbHEg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a8452-86f2-49e2-8ca2-08d58a87916c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 15:15:20.5633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3983
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FFFYph014836

On 03/15/2018 06:36 AM, James Morse wrote:
> Hi York,
> 
> You have a DT binding in here, please CC the devicetree list. You're touching
> code under arch/arm64, so you need the arm list too. get_maintainer.pl will take
> your patch and give you the list of which lists and maintainers to CC.
> 
> (I've added those lists, the full patch is here:

Thanks for doing this.

> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fpatch%2F10283783%2F&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=xWmuUtS9dk7PSq1R11L%2F4vpoztnXATAPgtmiqytpnAs%3D&reserved=0
> )
> 
> Some comments below, I haven't looked in to edac or the manuals for A53/A57.
> 
> On 15/03/18 00:17, York Sun wrote:
>> Add error detection for A53 and A57 cores. Hardware error injection
>> is supported on A53. Software error injection is supported on both.
>> For hardware error injection on A53 to work, proper access to
>> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
>> is done by making an SMC call in the driver. Failure to enable access
>> disables hardware error injection. For error interrupt to work,
>> another SMC call enables access to L2ECTLR_EL1. Failure to enable
>> access disables interrupt for error reporting.
> 
> This is tricky as there are shipped systems out there without these SMC calls.
> They need to be discovered in some way. We can't even assume firmware has PSCI,
> it has to be discovered via APCI/DT.

Using the return values from SMC calls, we can detect if such calls
exist. Without these SMC calls, hardware error injection is removed from
/sys interface for A53. A57 doesn't have this feature anyway. Similarly,
without these SMC calls, interrupt is not used so the driver only works
in polling mode.

> 
> I think it will be cleaner for the presence of this device/compatible to
> indicate that the registers are enabled for the normal-world, instead of having
> the OS try to call into firmware to enable it.

I don't disagree. Doing this requires updating device tree. For my case
using U-Boot, this needs to sync with U-Boot. I would prefer not to. I
can imaging this would be the same for UEFI.

> 
> 
>> Signed-off-by: York Sun <york.sun@nxp.com>
>> ---
>>  .../devicetree/bindings/edac/cortex-arm64-edac.txt |  37 +
>>  arch/arm64/include/asm/cacheflush.h                |   1 +
>>  arch/arm64/mm/cache.S                              |  35 +
>>  drivers/edac/Kconfig                               |   6 +
>>  drivers/edac/Makefile                              |   1 +
>>  drivers/edac/cortex_arm64_l1_l2.c                  | 741 +++++++++++++++++++++
>>  drivers/edac/cortex_arm64_l1_l2.h                  |  55 ++
>>  7 files changed, 876 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
>>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.h
>>
>> diff --git a/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>> new file mode 100644
>> index 0000000..74a1c2f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>> @@ -0,0 +1,37 @@
>> +ARM Cortex A57 and A53 L1/L2 cache error reporting
>> +
>> +CPU Memory Error Syndrome and L2 Memory Error Syndrome registers can be used
>> +for checking L1 and L2 memory errors. However, only A53 supports double-bit
>> +error injection to L1 and L2 memory. This driver uses the hardware error
>> +injection when available, but also provides a way to inject errors by
>> +software. Both A53 and A57 supports interrupt when multi-bit errors happen.
> 
>> +To use hardware error injection and the interrupt, proper access needs to be
>> +granted in ACTLR_EL3 (and/or ACTLR_EL2) register by EL3 firmware SMC call.
> 
> How can Linux know whether firmware toggled these bits? How can it know if it
> needs to make an SMC call to do the work?

It is done in probe function in this driver.

> 
> This looks like platform policy, I'm not sure how this gets described...
> 
> 
>> +Correctable errors do not trigger such interrupt. This driver uses dynamic
>> +polling internal to check for errors. The more errors detected, the more
>> +frequently it polls. Combining with interrupt, this driver can detect
>> +correctable and uncorrectable errors. However, if the uncorrectable errors
>> +cause system abort exception, this drivr is not able to report errors in time.
>> +
>> +The following section describes the Cortex A57/A53 EDAC DT node binding.
>> +
>> +Required properties:
>> +- compatible: Should be "arm,cortex-a57-edac" or "arm,cortex-a53-edac"
>> +- cpus: Should be a list of compatible cores
>> +
>> +Optional properties:
>> +- interrupts: Interrupt number if supported
>> +
>> +Example:
>> +	edac {
>> +		compatible = "arm,cortex-a53-edac";
>> +		cpus = <&cpu0>,
>> +		       <&cpu1>,
>> +		       <&cpu2>,
>> +		       <&cpu3>;
>> +		interrupts = <0 108 0x4>;
>> +
>> +	};
>> +
> 
>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
>> index 76d1cc8..f1cd090 100644
>> --- a/arch/arm64/include/asm/cacheflush.h
>> +++ b/arch/arm64/include/asm/cacheflush.h
>> @@ -73,6 +73,7 @@ extern void __clean_dcache_area_pop(void *addr, size_t len);
>>  extern void __clean_dcache_area_pou(void *addr, size_t len);
>>  extern long __flush_cache_user_range(unsigned long start, unsigned long end);
>>  extern void sync_icache_aliases(void *kaddr, unsigned long len);
>> +extern void __flush_l1_dcache_way(phys_addr_t ptr);
>>  
>>  static inline void flush_cache_mm(struct mm_struct *mm)
>>  {
> 
>> diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
>> index 7f1dbe9..5e65c20 100644
>> --- a/arch/arm64/mm/cache.S
>> +++ b/arch/arm64/mm/cache.S
>> @@ -221,3 +221,38 @@ ENTRY(__dma_unmap_area)
>>  	b.ne	__dma_inv_area
>>  	ret
>>  ENDPIPROC(__dma_unmap_area)
>> +
>> +/*
>> + *	Flush L1 dcache by way, using physical address to find sets
>> + *
>> + *	__flush_l1_dcache_way(ptr)
>> + *	- ptr	- physical address to be flushed
>> + */
> 
> We don't have set/way maintenance in the kernel because its impossible to do
> correctly outside EL3's CPU power-on code.
> 
> The ARM-ARM has a half page 'note' explaining the issues, under 'Performing
> cache maintenance instructions' in section "D3.4.8 A64 Cache maintenance
> instructions". If you have DDI0487B.b, its on Page D3-2020.
> 
> These may also help:
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2016%2F3%2F21%2F190&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=cGfumC%2BDk6y5XVnkH3orgVYovhT1KHPmsXfkKo6veIE%3D&reserved=0
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fevents.static.linuxfound.org%2Fsites%2Fevents%2Ffiles%2Fslides%2Fslides_17.pdf&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=z0HTGOfZeuhY9YtFFAm4rBB9v%2BsapRHOZX2TPPZEjus%3D&reserved=0
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.linux.com%2Fnews%2Ftaming-chaos-modern-caches&data=02%7C01%7Cyork.sun%40nxp.com%7C794bff898fae4046bb9d08d58a79c482%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636567177956904165&sdata=KZOY2ESFrl55ojinzG7eiPzwFHLTBx1VJvGZ3hdchiE%3D&reserved=0
> 
> Why do you need to do this? There is no way to guarantee an address isn't in the
> cache.
> 

It was suggested by ARM support. The purpose is to flush L1 cache with
concerned address and cause a write to L2 cache, which in turn injects
the error. The whole idea is to safely inject uncorrectable error(s)
without corrupt the system.

I am going to stop here since I received Mark's comment in another
email. Your comments are very valuable and very much appreciated.

York
