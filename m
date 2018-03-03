Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935321AbeCCAQV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:16:21 -0500
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:26568
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932890AbeCCAQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:16:18 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH 2/3] crypto: ccp - return an actual key size from RSA
 max_size callback
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "Hook, Gary" <ghook@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <51c265e4-6153-3e5e-316a-ebef059ac36a@maciej.szmigiero.name>
 <20180302164451.GJ21579@gondor.apana.org.au>
 <087e7b27-f839-8d4b-8da8-5d0fa2f8caf1@maciej.szmigiero.name>
 <bcf42353-4b07-a14a-e76f-6c520b7b0ba1@amd.com>
 <7deb1115-b4b2-8fe3-885f-0162f2fe359f@maciej.szmigiero.name>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <d3b268a9-1ebe-d9bd-01db-a513538e74c5@amd.com>
Date: Fri, 2 Mar 2018 18:16:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7deb1115-b4b2-8fe3-885f-0162f2fe359f@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR21CA0068.namprd21.prod.outlook.com
 (2603:10b6:300:db::30) To SN1PR12MB0703.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b254dba8-d2cd-428f-54db-08d5809bfa5a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR12MB0703;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;3:ojSrySlvrLH4ysj//mL/f5gAJlyc9FoT1zvUUQ9AGsHOAo1ciq8zSYwdv1t1MkWJt9VHUo874fP3SaWmMjHIdAHM9jn+oJsw63Z5ugZcGqN3qEIECNp7r8UTuX40+tGXX6u7YRjLImf6JDTziDaer9aPgnL6zEwoCPHG3dkh9sI8b8XIXz/y1TpkpvH529v1mXabZoL0KK6kPWV2jOlEAj1Jr0xEHfQLOEMdzTZSHp641E3jhKu2FD7/Vbchn4jL;25:YfI/gL6yZVCLDNjEYytpkWC7bGmGtj5IIcSCZPM9KcjqHenYZjT2kkYQYSF/VNTvwlwh7QRYWtSJwKHt7L+wgJutS2gxoXmuIKi1nIn6Yh6vm87lrTokhh8TfDdH5Nj20EHbSXN+TuBpti7D1wZHv78rnjyVjmrFCFXU9+ngW9SqJ1h+b/fjdpzZehr2ttjr443BwIFj6XyHXM7XwBXzrr1YUtkj3nay37hdGhgVg2bJqd2UYzykhnlE8kiVjv/GQWlJh0Xz/26S+w5JJYTokQb9OfZNUcgj3RIwbXnlOGDn+QbNnnLsBkBR+/+Fix7pnoGRudnrJ6ZQgm1cmv2e6A==;31:Y6YKpa3uk4rCHdDuu0lHRJtwHjN2wxH0za65vETnTbUwWGcKhDzaC9cRV5CH187+hESnilBmAazY3VOeH3En76Qwnj49A0CvKGyW6ITEyoVPtGKBb3nWTCzWVITJPtzkhoyMeBMtOL2QVOdL7wdav6J5mV+dHkr61+XqYgQ+FkhTqyE1R6fJRMNyQNiVNxOqZ+AL91mp9R2DpgAC+mv5k3giemE/0JCgVpIT2Rj9I7M=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0703:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:edOOsVB+EVzlRu7FmvSLFrQs3/AMnG9hoq61etkPXIkVgy3IS1q7cEqHd7QGfC8gYbo7t2++nqT+sMakMTASraCacLa/LJMbnI2d3eoBh9V+vHWf2ABb+B01unJJbV2svrTvGTA3LS8ABTmkbjcqdIvTJqKbPg1ETd6fVScmG03WQNDUaaxKvMM/dn5pJn7mHJq7ciL1+pHaJy5chv7iDepK6TocRwzERAPIoGYYFjyvWuvu927KtXbMfxUSf+8XuAPJOcx5sABmJhDM/c7ZoOqlv7dqLdOb4UGwIiM335A5WK7K/rVF9XtiEL9feuccU2Gjv6rMATxNi8gW5GPb0G6yPWsptxrNsK7bNm5qLX86BQ687m9N9qwbkpWj8xm2qj3F/p+LgY0GXyK48LvVWjMJWhGXWaMa1m60djseJqPIt7Ef4Rz+oBrHZsT2fcANZ+k/iu9oK5f3bOp1V1S/RqnSjwVPDPpZYK9bbyn6BHxnWhN4LTBLJd/SbqYVVX8m;4:k+9fIS+DI15BW6CL4m+eE3tCJp2Z8H/+cb4Wu7lKF+3nyFZ4GPO7IH6LMuZIxI5SSXuQSIxL9xjDFyPcoq8HzqX+Zngz4FDfz+ClyPFZ1M/1xSGCVSSts6qiZqRw6DxFcUpnE9Sc4gy4U6YcWtZKpb+dj3/e1lzWXxQV3+i91lc/2fPVedhgJCOMx0wc0xfM9eywrPCDnCSKj7RqpjyIGbCdiJj58N0oVCDDHz9KsDvPfrvBekkbKcIOMP8mOYrnNhZlfhjAZxiXrnylw5QoWA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB07039CFAABCAB69D01E059F2FDC40@SN1PR12MB0703.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB0703;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0703;
X-Forefront-PRVS: 0600F93FE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(366004)(39380400002)(346002)(396003)(189003)(199004)(64126003)(6486002)(4326008)(86362001)(6116002)(3846002)(2906002)(230700001)(93886005)(106356001)(6246003)(68736007)(1250700005)(5660300001)(97736004)(6306002)(31696002)(305945005)(7736002)(53936002)(16526019)(186003)(72206003)(478600001)(23676004)(52116002)(52146003)(2486003)(76176011)(67846002)(47776003)(26005)(77096007)(53546011)(386003)(59450400001)(8936002)(8676002)(81156014)(81166006)(36756003)(966005)(58126008)(110136005)(54906003)(316002)(6666003)(6636002)(2950100002)(16576012)(31686004)(65826007)(50466002)(25786009)(229853002)(105586002)(65806001)(65956001)(66066001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0703;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAzOzIzOklLUytCemJWMGRDRFdFNzRjSTJDc2M3TVdy?=
 =?utf-8?B?SFpnY1YyMGZKQU5GR3N6MmZ4Ymp5TGdaUUdhWGtESWFXMGpETGl2OGFWUlVF?=
 =?utf-8?B?a1NnV2FSQ2xxbms3eWF2TncyNjcyWVRteGZXaU9TMUd0TkI4RGdYbkVqQUtp?=
 =?utf-8?B?K25MYjN0Q04rUVNqM2RiT3dUQVA1RXVuaE10RmpUZkF2SjFtNHFaN3g2bUhY?=
 =?utf-8?B?eFRsaFNVaFdtUE1qcHBPdFlJbzYzSzg1RkZiOUhBKzU5N1ZoZGtkcUZiQ24y?=
 =?utf-8?B?TWVZdE1JaUVHUkp0OVdTNW1oaHpIU3J4cE9XWmE5RE1MS3NIN29tTDVwcE5h?=
 =?utf-8?B?dHI4Nld2bEZjZk1hS0pEcnliOUJ4czZKMmlOekNIMjBXR0NUbEpjSkFVNm13?=
 =?utf-8?B?RkxqMmlNNngvMHJrQjZvSndqOGJhM3ZGZmZoRElmbnN0WjhXaTZLa3hmSDRq?=
 =?utf-8?B?K0JvYjRJTTBGdzBmNUVWbmwvOGFwWEFZcW5zMnAzNTM4Vjg3QmtyVVpZZmll?=
 =?utf-8?B?OFdFc1JyVFpNL1RUNGp0YzRmUDd4Zy9XM2ZlanBOenFGcStyR1EzWmNGaUM1?=
 =?utf-8?B?b0haOHdmalQwamZhb0NIelQ1YnRNVHRKVG85dlJtMWtLZ3hOLzVDbWZGbEdY?=
 =?utf-8?B?aEpPRW5pL2VOTUsvd2JPalVZbXRjYXVoUE9TcUhyNXdOeGZ1ZGpHVmNOZGhU?=
 =?utf-8?B?NDg0V1B3RjZUYVR2cjBKTVQ1Smg3MWVGM2FkeEdYRldIVCtxQXI1cEJORG1J?=
 =?utf-8?B?UmJMdGdKczJWZzVpZkpZNHMwMjFORFR5ckFHUy9zOC9nZ1FrZHNHemNBd3Y5?=
 =?utf-8?B?emgzWGtyaHZKRXByR3lvWkFXWjNHNC9OZlkyOWR2YzExY056bnVGcVlrNDBW?=
 =?utf-8?B?TUN0bnQvM1ZWWHlnbzNpbXBESE9QbnZUeXhDd2JkTU5IQVZmUU9YZnIzNitw?=
 =?utf-8?B?ZktScDQzREk4bTNoYklyTXAyc0cwWE83NkQwYTh6RmhoakpjeXFwcGFUYy9V?=
 =?utf-8?B?YnZHalJ0S3BGbkxrOGhIRjhuZmZOUzNXbWZIZ1BpdklMVmdqcGlnMzl2NW5p?=
 =?utf-8?B?anhYTmlpZmsrcHpFU3pYOVBYRUlYYXp1STdkVnRMRStnQjRVOWhEc25OaEQ5?=
 =?utf-8?B?dUdTOVI3SlBjSXI4dWp1YXRxQ2VwdkFkY2loL0J3eVBGejhjeGhSemRkSHFX?=
 =?utf-8?B?aXROSVdTL2lzWm1WZGlsTTFseGlTc0lvUDZjeEg2bENVZVRTU3NNcDdnMS9H?=
 =?utf-8?B?bEhvUGlZTVVQNGprZGZZZDJYRmtvbDR2TWJybTRjRzlSY1J1b3E5RXhZd1JO?=
 =?utf-8?B?UkZhSEhrSjBpa3FRMEozYTFiNWEvMUZiWWxNaS8xK3g4MnVHVkJhNkVpZVNR?=
 =?utf-8?B?MzNWOGRWSlR5TkxGRGw5dVFlaVF1S1FueFd4cVNGOXluMXREZWdlWmZkRGtR?=
 =?utf-8?B?Mm16bUIxbml6dXBOMUJHSTFkNkRGQkVjV3IxekJOVVQ2YWNlK2RtcEtFZTJZ?=
 =?utf-8?B?NDBPMEdaUHVINTNLbHVYZkRUQ1UrMEhoalhOY3F3TnJCN1pVWkdTYWtxM1hK?=
 =?utf-8?B?MHVITnY2c2xCTTZva093YXQ0bFpyRjdQcE1xRUFqNHpzZjhiekZTNEJxSFNm?=
 =?utf-8?B?ZnFNRmZaaXlCSVNFREtoMi9MUGZ6TlNqK0VMSDM1eXVGSGIzU3pHalNqOVFt?=
 =?utf-8?B?LzM4MTU0U2p6LzFPZDRaaUlnUDQ5Qnh1emxrdFdUVHF1QXJrd0pUZXFBdEVy?=
 =?utf-8?B?c0hSYk5jd01xUmNLT0FVRE5uVW81NE5JVmU3b3NTRThVT2VtRjRmL2ZFTUxF?=
 =?utf-8?B?WVZhVWhOMDUxOVhvWkYxMkF3UTYrQ2FDa1pIRmFua3VJSk1kYlZGbmZSQ0NL?=
 =?utf-8?B?WTVCTVZnSytKZy9sWGlsSEpTdDhDaW1XOHB5b3BRZFJxY0JRT3ZnNUtrME96?=
 =?utf-8?B?dkt2OXVWMWVUYnBlSkN6S01IUk1LZURmMnVteitRTnZRVHF6NXlUL2VzVFVX?=
 =?utf-8?B?NWZMckZIcTNrVHYySUIreFZPWU1NSzJzWnFvd0tMVTJVRmtmZW1IeXFKNHdz?=
 =?utf-8?B?bjdvaVFEVFNxSWxXNFBZQVNYR1ZBSlpRMUJYckE3SnV3ZnFBVDBwc21KQnJB?=
 =?utf-8?B?dFE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;6:zGOQqXI9ePfuFd+b1zEGBul52BVAgGzshIjnL8EMLCGlWVB+dOznLBNCQGiXgAc4dR9rLVo8yeaURqkz8XYJFWHGhxN4EuYGbV/TMhYq0YviSw4fndXM8CFwKsPw5i/8akXGot89oDe8BwYD8yeJh29xR8VMHCMQbSTvF7lRkD3Z1UDGPCZTiOpHDAKtOEdPxPp6vzG2J0ag3TnLQHvsXSC13mjHo1dDk7iqA0yOd9Bfsd3dZgF25MOztEa6VQbf4U+c5zUq/sv/aPh/nJUC1ymk+WQL+cp16JBvzedexHjrkED5zzVV0HgweckwSLhdQ/kbmSIXpAs4JaDoTf0nj7+FZMAv3MVlUHmonfofym4=;5:hBwor5zhvEqQGchOB1tipOH4tTs4YrXsWromXtx/rV4m4ywT9D+CVHJxJfom8If+/IaJKWz3hD8ElSiNlmxl1SCLV58nTS8pmXavmmYRKedqImOxyaQWQQNt3IYknZo0vKnpBIo5TmkHpLVSCsEKcz1uEY4gNwkOAbfGOVUdO3Q=;24:wFpsOsD3TURoH1G5XGzbzxZqJgFlqx6JzxXEVzIm1qmoQ6O0TpC5ZV3i0/lYJfaQpOwtgKZkuRjseKaf19CJlmXJ6ki+Owy+7twk4j7bw6Y=;7:4o/8GSRYuZm0DxpphF8naAbVnm3ftcIsfQM1HadM+F/6YK3zE6YmWhF+HTVwqDEJ0VUN1eRn9H0oXn7e43vXn+SpbhXzEHpbkdWNFnfs2MKoDAPLB08Snn0TpzxBwHG1lgVB3iJbRhyJrO4w87Xjee5qcpbW1sWJzEG0fg+AEX4JF654dXjudtRE6+z7wO0hucHmrZTX+yjVpsgY1+9Slyra2AcsN1otorje351pHyPb7JCpmoo43jPkCRl1TlVW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0703;20:43bba+ugLkeKv2LSp+29DMe346x8e4ygQLqJS8QpEA6451TjOUMDVaUVVjzMQ8GGkevsrBx1dznymWDgCOoBQOjCTgYi0T8mD48kY7V4bAXPN/zJTFUe1rXkhflBb3F6DaEfJcpPMbq7QWU5ESeeU16/GHnM3OoUIYIoWHI8FiH4mElYehfGk65nO7SRh/ZGOW0noR9mg7sYetwNVzO7FIIaNKJ22h8qUyq5j+B8MpXP9feqJe1oXzaTukq6/cPY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2018 00:16:13.8490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b254dba8-d2cd-428f-54db-08d5809bfa5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0703
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2018 05:58 PM, Maciej S. Szmigiero wrote:
> On 03.03.2018 00:49, Hook, Gary wrote:
>> On 3/2/2018 5:15 PM, Maciej S. Szmigiero wrote:
>>>
>>> Thanks.
>>>
>>> However, what about the first patch from this series?
>>> Without it, while it no longer should cause a buffer overflow, in-kernel
>>> X.509 certificate verification will still fail with CCP driver loaded
>>> (since CCP RSA implementation has a higher priority than the software
>>> RSA implementation).
>>>
>>> Maciej
>>>
>>
>>
>> I commented on that one here:
>> https://marc.info/?l=linux-crypto-vger&m=151986452422791&w=2
>>
>> Effectively a NACK. We are a reviewing a proposed patch right now.
> 
> Your earlier comment referred to the third patch from this series.
> My message above was about the first one.

Apologies; my mistake.
