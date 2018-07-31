Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E2F208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UWgtVjH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E2F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbeGaITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:19:24 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:30944
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726591AbeGaITY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfk3bIwI5f0AV0EpoI1x/liri+wm4x0VqqgGjO0DrJU=;
 b=UWgtVjH0yJP3JI5rVblxoiqusMJRbeLBISyctctmHDwwbxLKrobuJfenM7y0aqXOSoz0AK2AlcxrUW/As9W/kngkKosqwdJB3o2OVdEGmxDkDiSRGN4zgo1J3saDK4Oq05HOqqvUNaaYA9cn6bJktr9JUW50Ya+l+AGjqsZjpOE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [10.8.2.75] (193.47.165.251) by
 DB6PR05MB4648.eurprd05.prod.outlook.com (2603:10a6:6:4b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Tue, 31 Jul 2018 06:40:29 +0000
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
From:   Tal Gilboa <talgi@mellanox.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
Message-ID: <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
Date:   Tue, 31 Jul 2018 09:40:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: HE1PR0701CA0053.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::21) To DB6PR05MB4648.eurprd05.prod.outlook.com
 (2603:10a6:6:4b::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b63d0c92-096a-4d18-7159-08d5f6b0835f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB4648;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;3:+bFCJvXY6EXNeXBRGudUE6HyQjUnPhqF6Qh3VhqnbKcI4P93ojYXgKw8Gfk0Y4mF/bvpAq33r0ge1jud7M1Z4cdftjjL6QpxjmRCk1VvnmSYQS0ZprDncVMk3VfnZi6vkFw2h+XyV/kq7ZWsuErsFdrwzkToZCJg6Eee20LFhrkBY8gTN/OJsuipYqM4X1WALR+QhVcJi3ZcJE3W3B1gdLXJPUd/HdNcPogNJi2s9WxgOUuQBTSMS42HW1U/TkeT;25:/6X7ZiKyMhy0YhXa4HopUSykPQ2cGvfUXgDJRALKagd4x7sLw7WbXFubYoYRrmqSZCsHM2KSIRvImqQMSnoTjjqbhpKHR971Z1BszqbNc7Uw/C9XnAui4RWc/B7EYqcbWipE2oeV6URzyUuc1Gaiy4cEJPGNYvCufCKzdNAN44t/c8pfE73XTNNPY2/VtmeERvsne20aG/7w1fvt3JceBPgiuJJ0QfH7bp+THtlLJI/GXSZftCgUi0pcbAUit6rdYg8uTaxHV8dztR0GtcfpVVZyTAZ4/fkUEqfoXR1taUhykZlp9TiQn7XCH+iZvQ9aHvPp/+xD5NY2dI3SMoFzQg==;31:r8YDuJu+uXXitmUSsHRx+dD9c1qbp8HLEDD6DG3eoSTsuKgDBNJQEmwgVfDESeQtfSm56hpq+J0slVI8e+H/G/XydNFuFwQh2EHJ4Qtz+bwwe6ixNJejEQqipBxRAg4hSHABwSyoR4J3bbLT5d9sH7/8v3OEuK/w73RwMegmA0pJEcOBFcAWs3e/dFJXERVkgaofBGMeubHL/RYdCOAMZHusB9yuGGOxtv3uc3jwpUM=
X-MS-TrafficTypeDiagnostic: DB6PR05MB4648:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;20:sy87tfMQ6ZmFQQqEZ927qHh7daoBJtR+Cd7h6MNa/tBi92pqMyacn+yNI5IO8fzbK8bAdpiMqIf7N8OScp/TOEGrKdcciWdSCmctIOjQolsb294pMUky6lpvVSesn22PgH9/XKaE0z4YlpdXNlGQVUyaaF2hWApuXbc8mdpZN/C2CG9b6UP7Q4mgpNCZYHJDhG4PoyYdtbK9ViyVJZqLHggChzDYpSxsvYpsYjo5LF7hkyn97ZryI7j5+tEooutpcOU1/1dGt6imxXasAcG3QfVWxv2f2lJ82V/Kv2skfDkMQ3lDrJ6dWJocyKJTpUKneidFfpZJr9+CFHdXgAPyqEbQCTdzYojyNis0ggHYG+Xrv3sPn6eMwROTlKfK0qNC9lNwHzM9JtgycRnkSQNwykZZ7QBHq9wmnqYAGOVJ6DKZeMcNca2jk26l98zGurb6BBEkCX+b7epxcCjr/eCS1LBI1o9OVcj/IRH1mn38QFcAKPP5U20pEnW+h90Cc0b6;4:UFOAg77NlcQAuBcJMLpjP4uzcoJd+L5v+fqDe7q30JExi98zKQI6EB9anY2PuZBiWdW9byXT+xL+9hRQS8dQJh7RzRM+NFK6WgjqWlDsCYPygldN0e5xZprGntLcJJ72iC/kxws6kIQqqc0iO7+6tdaQh1jCWeHW9A7prx8BRXpUG4AF1BRuvBSxWvPVbzPXny21pRReTnIPcalgoGDqNaZFwzf5nB9c2TTNmdbyXTyepsw043xlRXEciS/sbBX28yMRXIAZkUfQSDiuLIRzEzZM9wr8bGHMiEWdSun629M9S5QQGoqbQLbkUikZoHOVH9mLtpGvfAT1b+Qv+ZyQWAmWzUDIcPZzvMvob+EnjxA=
X-Microsoft-Antispam-PRVS: <DB6PR05MB4648F751BE09FA3FF3AAF2AFD22E0@DB6PR05MB4648.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR05MB4648;BCL:0;PCL:0;RULEID:;SRVR:DB6PR05MB4648;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(396003)(366004)(346002)(136003)(189003)(199004)(76094002)(8676002)(81156014)(81166006)(4326008)(478600001)(316002)(2870700001)(47776003)(67846002)(16576012)(53936002)(65826007)(486006)(2616005)(229853002)(7416002)(6486002)(476003)(446003)(956004)(11346002)(25786009)(7736002)(305945005)(3260700006)(14444005)(64126003)(50466002)(39060400002)(66066001)(65806001)(6116002)(186003)(65956001)(386003)(106356001)(86362001)(53546011)(52116002)(97736004)(16526019)(3846002)(93886005)(26005)(77096007)(5660300001)(105586002)(54906003)(2906002)(110136005)(6246003)(31686004)(58126008)(52146003)(23676004)(2486003)(6666003)(8936002)(68736007)(31696002)(76176011)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB4648;H:[10.8.2.75];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1TUI0NjQ4OzIzOmV3OGJOM0s1VmlsOWUzNDV2ZUVtTFFpaVNV?=
 =?utf-8?B?S3JDaXRZbFhCVU9rTTQxRGxMbmc3RXF4NWlWZ0ZWb1RRdXFzd2l6ZDRvc1Qx?=
 =?utf-8?B?YWp0aDBjY1Bza1ZWdEU5OEQyK0FxbklEbTlQdnV1NTVSNzRqOVlpOEVYOVl3?=
 =?utf-8?B?dzRET0hOY1NYTFJZbUR0YU80M2EwK21wTHRhT2liRnNFRnpNMXF6ejB5a2p2?=
 =?utf-8?B?eGI5OXkycG9Iem5IZUxPbFpoK0Eva211bEp2N1lyRG00SFJzWW5EaFVPbkNm?=
 =?utf-8?B?NnlFbGh1bHdRN0Q3WXR0bmZYOG5nbDl4MHV1UG1VRGJHMzJ6dHRPQnFFdnNP?=
 =?utf-8?B?a3pMTkFxaWV0cEVaZFYwdUIzT0tYZTNic255M3NxTFptUTZhZFhuajNxenA5?=
 =?utf-8?B?MWw2a1l0VHFwS3Blb3FKWlpyUGRiZS9QQVFQdG5QZk11WTVTRXZvazVYT051?=
 =?utf-8?B?cG5aTlQ4MlRIZDFlcG5lNGdudEZjNVdtS0lQTU9KcFF3eElHb05ocWVtWmc5?=
 =?utf-8?B?L2ZjTGNNeER6d0dYQmcwV1VIa0YrZW5ub1lmWmtNOTNlMDgwak8wMkVJZVhK?=
 =?utf-8?B?dEFhN2tXWUNzMk1sdVBGYkZYeUIyTzFjQ2lWRUVRWm8xdVJYYm1pZFJtUjRy?=
 =?utf-8?B?VjlHNlEzN1VUSkJVWVBuTEpvUlNjZmUyZHFLWE90dC9PSDF0cS91UlZISUF5?=
 =?utf-8?B?VE43aHEvczRUVGkreWlYM3o2Nk9yY0pGM3hzMnhkZjNUVmpMMjBpWTNRcWRh?=
 =?utf-8?B?M0Z0ZWtOR2pweVlxaTZQdkYwaDU0WGxjcW9yNjhvZEpFcUtBaTJtZ0lSRFF5?=
 =?utf-8?B?YWpCTEFid09JSkZPS3dvSi9EMW9IekxkQXhZd2djdWlERi9rYS9GOGNBQk9R?=
 =?utf-8?B?WWNkak9hbEJFUjhneCtHZmVIT3FxSlhOcStHR1RPTWpiN1h2Qnhoa1N6ajRz?=
 =?utf-8?B?Z2oxdVRZS0JVaFNhUGtJWHptVUlucVFZT0dpRlcvN1B5VHBScXVxVVpUaHRn?=
 =?utf-8?B?TmlYSXUvSU91cmFEK204SmtIa2hVMWFuOXdjanY2VGhZcG9oY2V0WHU0Tm9h?=
 =?utf-8?B?WHRvaFNTYitRZmt2TUoxRC9XYUF3YUhhcXBjeHhmaU1NUWhnaWswSGpwaG5r?=
 =?utf-8?B?eGtMMTRZYXFLbk9DU0hGSVVxcnJHWHJ3N29ueXprR3Njcnd0VXlLVDRESTll?=
 =?utf-8?B?TFlQOWtNK0NvT1FpaFBYYXZLd2xQVHBIMSt1YTh0L1lubXpLY2VmTXdUWEZR?=
 =?utf-8?B?eWxzblI0TW94ZlNEWDIyVFkxcERjOElPMGpKOWdPZjF1aHhKcEhobmpCSi9Q?=
 =?utf-8?B?UGRFV3I2Rk9jREc1cVBsOFpHMDNUUHdFMTI1ckFQZTYvZGc0OXMzSmFuckVs?=
 =?utf-8?B?aDk3MTUxaWVUSHphZjhXSUxBK0RBMU1xVVdyRm16WDU0azV6V1V0RGQvVUVD?=
 =?utf-8?B?UUppVFJOK2VaSmZnT1FjYjV3cjZlZjNBWEVtenBKVEwxSFB6SXB1alZMbW9m?=
 =?utf-8?B?dktXbnk2M1d2ZHZuSnBvNGxHK0tYN3g2QXRNc1V3THFKZmN2Ky9QdVBxZXM3?=
 =?utf-8?B?RkpQMTB3dUFLaE13YmZoTG92M0MyVUdlb3ViaG1XNkxhNXFzVXB5cWFETXlz?=
 =?utf-8?B?eHRCaFJhNUNiN01pVExnTTFHL3lRd2oya2xKNmkwQkIwVHJLUCttaE5Pd28v?=
 =?utf-8?B?K3g3MEN6MHVtYjlVNXNPWGR3bXBkNFhpZUZ0bm9oSk1ETjQ5R3FaUU9SVGZs?=
 =?utf-8?B?dHpqSHlnWVp0UDdhS29WZXp4Z2JDcWhnL2UrK0JlRUFQQ3pRdlR0Z3ZMZ2x6?=
 =?utf-8?B?NUZPcWRjTUJ1V3hlNFZLUjE5dnZVZ3ljVE5KcXF2TmJ3RngyaUF2cC9EVEl5?=
 =?utf-8?B?Q29FU2FFbVhyaDFGYUVHenlLRWdLMC9jV3VzNU1ETWZMZmdDOFZ1SnBYS2I0?=
 =?utf-8?B?b0lFV1ZNaEoweGJNVzJ3dGduYTFoVTBCTHRZakxhdGExYkNzM1RlTmFaM2Ux?=
 =?utf-8?B?VzFZRHR1RURkT0V0NWkweGhyQkc3NGZaNi9WOTF3ZTJWVFc2VzBtL0plUTNE?=
 =?utf-8?B?eUU2Tld3K3RnYzhzK3ZaU3BTWkpFYm0vVmhmSzJKUVNHT3dEZ0V6T2RXd3Fr?=
 =?utf-8?Q?2oFh/U5fUhyuW3JpyyFQRdwjUCm8yrQ03w8zYP7yoHB0?=
X-Microsoft-Antispam-Message-Info: RVuiABe//0fZKwud3lcFs6aHVKW2PvpNwJq965klDqqgrUqhaRXtE1/fqkbP/6GDjTtWUnFyPNInW4n/87VXIdsiqShxCCpDDh3xetRNVEVbjWYamzHAstj62UwmGWaBnOYOOifEzYzh1BMlytYQXFXXJsBdmhZVZZhsWccVfOwtK5NuYC4zYjhQzv+XQPHW2bdIbg7fF4fUPfSG+oou/VJxA2x7ypJn73G5JPQ8KHBeNASnRQpESSBnPvx0jEdWY/M98YtkNWhP5+qklMsMOPGzfsp2PJgVThE7YWLH+sMUgTlWEcaiE/lUzs0ZmkggvUjElx4PMCy7RNB7+DExyNtMLx1qVaq95io+V8p8qDk=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR05MB4648;6:b7IFIy3rXHlA/JutfiUmtaKGB/rT89yCD+rcHeLAoho5YhiCTaTA4DV+ScpHbrJV4mH+IKJcF3eqV/oOTtocLRyA/lIys5mLNEr2ouZNqlLO9RxSX8YDxk3Mx2cOK4AVNURTpjgtLLtu21wUwP/WXZAzxxyNAn5Opk3hxJfkwhpaiG05l5YFXwMHs/Vm2elEUigb/N9neUKhd0w+qYM/kCoo1L4B9RPY3nr/Tpcayd5TxvYEh3/n2I9odF1X/kJsJE5tOapdiR+4DiopbFLmMklmIAyOaRwpu8aTXyjMr3TiDnCbXYePBR2HvmIjw0Bj3v0yslXV7uGqroPTZo7eJqOa4yZ62ndTVkpjRBsZIgp47a5g+0VQMxqiIts46LgnLELDgTer/NCJEDvtVki7rmMBvpnyi4baBv7snr9U7OxkuBdARreUlsiqLhx1qVY+rfCEMxPIco9niBV4IeBh4g==;5:LcOzSWHHrEBgtf2cWQqShY8qrC1PLerjeOcZkzSVCSEcLeHiEo3erw/klPlVKIe7Av2pv9xmwAsRDszcGL1heR5r4Rr+h9An27VrI6uWcADK6G8M6pr+RsyWQGvWGH5D38soLKi676agBl/Asj5vP/tqF+48NsMkktcVJcZU1kk=;7:wfou4h8rSR56igS4RFLs5YJyVcTLEmzojvGYF6NJSfCqs3MGZSpFYAPWP47GAOWTQkCvl3iclKkPSr31cJ9jXAIMEZ+AUKr+PXTvspJDyEJ8QT29wJjKdAG5dn73/8f+4jaEDeqIc2XH3NuW3F80KDOKZXZb+hk6h/OXuL32uFDsRySpbrvNMNHKYr4B0GFQjrX/pnex8V7k/fuk9ewdFpUC3U6t0RXSFpkgLH74fQUc7aoSY6dfqiUhLyJ16IfB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 06:40:29.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d0c92-096a-4d18-7159-08d5f6b0835f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB4648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2018 12:52 AM, Tal Gilboa wrote:
> On 7/24/2018 12:01 AM, Jakub Kicinski wrote:
>> On Mon, 23 Jul 2018 15:03:38 -0500, Alexandru Gagniuc wrote:
>>> PCIe downtraining happens when both the device and PCIe port are
>>> capable of a larger bus width or higher speed than negotiated.
>>> Downtraining might be indicative of other problems in the system, and
>>> identifying this from userspace is neither intuitive, nor
>>> straightforward.
>>>
>>> The easiest way to detect this is with pcie_print_link_status(),
>>> since the bottleneck is usually the link that is downtrained. It's not
>>> a perfect solution, but it works extremely well in most cases.
>>>
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>>> ---
>>>
>>> For the sake of review, I've created a __pcie_print_link_status() which
>>> takes a 'verbose' argument. If we agree want to go this route, and 
>>> update
>>> the users of pcie_print_link_status(), I can split this up in two 
>>> patches.
>>> I prefer just printing this information in the core functions, and 
>>> letting
>>> drivers not have to worry about this. Though there seems to be strong 
>>> for
>>> not going that route, so here it goes:
>>
>> FWIW the networking drivers print PCIe BW because sometimes the network
>> bandwidth is simply over-provisioned on multi port cards, e.g. 80Gbps
>> card on a x8 link.
>>
>> Sorry to bike shed, but currently the networking cards print the info
>> during probe.  Would it make sense to move your message closer to probe
>> time?  Rather than when device is added.  If driver structure is
>> available, we could also consider adding a boolean to struct pci_driver
>> to indicate if driver wants the verbose message?  This way we avoid
>> duplicated prints.
>>
>> I have no objection to current patch, it LGTM.  Just a thought.
> 
> I don't see the reason for having two functions. What's the problem with 
> adding the verbose argument to the original function?
> 
>>
>>>   drivers/pci/pci.c   | 22 ++++++++++++++++++----
>>>   drivers/pci/probe.c | 21 +++++++++++++++++++++
>>>   include/linux/pci.h |  1 +
>>>   3 files changed, 40 insertions(+), 4 deletions(-) >>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 316496e99da9..414ad7b3abdb 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -5302,14 +5302,15 @@ u32 pcie_bandwidth_capable(struct pci_dev 
>>> *dev, enum pci_bus_speed *speed,
>>>   }
>>>   /**
>>> - * pcie_print_link_status - Report the PCI device's link speed and 
>>> width
>>> + * __pcie_print_link_status - Report the PCI device's link speed and 
>>> width
>>>    * @dev: PCI device to query
>>> + * @verbose: Be verbose -- print info even when enough bandwidth is 
>>> available.
>>>    *
>>>    * Report the available bandwidth at the device.  If this is less 
>>> than the
>>>    * device is capable of, report the device's maximum possible 
>>> bandwidth and
>>>    * the upstream link that limits its performance to less than that.
>>>    */
>>> -void pcie_print_link_status(struct pci_dev *dev)
>>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>>>   {
>>>       enum pcie_link_width width, width_cap;
>>>       enum pci_bus_speed speed, speed_cap;
>>> @@ -5319,11 +5320,11 @@ void pcie_print_link_status(struct pci_dev *dev)
>>>       bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
>>>       bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, 
>>> &width);
>>> -    if (bw_avail >= bw_cap)
>>> +    if (bw_avail >= bw_cap && verbose)
>>>           pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s 
>>> x%d link)\n",
>>>                bw_cap / 1000, bw_cap % 1000,
>>>                PCIE_SPEED2STR(speed_cap), width_cap);
>>> -    else
>>> +    else if (bw_avail < bw_cap)
>>>           pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth, 
>>> limited by %s x%d link at %s (capable of %u.%03u Gb/s with %s x%d 
>>> link)\n",
>>>                bw_avail / 1000, bw_avail % 1000,
>>>                PCIE_SPEED2STR(speed), width,
>>> @@ -5331,6 +5332,19 @@ void pcie_print_link_status(struct pci_dev *dev)
>>>                bw_cap / 1000, bw_cap % 1000,
>>>                PCIE_SPEED2STR(speed_cap), width_cap);
>>>   }
>>> +
>>> +/**
>>> + * pcie_print_link_status - Report the PCI device's link speed and 
>>> width
>>> + * @dev: PCI device to query
>>> + *
>>> + * Report the available bandwidth at the device.  If this is less 
>>> than the
>>> + * device is capable of, report the device's maximum possible 
>>> bandwidth and
>>> + * the upstream link that limits its performance to less than that.
>>> + */
>>> +void pcie_print_link_status(struct pci_dev *dev)
>>> +{
>>> +    __pcie_print_link_status(dev, true);
>>> +}
>>>   EXPORT_SYMBOL(pcie_print_link_status);
>>>   /**
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index ac876e32de4b..1f7336377c3b 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -2205,6 +2205,24 @@ static struct pci_dev *pci_scan_device(struct 
>>> pci_bus *bus, int devfn)
>>>       return dev;
>>>   }
>>> +static void pcie_check_upstream_link(struct pci_dev *dev)
>>> +{
>>> +    if (!pci_is_pcie(dev))
>>> +        return;
>>> +
>>> +    /* Look from the device up to avoid downstream ports with no 
>>> devices. */
>>> +    if ((pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT) &&
>>> +        (pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END) &&
>>> +        (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM))
>>> +        return;
>>> +
>>> +    /* Multi-function PCIe share the same link/status. */
>>> +    if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
>>> +        return;
>>> +
>>> +    __pcie_print_link_status(dev, false);
>>> +}
>>> +
>>>   static void pci_init_capabilities(struct pci_dev *dev)
>>>   {
>>>       /* Enhanced Allocation */
>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct 
>>> pci_dev *dev)
>>>       /* Advanced Error Reporting */
>>>       pci_aer_init(dev);
>>> +    /* Check link and detect downtrain errors */
>>> +    pcie_check_upstream_link(dev);
> 
> This is called for every PCIe device right? Won't there be a duplicated 
> print in case a device loads with lower PCIe bandwidth than needed?

Alex, can you comment on this please?

> 
>>> +
>>>       if (pci_probe_reset_function(dev) == 0)
>>>           dev->reset_fn = 1;
>>>   }
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index abd5d5e17aee..15bfab8f7a1b 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>>>   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev 
>>> **limiting_dev,
>>>                    enum pci_bus_speed *speed,
>>>                    enum pcie_link_width *width);
>>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>>>   void pcie_print_link_status(struct pci_dev *dev);
>>>   int pcie_flr(struct pci_dev *dev);
>>>   int __pci_reset_function_locked(struct pci_dev *dev);
>>
