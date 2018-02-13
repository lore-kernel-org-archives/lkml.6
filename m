Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeBMPsH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:48:07 -0500
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:30242
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933594AbeBMPsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:48:03 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
To: Joerg Roedel <joro@8bytes.org>, Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
Date: Tue, 13 Feb 2018 10:47:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180213132216.gyhndywyu23cdzbv@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [66.187.233.206]
X-ClientProxiedBy: MWHPR11CA0010.namprd11.prod.outlook.com (10.172.48.148) To
 CY1PR12MB0700.namprd12.prod.outlook.com (10.163.238.18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6db0f093-9417-4c0d-343e-08d572f929b9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY1PR12MB0700;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0700;3:WNC544vjH1lO1SZssc8hZZoUojDECvKq/DqTUIaThk9jz3dGkJ6QtQ4HPrIFoXhPv5kLKEQ9cx7WFvBhRRZmYJdl2beoCLMrKkVgmdWn+XBj0xJKm6/6V0Lk3pjrawNw8r7QEueEbgP95xtSD68Rz+RelBLaty+Tat3e2JYTRXzW+c47JbsMhW0VCr50wIWviVeY4+T+XS7w5TW8eoEBXhy7KFpOWIIk/SpMJ7lRZI+xKkGoWI5vMP3NI/IUY4q/;25:U9KcqZApTKud4Lo/PxvJN7hIxpyVIxdxcHDNSwm+N1Jv3KWSrmG9cl4xPvpQq9FRIror+o+lZeEPjHQYRpzcySJaEydfHxz6VD1gfxgGB8qseaov2r7R/lDyk/BZrIpX5APD+AdP6XQq4Fsoj0YKdL8DL78rgD8NXImBzdFCY8CZygpncm3ttw4e+dSu+Pg7DpEaZ4pSeUi9hIvWmydxJIWelbdE4SJVV4m366KwAYsHfwkT77Z9ybXQ0ulC9BrJqQuyObUzxHfNasBArKwkoWcMWfe5aZLISnCA2qxloyWUA30jSTHWtpmBEjAiHSPNkrhWOeW4e58EhT5T4crxWQ==;31:xtD2GKDKOsBB6QLUiKSqNdpYUnuvCBTk7gfLvJrQP9E5A8EFHBMCPn8TcykgIaiy78l4Ewmn46XNmDfcijZaMFmuRA0MAXMQzkapkthv5erOBJv3oTo/11QjC+1gPBiERB8dU6O0f8unVfV59+6/dKN7fMd8zdTqSt6+jyO8+6YQxwwhlFA9qIx32iEwvbjD3+6ScbDOGn58OEH4KOczdqa8nUB93cF1OWnq8QoyyJk=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0700:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0700;20:ugti/k3qLtGwAyOUIr8CManjVCUMvYB7ODUBbjzwTc7eHWRwmZnrlPJRop6uGdTgli2KnR/GPFf7NR1wWwdKllayZ1hRiIgIipAH+OhsfwStnrz2F8HtrePMtdYZ+VuxH2mcXxLQCnYx7hnPrvTCtXZTMI2CVdnzS5EDA/BZ2PbOr0EZ4OQo/qy6Jtt86I75PO97JjLeT7MnBkQqrXZCzWzdmw2pte089jGbFc75giv3+5IAZH3oKo2WA1L232EFDsoSdFV3IpSiTR7n39Dr7U9xc+yIx8uilOx/VcebOI6V5r3jslb9zameSjiq1NESHixNtEoOCjFh1EGSwBROW8uf17e//fwTAR3bSA4UUcPVhG2an0mEtZHbsA8wDnWUyXiZr1qxB9tjv/vcSOQzmH+MgClMaA28hVRHKwaYhw5UzbtZKp1peo76zdb7Gu2qCPsXZUSxPqrq3GrmRAUCUOnP5OyGbkXOrRtpk98QgJpIp3yrOZcMMBiB315SF+Jn;4:UYCDu3Yn7iJJsOHnmZ1xVZSrwCItvo62uDjrgGwUffK12AVmY5p1eBiYh3efcUy/jxvAQ1iFN2pXVXfMopeCnkFuv9WBDYQXoLtRMvWJjW8RPUD8I/YsKIOwczLMMxJkAfg2B/ZFvBBDJP/I0mZ+afQK0aQjidkBc01qPlO5A3k+8bbQ3E/TCcHH+aYRxD6ondwYwolYykUEfimB5Jq74pt71Cjm931A+9mwfi8W4MgyNJqHJNKU/9MNpr3p+7Z9VEx324PoiZSzd9VX2dkXBw==
X-Microsoft-Antispam-PRVS: <CY1PR12MB07006FE17A2D1073EDB417A9FDF60@CY1PR12MB0700.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0700;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0700;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(346002)(39380400002)(39860400002)(376002)(199004)(189003)(8936002)(81166006)(72206003)(81156014)(229853002)(97736004)(478600001)(2906002)(68736007)(8676002)(83506002)(106356001)(90366009)(6486002)(3846002)(6116002)(53936002)(6246003)(26005)(77096007)(65826007)(4326008)(6636002)(6666003)(2950100002)(76176011)(186003)(64126003)(386003)(3260700006)(25786009)(53546011)(16526019)(47776003)(31686004)(66066001)(316002)(65956001)(16576012)(5660300001)(65806001)(58126008)(110136005)(105586002)(230700001)(31696002)(2486003)(52116002)(23676004)(52146003)(7736002)(305945005)(50466002)(36756003)(67846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0700;H:[10.18.17.154];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNzAwOzIzOmhhdU1vVG1mNDkyZXAxOVhsOUkrdkJiK28v?=
 =?utf-8?B?YUJBcVc1V3ljMWVqeGxEcmgyUzNraldHUjRJME04SmFTM2R6V2ZmTW05L05X?=
 =?utf-8?B?WnVrUDVaR0liL0lUQnFablFkZHI1dnBGaGtacTVpSGN6QkpPRENHWnc0VWtT?=
 =?utf-8?B?MzJQakdNbmV3aWpIMk5xZDRCNXc0dXc3dG5PMmxyNTZYemEzVGlsbjY0dkNG?=
 =?utf-8?B?a0VsKzk2dGc4YkdaTDV2cENHL1dYSXFnZ1UwbGhjaFZiNmJQUTN2andLdldV?=
 =?utf-8?B?YWZFRVJabjNuVWJDTnNUVW5TOFoza2lTUk8wdE5XYVVYdy9yaWtsT3F3Qmxq?=
 =?utf-8?B?S2ZOVy82VjRHd1dWLy90M043a0ZraXRLUUlzWG94d09kS2hlMEdYNXFTNDhT?=
 =?utf-8?B?cDFvYkVmZ2NFelp3NXVCQzZoL3Z4bTBDMXNMQmdMTHNBc0I0dUd6TFUxVXc5?=
 =?utf-8?B?SGZpMGNua2J1Z2d1cWxhM3YyTWJ0S01wQjJJano0RDNicHRxQklIR2ZFTDBX?=
 =?utf-8?B?OWRTLzRNRVdoN25MUEEyUk1PM2s4b01LM0h6a3FQWElvdmxrRzhCd1A5RXBI?=
 =?utf-8?B?T29pV2lHc2NzRmlib1NlS3dnT0s5eUN6aUpUT3Q4VmE3U1UremN4UXduWVV2?=
 =?utf-8?B?aEdHVnlUdjJjMUpKeWF3OXdUZGxlSE94VVFRdDV4WmZFVDhEbFp1WDVoZ3pZ?=
 =?utf-8?B?VVMzUzdUVUtGYmNwV2pGeHVBVjJBNFBacHQyNU4xZ2FPZjJIZlhaQU80bjVt?=
 =?utf-8?B?a090aUQrNWZreWNMcHZqNGdTcVMxMXEwL0Ird2JnRlN2OExWdmZEZUtucUtU?=
 =?utf-8?B?bUt5S3JPWkhweDhHYWNBMzJpQUVmKzNLaG1BNnZkdStlbVJYSjlPSmlraGJK?=
 =?utf-8?B?cHJOUVRsdVNMMm44WkcrUjdENjV0ZVMxUEdsNW5YZlpzNU1BM29MUTdMeVdh?=
 =?utf-8?B?dU1yS3QxTHNEazROT0laUlZDeGtIRWtzelZaRCt6Qm5xZ1VWS0lGOHRxaEVD?=
 =?utf-8?B?NCt6ZDl1OXRKWkhtNCs3dWtieE9OVFN2ZlIxZmw0NndoWlJYc2dLREdJUmsy?=
 =?utf-8?B?K3hvdnJlVDVEV2tuUHhrR2JSZUZJOVArd2pTLzRyOHBtRlFyRFFJODhoaXZ0?=
 =?utf-8?B?MVZ0azJ4K3NCUUg2Q241QUd1RWZBZlpEQjI4N3NHaS8zZldORXJOUFk3ZS9T?=
 =?utf-8?B?VmEvKzJPbzFXQyt5Z0xvcDNwMnVJSnZnN2JHbTFocldoSjZ5ZEdUTzlxVzlu?=
 =?utf-8?B?aENpSUppZUE1alJ4cThlMCtWTUJUMnZxSVRrRjRubWJwdk1hQm9ucndCRHNW?=
 =?utf-8?B?UllUZGZGTWd2RkNKWmZaM1kvc2E2RnR0eU5LazRrSFJzaVI2RzdSWno5U21L?=
 =?utf-8?B?TmMvd25YKy9sckVsQVlpK0ROd0g0T0xDNFhPTjVKZEFOenRRN0VVZXAwUmVJ?=
 =?utf-8?B?MFh1QlErZkZJY3ZmZldDMGNTUEV2b1U1US9Gc0lXUXRnUkxBK3ZJaXl2a3JX?=
 =?utf-8?B?WEdycUJBSjZPVW9yV2pGQnZJWTdVSmlVbnY0NWJPcnl5eGtzMnN4NGhkN3p4?=
 =?utf-8?B?c0ZxZDVNbDBtYnlETE1BdlBhdkNGMWs4L2wwTXJCc25QRWVIZ2FyTlNlRGlB?=
 =?utf-8?B?MTBLbDJYT2dqRS8wdWZCcFBMSis2YXRjcHk5cDI2K0FzMzFSdlpnY3gzOFZi?=
 =?utf-8?B?WWFIQzJHNEEzWExxbkwxUzlQWVR2TFRRODkvR0FYcGw5VEtHbWpISCtYcGRz?=
 =?utf-8?B?U1hNVkd5aDRiTHgrckZyUlp5U1lkS093bUthdklyd2lxbytKSHV3MnRENFBV?=
 =?utf-8?B?VHhEdmNsS1h4d3Mwa2tBc3VkYnlpY2VXdGN5K0FDM2NkT1F6cVI0MndPMXUr?=
 =?utf-8?B?Q1ltS0xHVkJLTGlCbnZEbU4wMTNyWUJtYitwTlNITFJQaTA0Z3RnMVhlbWUy?=
 =?utf-8?Q?SBoaLmgsgCS1gxLk6ReZO1clS8p9t0=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0700;6:551m0v0EaPRCGWUbVPPH6aP5LlMX3j3FpUI1jrSMYsqlOtaPB6BgFbSP4zdlJLxmKxUIRcE4y1bqnRumnYYJUpyM5Ns2Qhy3E2UHG9/CQ0l3uM2I2MYhNLCzRkmReIu22TwlnUzVnwRLfhtRRo26XXKgwqqrpleTOCtwtH5Z4j5TtFqQznRwfJkZcvIakNS4/HoRHZYUgHrDTGLw/xq8IN3GuHFEA5xer55t7MLSl2GEnHWdNdsB6CBRWhf2C65/aYJn04iA9oEDCLTfpQJeLOniPg/4SE86xCOyZEEhQ3r0q4HZjrspsAIyS/eGchRikKJZD6poICwj+DYtVoCPXQKZkk57rIT52YoTjSMBjF8=;5:gFODZIoSlQNjKGNEWQawVNzZam1TtVNbBWZDP2N8aLxE6yfqZ4nn1gr29Hus4CSp9nBsI+dn6lL26e2hDk0bic5+WKsEPwnNYFcm0emFQMz1itEl5ZQIhnOIFGYfoFNs/adFknCgAct9HvpSrutX8YKDOzq3KdJXKrzV4EfA3Tg=;24:G1yibx1r0bSZpylOeZGFIN/PXQjYD2LvkBO4USER1X/6nsdeqFLdEyHZBEFjacBCLUGw21pzK5go3r6pnZ4mhl7wG3RjeNNINsAVwjUHeNo=;7:c8sC1Vq/qIG4LTh3PiEvm8USe+82O5izsN1rNWFijn3VKaQAI3EFjoq+iDLRiQTV6/5l1yh6YcMui7SopEkLCo50ham5O+b+nmnzeRuDCrHT5EIoniNgi3WA67bDrYVsrxdAab70NCXw6FItPHN3JQRXLOnpS2JCxg71JbQmj7VopGHqE054GJgMpR3tsrDeAou/OxfK1v5BS+k6mhruIydwhorp1rMGOloiW3MjZnhrGyusTPvMd1w1WDxrPFuB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0700;20:jlfVbm6Boph1biLWdzPnhKsi9lKpRl7gzcaw+Z0Ct2RbjiXa5xhgFVKLRctLI6vYiNEo/U0jecdJNxpEgB0H1zZIOEQDlGIoTkP6NpAfiZQ3q6o/tbRII4KP64vCpIfTD1XD68gGymyX9Xpk/1BFSJrVnjxO/gLAw04zzWzfnABv6lLMOzj2xRIxWWIBItJrh71XH/4/EF20h6l7CAYJn3T+kncF06XwMq1HQmuzg5Ud0TEtCZK1i8GA8jBZIibX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 15:48:00.5531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db0f093-9417-4c0d-343e-08d572f929b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/2018 8:22 AM, Joerg Roedel wrote:
> On Tue, Jan 30, 2018 at 07:04:27PM -0600, Gary R Hook wrote:
>> +		dev_err(dev, "ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x "
>> +			"address=0x%016llx flags=0x%04x]\n",
>> +			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>> +			address, flags);
> 
> That prints the PCI device-name of the IOMMU in front of the message. Is
> that actually helpful?
> 
> If at all, we should print the name of the iommu-device in front of the
> message, not the PCI device that hosts the IOMMU.

so (e.g.):

         dev_err(&iommu->dev->dev, "ILLEGAL...

?

I'm okay with that. It does make more sense.

Gary
