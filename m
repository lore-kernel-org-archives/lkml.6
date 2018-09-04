Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B177C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D6520843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="LQnKCItL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D6520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeIDPdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:33:55 -0400
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:54352
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbeIDPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkBNlTe0iH2j4fSVaIxkknQpdmpI7s+EYcpv3KLaa3s=;
 b=LQnKCItL4EeHkWlCSRJL0ynOi8wexO7I5/IzrJOtKaDbiONerqNoEvSMxbCVoGLQwW7BjLzCRxKNUz5SckZvwg9YbjweR+7RjaRA792pXwIGuHh0GJWah2YHZV4qDwHKRUCxdfdVVts7AQRYX7/AKiWdlihXJ41y2OvrsotkLB4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com; 
Received: from localhost (95.104.163.45) by
 BN7PR07MB4372.namprd07.prod.outlook.com (2603:10b6:406:b5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 4 Sep 2018 11:09:10 +0000
Date:   Tue, 4 Sep 2018 14:08:59 +0300
From:   Yury Norov <ynorov@caviumnetworks.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] linux/bitmap.h: relax comment on compile-time
 constant nbits
Message-ID: <20180904110859.GA4992@yury-thinkpad>
References: <20180818131623.8755-1-linux@rasmusvillemoes.dk>
 <20180818131623.8755-6-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180818131623.8755-6-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [95.104.163.45]
X-ClientProxiedBy: AM0PR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::29) To BN7PR07MB4372.namprd07.prod.outlook.com
 (2603:10b6:406:b5::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c0d91a-5f2f-431e-843a-08d61256d746
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4372;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;3:ReBYmya0/+HiOC0GlwXwXwp8SNDosnXw+KnjtyU7vyxowMxOe6n+yByTjiwYbQQ9jPpFJvh44IpsWBEDJ3vmZ69t33y749Sp0yfXgjrMeWoz1RiZ5t7/fkN+DGuBiZSUJLbmXEdT3DhiszaiHNQdOS5/KDkF6R2UNJUdUk2D8zp8piUL2Q32Nj4I81r5WEiWn1YkHqFjxm/J3Wgq09zfJ8hra5SwuPFHLesnoitSiWqSVzLtWcHWLpk0MJwxg4/E;25:ILnJG24YdeD6PE+Fo/hELTiFKSDUFSTf0Cr/J9cxR1gl8OFRyzsUjK8vqp6W0z0a4B1mPx9+4m4CKNjVOys0LfqgOG+zrVjRVfWZOw/UbkASwnJGPZ9XImrHI4Aa3I6AxLfbkC+5DzCOKdgs7ToH3V8zvYzDE70EebkdvZzsZBVJYVQ929D08iNEXIdtcxd3X9eQn5LT6nJAihivpgclhnBzfk4v+eN4zMA2d3wV5PsY+RnNYTTtUGWWRWNNBRLc6dRux2tUGqf9afDjTiKbl6wl19QHcqYGmJV91JZOFDFf8UiXQdL+LoPNsFfA8PhvuwzSmQSzqFncR1e681oQqw==;31:4BvOUDF7l3sudob/prWlDaMnssY+T4DShYwgKgpMOfgsYNnePuWrAXoeT40bUMvTtglNhkndGPaF8tHvZeins2XEK8sA7uMFk9YX9azHLIsQGTJa8s5TTxzKKdQlczKA6UvGEDexV6LHVUqIQmtUJxpf1f+06KKJTahvCtpMsnv9vP+8MGQJnTdAMzrySyPhvRAXx6X9cwXicVgIjpKmLlddqk2MG5o2dXu7rTWQUo8=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4372:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;20:GeGulo/REktQOL4p0yBNTW/nriC7blHyQ7XDwhtDcmvSwjrvmbfv14l/Kql6LNjKRaPrNC9UBWYVASUU+t4OXF8k5o3UGokKjlbltNTlt4KCaVRMyqEhOEPQtnMRueUE9mjfOWCGXWOEQlDuTPoRm/c5qLSjM1IzUHL9eDQX6mz+fWtxy223s6r+ii89nzKDdI398fX6UurCjk5KKHL/iHlie9kVOL23czEaNSEgvE0rpUBaXz/kMP3dQWe74DTuXGwdb8ek/ZhuPX8taJGIxkBe6/EgkQOwjA0L3iaMiQaEoVaq6RGUd0O+bTNy0uEsHRDI6vCRsnnWQ+thu/paSmzB03/6qeiWZI/NUt0p7csYvegtMzPluQxb/J3fvRiDwg09fHTdQZR8ajtU5Z6U9m+f9z2L9aZQHBLRzWU4k6iTec4gsxZHRKmNs+VH48cj/18EGxhSMPumT6wIbj4GSTwEB20aTD/+43XLuxtkFgYXkAL6GuXuECv4u7HaQI+KeHGvDl/ilTaW3Cy3qSrn3r7UdjTGOVHplBdMrexGcnv/K6SDUSbwI+hVWeXdcR9SB7m4mWEwPRRLbQ+4gIScnQIbOS+XW3nAivRkRhgALy4=;4:SgxWNHIUO1m2XUZ/woYNj2J5FP2TgKDPTwN1FjCutjvyvCgg9rgEKESMFKv+mt/sbDl19wA8OXEHF0ay9KBL4Wd4fBZnpoQ/BxKT4fx+1aKsRsx5r4LNkhJ+Ob4d457FAcNWNRyLNyF1gSEtTa2oQcBGKbW96pGoJ4Wv7siAsLlSN/eNngWypaPpRFkufujQbbT58R/D5vApWq/jg03llVxPDS+KBNJTHsrJTI3q81Fq2/xZ9tpqCzrsxuEx5ofvvBYtaNmnTOVpl+tCOIfJNw==
X-Microsoft-Antispam-PRVS: <BN7PR07MB4372E058392AEB9D7ACB0736E3030@BN7PR07MB4372.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN7PR07MB4372;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4372;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(478600001)(5660300001)(58126008)(25786009)(16586007)(33716001)(2906002)(54906003)(4326008)(316002)(575784001)(105586002)(72206003)(81166006)(6916009)(81156014)(50466002)(76506005)(66066001)(68736007)(6666003)(7736002)(6246003)(47776003)(106356001)(33656002)(486006)(446003)(8936002)(8676002)(305945005)(9686003)(26005)(52116002)(956004)(11346002)(476003)(6496006)(53936002)(42882007)(33896004)(229853002)(76176011)(6486002)(16526019)(386003)(6116002)(23726003)(3846002)(97736004)(186003)(1076002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4372;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4372;23:OX6b0LlIQ4kyiDM9KZE862gRE0lfS2aon5mAhmNK/?=
 =?us-ascii?Q?H3dOZ4HMYo9gASMNu6q1zpd0cGu/dgNmZph0y2U3cfEO1170z6JrnY2aKoZQ?=
 =?us-ascii?Q?AgQKT15pG//eoF/3+kNLx5KZ/afnIQX6YDdP0kjzggmlg3vhZEI3jRbtJrMl?=
 =?us-ascii?Q?jqULiPSk1TgWgzUsT0z+5Vvm1ZGnAnGx7kIAaobSwPishcpZE+9i6Iao5p4O?=
 =?us-ascii?Q?xSozfM35EsmiKOi9cSuKXUZxNWIHyc0JnSyG3g6iOlONpN+V5//EwMs9aJb6?=
 =?us-ascii?Q?eaRyvV/auL7IMIyfOzJQmGOgUXhO0Ow/SYKxaPlL9BiEn5YposqZzDDWYFzF?=
 =?us-ascii?Q?enBm1gRN6K7UG229qfqu8e4TFKerZ/OolTVEigqwajq1UxAGg8Luj0w/V51d?=
 =?us-ascii?Q?T8JvkTxE9Fyxrt3o3IRrongK08FK38BMyllFYtTl7Z8kAxeoXHiiB9SjpQ6l?=
 =?us-ascii?Q?hYYcaSSPIh0WI+0u9GTgN5vw+D/CnkvpyQIWM0YlOjEeTnVeTJcUTQvfj4xV?=
 =?us-ascii?Q?tSu8LlGbG/1CuSif+Cmqi0l8vuvT+fyPm7xb6dqv6JiaVh9aTXaH/48Kj8oR?=
 =?us-ascii?Q?2VN8JPUqftH4ifT2sO9uAdCG9ytLcIQcAsqOr/ehW3eVVnltcTzOAXODi6YY?=
 =?us-ascii?Q?HjhX5at8om8JGPJEJjd4FJpdBQLYt/fEh8NLtrNtVpeaDx1mOtOPSoV/aMqj?=
 =?us-ascii?Q?54FhXbsNHQCgQXXSfDqU1/FHBSsZYyW+fcZJm7VuRVR8OOPdyeWJP3SePdGe?=
 =?us-ascii?Q?ZnFbZEXscD1W45ywF/k8QSuGUQkXOWM38JMEXWoiq700LnLxYWwJPX/Va53B?=
 =?us-ascii?Q?BEua6I43/NbpM/MTrtmPEkiT2vq5/KONssu/qhtVrbZFFBVjAQ/B4CMaeAHY?=
 =?us-ascii?Q?WjfGYwQfmWrTWTdDDKaqzOaXAu4K5V9eMsZK7SnGwZrAW4kfcltttd5GguPq?=
 =?us-ascii?Q?bKzB/eDd6HQbqHdIJTZCfd05MZfkbV/wKVsCYEDL1wFlF8w49xuOw9W2M9+U?=
 =?us-ascii?Q?NrvjqWWVU/jE/nk+rMSzpqsSdJMUqyUr0qFGQnupsSAvzlfKkKwCHjeQkL1D?=
 =?us-ascii?Q?lPSMMnYgaXEPEiAjKL3PEeXu7E7lss4jUoR7k3ekgjdqvwTJKmv9uEXj/RMv?=
 =?us-ascii?Q?rOkDgwjIBXAv9T1qyekubzQV/bqbm1rEgrboilNo1RfolB3J7xWmyysimG1U?=
 =?us-ascii?Q?6BKfsgJ/yal3eBroKCXF4SylJ4bIh+9SrXl7lHXXxl+GzLAFA8KxH/Huf+oQ?=
 =?us-ascii?Q?QMMRemJjW/EnVSR64uhxaTMIn2AmU32ZW+ZB5ljMuV70aiMM+mNuKhp8DDiK?=
 =?us-ascii?Q?SD7YiMv4Fv74IK2fzN4/UohcMmMllG5MS8Lbapw4lg+jlhBrc3yh+r0kRa78?=
 =?us-ascii?Q?zJml56YQ30/9KAtx+jcBpnB1kc=3D?=
X-Microsoft-Antispam-Message-Info: uI7NxNVYi5J+ZqsfbNUKPsNH4OQjhgC8Wp7gb85WO53n+DeGCWgeWVWm9JUZNKpXXGnAtYZMRI+DCtNZI1D60uD2HMuWSJY65kbGKZla/xvnF3pTOLrriLkBeTQZf6bgpHHeEeQvo45KHvhgC2LC1t8NAYPGbj0Z4DqPYZZyjnS/f2LHM3P1ibLQ1/y0g9ubKPGRSO+4syzvpE93P9by/1/00oKwc9bxEpvxjECzmiqvX19rp+Y/r5zKJlN+Y+H4Q5pVdLJLfV5hCPtOxwBIDt+T9ghGF6c0OjBPZ2e2x5R8m/9MV2cFHsnBPj4FbwmM6Nxr1BEnOvyM6DM66Qx5ipsTdaz5EbPOJ7LApE5QWhw=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;6:zKQRYyeglXj3D3ddXr87yXea+zZpNrcPodfP+D93sM6CxRyhod48/s2xVqbhdlkP7CDImLeDiKQ3juf4lQQ3qRAlvETNKb9dGEUARbxqu9wMVLkO2krSiavW6HUBJCvZewm7qUpda7VFkCrtAJrphEf+xzJS5Lx2UCSaEz7DHcFjBMKYwpy6575wa515XjXdFM1fIbhXQxBG1yVzancEB7QJYMj22HqnoHBvVxffqtvWWA+01d61oMDt1+aAdf8b2qkOukGdsVJmJJTVRa3/w7ooDo6IQ/+pzzxS9/D7hX3WffGtBVrmbP9VDkonzt+CkRVSJ5olqM/aEbVdH2JKZPqTtJw8bbcouWVL0CnjyUc2Rf85K7PUXgShg8EyWNUrsDW75I3RiiXaGGkDAkxqwOnHuP3TJcKxYk2rzQ9KWMLmLJEIhXxaDJaFIqSPNutIjwnonKSZoSb+QfiVyQ7B7A==;5:KyuXCeCPThKoF+duw8DmYwMpgdsMsVlJzR6CfNXbetjdcbR2BQTElX8hEmSz5E/9VFEOMGf5wPm0Rx6UBNHIeCfWZEW4BP4d0pkRjH+LNj6CTJ/HXg3Bv3TTE41yWxk9CuQmd+bbPA3Tk8EHyXA94Oqcp2LV405V18dxeOfneS4=;7:UiOYkTWTtpE3BqUV5cMC9cjCO8a8GrCaqkyykpAu335whk2qQ0XOcO28zOfX6Y7SBdIX62kKjwa/ZToOXRTDq9dnk0JeMVQlfQARuihdv0a/Qi9v/OE+XK89+dn9iioUMlYsgSMkBa6QQUjhN/FfmfzQL+eQlZEsxLnd0pyBFJhWsauuZ4IofOWnVk3nVINMVi2NDoiJkth5+zKZDdkbCiLHlmlWVCIwENsFPkKK/darZ/ua3cnpA6+tjlK5EseE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 11:09:10.4001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c0d91a-5f2f-431e-843a-08d61256d746
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 03:16:21PM +0200, Rasmus Villemoes wrote:
> It's not clear what's so horrible about emitting a function call to
> handle a run-time sized bitmap. Moreover, gcc also emits a function call
> for a compile-time-constant-but-huge nbits, so the comment isn't even
> accurate.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Hi Rasmus,

Maybe too late, but 

Acked-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  include/linux/bitmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index e34c361f4a92..3f0cac3aedca 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -28,8 +28,8 @@
>   * The available bitmap operations and their rough meaning in the
>   * case that the bitmap is a single unsigned long are thus:
>   *
> - * Note that nbits should be always a compile time evaluable constant.
> - * Otherwise many inlines will generate horrible code.
> + * The generated code is more efficient when nbits is known at
> + * compile-time and at most BITS_PER_LONG.
>   *
>   * ::
>   *
> --
> 2.16.4
