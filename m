Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeC3Rkx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:40:53 -0400
Received: from mail-eopbgr20137.outbound.protection.outlook.com ([40.107.2.137]:59167
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751318AbeC3Rku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:40:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Fri, 30 Mar 2018 10:40:23 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [03/10] genksyms: generate lexer and parser during build instead
 of shipping
Message-ID: <20180330174022.GA8890@outlook.office365.com>
References: <1521810279-6282-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1521810279-6282-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: MWHPR12CA0058.namprd12.prod.outlook.com
 (2603:10b6:300:103::20) To AM4PR08MB0740.eurprd08.prod.outlook.com
 (2a01:111:e400:59ed::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e0298f-c70e-40e1-dc0f-08d596655cf8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB0740;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;3:X3lfQIupsPQXjxvl86prxm2TvlAwt6d7U0x9tGxfkF1TU7sYo2EqhtUEClhm/f+9rGL0dpXvTSxPu0QEysEEKumf49Dv0sVYzprOwj0lTy0LoBsFqDOqFJ6DB+cqpvDdozQK75gI9rixy3u0FHT8uIdRCJqZ9KRHLmLwOKOMn8PMYcrzmC+Ow3cOQj+nsspGMI+LMHrJ2lu8I1H8SuKzvLV4cllzi/+TzIXx5w/z+/bhc/P38qDysWucdIQRP8tZ;25:darS8rQ14+prRhF5B3wuEFMjGyGdGs6y/W0S+fGlFw8wdYzNUS/8zqfbBbvszw7NFLG0WPewUds9GIDKbpzvewqlSM0Mnd71ArDzGxIhaoqbBY5gkqn4B1N1IGW2qWrHL4MjjlA+TCt1KRf8TChRHkSaQKHKIAD/mbbmBdEA25LqckwMv6PFcowmMBnUr/ekMxgPGPo1vi9x/7MFpvpH5JPf4e6zX6xKfTjbbXxPvuW5gXTHuYrudkxkwKc6yBnfEFmKgugQ1fyD9/3fIQhI0zSmyKfCuHw7TX5BcHa4A4RZgXgoeoAaYeUVHcoAbMupWOnnv4xBF3W2RjQwNkQhPw==;31:+bgf75Z/LgytN9NYxehmBBbBNvkgYndUGSEoi/V6LVsBhNJiCZ9mqKIErN2yOc2+zUsvjngTv665wDXvmYURYBwLmrb0PIH4LIzKsfHMCCnlMqqMT6Uxppk1cVl4U4K0deWQWeXGplumDSmLjdkCc1EnmhKPH/3XjQYXz3uLyajcMjXY+EUj9p7fQXTrEXxpLa9o4XRzxWXWWmTzael09/AMG1v/cRW7iQ9h4UeO1X8=
X-MS-TrafficTypeDiagnostic: AM4PR08MB0740:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;20:cZHhQXNv5il77XcIrFhTQtPVyyWLMSm50GPwsogP8pzCtwdmq23lZRwhM52YQvZiHZdnpDr7q6LsX9w2pHkp99GGE5EEbM/zmhpzcomM7rh7FByknAnZC4XMgIxeLoBTOKEdrNy9htZjLTnbysJyOOZVZxVa5TKqIGewU9untZT45Ghdi3SlG/QggaIB1e7BkSIGeFsdQf5V3IiLHoG5o2RVlrBsyVyO4+aZkhlt5boCesy8Ool+y4R/YbrYHnZGXryBUOg/zXe829IGbAANIEruRmWyK2NUnUlCnBgFvqDEL7UJQjHlTppP896PmQ4HSjmPVgHfyz8DW2/3zdKsna6tjpVO+gvwcZBQ3xvZJG+JiWjW7/TVehJfg5CwFIiOqMcjTifM3fA6+lRcTb8+KPFx38VA0UGvCMUQwGHqCYdUm+hwvcQ0H4Dx6q0wX468vx11f7v1zAR9lH2R2VPzHlppzybG5a6NKCY1AfYHwNCVCqM4JvFJui7ldL53ZQbG
X-Microsoft-Antispam-PRVS: <AM4PR08MB0740C38723F128A52F2E7F33CFA10@AM4PR08MB0740.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(250305191791016)(226959686518644)(22074186197030)(251416522907027)(131327999870524)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM4PR08MB0740;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB0740;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;4:cV3VpWS54ksBjpTlwe0QSDFS55Ww1bdkhJCegTMC/mO9oYDNqsxecO1k4A0ckxyCkyEWO+qwhhFftW2WxVkzBK7MIWa54c6A76wc7aiP1ASmuxsZd41+ceXS4t3u6kSLdYjwyJhjCQTRs1IOmWPg3SqHEuCJ5tYbfOuXOoVhyVwco9B7SoYpwMvJNUjKLBdyw6AbNqfioUR4zofH2QZ6qKfhSv50sfPgk7mpNE9dl2xoqILDhAyyYbRrMSU0zTqB6J49UQKqDJOCs1Quqt4Rzn3+VTMauCuIvyH7YTVMBZW3dTtbt6GCQhI/RRRWujdQaTzCQY59qWJ5L7Ivi11mDKmlO9AaG9WuusSJY1spce3FV/pMdhdZBODsysPFS1TQF4mfcPYndMRc3PeO3PaWuhRlNw4ozfjOVTr3h50PRLBLOLUUXtkf3AjPBcRfPQnCtnavvvSXNGS2or4VKqKB9VPyPliWLVXVWOsqNiL2DjM=
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39850400004)(346002)(199004)(43544003)(189003)(26005)(6306002)(68736007)(16586007)(53946003)(16526019)(9686003)(55016002)(186003)(11346002)(16200700003)(37156001)(446003)(478600001)(23686003)(58126008)(47776003)(53936002)(66066001)(956004)(5660300001)(229853002)(486005)(486005)(106356001)(1076002)(386003)(4326008)(6506007)(25786009)(54906003)(50466002)(476003)(6246003)(6916009)(33656002)(3846002)(7736002)(2906002)(59450400001)(6666003)(53416004)(966005)(105586002)(69596002)(81156014)(81166006)(8936002)(97736004)(7696005)(305945005)(52116002)(8676002)(8656006)(76176011)(316002)(575784001)(86362001)(6116002)(18370500001)(2004002)(579004)(559001)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB0740;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM4PR08MB0740;23:UH/KcsG5w0i9lsFJCsznAfVp1tDSgswtlPhzrrd8g/K?=
 =?koi8-r?Q?3hvSU1fO/IJ5OUISzjKnT9obQRd+4FUPkrD20Mxhs8W9zy8xLHHxRiUPhHtcVl?=
 =?koi8-r?Q?S4N/5VEkIiOrHH4rDXe2pzUJDTu8oAKX5UuT9G1fHLudZWR+jh9Zs66a1IT4js?=
 =?koi8-r?Q?KBCud8KPcexkew/lmvJhdl0+Ou/HrozifYPlQje3MB3fxPAEL8rb8oZkvDloAy?=
 =?koi8-r?Q?D8T2JIE1GvSxyjnRyAsGTtvQgmbACkX1bL0oQbXR2cxmJkan2+9UsgOTIBXY3Q?=
 =?koi8-r?Q?6605nU773CQwJWNcbHasKDz+4qIINLb9yynmhVJHU1jvCc5a05znDlNxFksLGb?=
 =?koi8-r?Q?rMGmIXMVvM+AlfoQE2FFjxj0iTzvO5hpxcoq0tUasGqBiZWlPKDTDQVqszqtrH?=
 =?koi8-r?Q?qYpGuZUyIPGo9jP05nTQBFdLmYuev/5RbBAjKBNyEul28u+M2QbyQ2wOcb7TUb?=
 =?koi8-r?Q?daZeNYTEEGB+3d0JQ/tJFMi0zHk3XEDlnAjeWZxqN0yKLE0CToIJJvWNTHB4Ij?=
 =?koi8-r?Q?lZOQsNdFwlVEXyqG0wE++Ip7Rif6s17cdu4uvsyw7fd5tuA/ZOSTTP3RsYNoAB?=
 =?koi8-r?Q?2pandYUk4DeoGyvSClHTtA6qyMNJ8fqxh0zum0X5cosRfwzo2bQWDinkZEhdRn?=
 =?koi8-r?Q?upFP5VoXYRp4EtEjXioFG59/+HnYND6hhpljghU24ksDS1SOV7XHFZAiwVQr/d?=
 =?koi8-r?Q?75GMeHXIyH6PV0S/yG6R+XWng9XkcfnI1aQuUTHkm6ui4rwuoNEo3pUXySPsWY?=
 =?koi8-r?Q?tL+Dj3j5/PjvEi1oVRwdAD+2CBJQy3PRHs3WxgP2Uh2ebTlu7Q+7QDImnPeDv6?=
 =?koi8-r?Q?fFfJP1gd9QOA4YLmd7uQO8Knz4NkDUekV3CnldaW0kQI9eURZD8P5//jltR3PK?=
 =?koi8-r?Q?GFoLrseZaa7yiQskPZ3/CCpJ7+g5jFSepeam/+1zRJGizuanQOG9fdZ1De0ZQ8?=
 =?koi8-r?Q?YLt8LP3Kpci0fZzhUZvbOJ4IaF7XSYOdCADLJyzusFNesVa0tUOQ5rBTMx1+fm?=
 =?koi8-r?Q?SCpuDPp3FXu5TxYlkHgWyJObWMewVtoWuu5W77nej8IWDa+/VuMA3uuGOlwkQF?=
 =?koi8-r?Q?zyZPokVNVzmZ7gjNIknm1iH+C2wwuRtdGLoYM1It+ME0FtYMKmoeQXBHsDJ37m?=
 =?koi8-r?Q?eFrIYTXPoXb094YlPgsDsRsfA6jIGehR72cayJ/gqsp3qcM6nV7dMAGek1Ac+8?=
 =?koi8-r?Q?em5ODKskJ6j2HmGzbUKcM+01m535017h4fLigurSw1oXLDuzUZGeTgVGhRm/d+?=
 =?koi8-r?Q?yX2O4DDLh/czjmNUThY17MDidI6ztVQu8dXWkD/5p3APqNOVmzWMPRiuLM8nAy?=
 =?koi8-r?Q?n+tuYhRlV4xAMoabgIVhZ+nIEamMAw91OLvETjlNq8sQsGxeBl7MDEKGI3QqC4?=
 =?koi8-r?Q?uVpUppgcEAq621Qv+zV02tTEwOFiLFIzj0/lZVpyKGV/27jM0SbappHiMzv3qO?=
 =?koi8-r?Q?kZnVylyuUjF0CmzkOspWzS5aSSb/SviUxLQ7SZe0O3K2YhY1vNc3ux6VcLF+uv?=
 =?koi8-r?Q?uiYTZ17ZSyFElViK2xSWu4oGsnxvndqPQrE9ATsP8ajIODd9TRJ1hwNjbAL09D?=
 =?koi8-r?Q?bMs8FfW?=
X-Microsoft-Antispam-Message-Info: vXuEfzIpzSqaO9fu4qyBy8C41Lnho2VkGZBpZpuAj3pd6qQtiSrac/9tGJdVTqU2y4VzIRMRErTzi9IJw75TTtg54sBuuMX4J5aqtAP28SP+H1f6pEk1/1p5t4oJTrKrQj+Xo3GNuAP5cAIoOzI2Bam/BBQGQNb4Yj9o4jMTEp29vM3d0CnZk6zhcygYRQce
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;6:4RgXppGR3/GM+wo7w3Z0GTK0iWTcnyuphzUJXPCbzKOUVnZOW0pzJpoXsgArutNKDFbPK71bfcj6BWnpg2qLJDTxz2QB6MGI9/Aa1C6ijpdEfxWAtLhBmJ1uhLELUERCWMxeOwYFDVAYzM4KfFU7Safrj5RFqOH0hiIwXi+XVVh3gdUq68r6anzOAlWTVAubYOmvadTSLS+1kwvNVEoGSE2GUI6NWJ99PnJUjxzm3eXY8dStfPimMWSQPHYR//89c7g3VrrT+A/qCztATX2kHtopPlwUnvmTxfaZZw9VDAvpPjNccoDMCfzFD9ItGc6sPc7UMcljzuFMztdVjiUmJjt1OY2OkbBIeDK8nm2srZaSIeCGBAMR1yJ+CUIxh0BeK3vQa+6DHMkAvFzPdf//Yo1N1k+VUoS9S3EOpsATWzpXy0ToacEo4EXKHAQlf0ksUnwj1VxkkMeuX1uNzS0XXg==;5:tjxfhUe8ErZZ1mvU7NRpm9ujYkxnqxsD0a8dSwtqxgvc2SusT1+atmXNuKeZFEpuHnXDyFUUSZUz/Ic7v3IXG0C//Yjw/yxHudrK65kBXKwcGYV9A53aILuphI+mY2sC4Mt7jz1aK8+wNdzROLhbUJiZY3tVWB5udXpIDGAGmw4=;24:gMguZZR4jfeRvL4Wfha40IThxh2h0Tvn3kZiF647zS5ohZjObjPVv9w/qvlPGniGtk2Quwalo1twZGVk5FwjIn8pRuyLbhZTCQE1G3yEKqQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;7:BREBJq1W8csvRWb7dFI1EzmAcSCZi3EjmDYcHR+zWE+8K26qAZSHiyIfBAmfaxews+f+YA73NnhY4RVubjxLW8hXATPKinxhLxQ42406eKVmD90a3G4QMXbxOPoGYMHuouqMTN28+P9t5AUoEnf9myCFgq+ApF7Hik2+w9EnstKDhkHvMDhbadUign0uukNDxAczjGhd98sXfx+PpFBUDkWlkSrzwVv/cyfcao4MiLYrBXSkaug/Emp43U+zYQPD;20:Urwt3UyloXLB55P3Umjtx+LQ54C73KGoINfi3FRMWgpxYIyS6D5MIHh7Ivn+z24HrxjiFyDmGgcmiSMgPhqLf0rBbQHFDof0o2+O3HXFVnRFi6wyfnqW0WWspHGI3VcggrpWffZyVVWOD0ntDX2zeCfgmCXdxMXtsPzSZ8ez9kE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 17:40:42.0985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e0298f-c70e-40e1-dc0f-08d596655cf8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0740
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:04:32PM +0900, Masahiro Yamada wrote:
> Now that the kernel build supports flex and bison, remove the _shipped
> files and generate them during the build instead.
> 
> There are no more shipped lexer and parser, so I ripped off the rules
> in scripts/Malefile.lib that were used for REGENERATE_PARSERS.
> 
> The genksyms parser has ambiguous grammar, which would emit warnings:
> 
>  scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>  scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
> 
> They are normally suppressed, but displayed when W=1 is given.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  scripts/Makefile.lib                 |   24 +-
>  scripts/genksyms/Makefile            |   23 +
>  scripts/genksyms/lex.lex.c_shipped   | 2291 --------------------------------
>  scripts/genksyms/parse.tab.c_shipped | 2394 ----------------------------------
>  scripts/genksyms/parse.tab.h_shipped |  119 --
>  5 files changed, 26 insertions(+), 4825 deletions(-)
>  delete mode 100644 scripts/genksyms/lex.lex.c_shipped
>  delete mode 100644 scripts/genksyms/parse.tab.c_shipped
>  delete mode 100644 scripts/genksyms/parse.tab.h_shipped
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 2fde810..b7d2c97 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -183,14 +183,8 @@ endef
>  quiet_cmd_flex = LEX     $@
>        cmd_flex = $(LEX) -o$@ -L $<
>  
> -ifdef REGENERATE_PARSERS
> -.PRECIOUS: $(src)/%.lex.c_shipped
> -$(src)/%.lex.c_shipped: $(src)/%.l
> -	$(call cmd,flex)
> -endif
> -
>  .PRECIOUS: $(obj)/%.lex.c
> -$(filter %.lex.c,$(targets)): $(obj)/%.lex.c: $(src)/%.l FORCE
> +$(obj)/%.lex.c: $(src)/%.l FORCE
>  	$(call if_changed,flex)
>  
>  # YACC
> @@ -198,27 +192,15 @@ $(filter %.lex.c,$(targets)): $(obj)/%.lex.c: $(src)/%.l FORCE
>  quiet_cmd_bison = YACC    $@
>        cmd_bison = $(YACC) -o$@ -t -l $<
>  
> -ifdef REGENERATE_PARSERS
> -.PRECIOUS: $(src)/%.tab.c_shipped
> -$(src)/%.tab.c_shipped: $(src)/%.y
> -	$(call cmd,bison)
> -endif
> -
>  .PRECIOUS: $(obj)/%.tab.c
> -$(filter %.tab.c,$(targets)): $(obj)/%.tab.c: $(src)/%.y FORCE
> +$(obj)/%.tab.c: $(src)/%.y FORCE
>  	$(call if_changed,bison)
>  
>  quiet_cmd_bison_h = YACC    $@
>        cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
>  
> -ifdef REGENERATE_PARSERS
> -.PRECIOUS: $(src)/%.tab.h_shipped
> -$(src)/%.tab.h_shipped: $(src)/%.y
> -	$(call cmd,bison_h)
> -endif
> -
>  .PRECIOUS: $(obj)/%.tab.h
> -$(filter %.tab.h,$(targets)): $(obj)/%.tab.h: $(src)/%.y FORCE
> +$(obj)/%.tab.h: $(src)/%.y FORCE
>  	$(call if_changed,bison_h)
>  
>  # Shipped files
> diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
> index 0ccac51..f4749e8 100644
> --- a/scripts/genksyms/Makefile
> +++ b/scripts/genksyms/Makefile
> @@ -5,9 +5,32 @@ always		:= $(hostprogs-y)
>  
>  genksyms-objs	:= genksyms.o parse.tab.o lex.lex.o
>  
> +# FIXME: fix the ambiguous grammar in parse.y and delete this hack
> +#
> +# Suppress shift/reduce, reduce/reduce conflicts warnings
> +# unless W=1 is specified.
> +ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
> +SUPPRESS_BISON_WARNING := 2>/dev/null

We have a robot which runs CRIU tests on linux-next.
Yesterday it failed with this error:

  HOSTCC  scripts/genksyms/genksyms.o
make[2]: *** [scripts/genksyms/parse.tab.c] Error 127

cripts/genksyms/Makefile:20: recipe for target 'scripts/genksyms/parse.tab.c' failed
scripts/Makefile.build:559: recipe for target 'scripts/genksyms' failed
Makefile:1073: recipe for target 'scripts' failed
make[1]: *** [scripts/genksyms] Error 2
make: *** [scripts] Error 2
make: *** Waiting for unfinished jobs....

https://travis-ci.org/avagin/linux/jobs/360056903

>From this output, it is very hard to understand what was going wrong.

Thanks,
Andrei

> +endif
> +
> +quiet_cmd_bison_no_warn = $(quet_cmd_bison)
> +      cmd_bison_no_warn = $(cmd_bison) $(SUPPRESS_BISON_WARNING)
> +
> +$(obj)/parse.tab.c: $(src)/parse.y FORCE
> +	$(call if_changed,bison_no_warn)
> +
> +quiet_cmd_bison_h_no_warn = $(quet_cmd_bison_h)
> +      cmd_bison_h_no_warn = $(cmd_bison_h) $(SUPPRESS_BISON_WARNING)
> +
> +$(obj)/parse.tab.h: $(src)/parse.y FORCE
> +	$(call if_changed,bison_h_no_warn)
> +# FIXME END
> +
>  # -I needed for generated C source (shipped source)
>  HOSTCFLAGS_parse.tab.o := -I$(src)
>  HOSTCFLAGS_lex.lex.o := -I$(src)
>  
>  # dependencies on generated files need to be listed explicitly
>  $(obj)/lex.lex.o: $(obj)/parse.tab.h
> +
> +targets := lex.lex.c parse.tab.c parse.tab.h
> diff --git a/scripts/genksyms/lex.lex.c_shipped b/scripts/genksyms/lex.lex.c_shipped
> deleted file mode 100644
> index ba2fda8..0000000
> --- a/scripts/genksyms/lex.lex.c_shipped
> +++ /dev/null
> @@ -1,2291 +0,0 @@
> -
> -#line 3 "scripts/genksyms/lex.lex.c_shipped"
> -
> -#define  YY_INT_ALIGNED short int
> -
> -/* A lexical scanner generated by flex */
> -
> -#define FLEX_SCANNER
> -#define YY_FLEX_MAJOR_VERSION 2
> -#define YY_FLEX_MINOR_VERSION 5
> -#define YY_FLEX_SUBMINOR_VERSION 35
> -#if YY_FLEX_SUBMINOR_VERSION > 0
> -#define FLEX_BETA
> -#endif
> -
> -/* First, we deal with  platform-specific or compiler-specific issues. */
> -
> -/* begin standard C headers. */
> -#include <stdio.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <stdlib.h>
> -
> -/* end standard C headers. */
> -
> -/* flex integer type definitions */
> -
> -#ifndef FLEXINT_H
> -#define FLEXINT_H
> -
> -/* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
> -
> -#if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
> -
> -/* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
> - * if you want the limit (max/min) macros for int types. 
> - */
> -#ifndef __STDC_LIMIT_MACROS
> -#define __STDC_LIMIT_MACROS 1
> -#endif
> -
> -#include <inttypes.h>
> -typedef int8_t flex_int8_t;
> -typedef uint8_t flex_uint8_t;
> -typedef int16_t flex_int16_t;
> -typedef uint16_t flex_uint16_t;
> -typedef int32_t flex_int32_t;
> -typedef uint32_t flex_uint32_t;
> -#else
> -typedef signed char flex_int8_t;
> -typedef short int flex_int16_t;
> -typedef int flex_int32_t;
> -typedef unsigned char flex_uint8_t; 
> -typedef unsigned short int flex_uint16_t;
> -typedef unsigned int flex_uint32_t;
> -#endif /* ! C99 */
> -
> -/* Limits of integral types. */
> -#ifndef INT8_MIN
> -#define INT8_MIN               (-128)
> -#endif
> -#ifndef INT16_MIN
> -#define INT16_MIN              (-32767-1)
> -#endif
> -#ifndef INT32_MIN
> -#define INT32_MIN              (-2147483647-1)
> -#endif
> -#ifndef INT8_MAX
> -#define INT8_MAX               (127)
> -#endif
> -#ifndef INT16_MAX
> -#define INT16_MAX              (32767)
> -#endif
> -#ifndef INT32_MAX
> -#define INT32_MAX              (2147483647)
> -#endif
> -#ifndef UINT8_MAX
> -#define UINT8_MAX              (255U)
> -#endif
> -#ifndef UINT16_MAX
> -#define UINT16_MAX             (65535U)
> -#endif
> -#ifndef UINT32_MAX
> -#define UINT32_MAX             (4294967295U)
> -#endif
> -
> -#endif /* ! FLEXINT_H */
> -
> -#ifdef __cplusplus
> -
> -/* The "const" storage-class-modifier is valid. */
> -#define YY_USE_CONST
> -
> -#else	/* ! __cplusplus */
> -
> -/* C99 requires __STDC__ to be defined as 1. */
> -#if defined (__STDC__)
> -
> -#define YY_USE_CONST
> -
> -#endif	/* defined (__STDC__) */
> -#endif	/* ! __cplusplus */
> -
> -#ifdef YY_USE_CONST
> -#define yyconst const
> -#else
> -#define yyconst
> -#endif
> -
> -/* Returned upon end-of-file. */
> -#define YY_NULL 0
> -
> -/* Promotes a possibly negative, possibly signed char to an unsigned
> - * integer for use as an array index.  If the signed char is negative,
> - * we want to instead treat it as an 8-bit unsigned char, hence the
> - * double cast.
> - */
> -#define YY_SC_TO_UI(c) ((unsigned int) (unsigned char) c)
> -
> -/* Enter a start condition.  This macro really ought to take a parameter,
> - * but we do it the disgusting crufty way forced on us by the ()-less
> - * definition of BEGIN.
> - */
> -#define BEGIN (yy_start) = 1 + 2 *
> -
> -/* Translate the current start state into a value that can be later handed
> - * to BEGIN to return to the state.  The YYSTATE alias is for lex
> - * compatibility.
> - */
> -#define YY_START (((yy_start) - 1) / 2)
> -#define YYSTATE YY_START
> -
> -/* Action number for EOF rule of a given start state. */
> -#define YY_STATE_EOF(state) (YY_END_OF_BUFFER + state + 1)
> -
> -/* Special action meaning "start processing a new file". */
> -#define YY_NEW_FILE yyrestart(yyin  )
> -
> -#define YY_END_OF_BUFFER_CHAR 0
> -
> -/* Size of default input buffer. */
> -#ifndef YY_BUF_SIZE
> -#define YY_BUF_SIZE 16384
> -#endif
> -
> -/* The state buf must be large enough to hold one state per character in the main buffer.
> - */
> -#define YY_STATE_BUF_SIZE   ((YY_BUF_SIZE + 2) * sizeof(yy_state_type))
> -
> -#ifndef YY_TYPEDEF_YY_BUFFER_STATE
> -#define YY_TYPEDEF_YY_BUFFER_STATE
> -typedef struct yy_buffer_state *YY_BUFFER_STATE;
> -#endif
> -
> -extern int yyleng;
> -
> -extern FILE *yyin, *yyout;
> -
> -#define EOB_ACT_CONTINUE_SCAN 0
> -#define EOB_ACT_END_OF_FILE 1
> -#define EOB_ACT_LAST_MATCH 2
> -
> -    #define YY_LESS_LINENO(n)
> -    
> -/* Return all but the first "n" matched characters back to the input stream. */
> -#define yyless(n) \
> -	do \
> -		{ \
> -		/* Undo effects of setting up yytext. */ \
> -        int yyless_macro_arg = (n); \
> -        YY_LESS_LINENO(yyless_macro_arg);\
> -		*yy_cp = (yy_hold_char); \
> -		YY_RESTORE_YY_MORE_OFFSET \
> -		(yy_c_buf_p) = yy_cp = yy_bp + yyless_macro_arg - YY_MORE_ADJ; \
> -		YY_DO_BEFORE_ACTION; /* set up yytext again */ \
> -		} \
> -	while ( 0 )
> -
> -#define unput(c) yyunput( c, (yytext_ptr)  )
> -
> -#ifndef YY_TYPEDEF_YY_SIZE_T
> -#define YY_TYPEDEF_YY_SIZE_T
> -typedef size_t yy_size_t;
> -#endif
> -
> -#ifndef YY_STRUCT_YY_BUFFER_STATE
> -#define YY_STRUCT_YY_BUFFER_STATE
> -struct yy_buffer_state
> -	{
> -	FILE *yy_input_file;
> -
> -	char *yy_ch_buf;		/* input buffer */
> -	char *yy_buf_pos;		/* current position in input buffer */
> -
> -	/* Size of input buffer in bytes, not including room for EOB
> -	 * characters.
> -	 */
> -	yy_size_t yy_buf_size;
> -
> -	/* Number of characters read into yy_ch_buf, not including EOB
> -	 * characters.
> -	 */
> -	int yy_n_chars;
> -
> -	/* Whether we "own" the buffer - i.e., we know we created it,
> -	 * and can realloc() it to grow it, and should free() it to
> -	 * delete it.
> -	 */
> -	int yy_is_our_buffer;
> -
> -	/* Whether this is an "interactive" input source; if so, and
> -	 * if we're using stdio for input, then we want to use getc()
> -	 * instead of fread(), to make sure we stop fetching input after
> -	 * each newline.
> -	 */
> -	int yy_is_interactive;
> -
> -	/* Whether we're considered to be at the beginning of a line.
> -	 * If so, '^' rules will be active on the next match, otherwise
> -	 * not.
> -	 */
> -	int yy_at_bol;
> -
> -    int yy_bs_lineno; /**< The line count. */
> -    int yy_bs_column; /**< The column count. */
> -    
> -	/* Whether to try to fill the input buffer when we reach the
> -	 * end of it.
> -	 */
> -	int yy_fill_buffer;
> -
> -	int yy_buffer_status;
> -
> -#define YY_BUFFER_NEW 0
> -#define YY_BUFFER_NORMAL 1
> -	/* When an EOF's been seen but there's still some text to process
> -	 * then we mark the buffer as YY_EOF_PENDING, to indicate that we
> -	 * shouldn't try reading from the input source any more.  We might
> -	 * still have a bunch of tokens to match, though, because of
> -	 * possible backing-up.
> -	 *
> -	 * When we actually see the EOF, we change the status to "new"
> -	 * (via yyrestart()), so that the user can continue scanning by
> -	 * just pointing yyin at a new input file.
> -	 */
> -#define YY_BUFFER_EOF_PENDING 2
> -
> -	};
> -#endif /* !YY_STRUCT_YY_BUFFER_STATE */
> -
> -/* Stack of input buffers. */
> -static size_t yy_buffer_stack_top = 0; /**< index of top of stack. */
> -static size_t yy_buffer_stack_max = 0; /**< capacity of stack. */
> -static YY_BUFFER_STATE * yy_buffer_stack = 0; /**< Stack as an array. */
> -
> -/* We provide macros for accessing buffer states in case in the
> - * future we want to put the buffer states in a more general
> - * "scanner state".
> - *
> - * Returns the top of the stack, or NULL.
> - */
> -#define YY_CURRENT_BUFFER ( (yy_buffer_stack) \
> -                          ? (yy_buffer_stack)[(yy_buffer_stack_top)] \
> -                          : NULL)
> -
> -/* Same as previous macro, but useful when we know that the buffer stack is not
> - * NULL or when we need an lvalue. For internal use only.
> - */
> -#define YY_CURRENT_BUFFER_LVALUE (yy_buffer_stack)[(yy_buffer_stack_top)]
> -
> -/* yy_hold_char holds the character lost when yytext is formed. */
> -static char yy_hold_char;
> -static int yy_n_chars;		/* number of characters read into yy_ch_buf */
> -int yyleng;
> -
> -/* Points to current character in buffer. */
> -static char *yy_c_buf_p = (char *) 0;
> -static int yy_init = 0;		/* whether we need to initialize */
> -static int yy_start = 0;	/* start state number */
> -
> -/* Flag which is used to allow yywrap()'s to do buffer switches
> - * instead of setting up a fresh yyin.  A bit of a hack ...
> - */
> -static int yy_did_buffer_switch_on_eof;
> -
> -void yyrestart (FILE *input_file  );
> -void yy_switch_to_buffer (YY_BUFFER_STATE new_buffer  );
> -YY_BUFFER_STATE yy_create_buffer (FILE *file,int size  );
> -void yy_delete_buffer (YY_BUFFER_STATE b  );
> -void yy_flush_buffer (YY_BUFFER_STATE b  );
> -void yypush_buffer_state (YY_BUFFER_STATE new_buffer  );
> -void yypop_buffer_state (void );
> -
> -static void yyensure_buffer_stack (void );
> -static void yy_load_buffer_state (void );
> -static void yy_init_buffer (YY_BUFFER_STATE b,FILE *file  );
> -
> -#define YY_FLUSH_BUFFER yy_flush_buffer(YY_CURRENT_BUFFER )
> -
> -YY_BUFFER_STATE yy_scan_buffer (char *base,yy_size_t size  );
> -YY_BUFFER_STATE yy_scan_string (yyconst char *yy_str  );
> -YY_BUFFER_STATE yy_scan_bytes (yyconst char *bytes,int len  );
> -
> -void *yyalloc (yy_size_t  );
> -void *yyrealloc (void *,yy_size_t  );
> -void yyfree (void *  );
> -
> -#define yy_new_buffer yy_create_buffer
> -
> -#define yy_set_interactive(is_interactive) \
> -	{ \
> -	if ( ! YY_CURRENT_BUFFER ){ \
> -        yyensure_buffer_stack (); \
> -		YY_CURRENT_BUFFER_LVALUE =    \
> -            yy_create_buffer(yyin,YY_BUF_SIZE ); \
> -	} \
> -	YY_CURRENT_BUFFER_LVALUE->yy_is_interactive = is_interactive; \
> -	}
> -
> -#define yy_set_bol(at_bol) \
> -	{ \
> -	if ( ! YY_CURRENT_BUFFER ){\
> -        yyensure_buffer_stack (); \
> -		YY_CURRENT_BUFFER_LVALUE =    \
> -            yy_create_buffer(yyin,YY_BUF_SIZE ); \
> -	} \
> -	YY_CURRENT_BUFFER_LVALUE->yy_at_bol = at_bol; \
> -	}
> -
> -#define YY_AT_BOL() (YY_CURRENT_BUFFER_LVALUE->yy_at_bol)
> -
> -/* Begin user sect3 */
> -
> -#define yywrap(n) 1
> -#define YY_SKIP_YYWRAP
> -
> -typedef unsigned char YY_CHAR;
> -
> -FILE *yyin = (FILE *) 0, *yyout = (FILE *) 0;
> -
> -typedef int yy_state_type;
> -
> -extern int yylineno;
> -
> -int yylineno = 1;
> -
> -extern char *yytext;
> -#define yytext_ptr yytext
> -
> -static yy_state_type yy_get_previous_state (void );
> -static yy_state_type yy_try_NUL_trans (yy_state_type current_state  );
> -static int yy_get_next_buffer (void );
> -static void yy_fatal_error (yyconst char msg[]  );
> -
> -/* Done after the current pattern has been matched and before the
> - * corresponding action - sets up yytext.
> - */
> -#define YY_DO_BEFORE_ACTION \
> -	(yytext_ptr) = yy_bp; \
> -	yyleng = (size_t) (yy_cp - yy_bp); \
> -	(yy_hold_char) = *yy_cp; \
> -	*yy_cp = '\0'; \
> -	(yy_c_buf_p) = yy_cp;
> -
> -#define YY_NUM_RULES 13
> -#define YY_END_OF_BUFFER 14
> -/* This struct is not used in this scanner,
> -   but its presence is necessary. */
> -struct yy_trans_info
> -	{
> -	flex_int32_t yy_verify;
> -	flex_int32_t yy_nxt;
> -	};
> -static yyconst flex_int16_t yy_accept[73] =
> -    {   0,
> -        0,    0,   14,   12,    4,    3,   12,    7,   12,   12,
> -       12,   12,   12,    9,    9,   12,   12,    7,   12,   12,
> -        4,    0,    5,    0,    7,    8,    0,    6,    0,    0,
> -       10,   10,    9,    0,    0,    9,    9,    0,    9,    0,
> -        0,    0,    0,    2,    0,    0,   11,    0,   10,    0,
> -       10,    9,    9,    0,    0,    0,   10,   10,    0,    0,
> -        0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
> -        1,    0
> -    } ;
> -
> -static yyconst flex_int32_t yy_ec[256] =
> -    {   0,
> -        1,    1,    1,    1,    1,    1,    1,    1,    2,    3,
> -        4,    4,    4,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    2,    1,    5,    6,    7,    8,    9,   10,    1,
> -        1,    8,   11,    1,   12,   13,    8,   14,   15,   15,
> -       15,   15,   15,   15,   15,   16,   16,    1,    1,   17,
> -       18,   19,    1,    1,   20,   20,   20,   20,   21,   22,
> -        7,    7,    7,    7,    7,   23,    7,    7,    7,    7,
> -        7,    7,    7,    7,   24,    7,    7,   25,    7,    7,
> -        1,   26,    1,    8,    7,    1,   20,   20,   20,   20,
> -
> -       21,   22,    7,    7,    7,    7,    7,   27,    7,    7,
> -        7,    7,    7,    7,    7,    7,   24,    7,    7,   25,
> -        7,    7,    1,   28,    1,    8,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1
> -    } ;
> -
> -static yyconst flex_int32_t yy_meta[29] =
> -    {   0,
> -        1,    1,    2,    1,    1,    1,    3,    1,    1,    1,
> -        4,    4,    5,    6,    6,    6,    1,    1,    1,    7,
> -        8,    7,    3,    3,    3,    1,    3,    1
> -    } ;
> -
> -static yyconst flex_int16_t yy_base[85] =
> -    {   0,
> -        0,  145,  150,  266,   27,  266,   25,    0,  131,   23,
> -       23,   16,   23,   39,   31,   25,   39,   60,   22,   65,
> -       57,   43,  266,    0,    0,  266,   61,  266,    0,  128,
> -       74,    0,  113,   59,   62,  113,   52,    0,    0,   72,
> -       66,  110,  100,  266,   73,   74,  266,   70,  266,   90,
> -      103,  266,   84,  129,  108,  113,  143,  266,  107,   66,
> -      118,  137,  168,  120,   80,   91,  145,  143,   83,   41,
> -      266,  266,  190,  196,  204,  212,  220,  228,  232,  237,
> -      238,  243,  249,  257
> -    } ;
> -
> -static yyconst flex_int16_t yy_def[85] =
> -    {   0,
> -       72,    1,   72,   72,   72,   72,   73,   74,   72,   72,
> -       75,   72,   72,   72,   14,   72,   72,   74,   72,   76,
> -       72,   73,   72,   77,   74,   72,   75,   72,   78,   72,
> -       72,   31,   14,   79,   80,   72,   72,   81,   15,   73,
> -       75,   76,   76,   72,   73,   75,   72,   82,   72,   72,
> -       72,   72,   81,   76,   54,   72,   72,   72,   76,   54,
> -       76,   76,   76,   54,   83,   76,   63,   83,   84,   84,
> -       72,    0,   72,   72,   72,   72,   72,   72,   72,   72,
> -       72,   72,   72,   72
> -    } ;
> -
> -static yyconst flex_int16_t yy_nxt[295] =
> -    {   0,
> -        4,    5,    6,    5,    7,    4,    8,    9,   10,   11,
> -        9,   12,   13,   14,   15,   15,   16,    9,   17,    8,
> -        8,    8,   18,    8,    8,    4,    8,   19,   21,   23,
> -       21,   26,   28,   26,   26,   30,   31,   31,   31,   26,
> -       26,   26,   26,   71,   39,   39,   39,   23,   29,   26,
> -       24,   32,   33,   33,   34,   72,   26,   26,   21,   35,
> -       21,   36,   37,   38,   40,   36,   43,   44,   24,   41,
> -       28,   32,   50,   50,   52,   28,   23,   23,   52,   35,
> -       56,   56,   44,   28,   42,   71,   29,   31,   31,   31,
> -       42,   29,   59,   44,   48,   49,   49,   24,   24,   29,
> -
> -       49,   43,   44,   51,   51,   51,   36,   37,   59,   44,
> -       36,   65,   44,   54,   55,   55,   51,   51,   51,   59,
> -       44,   64,   64,   64,   58,   58,   57,   57,   57,   58,
> -       59,   44,   42,   64,   64,   64,   52,   72,   59,   44,
> -       47,   66,   60,   60,   42,   44,   59,   69,   26,   72,
> -       20,   61,   62,   63,   72,   61,   57,   57,   57,   66,
> -       72,   72,   72,   66,   49,   49,   72,   61,   62,   49,
> -       44,   61,   72,   72,   72,   72,   72,   72,   72,   72,
> -       72,   67,   67,   67,   72,   72,   72,   67,   67,   67,
> -       22,   22,   22,   22,   22,   22,   22,   22,   25,   72,
> -
> -       72,   25,   25,   25,   27,   27,   27,   27,   27,   27,
> -       27,   27,   42,   42,   42,   42,   42,   42,   42,   42,
> -       45,   72,   45,   45,   45,   45,   45,   45,   46,   72,
> -       46,   46,   46,   46,   46,   46,   34,   34,   72,   34,
> -       51,   72,   51,   53,   53,   53,   57,   72,   57,   68,
> -       68,   68,   68,   68,   68,   68,   68,   70,   70,   70,
> -       70,   70,   70,   70,   70,    3,   72,   72,   72,   72,
> -       72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
> -       72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
> -       72,   72,   72,   72
> -
> -    } ;
> -
> -static yyconst flex_int16_t yy_chk[295] =
> -    {   0,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
> -        1,    1,    1,    1,    1,    1,    1,    1,    5,    7,
> -        5,   10,   11,   12,   12,   13,   13,   13,   13,   19,
> -       10,   16,   16,   70,   15,   15,   15,   22,   11,   19,
> -        7,   14,   14,   14,   14,   15,   17,   17,   21,   14,
> -       21,   14,   14,   14,   18,   14,   20,   20,   22,   18,
> -       27,   34,   35,   35,   37,   41,   40,   45,   37,   34,
> -       48,   48,   65,   46,   65,   69,   27,   31,   31,   31,
> -       60,   41,   66,   66,   31,   31,   31,   40,   45,   46,
> -
> -       31,   43,   43,   50,   50,   50,   53,   53,   59,   59,
> -       53,   59,   42,   43,   43,   43,   51,   51,   51,   61,
> -       61,   55,   55,   55,   51,   51,   56,   56,   56,   51,
> -       54,   54,   55,   64,   64,   64,   36,   33,   62,   62,
> -       30,   61,   54,   54,   64,   68,   67,   68,    9,    3,
> -        2,   54,   54,   54,    0,   54,   57,   57,   57,   62,
> -        0,    0,    0,   62,   57,   57,    0,   67,   67,   57,
> -       63,   67,    0,    0,    0,    0,    0,    0,    0,    0,
> -        0,   63,   63,   63,    0,    0,    0,   63,   63,   63,
> -       73,   73,   73,   73,   73,   73,   73,   73,   74,    0,
> -
> -        0,   74,   74,   74,   75,   75,   75,   75,   75,   75,
> -       75,   75,   76,   76,   76,   76,   76,   76,   76,   76,
> -       77,    0,   77,   77,   77,   77,   77,   77,   78,    0,
> -       78,   78,   78,   78,   78,   78,   79,   79,    0,   79,
> -       80,    0,   80,   81,   81,   81,   82,    0,   82,   83,
> -       83,   83,   83,   83,   83,   83,   83,   84,   84,   84,
> -       84,   84,   84,   84,   84,   72,   72,   72,   72,   72,
> -       72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
> -       72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
> -       72,   72,   72,   72
> -
> -    } ;
> -
> -static yy_state_type yy_last_accepting_state;
> -static char *yy_last_accepting_cpos;
> -
> -extern int yy_flex_debug;
> -int yy_flex_debug = 0;
> -
> -/* The intent behind this definition is that it'll catch
> - * any uses of REJECT which flex missed.
> - */
> -#define REJECT reject_used_but_not_detected
> -#define yymore() yymore_used_but_not_detected
> -#define YY_MORE_ADJ 0
> -#define YY_RESTORE_YY_MORE_OFFSET
> -char *yytext;
> -/* Lexical analysis for genksyms.
> -   Copyright 1996, 1997 Linux International.
> -
> -   New implementation contributed by Richard Henderson <rth@tamu.edu>
> -   Based on original work by Bjorn Ekwall <bj0rn@blox.se>
> -
> -   Taken from Linux modutils 2.4.22.
> -
> -   This program is free software; you can redistribute it and/or modify it
> -   under the terms of the GNU General Public License as published by the
> -   Free Software Foundation; either version 2 of the License, or (at your
> -   option) any later version.
> -
> -   This program is distributed in the hope that it will be useful, but
> -   WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -   General Public License for more details.
> -
> -   You should have received a copy of the GNU General Public License
> -   along with this program; if not, write to the Free Software Foundation,
> -   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
> -
> -#include <limits.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <ctype.h>
> -
> -#include "genksyms.h"
> -#include "parse.tab.h"
> -
> -/* We've got a two-level lexer here.  We let flex do basic tokenization
> -   and then we categorize those basic tokens in the second stage.  */
> -#define YY_DECL		static int yylex1(void)
> -
> -/* We don't do multiple input files.  */
> -#define YY_NO_INPUT 1
> -
> -#define INITIAL 0
> -
> -#ifndef YY_NO_UNISTD_H
> -/* Special case for "unistd.h", since it is non-ANSI. We include it way
> - * down here because we want the user's section 1 to have been scanned first.
> - * The user has a chance to override it with an option.
> - */
> -#include <unistd.h>
> -#endif
> -
> -#ifndef YY_EXTRA_TYPE
> -#define YY_EXTRA_TYPE void *
> -#endif
> -
> -static int yy_init_globals (void );
> -
> -/* Accessor methods to globals.
> -   These are made visible to non-reentrant scanners for convenience. */
> -
> -int yylex_destroy (void );
> -
> -int yyget_debug (void );
> -
> -void yyset_debug (int debug_flag  );
> -
> -YY_EXTRA_TYPE yyget_extra (void );
> -
> -void yyset_extra (YY_EXTRA_TYPE user_defined  );
> -
> -FILE *yyget_in (void );
> -
> -void yyset_in  (FILE * in_str  );
> -
> -FILE *yyget_out (void );
> -
> -void yyset_out  (FILE * out_str  );
> -
> -int yyget_leng (void );
> -
> -char *yyget_text (void );
> -
> -int yyget_lineno (void );
> -
> -void yyset_lineno (int line_number  );
> -
> -/* Macros after this point can all be overridden by user definitions in
> - * section 1.
> - */
> -
> -#ifndef YY_SKIP_YYWRAP
> -#ifdef __cplusplus
> -extern "C" int yywrap (void );
> -#else
> -extern int yywrap (void );
> -#endif
> -#endif
> -
> -    static void yyunput (int c,char *buf_ptr  );
> -    
> -#ifndef yytext_ptr
> -static void yy_flex_strncpy (char *,yyconst char *,int );
> -#endif
> -
> -#ifdef YY_NEED_STRLEN
> -static int yy_flex_strlen (yyconst char * );
> -#endif
> -
> -#ifndef YY_NO_INPUT
> -
> -#ifdef __cplusplus
> -static int yyinput (void );
> -#else
> -static int input (void );
> -#endif
> -
> -#endif
> -
> -/* Amount of stuff to slurp up with each read. */
> -#ifndef YY_READ_BUF_SIZE
> -#define YY_READ_BUF_SIZE 8192
> -#endif
> -
> -/* Copy whatever the last rule matched to the standard output. */
> -#ifndef ECHO
> -/* This used to be an fputs(), but since the string might contain NUL's,
> - * we now use fwrite().
> - */
> -#define ECHO fwrite( yytext, yyleng, 1, yyout )
> -#endif
> -
> -/* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
> - * is returned in "result".
> - */
> -#ifndef YY_INPUT
> -#define YY_INPUT(buf,result,max_size) \
> -	if ( YY_CURRENT_BUFFER_LVALUE->yy_is_interactive ) \
> -		{ \
> -		int c = '*'; \
> -		int n; \
> -		for ( n = 0; n < max_size && \
> -			     (c = getc( yyin )) != EOF && c != '\n'; ++n ) \
> -			buf[n] = (char) c; \
> -		if ( c == '\n' ) \
> -			buf[n++] = (char) c; \
> -		if ( c == EOF && ferror( yyin ) ) \
> -			YY_FATAL_ERROR( "input in flex scanner failed" ); \
> -		result = n; \
> -		} \
> -	else \
> -		{ \
> -		errno=0; \
> -		while ( (result = fread(buf, 1, max_size, yyin))==0 && ferror(yyin)) \
> -			{ \
> -			if( errno != EINTR) \
> -				{ \
> -				YY_FATAL_ERROR( "input in flex scanner failed" ); \
> -				break; \
> -				} \
> -			errno=0; \
> -			clearerr(yyin); \
> -			} \
> -		}\
> -\
> -
> -#endif
> -
> -/* No semi-colon after return; correct usage is to write "yyterminate();" -
> - * we don't want an extra ';' after the "return" because that will cause
> - * some compilers to complain about unreachable statements.
> - */
> -#ifndef yyterminate
> -#define yyterminate() return YY_NULL
> -#endif
> -
> -/* Number of entries by which start-condition stack grows. */
> -#ifndef YY_START_STACK_INCR
> -#define YY_START_STACK_INCR 25
> -#endif
> -
> -/* Report a fatal error. */
> -#ifndef YY_FATAL_ERROR
> -#define YY_FATAL_ERROR(msg) yy_fatal_error( msg )
> -#endif
> -
> -/* end tables serialization structures and prototypes */
> -
> -/* Default declaration of generated scanner - a define so the user can
> - * easily add parameters.
> - */
> -#ifndef YY_DECL
> -#define YY_DECL_IS_OURS 1
> -
> -extern int yylex (void);
> -
> -#define YY_DECL int yylex (void)
> -#endif /* !YY_DECL */
> -
> -/* Code executed at the beginning of each rule, after yytext and yyleng
> - * have been set up.
> - */
> -#ifndef YY_USER_ACTION
> -#define YY_USER_ACTION
> -#endif
> -
> -/* Code executed at the end of each rule. */
> -#ifndef YY_BREAK
> -#define YY_BREAK break;
> -#endif
> -
> -#define YY_RULE_SETUP \
> -	if ( yyleng > 0 ) \
> -		YY_CURRENT_BUFFER_LVALUE->yy_at_bol = \
> -				(yytext[yyleng - 1] == '\n'); \
> -	YY_USER_ACTION
> -
> -/** The main scanner function which does all the work.
> - */
> -YY_DECL
> -{
> -	register yy_state_type yy_current_state;
> -	register char *yy_cp, *yy_bp;
> -	register int yy_act;
> -    
> - /* Keep track of our location in the original source files.  */
> -
> -	if ( !(yy_init) )
> -		{
> -		(yy_init) = 1;
> -
> -#ifdef YY_USER_INIT
> -		YY_USER_INIT;
> -#endif
> -
> -		if ( ! (yy_start) )
> -			(yy_start) = 1;	/* first start state */
> -
> -		if ( ! yyin )
> -			yyin = stdin;
> -
> -		if ( ! yyout )
> -			yyout = stdout;
> -
> -		if ( ! YY_CURRENT_BUFFER ) {
> -			yyensure_buffer_stack ();
> -			YY_CURRENT_BUFFER_LVALUE =
> -				yy_create_buffer(yyin,YY_BUF_SIZE );
> -		}
> -
> -		yy_load_buffer_state( );
> -		}
> -
> -	while ( 1 )		/* loops until end-of-file is reached */
> -		{
> -		yy_cp = (yy_c_buf_p);
> -
> -		/* Support of yytext. */
> -		*yy_cp = (yy_hold_char);
> -
> -		/* yy_bp points to the position in yy_ch_buf of the start of
> -		 * the current run.
> -		 */
> -		yy_bp = yy_cp;
> -
> -		yy_current_state = (yy_start);
> -		yy_current_state += YY_AT_BOL();
> -yy_match:
> -		do
> -			{
> -			register YY_CHAR yy_c = yy_ec[YY_SC_TO_UI(*yy_cp)];
> -			if ( yy_accept[yy_current_state] )
> -				{
> -				(yy_last_accepting_state) = yy_current_state;
> -				(yy_last_accepting_cpos) = yy_cp;
> -				}
> -			while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> -				{
> -				yy_current_state = (int) yy_def[yy_current_state];
> -				if ( yy_current_state >= 73 )
> -					yy_c = yy_meta[(unsigned int) yy_c];
> -				}
> -			yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int) yy_c];
> -			++yy_cp;
> -			}
> -		while ( yy_base[yy_current_state] != 266 );
> -
> -yy_find_action:
> -		yy_act = yy_accept[yy_current_state];
> -		if ( yy_act == 0 )
> -			{ /* have to back up */
> -			yy_cp = (yy_last_accepting_cpos);
> -			yy_current_state = (yy_last_accepting_state);
> -			yy_act = yy_accept[yy_current_state];
> -			}
> -
> -		YY_DO_BEFORE_ACTION;
> -
> -do_action:	/* This label is used only to access EOF actions. */
> -
> -		switch ( yy_act )
> -	{ /* beginning of action switch */
> -			case 0: /* must back up */
> -			/* undo the effects of YY_DO_BEFORE_ACTION */
> -			*yy_cp = (yy_hold_char);
> -			yy_cp = (yy_last_accepting_cpos);
> -			yy_current_state = (yy_last_accepting_state);
> -			goto yy_find_action;
> -
> -case 1:
> -/* rule 1 can match eol */
> -YY_RULE_SETUP
> -return FILENAME;
> -	YY_BREAK
> -case 2:
> -/* rule 2 can match eol */
> -YY_RULE_SETUP
> -cur_line++;
> -	YY_BREAK
> -case 3:
> -/* rule 3 can match eol */
> -YY_RULE_SETUP
> -cur_line++;
> -	YY_BREAK
> -/* Ignore all other whitespace.  */
> -case 4:
> -YY_RULE_SETUP
> -;
> -	YY_BREAK
> -case 5:
> -/* rule 5 can match eol */
> -YY_RULE_SETUP
> -return STRING;
> -	YY_BREAK
> -case 6:
> -/* rule 6 can match eol */
> -YY_RULE_SETUP
> -return CHAR;
> -	YY_BREAK
> -case 7:
> -YY_RULE_SETUP
> -return IDENT;
> -	YY_BREAK
> -/* The Pedant requires that the other C multi-character tokens be
> -    recognized as tokens.  We don't actually use them since we don't
> -    parse expressions, but we do want whitespace to be arranged
> -    around them properly.  */
> -case 8:
> -YY_RULE_SETUP
> -return OTHER;
> -	YY_BREAK
> -case 9:
> -YY_RULE_SETUP
> -return INT;
> -	YY_BREAK
> -case 10:
> -YY_RULE_SETUP
> -return REAL;
> -	YY_BREAK
> -case 11:
> -YY_RULE_SETUP
> -return DOTS;
> -	YY_BREAK
> -/* All other tokens are single characters.  */
> -case 12:
> -YY_RULE_SETUP
> -return yytext[0];
> -	YY_BREAK
> -case 13:
> -YY_RULE_SETUP
> -ECHO;
> -	YY_BREAK
> -case YY_STATE_EOF(INITIAL):
> -	yyterminate();
> -
> -	case YY_END_OF_BUFFER:
> -		{
> -		/* Amount of text matched not including the EOB char. */
> -		int yy_amount_of_matched_text = (int) (yy_cp - (yytext_ptr)) - 1;
> -
> -		/* Undo the effects of YY_DO_BEFORE_ACTION. */
> -		*yy_cp = (yy_hold_char);
> -		YY_RESTORE_YY_MORE_OFFSET
> -
> -		if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status == YY_BUFFER_NEW )
> -			{
> -			/* We're scanning a new file or input source.  It's
> -			 * possible that this happened because the user
> -			 * just pointed yyin at a new source and called
> -			 * yylex().  If so, then we have to assure
> -			 * consistency between YY_CURRENT_BUFFER and our
> -			 * globals.  Here is the right place to do so, because
> -			 * this is the first action (other than possibly a
> -			 * back-up) that will match for the new input source.
> -			 */
> -			(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
> -			YY_CURRENT_BUFFER_LVALUE->yy_input_file = yyin;
> -			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status = YY_BUFFER_NORMAL;
> -			}
> -
> -		/* Note that here we test for yy_c_buf_p "<=" to the position
> -		 * of the first EOB in the buffer, since yy_c_buf_p will
> -		 * already have been incremented past the NUL character
> -		 * (since all states make transitions on EOB to the
> -		 * end-of-buffer state).  Contrast this with the test
> -		 * in input().
> -		 */
> -		if ( (yy_c_buf_p) <= &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
> -			{ /* This was really a NUL. */
> -			yy_state_type yy_next_state;
> -
> -			(yy_c_buf_p) = (yytext_ptr) + yy_amount_of_matched_text;
> -
> -			yy_current_state = yy_get_previous_state(  );
> -
> -			/* Okay, we're now positioned to make the NUL
> -			 * transition.  We couldn't have
> -			 * yy_get_previous_state() go ahead and do it
> -			 * for us because it doesn't know how to deal
> -			 * with the possibility of jamming (and we don't
> -			 * want to build jamming into it because then it
> -			 * will run more slowly).
> -			 */
> -
> -			yy_next_state = yy_try_NUL_trans( yy_current_state );
> -
> -			yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> -
> -			if ( yy_next_state )
> -				{
> -				/* Consume the NUL. */
> -				yy_cp = ++(yy_c_buf_p);
> -				yy_current_state = yy_next_state;
> -				goto yy_match;
> -				}
> -
> -			else
> -				{
> -				yy_cp = (yy_c_buf_p);
> -				goto yy_find_action;
> -				}
> -			}
> -
> -		else switch ( yy_get_next_buffer(  ) )
> -			{
> -			case EOB_ACT_END_OF_FILE:
> -				{
> -				(yy_did_buffer_switch_on_eof) = 0;
> -
> -				if ( yywrap( ) )
> -					{
> -					/* Note: because we've taken care in
> -					 * yy_get_next_buffer() to have set up
> -					 * yytext, we can now set up
> -					 * yy_c_buf_p so that if some total
> -					 * hoser (like flex itself) wants to
> -					 * call the scanner after we return the
> -					 * YY_NULL, it'll still work - another
> -					 * YY_NULL will get returned.
> -					 */
> -					(yy_c_buf_p) = (yytext_ptr) + YY_MORE_ADJ;
> -
> -					yy_act = YY_STATE_EOF(YY_START);
> -					goto do_action;
> -					}
> -
> -				else
> -					{
> -					if ( ! (yy_did_buffer_switch_on_eof) )
> -						YY_NEW_FILE;
> -					}
> -				break;
> -				}
> -
> -			case EOB_ACT_CONTINUE_SCAN:
> -				(yy_c_buf_p) =
> -					(yytext_ptr) + yy_amount_of_matched_text;
> -
> -				yy_current_state = yy_get_previous_state(  );
> -
> -				yy_cp = (yy_c_buf_p);
> -				yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> -				goto yy_match;
> -
> -			case EOB_ACT_LAST_MATCH:
> -				(yy_c_buf_p) =
> -				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)];
> -
> -				yy_current_state = yy_get_previous_state(  );
> -
> -				yy_cp = (yy_c_buf_p);
> -				yy_bp = (yytext_ptr) + YY_MORE_ADJ;
> -				goto yy_find_action;
> -			}
> -		break;
> -		}
> -
> -	default:
> -		YY_FATAL_ERROR(
> -			"fatal flex scanner internal error--no action found" );
> -	} /* end of action switch */
> -		} /* end of scanning one token */
> -} /* end of yylex */
> -
> -/* yy_get_next_buffer - try to read in a new buffer
> - *
> - * Returns a code representing an action:
> - *	EOB_ACT_LAST_MATCH -
> - *	EOB_ACT_CONTINUE_SCAN - continue scanning from current position
> - *	EOB_ACT_END_OF_FILE - end of file
> - */
> -static int yy_get_next_buffer (void)
> -{
> -    	register char *dest = YY_CURRENT_BUFFER_LVALUE->yy_ch_buf;
> -	register char *source = (yytext_ptr);
> -	register int number_to_move, i;
> -	int ret_val;
> -
> -	if ( (yy_c_buf_p) > &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] )
> -		YY_FATAL_ERROR(
> -		"fatal flex scanner internal error--end of buffer missed" );
> -
> -	if ( YY_CURRENT_BUFFER_LVALUE->yy_fill_buffer == 0 )
> -		{ /* Don't try to fill the buffer, so this is an EOF. */
> -		if ( (yy_c_buf_p) - (yytext_ptr) - YY_MORE_ADJ == 1 )
> -			{
> -			/* We matched a single character, the EOB, so
> -			 * treat this as a final EOF.
> -			 */
> -			return EOB_ACT_END_OF_FILE;
> -			}
> -
> -		else
> -			{
> -			/* We matched some text prior to the EOB, first
> -			 * process it.
> -			 */
> -			return EOB_ACT_LAST_MATCH;
> -			}
> -		}
> -
> -	/* Try to read more data. */
> -
> -	/* First move last chars to start of buffer. */
> -	number_to_move = (int) ((yy_c_buf_p) - (yytext_ptr)) - 1;
> -
> -	for ( i = 0; i < number_to_move; ++i )
> -		*(dest++) = *(source++);
> -
> -	if ( YY_CURRENT_BUFFER_LVALUE->yy_buffer_status == YY_BUFFER_EOF_PENDING )
> -		/* don't do the read, it's not guaranteed to return an EOF,
> -		 * just force an EOF
> -		 */
> -		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars) = 0;
> -
> -	else
> -		{
> -			int num_to_read =
> -			YY_CURRENT_BUFFER_LVALUE->yy_buf_size - number_to_move - 1;
> -
> -		while ( num_to_read <= 0 )
> -			{ /* Not enough room in the buffer - grow it. */
> -
> -			/* just a shorter name for the current buffer */
> -			YY_BUFFER_STATE b = YY_CURRENT_BUFFER;
> -
> -			int yy_c_buf_p_offset =
> -				(int) ((yy_c_buf_p) - b->yy_ch_buf);
> -
> -			if ( b->yy_is_our_buffer )
> -				{
> -				int new_size = b->yy_buf_size * 2;
> -
> -				if ( new_size <= 0 )
> -					b->yy_buf_size += b->yy_buf_size / 8;
> -				else
> -					b->yy_buf_size *= 2;
> -
> -				b->yy_ch_buf = (char *)
> -					/* Include room in for 2 EOB chars. */
> -					yyrealloc((void *) b->yy_ch_buf,b->yy_buf_size + 2  );
> -				}
> -			else
> -				/* Can't grow it, we don't own it. */
> -				b->yy_ch_buf = 0;
> -
> -			if ( ! b->yy_ch_buf )
> -				YY_FATAL_ERROR(
> -				"fatal error - scanner input buffer overflow" );
> -
> -			(yy_c_buf_p) = &b->yy_ch_buf[yy_c_buf_p_offset];
> -
> -			num_to_read = YY_CURRENT_BUFFER_LVALUE->yy_buf_size -
> -						number_to_move - 1;
> -
> -			}
> -
> -		if ( num_to_read > YY_READ_BUF_SIZE )
> -			num_to_read = YY_READ_BUF_SIZE;
> -
> -		/* Read in more data. */
> -		YY_INPUT( (&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move]),
> -			(yy_n_chars), (size_t) num_to_read );
> -
> -		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> -		}
> -
> -	if ( (yy_n_chars) == 0 )
> -		{
> -		if ( number_to_move == YY_MORE_ADJ )
> -			{
> -			ret_val = EOB_ACT_END_OF_FILE;
> -			yyrestart(yyin  );
> -			}
> -
> -		else
> -			{
> -			ret_val = EOB_ACT_LAST_MATCH;
> -			YY_CURRENT_BUFFER_LVALUE->yy_buffer_status =
> -				YY_BUFFER_EOF_PENDING;
> -			}
> -		}
> -
> -	else
> -		ret_val = EOB_ACT_CONTINUE_SCAN;
> -
> -	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LVALUE->yy_buf_size) {
> -		/* Extend the array by 50%, plus the number we really need. */
> -		yy_size_t new_size = (yy_n_chars) + number_to_move + ((yy_n_chars) >> 1);
> -		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf = (char *) yyrealloc((void *) YY_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
> -		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
> -			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
> -	}
> -
> -	(yy_n_chars) += number_to_move;
> -	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] = YY_END_OF_BUFFER_CHAR;
> -	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] = YY_END_OF_BUFFER_CHAR;
> -
> -	(yytext_ptr) = &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[0];
> -
> -	return ret_val;
> -}
> -
> -/* yy_get_previous_state - get the state just before the EOB char was reached */
> -
> -    static yy_state_type yy_get_previous_state (void)
> -{
> -	register yy_state_type yy_current_state;
> -	register char *yy_cp;
> -    
> -	yy_current_state = (yy_start);
> -	yy_current_state += YY_AT_BOL();
> -
> -	for ( yy_cp = (yytext_ptr) + YY_MORE_ADJ; yy_cp < (yy_c_buf_p); ++yy_cp )
> -		{
> -		register YY_CHAR yy_c = (*yy_cp ? yy_ec[YY_SC_TO_UI(*yy_cp)] : 1);
> -		if ( yy_accept[yy_current_state] )
> -			{
> -			(yy_last_accepting_state) = yy_current_state;
> -			(yy_last_accepting_cpos) = yy_cp;
> -			}
> -		while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> -			{
> -			yy_current_state = (int) yy_def[yy_current_state];
> -			if ( yy_current_state >= 73 )
> -				yy_c = yy_meta[(unsigned int) yy_c];
> -			}
> -		yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int) yy_c];
> -		}
> -
> -	return yy_current_state;
> -}
> -
> -/* yy_try_NUL_trans - try to make a transition on the NUL character
> - *
> - * synopsis
> - *	next_state = yy_try_NUL_trans( current_state );
> - */
> -    static yy_state_type yy_try_NUL_trans  (yy_state_type yy_current_state )
> -{
> -	register int yy_is_jam;
> -    	register char *yy_cp = (yy_c_buf_p);
> -
> -	register YY_CHAR yy_c = 1;
> -	if ( yy_accept[yy_current_state] )
> -		{
> -		(yy_last_accepting_state) = yy_current_state;
> -		(yy_last_accepting_cpos) = yy_cp;
> -		}
> -	while ( yy_chk[yy_base[yy_current_state] + yy_c] != yy_current_state )
> -		{
> -		yy_current_state = (int) yy_def[yy_current_state];
> -		if ( yy_current_state >= 73 )
> -			yy_c = yy_meta[(unsigned int) yy_c];
> -		}
> -	yy_current_state = yy_nxt[yy_base[yy_current_state] + (unsigned int) yy_c];
> -	yy_is_jam = (yy_current_state == 72);
> -
> -	return yy_is_jam ? 0 : yy_current_state;
> -}
> -
> -    static void yyunput (int c, register char * yy_bp )
> -{
> -	register char *yy_cp;
> -    
> -    yy_cp = (yy_c_buf_p);
> -
> -	/* undo effects of setting up yytext */
> -	*yy_cp = (yy_hold_char);
> -
> -	if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
> -		{ /* need to shift things up to make room */
> -		/* +2 for EOB chars. */
> -		register int number_to_move = (yy_n_chars) + 2;
> -		register char *dest = &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[
> -					YY_CURRENT_BUFFER_LVALUE->yy_buf_size + 2];
> -		register char *source =
> -				&YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[number_to_move];
> -
> -		while ( source > YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
> -			*--dest = *--source;
> -
> -		yy_cp += (int) (dest - source);
> -		yy_bp += (int) (dest - source);
> -		YY_CURRENT_BUFFER_LVALUE->yy_n_chars =
> -			(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_buf_size;
> -
> -		if ( yy_cp < YY_CURRENT_BUFFER_LVALUE->yy_ch_buf + 2 )
> -			YY_FATAL_ERROR( "flex scanner push-back overflow" );
> -		}
> -
> -	*--yy_cp = (char) c;
> -
> -	(yytext_ptr) = yy_bp;
> -	(yy_hold_char) = *yy_cp;
> -	(yy_c_buf_p) = yy_cp;
> -}
> -
> -#ifndef YY_NO_INPUT
> -#ifdef __cplusplus
> -    static int yyinput (void)
> -#else
> -    static int input  (void)
> -#endif
> -
> -{
> -	int c;
> -    
> -	*(yy_c_buf_p) = (yy_hold_char);
> -
> -	if ( *(yy_c_buf_p) == YY_END_OF_BUFFER_CHAR )
> -		{
> -		/* yy_c_buf_p now points to the character we want to return.
> -		 * If this occurs *before* the EOB characters, then it's a
> -		 * valid NUL; if not, then we've hit the end of the buffer.
> -		 */
> -		if ( (yy_c_buf_p) < &YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] )
> -			/* This was really a NUL. */
> -			*(yy_c_buf_p) = '\0';
> -
> -		else
> -			{ /* need more input */
> -			int offset = (yy_c_buf_p) - (yytext_ptr);
> -			++(yy_c_buf_p);
> -
> -			switch ( yy_get_next_buffer(  ) )
> -				{
> -				case EOB_ACT_LAST_MATCH:
> -					/* This happens because yy_g_n_b()
> -					 * sees that we've accumulated a
> -					 * token and flags that we need to
> -					 * try matching the token before
> -					 * proceeding.  But for input(),
> -					 * there's no matching to consider.
> -					 * So convert the EOB_ACT_LAST_MATCH
> -					 * to EOB_ACT_END_OF_FILE.
> -					 */
> -
> -					/* Reset buffer status. */
> -					yyrestart(yyin );
> -
> -					/*FALLTHROUGH*/
> -
> -				case EOB_ACT_END_OF_FILE:
> -					{
> -					if ( yywrap( ) )
> -						return EOF;
> -
> -					if ( ! (yy_did_buffer_switch_on_eof) )
> -						YY_NEW_FILE;
> -#ifdef __cplusplus
> -					return yyinput();
> -#else
> -					return input();
> -#endif
> -					}
> -
> -				case EOB_ACT_CONTINUE_SCAN:
> -					(yy_c_buf_p) = (yytext_ptr) + offset;
> -					break;
> -				}
> -			}
> -		}
> -
> -	c = *(unsigned char *) (yy_c_buf_p);	/* cast for 8-bit char's */
> -	*(yy_c_buf_p) = '\0';	/* preserve yytext */
> -	(yy_hold_char) = *++(yy_c_buf_p);
> -
> -	YY_CURRENT_BUFFER_LVALUE->yy_at_bol = (c == '\n');
> -
> -	return c;
> -}
> -#endif	/* ifndef YY_NO_INPUT */
> -
> -/** Immediately switch to a different input stream.
> - * @param input_file A readable stream.
> - * 
> - * @note This function does not reset the start condition to @c INITIAL .
> - */
> -    void yyrestart  (FILE * input_file )
> -{
> -    
> -	if ( ! YY_CURRENT_BUFFER ){
> -        yyensure_buffer_stack ();
> -		YY_CURRENT_BUFFER_LVALUE =
> -            yy_create_buffer(yyin,YY_BUF_SIZE );
> -	}
> -
> -	yy_init_buffer(YY_CURRENT_BUFFER,input_file );
> -	yy_load_buffer_state( );
> -}
> -
> -/** Switch to a different input buffer.
> - * @param new_buffer The new input buffer.
> - * 
> - */
> -    void yy_switch_to_buffer  (YY_BUFFER_STATE  new_buffer )
> -{
> -    
> -	/* TODO. We should be able to replace this entire function body
> -	 * with
> -	 *		yypop_buffer_state();
> -	 *		yypush_buffer_state(new_buffer);
> -     */
> -	yyensure_buffer_stack ();
> -	if ( YY_CURRENT_BUFFER == new_buffer )
> -		return;
> -
> -	if ( YY_CURRENT_BUFFER )
> -		{
> -		/* Flush out information for old buffer. */
> -		*(yy_c_buf_p) = (yy_hold_char);
> -		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
> -		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> -		}
> -
> -	YY_CURRENT_BUFFER_LVALUE = new_buffer;
> -	yy_load_buffer_state( );
> -
> -	/* We don't actually know whether we did this switch during
> -	 * EOF (yywrap()) processing, but the only time this flag
> -	 * is looked at is after yywrap() is called, so it's safe
> -	 * to go ahead and always set it.
> -	 */
> -	(yy_did_buffer_switch_on_eof) = 1;
> -}
> -
> -static void yy_load_buffer_state  (void)
> -{
> -    	(yy_n_chars) = YY_CURRENT_BUFFER_LVALUE->yy_n_chars;
> -	(yytext_ptr) = (yy_c_buf_p) = YY_CURRENT_BUFFER_LVALUE->yy_buf_pos;
> -	yyin = YY_CURRENT_BUFFER_LVALUE->yy_input_file;
> -	(yy_hold_char) = *(yy_c_buf_p);
> -}
> -
> -/** Allocate and initialize an input buffer state.
> - * @param file A readable stream.
> - * @param size The character buffer size in bytes. When in doubt, use @c YY_BUF_SIZE.
> - * 
> - * @return the allocated buffer state.
> - */
> -    YY_BUFFER_STATE yy_create_buffer  (FILE * file, int  size )
> -{
> -	YY_BUFFER_STATE b;
> -    
> -	b = (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
> -	if ( ! b )
> -		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
> -
> -	b->yy_buf_size = size;
> -
> -	/* yy_ch_buf has to be 2 characters longer than the size given because
> -	 * we need to put in 2 end-of-buffer characters.
> -	 */
> -	b->yy_ch_buf = (char *) yyalloc(b->yy_buf_size + 2  );
> -	if ( ! b->yy_ch_buf )
> -		YY_FATAL_ERROR( "out of dynamic memory in yy_create_buffer()" );
> -
> -	b->yy_is_our_buffer = 1;
> -
> -	yy_init_buffer(b,file );
> -
> -	return b;
> -}
> -
> -/** Destroy the buffer.
> - * @param b a buffer created with yy_create_buffer()
> - * 
> - */
> -    void yy_delete_buffer (YY_BUFFER_STATE  b )
> -{
> -    
> -	if ( ! b )
> -		return;
> -
> -	if ( b == YY_CURRENT_BUFFER ) /* Not sure if we should pop here. */
> -		YY_CURRENT_BUFFER_LVALUE = (YY_BUFFER_STATE) 0;
> -
> -	if ( b->yy_is_our_buffer )
> -		yyfree((void *) b->yy_ch_buf  );
> -
> -	yyfree((void *) b  );
> -}
> -
> -#ifndef __cplusplus
> -extern int isatty (int );
> -#endif /* __cplusplus */
> -    
> -/* Initializes or reinitializes a buffer.
> - * This function is sometimes called more than once on the same buffer,
> - * such as during a yyrestart() or at EOF.
> - */
> -    static void yy_init_buffer  (YY_BUFFER_STATE  b, FILE * file )
> -
> -{
> -	int oerrno = errno;
> -    
> -	yy_flush_buffer(b );
> -
> -	b->yy_input_file = file;
> -	b->yy_fill_buffer = 1;
> -
> -    /* If b is the current buffer, then yy_init_buffer was _probably_
> -     * called from yyrestart() or through yy_get_next_buffer.
> -     * In that case, we don't want to reset the lineno or column.
> -     */
> -    if (b != YY_CURRENT_BUFFER){
> -        b->yy_bs_lineno = 1;
> -        b->yy_bs_column = 0;
> -    }
> -
> -        b->yy_is_interactive = file ? (isatty( fileno(file) ) > 0) : 0;
> -    
> -	errno = oerrno;
> -}
> -
> -/** Discard all buffered characters. On the next scan, YY_INPUT will be called.
> - * @param b the buffer state to be flushed, usually @c YY_CURRENT_BUFFER.
> - * 
> - */
> -    void yy_flush_buffer (YY_BUFFER_STATE  b )
> -{
> -    	if ( ! b )
> -		return;
> -
> -	b->yy_n_chars = 0;
> -
> -	/* We always need two end-of-buffer characters.  The first causes
> -	 * a transition to the end-of-buffer state.  The second causes
> -	 * a jam in that state.
> -	 */
> -	b->yy_ch_buf[0] = YY_END_OF_BUFFER_CHAR;
> -	b->yy_ch_buf[1] = YY_END_OF_BUFFER_CHAR;
> -
> -	b->yy_buf_pos = &b->yy_ch_buf[0];
> -
> -	b->yy_at_bol = 1;
> -	b->yy_buffer_status = YY_BUFFER_NEW;
> -
> -	if ( b == YY_CURRENT_BUFFER )
> -		yy_load_buffer_state( );
> -}
> -
> -/** Pushes the new state onto the stack. The new state becomes
> - *  the current state. This function will allocate the stack
> - *  if necessary.
> - *  @param new_buffer The new state.
> - *  
> - */
> -void yypush_buffer_state (YY_BUFFER_STATE new_buffer )
> -{
> -    	if (new_buffer == NULL)
> -		return;
> -
> -	yyensure_buffer_stack();
> -
> -	/* This block is copied from yy_switch_to_buffer. */
> -	if ( YY_CURRENT_BUFFER )
> -		{
> -		/* Flush out information for old buffer. */
> -		*(yy_c_buf_p) = (yy_hold_char);
> -		YY_CURRENT_BUFFER_LVALUE->yy_buf_pos = (yy_c_buf_p);
> -		YY_CURRENT_BUFFER_LVALUE->yy_n_chars = (yy_n_chars);
> -		}
> -
> -	/* Only push if top exists. Otherwise, replace top. */
> -	if (YY_CURRENT_BUFFER)
> -		(yy_buffer_stack_top)++;
> -	YY_CURRENT_BUFFER_LVALUE = new_buffer;
> -
> -	/* copied from yy_switch_to_buffer. */
> -	yy_load_buffer_state( );
> -	(yy_did_buffer_switch_on_eof) = 1;
> -}
> -
> -/** Removes and deletes the top of the stack, if present.
> - *  The next element becomes the new top.
> - *  
> - */
> -void yypop_buffer_state (void)
> -{
> -    	if (!YY_CURRENT_BUFFER)
> -		return;
> -
> -	yy_delete_buffer(YY_CURRENT_BUFFER );
> -	YY_CURRENT_BUFFER_LVALUE = NULL;
> -	if ((yy_buffer_stack_top) > 0)
> -		--(yy_buffer_stack_top);
> -
> -	if (YY_CURRENT_BUFFER) {
> -		yy_load_buffer_state( );
> -		(yy_did_buffer_switch_on_eof) = 1;
> -	}
> -}
> -
> -/* Allocates the stack if it does not exist.
> - *  Guarantees space for at least one push.
> - */
> -static void yyensure_buffer_stack (void)
> -{
> -	int num_to_alloc;
> -    
> -	if (!(yy_buffer_stack)) {
> -
> -		/* First allocation is just for 2 elements, since we don't know if this
> -		 * scanner will even need a stack. We use 2 instead of 1 to avoid an
> -		 * immediate realloc on the next call.
> -         */
> -		num_to_alloc = 1;
> -		(yy_buffer_stack) = (struct yy_buffer_state**)yyalloc
> -								(num_to_alloc * sizeof(struct yy_buffer_state*)
> -								);
> -		if ( ! (yy_buffer_stack) )
> -			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
> -								  
> -		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_state*));
> -				
> -		(yy_buffer_stack_max) = num_to_alloc;
> -		(yy_buffer_stack_top) = 0;
> -		return;
> -	}
> -
> -	if ((yy_buffer_stack_top) >= ((yy_buffer_stack_max)) - 1){
> -
> -		/* Increase the buffer to prepare for a possible push. */
> -		int grow_size = 8 /* arbitrary grow size */;
> -
> -		num_to_alloc = (yy_buffer_stack_max) + grow_size;
> -		(yy_buffer_stack) = (struct yy_buffer_state**)yyrealloc
> -								((yy_buffer_stack),
> -								num_to_alloc * sizeof(struct yy_buffer_state*)
> -								);
> -		if ( ! (yy_buffer_stack) )
> -			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
> -
> -		/* zero only the new slots.*/
> -		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * sizeof(struct yy_buffer_state*));
> -		(yy_buffer_stack_max) = num_to_alloc;
> -	}
> -}
> -
> -/** Setup the input buffer state to scan directly from a user-specified character buffer.
> - * @param base the character buffer
> - * @param size the size in bytes of the character buffer
> - * 
> - * @return the newly allocated buffer state object. 
> - */
> -YY_BUFFER_STATE yy_scan_buffer  (char * base, yy_size_t  size )
> -{
> -	YY_BUFFER_STATE b;
> -    
> -	if ( size < 2 ||
> -	     base[size-2] != YY_END_OF_BUFFER_CHAR ||
> -	     base[size-1] != YY_END_OF_BUFFER_CHAR )
> -		/* They forgot to leave room for the EOB's. */
> -		return 0;
> -
> -	b = (YY_BUFFER_STATE) yyalloc(sizeof( struct yy_buffer_state )  );
> -	if ( ! b )
> -		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_buffer()" );
> -
> -	b->yy_buf_size = size - 2;	/* "- 2" to take care of EOB's */
> -	b->yy_buf_pos = b->yy_ch_buf = base;
> -	b->yy_is_our_buffer = 0;
> -	b->yy_input_file = 0;
> -	b->yy_n_chars = b->yy_buf_size;
> -	b->yy_is_interactive = 0;
> -	b->yy_at_bol = 1;
> -	b->yy_fill_buffer = 0;
> -	b->yy_buffer_status = YY_BUFFER_NEW;
> -
> -	yy_switch_to_buffer(b  );
> -
> -	return b;
> -}
> -
> -/** Setup the input buffer state to scan a string. The next call to yylex() will
> - * scan from a @e copy of @a str.
> - * @param yystr a NUL-terminated string to scan
> - * 
> - * @return the newly allocated buffer state object.
> - * @note If you want to scan bytes that may contain NUL values, then use
> - *       yy_scan_bytes() instead.
> - */
> -YY_BUFFER_STATE yy_scan_string (yyconst char * yystr )
> -{
> -    
> -	return yy_scan_bytes(yystr,strlen(yystr) );
> -}
> -
> -/** Setup the input buffer state to scan the given bytes. The next call to yylex() will
> - * scan from a @e copy of @a bytes.
> - * @param bytes the byte buffer to scan
> - * @param len the number of bytes in the buffer pointed to by @a bytes.
> - * 
> - * @return the newly allocated buffer state object.
> - */
> -YY_BUFFER_STATE yy_scan_bytes  (yyconst char * yybytes, int  _yybytes_len )
> -{
> -	YY_BUFFER_STATE b;
> -	char *buf;
> -	yy_size_t n;
> -	int i;
> -    
> -	/* Get memory for full buffer, including space for trailing EOB's. */
> -	n = _yybytes_len + 2;
> -	buf = (char *) yyalloc(n  );
> -	if ( ! buf )
> -		YY_FATAL_ERROR( "out of dynamic memory in yy_scan_bytes()" );
> -
> -	for ( i = 0; i < _yybytes_len; ++i )
> -		buf[i] = yybytes[i];
> -
> -	buf[_yybytes_len] = buf[_yybytes_len+1] = YY_END_OF_BUFFER_CHAR;
> -
> -	b = yy_scan_buffer(buf,n );
> -	if ( ! b )
> -		YY_FATAL_ERROR( "bad buffer in yy_scan_bytes()" );
> -
> -	/* It's okay to grow etc. this buffer, and we should throw it
> -	 * away when we're done.
> -	 */
> -	b->yy_is_our_buffer = 1;
> -
> -	return b;
> -}
> -
> -#ifndef YY_EXIT_FAILURE
> -#define YY_EXIT_FAILURE 2
> -#endif
> -
> -static void yy_fatal_error (yyconst char* msg )
> -{
> -    	(void) fprintf( stderr, "%s\n", msg );
> -	exit( YY_EXIT_FAILURE );
> -}
> -
> -/* Redefine yyless() so it works in section 3 code. */
> -
> -#undef yyless
> -#define yyless(n) \
> -	do \
> -		{ \
> -		/* Undo effects of setting up yytext. */ \
> -        int yyless_macro_arg = (n); \
> -        YY_LESS_LINENO(yyless_macro_arg);\
> -		yytext[yyleng] = (yy_hold_char); \
> -		(yy_c_buf_p) = yytext + yyless_macro_arg; \
> -		(yy_hold_char) = *(yy_c_buf_p); \
> -		*(yy_c_buf_p) = '\0'; \
> -		yyleng = yyless_macro_arg; \
> -		} \
> -	while ( 0 )
> -
> -/* Accessor  methods (get/set functions) to struct members. */
> -
> -/** Get the current line number.
> - * 
> - */
> -int yyget_lineno  (void)
> -{
> -        
> -    return yylineno;
> -}
> -
> -/** Get the input stream.
> - * 
> - */
> -FILE *yyget_in  (void)
> -{
> -        return yyin;
> -}
> -
> -/** Get the output stream.
> - * 
> - */
> -FILE *yyget_out  (void)
> -{
> -        return yyout;
> -}
> -
> -/** Get the length of the current token.
> - * 
> - */
> -int yyget_leng  (void)
> -{
> -        return yyleng;
> -}
> -
> -/** Get the current token.
> - * 
> - */
> -
> -char *yyget_text  (void)
> -{
> -        return yytext;
> -}
> -
> -/** Set the current line number.
> - * @param line_number
> - * 
> - */
> -void yyset_lineno (int  line_number )
> -{
> -    
> -    yylineno = line_number;
> -}
> -
> -/** Set the input stream. This does not discard the current
> - * input buffer.
> - * @param in_str A readable stream.
> - * 
> - * @see yy_switch_to_buffer
> - */
> -void yyset_in (FILE *  in_str )
> -{
> -        yyin = in_str ;
> -}
> -
> -void yyset_out (FILE *  out_str )
> -{
> -        yyout = out_str ;
> -}
> -
> -int yyget_debug  (void)
> -{
> -        return yy_flex_debug;
> -}
> -
> -void yyset_debug (int  bdebug )
> -{
> -        yy_flex_debug = bdebug ;
> -}
> -
> -static int yy_init_globals (void)
> -{
> -        /* Initialization is the same as for the non-reentrant scanner.
> -     * This function is called from yylex_destroy(), so don't allocate here.
> -     */
> -
> -    (yy_buffer_stack) = 0;
> -    (yy_buffer_stack_top) = 0;
> -    (yy_buffer_stack_max) = 0;
> -    (yy_c_buf_p) = (char *) 0;
> -    (yy_init) = 0;
> -    (yy_start) = 0;
> -
> -/* Defined in main.c */
> -#ifdef YY_STDINIT
> -    yyin = stdin;
> -    yyout = stdout;
> -#else
> -    yyin = (FILE *) 0;
> -    yyout = (FILE *) 0;
> -#endif
> -
> -    /* For future reference: Set errno on error, since we are called by
> -     * yylex_init()
> -     */
> -    return 0;
> -}
> -
> -/* yylex_destroy is for both reentrant and non-reentrant scanners. */
> -int yylex_destroy  (void)
> -{
> -    
> -    /* Pop the buffer stack, destroying each element. */
> -	while(YY_CURRENT_BUFFER){
> -		yy_delete_buffer(YY_CURRENT_BUFFER  );
> -		YY_CURRENT_BUFFER_LVALUE = NULL;
> -		yypop_buffer_state();
> -	}
> -
> -	/* Destroy the stack itself. */
> -	yyfree((yy_buffer_stack) );
> -	(yy_buffer_stack) = NULL;
> -
> -    /* Reset the globals. This is important in a non-reentrant scanner so the next time
> -     * yylex() is called, initialization will occur. */
> -    yy_init_globals( );
> -
> -    return 0;
> -}
> -
> -/*
> - * Internal utility routines.
> - */
> -
> -#ifndef yytext_ptr
> -static void yy_flex_strncpy (char* s1, yyconst char * s2, int n )
> -{
> -	register int i;
> -	for ( i = 0; i < n; ++i )
> -		s1[i] = s2[i];
> -}
> -#endif
> -
> -#ifdef YY_NEED_STRLEN
> -static int yy_flex_strlen (yyconst char * s )
> -{
> -	register int n;
> -	for ( n = 0; s[n]; ++n )
> -		;
> -
> -	return n;
> -}
> -#endif
> -
> -void *yyalloc (yy_size_t  size )
> -{
> -	return (void *) malloc( size );
> -}
> -
> -void *yyrealloc  (void * ptr, yy_size_t  size )
> -{
> -	/* The cast to (char *) in the following accommodates both
> -	 * implementations that use char* generic pointers, and those
> -	 * that use void* generic pointers.  It works with the latter
> -	 * because both ANSI C and C++ allow castless assignment from
> -	 * any pointer type to void*, and deal with argument conversions
> -	 * as though doing an assignment.
> -	 */
> -	return (void *) realloc( (char *) ptr, size );
> -}
> -
> -void yyfree (void * ptr )
> -{
> -	free( (char *) ptr );	/* see yyrealloc() for (char *) cast */
> -}
> -
> -#define YYTABLES_NAME "yytables"
> -
> -/* Bring in the keyword recognizer.  */
> -
> -#include "keywords.c"
> -
> -/* Macros to append to our phrase collection list.  */
> -
> -/*
> - * We mark any token, that that equals to a known enumerator, as
> - * SYM_ENUM_CONST. The parser will change this for struct and union tags later,
> - * the only problem is struct and union members:
> - *    enum e { a, b }; struct s { int a, b; }
> - * but in this case, the only effect will be, that the ABI checksums become
> - * more volatile, which is acceptable. Also, such collisions are quite rare,
> - * so far it was only observed in include/linux/telephony.h.
> - */
> -#define _APP(T,L)	do {						   \
> -			  cur_node = next_node;				   \
> -			  next_node = xmalloc(sizeof(*next_node));	   \
> -			  next_node->next = cur_node;			   \
> -			  cur_node->string = memcpy(xmalloc(L+1), T, L+1); \
> -			  cur_node->tag =				   \
> -			    find_symbol(cur_node->string, SYM_ENUM_CONST, 1)?\
> -			    SYM_ENUM_CONST : SYM_NORMAL ;		   \
> -			  cur_node->in_source_file = in_source_file;       \
> -			} while (0)
> -
> -#define APP		_APP(yytext, yyleng)
> -
> -/* The second stage lexer.  Here we incorporate knowledge of the state
> -   of the parser to tailor the tokens that are returned.  */
> -
> -int
> -yylex(void)
> -{
> -  static enum {
> -    ST_NOTSTARTED, ST_NORMAL, ST_ATTRIBUTE, ST_ASM, ST_TYPEOF, ST_TYPEOF_1,
> -    ST_BRACKET, ST_BRACE, ST_EXPRESSION,
> -    ST_TABLE_1, ST_TABLE_2, ST_TABLE_3, ST_TABLE_4,
> -    ST_TABLE_5, ST_TABLE_6
> -  } lexstate = ST_NOTSTARTED;
> -
> -  static int suppress_type_lookup, dont_want_brace_phrase;
> -  static struct string_list *next_node;
> -
> -  int token, count = 0;
> -  struct string_list *cur_node;
> -
> -  if (lexstate == ST_NOTSTARTED)
> -    {
> -      next_node = xmalloc(sizeof(*next_node));
> -      next_node->next = NULL;
> -      lexstate = ST_NORMAL;
> -    }
> -
> -repeat:
> -  token = yylex1();
> -
> -  if (token == 0)
> -    return 0;
> -  else if (token == FILENAME)
> -    {
> -      char *file, *e;
> -
> -      /* Save the filename and line number for later error messages.  */
> -
> -      if (cur_filename)
> -	free(cur_filename);
> -
> -      file = strchr(yytext, '\"')+1;
> -      e = strchr(file, '\"');
> -      *e = '\0';
> -      cur_filename = memcpy(xmalloc(e-file+1), file, e-file+1);
> -      cur_line = atoi(yytext+2);
> -
> -      if (!source_file) {
> -        source_file = xstrdup(cur_filename);
> -        in_source_file = 1;
> -      } else {
> -        in_source_file = (strcmp(cur_filename, source_file) == 0);
> -      }
> -
> -      goto repeat;
> -    }
> -
> -  switch (lexstate)
> -    {
> -    case ST_NORMAL:
> -      switch (token)
> -	{
> -	case IDENT:
> -	  APP;
> -	  {
> -	    int r = is_reserved_word(yytext, yyleng);
> -	    if (r >= 0)
> -	      {
> -		switch (token = r)
> -		  {
> -		  case ATTRIBUTE_KEYW:
> -		    lexstate = ST_ATTRIBUTE;
> -		    count = 0;
> -		    goto repeat;
> -		  case ASM_KEYW:
> -		    lexstate = ST_ASM;
> -		    count = 0;
> -		    goto repeat;
> -		  case TYPEOF_KEYW:
> -		    lexstate = ST_TYPEOF;
> -		    count = 0;
> -		    goto repeat;
> -
> -		  case STRUCT_KEYW:
> -		  case UNION_KEYW:
> -		  case ENUM_KEYW:
> -		    dont_want_brace_phrase = 3;
> -		    suppress_type_lookup = 2;
> -		    goto fini;
> -
> -		  case EXPORT_SYMBOL_KEYW:
> -		      goto fini;
> -		  }
> -	      }
> -	    if (!suppress_type_lookup)
> -	      {
> -		if (find_symbol(yytext, SYM_TYPEDEF, 1))
> -		  token = TYPE;
> -	      }
> -	  }
> -	  break;
> -
> -	case '[':
> -	  APP;
> -	  lexstate = ST_BRACKET;
> -	  count = 1;
> -	  goto repeat;
> -
> -	case '{':
> -	  APP;
> -	  if (dont_want_brace_phrase)
> -	    break;
> -	  lexstate = ST_BRACE;
> -	  count = 1;
> -	  goto repeat;
> -
> -	case '=': case ':':
> -	  APP;
> -	  lexstate = ST_EXPRESSION;
> -	  break;
> -
> -	case DOTS:
> -	default:
> -	  APP;
> -	  break;
> -	}
> -      break;
> -
> -    case ST_ATTRIBUTE:
> -      APP;
> -      switch (token)
> -	{
> -	case '(':
> -	  ++count;
> -	  goto repeat;
> -	case ')':
> -	  if (--count == 0)
> -	    {
> -	      lexstate = ST_NORMAL;
> -	      token = ATTRIBUTE_PHRASE;
> -	      break;
> -	    }
> -	  goto repeat;
> -	default:
> -	  goto repeat;
> -	}
> -      break;
> -
> -    case ST_ASM:
> -      APP;
> -      switch (token)
> -	{
> -	case '(':
> -	  ++count;
> -	  goto repeat;
> -	case ')':
> -	  if (--count == 0)
> -	    {
> -	      lexstate = ST_NORMAL;
> -	      token = ASM_PHRASE;
> -	      break;
> -	    }
> -	  goto repeat;
> -	default:
> -	  goto repeat;
> -	}
> -      break;
> -
> -    case ST_TYPEOF_1:
> -      if (token == IDENT)
> -	{
> -	  if (is_reserved_word(yytext, yyleng) >= 0
> -	      || find_symbol(yytext, SYM_TYPEDEF, 1))
> -	    {
> -	      yyless(0);
> -	      unput('(');
> -	      lexstate = ST_NORMAL;
> -	      token = TYPEOF_KEYW;
> -	      break;
> -	    }
> -	  _APP("(", 1);
> -	}
> -	lexstate = ST_TYPEOF;
> -	/* FALLTHRU */
> -
> -    case ST_TYPEOF:
> -      switch (token)
> -	{
> -	case '(':
> -	  if ( ++count == 1 )
> -	    lexstate = ST_TYPEOF_1;
> -	  else
> -	    APP;
> -	  goto repeat;
> -	case ')':
> -	  APP;
> -	  if (--count == 0)
> -	    {
> -	      lexstate = ST_NORMAL;
> -	      token = TYPEOF_PHRASE;
> -	      break;
> -	    }
> -	  goto repeat;
> -	default:
> -	  APP;
> -	  goto repeat;
> -	}
> -      break;
> -
> -    case ST_BRACKET:
> -      APP;
> -      switch (token)
> -	{
> -	case '[':
> -	  ++count;
> -	  goto repeat;
> -	case ']':
> -	  if (--count == 0)
> -	    {
> -	      lexstate = ST_NORMAL;
> -	      token = BRACKET_PHRASE;
> -	      break;
> -	    }
> -	  goto repeat;
> -	default:
> -	  goto repeat;
> -	}
> -      break;
> -
> -    case ST_BRACE:
> -      APP;
> -      switch (token)
> -	{
> -	case '{':
> -	  ++count;
> -	  goto repeat;
> -	case '}':
> -	  if (--count == 0)
> -	    {
> -	      lexstate = ST_NORMAL;
> -	      token = BRACE_PHRASE;
> -	      break;
> -	    }
> -	  goto repeat;
> -	default:
> -	  goto repeat;
> -	}
> -      break;
> -
> -    case ST_EXPRESSION:
> -      switch (token)
> -	{
> -	case '(': case '[': case '{':
> -	  ++count;
> -	  APP;
> -	  goto repeat;
> -	case '}':
> -	  /* is this the last line of an enum declaration? */
> -	  if (count == 0)
> -	    {
> -	      /* Put back the token we just read so's we can find it again
> -		 after registering the expression.  */
> -	      unput(token);
> -
> -	      lexstate = ST_NORMAL;
> -	      token = EXPRESSION_PHRASE;
> -	      break;
> -	    }
> -	  /* FALLTHRU */
> -	case ')': case ']':
> -	  --count;
> -	  APP;
> -	  goto repeat;
> -	case ',': case ';':
> -	  if (count == 0)
> -	    {
> -	      /* Put back the token we just read so's we can find it again
> -		 after registering the expression.  */
> -	      unput(token);
> -
> -	      lexstate = ST_NORMAL;
> -	      token = EXPRESSION_PHRASE;
> -	      break;
> -	    }
> -	  APP;
> -	  goto repeat;
> -	default:
> -	  APP;
> -	  goto repeat;
> -	}
> -      break;
> -
> -    case ST_TABLE_1:
> -      goto repeat;
> -
> -    case ST_TABLE_2:
> -      if (token == IDENT && yyleng == 1 && yytext[0] == 'X')
> -	{
> -	  token = EXPORT_SYMBOL_KEYW;
> -	  lexstate = ST_TABLE_5;
> -	  APP;
> -	  break;
> -	}
> -      lexstate = ST_TABLE_6;
> -      /* FALLTHRU */
> -
> -    case ST_TABLE_6:
> -      switch (token)
> -	{
> -	case '{': case '[': case '(':
> -	  ++count;
> -	  break;
> -	case '}': case ']': case ')':
> -	  --count;
> -	  break;
> -	case ',':
> -	  if (count == 0)
> -	    lexstate = ST_TABLE_2;
> -	  break;
> -	};
> -      goto repeat;
> -
> -    case ST_TABLE_3:
> -      goto repeat;
> -
> -    case ST_TABLE_4:
> -      if (token == ';')
> -	lexstate = ST_NORMAL;
> -      goto repeat;
> -
> -    case ST_TABLE_5:
> -      switch (token)
> -	{
> -	case ',':
> -	  token = ';';
> -	  lexstate = ST_TABLE_2;
> -	  APP;
> -	  break;
> -	default:
> -	  APP;
> -	  break;
> -	}
> -      break;
> -
> -    default:
> -      exit(1);
> -    }
> -fini:
> -
> -  if (suppress_type_lookup > 0)
> -    --suppress_type_lookup;
> -  if (dont_want_brace_phrase > 0)
> -    --dont_want_brace_phrase;
> -
> -  yylval = &next_node->next;
> -
> -  return token;
> -}
> -
> diff --git a/scripts/genksyms/parse.tab.c_shipped b/scripts/genksyms/parse.tab.c_shipped
> deleted file mode 100644
> index d02258b..0000000
> --- a/scripts/genksyms/parse.tab.c_shipped
> +++ /dev/null
> @@ -1,2394 +0,0 @@
> -/* A Bison parser, made by GNU Bison 2.7.  */
> -
> -/* Bison implementation for Yacc-like parsers in C
> -   
> -      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
> -   
> -   This program is free software: you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License as published by
> -   the Free Software Foundation, either version 3 of the License, or
> -   (at your option) any later version.
> -   
> -   This program is distributed in the hope that it will be useful,
> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -   GNU General Public License for more details.
> -   
> -   You should have received a copy of the GNU General Public License
> -   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
> -
> -/* As a special exception, you may create a larger work that contains
> -   part or all of the Bison parser skeleton and distribute that work
> -   under terms of your choice, so long as that work isn't itself a
> -   parser generator using the skeleton or a modified version thereof
> -   as a parser skeleton.  Alternatively, if you modify or redistribute
> -   the parser skeleton itself, you may (at your option) remove this
> -   special exception, which will cause the skeleton and the resulting
> -   Bison output files to be licensed under the GNU General Public
> -   License without this special exception.
> -   
> -   This special exception was added by the Free Software Foundation in
> -   version 2.2 of Bison.  */
> -
> -/* C LALR(1) parser skeleton written by Richard Stallman, by
> -   simplifying the original so-called "semantic" parser.  */
> -
> -/* All symbols defined below should begin with yy or YY, to avoid
> -   infringing on user name space.  This should be done even for local
> -   variables, as they might otherwise be expanded by user macros.
> -   There are some unavoidable exceptions within include files to
> -   define necessary library symbols; they are noted "INFRINGES ON
> -   USER NAME SPACE" below.  */
> -
> -/* Identify Bison output.  */
> -#define YYBISON 1
> -
> -/* Bison version.  */
> -#define YYBISON_VERSION "2.7"
> -
> -/* Skeleton name.  */
> -#define YYSKELETON_NAME "yacc.c"
> -
> -/* Pure parsers.  */
> -#define YYPURE 0
> -
> -/* Push parsers.  */
> -#define YYPUSH 0
> -
> -/* Pull parsers.  */
> -#define YYPULL 1
> -
> -
> -
> -
> -/* Copy the first part of user declarations.  */
> -
> -
> -
> -#include <assert.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include "genksyms.h"
> -
> -static int is_typedef;
> -static int is_extern;
> -static char *current_name;
> -static struct string_list *decl_spec;
> -
> -static void yyerror(const char *);
> -
> -static inline void
> -remove_node(struct string_list **p)
> -{
> -  struct string_list *node = *p;
> -  *p = node->next;
> -  free_node(node);
> -}
> -
> -static inline void
> -remove_list(struct string_list **pb, struct string_list **pe)
> -{
> -  struct string_list *b = *pb, *e = *pe;
> -  *pb = e;
> -  free_list(b, e);
> -}
> -
> -/* Record definition of a struct/union/enum */
> -static void record_compound(struct string_list **keyw,
> -		       struct string_list **ident,
> -		       struct string_list **body,
> -		       enum symbol_type type)
> -{
> -	struct string_list *b = *body, *i = *ident, *r;
> -
> -	if (i->in_source_file) {
> -		remove_node(keyw);
> -		(*ident)->tag = type;
> -		remove_list(body, ident);
> -		return;
> -	}
> -	r = copy_node(i); r->tag = type;
> -	r->next = (*keyw)->next; *body = r; (*keyw)->next = NULL;
> -	add_symbol(i->string, type, b, is_extern);
> -}
> -
> -
> -
> -
> -# ifndef YY_NULL
> -#  if defined __cplusplus && 201103L <= __cplusplus
> -#   define YY_NULL nullptr
> -#  else
> -#   define YY_NULL 0
> -#  endif
> -# endif
> -
> -/* Enabling verbose error messages.  */
> -#ifdef YYERROR_VERBOSE
> -# undef YYERROR_VERBOSE
> -# define YYERROR_VERBOSE 1
> -#else
> -# define YYERROR_VERBOSE 0
> -#endif
> -
> -
> -/* Enabling traces.  */
> -#ifndef YYDEBUG
> -# define YYDEBUG 1
> -#endif
> -#if YYDEBUG
> -extern int yydebug;
> -#endif
> -
> -/* Tokens.  */
> -#ifndef YYTOKENTYPE
> -# define YYTOKENTYPE
> -   /* Put the tokens into the symbol table, so that GDB and other debuggers
> -      know about them.  */
> -   enum yytokentype {
> -     ASM_KEYW = 258,
> -     ATTRIBUTE_KEYW = 259,
> -     AUTO_KEYW = 260,
> -     BOOL_KEYW = 261,
> -     CHAR_KEYW = 262,
> -     CONST_KEYW = 263,
> -     DOUBLE_KEYW = 264,
> -     ENUM_KEYW = 265,
> -     EXTERN_KEYW = 266,
> -     EXTENSION_KEYW = 267,
> -     FLOAT_KEYW = 268,
> -     INLINE_KEYW = 269,
> -     INT_KEYW = 270,
> -     LONG_KEYW = 271,
> -     REGISTER_KEYW = 272,
> -     RESTRICT_KEYW = 273,
> -     SHORT_KEYW = 274,
> -     SIGNED_KEYW = 275,
> -     STATIC_KEYW = 276,
> -     STRUCT_KEYW = 277,
> -     TYPEDEF_KEYW = 278,
> -     UNION_KEYW = 279,
> -     UNSIGNED_KEYW = 280,
> -     VOID_KEYW = 281,
> -     VOLATILE_KEYW = 282,
> -     TYPEOF_KEYW = 283,
> -     VA_LIST_KEYW = 284,
> -     EXPORT_SYMBOL_KEYW = 285,
> -     ASM_PHRASE = 286,
> -     ATTRIBUTE_PHRASE = 287,
> -     TYPEOF_PHRASE = 288,
> -     BRACE_PHRASE = 289,
> -     BRACKET_PHRASE = 290,
> -     EXPRESSION_PHRASE = 291,
> -     CHAR = 292,
> -     DOTS = 293,
> -     IDENT = 294,
> -     INT = 295,
> -     REAL = 296,
> -     STRING = 297,
> -     TYPE = 298,
> -     OTHER = 299,
> -     FILENAME = 300
> -   };
> -#endif
> -
> -
> -#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
> -typedef int YYSTYPE;
> -# define YYSTYPE_IS_TRIVIAL 1
> -# define yystype YYSTYPE /* obsolescent; will be withdrawn */
> -# define YYSTYPE_IS_DECLARED 1
> -#endif
> -
> -extern YYSTYPE yylval;
> -
> -#ifdef YYPARSE_PARAM
> -#if defined __STDC__ || defined __cplusplus
> -int yyparse (void *YYPARSE_PARAM);
> -#else
> -int yyparse ();
> -#endif
> -#else /* ! YYPARSE_PARAM */
> -#if defined __STDC__ || defined __cplusplus
> -int yyparse (void);
> -#else
> -int yyparse ();
> -#endif
> -#endif /* ! YYPARSE_PARAM */
> -
> -
> -
> -/* Copy the second part of user declarations.  */
> -
> -
> -
> -#ifdef short
> -# undef short
> -#endif
> -
> -#ifdef YYTYPE_UINT8
> -typedef YYTYPE_UINT8 yytype_uint8;
> -#else
> -typedef unsigned char yytype_uint8;
> -#endif
> -
> -#ifdef YYTYPE_INT8
> -typedef YYTYPE_INT8 yytype_int8;
> -#elif (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -typedef signed char yytype_int8;
> -#else
> -typedef short int yytype_int8;
> -#endif
> -
> -#ifdef YYTYPE_UINT16
> -typedef YYTYPE_UINT16 yytype_uint16;
> -#else
> -typedef unsigned short int yytype_uint16;
> -#endif
> -
> -#ifdef YYTYPE_INT16
> -typedef YYTYPE_INT16 yytype_int16;
> -#else
> -typedef short int yytype_int16;
> -#endif
> -
> -#ifndef YYSIZE_T
> -# ifdef __SIZE_TYPE__
> -#  define YYSIZE_T __SIZE_TYPE__
> -# elif defined size_t
> -#  define YYSIZE_T size_t
> -# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
> -#  define YYSIZE_T size_t
> -# else
> -#  define YYSIZE_T unsigned int
> -# endif
> -#endif
> -
> -#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)
> -
> -#ifndef YY_
> -# if defined YYENABLE_NLS && YYENABLE_NLS
> -#  if ENABLE_NLS
> -#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
> -#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
> -#  endif
> -# endif
> -# ifndef YY_
> -#  define YY_(Msgid) Msgid
> -# endif
> -#endif
> -
> -/* Suppress unused-variable warnings by "using" E.  */
> -#if ! defined lint || defined __GNUC__
> -# define YYUSE(E) ((void) (E))
> -#else
> -# define YYUSE(E) /* empty */
> -#endif
> -
> -/* Identity function, used to suppress warnings about constant conditions.  */
> -#ifndef lint
> -# define YYID(N) (N)
> -#else
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static int
> -YYID (int yyi)
> -#else
> -static int
> -YYID (yyi)
> -    int yyi;
> -#endif
> -{
> -  return yyi;
> -}
> -#endif
> -
> -#if ! defined yyoverflow || YYERROR_VERBOSE
> -
> -/* The parser invokes alloca or malloc; define the necessary symbols.  */
> -
> -# ifdef YYSTACK_USE_ALLOCA
> -#  if YYSTACK_USE_ALLOCA
> -#   ifdef __GNUC__
> -#    define YYSTACK_ALLOC __builtin_alloca
> -#   elif defined __BUILTIN_VA_ARG_INCR
> -#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
> -#   elif defined _AIX
> -#    define YYSTACK_ALLOC __alloca
> -#   elif defined _MSC_VER
> -#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
> -#    define alloca _alloca
> -#   else
> -#    define YYSTACK_ALLOC alloca
> -#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
> -      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
> -#     ifndef EXIT_SUCCESS
> -#      define EXIT_SUCCESS 0
> -#     endif
> -#    endif
> -#   endif
> -#  endif
> -# endif
> -
> -# ifdef YYSTACK_ALLOC
> -   /* Pacify GCC's `empty if-body' warning.  */
> -#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
> -#  ifndef YYSTACK_ALLOC_MAXIMUM
> -    /* The OS might guarantee only one guard page at the bottom of the stack,
> -       and a page size can be as small as 4096 bytes.  So we cannot safely
> -       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
> -       to allow for a few compiler-allocated temporary stack slots.  */
> -#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
> -#  endif
> -# else
> -#  define YYSTACK_ALLOC YYMALLOC
> -#  define YYSTACK_FREE YYFREE
> -#  ifndef YYSTACK_ALLOC_MAXIMUM
> -#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
> -#  endif
> -#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
> -       && ! ((defined YYMALLOC || defined malloc) \
> -	     && (defined YYFREE || defined free)))
> -#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
> -#   ifndef EXIT_SUCCESS
> -#    define EXIT_SUCCESS 0
> -#   endif
> -#  endif
> -#  ifndef YYMALLOC
> -#   define YYMALLOC malloc
> -#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
> -#   endif
> -#  endif
> -#  ifndef YYFREE
> -#   define YYFREE free
> -#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -void free (void *); /* INFRINGES ON USER NAME SPACE */
> -#   endif
> -#  endif
> -# endif
> -#endif /* ! defined yyoverflow || YYERROR_VERBOSE */
> -
> -
> -#if (! defined yyoverflow \
> -     && (! defined __cplusplus \
> -	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))
> -
> -/* A type that is properly aligned for any stack member.  */
> -union yyalloc
> -{
> -  yytype_int16 yyss_alloc;
> -  YYSTYPE yyvs_alloc;
> -};
> -
> -/* The size of the maximum gap between one aligned stack and the next.  */
> -# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)
> -
> -/* The size of an array large to enough to hold all stacks, each with
> -   N elements.  */
> -# define YYSTACK_BYTES(N) \
> -     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
> -      + YYSTACK_GAP_MAXIMUM)
> -
> -# define YYCOPY_NEEDED 1
> -
> -/* Relocate STACK from its old location to the new one.  The
> -   local variables YYSIZE and YYSTACKSIZE give the old and new number of
> -   elements in the stack, and YYPTR gives the new location of the
> -   stack.  Advance YYPTR to a properly aligned location for the next
> -   stack.  */
> -# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
> -    do									\
> -      {									\
> -	YYSIZE_T yynewbytes;						\
> -	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
> -	Stack = &yyptr->Stack_alloc;					\
> -	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
> -	yyptr += yynewbytes / sizeof (*yyptr);				\
> -      }									\
> -    while (YYID (0))
> -
> -#endif
> -
> -#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
> -/* Copy COUNT objects from SRC to DST.  The source and destination do
> -   not overlap.  */
> -# ifndef YYCOPY
> -#  if defined __GNUC__ && 1 < __GNUC__
> -#   define YYCOPY(Dst, Src, Count) \
> -      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
> -#  else
> -#   define YYCOPY(Dst, Src, Count)              \
> -      do                                        \
> -        {                                       \
> -          YYSIZE_T yyi;                         \
> -          for (yyi = 0; yyi < (Count); yyi++)   \
> -            (Dst)[yyi] = (Src)[yyi];            \
> -        }                                       \
> -      while (YYID (0))
> -#  endif
> -# endif
> -#endif /* !YYCOPY_NEEDED */
> -
> -/* YYFINAL -- State number of the termination state.  */
> -#define YYFINAL  4
> -/* YYLAST -- Last index in YYTABLE.  */
> -#define YYLAST   522
> -
> -/* YYNTOKENS -- Number of terminals.  */
> -#define YYNTOKENS  55
> -/* YYNNTS -- Number of nonterminals.  */
> -#define YYNNTS  49
> -/* YYNRULES -- Number of rules.  */
> -#define YYNRULES  133
> -/* YYNRULES -- Number of states.  */
> -#define YYNSTATES  187
> -
> -/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
> -#define YYUNDEFTOK  2
> -#define YYMAXUTOK   300
> -
> -#define YYTRANSLATE(YYX)						\
> -  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)
> -
> -/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
> -static const yytype_uint8 yytranslate[] =
> -{
> -       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -      49,    50,    51,     2,    48,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,    54,    46,
> -       2,    52,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,    53,     2,    47,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
> -       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
> -       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
> -      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
> -      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
> -      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
> -      45
> -};
> -
> -#if YYDEBUG
> -/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
> -   YYRHS.  */
> -static const yytype_uint16 yyprhs[] =
> -{
> -       0,     0,     3,     5,     8,     9,    12,    13,    18,    19,
> -      23,    25,    27,    29,    31,    34,    37,    41,    42,    44,
> -      46,    50,    55,    56,    58,    60,    63,    65,    67,    69,
> -      71,    73,    75,    77,    79,    81,    86,    88,    91,    94,
> -      97,   101,   105,   109,   112,   115,   118,   120,   122,   124,
> -     126,   128,   130,   132,   134,   136,   138,   140,   142,   145,
> -     146,   148,   150,   153,   155,   157,   159,   161,   164,   166,
> -     168,   170,   175,   180,   183,   187,   190,   192,   194,   196,
> -     201,   206,   209,   213,   217,   220,   222,   226,   227,   229,
> -     231,   235,   238,   241,   243,   244,   246,   248,   253,   258,
> -     261,   265,   269,   273,   274,   276,   279,   283,   287,   288,
> -     290,   292,   295,   299,   302,   303,   305,   307,   311,   314,
> -     317,   319,   322,   323,   326,   330,   335,   337,   341,   343,
> -     347,   350,   351,   353
> -};
> -
> -/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
> -static const yytype_int8 yyrhs[] =
> -{
> -      56,     0,    -1,    57,    -1,    56,    57,    -1,    -1,    58,
> -      59,    -1,    -1,    12,    23,    60,    62,    -1,    -1,    23,
> -      61,    62,    -1,    62,    -1,    86,    -1,   101,    -1,   103,
> -      -1,     1,    46,    -1,     1,    47,    -1,    66,    63,    46,
> -      -1,    -1,    64,    -1,    65,    -1,    64,    48,    65,    -1,
> -      76,   102,    97,    87,    -1,    -1,    67,    -1,    68,    -1,
> -      67,    68,    -1,    69,    -1,    70,    -1,     5,    -1,    17,
> -      -1,    21,    -1,    11,    -1,    14,    -1,    71,    -1,    75,
> -      -1,    28,    49,    83,    50,    -1,    33,    -1,    22,    39,
> -      -1,    24,    39,    -1,    10,    39,    -1,    22,    39,    89,
> -      -1,    24,    39,    89,    -1,    10,    39,    98,    -1,    10,
> -      98,    -1,    22,    89,    -1,    24,    89,    -1,     7,    -1,
> -      19,    -1,    15,    -1,    16,    -1,    20,    -1,    25,    -1,
> -      13,    -1,     9,    -1,    26,    -1,     6,    -1,    29,    -1,
> -      43,    -1,    51,    73,    -1,    -1,    74,    -1,    75,    -1,
> -      74,    75,    -1,     8,    -1,    27,    -1,    32,    -1,    18,
> -      -1,    72,    76,    -1,    77,    -1,    39,    -1,    43,    -1,
> -      77,    49,    80,    50,    -1,    77,    49,     1,    50,    -1,
> -      77,    35,    -1,    49,    76,    50,    -1,    72,    78,    -1,
> -      79,    -1,    39,    -1,    43,    -1,    79,    49,    80,    50,
> -      -1,    79,    49,     1,    50,    -1,    79,    35,    -1,    49,
> -      78,    50,    -1,    49,     1,    50,    -1,    81,    38,    -1,
> -      81,    -1,    82,    48,    38,    -1,    -1,    82,    -1,    83,
> -      -1,    82,    48,    83,    -1,    67,    84,    -1,    72,    84,
> -      -1,    85,    -1,    -1,    39,    -1,    43,    -1,    85,    49,
> -      80,    50,    -1,    85,    49,     1,    50,    -1,    85,    35,
> -      -1,    49,    84,    50,    -1,    49,     1,    50,    -1,    66,
> -      76,    34,    -1,    -1,    88,    -1,    52,    36,    -1,    53,
> -      90,    47,    -1,    53,     1,    47,    -1,    -1,    91,    -1,
> -      92,    -1,    91,    92,    -1,    66,    93,    46,    -1,     1,
> -      46,    -1,    -1,    94,    -1,    95,    -1,    94,    48,    95,
> -      -1,    78,    97,    -1,    39,    96,    -1,    96,    -1,    54,
> -      36,    -1,    -1,    97,    32,    -1,    53,    99,    47,    -1,
> -      53,    99,    48,    47,    -1,   100,    -1,    99,    48,   100,
> -      -1,    39,    -1,    39,    52,    36,    -1,    31,    46,    -1,
> -      -1,    31,    -1,    30,    49,    39,    50,    46,    -1
> -};
> -
> -/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
> -static const yytype_uint16 yyrline[] =
> -{
> -       0,   125,   125,   126,   130,   130,   136,   136,   138,   138,
> -     140,   141,   142,   143,   144,   145,   149,   163,   164,   168,
> -     176,   189,   195,   196,   200,   201,   205,   211,   215,   216,
> -     217,   218,   219,   223,   224,   225,   226,   230,   232,   234,
> -     238,   240,   242,   247,   250,   251,   255,   256,   257,   258,
> -     259,   260,   261,   262,   263,   264,   265,   266,   270,   275,
> -     276,   280,   281,   285,   285,   285,   286,   294,   295,   299,
> -     308,   317,   319,   321,   323,   330,   331,   335,   336,   337,
> -     339,   341,   343,   345,   350,   351,   352,   356,   357,   361,
> -     362,   367,   372,   374,   378,   379,   387,   391,   393,   395,
> -     397,   399,   404,   413,   414,   419,   424,   425,   429,   430,
> -     434,   435,   439,   441,   446,   447,   451,   452,   456,   457,
> -     458,   462,   466,   467,   471,   472,   476,   477,   480,   485,
> -     493,   497,   498,   502
> -};
> -#endif
> -
> -#if YYDEBUG || YYERROR_VERBOSE || 0
> -/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
> -   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
> -static const char *const yytname[] =
> -{
> -  "$end", "error", "$undefined", "ASM_KEYW", "ATTRIBUTE_KEYW",
> -  "AUTO_KEYW", "BOOL_KEYW", "CHAR_KEYW", "CONST_KEYW", "DOUBLE_KEYW",
> -  "ENUM_KEYW", "EXTERN_KEYW", "EXTENSION_KEYW", "FLOAT_KEYW",
> -  "INLINE_KEYW", "INT_KEYW", "LONG_KEYW", "REGISTER_KEYW", "RESTRICT_KEYW",
> -  "SHORT_KEYW", "SIGNED_KEYW", "STATIC_KEYW", "STRUCT_KEYW",
> -  "TYPEDEF_KEYW", "UNION_KEYW", "UNSIGNED_KEYW", "VOID_KEYW",
> -  "VOLATILE_KEYW", "TYPEOF_KEYW", "VA_LIST_KEYW", "EXPORT_SYMBOL_KEYW",
> -  "ASM_PHRASE", "ATTRIBUTE_PHRASE", "TYPEOF_PHRASE", "BRACE_PHRASE",
> -  "BRACKET_PHRASE", "EXPRESSION_PHRASE", "CHAR", "DOTS", "IDENT", "INT",
> -  "REAL", "STRING", "TYPE", "OTHER", "FILENAME", "';'", "'}'", "','",
> -  "'('", "')'", "'*'", "'='", "'{'", "':'", "$accept", "declaration_seq",
> -  "declaration", "$@1", "declaration1", "$@2", "$@3", "simple_declaration",
> -  "init_declarator_list_opt", "init_declarator_list", "init_declarator",
> -  "decl_specifier_seq_opt", "decl_specifier_seq", "decl_specifier",
> -  "storage_class_specifier", "type_specifier", "simple_type_specifier",
> -  "ptr_operator", "cvar_qualifier_seq_opt", "cvar_qualifier_seq",
> -  "cvar_qualifier", "declarator", "direct_declarator", "nested_declarator",
> -  "direct_nested_declarator", "parameter_declaration_clause",
> -  "parameter_declaration_list_opt", "parameter_declaration_list",
> -  "parameter_declaration", "m_abstract_declarator",
> -  "direct_m_abstract_declarator", "function_definition", "initializer_opt",
> -  "initializer", "class_body", "member_specification_opt",
> -  "member_specification", "member_declaration",
> -  "member_declarator_list_opt", "member_declarator_list",
> -  "member_declarator", "member_bitfield_declarator", "attribute_opt",
> -  "enum_body", "enumerator_list", "enumerator", "asm_definition",
> -  "asm_phrase_opt", "export_definition", YY_NULL
> -};
> -#endif
> -
> -# ifdef YYPRINT
> -/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
> -   token YYLEX-NUM.  */
> -static const yytype_uint16 yytoknum[] =
> -{
> -       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
> -     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
> -     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
> -     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
> -     295,   296,   297,   298,   299,   300,    59,   125,    44,    40,
> -      41,    42,    61,   123,    58
> -};
> -# endif
> -
> -/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
> -static const yytype_uint8 yyr1[] =
> -{
> -       0,    55,    56,    56,    58,    57,    60,    59,    61,    59,
> -      59,    59,    59,    59,    59,    59,    62,    63,    63,    64,
> -      64,    65,    66,    66,    67,    67,    68,    68,    69,    69,
> -      69,    69,    69,    70,    70,    70,    70,    70,    70,    70,
> -      70,    70,    70,    70,    70,    70,    71,    71,    71,    71,
> -      71,    71,    71,    71,    71,    71,    71,    71,    72,    73,
> -      73,    74,    74,    75,    75,    75,    75,    76,    76,    77,
> -      77,    77,    77,    77,    77,    78,    78,    79,    79,    79,
> -      79,    79,    79,    79,    80,    80,    80,    81,    81,    82,
> -      82,    83,    84,    84,    85,    85,    85,    85,    85,    85,
> -      85,    85,    86,    87,    87,    88,    89,    89,    90,    90,
> -      91,    91,    92,    92,    93,    93,    94,    94,    95,    95,
> -      95,    96,    97,    97,    98,    98,    99,    99,   100,   100,
> -     101,   102,   102,   103
> -};
> -
> -/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
> -static const yytype_uint8 yyr2[] =
> -{
> -       0,     2,     1,     2,     0,     2,     0,     4,     0,     3,
> -       1,     1,     1,     1,     2,     2,     3,     0,     1,     1,
> -       3,     4,     0,     1,     1,     2,     1,     1,     1,     1,
> -       1,     1,     1,     1,     1,     4,     1,     2,     2,     2,
> -       3,     3,     3,     2,     2,     2,     1,     1,     1,     1,
> -       1,     1,     1,     1,     1,     1,     1,     1,     2,     0,
> -       1,     1,     2,     1,     1,     1,     1,     2,     1,     1,
> -       1,     4,     4,     2,     3,     2,     1,     1,     1,     4,
> -       4,     2,     3,     3,     2,     1,     3,     0,     1,     1,
> -       3,     2,     2,     1,     0,     1,     1,     4,     4,     2,
> -       3,     3,     3,     0,     1,     2,     3,     3,     0,     1,
> -       1,     2,     3,     2,     0,     1,     1,     3,     2,     2,
> -       1,     2,     0,     2,     3,     4,     1,     3,     1,     3,
> -       2,     0,     1,     5
> -};
> -
> -/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
> -   Performed when YYTABLE doesn't specify something else to do.  Zero
> -   means the default is an error.  */
> -static const yytype_uint8 yydefact[] =
> -{
> -       4,     4,     2,     0,     1,     3,     0,    28,    55,    46,
> -      63,    53,     0,    31,     0,    52,    32,    48,    49,    29,
> -      66,    47,    50,    30,     0,     8,     0,    51,    54,    64,
> -       0,    56,     0,     0,    65,    36,    57,     5,    10,    17,
> -      23,    24,    26,    27,    33,    34,    11,    12,    13,    14,
> -      15,    39,     0,    43,     6,    37,     0,    44,    22,    38,
> -      45,     0,     0,   130,    69,    70,     0,    59,     0,    18,
> -      19,     0,   131,    68,    25,    42,   128,     0,   126,    22,
> -      40,     0,   114,     0,     0,   110,     9,    17,    41,    94,
> -       0,     0,     0,    58,    60,    61,    16,     0,    67,   132,
> -     102,   122,    73,     0,     0,   124,     0,     7,   113,   107,
> -      77,    78,     0,     0,     0,   122,    76,     0,   115,   116,
> -     120,   106,     0,   111,   131,    95,    57,     0,    94,    91,
> -      93,    35,     0,    74,    62,    20,   103,     0,     0,    85,
> -      88,    89,   129,   125,   127,   119,     0,    77,     0,   121,
> -      75,   118,    81,     0,   112,     0,     0,    96,     0,    92,
> -      99,     0,   133,   123,     0,    21,   104,    72,    71,    84,
> -       0,    83,    82,     0,     0,   117,   101,   100,     0,     0,
> -     105,    86,    90,    80,    79,    98,    97
> -};
> -
> -/* YYDEFGOTO[NTERM-NUM].  */
> -static const yytype_int16 yydefgoto[] =
> -{
> -      -1,     1,     2,     3,    37,    79,    58,    38,    68,    69,
> -      70,    82,    40,    41,    42,    43,    44,    71,    93,    94,
> -      45,   124,    73,   115,   116,   138,   139,   140,   141,   129,
> -     130,    46,   165,   166,    57,    83,    84,    85,   117,   118,
> -     119,   120,   136,    53,    77,    78,    47,   101,    48
> -};
> -
> -/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
> -   STATE-NUM.  */
> -#define YYPACT_NINF -94
> -static const yytype_int16 yypact[] =
> -{
> -     -94,    15,   -94,   208,   -94,   -94,    34,   -94,   -94,   -94,
> -     -94,   -94,   -27,   -94,    -5,   -94,   -94,   -94,   -94,   -94,
> -     -94,   -94,   -94,   -94,   -25,   -94,   -16,   -94,   -94,   -94,
> -      -4,   -94,    19,   -24,   -94,   -94,   -94,   -94,   -94,    24,
> -     479,   -94,   -94,   -94,   -94,   -94,   -94,   -94,   -94,   -94,
> -     -94,    29,    48,   -94,   -94,    37,   106,   -94,   479,    37,
> -     -94,   479,    54,   -94,   -94,   -94,    24,    -2,    49,    53,
> -     -94,    24,   -14,   -11,   -94,   -94,    47,    38,   -94,   479,
> -     -94,    51,    23,    55,   157,   -94,   -94,    24,   -94,   393,
> -      56,    58,    68,   -94,    -2,   -94,   -94,    24,   -94,   -94,
> -     -94,   -94,   -94,   255,    67,   -94,     5,   -94,   -94,   -94,
> -      50,   -94,     7,    69,    40,   -94,    -8,    83,    88,   -94,
> -     -94,   -94,    91,   -94,   109,   -94,   -94,     4,    45,   -94,
> -      16,   -94,    95,   -94,   -94,   -94,   -23,    92,    93,   108,
> -      96,   -94,   -94,   -94,   -94,   -94,    97,   -94,    98,   -94,
> -     -94,   118,   -94,   301,   -94,    23,   101,   -94,   104,   -94,
> -     -94,   347,   -94,   -94,   120,   -94,   -94,   -94,   -94,   -94,
> -     440,   -94,   -94,   111,   119,   -94,   -94,   -94,   130,   137,
> -     -94,   -94,   -94,   -94,   -94,   -94,   -94
> -};
> -
> -/* YYPGOTO[NTERM-NUM].  */
> -static const yytype_int16 yypgoto[] =
> -{
> -     -94,   -94,   158,   -94,   -94,   -94,   -94,   -45,   -94,   -94,
> -      94,    -1,   -61,   -29,   -94,   -94,   -94,   -79,   -94,   -94,
> -     -63,    -7,   -94,   -93,   -94,   -92,   -94,   -94,   -60,   -57,
> -     -94,   -94,   -94,   -94,   -19,   -94,   -94,   110,   -94,   -94,
> -      33,    82,    78,   144,   -94,    99,   -94,   -94,   -94
> -};
> -
> -/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
> -   positive, shift that token.  If negative, reduce the rule which
> -   number is the opposite.  If YYTABLE_NINF, syntax error.  */
> -#define YYTABLE_NINF -110
> -static const yytype_int16 yytable[] =
> -{
> -      89,    90,    39,   114,    95,   156,    10,    60,   146,   163,
> -     128,    74,    51,    86,    55,     4,    20,    99,    54,   148,
> -     100,   150,    63,    59,   102,    29,    52,   152,    56,   164,
> -      34,   134,    72,   114,   107,   114,    80,    56,   103,   -94,
> -      88,   153,    89,   125,    76,    61,   147,   157,   128,   128,
> -     111,   160,   143,   127,   -94,    67,   112,    87,    67,    92,
> -      74,   174,   110,    64,    98,   161,   111,    65,    62,   179,
> -     158,   159,   112,    66,    67,    67,   114,   113,    87,   147,
> -      49,    50,    52,   111,   125,   105,   106,    76,   157,   112,
> -      56,    67,    89,    91,   127,    96,    67,   108,   109,   104,
> -      89,    97,   121,   142,   113,   149,   131,    81,   132,    89,
> -     182,     7,     8,     9,    10,    11,    12,    13,   133,    15,
> -      16,    17,    18,    19,    20,    21,    22,    23,    24,   154,
> -      26,    27,    28,    29,    30,    31,   155,   108,    34,    35,
> -      99,   162,   167,   168,   170,   -22,   169,   171,   172,    36,
> -     163,   176,   -22,  -108,   177,   -22,   180,   -22,   122,     5,
> -     -22,   183,     7,     8,     9,    10,    11,    12,    13,   184,
> -      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
> -     185,    26,    27,    28,    29,    30,    31,   186,   175,    34,
> -      35,   135,   145,   151,   123,    75,   -22,     0,     0,     0,
> -      36,     0,     0,   -22,  -109,   144,   -22,     0,   -22,     6,
> -       0,   -22,     0,     7,     8,     9,    10,    11,    12,    13,
> -      14,    15,    16,    17,    18,    19,    20,    21,    22,    23,
> -      24,    25,    26,    27,    28,    29,    30,    31,    32,    33,
> -      34,    35,     0,     0,     0,     0,     0,   -22,     0,     0,
> -       0,    36,     0,     0,   -22,     0,   137,   -22,     0,   -22,
> -       7,     8,     9,    10,    11,    12,    13,     0,    15,    16,
> -      17,    18,    19,    20,    21,    22,    23,    24,     0,    26,
> -      27,    28,    29,    30,    31,     0,     0,    34,    35,     0,
> -       0,     0,     0,   -87,     0,     0,     0,     0,    36,     0,
> -       0,     0,   173,     0,     0,   -87,     7,     8,     9,    10,
> -      11,    12,    13,     0,    15,    16,    17,    18,    19,    20,
> -      21,    22,    23,    24,     0,    26,    27,    28,    29,    30,
> -      31,     0,     0,    34,    35,     0,     0,     0,     0,   -87,
> -       0,     0,     0,     0,    36,     0,     0,     0,   178,     0,
> -       0,   -87,     7,     8,     9,    10,    11,    12,    13,     0,
> -      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
> -       0,    26,    27,    28,    29,    30,    31,     0,     0,    34,
> -      35,     0,     0,     0,     0,   -87,     0,     0,     0,     0,
> -      36,     0,     0,     0,     0,     0,     0,   -87,     7,     8,
> -       9,    10,    11,    12,    13,     0,    15,    16,    17,    18,
> -      19,    20,    21,    22,    23,    24,     0,    26,    27,    28,
> -      29,    30,    31,     0,     0,    34,    35,     0,     0,     0,
> -       0,     0,   125,     0,     0,     0,   126,     0,     0,     0,
> -       0,     0,   127,     0,    67,     7,     8,     9,    10,    11,
> -      12,    13,     0,    15,    16,    17,    18,    19,    20,    21,
> -      22,    23,    24,     0,    26,    27,    28,    29,    30,    31,
> -       0,     0,    34,    35,     0,     0,     0,     0,   181,     0,
> -       0,     0,     0,    36,     7,     8,     9,    10,    11,    12,
> -      13,     0,    15,    16,    17,    18,    19,    20,    21,    22,
> -      23,    24,     0,    26,    27,    28,    29,    30,    31,     0,
> -       0,    34,    35,     0,     0,     0,     0,     0,     0,     0,
> -       0,     0,    36
> -};
> -
> -#define yypact_value_is_default(Yystate) \
> -  (!!((Yystate) == (-94)))
> -
> -#define yytable_value_is_error(Yytable_value) \
> -  YYID (0)
> -
> -static const yytype_int16 yycheck[] =
> -{
> -      61,    61,     3,    82,    67,     1,     8,    26,     1,    32,
> -      89,    40,    39,    58,    39,     0,    18,    31,    23,   112,
> -      34,   114,    46,    39,    35,    27,    53,    35,    53,    52,
> -      32,    94,    39,   112,    79,   114,    55,    53,    49,    35,
> -      59,    49,   103,    39,    39,    49,    39,    43,   127,   128,
> -      43,    35,    47,    49,    50,    51,    49,    58,    51,    66,
> -      89,   153,    39,    39,    71,    49,    43,    43,    49,   161,
> -     127,   128,    49,    49,    51,    51,   155,    54,    79,    39,
> -      46,    47,    53,    43,    39,    47,    48,    39,    43,    49,
> -      53,    51,   153,    39,    49,    46,    51,    46,    47,    52,
> -     161,    48,    47,    36,    54,    36,    50,     1,    50,   170,
> -     170,     5,     6,     7,     8,     9,    10,    11,    50,    13,
> -      14,    15,    16,    17,    18,    19,    20,    21,    22,    46,
> -      24,    25,    26,    27,    28,    29,    48,    46,    32,    33,
> -      31,    46,    50,    50,    48,    39,    38,    50,    50,    43,
> -      32,    50,    46,    47,    50,    49,    36,    51,     1,     1,
> -      54,    50,     5,     6,     7,     8,     9,    10,    11,    50,
> -      13,    14,    15,    16,    17,    18,    19,    20,    21,    22,
> -      50,    24,    25,    26,    27,    28,    29,    50,   155,    32,
> -      33,    97,   110,   115,    84,    51,    39,    -1,    -1,    -1,
> -      43,    -1,    -1,    46,    47,   106,    49,    -1,    51,     1,
> -      -1,    54,    -1,     5,     6,     7,     8,     9,    10,    11,
> -      12,    13,    14,    15,    16,    17,    18,    19,    20,    21,
> -      22,    23,    24,    25,    26,    27,    28,    29,    30,    31,
> -      32,    33,    -1,    -1,    -1,    -1,    -1,    39,    -1,    -1,
> -      -1,    43,    -1,    -1,    46,    -1,     1,    49,    -1,    51,
> -       5,     6,     7,     8,     9,    10,    11,    -1,    13,    14,
> -      15,    16,    17,    18,    19,    20,    21,    22,    -1,    24,
> -      25,    26,    27,    28,    29,    -1,    -1,    32,    33,    -1,
> -      -1,    -1,    -1,    38,    -1,    -1,    -1,    -1,    43,    -1,
> -      -1,    -1,     1,    -1,    -1,    50,     5,     6,     7,     8,
> -       9,    10,    11,    -1,    13,    14,    15,    16,    17,    18,
> -      19,    20,    21,    22,    -1,    24,    25,    26,    27,    28,
> -      29,    -1,    -1,    32,    33,    -1,    -1,    -1,    -1,    38,
> -      -1,    -1,    -1,    -1,    43,    -1,    -1,    -1,     1,    -1,
> -      -1,    50,     5,     6,     7,     8,     9,    10,    11,    -1,
> -      13,    14,    15,    16,    17,    18,    19,    20,    21,    22,
> -      -1,    24,    25,    26,    27,    28,    29,    -1,    -1,    32,
> -      33,    -1,    -1,    -1,    -1,    38,    -1,    -1,    -1,    -1,
> -      43,    -1,    -1,    -1,    -1,    -1,    -1,    50,     5,     6,
> -       7,     8,     9,    10,    11,    -1,    13,    14,    15,    16,
> -      17,    18,    19,    20,    21,    22,    -1,    24,    25,    26,
> -      27,    28,    29,    -1,    -1,    32,    33,    -1,    -1,    -1,
> -      -1,    -1,    39,    -1,    -1,    -1,    43,    -1,    -1,    -1,
> -      -1,    -1,    49,    -1,    51,     5,     6,     7,     8,     9,
> -      10,    11,    -1,    13,    14,    15,    16,    17,    18,    19,
> -      20,    21,    22,    -1,    24,    25,    26,    27,    28,    29,
> -      -1,    -1,    32,    33,    -1,    -1,    -1,    -1,    38,    -1,
> -      -1,    -1,    -1,    43,     5,     6,     7,     8,     9,    10,
> -      11,    -1,    13,    14,    15,    16,    17,    18,    19,    20,
> -      21,    22,    -1,    24,    25,    26,    27,    28,    29,    -1,
> -      -1,    32,    33,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
> -      -1,    -1,    43
> -};
> -
> -/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
> -   symbol of state STATE-NUM.  */
> -static const yytype_uint8 yystos[] =
> -{
> -       0,    56,    57,    58,     0,    57,     1,     5,     6,     7,
> -       8,     9,    10,    11,    12,    13,    14,    15,    16,    17,
> -      18,    19,    20,    21,    22,    23,    24,    25,    26,    27,
> -      28,    29,    30,    31,    32,    33,    43,    59,    62,    66,
> -      67,    68,    69,    70,    71,    75,    86,   101,   103,    46,
> -      47,    39,    53,    98,    23,    39,    53,    89,    61,    39,
> -      89,    49,    49,    46,    39,    43,    49,    51,    63,    64,
> -      65,    72,    76,    77,    68,    98,    39,    99,   100,    60,
> -      89,     1,    66,    90,    91,    92,    62,    66,    89,    67,
> -      83,    39,    76,    73,    74,    75,    46,    48,    76,    31,
> -      34,   102,    35,    49,    52,    47,    48,    62,    46,    47,
> -      39,    43,    49,    54,    72,    78,    79,    93,    94,    95,
> -      96,    47,     1,    92,    76,    39,    43,    49,    72,    84,
> -      85,    50,    50,    50,    75,    65,    97,     1,    80,    81,
> -      82,    83,    36,    47,   100,    96,     1,    39,    78,    36,
> -      78,    97,    35,    49,    46,    48,     1,    43,    84,    84,
> -      35,    49,    46,    32,    52,    87,    88,    50,    50,    38,
> -      48,    50,    50,     1,    80,    95,    50,    50,     1,    80,
> -      36,    38,    83,    50,    50,    50,    50
> -};
> -
> -#define yyerrok		(yyerrstatus = 0)
> -#define yyclearin	(yychar = YYEMPTY)
> -#define YYEMPTY		(-2)
> -#define YYEOF		0
> -
> -#define YYACCEPT	goto yyacceptlab
> -#define YYABORT		goto yyabortlab
> -#define YYERROR		goto yyerrorlab
> -
> -
> -/* Like YYERROR except do call yyerror.  This remains here temporarily
> -   to ease the transition to the new meaning of YYERROR, for GCC.
> -   Once GCC version 2 has supplanted version 1, this can go.  However,
> -   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
> -   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
> -   discussed.  */
> -
> -#define YYFAIL		goto yyerrlab
> -#if defined YYFAIL
> -  /* This is here to suppress warnings from the GCC cpp's
> -     -Wunused-macros.  Normally we don't worry about that warning, but
> -     some users do, and we want to make it easy for users to remove
> -     YYFAIL uses, which will produce warnings from Bison 2.5.  */
> -#endif
> -
> -#define YYRECOVERING()  (!!yyerrstatus)
> -
> -#define YYBACKUP(Token, Value)                                  \
> -do                                                              \
> -  if (yychar == YYEMPTY)                                        \
> -    {                                                           \
> -      yychar = (Token);                                         \
> -      yylval = (Value);                                         \
> -      YYPOPSTACK (yylen);                                       \
> -      yystate = *yyssp;                                         \
> -      goto yybackup;                                            \
> -    }                                                           \
> -  else                                                          \
> -    {                                                           \
> -      yyerror (YY_("syntax error: cannot back up")); \
> -      YYERROR;							\
> -    }								\
> -while (YYID (0))
> -
> -/* Error token number */
> -#define YYTERROR	1
> -#define YYERRCODE	256
> -
> -
> -/* This macro is provided for backward compatibility. */
> -#ifndef YY_LOCATION_PRINT
> -# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
> -#endif
> -
> -
> -/* YYLEX -- calling `yylex' with the right arguments.  */
> -#ifdef YYLEX_PARAM
> -# define YYLEX yylex (YYLEX_PARAM)
> -#else
> -# define YYLEX yylex ()
> -#endif
> -
> -/* Enable debugging if requested.  */
> -#if YYDEBUG
> -
> -# ifndef YYFPRINTF
> -#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
> -#  define YYFPRINTF fprintf
> -# endif
> -
> -# define YYDPRINTF(Args)			\
> -do {						\
> -  if (yydebug)					\
> -    YYFPRINTF Args;				\
> -} while (YYID (0))
> -
> -# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
> -do {									  \
> -  if (yydebug)								  \
> -    {									  \
> -      YYFPRINTF (stderr, "%s ", Title);					  \
> -      yy_symbol_print (stderr,						  \
> -		  Type, Value); \
> -      YYFPRINTF (stderr, "\n");						  \
> -    }									  \
> -} while (YYID (0))
> -
> -
> -/*--------------------------------.
> -| Print this symbol on YYOUTPUT.  |
> -`--------------------------------*/
> -
> -/*ARGSUSED*/
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static void
> -yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
> -#else
> -static void
> -yy_symbol_value_print (yyoutput, yytype, yyvaluep)
> -    FILE *yyoutput;
> -    int yytype;
> -    YYSTYPE const * const yyvaluep;
> -#endif
> -{
> -  FILE *yyo = yyoutput;
> -  YYUSE (yyo);
> -  if (!yyvaluep)
> -    return;
> -# ifdef YYPRINT
> -  if (yytype < YYNTOKENS)
> -    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
> -# else
> -  YYUSE (yyoutput);
> -# endif
> -  switch (yytype)
> -    {
> -      default:
> -        break;
> -    }
> -}
> -
> -
> -/*--------------------------------.
> -| Print this symbol on YYOUTPUT.  |
> -`--------------------------------*/
> -
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static void
> -yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
> -#else
> -static void
> -yy_symbol_print (yyoutput, yytype, yyvaluep)
> -    FILE *yyoutput;
> -    int yytype;
> -    YYSTYPE const * const yyvaluep;
> -#endif
> -{
> -  if (yytype < YYNTOKENS)
> -    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
> -  else
> -    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);
> -
> -  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
> -  YYFPRINTF (yyoutput, ")");
> -}
> -
> -/*------------------------------------------------------------------.
> -| yy_stack_print -- Print the state stack from its BOTTOM up to its |
> -| TOP (included).                                                   |
> -`------------------------------------------------------------------*/
> -
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static void
> -yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
> -#else
> -static void
> -yy_stack_print (yybottom, yytop)
> -    yytype_int16 *yybottom;
> -    yytype_int16 *yytop;
> -#endif
> -{
> -  YYFPRINTF (stderr, "Stack now");
> -  for (; yybottom <= yytop; yybottom++)
> -    {
> -      int yybot = *yybottom;
> -      YYFPRINTF (stderr, " %d", yybot);
> -    }
> -  YYFPRINTF (stderr, "\n");
> -}
> -
> -# define YY_STACK_PRINT(Bottom, Top)				\
> -do {								\
> -  if (yydebug)							\
> -    yy_stack_print ((Bottom), (Top));				\
> -} while (YYID (0))
> -
> -
> -/*------------------------------------------------.
> -| Report that the YYRULE is going to be reduced.  |
> -`------------------------------------------------*/
> -
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static void
> -yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
> -#else
> -static void
> -yy_reduce_print (yyvsp, yyrule)
> -    YYSTYPE *yyvsp;
> -    int yyrule;
> -#endif
> -{
> -  int yynrhs = yyr2[yyrule];
> -  int yyi;
> -  unsigned long int yylno = yyrline[yyrule];
> -  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
> -	     yyrule - 1, yylno);
> -  /* The symbols being reduced.  */
> -  for (yyi = 0; yyi < yynrhs; yyi++)
> -    {
> -      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
> -      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
> -		       &(yyvsp[(yyi + 1) - (yynrhs)])
> -		       		       );
> -      YYFPRINTF (stderr, "\n");
> -    }
> -}
> -
> -# define YY_REDUCE_PRINT(Rule)		\
> -do {					\
> -  if (yydebug)				\
> -    yy_reduce_print (yyvsp, Rule); \
> -} while (YYID (0))
> -
> -/* Nonzero means print parse trace.  It is left uninitialized so that
> -   multiple parsers can coexist.  */
> -int yydebug;
> -#else /* !YYDEBUG */
> -# define YYDPRINTF(Args)
> -# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
> -# define YY_STACK_PRINT(Bottom, Top)
> -# define YY_REDUCE_PRINT(Rule)
> -#endif /* !YYDEBUG */
> -
> -
> -/* YYINITDEPTH -- initial size of the parser's stacks.  */
> -#ifndef	YYINITDEPTH
> -# define YYINITDEPTH 200
> -#endif
> -
> -/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
> -   if the built-in stack extension method is used).
> -
> -   Do not make this value too large; the results are undefined if
> -   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
> -   evaluated with infinite-precision integer arithmetic.  */
> -
> -#ifndef YYMAXDEPTH
> -# define YYMAXDEPTH 10000
> -#endif
> -
> -
> -#if YYERROR_VERBOSE
> -
> -# ifndef yystrlen
> -#  if defined __GLIBC__ && defined _STRING_H
> -#   define yystrlen strlen
> -#  else
> -/* Return the length of YYSTR.  */
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static YYSIZE_T
> -yystrlen (const char *yystr)
> -#else
> -static YYSIZE_T
> -yystrlen (yystr)
> -    const char *yystr;
> -#endif
> -{
> -  YYSIZE_T yylen;
> -  for (yylen = 0; yystr[yylen]; yylen++)
> -    continue;
> -  return yylen;
> -}
> -#  endif
> -# endif
> -
> -# ifndef yystpcpy
> -#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
> -#   define yystpcpy stpcpy
> -#  else
> -/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
> -   YYDEST.  */
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static char *
> -yystpcpy (char *yydest, const char *yysrc)
> -#else
> -static char *
> -yystpcpy (yydest, yysrc)
> -    char *yydest;
> -    const char *yysrc;
> -#endif
> -{
> -  char *yyd = yydest;
> -  const char *yys = yysrc;
> -
> -  while ((*yyd++ = *yys++) != '\0')
> -    continue;
> -
> -  return yyd - 1;
> -}
> -#  endif
> -# endif
> -
> -# ifndef yytnamerr
> -/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
> -   quotes and backslashes, so that it's suitable for yyerror.  The
> -   heuristic is that double-quoting is unnecessary unless the string
> -   contains an apostrophe, a comma, or backslash (other than
> -   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
> -   null, do not copy; instead, return the length of what the result
> -   would have been.  */
> -static YYSIZE_T
> -yytnamerr (char *yyres, const char *yystr)
> -{
> -  if (*yystr == '"')
> -    {
> -      YYSIZE_T yyn = 0;
> -      char const *yyp = yystr;
> -
> -      for (;;)
> -	switch (*++yyp)
> -	  {
> -	  case '\'':
> -	  case ',':
> -	    goto do_not_strip_quotes;
> -
> -	  case '\\':
> -	    if (*++yyp != '\\')
> -	      goto do_not_strip_quotes;
> -	    /* Fall through.  */
> -	  default:
> -	    if (yyres)
> -	      yyres[yyn] = *yyp;
> -	    yyn++;
> -	    break;
> -
> -	  case '"':
> -	    if (yyres)
> -	      yyres[yyn] = '\0';
> -	    return yyn;
> -	  }
> -    do_not_strip_quotes: ;
> -    }
> -
> -  if (! yyres)
> -    return yystrlen (yystr);
> -
> -  return yystpcpy (yyres, yystr) - yyres;
> -}
> -# endif
> -
> -/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
> -   about the unexpected token YYTOKEN for the state stack whose top is
> -   YYSSP.
> -
> -   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
> -   not large enough to hold the message.  In that case, also set
> -   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
> -   required number of bytes is too large to store.  */
> -static int
> -yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
> -                yytype_int16 *yyssp, int yytoken)
> -{
> -  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
> -  YYSIZE_T yysize = yysize0;
> -  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
> -  /* Internationalized format string. */
> -  const char *yyformat = YY_NULL;
> -  /* Arguments of yyformat. */
> -  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
> -  /* Number of reported tokens (one for the "unexpected", one per
> -     "expected"). */
> -  int yycount = 0;
> -
> -  /* There are many possibilities here to consider:
> -     - Assume YYFAIL is not used.  It's too flawed to consider.  See
> -       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
> -       for details.  YYERROR is fine as it does not invoke this
> -       function.
> -     - If this state is a consistent state with a default action, then
> -       the only way this function was invoked is if the default action
> -       is an error action.  In that case, don't check for expected
> -       tokens because there are none.
> -     - The only way there can be no lookahead present (in yychar) is if
> -       this state is a consistent state with a default action.  Thus,
> -       detecting the absence of a lookahead is sufficient to determine
> -       that there is no unexpected or expected token to report.  In that
> -       case, just report a simple "syntax error".
> -     - Don't assume there isn't a lookahead just because this state is a
> -       consistent state with a default action.  There might have been a
> -       previous inconsistent state, consistent state with a non-default
> -       action, or user semantic action that manipulated yychar.
> -     - Of course, the expected token list depends on states to have
> -       correct lookahead information, and it depends on the parser not
> -       to perform extra reductions after fetching a lookahead from the
> -       scanner and before detecting a syntax error.  Thus, state merging
> -       (from LALR or IELR) and default reductions corrupt the expected
> -       token list.  However, the list is correct for canonical LR with
> -       one exception: it will still contain any token that will not be
> -       accepted due to an error action in a later state.
> -  */
> -  if (yytoken != YYEMPTY)
> -    {
> -      int yyn = yypact[*yyssp];
> -      yyarg[yycount++] = yytname[yytoken];
> -      if (!yypact_value_is_default (yyn))
> -        {
> -          /* Start YYX at -YYN if negative to avoid negative indexes in
> -             YYCHECK.  In other words, skip the first -YYN actions for
> -             this state because they are default actions.  */
> -          int yyxbegin = yyn < 0 ? -yyn : 0;
> -          /* Stay within bounds of both yycheck and yytname.  */
> -          int yychecklim = YYLAST - yyn + 1;
> -          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
> -          int yyx;
> -
> -          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
> -            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
> -                && !yytable_value_is_error (yytable[yyx + yyn]))
> -              {
> -                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
> -                  {
> -                    yycount = 1;
> -                    yysize = yysize0;
> -                    break;
> -                  }
> -                yyarg[yycount++] = yytname[yyx];
> -                {
> -                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
> -                  if (! (yysize <= yysize1
> -                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
> -                    return 2;
> -                  yysize = yysize1;
> -                }
> -              }
> -        }
> -    }
> -
> -  switch (yycount)
> -    {
> -# define YYCASE_(N, S)                      \
> -      case N:                               \
> -        yyformat = S;                       \
> -      break
> -      YYCASE_(0, YY_("syntax error"));
> -      YYCASE_(1, YY_("syntax error, unexpected %s"));
> -      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
> -      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
> -      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
> -      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
> -# undef YYCASE_
> -    }
> -
> -  {
> -    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
> -    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
> -      return 2;
> -    yysize = yysize1;
> -  }
> -
> -  if (*yymsg_alloc < yysize)
> -    {
> -      *yymsg_alloc = 2 * yysize;
> -      if (! (yysize <= *yymsg_alloc
> -             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
> -        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
> -      return 1;
> -    }
> -
> -  /* Avoid sprintf, as that infringes on the user's name space.
> -     Don't have undefined behavior even if the translation
> -     produced a string with the wrong number of "%s"s.  */
> -  {
> -    char *yyp = *yymsg;
> -    int yyi = 0;
> -    while ((*yyp = *yyformat) != '\0')
> -      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
> -        {
> -          yyp += yytnamerr (yyp, yyarg[yyi++]);
> -          yyformat += 2;
> -        }
> -      else
> -        {
> -          yyp++;
> -          yyformat++;
> -        }
> -  }
> -  return 0;
> -}
> -#endif /* YYERROR_VERBOSE */
> -
> -/*-----------------------------------------------.
> -| Release the memory associated to this symbol.  |
> -`-----------------------------------------------*/
> -
> -/*ARGSUSED*/
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -static void
> -yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
> -#else
> -static void
> -yydestruct (yymsg, yytype, yyvaluep)
> -    const char *yymsg;
> -    int yytype;
> -    YYSTYPE *yyvaluep;
> -#endif
> -{
> -  YYUSE (yyvaluep);
> -
> -  if (!yymsg)
> -    yymsg = "Deleting";
> -  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);
> -
> -  switch (yytype)
> -    {
> -
> -      default:
> -        break;
> -    }
> -}
> -
> -
> -
> -
> -/* The lookahead symbol.  */
> -int yychar;
> -
> -
> -#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -# define YY_IGNORE_MAYBE_UNINITIALIZED_END
> -#endif
> -#ifndef YY_INITIAL_VALUE
> -# define YY_INITIAL_VALUE(Value) /* Nothing. */
> -#endif
> -
> -/* The semantic value of the lookahead symbol.  */
> -YYSTYPE yylval YY_INITIAL_VALUE(yyval_default);
> -
> -/* Number of syntax errors so far.  */
> -int yynerrs;
> -
> -
> -/*----------.
> -| yyparse.  |
> -`----------*/
> -
> -#ifdef YYPARSE_PARAM
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -int
> -yyparse (void *YYPARSE_PARAM)
> -#else
> -int
> -yyparse (YYPARSE_PARAM)
> -    void *YYPARSE_PARAM;
> -#endif
> -#else /* ! YYPARSE_PARAM */
> -#if (defined __STDC__ || defined __C99__FUNC__ \
> -     || defined __cplusplus || defined _MSC_VER)
> -int
> -yyparse (void)
> -#else
> -int
> -yyparse ()
> -
> -#endif
> -#endif
> -{
> -    int yystate;
> -    /* Number of tokens to shift before error messages enabled.  */
> -    int yyerrstatus;
> -
> -    /* The stacks and their tools:
> -       `yyss': related to states.
> -       `yyvs': related to semantic values.
> -
> -       Refer to the stacks through separate pointers, to allow yyoverflow
> -       to reallocate them elsewhere.  */
> -
> -    /* The state stack.  */
> -    yytype_int16 yyssa[YYINITDEPTH];
> -    yytype_int16 *yyss;
> -    yytype_int16 *yyssp;
> -
> -    /* The semantic value stack.  */
> -    YYSTYPE yyvsa[YYINITDEPTH];
> -    YYSTYPE *yyvs;
> -    YYSTYPE *yyvsp;
> -
> -    YYSIZE_T yystacksize;
> -
> -  int yyn;
> -  int yyresult;
> -  /* Lookahead token as an internal (translated) token number.  */
> -  int yytoken = 0;
> -  /* The variables used to return semantic value and location from the
> -     action routines.  */
> -  YYSTYPE yyval;
> -
> -#if YYERROR_VERBOSE
> -  /* Buffer for error messages, and its allocated size.  */
> -  char yymsgbuf[128];
> -  char *yymsg = yymsgbuf;
> -  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
> -#endif
> -
> -#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))
> -
> -  /* The number of symbols on the RHS of the reduced rule.
> -     Keep to zero when no symbol should be popped.  */
> -  int yylen = 0;
> -
> -  yyssp = yyss = yyssa;
> -  yyvsp = yyvs = yyvsa;
> -  yystacksize = YYINITDEPTH;
> -
> -  YYDPRINTF ((stderr, "Starting parse\n"));
> -
> -  yystate = 0;
> -  yyerrstatus = 0;
> -  yynerrs = 0;
> -  yychar = YYEMPTY; /* Cause a token to be read.  */
> -  goto yysetstate;
> -
> -/*------------------------------------------------------------.
> -| yynewstate -- Push a new state, which is found in yystate.  |
> -`------------------------------------------------------------*/
> - yynewstate:
> -  /* In all cases, when you get here, the value and location stacks
> -     have just been pushed.  So pushing a state here evens the stacks.  */
> -  yyssp++;
> -
> - yysetstate:
> -  *yyssp = yystate;
> -
> -  if (yyss + yystacksize - 1 <= yyssp)
> -    {
> -      /* Get the current used size of the three stacks, in elements.  */
> -      YYSIZE_T yysize = yyssp - yyss + 1;
> -
> -#ifdef yyoverflow
> -      {
> -	/* Give user a chance to reallocate the stack.  Use copies of
> -	   these so that the &'s don't force the real ones into
> -	   memory.  */
> -	YYSTYPE *yyvs1 = yyvs;
> -	yytype_int16 *yyss1 = yyss;
> -
> -	/* Each stack pointer address is followed by the size of the
> -	   data in use in that stack, in bytes.  This used to be a
> -	   conditional around just the two extra args, but that might
> -	   be undefined if yyoverflow is a macro.  */
> -	yyoverflow (YY_("memory exhausted"),
> -		    &yyss1, yysize * sizeof (*yyssp),
> -		    &yyvs1, yysize * sizeof (*yyvsp),
> -		    &yystacksize);
> -
> -	yyss = yyss1;
> -	yyvs = yyvs1;
> -      }
> -#else /* no yyoverflow */
> -# ifndef YYSTACK_RELOCATE
> -      goto yyexhaustedlab;
> -# else
> -      /* Extend the stack our own way.  */
> -      if (YYMAXDEPTH <= yystacksize)
> -	goto yyexhaustedlab;
> -      yystacksize *= 2;
> -      if (YYMAXDEPTH < yystacksize)
> -	yystacksize = YYMAXDEPTH;
> -
> -      {
> -	yytype_int16 *yyss1 = yyss;
> -	union yyalloc *yyptr =
> -	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
> -	if (! yyptr)
> -	  goto yyexhaustedlab;
> -	YYSTACK_RELOCATE (yyss_alloc, yyss);
> -	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
> -#  undef YYSTACK_RELOCATE
> -	if (yyss1 != yyssa)
> -	  YYSTACK_FREE (yyss1);
> -      }
> -# endif
> -#endif /* no yyoverflow */
> -
> -      yyssp = yyss + yysize - 1;
> -      yyvsp = yyvs + yysize - 1;
> -
> -      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
> -		  (unsigned long int) yystacksize));
> -
> -      if (yyss + yystacksize - 1 <= yyssp)
> -	YYABORT;
> -    }
> -
> -  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
> -
> -  if (yystate == YYFINAL)
> -    YYACCEPT;
> -
> -  goto yybackup;
> -
> -/*-----------.
> -| yybackup.  |
> -`-----------*/
> -yybackup:
> -
> -  /* Do appropriate processing given the current state.  Read a
> -     lookahead token if we need one and don't already have one.  */
> -
> -  /* First try to decide what to do without reference to lookahead token.  */
> -  yyn = yypact[yystate];
> -  if (yypact_value_is_default (yyn))
> -    goto yydefault;
> -
> -  /* Not known => get a lookahead token if don't already have one.  */
> -
> -  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
> -  if (yychar == YYEMPTY)
> -    {
> -      YYDPRINTF ((stderr, "Reading a token: "));
> -      yychar = YYLEX;
> -    }
> -
> -  if (yychar <= YYEOF)
> -    {
> -      yychar = yytoken = YYEOF;
> -      YYDPRINTF ((stderr, "Now at end of input.\n"));
> -    }
> -  else
> -    {
> -      yytoken = YYTRANSLATE (yychar);
> -      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
> -    }
> -
> -  /* If the proper action on seeing token YYTOKEN is to reduce or to
> -     detect an error, take that action.  */
> -  yyn += yytoken;
> -  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
> -    goto yydefault;
> -  yyn = yytable[yyn];
> -  if (yyn <= 0)
> -    {
> -      if (yytable_value_is_error (yyn))
> -        goto yyerrlab;
> -      yyn = -yyn;
> -      goto yyreduce;
> -    }
> -
> -  /* Count tokens shifted since error; after three, turn off error
> -     status.  */
> -  if (yyerrstatus)
> -    yyerrstatus--;
> -
> -  /* Shift the lookahead token.  */
> -  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
> -
> -  /* Discard the shifted token.  */
> -  yychar = YYEMPTY;
> -
> -  yystate = yyn;
> -  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -  *++yyvsp = yylval;
> -  YY_IGNORE_MAYBE_UNINITIALIZED_END
> -
> -  goto yynewstate;
> -
> -
> -/*-----------------------------------------------------------.
> -| yydefault -- do the default action for the current state.  |
> -`-----------------------------------------------------------*/
> -yydefault:
> -  yyn = yydefact[yystate];
> -  if (yyn == 0)
> -    goto yyerrlab;
> -  goto yyreduce;
> -
> -
> -/*-----------------------------.
> -| yyreduce -- Do a reduction.  |
> -`-----------------------------*/
> -yyreduce:
> -  /* yyn is the number of a rule to reduce with.  */
> -  yylen = yyr2[yyn];
> -
> -  /* If YYLEN is nonzero, implement the default value of the action:
> -     `$$ = $1'.
> -
> -     Otherwise, the following line sets YYVAL to garbage.
> -     This behavior is undocumented and Bison
> -     users should not rely upon it.  Assigning to YYVAL
> -     unconditionally makes the parser a bit smaller, and it avoids a
> -     GCC warning that YYVAL may be used uninitialized.  */
> -  yyval = yyvsp[1-yylen];
> -
> -
> -  YY_REDUCE_PRINT (yyn);
> -  switch (yyn)
> -    {
> -        case 4:
> -
> -    { is_typedef = 0; is_extern = 0; current_name = NULL; decl_spec = NULL; }
> -    break;
> -
> -  case 5:
> -
> -    { free_list(*(yyvsp[(2) - (2)]), NULL); *(yyvsp[(2) - (2)]) = NULL; }
> -    break;
> -
> -  case 6:
> -
> -    { is_typedef = 1; }
> -    break;
> -
> -  case 7:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 8:
> -
> -    { is_typedef = 1; }
> -    break;
> -
> -  case 9:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 14:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 15:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 16:
> -
> -    { if (current_name) {
> -		    struct string_list *decl = (*(yyvsp[(3) - (3)]))->next;
> -		    (*(yyvsp[(3) - (3)]))->next = NULL;
> -		    add_symbol(current_name,
> -			       is_typedef ? SYM_TYPEDEF : SYM_NORMAL,
> -			       decl, is_extern);
> -		    current_name = NULL;
> -		  }
> -		  (yyval) = (yyvsp[(3) - (3)]);
> -		}
> -    break;
> -
> -  case 17:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 19:
> -
> -    { struct string_list *decl = *(yyvsp[(1) - (1)]);
> -		  *(yyvsp[(1) - (1)]) = NULL;
> -		  add_symbol(current_name,
> -			     is_typedef ? SYM_TYPEDEF : SYM_NORMAL, decl, is_extern);
> -		  current_name = NULL;
> -		  (yyval) = (yyvsp[(1) - (1)]);
> -		}
> -    break;
> -
> -  case 20:
> -
> -    { struct string_list *decl = *(yyvsp[(3) - (3)]);
> -		  *(yyvsp[(3) - (3)]) = NULL;
> -		  free_list(*(yyvsp[(2) - (3)]), NULL);
> -		  *(yyvsp[(2) - (3)]) = decl_spec;
> -		  add_symbol(current_name,
> -			     is_typedef ? SYM_TYPEDEF : SYM_NORMAL, decl, is_extern);
> -		  current_name = NULL;
> -		  (yyval) = (yyvsp[(3) - (3)]);
> -		}
> -    break;
> -
> -  case 21:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]) ? (yyvsp[(4) - (4)]) : (yyvsp[(3) - (4)]) ? (yyvsp[(3) - (4)]) : (yyvsp[(2) - (4)]) ? (yyvsp[(2) - (4)]) : (yyvsp[(1) - (4)]); }
> -    break;
> -
> -  case 22:
> -
> -    { decl_spec = NULL; }
> -    break;
> -
> -  case 24:
> -
> -    { decl_spec = *(yyvsp[(1) - (1)]); }
> -    break;
> -
> -  case 25:
> -
> -    { decl_spec = *(yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 26:
> -
> -    { /* Version 2 checksumming ignores storage class, as that
> -		     is really irrelevant to the linkage.  */
> -		  remove_node((yyvsp[(1) - (1)]));
> -		  (yyval) = (yyvsp[(1) - (1)]);
> -		}
> -    break;
> -
> -  case 31:
> -
> -    { is_extern = 1; (yyval) = (yyvsp[(1) - (1)]); }
> -    break;
> -
> -  case 32:
> -
> -    { is_extern = 0; (yyval) = (yyvsp[(1) - (1)]); }
> -    break;
> -
> -  case 37:
> -
> -    { remove_node((yyvsp[(1) - (2)])); (*(yyvsp[(2) - (2)]))->tag = SYM_STRUCT; (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 38:
> -
> -    { remove_node((yyvsp[(1) - (2)])); (*(yyvsp[(2) - (2)]))->tag = SYM_UNION; (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 39:
> -
> -    { remove_node((yyvsp[(1) - (2)])); (*(yyvsp[(2) - (2)]))->tag = SYM_ENUM; (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 40:
> -
> -    { record_compound((yyvsp[(1) - (3)]), (yyvsp[(2) - (3)]), (yyvsp[(3) - (3)]), SYM_STRUCT); (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 41:
> -
> -    { record_compound((yyvsp[(1) - (3)]), (yyvsp[(2) - (3)]), (yyvsp[(3) - (3)]), SYM_UNION); (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 42:
> -
> -    { record_compound((yyvsp[(1) - (3)]), (yyvsp[(2) - (3)]), (yyvsp[(3) - (3)]), SYM_ENUM); (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 43:
> -
> -    { add_symbol(NULL, SYM_ENUM, NULL, 0); (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 44:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 45:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 57:
> -
> -    { (*(yyvsp[(1) - (1)]))->tag = SYM_TYPEDEF; (yyval) = (yyvsp[(1) - (1)]); }
> -    break;
> -
> -  case 58:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]) ? (yyvsp[(2) - (2)]) : (yyvsp[(1) - (2)]); }
> -    break;
> -
> -  case 59:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 62:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 66:
> -
> -    { /* restrict has no effect in prototypes so ignore it */
> -		  remove_node((yyvsp[(1) - (1)]));
> -		  (yyval) = (yyvsp[(1) - (1)]);
> -		}
> -    break;
> -
> -  case 67:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 69:
> -
> -    { if (current_name != NULL) {
> -		    error_with_pos("unexpected second declaration name");
> -		    YYERROR;
> -		  } else {
> -		    current_name = (*(yyvsp[(1) - (1)]))->string;
> -		    (yyval) = (yyvsp[(1) - (1)]);
> -		  }
> -		}
> -    break;
> -
> -  case 70:
> -
> -    { if (current_name != NULL) {
> -		    error_with_pos("unexpected second declaration name");
> -		    YYERROR;
> -		  } else {
> -		    current_name = (*(yyvsp[(1) - (1)]))->string;
> -		    (yyval) = (yyvsp[(1) - (1)]);
> -		  }
> -		}
> -    break;
> -
> -  case 71:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 72:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 73:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 74:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 75:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 79:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 80:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 81:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 82:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 83:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 84:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 86:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 87:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 90:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 91:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]) ? (yyvsp[(2) - (2)]) : (yyvsp[(1) - (2)]); }
> -    break;
> -
> -  case 92:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]) ? (yyvsp[(2) - (2)]) : (yyvsp[(1) - (2)]); }
> -    break;
> -
> -  case 94:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 95:
> -
> -    { /* For version 2 checksums, we don't want to remember
> -		     private parameter names.  */
> -		  remove_node((yyvsp[(1) - (1)]));
> -		  (yyval) = (yyvsp[(1) - (1)]);
> -		}
> -    break;
> -
> -  case 96:
> -
> -    { remove_node((yyvsp[(1) - (1)]));
> -		  (yyval) = (yyvsp[(1) - (1)]);
> -		}
> -    break;
> -
> -  case 97:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 98:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 99:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 100:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 101:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 102:
> -
> -    { struct string_list *decl = *(yyvsp[(2) - (3)]);
> -		  *(yyvsp[(2) - (3)]) = NULL;
> -		  add_symbol(current_name, SYM_NORMAL, decl, is_extern);
> -		  (yyval) = (yyvsp[(3) - (3)]);
> -		}
> -    break;
> -
> -  case 103:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 105:
> -
> -    { remove_list((yyvsp[(2) - (2)]), &(*(yyvsp[(1) - (2)]))->next); (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 106:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 107:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 108:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 111:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 112:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 113:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 114:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 117:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 118:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]) ? (yyvsp[(2) - (2)]) : (yyvsp[(1) - (2)]); }
> -    break;
> -
> -  case 119:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 121:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 122:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 124:
> -
> -    { (yyval) = (yyvsp[(3) - (3)]); }
> -    break;
> -
> -  case 125:
> -
> -    { (yyval) = (yyvsp[(4) - (4)]); }
> -    break;
> -
> -  case 128:
> -
> -    {
> -			const char *name = strdup((*(yyvsp[(1) - (1)]))->string);
> -			add_symbol(name, SYM_ENUM_CONST, NULL, 0);
> -		}
> -    break;
> -
> -  case 129:
> -
> -    {
> -			const char *name = strdup((*(yyvsp[(1) - (3)]))->string);
> -			struct string_list *expr = copy_list_range(*(yyvsp[(3) - (3)]), *(yyvsp[(2) - (3)]));
> -			add_symbol(name, SYM_ENUM_CONST, expr, 0);
> -		}
> -    break;
> -
> -  case 130:
> -
> -    { (yyval) = (yyvsp[(2) - (2)]); }
> -    break;
> -
> -  case 131:
> -
> -    { (yyval) = NULL; }
> -    break;
> -
> -  case 133:
> -
> -    { export_symbol((*(yyvsp[(3) - (5)]))->string); (yyval) = (yyvsp[(5) - (5)]); }
> -    break;
> -
> -
> -
> -      default: break;
> -    }
> -  /* User semantic actions sometimes alter yychar, and that requires
> -     that yytoken be updated with the new translation.  We take the
> -     approach of translating immediately before every use of yytoken.
> -     One alternative is translating here after every semantic action,
> -     but that translation would be missed if the semantic action invokes
> -     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
> -     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
> -     incorrect destructor might then be invoked immediately.  In the
> -     case of YYERROR or YYBACKUP, subsequent parser actions might lead
> -     to an incorrect destructor call or verbose syntax error message
> -     before the lookahead is translated.  */
> -  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);
> -
> -  YYPOPSTACK (yylen);
> -  yylen = 0;
> -  YY_STACK_PRINT (yyss, yyssp);
> -
> -  *++yyvsp = yyval;
> -
> -  /* Now `shift' the result of the reduction.  Determine what state
> -     that goes to, based on the state we popped back to and the rule
> -     number reduced by.  */
> -
> -  yyn = yyr1[yyn];
> -
> -  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
> -  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
> -    yystate = yytable[yystate];
> -  else
> -    yystate = yydefgoto[yyn - YYNTOKENS];
> -
> -  goto yynewstate;
> -
> -
> -/*------------------------------------.
> -| yyerrlab -- here on detecting error |
> -`------------------------------------*/
> -yyerrlab:
> -  /* Make sure we have latest lookahead translation.  See comments at
> -     user semantic actions for why this is necessary.  */
> -  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);
> -
> -  /* If not already recovering from an error, report this error.  */
> -  if (!yyerrstatus)
> -    {
> -      ++yynerrs;
> -#if ! YYERROR_VERBOSE
> -      yyerror (YY_("syntax error"));
> -#else
> -# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
> -                                        yyssp, yytoken)
> -      {
> -        char const *yymsgp = YY_("syntax error");
> -        int yysyntax_error_status;
> -        yysyntax_error_status = YYSYNTAX_ERROR;
> -        if (yysyntax_error_status == 0)
> -          yymsgp = yymsg;
> -        else if (yysyntax_error_status == 1)
> -          {
> -            if (yymsg != yymsgbuf)
> -              YYSTACK_FREE (yymsg);
> -            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
> -            if (!yymsg)
> -              {
> -                yymsg = yymsgbuf;
> -                yymsg_alloc = sizeof yymsgbuf;
> -                yysyntax_error_status = 2;
> -              }
> -            else
> -              {
> -                yysyntax_error_status = YYSYNTAX_ERROR;
> -                yymsgp = yymsg;
> -              }
> -          }
> -        yyerror (yymsgp);
> -        if (yysyntax_error_status == 2)
> -          goto yyexhaustedlab;
> -      }
> -# undef YYSYNTAX_ERROR
> -#endif
> -    }
> -
> -
> -
> -  if (yyerrstatus == 3)
> -    {
> -      /* If just tried and failed to reuse lookahead token after an
> -	 error, discard it.  */
> -
> -      if (yychar <= YYEOF)
> -	{
> -	  /* Return failure if at end of input.  */
> -	  if (yychar == YYEOF)
> -	    YYABORT;
> -	}
> -      else
> -	{
> -	  yydestruct ("Error: discarding",
> -		      yytoken, &yylval);
> -	  yychar = YYEMPTY;
> -	}
> -    }
> -
> -  /* Else will try to reuse lookahead token after shifting the error
> -     token.  */
> -  goto yyerrlab1;
> -
> -
> -/*---------------------------------------------------.
> -| yyerrorlab -- error raised explicitly by YYERROR.  |
> -`---------------------------------------------------*/
> -yyerrorlab:
> -
> -  /* Pacify compilers like GCC when the user code never invokes
> -     YYERROR and the label yyerrorlab therefore never appears in user
> -     code.  */
> -  if (/*CONSTCOND*/ 0)
> -     goto yyerrorlab;
> -
> -  /* Do not reclaim the symbols of the rule which action triggered
> -     this YYERROR.  */
> -  YYPOPSTACK (yylen);
> -  yylen = 0;
> -  YY_STACK_PRINT (yyss, yyssp);
> -  yystate = *yyssp;
> -  goto yyerrlab1;
> -
> -
> -/*-------------------------------------------------------------.
> -| yyerrlab1 -- common code for both syntax error and YYERROR.  |
> -`-------------------------------------------------------------*/
> -yyerrlab1:
> -  yyerrstatus = 3;	/* Each real token shifted decrements this.  */
> -
> -  for (;;)
> -    {
> -      yyn = yypact[yystate];
> -      if (!yypact_value_is_default (yyn))
> -	{
> -	  yyn += YYTERROR;
> -	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
> -	    {
> -	      yyn = yytable[yyn];
> -	      if (0 < yyn)
> -		break;
> -	    }
> -	}
> -
> -      /* Pop the current state because it cannot handle the error token.  */
> -      if (yyssp == yyss)
> -	YYABORT;
> -
> -
> -      yydestruct ("Error: popping",
> -		  yystos[yystate], yyvsp);
> -      YYPOPSTACK (1);
> -      yystate = *yyssp;
> -      YY_STACK_PRINT (yyss, yyssp);
> -    }
> -
> -  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
> -  *++yyvsp = yylval;
> -  YY_IGNORE_MAYBE_UNINITIALIZED_END
> -
> -
> -  /* Shift the error token.  */
> -  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);
> -
> -  yystate = yyn;
> -  goto yynewstate;
> -
> -
> -/*-------------------------------------.
> -| yyacceptlab -- YYACCEPT comes here.  |
> -`-------------------------------------*/
> -yyacceptlab:
> -  yyresult = 0;
> -  goto yyreturn;
> -
> -/*-----------------------------------.
> -| yyabortlab -- YYABORT comes here.  |
> -`-----------------------------------*/
> -yyabortlab:
> -  yyresult = 1;
> -  goto yyreturn;
> -
> -#if !defined yyoverflow || YYERROR_VERBOSE
> -/*-------------------------------------------------.
> -| yyexhaustedlab -- memory exhaustion comes here.  |
> -`-------------------------------------------------*/
> -yyexhaustedlab:
> -  yyerror (YY_("memory exhausted"));
> -  yyresult = 2;
> -  /* Fall through.  */
> -#endif
> -
> -yyreturn:
> -  if (yychar != YYEMPTY)
> -    {
> -      /* Make sure we have latest lookahead translation.  See comments at
> -         user semantic actions for why this is necessary.  */
> -      yytoken = YYTRANSLATE (yychar);
> -      yydestruct ("Cleanup: discarding lookahead",
> -                  yytoken, &yylval);
> -    }
> -  /* Do not reclaim the symbols of the rule which action triggered
> -     this YYABORT or YYACCEPT.  */
> -  YYPOPSTACK (yylen);
> -  YY_STACK_PRINT (yyss, yyssp);
> -  while (yyssp != yyss)
> -    {
> -      yydestruct ("Cleanup: popping",
> -		  yystos[*yyssp], yyvsp);
> -      YYPOPSTACK (1);
> -    }
> -#ifndef yyoverflow
> -  if (yyss != yyssa)
> -    YYSTACK_FREE (yyss);
> -#endif
> -#if YYERROR_VERBOSE
> -  if (yymsg != yymsgbuf)
> -    YYSTACK_FREE (yymsg);
> -#endif
> -  /* Make sure YYID is used.  */
> -  return YYID (yyresult);
> -}
> -
> -
> -
> -
> -
> -static void
> -yyerror(const char *e)
> -{
> -  error_with_pos("%s", e);
> -}
> diff --git a/scripts/genksyms/parse.tab.h_shipped b/scripts/genksyms/parse.tab.h_shipped
> deleted file mode 100644
> index 46a5e12..0000000
> --- a/scripts/genksyms/parse.tab.h_shipped
> +++ /dev/null
> @@ -1,119 +0,0 @@
> -/* A Bison parser, made by GNU Bison 2.7.  */
> -
> -/* Bison interface for Yacc-like parsers in C
> -   
> -      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
> -   
> -   This program is free software: you can redistribute it and/or modify
> -   it under the terms of the GNU General Public License as published by
> -   the Free Software Foundation, either version 3 of the License, or
> -   (at your option) any later version.
> -   
> -   This program is distributed in the hope that it will be useful,
> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -   GNU General Public License for more details.
> -   
> -   You should have received a copy of the GNU General Public License
> -   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */
> -
> -/* As a special exception, you may create a larger work that contains
> -   part or all of the Bison parser skeleton and distribute that work
> -   under terms of your choice, so long as that work isn't itself a
> -   parser generator using the skeleton or a modified version thereof
> -   as a parser skeleton.  Alternatively, if you modify or redistribute
> -   the parser skeleton itself, you may (at your option) remove this
> -   special exception, which will cause the skeleton and the resulting
> -   Bison output files to be licensed under the GNU General Public
> -   License without this special exception.
> -   
> -   This special exception was added by the Free Software Foundation in
> -   version 2.2 of Bison.  */
> -
> -#ifndef YY_YY_SCRIPTS_GENKSYMS_PARSE_TAB_H_SHIPPED_INCLUDED
> -# define YY_YY_SCRIPTS_GENKSYMS_PARSE_TAB_H_SHIPPED_INCLUDED
> -/* Enabling traces.  */
> -#ifndef YYDEBUG
> -# define YYDEBUG 1
> -#endif
> -#if YYDEBUG
> -extern int yydebug;
> -#endif
> -
> -/* Tokens.  */
> -#ifndef YYTOKENTYPE
> -# define YYTOKENTYPE
> -   /* Put the tokens into the symbol table, so that GDB and other debuggers
> -      know about them.  */
> -   enum yytokentype {
> -     ASM_KEYW = 258,
> -     ATTRIBUTE_KEYW = 259,
> -     AUTO_KEYW = 260,
> -     BOOL_KEYW = 261,
> -     CHAR_KEYW = 262,
> -     CONST_KEYW = 263,
> -     DOUBLE_KEYW = 264,
> -     ENUM_KEYW = 265,
> -     EXTERN_KEYW = 266,
> -     EXTENSION_KEYW = 267,
> -     FLOAT_KEYW = 268,
> -     INLINE_KEYW = 269,
> -     INT_KEYW = 270,
> -     LONG_KEYW = 271,
> -     REGISTER_KEYW = 272,
> -     RESTRICT_KEYW = 273,
> -     SHORT_KEYW = 274,
> -     SIGNED_KEYW = 275,
> -     STATIC_KEYW = 276,
> -     STRUCT_KEYW = 277,
> -     TYPEDEF_KEYW = 278,
> -     UNION_KEYW = 279,
> -     UNSIGNED_KEYW = 280,
> -     VOID_KEYW = 281,
> -     VOLATILE_KEYW = 282,
> -     TYPEOF_KEYW = 283,
> -     VA_LIST_KEYW = 284,
> -     EXPORT_SYMBOL_KEYW = 285,
> -     ASM_PHRASE = 286,
> -     ATTRIBUTE_PHRASE = 287,
> -     TYPEOF_PHRASE = 288,
> -     BRACE_PHRASE = 289,
> -     BRACKET_PHRASE = 290,
> -     EXPRESSION_PHRASE = 291,
> -     CHAR = 292,
> -     DOTS = 293,
> -     IDENT = 294,
> -     INT = 295,
> -     REAL = 296,
> -     STRING = 297,
> -     TYPE = 298,
> -     OTHER = 299,
> -     FILENAME = 300
> -   };
> -#endif
> -
> -
> -#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
> -typedef int YYSTYPE;
> -# define YYSTYPE_IS_TRIVIAL 1
> -# define yystype YYSTYPE /* obsolescent; will be withdrawn */
> -# define YYSTYPE_IS_DECLARED 1
> -#endif
> -
> -extern YYSTYPE yylval;
> -
> -#ifdef YYPARSE_PARAM
> -#if defined __STDC__ || defined __cplusplus
> -int yyparse (void *YYPARSE_PARAM);
> -#else
> -int yyparse ();
> -#endif
> -#else /* ! YYPARSE_PARAM */
> -#if defined __STDC__ || defined __cplusplus
> -int yyparse (void);
> -#else
> -int yyparse ();
> -#endif
> -#endif /* ! YYPARSE_PARAM */
> -
> -#endif /* !YY_YY_SCRIPTS_GENKSYMS_PARSE_TAB_H_SHIPPED_INCLUDED  */
