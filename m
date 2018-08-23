Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C3C21568
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nlwrw9O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C3C21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeHXCiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:38:01 -0400
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:16297
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeHXCiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW0b/YvnjyJRC3EGyu7zo3Tn1kIEws5G8kDsHGG3OR8=;
 b=nlwrw9O11Dpbrb7AtnSkVByVwFDz6/963Coo5/d/JzDYtId+9us6LHTZVfRGBXP+yBsCE2f0Lqca75DHRPkO+vQA1hjo6hF36OY+jHOmTs1nRjZbBRa2MkylNKXlhr36fl3w4MHm5Gc7Tf7Y866q2AtS03l2tQa7zH32NqrZ9Ys=
Received: from [10.236.18.153] (165.204.77.1) by
 CY4PR1201MB2532.namprd12.prod.outlook.com (2603:10b6:903:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Thu, 23 Aug
 2018 23:06:03 +0000
Subject: Re: [PATCH 1/1] drm/ttm: Set memory as decrypted for ttm framebuffer
 mappings
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jiandi An <Jiandi.An@amd.com>, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org, ray.huang@amd.com,
        Jerry.Zhang@amd.com
References: <20180822185754.104729-1-jiandi.an@amd.com>
 <d22f2dce-7229-aac8-036b-5312927632e4@gmail.com>
 <2eeaae95-181c-b856-09ae-4ee2423fe3fd@amd.com>
 <92cfac31-a408-210a-d901-1e6511a1cb9a@amd.com>
From:   Jiandi An <jiandi@amd.com>
Message-ID: <3ef2e755-eb99-0e4b-1e0c-c2ae62aafc10@amd.com>
Date:   Thu, 23 Aug 2018 18:05:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <92cfac31-a408-210a-d901-1e6511a1cb9a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:910:14::21) To CY4PR1201MB2532.namprd12.prod.outlook.com
 (2603:10b6:903:d8::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa8cd16d-7c63-4093-bf7f-08d6094d0010
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB2532;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;3:OxQo8z+EnVVBIU3UllvN9b81HHiP0stYkhGZbUK0XLYrw758VFCJHJ1cz4Gev/zs+Eo64VJGUKa0GHybq7cpm2i/cr6/ag1IVQ4mzcK7IxWGBqGUgQC0NIVGYmZzLENAEpVtPKqNiG7k8VLuxoM6R/p4HsezwBMC+BumnXyutJmw1E7Q6B7+5tfRnMHf5tReBaj+iZS5WaqvXk7V2kBdzaE6ekrEIE5zwJ0OqW+yHk2idv7qM/90A3eA4/1dA7xO;25:dwUjPXlP3iut+2SBXxdsLV+b5eWNeYs/cAcw6a94fqi03yZLXTpc9SVjVDex+ESIYlltFpH57qxOi5EiFRhpMUaUqcOBiER/TJ6hHhcZUGNyClds4+lBbdPEwbM0rrXKdmqlQfW/mkK0zXiNQK9+5CCcooVvtbQnRy1mJ+jAs56YX/wHcNYQ2WGmaDqrJXGusXhh7eWdlOhfs6n/d038zOj184cwpeYH6iHnjiB8f6jpNmoJuI6AOydiaTHBngKTQyLM43CksXBYIsmJglKqMpHi9naooNJxZtU5feS/xpYFVAwtdMbqQKDjfkplsg/D0NKOir7lOIxVoJmQo7t+5A==;31:aPeerNsksn4e3mpaCsuso0gHxxvudu5dP/oCDKFHxoQjYlFAQRXkidQiklL62dfG+5DdK5mvb7bWmftxO2Ff4Q1TMKF3spfhPp9odgRG7QGgVfp8ez8LchDIi+LgEaIszL5EbAjikPIwAw8kIZaYfS3E9MapnI8CueU84pGIqEEpTeuiLe8mrys7wEEF+7S91A/B9DMXwBXngXyJhQN+NHgZih4zzwQWdSigr1fhVk0=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2532:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:lpYgxma770Q/raxL7bx/N3p+ytrgxJOxTJivemquFSL7zlRWFdTOfOCBX28f9uPIZaDTYaG/y3p/pxMyyg+BhTYej3ldCbfo5d+1JOFh6hLxmH5N6RhhQT1ib0R4GAuQzFDedyUe5qyeGUi6fUdWzs9gDLTh3cCF0mW/fvV3l7HENzDSnvA8fNa+WJ0BRzF/PME734Drsfl+//tZDho9ZrWB7ISnRyqOMeVcwgmaha8PDdyWex2FQBd2uW+YXc2SClOeEfJqMwsLPaiDJMUeySikq4ux+/QaQqZgTVQeal8DELdCybSl+R9aH3W0UiwThqtIByc7Rlc7oqLa0BMRMCN+TD8n7+BmSORGCyRrSIcPHENUHoi4Jqy1GhBSGVmBFueS8E8KDv0Pss66fh2DSu6RAGCz6+TuJk1YWOEDrjKTCW8Gqf792OjLTmj3PXUy5Zu2uOcj6+nji0ym2AgZ9krSqq3VP5342frKMBOpTQXD+QL8q095Zt+qGZOd8NQp;4:/wt+lHvvyJ0tL3GFM+apdW/CXCtnxkxSWaUygtfL1/zK0FIzxwsM+OtFxKmNlnrl5XFUE1A8Q9BzOeRquZ6AUyJFTPhwEFRv/Yd26vf3UfhF+HZDknFbaRwgx4jIK77+Eo2JrjS+lugIrjH93PbiTtVTYoMLqzMnkF+xxHrLKIPCDBQws2IQYqGKTH4BXpGuQFMFUlXg6w351LlkWS5RgHau7Fp11H4G+Z71aYQaHRTdw6Zbij6UwE4HNRUL5xtzCj8k67VrY1Yw1Gk89/UVr6u1ebpFlX+NWfjzWEzN2WwdL/PAgrzl3sIvGWonr52y
X-Microsoft-Antispam-PRVS: <CY4PR1201MB253244B1C4C5D4E0D7C5FF73FD370@CY4PR1201MB2532.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:CY4PR1201MB2532;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB2532;
X-Forefront-PRVS: 0773BB46AC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(39860400002)(136003)(396003)(43544003)(51914003)(189003)(199004)(6666003)(8676002)(65806001)(47776003)(65956001)(81156014)(81166006)(67846002)(72206003)(53936002)(76176011)(956004)(6116002)(2616005)(2486003)(65826007)(6246003)(52146003)(23676004)(446003)(3846002)(11346002)(110136005)(7736002)(8936002)(93886005)(66066001)(97736004)(305945005)(478600001)(5660300001)(68736007)(14444005)(5024004)(105586002)(77096007)(229853002)(26005)(16526019)(476003)(106356001)(31686004)(36756003)(52116002)(16576012)(31696002)(58126008)(25786009)(64126003)(6486002)(53546011)(386003)(6346003)(2906002)(2870700001)(316002)(4326008)(50466002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB2532;H:[10.236.18.153];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jiandi.An@amd.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjI1MzI7MjM6MWd4cTFYeWtMbkZlVm1EZ3p1TG1iakRH?=
 =?utf-8?B?b3drdzdpQnp2MkpnUGhZWjJlNVZYbVNXTmhBQnFBWlFEL044cktOdEs4TG1Z?=
 =?utf-8?B?ZFlrNFltU0VWQjVOK3lXbTJGd09FVUxYeDcxeWh6OXYwNkxiOXV6K0pNbjZP?=
 =?utf-8?B?WGJLVmtaRFAwazh6MjJpQU1wTzM3OWdnL05UMS9tckZhdklxSld6SHBoVm9q?=
 =?utf-8?B?SHRic0ZqOVZjL2VNMEg1Q1hhNHNhTm1malZrMGg3cnprTmdkSk1tMFhnZlNl?=
 =?utf-8?B?SldsYWlkdkxzTGVDRXRvcUMzUjUzN3J5U1JFU1o4REl2SkR5WDlVNWVPWGRZ?=
 =?utf-8?B?SmVxZ0RGYXBTeGVMWGhDek96SWhCQlhaYm1QY3RlMFhYUVh5NnNqWHpGSitk?=
 =?utf-8?B?UjhXbTFuMFZpdEZONmF4SzlteloweldyZUVlQ3MyRk5rSTQxQU9UangxS3FX?=
 =?utf-8?B?bU1EOGFLOXNWaE1pQWlWRCtJSm9NMGt6M2lYanBxcUxLR2NWSFNIcGM0aFFX?=
 =?utf-8?B?TDNVeGNmN3lJMlZWZytGYk9qZitHdVFTeWQ1SWw0Y1d3aktvM0JwaktvTlh3?=
 =?utf-8?B?bDNVdEJqcjRGQVp2REs5RE5HZG1nSjBpSW4weVI5QWQ3V1BXSlRweGMrdGdx?=
 =?utf-8?B?SzJkMnpYcGFyQXJPekFCcUE4SE9pcklKNnYzeVlCMVozcVp6Wkl2VUJUcnp0?=
 =?utf-8?B?ZkFmbldaeU5FN2FtVEVZTlZocDBCSzVSbXhFM0dBSytZQjhtQlYwazhOcDdR?=
 =?utf-8?B?cCtlM1BpcXVySEhWY0grSzhnZERJbUtLMW1ndE4zUXNtRjJCSHdYV0xRUmZ2?=
 =?utf-8?B?Qm84M1VxNUpjS3V4Wm1iTnk5SXp5YmROQ1M2UGpCeTlPeWVMcElYYVV5Qjln?=
 =?utf-8?B?VVZaaTlVN1hpVkJvM1FnbkwyNE9RdWNPRVpNTExsMS9KN21tendEVjBnL0tm?=
 =?utf-8?B?OHpqUmNsb2x2VHZBSG1jTGRTR20xM2c2R01jbGhOV2I1OGNsUENQNXhtejhQ?=
 =?utf-8?B?WTJCcU9zaWtYUUxtazYyL0psWVdQWFdFN2FsSThVU0p0TjJMbU5EK1VlT1ZW?=
 =?utf-8?B?YUUzRE4wVExGMVQya3N2WmNZbFVUTDZpYXRXU3R3THhOQ2R5M2NRMENKZnht?=
 =?utf-8?B?YUx2ZStiZ0FMUVpYVndYZENaS0dzRk1KNlJDV0J4TWRUckdTUTBRcmo1bTRW?=
 =?utf-8?B?R243ZlJhaGVMRjRjcmJtTTdjbTZVVFRFRkhROE9ZdU1vWnU1aWNudGE2andv?=
 =?utf-8?B?aXJ3WC9jRGZiUTgxUlRYUDFBQnJQMUZ5TE9GU0dsU01YOGpIZTdqODZoL0dy?=
 =?utf-8?B?NEd1TjVTZUpQTFNYUUVIdHVwN3Z6ZmlaaTJ2eldBVHl6TEpZN3hHMkpJLzE2?=
 =?utf-8?B?bXQ5YzU1d2VpK1dxM2JtQ2NCU0diM0dLR0JyL0d6SU1BdFJ4Z1I5QkEyeDlW?=
 =?utf-8?B?SnlPanN6RjNzckw3eFprSnJ4WUZqM2hSSHpCWmtVdEVNNTB6VFN2RGFvYi9S?=
 =?utf-8?B?Sjg2K2RXaG9KZEVuclNoTHJFRVlReHVOVG0yQTcxdTdid3pIMnJ1TTNaS3Az?=
 =?utf-8?B?OTRsZW5sNnM2ODRrcHlINThvWXNQZWY2ZjJpK2hBc3RONDA0TmJtd1d3elBZ?=
 =?utf-8?B?cVAxdlBVc3FJY2llT0IraWVoY29pL3NmbHFpSm1VSnpuVk1uWElNRXE4ZTd0?=
 =?utf-8?B?YVkrVXl6UEVIVmVtZ3NYbm51NFY1RExEZHA1eUJzSHZZZkt2ZG1oZkdWbHZK?=
 =?utf-8?B?U1p4UnIzV3ZKODlKYit3ZzVCdzI3cjdqMmROd0YzSmduWWNLc3hMcklzcjNL?=
 =?utf-8?B?V3NLazFOZmRTbC9pdzhia2xndWJyckE1S0xrbTJKeVRTdFVwVUUxYWpaYTBJ?=
 =?utf-8?B?WVlhWENCcjMxRmo0RE4xeHBwMlFhdHliL3RJOUYrbk1lcy9TR3IyaTE5SkZ5?=
 =?utf-8?B?WmdDVDVWY28xKzZnL2dMeVVNOTRISHBxTXpQdjR2UC93ODFJV05OSmNBZDU1?=
 =?utf-8?B?eFROTWFiai9BVFBZeTRxeFBQYXBzSXBJMmJVcTdNOUZPR2dEaUJoWDdOQ0dL?=
 =?utf-8?Q?6ugpmZQlLYaSm5/fbxlTitMjlmd?=
X-Microsoft-Antispam-Message-Info: +Tf+aJo//jDpvWyFAs4ZX9Kd20VBbLCtvO4Dm/6kmHnYFOCqCHbdWo/pgql5KO0NEzOmofSxXsLVeg6QAOuEfnkY5Beq4fE+1sQ9AlMyAbQ/mo/xktiqUM4HagnT19m0+HiMdHa6Jq5eLlSnwKhYOxkoN5CRHMItqHWg0EYDHt6Y6dmTZgffWo/CNnr5kqpf9CJlul3o6JIHoUTfnWbpRgKOJL/ocyhQKkUJTWA4nbTDNSQGzV+PmnFFiQddjPOEX06zN9+WGTAB0Vb13UJRzksR7+gEX/ddh2hqk8jugwN7r1MWZIgUXjri6Th27+zcGGfwyCf+PaUDuzr90nE+NicPRMXdTN8SFLqk6iUOWnA=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;6:WX2BWS+nlO4Nb94e7Idl/twBE/xx9GrwPMWMBVI3iOMNgmcukI5Xvuoiv7mX1Bxt3rmHlJycIx404yfLieAEtGbnTfahcW1ywm4d0HURvK5fgBkp4fO75pEV9JNiH943nDHsG4boXPbTi78dOS3HK87BwuLJqMOpv9b/y9f4m5srbOaSQMfbWSBP5uDH9zmJLNpU4LomptvlAxpaGsHCcOzk+qmk0o9YVdfTas3/xvP4JkAGIcc8EuK9xgquzxu8nyVGZrBybWcoidyouQ8q0rYRXGiVZziZKxrgkCqf8d037GprW4fMkHTZor+qjmtsjA/DQQzdXlYINej1llEcvJ0J8+7prCEr1m80mN4oiOHR7ox5sQuAVyXkG4VsS3AkAk+3KHJZN8gbCd68x87J02ZIu1xM3BOD5PF6dB04dSgcTTq2Xo1GnB9/wnVUzDV/ag9VhX0lEahvZrsfRfmhqw==;5:nM/1ghVzLP9zaqkl0nLO0/XwxfJB0oYf/AIyWDmAPbqSKox5kl9WS4X5EXbpv9rMbNuYT8sdt6PjLScsZOL7Soxzlbm9wJI0dZg9oh9tE2h0JNhU2rr9oqLdcCpOG+KQsy6GJgrdlGVjPx5Y28avK1RyTLhiS602NNeCHCCuIU0=;7:1qq8PdUe3OFpZElaCjaEGTCMbg48V6FWklAWpqL27+B9KVgIJpwg8UJvW1zZPhzULlSLfANYkndaTQzXotxvVzAW35jauOb5hXwc22//Y2Q+6piG9jPf8nEwlIXSjQyQVKkiEeTcBrUYsacT3jROCbL6XR5tvGMyyd/3QtrI9Z0jGA40BtXz6McN9KmyoExHmgBlJiXik3PUt1tEIZ1oid3JBhvzM1O0UUgmv7RnnI2SeLMuAB9Ynjdun48Q0rXU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2532;20:NhJ1RI4wDkoaZ3Cl3graEQdm3gYdFjHOgyLZQU6a+t9iE7ICh3Yk8NRM9EjjySe7EtitCiUAEuZNwqEf6j5tce/BZrfiEZDQ+b7BKup8e34TG//uGkNBUma8yQItNcQe4Gm5LEiI9EOfDWuZAguO3OSaWmWpVNEPNd7WFTshGia7QjuRLAsJe6k9yVWZde3iKpRpJxuWsircfzWKiEZFDGxjEYtFGnPc0MfqxpCGM494W/wk8vsjdmaR+sc1rZXc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2018 23:06:03.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8cd16d-7c63-4093-bf7f-08d6094d0010
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2532
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/23/2018 01:47 AM, Christian König wrote:
> Am 22.08.2018 um 22:57 schrieb Jiandi An:
>>
>> On 08/22/2018 02:09 PM, Christian König wrote:
>>> Am 22.08.2018 um 20:57 schrieb Jiandi An:
>>>> Framebuffer memory needs to be accessed decrypted.  Ensure the
>>>> memory encryption mask is not set for the ttm framebuffer mappings.
>>> NAK, the memory not only needs to be decrypted while CPU accessed 
>>> but all the time.
>>>
>>> ttm_page_alloc.c and ttm_page_alloc_dma.c should already take care 
>>> of that while mapping the pages.
>>>
>>> Regards,
>>> Christian.
>>>
>> The path where the issue comes in is booting guest with AMD SEV 
>> enabled while using virtio-vga device.
>> The ttm->pages doesn't go through ttm_populate_and_map_pages().
>
> And that is the point where you need to jump in and fix the problem.
>
> When a driver implements the populate() and unpopulate() callbacks 
> themselves it needs to take care of all that handling.
Thanks for the suggestion and guidance.  So you want me to register the 
callbacks something like virtio_gpu_ttm_populate() and 
virtio_gpu_ttm_unpopulate() in the virtio_gpu_bo_driver, and perform 
mapping by calling ttm_bo_kmap()?  Then bring setting memory 
decrypted/encryped by calling 
set_memory_decrypted()/set_memory_encrypted() outside of ttm_bo_kmap(), 
do it within virtio_gpu_ttm_populate() and virtio_gpu_ttm_unpopulate() 
callbacks?

Then get rid of the separate call of virtio_gpu_vmap_fb() the virtio_gpu 
driver does?

>
>>
>> In the kernel path, the virtio_gpu driver calls 
>> virtio_gpu_alloc_object() and goes down to ttm to
>> allocate pages in ttm_pool_populate().  Driver in guest then does 
>> virtio_gpu_vmap_fb() which goes
>> down to ttm_bo_kmap_ttm() and does a vmap() for GVA to GPA for those 
>> pages.  If SEV is enabled,
>> decryption should be set in this GVA to GPA mapping.
>
> That assumption is what is incorrect here.
>
> TTM can't work with encrypted pages, so you need to set the pages as 
> decrypted directly after calling ttm_pool_populate().
>
> And obviously set it to encrypted again before calling 
> ttm_pool_unpopulate().
>
> Probably best if we add that to ttm_tt_populate()/ttm_tt_unpopulate().

Here when you say ttm_tt_populate() and ttm_tt_unpopulate() you mean the 
virtio_gpu_ttm_populate() and virtio_gpu_ttm_unpopulate() that I 
register in virtio_gpu_bo_driver right?

>
> Regards,
> Christian.
>
>>    Guest then sends object attach command to host
>> via virtio_gpu_object_attach() which stuffs the pages' physical 
>> addresses (guest physical address)
>> in a scatter list and send them to host QEMU. Host QEMU maps those 
>> guest pages GPA to HPA and access
>> via HVA while guest write stuff in those pages via GVA.
>>
>> virtio_gpu_alloc_object()
>>     virtio_gpu_object_create()
>>        sturct virtio_gpu_object bo kzalloc()
>>           ttm_bo_init()
>>           ...
>>              ttm_tt_create()
>>                 bo->ttm = bdev->driver->ttm_tt_create()
>>                     virtio_gpu_ttm_tt_create()
>>                     ...
>>                        ttm_tt_populate()
>>                           ttm_pool_populate()
>>                              ttm_get_pages(ttm->pages, ttm->num_pages)
>>
>> virtio_gpu_vmap_fb()
>>     virtio_gpu_object_kmap(obj, NULL)
>>        ttm_bo_kmap
>>           ttm_mem_io_reserve()
>>              ttm_bo_kmap_ttm()
>>                 vmap()
>>              struct virtio_gpu_object bo->vmap = 
>> ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
>>
>>
>> virtio_gpu_object_attach() <<== Sending attach backing command
>>     virtio_gpu_object_get_sg_table()
>>        if (bo->tbo.ttm->state == tt_unpopulated)
>>           virtio_gpu_object 
>> bo.ttm->bdev->driver->ttm_tt_populate(bo->tbo.ttm, &ctx);
>>              bo->pages = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
>> sg_alloc_table_from_pages(bo->tbo.ttm->pages)  //Getfrom ttm->pages 
>> and put in sg
>>                 __sg_alloc_table_from_pages()
>>
>>
>> There is a separate userspace path for example when displace manager 
>> kicks in,
>> virtio_gpu_alloc_object() followed by virtio_gpu_object_attach() are 
>> called through
>> the ioctl virtio_gpu_resource_create_ioctl().  The mapping of the 
>> pages created in this
>> page are handled in the do_page_fault() path in ttm_bo_vm_ops's 
>> ttm_bo_vm_fault() handler.
>>
>> do_page_fault()
>>     handle_mm_fault()
>>        __do_page_fault()
>>           ttm_bo_vm_fault()
>>              ttm_bo_reserve()
>>                 __ttm_bo_reserve()
>>
>>              ttm_mem_io_reserve_vm()
>>                 ttm_mem_io_reserve()
>>                    bdev->driver->io_mem_reserve()
>>                       virtio_gpu_ttm_io_mem_reserve()
>>                          mem->bus.is_iomem = false
>>                          mem->mem_type == TTM_PL_TT
>>
>>
>> I originally handled setting pages decrypted for the kernel path for 
>> GVA to GPA mapping in guest
>> in virtio_gpu_vmap_fb() at the virtio_gpu driver layer.  But for the 
>> user space path
>> virtio_gpu_vmap_fb() is not called.  Mapping is handled in the 
>> page_fault handler.  So I moved it
>> to the ttm layer.
>>
>> What layer do you recommend as more appropriate to handle setting 
>> memory decrypted for GVA to GPA
>> mapping for thos ttm->pages?
>>
>> Thanks
>> Jiandi
>>
>>>> Signed-off-by: Jiandi An <jiandi.an@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/ttm/ttm_bo_util.c | 12 +++++++++++-
>>>>    drivers/gpu/drm/ttm/ttm_bo_vm.c   |  6 ++++--
>>>>    2 files changed, 15 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c 
>>>> b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>> index 046a6dda690a..b3f5d26f571e 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
>>>> @@ -29,6 +29,7 @@
>>>>     * Authors: Thomas Hellstrom <thellstrom-at-vmware-dot-com>
>>>>     */
>>>>    +#include <asm/set_memory.h>
>>>>    #include <drm/ttm/ttm_bo_driver.h>
>>>>    #include <drm/ttm/ttm_placement.h>
>>>>    #include <drm/drm_vma_manager.h>
>>>> @@ -639,7 +640,11 @@ int ttm_bo_kmap(struct ttm_buffer_object *bo,
>>>>        if (ret)
>>>>            return ret;
>>>>        if (!bo->mem.bus.is_iomem) {
>>>> -        return ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>>>> +        ret = ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
>>>> +        if (!ret && sev_active())
>>>> +            set_memory_decrypted((unsigned long) map->virtual,
>>>> +                         num_pages);
>>>> +        return ret;
>>>>        } else {
>>>>            offset = start_page << PAGE_SHIFT;
>>>>            size = num_pages << PAGE_SHIFT;
>>>> @@ -661,9 +666,14 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
>>>>            iounmap(map->virtual);
>>>>            break;
>>>>        case ttm_bo_map_vmap:
>>>> +        if (sev_active())
>>>> +            set_memory_encrypted((unsigned long) map->virtual,
>>>> +                         bo->num_pages);
>>>>            vunmap(map->virtual);
>>>>            break;
>>>>        case ttm_bo_map_kmap:
>>>> +        if (sev_active())
>>>> +            set_memory_encrypted((unsigned long) map->virtual, 1);
>>>>            kunmap(map->page);
>>>>            break;
>>>>        case ttm_bo_map_premapped:
>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>>>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>> index 6fe91c1b692d..211d3549fd9f 100644
>>>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>>>> @@ -249,10 +249,12 @@ static vm_fault_t ttm_bo_vm_fault(struct 
>>>> vm_fault *vmf)
>>>>         * Speculatively prefault a number of pages. Only error on
>>>>         * first page.
>>>>         */
>>>> +
>>>> +    /* Mark framebuffer pages decrypted */
>>>> +    cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>>>> +
>>>>        for (i = 0; i < TTM_BO_VM_NUM_PREFAULT; ++i) {
>>>>            if (bo->mem.bus.is_iomem) {
>>>> -            /* Iomem should not be marked encrypted */
>>>> -            cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
>>>>                pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>>>>            } else {
>>>>                page = ttm->pages[page_offset];
>

