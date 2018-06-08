Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HjYjF6HCGlsFHwAAmS7hNA
	; Fri, 08 Jun 2018 17:53:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2D4D3607DC; Fri,  8 Jun 2018 17:53:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Go+lRTVe"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 36E78607A4;
	Fri,  8 Jun 2018 17:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36E78607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeFHRxb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:53:31 -0400
Received: from mail-eopbgr20097.outbound.protection.outlook.com ([40.107.2.97]:23098
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751574AbeFHRx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK7GSAnG4s1QCCZyL7ESjNKM2y8hBNIll8vUaqh0X3o=;
 b=Go+lRTVeqM9D4z8gILsc88VcLUVqbRRZxv+6uwDY0rGnqNS9urlEQ5qs9D2dZKCdKId/7xMOJDIpb/BtR8Iz4p3hGBa+HLgChpXY6scM+66UDfx6fsY7Eg7MvZTDBxizUiXe8TLMQ4fzwNHJ8Z3uvxpil4BmLt6DN5L9BfIFNwQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Received: from outlook.office365.com (4.16.175.162) by
 AM6PR08MB3255.eurprd08.prod.outlook.com (2603:10a6:209:47::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.13; Fri, 8 Jun 2018 17:53:22 +0000
Date: Fri, 8 Jun 2018 10:53:08 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v5, 03/31] kconfig: reference environment variables directly
 and remove 'option env='
Message-ID: <20180608175307.GA15799@outlook.office365.com>
References: <1527499328-13213-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1527499328-13213-4-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: MWHPR2201CA0085.namprd22.prod.outlook.com
 (2603:10b6:301:5e::38) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:5+CY70L+DvP4U1IkzYLScDVissgvsDQeFnT6aHyn/+DyFd3f7ATonJpXYbQb9ju4YEsGkxw+jZypahaI+eo36hos4kwIH0OVwaEh8zGAKDUFJtCkosL19b5yhp8SEyJ9Vbxnb/sdEEa1gdamfVhfe4nPGRzzvuKGLugLnmuR23UJbp/4JuAD9P452GazahmoApLxDWbp5mKXEH8leEMvpZ0ArCQr2w52E8S7YL7fXGcHgRuaPOf6KunhbNNLO+Ok;25:nWzufwnOzgfMXflhCM9AtSm/rxgJ95eji7NTW5Xn4+VU0DgaWaKfXsWBY5g91AAr3mgN62yg/067gYL2okcQ9uTWbGiYOJtiAyYw3ns8gpEdAyDQr5xUkO9GHWZACluFeGhp9z57hGf9sidxUsh19ybOgih6RkuhCW88oNKE4OQ9WBKejHvpglNbJ2zI3OcCB/VxcWt6MGtb5bfC/V6wPLiBc4Lg/ab2kE5o/S75OhCS6if0ANZeNKQTA+sJbVMhHFtlgGPMnB4dC8U850gVvBkEz21nrrrJIVBUmS1agqty2d+jrR8MFEPpO6PugpsDP2gbr9v87YZDrcOezx0ZWQ==;31:xpi2zqHzUnRcqzVh6EUpHpXCM8ukA0ROm1Fp/QnPGHcf1594ogpOehbRJTTiYZKotdX3yjGlLnYCLB3fyRo3uTt5lL8HoNmDvxoXevJOBiYEYehc89v+MjLwOScNVcSSdRNQl0Sh/jUYbtoTzp+HSnfw1xgedWzGMI4r8ISDAKS+czWjSw/QFCEiUwBFMt9gHcX0gwExakGIWPFW99uB3rJKBkK1BGlIrFNy13WQYHY=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:Po38UDPbAPu3X8OuLqQrsdVxU7qZdIV0jiB+ScA772kAxWEccgfXdHqshvE0Rfp1qasXMqBQPzwSyNLVkuGZFZvf4ESJ3pUF5KItqtjj1rZ2nFQomw3nNTKmY4iGCmPUv3pLlc27r/9NR+VNQ9qeCoWMhVUi2CbsMvFoZfeJ5GEnfe0I6NDHiflGv37n1xUR8l/bdsMizosnTepPvcpd6oqwPq7ZSJvt7eTYNOfTwLpoD4grDjNU30rGLQ9Ol/sai48NUvPKTF5V1AYzE3cWApdsotmXdfrRoaQXhhrP/5OHRgiatdOeoz3Ln+yiEnnwjQroYd7Hw114nAUid+n9N3+Ad+WQikIB5KiiZ63urAjZAuLO4zHd5WplIO2/MitOUpZPKxfcEg/lj2xt4kslng75SMumgkduSpCbK2F7iCQaZ8a2sur1VwKpioVkfKAXwzXMq625CAtxrsAPn1PC0Sd//GGYfQk9IBSz/OIK3HbK6z2GJ25BKGnk6W3KnI1i;4:L+UNm51kYexNUY4e1KmUEO7miGC62QJue7vcQ1P1//l8z9dqn0ZzvIxaNRkpSFCYSSkw7bcbwAOGmlhboVrx6jRimUhamci2jdECboWaWkk/2UoXghzTmI1xOU1lATUyQc5W8l9hbS/hTQdMTSaAxv5cY/lbtU8Ynsg4F18jXfLzDBrc3RbpxG5PtVQ3Ea2Fw1eAdXtcoytPCHfb4hM1pgzT21ug4YR5WQGKKMg2mxxy37iZ/XgehuSA+PVB4akdOOkoX7tArG39ZnUa3FCLEg==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3255D23959B8E0D6D861D2E7CF7B0@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39850400004)(39380400002)(376002)(366004)(174874002)(199004)(189003)(7416002)(86362001)(6246003)(25786009)(66066001)(4326008)(55016002)(47776003)(58126008)(5660300001)(39060400002)(316002)(478600001)(6306002)(9686003)(16586007)(69596002)(50466002)(33656002)(54906003)(229853002)(6916009)(53936002)(575784001)(68736007)(97736004)(6666003)(446003)(11346002)(956004)(8676002)(386003)(6506007)(6116002)(3846002)(305945005)(26005)(52116002)(7696005)(8936002)(2906002)(81156014)(59450400001)(476003)(81166006)(106356001)(76176011)(53416004)(23686003)(37156001)(486006)(16526019)(105586002)(1076002)(186003)(7736002)(18370500001)(403724002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3255;23:reUNcGqTAQYok7/a9Vz2cXoUyCpgF5fjMp/lo1lvlRU?=
 =?koi8-r?Q?DWm7fmaVMqF1UVYsVzSBhhzkPYoklL7OqpyMC79kAm19EhkSOMZuembBSlfSG1?=
 =?koi8-r?Q?vylLqAPxDX9X/fIr08prfn+UKGEjUOd4TOI+yv3boOY8gGSpMR3EIdOA12nU/M?=
 =?koi8-r?Q?4fE3tiMExIc+02SxPx4Nil9FipY6R6Jk9plfJDEmYY9NJwRfwdFvedXbCUFUZM?=
 =?koi8-r?Q?wJ5qyZxXR/MIaRAw5i7OkmYGbOpT05FAga+2zgJzwhpwd+9WHPypx4HEv+nQbT?=
 =?koi8-r?Q?Z3RQfDWdmOKob3sdUMLI2nTOdX5vtTUHjVjFHEGNX8uJ957HpYGnY12s1b+XB9?=
 =?koi8-r?Q?HIzMepem1zobzo2Gihz9wrY0Dtuzi+ONWVKptduKMIyRbN+kD2eZSRcY9cgAwc?=
 =?koi8-r?Q?GeYubkY+GsU3CKIix5SJqcX3PPk5iXOM7IHd9jM6sHF4u2STiU/MWt+/JnX18c?=
 =?koi8-r?Q?TdELk39eybrsgOsFW2/cbIMJEmI5H/XHlOgOpLkiJELevravlsmC/G+Dgv30M8?=
 =?koi8-r?Q?3hNZFgqGLmXHGeLhNGjIiObHqdda+INAa8Wfa0meqE9WJwAEffKyauUsiV6XPP?=
 =?koi8-r?Q?91jqQIlrUjIYNvTd7QI9exAclwwKTdX3BVqKEIN4XvJA69ynYgVq92eEL4VmjE?=
 =?koi8-r?Q?+C17Etax0OxudRpC34uV3EEwaStrw/Yq0jtaVHhkRArNLYlgcv4w0V07SOrE64?=
 =?koi8-r?Q?6dWml1605milmVs8PtKaobn4VbFC6vZvt5XKRA9KNgtBdpv+jHqWV/+56aMYe1?=
 =?koi8-r?Q?QYM7/sE4RvsspARcdHN4D0Qh7gx3qDDtibQjU8T1ZG8ytyjKQDX2D8/YsnRjct?=
 =?koi8-r?Q?AOFi2Zhhih80sw/nKgUrHfFzRnxyM07AiXJ3rJmnE/F+8b+R/TgTyrUYVgmBus?=
 =?koi8-r?Q?1RJdeGaByB1Ox7aFNRBxQDypYZcxCwIR95cZwj8ivsslqKu9aokjeqfkqlmtFJ?=
 =?koi8-r?Q?vPoKEgWGSaHjmZccfpVo3+G8gEyW1m2t8LYSteBASJabtPs0rhXY/Qpsh1uF5u?=
 =?koi8-r?Q?1t9iicu+m3B39X4WJfJpjh7emYBH/lkYfeimR6EwN4oF9/7Pp4vPr0TdVGwqBq?=
 =?koi8-r?Q?ekPm/JvUUg28EMMUPkmjhSzJXdjkHiDsGtVLAyYP2N3cVt8s09VYQ/fQJao8yI?=
 =?koi8-r?Q?09ze8Q9XYnCjAdi45cT/366s/kfXNIgvYRi/UMK07VF2tEVCwAyl1ckZFeoH1G?=
 =?koi8-r?Q?B1OGfAsEDgBJj5xa1PyC6P1eeFC4YqlYU2wV+jTpLUlrO6TaPH2kvWU1Q4l/eS?=
 =?koi8-r?Q?JNIOQLYhP6EOOG6zZAifA/Vau6qko6oGw/MG2YITEgfZf0Zv6G6MJzBVNoYtpt?=
 =?koi8-r?Q?oPGOU+jIK3vphRd8gtl19trHkc8NSwGZtBLiJdZSKGZ+DZ49HY6e3bdL7DavZo?=
 =?koi8-r?Q?+nfvtyOWyZZhXTALgFv1BCfwrNK1BY0DE13xGX1JDsM27A7Qg5KVIuofeYocON?=
 =?koi8-r?Q?tBAtcD9g0OCTaP8TGmf7AbduA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6Lc4ml7zDKZnLuuoWXL+lFMpYCXJ1vpJSfgOtbuw19jfGgqRCmdWBmZ2goZx/vZAgP8cYNsf7kkwwwZ8rNSiQ3J6f1MFIAUe5iCGMQM39ndoy4Dcr3beoWrYyzkgH1O0S+RoKYsf3SZHsxhUycDhRSDqz7HBgtbd+VWZqCBF9+ktK/oBcVMl5ET9y/hfywKY
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:ZegY2gMGypIws+k4jWfhiL0GyAk+ID6iJaWX70YDvXq/FMPAY0sjShX03kjAKL0OMDpDxdVqmQldtImzE1VSNknrAd85CqkLqEVDjxl0Al7vIW/Z4d2/qqzBfGiH5lXXEHdIOVv3MWqHPrRULf8P9ZqMT8GG0sh7V/2SLrNgK5iuFJd4yk6kgJ1pFrG6fp8+l8qLEFyowEg7oJGD2TSeVVXGq61Kv1cDS3kFSDpSNA21SRbHwiC/20Z4bJGsg8aMfObW2QMyRAbwrYRIxSP9Lh67AkgZzPtGM6kxj2trOohZpH9fy3xjn/QqVCVWLJeIowYauAwytuUNSc5jg9GeokzIqMRl2ItO8WMeU0pLCV/6gJngNfUylz0zRZAEaaIMkBpchQlTmRPbBfMX+Tef9+GuiErKS3ZCvoksEvvldvFs+oatjJWhfsYpKiJNGIzl438YMVtioiVxuQVtsjZT7A==;5:aU1IyO5B3QjvMoGHYuRQWbPD42i68xywu2BX/eJbhrkxBN6OAvUDq4ZoUP5QRjwmpUBUWsVBD0lrEyTkefQmJKfP0XfPgA7WJ9FbpWeOzRbbzeEvzRsrHBMJMoU084EpwqVKjCXXORyKFiu2AtZ/dC64E0Pd2HXrAqxkkEgq3E4=;24:ukVMDHT4XLiaFedTnhBTuhH8XRIn0iIyO59wZdWbXBqEYg9ZQPtUz0NpEgX7b7OPmLXaBbexDMK60XhRKQMEZgKvhtufaO6nfXkZ7trsuJw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:MauI2rYBiVlVazXtDyyqfkduNByHLMCWc7dCrmpBcCXBw7Ypph1pi3y3/GYDPNjaKQ+Bv1MIVaIYwt8L615gwadpPvM39CTZnxNeVyr8Un0bp3OxIt+dmfU8CUB5pv8lBU7Q+fP9S3DdkvrLBOdKo/wo7wy3RncjoazEDFpdNTu8Xzs15TBV1i68eIw+ibYLrwgIgh0oXzK65DDs3wwTqTAO6ZWis630lNWbb6YlvROjSiZjZhA7uQp4r2Hd3vef;20:mL2AjPUgTnCT2tfQVLUmjx0ddrhVTCgvSyPfHxU8EzvWBXODBRPP6HtjaSrUopojer2fcn2UzZu66MooXnK60tXWhfE4kp1lGDK2fXP0T1yKj8qd+JvH9Q1vsVFSkfYYs6n7eIwwO7FL7LnWYUNLmZQBX4vlAtczfFMRbfFBfFo=
X-MS-Office365-Filtering-Correlation-Id: d8fed0df-8f8c-4ee4-2dcc-08d5cd68bb60
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 17:53:22.6164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fed0df-8f8c-4ee4-2dcc-08d5cd68bb60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

localyesconfig doesn't work and git bisect points on this patch.

[avagin@laptop linux]$ make  localyesconfig
using config: '.config'
Can't open arch/$(SRCARCH)/Kconfig at ./scripts/kconfig/streamline_config.pl line 174, <$kinfile> line 8.
make[1]: *** [scripts/kconfig/Makefile:45: localyesconfig] Error 2
make: *** [Makefile:526: localyesconfig] Error 2

On Mon, May 28, 2018 at 06:21:40PM +0900, Masahiro Yamada wrote:
> To get access to environment variables, Kconfig needs to define a
> symbol using "option env=" syntax.  It is tedious to add a symbol entry
> for each environment variable given that we need to define much more
> such as 'CC', 'AS', 'srctree' etc. to evaluate the compiler capability
> in Kconfig.
> 
> Adding '$' for symbol references is grammatically inconsistent.
> Looking at the code, the symbols prefixed with 'S' are expanded by:
>  - conf_expand_value()
>    This is used to expand 'arch/$ARCH/defconfig' and 'defconfig_list'
>  - sym_expand_string_value()
>    This is used to expand strings in 'source' and 'mainmenu'
> 
> All of them are fixed values independent of user configuration.  So,
> they can be changed into the direct expansion instead of symbols.
> 
> This change makes the code much cleaner.  The bounce symbols 'SRCARCH',
> 'ARCH', 'SUBARCH', 'KERNELVERSION' are gone.
> 
> sym_init() hard-coding 'UNAME_RELEASE' is also gone.  'UNAME_RELEASE'
> should be replaced with an environment variable.
> 
> ARCH_DEFCONFIG is a normal symbol, so it should be simply referenced
> without '$' prefix.
> 
> The new syntax is addicted by Make.  The variable reference needs
> parentheses, like $(FOO), but you can omit them for single-letter
> variables, like $F.  Yet, in Makefiles, people tend to use the
> parenthetical form for consistency / clarification.
> 
> At this moment, only the environment variable is supported, but I will
> extend the concept of 'variable' later on.
> 
> The variables are expanded in the lexer so we can simplify the token
> handling on the parser side.
> 
> For example, the following code works.
> 
> [Example code]
> 
>   config MY_TOOLCHAIN_LIST
>           string
>           default "My tools: CC=$(CC), AS=$(AS), CPP=$(CPP)"
> 
> [Result]
> 
>   $ make -s alldefconfig && tail -n 1 .config
>   CONFIG_MY_TOOLCHAIN_LIST="My tools: CC=gcc, AS=as, CPP=gcc -E"
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> 
> Changes in v5:
>   - More comments like "advance pointer to ..."
>   - Factor out the duplicated code into __expand_string()
>   - Move the empty name check to env_expand().
>   - Remove escape sequence of '$'
> 
> Changes in v4:
>   - Enclose ARCH in conf_defname
>   - Drop single-letter support
> 
> Changes in v3:
>   - Reimplement
>   - Variable reference need parentheses except single-letter variable
> 
> Changes in v2:
>   - Move the string expansion to the lexer phase.
>   - Split environment helpers to env.c
> 
>  Documentation/kbuild/kconfig-language.txt |   8 -
>  Kconfig                                   |   8 +-
>  Makefile                                  |   3 +-
>  arch/sh/Kconfig                           |   4 +-
>  arch/sparc/Kconfig                        |   4 +-
>  arch/um/Kconfig.common                    |   4 -
>  arch/x86/Kconfig                          |   4 +-
>  arch/x86/um/Kconfig                       |   6 +-
>  init/Kconfig                              |  16 +-
>  scripts/kconfig/confdata.c                |  33 +----
>  scripts/kconfig/kconf_id.c                |   1 -
>  scripts/kconfig/lkc.h                     |   5 +-
>  scripts/kconfig/lkc_proto.h               |   6 +
>  scripts/kconfig/menu.c                    |   3 -
>  scripts/kconfig/preprocess.c              | 238 ++++++++++++++++++++++++++++++
>  scripts/kconfig/symbol.c                  |  56 -------
>  scripts/kconfig/util.c                    |  29 ++--
>  scripts/kconfig/zconf.l                   |  67 ++++++++-
>  scripts/kconfig/zconf.y                   |   2 +-
>  19 files changed, 343 insertions(+), 154 deletions(-)
>  create mode 100644 scripts/kconfig/preprocess.c
> 
> diff --git a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
> index f5b9493..0e966e8 100644
> --- a/Documentation/kbuild/kconfig-language.txt
> +++ b/Documentation/kbuild/kconfig-language.txt
> @@ -198,14 +198,6 @@ applicable everywhere (see syntax).
>      enables the third modular state for all config symbols.
>      At most one symbol may have the "modules" option set.
>  
> -  - "env"=<value>
> -    This imports the environment variable into Kconfig. It behaves like
> -    a default, except that the value comes from the environment, this
> -    also means that the behaviour when mixing it with normal defaults is
> -    undefined at this point. The symbol is currently not exported back
> -    to the build environment (if this is desired, it can be done via
> -    another symbol).
> -
>    - "allnoconfig_y"
>      This declares the symbol as one that should have the value y when
>      using "allnoconfig". Used for symbols that hide other symbols.
> diff --git a/Kconfig b/Kconfig
> index 8c4c1cb..4af1b42 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -3,10 +3,6 @@
>  # For a description of the syntax of this configuration file,
>  # see Documentation/kbuild/kconfig-language.txt.
>  #
> -mainmenu "Linux/$ARCH $KERNELVERSION Kernel Configuration"
> +mainmenu "Linux/$(ARCH) $(KERNELVERSION) Kernel Configuration"
>  
> -config SRCARCH
> -	string
> -	option env="SRCARCH"
> -
> -source "arch/$SRCARCH/Kconfig"
> +source "arch/$(SRCARCH)/Kconfig"
> diff --git a/Makefile b/Makefile
> index 58afa07..59b8654 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -284,7 +284,8 @@ include scripts/Kbuild.include
>  # Read KERNELRELEASE from include/config/kernel.release (if it exists)
>  KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
>  KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
> -export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
> +UNAME_RELEASE := $(shell uname --release)
> +export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION UNAME_RELEASE
>  
>  # SUBARCH tells the usermode build what the underlying arch is.  That is set
>  # first, and if a usermode build is happening, the "ARCH=um" on the command
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 1851eae..c8400e3 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -58,7 +58,7 @@ config SUPERH
>  	  <http://www.linux-sh.org/>.
>  
>  config SUPERH32
> -	def_bool ARCH = "sh"
> +	def_bool "$(ARCH)" = "sh"
>  	select HAVE_KPROBES
>  	select HAVE_KRETPROBES
>  	select HAVE_IOREMAP_PROT if MMU && !X2TLB
> @@ -77,7 +77,7 @@ config SUPERH32
>  	select HAVE_CC_STACKPROTECTOR
>  
>  config SUPERH64
> -	def_bool ARCH = "sh64"
> +	def_bool "$(ARCH)" = "sh64"
>  	select HAVE_EXIT_THREAD
>  	select KALLSYMS
>  
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 8767e45..df7410c 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -1,6 +1,6 @@
>  config 64BIT
> -	bool "64-bit kernel" if ARCH = "sparc"
> -	default ARCH = "sparc64"
> +	bool "64-bit kernel" if "$(ARCH)" = "sparc"
> +	default "$(ARCH)" = "sparc64"
>  	help
>  	  SPARC is a family of RISC microprocessors designed and marketed by
>  	  Sun Microsystems, incorporated.  They are very widely found in Sun
> diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
> index c68add8..07f84c8 100644
> --- a/arch/um/Kconfig.common
> +++ b/arch/um/Kconfig.common
> @@ -54,10 +54,6 @@ config HZ
>  	int
>  	default 100
>  
> -config SUBARCH
> -	string
> -	option env="SUBARCH"
> -
>  config NR_CPUS
>  	int
>  	range 1 1
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c07f492..2236505 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Select 32 or 64 bit
>  config 64BIT
> -	bool "64-bit kernel" if ARCH = "x86"
> -	default ARCH != "i386"
> +	bool "64-bit kernel" if "$(ARCH)" = "x86"
> +	default "$(ARCH)" != "i386"
>  	---help---
>  	  Say yes to build a 64-bit kernel - formerly known as x86_64
>  	  Say no to build a 32-bit kernel - formerly known as i386
> diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
> index 13ed827..6a15c4d 100644
> --- a/arch/x86/um/Kconfig
> +++ b/arch/x86/um/Kconfig
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -mainmenu "User Mode Linux/$SUBARCH $KERNELVERSION Kernel Configuration"
> +mainmenu "User Mode Linux/$(SUBARCH) $(KERNELVERSION) Kernel Configuration"
>  
>  source "arch/um/Kconfig.common"
>  
> @@ -16,8 +16,8 @@ config UML_X86
>  	select GENERIC_FIND_FIRST_BIT
>  
>  config 64BIT
> -	bool "64-bit kernel" if SUBARCH = "x86"
> -	default SUBARCH != "i386"
> +	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
> +	default "$(SUBARCH)" != "i386"
>  
>  config X86_32
>  	def_bool !64BIT
> diff --git a/init/Kconfig b/init/Kconfig
> index 15aae32..1217fc6 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1,20 +1,12 @@
> -config ARCH
> -	string
> -	option env="ARCH"
> -
> -config KERNELVERSION
> -	string
> -	option env="KERNELVERSION"
> -
>  config DEFCONFIG_LIST
>  	string
>  	depends on !UML
>  	option defconfig_list
> -	default "/lib/modules/$UNAME_RELEASE/.config"
> +	default "/lib/modules/$(UNAME_RELEASE)/.config"
>  	default "/etc/kernel-config"
> -	default "/boot/config-$UNAME_RELEASE"
> -	default "$ARCH_DEFCONFIG"
> -	default "arch/$ARCH/defconfig"
> +	default "/boot/config-$(UNAME_RELEASE)"
> +	default ARCH_DEFCONFIG
> +	default "arch/$(ARCH)/defconfig"
>  
>  config CONSTRUCTORS
>  	bool
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index df26c7b..f72587c 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -30,7 +30,7 @@ static void conf_message(const char *fmt, ...)
>  static const char *conf_filename;
>  static int conf_lineno, conf_warnings;
>  
> -const char conf_defname[] = "arch/$ARCH/defconfig";
> +const char conf_defname[] = "arch/$(ARCH)/defconfig";
>  
>  static void conf_warning(const char *fmt, ...)
>  {
> @@ -81,39 +81,13 @@ const char *conf_get_autoconfig_name(void)
>  	return name ? name : "include/config/auto.conf";
>  }
>  
> -static char *conf_expand_value(const char *in)
> -{
> -	struct symbol *sym;
> -	const char *src;
> -	static char res_value[SYMBOL_MAXLENGTH];
> -	char *dst, name[SYMBOL_MAXLENGTH];
> -
> -	res_value[0] = 0;
> -	dst = name;
> -	while ((src = strchr(in, '$'))) {
> -		strncat(res_value, in, src - in);
> -		src++;
> -		dst = name;
> -		while (isalnum(*src) || *src == '_')
> -			*dst++ = *src++;
> -		*dst = 0;
> -		sym = sym_lookup(name, 0);
> -		sym_calc_value(sym);
> -		strcat(res_value, sym_get_string_value(sym));
> -		in = src;
> -	}
> -	strcat(res_value, in);
> -
> -	return res_value;
> -}
> -
>  char *conf_get_default_confname(void)
>  {
>  	struct stat buf;
>  	static char fullname[PATH_MAX+1];
>  	char *env, *name;
>  
> -	name = conf_expand_value(conf_defname);
> +	name = expand_string(conf_defname);
>  	env = getenv(SRCTREE);
>  	if (env) {
>  		sprintf(fullname, "%s/%s", env, name);
> @@ -274,7 +248,8 @@ int conf_read_simple(const char *name, int def)
>  			if (expr_calc_value(prop->visible.expr) == no ||
>  			    prop->expr->type != E_SYMBOL)
>  				continue;
> -			name = conf_expand_value(prop->expr->left.sym->name);
> +			sym_calc_value(prop->expr->left.sym);
> +			name = sym_get_string_value(prop->expr->left.sym);
>  			in = zconf_fopen(name);
>  			if (in) {
>  				conf_message(_("using defaults found in %s"),
> diff --git a/scripts/kconfig/kconf_id.c b/scripts/kconfig/kconf_id.c
> index 3ea9c5f..b3e0ea0 100644
> --- a/scripts/kconfig/kconf_id.c
> +++ b/scripts/kconfig/kconf_id.c
> @@ -32,7 +32,6 @@ static struct kconf_id kconf_id_array[] = {
>  	{ "on",			T_ON,			TF_PARAM },
>  	{ "modules",		T_OPT_MODULES,		TF_OPTION },
>  	{ "defconfig_list",	T_OPT_DEFCONFIG_LIST,	TF_OPTION },
> -	{ "env",		T_OPT_ENV,		TF_OPTION },
>  	{ "allnoconfig_y",	T_OPT_ALLNOCONFIG_Y,	TF_OPTION },
>  };
>  
> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> index f4394af..658efb0 100644
> --- a/scripts/kconfig/lkc.h
> +++ b/scripts/kconfig/lkc.h
> @@ -58,7 +58,6 @@ enum conf_def_mode {
>  
>  #define T_OPT_MODULES		1
>  #define T_OPT_DEFCONFIG_LIST	2
> -#define T_OPT_ENV		3
>  #define T_OPT_ALLNOCONFIG_Y	4
>  
>  struct kconf_id {
> @@ -117,6 +116,7 @@ void *xmalloc(size_t size);
>  void *xcalloc(size_t nmemb, size_t size);
>  void *xrealloc(void *p, size_t size);
>  char *xstrdup(const char *s);
> +char *xstrndup(const char *s, size_t n);
>  
>  struct gstr {
>  	size_t len;
> @@ -134,9 +134,6 @@ void str_printf(struct gstr *gs, const char *fmt, ...);
>  const char *str_get(struct gstr *gs);
>  
>  /* symbol.c */
> -extern struct expr *sym_env_list;
> -
> -void sym_init(void);
>  void sym_clear_all_valid(void);
>  struct symbol *sym_choice_default(struct symbol *sym);
>  const char *sym_get_string_default(struct symbol *sym);
> diff --git a/scripts/kconfig/lkc_proto.h b/scripts/kconfig/lkc_proto.h
> index 9dc8abf..9f465fe 100644
> --- a/scripts/kconfig/lkc_proto.h
> +++ b/scripts/kconfig/lkc_proto.h
> @@ -49,5 +49,11 @@ const char * sym_get_string_value(struct symbol *sym);
>  
>  const char * prop_get_type_name(enum prop_type type);
>  
> +/* preprocess.c */
> +void env_write_dep(FILE *f, const char *auto_conf_name);
> +char *expand_string(const char *in);
> +char *expand_dollar(const char **str);
> +char *expand_one_token(const char **str);
> +
>  /* expr.c */
>  void expr_print(struct expr *e, void (*fn)(void *, struct symbol *, const char *), void *data, int prevtoken);
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 5c5c137..8148305 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -214,9 +214,6 @@ void menu_add_option(int token, char *arg)
>  			zconf_error("trying to redefine defconfig symbol");
>  		sym_defconfig_list->flags |= SYMBOL_AUTO;
>  		break;
> -	case T_OPT_ENV:
> -		prop_add_env(arg);
> -		break;
>  	case T_OPT_ALLNOCONFIG_Y:
>  		current_entry->sym->flags |= SYMBOL_ALLNOCONFIG_Y;
>  		break;
> diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
> new file mode 100644
> index 0000000..a2eb2eb
> --- /dev/null
> +++ b/scripts/kconfig/preprocess.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 Masahiro Yamada <yamada.masahiro@socionext.com>
> +
> +#include <stdarg.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "list.h"
> +
> +static void __attribute__((noreturn)) pperror(const char *format, ...)
> +{
> +	va_list ap;
> +
> +	fprintf(stderr, "%s:%d: ", current_file->name, yylineno);
> +	va_start(ap, format);
> +	vfprintf(stderr, format, ap);
> +	va_end(ap);
> +	fprintf(stderr, "\n");
> +
> +	exit(1);
> +}
> +
> +/*
> + * Environment variables
> + */
> +static LIST_HEAD(env_list);
> +
> +struct env {
> +	char *name;
> +	char *value;
> +	struct list_head node;
> +};
> +
> +static void env_add(const char *name, const char *value)
> +{
> +	struct env *e;
> +
> +	e = xmalloc(sizeof(*e));
> +	e->name = xstrdup(name);
> +	e->value = xstrdup(value);
> +
> +	list_add_tail(&e->node, &env_list);
> +}
> +
> +static void env_del(struct env *e)
> +{
> +	list_del(&e->node);
> +	free(e->name);
> +	free(e->value);
> +	free(e);
> +}
> +
> +/* The returned pointer must be freed when done */
> +static char *env_expand(const char *name)
> +{
> +	struct env *e;
> +	const char *value;
> +
> +	if (!*name)
> +		return NULL;
> +
> +	list_for_each_entry(e, &env_list, node) {
> +		if (!strcmp(name, e->name))
> +			return xstrdup(e->value);
> +	}
> +
> +	value = getenv(name);
> +	if (!value)
> +		return NULL;
> +
> +	/*
> +	 * We need to remember all referenced environment variables.
> +	 * They will be written out to include/config/auto.conf.cmd
> +	 */
> +	env_add(name, value);
> +
> +	return xstrdup(value);
> +}
> +
> +void env_write_dep(FILE *f, const char *autoconfig_name)
> +{
> +	struct env *e, *tmp;
> +
> +	list_for_each_entry_safe(e, tmp, &env_list, node) {
> +		fprintf(f, "ifneq \"$(%s)\" \"%s\"\n", e->name, e->value);
> +		fprintf(f, "%s: FORCE\n", autoconfig_name);
> +		fprintf(f, "endif\n");
> +		env_del(e);
> +	}
> +}
> +
> +static char *eval_clause(const char *str, size_t len)
> +{
> +	char *tmp, *name, *res;
> +
> +	tmp = xstrndup(str, len);
> +
> +	name = expand_string(tmp);
> +
> +	res = env_expand(name);
> +	if (res)
> +		goto free;
> +
> +	res = xstrdup("");
> +free:
> +	free(name);
> +	free(tmp);
> +
> +	return res;
> +}
> +
> +/*
> + * Expand a string that follows '$'
> + *
> + * For example, if the input string is
> + *     ($(FOO)$($(BAR)))$(BAZ)
> + * this helper evaluates
> + *     $($(FOO)$($(BAR)))
> + * and returns a new string containing the expansion (note that the string is
> + * recursively expanded), also advancing 'str' to point to the next character
> + * after the corresponding closing parenthesis, in this case, *str will be
> + *     $(BAR)
> + */
> +char *expand_dollar(const char **str)
> +{
> +	const char *p = *str;
> +	const char *q;
> +	int nest = 0;
> +
> +	/*
> +	 * In Kconfig, variable references always start with "$(".
> +	 * Neither single-letter variables as in $A nor curly braces as in ${CC}
> +	 * are supported.  '$' not followed by '(' loses its special meaning.
> +	 */
> +	if (*p != '(') {
> +		*str = p;
> +		return xstrdup("$");
> +	}
> +
> +	p++;
> +	q = p;
> +	while (*q) {
> +		if (*q == '(') {
> +			nest++;
> +		} else if (*q == ')') {
> +			if (nest-- == 0)
> +				break;
> +		}
> +		q++;
> +	}
> +
> +	if (!*q)
> +		pperror("unterminated reference to '%s': missing ')'", p);
> +
> +	/* Advance 'str' to after the expanded initial portion of the string */
> +	*str = q + 1;
> +
> +	return eval_clause(p, q - p);
> +}
> +
> +static char *__expand_string(const char **str, bool (*is_end)(char c))
> +{
> +	const char *in, *p;
> +	char *expansion, *out;
> +	size_t in_len, out_len;
> +
> +	out = xmalloc(1);
> +	*out = 0;
> +	out_len = 1;
> +
> +	p = in = *str;
> +
> +	while (1) {
> +		if (*p == '$') {
> +			in_len = p - in;
> +			p++;
> +			expansion = expand_dollar(&p);
> +			out_len += in_len + strlen(expansion);
> +			out = xrealloc(out, out_len);
> +			strncat(out, in, in_len);
> +			strcat(out, expansion);
> +			free(expansion);
> +			in = p;
> +			continue;
> +		}
> +
> +		if (is_end(*p))
> +			break;
> +
> +		p++;
> +	}
> +
> +	in_len = p - in;
> +	out_len += in_len;
> +	out = xrealloc(out, out_len);
> +	strncat(out, in, in_len);
> +
> +	/* Advance 'str' to the end character */
> +	*str = p;
> +
> +	return out;
> +}
> +
> +static bool is_end_of_str(char c)
> +{
> +	return !c;
> +}
> +
> +/*
> + * Expand variables in the given string.  Undefined variables
> + * expand to an empty string.
> + * The returned string must be freed when done.
> + */
> +char *expand_string(const char *in)
> +{
> +	return __expand_string(&in, is_end_of_str);
> +}
> +
> +static bool is_end_of_token(char c)
> +{
> +	/* Why are '.' and '/' valid characters for symbols? */
> +	return !(isalnum(c) || c == '_' || c == '-' || c == '.' || c == '/');
> +}
> +
> +/*
> + * Expand variables in a token.  The parsing stops when a token separater
> + * (in most cases, it is a whitespace) is encountered.  'str' is updated to
> + * point to the next character.
> + *
> + * The returned string must be freed when done.
> + */
> +char *expand_one_token(const char **str)
> +{
> +	return __expand_string(str, is_end_of_token);
> +}
> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
> index f0b2e3b..2460648 100644
> --- a/scripts/kconfig/symbol.c
> +++ b/scripts/kconfig/symbol.c
> @@ -33,33 +33,6 @@ struct symbol *sym_defconfig_list;
>  struct symbol *modules_sym;
>  tristate modules_val;
>  
> -struct expr *sym_env_list;
> -
> -static void sym_add_default(struct symbol *sym, const char *def)
> -{
> -	struct property *prop = prop_alloc(P_DEFAULT, sym);
> -
> -	prop->expr = expr_alloc_symbol(sym_lookup(def, SYMBOL_CONST));
> -}
> -
> -void sym_init(void)
> -{
> -	struct symbol *sym;
> -	struct utsname uts;
> -	static bool inited = false;
> -
> -	if (inited)
> -		return;
> -	inited = true;
> -
> -	uname(&uts);
> -
> -	sym = sym_lookup("UNAME_RELEASE", 0);
> -	sym->type = S_STRING;
> -	sym->flags |= SYMBOL_AUTO;
> -	sym_add_default(sym, uts.release);
> -}
> -
>  enum symbol_type sym_get_type(struct symbol *sym)
>  {
>  	enum symbol_type type = sym->type;
> @@ -1401,32 +1374,3 @@ const char *prop_get_type_name(enum prop_type type)
>  	}
>  	return "unknown";
>  }
> -
> -static void prop_add_env(const char *env)
> -{
> -	struct symbol *sym, *sym2;
> -	struct property *prop;
> -	char *p;
> -
> -	sym = current_entry->sym;
> -	sym->flags |= SYMBOL_AUTO;
> -	for_all_properties(sym, prop, P_ENV) {
> -		sym2 = prop_get_symbol(prop);
> -		if (strcmp(sym2->name, env))
> -			menu_warn(current_entry, "redefining environment symbol from %s",
> -				  sym2->name);
> -		return;
> -	}
> -
> -	prop = prop_alloc(P_ENV, sym);
> -	prop->expr = expr_alloc_symbol(sym_lookup(env, SYMBOL_CONST));
> -
> -	sym_env_list = expr_alloc_one(E_LIST, sym_env_list);
> -	sym_env_list->right.sym = sym;
> -
> -	p = getenv(env);
> -	if (p)
> -		sym_add_default(sym, p);
> -	else
> -		menu_warn(current_entry, "environment variable %s undefined", env);
> -}
> diff --git a/scripts/kconfig/util.c b/scripts/kconfig/util.c
> index c6f6e21..703ee49 100644
> --- a/scripts/kconfig/util.c
> +++ b/scripts/kconfig/util.c
> @@ -34,8 +34,6 @@ struct file *file_lookup(const char *name)
>  /* write a dependency file as used by kbuild to track dependencies */
>  int file_write_dep(const char *name)
>  {
> -	struct symbol *sym, *env_sym;
> -	struct expr *e;
>  	struct file *file;
>  	FILE *out;
>  
> @@ -54,21 +52,7 @@ int file_write_dep(const char *name)
>  	fprintf(out, "\n%s: \\\n"
>  		     "\t$(deps_config)\n\n", conf_get_autoconfig_name());
>  
> -	expr_list_for_each_sym(sym_env_list, e, sym) {
> -		struct property *prop;
> -		const char *value;
> -
> -		prop = sym_get_env_prop(sym);
> -		env_sym = prop_get_symbol(prop);
> -		if (!env_sym)
> -			continue;
> -		value = getenv(env_sym->name);
> -		if (!value)
> -			value = "";
> -		fprintf(out, "ifneq \"$(%s)\" \"%s\"\n", env_sym->name, value);
> -		fprintf(out, "%s: FORCE\n", conf_get_autoconfig_name());
> -		fprintf(out, "endif\n");
> -	}
> +	env_write_dep(out, conf_get_autoconfig_name());
>  
>  	fprintf(out, "\n$(deps_config): ;\n");
>  	fclose(out);
> @@ -165,3 +149,14 @@ char *xstrdup(const char *s)
>  	fprintf(stderr, "Out of memory.\n");
>  	exit(1);
>  }
> +
> +char *xstrndup(const char *s, size_t n)
> +{
> +	char *p;
> +
> +	p = strndup(s, n);
> +	if (p)
> +		return p;
> +	fprintf(stderr, "Out of memory.\n");
> +	exit(1);
> +}
> diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
> index 045093d..b385590 100644
> --- a/scripts/kconfig/zconf.l
> +++ b/scripts/kconfig/zconf.l
> @@ -1,6 +1,5 @@
>  %option nostdinit noyywrap never-interactive full ecs
>  %option 8bit nodefault yylineno
> -%option noinput
>  %x COMMAND HELP STRING PARAM
>  %{
>  /*
> @@ -35,6 +34,8 @@ struct buffer *current_buf;
>  
>  static int last_ts, first_ts;
>  
> +static char *expand_token(const char *in, size_t n);
> +static void append_expanded_string(const char *in);
>  static void zconf_endhelp(void);
>  static void zconf_endfile(void);
>  
> @@ -147,6 +148,13 @@ n	[A-Za-z0-9_-]
>  		yylval.string = text;
>  		return T_WORD;
>  	}
> +	({n}|[/.$])+	{
> +		/* this token includes at least one '$' */
> +		yylval.string = expand_token(yytext, yyleng);
> +		if (strlen(yylval.string))
> +			return T_WORD;
> +		free(yylval.string);
> +	}
>  	#.*	/* comment */
>  	\\\n	;
>  	[[:blank:]]+
> @@ -157,12 +165,13 @@ n	[A-Za-z0-9_-]
>  }
>  
>  <STRING>{
> -	[^'"\\\n]+/\n	{
> +	"$".*	append_expanded_string(yytext);
> +	[^$'"\\\n]+/\n	{
>  		append_string(yytext, yyleng);
>  		yylval.string = text;
>  		return T_WORD_QUOTE;
>  	}
> -	[^'"\\\n]+	{
> +	[^$'"\\\n]+	{
>  		append_string(yytext, yyleng);
>  	}
>  	\\.?/\n	{
> @@ -249,6 +258,58 @@ n	[A-Za-z0-9_-]
>  }
>  
>  %%
> +static char *expand_token(const char *in, size_t n)
> +{
> +	char *out;
> +	int c;
> +	char c2;
> +	const char *rest, *end;
> +
> +	new_string();
> +	append_string(in, n);
> +
> +	/* get the whole line because we do not know the end of token. */
> +	while ((c = input()) != EOF) {
> +		if (c == '\n') {
> +			unput(c);
> +			break;
> +		}
> +		c2 = c;
> +		append_string(&c2, 1);
> +	}
> +
> +	rest = text;
> +	out = expand_one_token(&rest);
> +
> +	/* push back unused characters to the input stream */
> +	end = rest + strlen(rest);
> +	while (end > rest)
> +		unput(*--end);
> +
> +	free(text);
> +
> +	return out;
> +}
> +
> +static void append_expanded_string(const char *str)
> +{
> +	const char *end;
> +	char *res;
> +
> +	str++;
> +
> +	res = expand_dollar(&str);
> +
> +	/* push back unused characters to the input stream */
> +	end = str + strlen(str);
> +	while (end > str)
> +		unput(*--end);
> +
> +	append_string(res, strlen(res));
> +
> +	free(res);
> +}
> +
>  void zconf_starthelp(void)
>  {
>  	new_string();
> diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
> index ad6305b..3a4a0fa 100644
> --- a/scripts/kconfig/zconf.y
> +++ b/scripts/kconfig/zconf.y
> @@ -534,7 +534,6 @@ void conf_parse(const char *name)
>  
>  	zconf_initscan(name);
>  
> -	sym_init();
>  	_menu_init();
>  
>  	if (getenv("ZCONF_DEBUG"))
> @@ -780,3 +779,4 @@ void zconfdump(FILE *out)
>  #include "expr.c"
>  #include "symbol.c"
>  #include "menu.c"
> +#include "preprocess.c"
