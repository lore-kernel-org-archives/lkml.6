Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E50FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04132075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 04:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wo8MC+Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04132075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932431AbeFUEsc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 00:48:32 -0400
Received: from mail-eopbgr680049.outbound.protection.outlook.com ([40.107.68.49]:20452
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750810AbeFUEsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 00:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7AnJ5+lpwcrecuwXy8VbjWTlNzF4eEhn8QZnmLnPS8=;
 b=Wo8MC+BclrC1k7lbENPzRbVgWy0vAJ/JcGqA5NlL3fOFiPg+HHeCvEzQIeNvqO0ZRp16+ec5etwqDPNt/8dSJuUEVG7L6MgPRrzu7RNcK93TM9xSpM+XJ/MedlrA+S60rGDMJOKrI47FiJvL1Nq/XlvZ2UJT7rEVzfwMe1Bxm4k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.129.24] (202.56.249.162) by
 MW2PR12MB2364.namprd12.prod.outlook.com (2603:10b6:907:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Thu, 21 Jun 2018 04:48:23 +0000
Subject: Re: [v2, 2/2] ASoC: AMD: Configure channel 1 or channel 0 for capture
To:     Mark Brown <broonie@kernel.org>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1528354129-5023-1-git-send-email-akshu.agrawal@amd.com>
 <1528354129-5023-2-git-send-email-akshu.agrawal@amd.com>
 <20180620140257.GG6242@sirena.org.uk>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <d3c0ff79-e2ae-a8e9-5e58-8ab003364062@amd.com>
Date:   Thu, 21 Jun 2018 10:18:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620140257.GG6242@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::25) To MW2PR12MB2364.namprd12.prod.outlook.com
 (2603:10b6:907:8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 722d9efa-81b7-42da-e890-08d5d7323a59
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2364;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;3:PHznMvNmcUFD5Y1YhTiWZpOCa4qa97eFAI20X2Ljg9PoB3w93+SWQW03b8kk82cav62qS7JzWCcjnyMqqtMwpktp1AFkCNwI1iFdCjB4Q9VAZdRNbRcavO/U+KThgfkwJFmswMJYFJD0uhGV/NSernZs7qEDlQBTOCYQE3Qz5HphprjopSl3WhAWb5/9Co+krIdDz7NC7+BNoryiVdO8lr9EvYNW2HmV9Aj4IsxsYbH1fblEa2ACsmjD02sR9Q5j;25:PQpbkQUnkbyQKH9nK2HoFabAWinjCuA3EHT4hRFTWBFaQAj/pbdVAIJ+BvrHpDb9rKESyXMEf+wmaK+dTY1oY/S7nLGtLIbrZzkIfuuI+rSxDg1anD9agjKfAUOMY+vNVPAv/iBN+eqcwXoCf+IzyLeCsy3WNx2Jn6dzLO4x98fqdpOIX0EuVxKKr70JBL6XqPXmCmiqEXK0q6CleBCQa3hD32TAuhxsLT9TKNxtHlfXCjRBOitXulXShgXredSchp40yM2K6jRcBlHK7jfjBWw6+u+polW3PKNmyEY0RiRVeME2S/SEnreSnnPTeCB5zMgT7iuzDEyPr0Jl3e4XMQ==;31:V1hchIGW5sJKrO0TsW+0Gbru951EKw3lTT+8vg+5UzdRGGQpnaAAal1nqdOXIx4oEBADr06hLz83oxhxXrcIC8LdCPU7eJMyMU98yhd2f12ey2/iRGZp3zuYPT8Saq2fdUmJC3wCxGwv8fyyQ8fa4AuQ4tlF9clg9VFdcLV4wkwaEHl/5VJKqBlkgpUTx1jLiAUDvsQEksMptPRJdReNFiTqKiXmzLV7h5zesW9fu8k=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2364:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;20:CYIwtcpYWBJ6vCVJxJZ6oLdUZS3oR6T731zte1Zv1uSiVayYQCukZK51IPo6WD97MyDXsZbTfPNSFE37akIhKga4gCumZnh+9TuTxyAXGoW/omLzdWI6XBbV4IgSi7Q5+RHYu8AKKAe/DPulZpEJdrcqmBnMu18/ytRydck9bgyhukDBWuGXuMwcXep8CtCAlzxdCx9/iEHbKaWWU4h5prt8sB5TPkIoe37cRx/115NU73BND5Shnd5x8DQtfrX+3yFLj1I52hWNIpY5lV+GAPmvFf9u/yjmbURxBs9B8XJTG4jD0YynD4N1/J5VnreHTJQC5wjDFr2w70PRWBB/jgGH/Za9fL++f36TtwtrQvOhE1s5+n98841Xi0OZn35+wwkL9PZqCuc1L1zh4lcoX9FVkGmXIIzSrpHVCfsMlt+Y0MbwX5T0FKOK4RMWCZ3xUoK0gdsMV5dQuBp5mD0c2zCyvvF9oMyy7h0GwCwZBWgKcKTHx50QGC+HFt38CxZU;4:r/Aq1Trj8XJer0b4e+jB9BtLr38UGJWwgn+COgq0r71nzW3SjAXc59K14bH9tAbrIge+JOkkv4I8Mj87S4ZBv+R+00oFwxcma9fy3oCPCtYHtcpPJuztnH4AZpFOTCkZExJATly2nZ7Iau1dTT0jsHXnqsjCwnrcraZS3a1oXxgqVv58cHn8QdCKK0iVPLyGnd1MRmAUaJ8XQieORxH5uZPr6kNumzmbugp34DNJnrQNsr46ENnJNUwrOcHdqkvVNByAGiyd7Z/5O532YY/6pg==
X-Microsoft-Antispam-PRVS: <MW2PR12MB23643E81661CDAD9BD85CB67F8760@MW2PR12MB2364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2364;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2364;
X-Forefront-PRVS: 07106EF9B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(346002)(396003)(366004)(39860400002)(189003)(199004)(81166006)(25786009)(6246003)(81156014)(476003)(966005)(3260700006)(446003)(486006)(2616005)(11346002)(47776003)(956004)(68736007)(478600001)(72206003)(58126008)(8936002)(39060400002)(53936002)(97736004)(16576012)(54906003)(4326008)(66066001)(386003)(65956001)(316002)(65806001)(7416002)(105586002)(2906002)(76176011)(59450400001)(53546011)(65826007)(23746002)(52116002)(305945005)(106356001)(230700001)(64126003)(50466002)(6486002)(36756003)(77096007)(6666003)(16526019)(31686004)(26005)(7736002)(6916009)(5660300001)(186003)(6306002)(8676002)(6116002)(86362001)(229853002)(3846002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2364;H:[10.136.129.24];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MW2PR12MB2364;23:CTiIY+nYjzF6Yqrug6W5K5y5URMkSqohnLxSZ?=
 =?Windows-1252?Q?silybWRnALPziEwoUE7cLvUh38GQNBH6JDZ1ngoMu0WbynuybOAr4HxR?=
 =?Windows-1252?Q?GBWyQjt6p/Ck1B6bxeXbAvPUX7uJ1ksnyx+tPtm4iWxI4780NVDcDKf8?=
 =?Windows-1252?Q?AXpNzOCal8vRR6l+9qBXuQ3DrMU97qb9p6HNc+fOjQqMaw/+xPwJpdPo?=
 =?Windows-1252?Q?T8lsuG654VZUcVhTRbf6YYh3HrZeyEZ64fht/nip0UmnakbNrtyon7Lh?=
 =?Windows-1252?Q?lxk7+EOTSyNekP/yPxhKnRScJxONsT/g0ymlBhoNGJRbA8LEoHrM0p6e?=
 =?Windows-1252?Q?6+A7Wu0PpDDe/jlD4SP8oyF3R47XkQlVT4OD+ZTylM/IIFpLVCIFdsbc?=
 =?Windows-1252?Q?pjRCvk6zjpK3Q6CfpuLSmc5WzrG3k2NvW2bsCQ7fmeHu2FxAQeDmmXfJ?=
 =?Windows-1252?Q?b8MzeY4CkEUjABz6vOyvxPYNQ1FyOYBRqTIRUiqsuySEVOtdjk2aW+El?=
 =?Windows-1252?Q?WcbrZW7UlbJADVwY4DWpsJ5qJxhhzjYQ2ou362InLbHj9qR7U8I74rP8?=
 =?Windows-1252?Q?VCJbzpn3JCLrx5rrUmQmpNtuhkPqAHgaKvFZSG57VZfUk56eYrWBUKVP?=
 =?Windows-1252?Q?ediF2bQk4KodyzTMZUeBNxdKcd+pJqgO+VaVhn0QXp75aNrncg7G417h?=
 =?Windows-1252?Q?mICv+DNr7+dCV4sv5NTcHE6EFGY50Q4v3eui2N6Z18mOlM1OpYTHza2Z?=
 =?Windows-1252?Q?j6VBO9HjdAUraH2rlQnwHfcWlrSEQrGxDlweI/n9Vx7nT9qYSLPxMM5Y?=
 =?Windows-1252?Q?VVdjT/ojh1/Qf2or2yqIzfrI1w+4eBQIhMdAWiwM+ZW+I2oHltk3tR2c?=
 =?Windows-1252?Q?RHckjjsXrVVLZ4zgmG2wW45jCMvmGPvx8ZY+ePmT2SUvQS7KQqR7Pln1?=
 =?Windows-1252?Q?MU6jaqG8JMNY6CAk7jJx8ckNGX/H6+HUfqL6qmOYFRRcG4gCQwrs3EDk?=
 =?Windows-1252?Q?/KYUmu2XBjXUSDOAgfeZSyi4k7d+AA3/MKoftrFjZuLNam5ieYjpjzdc?=
 =?Windows-1252?Q?Vj2dfYk3tGnLwyss+wWgkt+Ozt3xupARELNWK3Se60iaBQ3FQs977k+X?=
 =?Windows-1252?Q?mB0MKLAaX69M1H0NgbnPeHxvysl7LIL2Ho9xOpz25t+0fL62EjnxnMOd?=
 =?Windows-1252?Q?YlfXUPZes1QYUfDO2HHzM5qBK/R66E7sYOSBVZOD5tAT4ppfdLL9sbdl?=
 =?Windows-1252?Q?l7hr+WuswrC7CrDdGt9l7nHIs0aPto9O75iFSiyTw7wOtvWDvrc9wSBv?=
 =?Windows-1252?Q?5tip05mj5kaH5gXkhmK7A0Hbequ0Bl/Ckr9jWdKDYnOT32sw9meR7pvj?=
 =?Windows-1252?Q?ICa+JowC6gBmshsQ4VEAKtrEfsUFmaQWvYhUTIhvLkXzXQumFoF/fzl4?=
 =?Windows-1252?Q?7M1lKr2Gaz3zeZT4Jf1h3sRlgN4tZg35t1L0938zIXpayOPXbPelBAfK?=
 =?Windows-1252?Q?lRx8SD3lWZaJABacV0Bp3bAKwfGJ/2b0bFKEShh12C226FbP1RYT+ymH?=
 =?Windows-1252?Q?oFQU+wo8PCFs/VK5JH5vd0V7/pf/vSz1SeSOEkrtmkM452NrGhzb1zWk?=
 =?Windows-1252?Q?3qvbO+WDfQOoFWMoAhTrMjeODQ2oF3wjDOgiy2vk6f40tb2vrjaU0KqN?=
 =?Windows-1252?Q?IN/yXpnVw=3D=3D?=
X-Microsoft-Antispam-Message-Info: MOFexGSZQBwAAusmYk9dLzNdDVR/F0N4wPawkevjPv+xy1k5huBUMZdgBuF3pkP7jHSzn4aAfvUV3RyI/6tRqIMQd48AtbjBGiYQxlFlu0w1rVzELSLNM3OyHwzmhFM4AsCNyURHTbmCsI+Pb3oeZOPHEwPF+nTxfc+0YPyNxsE1cZaxC1s/2ay/7zmaZdqMwNMWa9+n6m57aMLD9u/43CQsuKAy8JEtpSqfkY1OxD860tZfH23p0Py3uRqKDe3Y12oWUa1ZBmmC/Db1PViVLs0qyuG2pkj6aNpoegHqlmGFHJw9XSRxtpRw6fbZkd5L
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;6:dQw1YMczRiGW7tqRuqb+yYZIMdMB/ab67Ff7KPELdgElnpqVq4SXgghjNCPze9HbDvedwhl49w2qaW3hGjkl1PizPJE2tuqFmvDkGCsQ54lhlD4huIq2w+VjTwaf/p5yb9OZzNrZTZY0PLZOeDZRRC4nAd7WoZTOLq3/IzUm332/7pQUJFvNaN7J3fBgGBFZYxoIod7ATxyzKa8N2wnJGIc/QdU5AGcobD8M3vvpcnK9bBCoXKM2NJi0ipyyiisq4UZSsalQcw+HSrCJ52BauvBSeHCXQqpavdevDPPs4a5xisu2+AexXSd42Hhayk6n1+Ek87YI05Wt/b+e0sbaMrZwKF7qCoTb39mFcScG2trDt7Plv1fMBoyI4CCCawGNPOkhiWURhpgf+37Zk7sG5xEVcqgGTwSMYEyoVU4S6eA3SWRUVokhKXhAVCFRA4pc0Ju3hpvjteZLEtSTbW0Ezw==;5:uWL0SFZaPtJ7u+T9vj0HjUE7FEhEo2Lgi/7j1NBt+L0Yo4/UefHi0fyEe05V8hzprlt+2/PKULpx+1Z1lWxqJsiW9H3dTW+ZJ6PoUCjUjHfgHfqR6FtWoNGlUMeX9gesg73wIKqs63JzoYu0CG3vOvGi+Lir6HYx64Z5cab9Ofg=;24:wPE2U2dojZD3cfOj4HFkFFODM/J7mZ4KL52QnbxeQFxT3J3ULrqo9beQUGSrTALKT8uQMvzzjFt1GTW08qRUmO1AFQ5ejqEvUnCkcH4Xg+o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2364;7:kjj9uaQVPbuXxrkfKCwMhE/wxu9wpz01GOQl7UEzduHdpoAPns6ymqzvX5F33PAfTVMfcUgXfu4VWFdqEAN+4dFMxE5oNvcmqLsXaMQecVEeP1ELl88f7qTvaS4pcGthGFxfxDxyh8NisgT8zg4QXT7pWs/3dmnzMlAFz9uh3oi976MzcIIu2M4x6uMNv+twUiCyq7I8OBlLo//entgeJ21KYN0lzPWG52QxgWmFft1FH+OojtaD0iiiT6A3YBmY;20:ia5HKmjUSV9CleRr+GdsJDZfmsaJ0fMSyQ3vo9XSlNAi+XJEM2bEX9O5tkPbIZE7uCEavJgtGB1USB1XSRJfSIjzIk428D4hfGGdDaeo1LUTJuHIdHIMDAY/DK2cFPFt1MXMhHsjJRXx11p7T0gPUmBriMWGUpnp5uYKde/l+KkyqAk3yW72LFVgBXCcthK9g4q/n4Z7BbZPOWlagIIFEgSRzMuWlpI0synfnnoCSlfmwppHkJjnFpXo1FtWJJ0k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 04:48:23.5946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722d9efa-81b7-42da-e890-08d5d7323a59
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2364
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/2018 7:32 PM, Mark Brown wrote:
> On Thu, Jun 07, 2018 at 02:48:44PM +0800, Akshu Agrawal wrote:
> 
>> This patch is dependent on ASoC: AMD: Change codec to channel link as per hardware redesign
>> https://patchwork.kernel.org/patch/10388099/
> 
> Can you please send a patch series with all the pending changes for this
> driver?  It's getting really difficult to track which of the patches
> you've sent fit together and what's currently pending as there's often
> quite a few different AMD patch serieses in flight with interdependencies.
> 

Sure, Mark. There are just 2 patches remaining. Will send them as a series.

Thanks,
Akshu
