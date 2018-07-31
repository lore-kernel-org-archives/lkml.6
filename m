Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F290C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DFC20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gqJMRocK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8DFC20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeGaDHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:07:11 -0400
Received: from mail-co1nam03on0069.outbound.protection.outlook.com ([104.47.40.69]:36896
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729576AbeGaDHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0bONSa0GAQcHr6ZnFIrJKqWlNMpnJHXL/Ee7tfnNwQ=;
 b=gqJMRocKJlfNYPleKvmuKeXdiWYL02kP59PbLKZYgI+e7oxxGl0XU1KVvo3csc/6J1W51RxX4FrIL/dKaHU3b3UzgloZWXiztNNEhAj8BQdZKKFZkZG/UQHZYTQvWbZCfKxfjF42PyfTpaIveizC2tG7ZN+XE9JKYaXOgF1g04s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.224.119.212] (125.21.194.1) by
 SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:25::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 01:25:28 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de> <20180730155030.GP5789@sirena.org.uk>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
Date:   Tue, 31 Jul 2018 06:55:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730155030.GP5789@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: PN1PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::34) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:25::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b9968e1-2e88-44c3-b54f-08d5f68481d9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2368;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;3:i1KqN+B7yIXq7Pz2UCOLje95iQBDH+C1t7BnFQjNfSXIZxqFAfBCNfEFnYeegpksWsts7Icu0z3jdiBRfAfWZLf/gFEZ4pkeYsoWPftZcU+YDgJLy+xyMyOTJCTsCfckti/0FHF2sZdtGR9iqP8c+e7g5uJpvP2fA8n4tnnkgF6Q7QHfLY0sYHOkKJ1LFeDf3219rM17oSAMXR6IWuM75lRyeTBF22fdI/yAiXLm0UP9CT66vvfLehJaT8Z9ORBu;25:rYJCZLPGd6iLykwt7GQ79EUslD6QikNt7dWqSIri+eD6A+PCdawJfc/DG7IqzEUJwAAD7WVFMmed5JCOF6t+Y8pZQWUrd0giyAZruX0ZpytMsBOWqvl5dMYkNVD5fEZw+T44hDqRAjr1eYCstijpcI6NHUMuCra2Yr9iL1vSbQ/MdQChEEq7tMmghzKHvnQD7elr/FjeRMwksTcDlVUJm5tdXvNrdOntnJYf/1j2giT6RfvC2B4E/pBpVHLIjXgBEgLMOuutvFxGQGBwruupBEqcPWc65NvCcG/MwhQ9nscjnoXnEqCtrHc1NGTzZ5zPQfvsMFuwXKVAwEVyg73gWQ==;31:5lfW0dFSKDtcigNMYDgh/7dspjhrMfxM8WO2QJQ+SXMgR15WnbnVfPYvOewQd9Afw/M3P2B37cRi5x0n/QCZmv/uNiV821n4hyi6D408H7isV5KP5Ax5ase4uL0BwCbQBeK63mWjpguiorrGPcqlHNceBjABB4RCLWj2W3yHzsPNs03ERZC83O2o4ZlbRhQfU5oAbKx7NEbL0wBEVLWQfXDpn5VevcZm2j02eE4rk0s=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;20:eWQcCCzA79zP+18vP3YJSWdaLP24Hk3hSIn285rAm2WoGn+uG9GOnymCtYaOiHi7TP3I433xZ4sbAqRj8oOIOThL5TNsLtw1jqarSQ3zEd7zIOauXMkF8G1n2ZvZ2k3TUvKhg4r99GM9G/r027ZC/lOE8Q4xZzvIwQFoeS0nZzxDLQxvlaU6kO4NTccyBYTwbl2MBoNjIW98Gf25mOTSAywEDBKZ2tQ8XL+nW7afMPfhP17YHRjUCvJGzqOxvRhDcLCD1t7v2R1vfXkqpijLXeY2Z4rwdsfWoMZpXSMgMWkTsUIh+QWspQhUJqd/PKFjzJPO1TnuCKBdfK5JGu0vnKWVkwPb9SDL7FAaOzhatA3Fl/jhD5mjKEH/kMbPAJ+vwM7cU9hvjowq7nXOOKeNLbRRgC9JdJeyHq+bcHZk07pLFprzm3AAVrZAIk1LkV1DWBMjwAGTnMMM1Nf4jLdXx68yMV0/UwF7PhP7t6DGE5TxZPrSZKopVUDGDEOqXxxm;4:DATjka8iyvnEAFUK4QRy4A9ZJOx30hjlViuy1J3styYLduaFzY4joxrkELhs46UbsDR7hUNjB4RsG/rVboUsU/pDztJ3VQpc7ZVoHgrL2fWqF69pPOi6TApkmZ0lC3N1srW1vl9Vo7YW3GVSfQ2NEpRRkAl1EkTJUXgtpXVyAaJCTzt++8roldX63kbx4KnRyXhQeBTdfyUAeP9XaE6k7WRon5Rigmm7Px9SJVifXyk5734WGxAmtdSbzxkZj7Ii+jgUSnvnRIqrx80nIAdePw==
X-Microsoft-Antispam-PRVS: <SN1PR12MB23681F75FDC64C4E426A9347F82E0@SN1PR12MB2368.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2368;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2368;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(189003)(8936002)(54906003)(47776003)(6666003)(23746002)(2616005)(476003)(478600001)(386003)(956004)(486006)(93886005)(76176011)(66066001)(53936002)(65806001)(65956001)(53546011)(25786009)(31696002)(16526019)(81156014)(81166006)(77096007)(8676002)(26005)(58126008)(86362001)(97736004)(6116002)(5660300001)(72206003)(305945005)(106356001)(50466002)(11346002)(6486002)(230700001)(36756003)(6246003)(64126003)(16576012)(39060400002)(3846002)(7736002)(2906002)(65826007)(186003)(110136005)(316002)(3260700006)(105586002)(68736007)(52116002)(4326008)(31686004)(446003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2368;H:[10.224.119.212];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR12MB2368;23:5xXTZekTay9OvEq04eu1GXrb996gC0MIOVa0M?=
 =?Windows-1252?Q?FEaiSGo8ymLCPcF0iNq+cjg5Gjk+4wVtv9Dvb5JH7sByOcJZ35ndXsTM?=
 =?Windows-1252?Q?29Lba9BwmoxzwSnuHphZ4oJRWdc9cld3FCpRD9IrB/BKusfkprvqpfpl?=
 =?Windows-1252?Q?4pslOSAk34diE70cPQ623397aWOEVf4D/6fCjRHJwPeOfIgPUtGULQRB?=
 =?Windows-1252?Q?z7fhqJhF5qu4yziRuj8gw01RytTrqtq5zLoV6juPhKHG2FjPayRPquTQ?=
 =?Windows-1252?Q?FYPPcoYQGxHe8mTVPjr8Fcbm7D6h7ESAUtghgPtlH63o1Zw5MIGMqhiX?=
 =?Windows-1252?Q?ghirD/ETOfO4hpfrFi+pZHcgwAdHUgS6SbFiQg3yk+NX4ouIpoLuYca3?=
 =?Windows-1252?Q?8eponnhvgv5jow03Xym08e6t8R69AN1ctlAlvUqfeHVlpVZ0JTo2GJj/?=
 =?Windows-1252?Q?ptZv5rWVlcPQij09FthqFqCo5fA/S569+XROcZcy3yBM5x9Ucw7x5fKR?=
 =?Windows-1252?Q?1QcOqY8V9RrurVB2wiwX32e7uCwY8BoPaEAXBF14XV2uvGNQMk1WxCTL?=
 =?Windows-1252?Q?MusNmvY8FFp0DT9JxSIQDJOCWau7Z/MLNUemp1qt9gfoamN0FHZVSG7h?=
 =?Windows-1252?Q?bdjrvJOb6ESPhm/qkbUO9AGC/2AD+yfTkSrKu9g71+Eql2dIeb+uGA6F?=
 =?Windows-1252?Q?+f+rTk4Ufhiv0eVrPNIqIdMI24yq1fyE1KZRfur/YWCEhVJFsDdEqrmL?=
 =?Windows-1252?Q?ZQekoe1e3P5bvExJvL1uNUV5XVtFFg7pUgDZFnsfCgP0tNdjQasZE8X3?=
 =?Windows-1252?Q?5we4U7dJvdojbxGYaIbm5GwCAi7UzhnZc/bHNilYHOHZVmFAqAuzKrES?=
 =?Windows-1252?Q?uWUGUV7w8q9HXJkfmYOl8gZRDIh3xBoAJIJp3HmjPoQCD2pzYKI5wTr4?=
 =?Windows-1252?Q?fiIvvO2+EBsUnQDVxtUVEMDYyTg4Xc7d868Cf1vKGSlYDwLkkpWYh+uy?=
 =?Windows-1252?Q?DlkdDEHcOfAC682G+iRruK4PsRtYpI8Pl39JFv9TdUeeK+svmSafer1s?=
 =?Windows-1252?Q?nmdwg8H+fMREIg7nhASu4rkKNfzW4M16aqGA1Chvs65D9oFAHsANHlSu?=
 =?Windows-1252?Q?71g+pqKt5vxGT7F/Y3vSxMs4P90T0ozPgL353VjLy3IqtA07bS6na9Ll?=
 =?Windows-1252?Q?Iu6i6hQ8Cc0aJqnvIOt4j39Bu1qsf87wLc09pxQkrlKQTbwhSKMdjh+w?=
 =?Windows-1252?Q?MqMqNSYvZPtS7Ft64zL5hylUJfeQehkS2Tx/m44PFTZQ3NOZreTfaZrp?=
 =?Windows-1252?Q?Le3/sXn2yaKaXPaGmibkm85oz7GrqSaQLp16aQL+Zq/vPBwv0mf29ngZ?=
 =?Windows-1252?Q?1LmEjfDpMDJsmapdnIzvV2rcIHI5KklkFE5oAA//ochxfD6g9uTDRhjJ?=
 =?Windows-1252?Q?SWsJ84Oz+G71Rf45DgZq8mtKKeVMbaLLKnk+AW5F/7lk5JPDxQ6pKvCH?=
 =?Windows-1252?Q?8H1xGTg6hITMFlcQ5E8g9tDY/k3L7+/kqovaUEOM7V6Tc/4rqj3e0Wkn?=
 =?Windows-1252?Q?rUNh8RGe59FV9tNLARsyg3KEuv/0Ty1ywRBQJk1EWnAro9h6KKIuAMMq?=
 =?Windows-1252?B?dz09?=
X-Microsoft-Antispam-Message-Info: CFdTy08iWvUvfzdW+X94CJc7Nq1E64yoPyfXftK95UAEQ2WhaiXcc08m9VMCUiH4jP2ZfTvSzjfuZNi5fTLHLv80BQODS2A29Zehwp6/+N/qKpcZsahwFYgOT85wS21T2PG9VfrKW7hAyj4B1+7IzGD5g3gRrP/cd9KNF2r/cMynCp+azBXxwKZLF/MxgM90byWShFNp/oyEnRg/0JuY6eNRksUNgzmRjBaeAd5osVL4+T5KcUJsBhyRqWAYIn5FjP1uc70Uv/icNCjobAQ9/HKoFSEVza8h1V2yf8J6/3hrRQbTFNgZciRP69UOt/Z13xJmfz0orNThyHxx4WWqphHTKHuHPiT2FFD7PBAc7qU=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;6:4W5Fezt4r7ODe4MTHin1Fs9lMtc1l3JwpIob25Db+Z3XI7p41tS8M2pzY7AeJ6oWjjemdLhsaBQMs6U4vBosva4W0RTP7Yj9Ol90zOlGzhpxEPPN1gp+ELszGhQUQJTVLT23O/MOxJ52fbsYrwTntEIjtS3/Hms7P/6lnNTrYsZqtQqHZG1lsw2XhasE9BnUQsBjEKan8dz5AWEgfCRd8etX1R+Oiy/JDr20nweesEJGy1DWv71CM1tvwSCeaxTRGtmeN9YB6fWM6EZiwMm3S5GeyEC5q2xsSrG0JakAnzefz4xZa63nK8ahib0tomVeg0t4h1SQ5BXWIVaw0TeRJIzT/99+p0bLXSL+6khWaUFEUxSedHPnD1oCktYOBFZi2rage6M0oKFcsrTd4xl/RR9hM4XMtkejNKlx5dRf+xuilceaHPMMcGvbp3Wu2iNBHAyFcisD102sUlPtaUtuJA==;5:+e1hnzYDakMSAI+xQyvw2LkxafugR5tcrSkFWCpVunNpSruWv2Yy3EiB8Pdmw3mXPkyMyXZkul8EyamikyfDQslbp/6s4drMZecrzJ9U/DjWl5YWI32MC6zVAk3kArYH1RcHuKjSs49SByeGYElJ8MvLgYUvJuucIUWDwQImVoU=;7:mb4TNe5EdlN4Mq6BXvtHiui/xGKU/hBnbqQg+wRCb+n5O2O1ZzOHmTxgmm7kEoScFIN/VX7v+DDmVnvX7wQTk+kvYnydsZi1Hpx0mhBzuMZxMXP/D2zx3640UzKUOpzmesuH0/assoBIzd0I4fvSwqA+9/BwkSrixXUDl/QUtmoKQFtZga84DiTs4sIlQL+IkH5GVsGOJs8hyLrt9lGqZ9r6gzeK/d8K8Z4YPY0sXoKKP0JeXYdO7GdfELp/MqlL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;20:mmUzgYB40rojCjiQWm37G56qK1abHvXj9PFnRLB9DOKSPasW96ZfSm65SwGx2O962lJiD8Syp6Bat07RhmWPWUNAV0xVXoCsQ0vG95cI7ghz46PsUTgunNxwkog5OP9cOVn4doJTExUyo8JxM81kQwh2/zEGuUqiZ7jzvGsNQyByhwrMl/lTOzVla4OIZESWQ5tEBU7dRlkKbkWXoloP0hgCd7uEDoxwkXkoStgg5xrY9+CIRVc3QTfK8NTH5HgG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 01:25:28.4454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9968e1-2e88-44c3-b54f-08d5f68481d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2018 9:20 PM, Mark Brown wrote:
> On Mon, Jul 30, 2018 at 05:32:21PM +0200, Takashi Iwai wrote:
> 
>> That said, if delay callback of CPU dai provides the additional delay,
>> the patch does correct thing.  OTOH, if CPU dai provides the base
>> delay instead, we need to clarify that it's rather a must; the delay
>> calculation in pointer callback becomes bogus in this scenario.
> 
> Part of the theory here is that every component might have a delay
> independently of the rest and we need to add them all together to figure
> out what the system as a whole will see.  Personally I'd rather just
> have everything use a callack consistently to avoid confusion.
> 

For consistency we can add a delay callback in snd_pcm_ops and modify
the drivers which directly assigning runtime->delay to use the callback.
Apart from the 2 drivers mentioned in commit message I also found
sound/usb to be doing the same and its delay getting lost.

Thanks,
Akshu
