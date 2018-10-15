Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E86C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162522064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 16:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hUcbQIcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162522064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJPA2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 20:28:22 -0400
Received: from mail-ve1eur01on0072.outbound.protection.outlook.com ([104.47.1.72]:7728
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbeJPA2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 20:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4fbhgPvcAMXDU/QXE525SOpFOn88rfkGhC8ZNE+od8=;
 b=hUcbQIcqCafRTxC3mFG9JG+MkJcCDvDU9YBuVVJUIdr14yJtCwG2QE1ov0mohqeMFbB1idnCK3NVfMwXtFpj57/rMsYo9xtsi2eeKnTaAOYcuHQikdsVQ9tZK+1jsnJENW0iZWKhSnI5pFwzF/45m3HNOwA6jv9+Yl8Cw18W234=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
Received: from lakrids.cambridge.arm.com (217.140.106.49) by
 DB7PR08MB2986.eurprd08.prod.outlook.com (2603:10a6:5:1c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Mon, 15 Oct 2018 16:42:17 +0000
Date:   Mon, 15 Oct 2018 17:42:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] arm64: dts: meson: fix reserve memory regions
Message-ID: <20181015164214.hpqz7zear2c44ijd@lakrids.cambridge.arm.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
 <20181015162833.7544-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015162833.7544-2-jbrunet@baylibre.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: CWLP265CA0219.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::15) To DB7PR08MB2986.eurprd08.prod.outlook.com
 (2603:10a6:5:1c::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c431f3d-e6a9-4ebe-fd11-08d632bd2b0d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB2986;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2986;3:OvPP7rxfRJlkLG1/qOG9z+CauJahYlSj1/ui5gYLRAtnKt2lyW8Kod7OlCxfycmhWpsxm3kdW7rtPL5aQfdTKm4/8a1bLyUNdgV93S4pnEA6ukLPiAjj3FeE5FHp0KGIKnxZCmoBOclL1nbsF81mv3veaBwRThgd7FcCs1+ygB/osDH0UQhqSHmzVHnC4zj/dLbGwJBkD9tsMQtt4WW+oB+INo0AEK6Ygc2ijJ30IISLDsJqmwlEask/C+U1Lofm;25:UuBWYBLtFQTkM5PK/6sQzOVCtxPzTvz9uvsjLwWsS27+IlQ63+5CbNI/sKm5ym9uMtT/MyYjusNsWWdg+qY+1LffaYQ0bew4krARR6EtGm0dscDENg59H2hohXT5I7Q3aIAFGq0He/8zUPCnIbKjKpq/7Ggq5HhmqSk+0wj+5tSFdivBDBR2q5SL5qlwjRKj6XR/Zr7Dr5NAH44GVzQOnoye/OskYZ2uTZlNVX0IE0Q70IEAj4PjXfJpUgRQnxdQhpu4+AoPCsbtCRPwUj+LTLa20ovrr2dkcbN83NLiLf+2MWeTntXjO4eT/GvXoibjOFpVVcKuqTmYt4UwMNsOSA==;31:+e4j8zKkqXlUgw71f+jxRSkmPhR9gHzxy4CgME1OZnzxzR68NS/Ka4pEZIuOUCbENSbIqh81YYsjn7PeUjJVtHGCQdYk4Ug8mvVxVfDVzY/djIwPzroV98uWSbjd3tHdVP7w4LMiN38rqw3XaplFmT/cTtHpTjz+nrJeE2x70yeSEdpWxIYMI6YgpHFi26n+Ht2jOrRt8uVKfU31EWhh7DboX7AzUT2LFPNU9fudbR8=
X-MS-TrafficTypeDiagnostic: DB7PR08MB2986:
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2986;20:jo8Whz+jV3ESoRP0AT7vB+IcAnUabF8uQVzbRtbowvHF/qXzIgvhv1QMFISFTdmpScVw5b5ZPTsFE2nOXuOErXKYYOqclHorRQx7SHvsv6AhDWJXbXGdB61LwRXy51SB+6Dwsjvdm52CCYktfL6LlBRlIj1+R9ilAXo/JG8+dFcQF2/JpF7+3NcCOq8OossoIvbFZtKA5+zgMSbIr2jgLnDB12DZN48zR44txvVtOJGHKklNPIpL5niBGU/vB0NII6bdi2ro3qf8W6GOGYewkSiC+ZOgYeYJw99E+crBNG/X6iPul1kR4GG/gNNctdGh0zCZYEQlWj751cG+n6TZy2xc+w9iMExEBUL5OKMFnWbj8akAJoCFMbx7zMeDefHOdcT57iOOhZQW02VQZKHhH29PCMt2R9repEoKqnksf3zWh6nonJC6C5Fju0gB0Y8Zvctwt07sJyeWpho/5SMMge+p5A6y396mo3+GhriSZNfgWej+CQ2Lx2uc2PsjEtl0;4:SE+M9Hv2ZmhHMDrd7RbWMwBY4TI4p6ZmXSAfar9JuU3zaQOVPc9pYlP/Pc3rR2wOs/bc5ozQFWav9YB4s3sauC/BrsFbD40/Dd+lSDwXmCtDQPH58/Kd66jRG3c46wEq4Ke11fq/TddJK1IC+nV3mYQeqfGhWD9aXhiwFNz+N7Lg9ISKorFp3dTYeZsx/la57eK6/VM4wq5COchGY+BH/ijZIBa3EGa5xcRaDbmDmFa6M6Z6yo6K0P7vDu3n3p6Dyu6RGTMPqyjYl9EW+G6EB9MblggqDGsVzbS6StwRuulJLXc4KOFHsNAAyDkbuLNu
X-Microsoft-Antispam-PRVS: <DB7PR08MB2986411DFB85793658FD9FAF84FD0@DB7PR08MB2986.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB7PR08MB2986;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB2986;
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(376002)(136003)(40434004)(189003)(199004)(55016002)(3846002)(6116002)(66066001)(23726003)(81156014)(72206003)(25786009)(81166006)(4326008)(8676002)(478600001)(50466002)(2906002)(6916009)(44832011)(186003)(446003)(26005)(956004)(11346002)(68736007)(86362001)(476003)(16526019)(1076002)(486006)(7736002)(106356001)(386003)(76176011)(316002)(6246003)(5024004)(14444005)(7696005)(105586002)(52116002)(5660300001)(58126008)(47776003)(45080400002)(6666004)(305945005)(97736004)(8936002)(53936002)(8746002)(54906003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2986;H:lakrids.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB2986;23:Oe0ihdUiG/j0S9uE8YHl6kZizSqoiADgE/niFnGOE?=
 =?us-ascii?Q?Ut7X6h9c3TZn7lH6vXJ69adMGU0qFUMKcnS6m/Vp3qnJqm6p5RVjBPKalXZA?=
 =?us-ascii?Q?VXZ11wKfg7O97PLPkPRTbvjDLrKy+Pvct369DT8Ld8p+sgZp5c/KQUSPhU2q?=
 =?us-ascii?Q?CBk/eToApNNo0Alr6/aP1IZzhd3t21cJ8YzUYLoBY+fFhCepFezUoSOesCSr?=
 =?us-ascii?Q?mQ2EKYmU/xHyE5gqJdvw6lj3TvbMBs0sd8XcQUDVO0kcTIFUnLdBs5Z96i/Y?=
 =?us-ascii?Q?qc9yHhkbgYCrwmL4Qou0iB9JDUzjW1s5CyE7QP87iV3KJcTV3jD3I8PyQMy1?=
 =?us-ascii?Q?SH5kHi0d/9NEFEbAPeg2pA7uchkUo/x9jRGFIX/hiGaHeZcYx4A9mhHd217i?=
 =?us-ascii?Q?8kJEdkUjRX+YvihzQO+eUZay59zOz3G3M/S5RPBfxg4sKH8MVdileHM/E6Q+?=
 =?us-ascii?Q?A87gdwOX6fJOoq4K5n+MPyhVsBMBjIOpi5CAZZOYTw/0nc7McmIfNjt64XKX?=
 =?us-ascii?Q?vf15Z+H9ECOy37a2v+9vLRJw9gEJNFXM+yfPOsAbLA9b/YC0EjFpInrNpnJo?=
 =?us-ascii?Q?YB2P7JFLX8hs/cl5+/4dMFAN15f2cnaq2sn2Mf0ZYv6JZWjZpKaNhfDLZOu5?=
 =?us-ascii?Q?DtGAEnCYpyD3lpdOYjUrhPs2GNSFW+XF2Qo7XrIwUvXwjz6YKDSXbdW99aAT?=
 =?us-ascii?Q?JU+UYoeBb46YL9X51Xc11ERO42TmKbxwPRyVEUOJcrPCYIxxOllN6n7+Kkba?=
 =?us-ascii?Q?52gMrTgVF0nhe5bxxoDMypqykbLdSsDxTzGwOk3ptuWoadJn4RXoAzqo4WmS?=
 =?us-ascii?Q?vT6olhz5jI+pQIAHe4xa/CaLrnBleFzd5x0mg/y+eOutCTDCuR9btnbPTAWW?=
 =?us-ascii?Q?Evn2rdufdgRz4A2Sj28NfeCMYjFsWITJ57km2IWqR5J9uZoxNZ2aTjVIYPvB?=
 =?us-ascii?Q?N7AxxkGrf5aXEYdqPkcJxsCCnUU7m6+WVk7Wa8BCED/2cmtAaovQWmkY5RVD?=
 =?us-ascii?Q?oSfGmeFcn+G0CPk923zntyBFF17hg7prO/pRUaN4OtsToNoVa9TQ2BMhNLHW?=
 =?us-ascii?Q?34u62BA9R8P4dp05Zq6pbdkbwr2jtFdxccVymHOSpIzCZq4DNYSCQ5SVPYh1?=
 =?us-ascii?Q?jYdz5BqWOuJRm3fbSSiIFOdIyuk2EVdKmfZZyEWsYzJANDJyHc4/8dIIB4tN?=
 =?us-ascii?Q?kUkqdygza/cGfKIS69887aKnI1pguOmYNXqcsGhsWnaymUaBswNAbiYuzWqE?=
 =?us-ascii?Q?sF+wAdObzncAhlJ/TdMkC2N0L/z7DrlEgvPS0+YgpNSW+qOwU6c03v5Efl9B?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: FpgKKhtauFCTfCrXJ/iQGVOWcprVaxD+zHOiVCVnjabDPH6TaT/b2gdSlbQbK8/ycF0i2GUjSrH7YdIZtt2XVrk4MTMm+9Y3N23U2CE7qfveqVCP1BvSlM4Mh4sk6ZFThDVegTx6KxzHaBjiuoOm0G34zzht595fvmRqXCm2QprDF+yxTw8aQAeN9SCTSYMhPLtsashN3n7Q4GamJQ0XjXekzO4mmGMGX+7BCcbIuGJfeR639J+aOMMzaDzFIOqfcbBqwmsaQNQfF+f1BNVKejR90kaa4Tj7HV2QeABGtfpoOkZoY1O8JK/WbNmTGjEFWGsskZt/Q1jJvq3I8aF6KlOCJ7zPem8cB7UFLCMYEYE=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB2986;6:DWVLxS+PEFKik28GZ02jy0zquqjGHqgqxfNGctPAMP1H24XwrMVEJ728UE/TgOzL/ynYmPkE7ICUwCouZ44g4WNnDIjcWHMmywbIAyBpvN0UAbYxN1pJ+rNLSsHmVjhB0GJzJSUdbTVvSNssEjPjSnTLq28l91WJp7spx2sbAwwLg7NXAEr8PoTSB8XzWQhTcxiJDghGY3UOVlJyJYHDTSYkMbB8/l8yOJVJ+En1oGoqs1+rklpyUA6mFsruSeIovr7jXgIy+ogwe1tLM+sqCjwC5bzYot3QFp+t/A3Z7imVG9xgUT8DgV+8Y0hWCDa3wfb05kiFtQ73bcWF6J80E+EVkZRCh+flSX8vBgETOTmLdtWkF1Pdl8PhwKYkbH7O6hMJrhs9yrGUx4QUbb6iiw90h1+ee9adL44TYZh5E6S/lGTe6rrXFkv2bBfG0mDCOWds4G/HNfofdtI8m4GFfw==;5:l9qt+RdkaOdvBgFYbUH2TIOKWkhFcOXdkIwTlFPuHdPtTZdjX3njQB2Eyyi7tDBscySyzg6B1ZZR1Mt9l85zH3nZCgnGGD4iEoc7wFKXIpSUROr+r5EusOtKba+qzkxlg/W5mBcqBqBaPRzF/rrr1suZZE9r5zomXw8kt/30NtQ=;7:CwFQo9dRlXuQaeYsxHhKTUhisx4SG9aV+htr/zgOK/hoBdbp7oc7kYSYEsTRDk2MQGS9Yjd0lc/9Ix7HSfjQY8EyWKP2wPssmGXpqRK/FTOOfNTCtIFTHRzsCL+IXAVbio2yizWjjIWzgg91+Vv3wJMWQCElk3uFIEVGWaPA/mczSwA4A3Ev4sfkm7RLWrkeZtcCccfHqYZUXRGXXUed0g0gYOvTt6mu7y56qOqDcgWQ8+QoILRwy2451wBG9kNW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 16:42:17.0017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c431f3d-e6a9-4ebe-fd11-08d632bd2b0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:28:32PM +0200, Jerome Brunet wrote:
> Since commit 50d7ba36b916 ("arm64: export memblock_reserve()d regions via=
 /proc/iomem")
> was merged Amlogic's boards using mainline u-boot started showing the
> following warning:
>
> WARNING: CPU: 0 PID: 1 at arch/arm64/kernel/setup.c:271 reserve_memblock_=
reserved_regions+0xd8/0x144
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc7-00263-g385684b3eb27-=
dirty #254
> pstate: 40000005 (nZcv daif -PAN -UAO)
> pc : reserve_memblock_reserved_regions+0xd8/0x144
> lr : reserve_memblock_reserved_regions+0xd0/0x144
> [...]
>
> This is due to u-boot setting some /reservedmem/ region while our
> dts declares reserved memory on the same region with no-map.
>
> The conflict produce the warning. This is fixed by using /reservedmem/
> in our dts as well, which is probably something we should have done from
> the beginning.

A /memreserve/ does not ensure no-map, and the kernel will map regions
which are described in a memory node and only protected with a
/memreserve/ entry.

Is it safe for the kernel to map these? e.g. speculative fetches won't
trigger a TrustZone controller to reboot the system?

... or are they not in memory nodes to begin with?

Thanks,
Mark.

>
> Cc: stable@vger.kernel.org
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>
> Hi Kevin,
>
> I would have liked to put a Fixes tag above but I could not figure out
> which commit to pick, considering how much we changed those regions in
> the past. If you have suggestion, I'll be happy to repost this patch.
> If you prefer, feel free to amend this patch directly.
>
> Cheers
> Jerome
>
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 24 +++++--------------
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 27 ++++++++--------------
>  2 files changed, 15 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot=
/dts/amlogic/meson-axg.dtsi
> index 178d8e8c56b8..06a06f11f114 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -13,6 +13,12 @@
>  #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>  #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
>
> +/* 16 MiB reserved for Hardware ROM Firmware */
> +/memreserve/ 0x0 0x1000000;
> +
> +/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
> +/memreserve/ 0x05000000 0x300000;
> +
>  / {
>       compatible =3D "amlogic,meson-axg";
>
> @@ -115,24 +121,6 @@
>               method =3D "smc";
>       };
>
> -     reserved-memory {
> -             #address-cells =3D <2>;
> -             #size-cells =3D <2>;
> -             ranges;
> -
> -             /* 16 MiB reserved for Hardware ROM Firmware */
> -             hwrom_reserved: hwrom@0 {
> -                     reg =3D <0x0 0x0 0x0 0x1000000>;
> -                     no-map;
> -             };
> -
> -             /* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31)=
 */
> -             secmon_reserved: secmon@5000000 {
> -                     reg =3D <0x0 0x05000000 0x0 0x300000>;
> -                     no-map;
> -             };
> -     };
> -
>       soc {
>               compatible =3D "simple-bus";
>               #address-cells =3D <2>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-gx.dtsi
> index 676a995fb912..23e879b29b1e 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -13,6 +13,15 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>
> +/* 16 MiB reserved for Hardware ROM Firmware */
> +/memreserve/ 0x0 0x1000000;
> +
> +/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> +/memreserve/ 0x10000000 0x200000;
> +
> +/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
> +/memreserve/ 0x05000000 0x300000;
> +
>  / {
>       interrupt-parent =3D <&gic>;
>       #address-cells =3D <2>;
> @@ -23,24 +32,6 @@
>               #size-cells =3D <2>;
>               ranges;
>
> -             /* 16 MiB reserved for Hardware ROM Firmware */
> -             hwrom_reserved: hwrom@0 {
> -                     reg =3D <0x0 0x0 0x0 0x1000000>;
> -                     no-map;
> -             };
> -
> -             /* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> -             secmon_reserved: secmon@10000000 {
> -                     reg =3D <0x0 0x10000000 0x0 0x200000>;
> -                     no-map;
> -             };
> -
> -             /* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31)=
 */
> -             secmon_reserved_alt: secmon@5000000 {
> -                     reg =3D <0x0 0x05000000 0x0 0x300000>;
> -                     no-map;
> -             };
> -
>               linux,cma {
>                       compatible =3D "shared-dma-pool";
>                       reusable;
> --
> 2.17.2
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
