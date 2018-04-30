Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZr2vJYPF1Vj4e0O1Pm9dkjTInZf+mO5hm55U5XF+m+hE7iVFu4/6NIckZooSqdFaeF2khrQ
ARC-Seal: i=1; a=rsa-sha256; t=1525076255; cv=none;
        d=google.com; s=arc-20160816;
        b=RbXnxzKaogBU/TVbsmJmJrHqSNjBDCE5xuyZ7iAiD5gQzyl2lBns3nw+vx9cwyCHTA
         jd+zbqIrWnPaP0robwPue+VunsEhkCUgJK6yFSMfEj1veI+lMtDoNj1Rl+xjhqVEtoWh
         QSvE7CSDy62/mBpqO6OkreAHR2xYE7gnXKtN+ClEom7gCR27zIFQEC+149yURipc5PXW
         YE5CvT2OXDu6lXCSuV0lYktqWnTOjYq1z/w9RrgjhBa1uLEvDEM76eBRBUEJZ/0iim0K
         wnors18Y88eo8lzRkbBMKoTcw7+pgBmU0MUe9eFacG6sdbSdDlEo1UwnJ+CuNAYdwR72
         rkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=WHzoQI5z2b0VWT4/pGIz6BNmyaZtfkic85Xr22DBlKw=;
        b=h5J4zhPjym7NsIo+hA5RqUSINdOrIAIXXmeWemnNvdONvm+f5mPeEhs46j4aE94iUp
         CbqST7SkEN6yX9L6ZUP4Fh8heQlTN4vTtaQnT1f0Vawp2g62/ye9/gerjRWGtHeV/N08
         ag+CAVJ0PUqSLTT6Hwi7m/hqJnOm/aqAysfq2TyjsiqZtMCSQOJFrAjt35btDmem+zI5
         HAkYGI3vATd/qF6+9YsGGMP0OfKV3myYngxyegXAc0jzAwSpS3krmZaNBviG2EJNCmVo
         47Q6rgtC7+6Z/NRI/Ms68uWUDNLQQDx3jAbkelQuk8pluXKthAsGJVYED8OptfBXTibh
         pcWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=PsxZAAZ1;
       spf=neutral (google.com: 104.47.32.84 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=PsxZAAZ1;
       spf=neutral (google.com: 104.47.32.84 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH 05/11] ASoC: amd: pte offset related dma driver changes
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
 jclinton@chromium.org, Akshu Agrawal <akshu.agrawal@amd.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-5-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omAH+W0yRxS4F42LOyVhKR3mTsNA1wXP-RQFr-BF6f_JJA@mail.gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <fc57902b-1610-52d2-914f-c2539a9fab69@amd.com>
Date: Mon, 30 Apr 2018 13:49:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omAH+W0yRxS4F42LOyVhKR3mTsNA1wXP-RQFr-BF6f_JJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MAXPR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::34) To DM2PR12MB0313.namprd12.prod.outlook.com
 (2a01:111:e400:50d0::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0313;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;3:/V4dtw6ofdBtqZYSY4fwSPhvch/CQOd4bvVNms+vXKL4jS86ZtqFsHCwy5s61AFOiUVB/qDpXYttKnm//qD59Fxna3AYvjm8xGB9U7Ud41cSaH05l1Vy1A+GnzPZxH8Abnuq2enaiPyiAi/8J8KWJ3dwXIA6K2S93Wd0Tm7zVj4URFsjM6/RX8jcs5aSx8A0sw8GhamaUy/gJPSQfvFWCRVseBXHQ7VpeeQAnrK+elZAC3r4z0ogOgxWGR/dlnNK;25:LVzaSGIaCjeKDXyKfEYEfPUM2ldrGlSrwKE5m4xIFWeTr9tXx1to5t/qpkyxnlt1bkjuVzlBGy3cAl24nVVPekul8sgNTHFJEFKxX5KCPsV4GnIa89Lg+tO8tg72e3cdVa1I//0pWmDXkmzNFEuUdu5R7k2ku9gGyNpSjO4CHNnIzogyghCjiZwt3tmlVtCMT7ewAC3GnMZlh+eKoMxuvxve8cWzdEbc8Uh0eMg+twmSo1dUc3yeYJZC81qLIUBhv+lqgZx9jAJSC/K+aZA1OwH/Nnv2Ya20D9iAyUhb/SymoSIcwB16FvmR6czQzJNJ4fP1qEzj+duOuMUcu7SQ5w==;31:P5kHBu8I0xyWs4jOWpj8QxrV8iZG3brnukhOhQrwT0VLlKdT9u+sb8M48wNc4Y+VSfpoPUUWd3dd/4Ckn+4gU1mD61+biYfNdpGkJornQEAbb8sOjEiStitclDboMGkHpBxd32lm70Y1rSK+ZukK6xyXD7D/4TVOU6ZWBpxABizqWRya1egc7d/8sSemb7Vn5kP9ELtoNULwM61wSW4envyZsyucfiiXr/lCQkAG9bI=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0313:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;20:c1UfictAVq/lP+MELwbApW47ljr4LZ2AwUuf2h1hIKoEClhLlYKoTXEDkhxrNRfUt3a+ftvSLDxrbxq63oukdHZpx8VXywndXe+1jZk2Xo8+Cl1FEKEbh/64AY4sesgbUZiDRQsx4kKNXL5s/KB2GnlNANyZLQkGlrnmgV3Vur2Y/kSeBbZ4bzHKQf9BdW7fzdPCYxzmoTmlM/rWoo6RwtM7SgeBxaGam8T+klhmt0Qt3dRFQCynoIKL2Dtc20kHToVl/k2KQKLUYEx8iWAzgrp1+OKcV4KDNEyZVlRuWYYu7Q9PpcGKwEoZqf/j0gFAEZLWDIZAYMCFxbDiHK/BrJYb0L+756IrbSq4XDPV8b7bokruSm5VyP65vG770zl/656tS/nh85QoFxR99oZ+sK6e3T1iH7g6pps4/HOTkaxxee+Yb5clHTv0San969TBQN34HrsUzOHJ1q/mqYFwKPrryFTkcreRvgUX0FUqyn1Jh9asmlxDIVxCRqtcns+c;4:o4m/c1y1EUDqHyIYZZMhshyzjv2FI63J4zNe/tlfq91s1kyf62tfDV4uX/H0xQrQcEPsiBxaWvnhP1vizhJgdQkEhVu1s5Cidl5Or9SztmM8DsCuOvcCKJ8v+UlVRFb92GGpSfMxWyAhUouE5i+ghOsNzETILXsxSy55AL+P7plee1quchV37OUUlUZ6IuEgnChcz7HlUXQwu1Co60VwNl9rYKF/tspFLU3QqjBomFuPPi8YM+b9a7uPJpvnsE0YeWuF0/AKa5lUT/1E09FNN3HXxiaI1NzdZK/TNglQZA58K/NyNfiaJLT5lFQFdEbU
X-Microsoft-Antispam-PRVS: <DM2PR12MB03139F346B18F67FD683147E97820@DM2PR12MB0313.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR12MB0313;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0313;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(77096007)(6486002)(31696002)(305945005)(86362001)(53546011)(105586002)(25786009)(6666003)(386003)(31686004)(3846002)(7736002)(956004)(67846002)(50466002)(2616005)(64126003)(26005)(2906002)(486006)(6916009)(6116002)(97736004)(476003)(316002)(39060400002)(16526019)(23676004)(52146003)(186003)(47776003)(8936002)(8676002)(7416002)(106356001)(6246003)(16576012)(58126008)(4326008)(68736007)(65826007)(230700001)(2486003)(52116002)(72206003)(478600001)(5660300001)(65956001)(229853002)(53936002)(66066001)(81166006)(76176011)(65806001)(11346002)(446003)(36756003)(81156014)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0313;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMzEzOzIzOlpYOWdBOVZkVEdaTFJ5UWhIU2pPRGxtRmli?=
 =?utf-8?B?Y05HWklPU3JOMnUwYUpqeHJYMlI1TzJBUVdrVmppUjlSNFJ3aGZ0eTAwaEdP?=
 =?utf-8?B?bThIVFAxUTlUV3h2T1VCYUdBQXI5dzA2RWdXR0dESGtncFYxV0xyQWNndXBj?=
 =?utf-8?B?c2JXcFdOZkxLcm1uMXY4ZWc1NDRnYkpHNERBTmwyZm53MXJjN2NXNTE2L3Bl?=
 =?utf-8?B?OGtFanh6M3MvaUxYRTZoYVRKaEU0N2k5RElWK0JvaEdyaTlKWEprRk9pa0Fi?=
 =?utf-8?B?NWJjMGJvYzJUT01wZTlLL2Zla2Z6YVZndDZnaEVaQjg0Nk5lV2U4ZWlDKzVF?=
 =?utf-8?B?Y0ZaaHY3SCtRckNnNlJsaWZjQ1lqWVdSSWhYamJFYlFWZWxIUHZIaDQ4Q3Ev?=
 =?utf-8?B?Q090bkc3dEpLdEZQa3VOVEhCenFVbjdJS0haZUE5aUtPZjU3RXdMcnFvSkRV?=
 =?utf-8?B?eVpoMStHcmR4SzMrK3pLZndBWWhZajU1aXFhRlJrMDFKTE5ZcmcxbXQvUGtm?=
 =?utf-8?B?UTFseXpFcWJrM21VY1hVenN2bHk5QkRjdHJxdndUd0F1dVgzd3JoSnJZUTF6?=
 =?utf-8?B?T2Z3c2NNQnV3TEsvcjZXTHZzNVh0NXNFa3Z5TmxpOVhCbXptNEt0SG94QTZP?=
 =?utf-8?B?VkFQZzAyUzMyaXlIOGpsanNLZXhaRzUrWnRKSHRMZmJ4WkNkNFpaTFV3Mms0?=
 =?utf-8?B?M21IT3NGTHJUWGYyRU5UaXFKYzc0ZDBzLzJyUEJuK2N6N1dGQU5OZVhIU0w2?=
 =?utf-8?B?SEUrZ1R4cnNVZ2xhMFlFaEhhUVJCQ2hjK2J3RThNTFlvcU5VcjNqSmtwNjFH?=
 =?utf-8?B?Z1NQcVhZQXl6Uk1FWjRKbVdPRjRqTDRPV3BMS0NCQVNIZ0lRSThtOFhwUitm?=
 =?utf-8?B?S0VGMUVTdTRWNUgwajcwWDlsd01PZEZSYm9WNm5Wc2R0VFRCNVBVVmdCdisz?=
 =?utf-8?B?L1BpQTIrRWNEZU9xZW14ZlZiUFdXOENaVXR6dVVmKzNkRFlVQ2JjZFQxZHQv?=
 =?utf-8?B?cDVKckxhWUwzZGkrbG1kVkVRN0FFbUJ0bGUrbTNNSXFRejRDQXF4cUlIWURO?=
 =?utf-8?B?eHF0eXh4bUlodE5aN01xSEMvNnNGR1M5SlRRd2hCQjhCbG5uSjVYUUE5ZTBP?=
 =?utf-8?B?RXYzTUZqM0JkVk1hUDV6bTBXc2grT2tIRVJjcS9RWGdLZy9yUUNUeUh2NjQ2?=
 =?utf-8?B?UWMvL0EySXhYeHhybC9SVzhhWXpOSmx1aFdzeENXb0ZBazRVMUUvS25BWUQr?=
 =?utf-8?B?OWVvQ3FScWh4YlRLN0F1RW9JZ0xoaW5Db005eGhabmFPTzVmN0RhNXN5Q3pQ?=
 =?utf-8?B?Z0tqNzhLUmZqSmhFTEhGZGRMTGNjcy9xb2VKcit2elNpbW9MTHd1UzFuWnhp?=
 =?utf-8?B?bjZ6TUhiOHNMOVpUeVgvSXg0L2Q4MmJMRk9TOWpJVzZtcGZVNlhKVll3UndF?=
 =?utf-8?B?TWVQV202ck5NWStNdGMxQ3l1d3ZHY2Uxc1B6VGRlM0JvMnNPdDVyQS9TNlZM?=
 =?utf-8?B?OGUzTm9sNjlKajlUcW1jeWc3QVhMNFFVRmlYcHhoN3JwSWxKem41NVYwZUxY?=
 =?utf-8?B?QU1USUNCdXBOa1J5WUxNWTJHRkR5SFNkTVd3TUFFMnBIeFhnM2JTUHJiM1VQ?=
 =?utf-8?B?akFpMGpZcFI1QVJyMnozTjIxUS96Z3dESHZuQlZKM3VBQUNTbDRGR3JNV1dL?=
 =?utf-8?B?R3NweUhoKzg0NEhPTXBtVTgzQWVTb05aSktVQWphUnRJWDdCR2hVREJFcTQ4?=
 =?utf-8?B?Sk1NTUcyaUVOenMxL1lRcFR0THRWems0RUtibE01dFZ4RU5sT1Y1M2Y0bDFT?=
 =?utf-8?B?TjhDYkVXTHhqRXNRRmpSUXhFVVRsc0JOcWUyTnVsSjVGTzVsTzdOTG0yZGlG?=
 =?utf-8?B?N1lTRUpFR3Z4QjFuOEZCbEZUVGl4bXJEWEkyNlZ6TUs2WEhhOFRvemEyVUhT?=
 =?utf-8?B?REpGN29CS01YTzZZQ0ZDcmxsSmNhOUZZZUpLZnZkQXUyOHNlOHZEZnZNSFgr?=
 =?utf-8?B?U1ZWOG5GeVM3eWMvRityT25RSUtob0xzQUJEMkFyOE9vYnZYY2ZHMTlUa013?=
 =?utf-8?Q?ATfgcKixqidM+VO6pR6dVeaay?=
X-Microsoft-Antispam-Message-Info: SxqyhfDvIRDk+MoJXAiINFTMJUW0+yHqcZ3hCYNfEeaDx+uXYEp29kybbl5l4rmmbl9QWBY0WsWJ0m7uPPYSqu/G30tRVW2Mq3qNCZKs3xF9JvVEKDpwEx9/G130vtqg1Pfk5oW0AMr0rWntbwByg9seED70LhXgBM8GwloO/MM43rDOmveCMFDNFxjmW8iC
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;6:+Iajaxsuw6hXFhpY9WslgLB5QBQfUJrifWpvxj8UlI/Yj7fJeT1yg284xWgl60TibX6dRPjy/F7ojnlR66g6G++lk6RO66nloCvF9yywg2SbBBc1BXgrTlTvIL3Q4bDQ0+np+1sBFUAFqFjOtraF5DsWSUUkeHi1HMCvzXbsbWCY9BAZtMSPVeG9a6RswyAiBeegVehgS4xTqLRHaMrO7aW+FxVZ1j4djfsjzc2XkdoD3ulg6H81qHBdIPYXGOVx5hqYJQ3N2vGTHNzw/nHRNJW++bhw7GkVaDinGcKbWb9HPw5EtYO8DT1okfAFkeqjTfUs7dnj4K6OdZLmuPpePFiUcBaNMDq33mguUh8pjarTKxuR53pIDr9ypLgLOPCV4dCneYkHslRcjb4SA8D6ho54mxAYmSYpDCu4/oVkbcqjDwX5iWytAQpntDYgq9RnIYc1WHW4KMCEOUFDwYEGOQ==;5:ixc+W9nkW1ykr+i5Ck/6PGA8KgnWTve/F8smBdbDzeoYNIRPvF4cmooIPUrSXWM2TPTjKD64hoH3rXzOrw2iDfOfSxV1O9nL5FnRkHqq3Zw9OS4SmGKPeeOyn5InbXmgqwEe5LqLvaJkIgDT1gDHM3i+3vUWUzmH1Mj/lFQtklA=;24:7xzvIBmw/Rq/fVKKoLAEcsuGBwCtq6ekRMIBinj68QFC86TApQkQsweaWpOK8zcKmsQUvDB7a1Burju2akAxoyVMxtIpD3UsoAk0U0QECYI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0313;7:50gtV9jj5ha5vqEzXJUUTNM4CWOWk+uTPQcnWvwr7mCWn83RWdEFuoVA6VZC19FghOJjmGfxc+u84vMfIel5T80g98QN8v6gFlZwR/ACbW1Ys6sX0qVlf3tu4jXwCbEdYJaQ1p0j29ni3xQ+BHoSoBdj0y/KvhsTRCeZ1k5iAau4VBdCmT+muW+kOHx7n5MxKLE1yRgrNpJ2p8E9npdriSuFJGBboJJWaWHFyHTdRcrrZKikgGaPoabjAqbEZ8Gm;20:O+X/CBcEG5D9yeoePl/QOQfhtDfJHP6jxI3qJ+lqt9hueMK4Jf0LlFbsOLserhzhjge5jndbfPujFDpIudmIAuF4DfNVmP21YbSfxhsc6UNbdPHaGN6I60894XvJ4ylt0M4DjSZ658QvRGpJUrV/inqAhoh0e2UNohhaxyNWCvN3wcPuf7GSQloHZlh/G1DZBLxUpwGKvjYO8svuiOV0rc6p0VznMyB/PltWZOa40J/amo3keu6A41yCGzCgwBfM
X-MS-Office365-Filtering-Correlation-Id: f1770bbc-7c7b-47ee-0288-08d5ae72d248
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 08:17:28.4452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1770bbc-7c7b-47ee-0288-08d5ae72d248
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0313
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807203680552021?=
X-GMAIL-MSGID: =?utf-8?q?1599158359004753981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Monday 30 April 2018 03:18 AM, Daniel Kurtz wrote:
> On Thu, Apr 26, 2018 at 5:16 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Added pte offset variable in audio_substream_data structure.
>> Added Stoney related PTE offset macros in acp header file.
>> Modified hw_params callback to assign the pte offset value
>> based on asic_type.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>    sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
>>    sound/soc/amd/acp.h         |  5 +++++
>>    2 files changed, 24 insertions(+), 7 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index 5f34be1..cb22653 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -320,13 +320,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                              struct audio_substream_data *rtd,
>>                              u32 asic_type)
>>    {
>> -       u32 pte_offset, sram_bank;
>> +       u32 sram_bank;
> 
>> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
>> -               pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> +       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>>                   sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
>> -       } else {
>> -               pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> +       else {
>>                   switch (asic_type) {
>>                   case CHIP_STONEY:
>>                           sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
>> @@ -336,10 +334,10 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                   }
>>           }
>>           acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>> -                      pte_offset);
>> +                      rtd->pte_offset);
>>           /* Configure System memory <-> ACP SRAM DMA descriptors */
>>           set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
>> -                                      rtd->direction, pte_offset,
>> +                                      rtd->direction, rtd->pte_offset,
>>                                          rtd->ch1, sram_bank,
>>                                          rtd->dma_dscr_idx_1, asic_type);
>>           /* Configure ACP SRAM <-> I2S DMA descriptors */
>> @@ -788,6 +786,13 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>           }
> 
>>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +               switch (adata->asic_type) {
>> +               case CHIP_STONEY:
>> +                       rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
>> +                       break;
>> +               default:
>> +                       rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
>> +               }
> 
> As in patch 2, I believe this would be better done in acp_dma_open().
> 
> Why does Stoney use a different PTE_OFFSET?  Please answer this question in
> the commit message.
> 
> -Dan


We will modify commit message and post the fresh patch.

-Vijendar
> 
>>                   rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>>                   rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>>                   rtd->destination = TO_ACP_I2S_1;
>> @@ -797,6 +802,13 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>                   mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
>>                   rtd->byte_cnt_low_reg_offset =
> mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>>           } else {
>> +               switch (adata->asic_type) {
>> +               case CHIP_STONEY:
>> +                       rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
>> +                       break;
>> +               default:
>> +                       rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> +               }
>>                   rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>>                   rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>>                   rtd->destination = FROM_ACP_I2S_1;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 82470bc..2f48d1d 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -10,6 +10,10 @@
>>    #define ACP_PLAYBACK_PTE_OFFSET                        10
>>    #define ACP_CAPTURE_PTE_OFFSET                 0
> 
>> +/* Playback and Capture Offset for Stoney */
>> +#define ACP_ST_PLAYBACK_PTE_OFFSET     0x04
>> +#define ACP_ST_CAPTURE_PTE_OFFSET      0x00
>> +
>>    #define ACP_GARLIC_CNTL_DEFAULT                        0x00000FB4
>>    #define ACP_ONION_CNTL_DEFAULT                 0x00000FB4
> 
>> @@ -90,6 +94,7 @@ struct audio_substream_data {
>>           u16 destination;
>>           u16 dma_dscr_idx_1;
>>           u16 dma_dscr_idx_2;
>> +       u32 pte_offset;
>>           u32 byte_cnt_high_reg_offset;
>>           u32 byte_cnt_low_reg_offset;
>>           uint64_t size;
>> --
>> 2.7.4
