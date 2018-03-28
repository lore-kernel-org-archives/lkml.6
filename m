Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbeC1FUX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 01:20:23 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:10785
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750732AbeC1FUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 01:20:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nehal-bakulchandra.Shah@amd.com;
Subject: Re: [PATCH] pinctrl/amd: poll InterruptEnable bits in enable_irq
To: Linus Walleij <linus.walleij@linaro.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Ken Xue <Ken.Xue@amd.com>
References: <20180312164530.215524-1-djkurtz@chromium.org>
 <CACRpkdaXzf=2nap2oqU0z_sTQ7XaFJGBnuk0UBE7FfNpT8mAFA@mail.gmail.com>
Cc: adurbin@chromium.org,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From: "Shah, Nehal-bakulchandra" <Nehal-Bakulchandra.shah@amd.com>
Message-ID: <a5ff2e32-662d-1c34-2ab9-16d98ffe9390@amd.com>
Date: Wed, 28 Mar 2018 10:49:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaXzf=2nap2oqU0z_sTQ7XaFJGBnuk0UBE7FfNpT8mAFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0075.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::15)
 To MW2PR12MB2571.namprd12.prod.outlook.com (2603:10b6:907:a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ab38ecb-5663-4c38-f808-08d5946b9779
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2571;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2571;3:96bK+o1HjDctOY4G3nFtI5+2vu15AzDLHxt2nkkY4ufFxVNLG/WapHHBeqP1mR4etOGibLVfK4uhl2RNVia40MIaFVwLhYQIqtZ08QoexlunOhcLIztCrF3xFLOpO3o3rAc9h2DlsiVD97Q9hBtjM54AaXg5xWG13JwwIUtcGxv71rDpaacCvYcxKYJs1iFFX2vfFVEcEoX2/wT20j9cu+ggWe6We4VCbyAcVEDj73uOvpI3s0+3niepkMO5e5Mc;25:JA24wbhKlxSb3FSnuidvySgoRvEORccFLf3IGSUMbJTIKpqkoB3D98BSxoVejJ5rcrMnh3VquFxzlRG97K9CZ+Xv/rYjcCJDXzoEoWwSSfff2Z3X0VkBSwe2BEGK96Yvvbr6mGH6DEF2l579XbkfDQ/logW8Tl54WM9dp7yngRJeL8z27D6QX7VZyZw8cOLfstey1g1jpNmxhDVtXD2Y3vGz+3nO8VrUM7X0nVpOEgY1vLqpX3rzZFsnTkfuI3X6uDG0HmSw4KHkfemO8ODDT/+rkF0iVgLM2bs/7/Jmd2NJRLpQTjxzfQ3Nzqw5b02bEpmD+ixUHd368uZhZ3L11w==;31:W4kO9ocjAgqcv3D7LbQ+f2lBNeYqoHvpe/sUnRqLICJvbVt/Hfh4sOVzXpcs2AOQ0VYpnh/ZrGFksCtPHHqNek8io/3bnS4B41cRQ4NbgAwuoK5Tv5x5M0Bxa0+KVVkYtqlb3mRUa1FiqxZuXS9g/AVjl2qZS2nia10S5orKLdfyUoetCh6wLMOQnBv8714J4bCC15ha6yKDGb0EVPxlgck0i9cre91bitIttuK28X8=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2571:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2571;20:oM4LfSZKk9OSH4Sw1bXQ13jaGeZ7t8njuy0QJw0pjQvfWSoypBMkypJIlxUXqkkbWGERvel9Foo4ARJBAr6IHJIy6WNmDUTXMd2f1SsXdSYi3eSgzAeJaniNPX9ezM539reRjnVbmgxfGetgV5nmhiEpQE4tiO8Ps01/YEJs9y9kIaO52lP5EzvKGyU7IBfYlYrjHfd5JGqRQCEXEuFofgc3K7OD9C1/C1Uw9+VsYzbgZ3LdyfsJ/ITCH16m76t4FMbzifU2EuKDMgJ0QbO0zsIIrhrmOVAxMSp5UASf1nXImYz6XkbXfD6wfsFmbaxAUZ4m3AnCCCJZ+NrZEl0X8lA8A5GiS60vOZNpAt/hmDKS0hszqUjYXda793ya5IIPqly8+hbCHtQETs+DfKTp9aP3QE1+KFoFExZNhKwcvrNX7fla6u3hCiOrge5q8fQnwyfzH/KQWUMIl4WkmKeWaMoNUW1ema56xfbTgoXhpX0k5GUXo+iFwziI8vk5OFIV;4:9yX4JYkwXvnByqVovJ6fvYQ+ePds9ebdiGmqTJatw802/lSJBEmXCLU2c3UvDTNF6Qvx4dqLMQzEahDNE7HTj2NCOSsldaM5mgHd396h6eLZvlyvKclPN787VX8n4pvpgJ1iB+F+8qXR6R1RPeO5Zs2w8QQfUnUy+29l9+bXJ1DAlBPE3YXLIs8DldMGVs2NPAZVfzfN2mQtfmTdRbBc9pQyDG2FLeINFKTIiCl06nQksVdoGL4U7oHbRjooqFhOp2IK6H66+m2sw2aoNdSnXQ==
X-Microsoft-Antispam-PRVS: <MW2PR12MB25715836520AA8150078117BA0A30@MW2PR12MB2571.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MW2PR12MB2571;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2571;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(396003)(366004)(39380400002)(199004)(189003)(386003)(52146003)(956004)(36756003)(11346002)(446003)(478600001)(8676002)(476003)(52116002)(53546011)(64126003)(4326008)(2486003)(86362001)(81156014)(65806001)(81166006)(47776003)(68736007)(26005)(16576012)(316002)(76176011)(65956001)(58126008)(77096007)(66066001)(186003)(25786009)(54906003)(16526019)(110136005)(2616005)(3260700006)(23676004)(50466002)(106356001)(486005)(486005)(2906002)(53936002)(6636002)(6116002)(72206003)(97736004)(105586002)(6666003)(3846002)(6246003)(5660300001)(6486002)(31686004)(230700001)(7736002)(31696002)(305945005)(229853002)(65826007)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2571;H:[10.136.6.59];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNVzJQUjEyTUIyNTcxOzIzOnIrUi9nUDhGcERvTld5azNSUTBmYVRVWGZL?=
 =?utf-8?B?Qys5cXNUdGQwME5qaElGem9iRlhkRnNWY1N1Mmp0ak9ESkZTM0ZiN3h5enJr?=
 =?utf-8?B?R2QzMGZiWmsybEVVdnUwZk9hTU1CN2FNUzM1Zk9MUEw0RWxTSGV0RDBzRGdn?=
 =?utf-8?B?UC95N20yWFBkZ1kyYmUyUHk3TUMzaTFEeXM5amZUQ2FQTzhhQU5IbEZPdWRs?=
 =?utf-8?B?eGJsc2kya1EybFVYV1VuR1lXOElyVEFrdnBtTjlGdExaK1VOQ2c3Y1hKcHQ4?=
 =?utf-8?B?UWlROHNzRDQwaHRPL211SkpEUGdaZ0lpOEhVY3JrV3psZ1poZzBwVGdIMXhN?=
 =?utf-8?B?d0RtSjJ1cTg0djVBSDc0SXcxbWFCN0txb0NXVnM4dHpOa2V1cG16Vi8wSlFu?=
 =?utf-8?B?bytkZ2xHalplbjA5TWQ5QjEyRUZmSVRaaWFVZFJGMXFWbERCZlROSWtPU2My?=
 =?utf-8?B?S3Y0Q3hRT2ZWN2wvWGpBUVBmemZHUkFuTjlYR3ZnMHhEV21zM2FGQ01VRXJD?=
 =?utf-8?B?MFJKSml3UTB3N1ExREJEczhZVDlSZklveFBLYll6M0U2QS9YQWxHcXJxdGx4?=
 =?utf-8?B?d2JUVk1IMmN3MG5jaWRuUDg5Q3M3OGpNMFlSZTZZMFE4WUFvanlNNlRkMHdz?=
 =?utf-8?B?WFI4ZlVUMkI2SERFU2RISTVmeXlvcGtDZk52K3d3amk4YU56VlNKc0NmZnA1?=
 =?utf-8?B?enRTeTUvS3ZqUmZKQU9uOVRmSFhucU85eWFSRlk4ZVNRNjRBVEs4NXhnVTZ2?=
 =?utf-8?B?Q1ZHeDFQNThxMWxidGpCTDRnUUw4ZTNOdzlHOHFnd2cwVWJ5bUVlbzF6RVNS?=
 =?utf-8?B?RXIrQ1VBRFB3LytOSGRsR0JlNWhQMEhVQ1Y3eCtFNjVvNmxqOHRwdmhYU21M?=
 =?utf-8?B?YUJBSGZzeTlZaUVNTllYdC82SUowY2ltSWFSVjhNdHgxTFRheWpRZGRrR2pW?=
 =?utf-8?B?Q1EyTWM3SEZXOHltdXMzSFpFNzNRaFl4eUFzNXlSVm9yOEVCeklHaW9JMDl0?=
 =?utf-8?B?NkRSQjQ1b24xSFNjd3VCN1JZMllvaXBmU294d0RPUXRseGo0WWZ6ekYyUmFS?=
 =?utf-8?B?YTFsQjVQQWhiaG9yTDZZR0hsRjlndWVSa29WZlk0dnhyTjkveGVLZ2JGWjVJ?=
 =?utf-8?B?TEdDbFRGVWg2RGFqME41bTQ5K1VZQ29wSWJtQkppOHAvWGpLcGtVWlpYaSsw?=
 =?utf-8?B?TE5COTJMRkhLYUU5dm93d3ZSTXIzeWRIV2lSNjV0RUovMjNKcElLMkZOY3Qx?=
 =?utf-8?B?NVdUNEV6c1FRZjhBTGNFbjhINWVuVGY1V1JGeDNzd2NXRTdqTS9IYzRLL0s2?=
 =?utf-8?B?bFZsYXpidjViZ3pKV0RXS2ZKSUlCQ2JsUU5uWHRTdnZrT043SmFSbjJoZm5j?=
 =?utf-8?B?dC9GT0xweTV5d2VYemtmK1F1ZWgxUVFLVHVWd2JlV3pEdm9aVUlVVFR4dWk5?=
 =?utf-8?B?aElSenhacUF1SGYzT0hQd3F6MmJwSGkyU0hPeE95VnN0UllNbDQ5UVgzZGRH?=
 =?utf-8?B?TE9mSG5SZTJvSEh4ME9VL1RMSTZGRDE0Tk5aano1Q3NSZTAwMFFycG1zdUtl?=
 =?utf-8?B?WlduYWhxRWs5N2tyK1hkOTdFeHlsUjVOcVhtczlvRnlTamtWN1RPdWkvQkp5?=
 =?utf-8?B?Smt4TUh0aDVJYWZJMU96RWxNaUZ0Q3BaWEZmaTZRUzVVVm1La2Q5NFMyWXBV?=
 =?utf-8?B?SEgwQ1hzc0Fob3FOY2krbDd3QUY4VTVkVmtVSHJYSWRDdHdPcWtQUjBPc0Mr?=
 =?utf-8?B?SU5YdC82K2NoWVRvaU9NOTlDcVBkQy9IQk1rSmJscVVUOWtTeHdtYTB6WHFh?=
 =?utf-8?B?RlZoMVFGNU1SMFdQR2VlRnV6anpEMkt4anNRSWRaUlc0SytRTTFLUG9NUU5V?=
 =?utf-8?B?Y1FEcEcwZjVGMFo5cnJETGtrU2JCcWpoTlRxNW9RajhJcFNDMTUrbmVvaHo1?=
 =?utf-8?B?QktmeSt1dlJib09UTEpJSndNRFRGbmdnbVZMa3lGZHRDa3FuZHYwUWhxS0VF?=
 =?utf-8?B?T3NySW5CTkU2SjZ6K3FSL1BlYzlSNHdsd0JDaVpQSzY0ZmVaaTUxNmd3Z0p0?=
 =?utf-8?Q?nc5s=3D?=
X-Microsoft-Antispam-Message-Info: qnBBpkC0X7uMVCtYG5zyUa9m6FJ1ZzlzIRloZCny0pmWIAFyPaUdxZi3qGtT6nnC75JidzN+Zbve8aJSJLL76KlCesG3tZjydfZZ89QonxHJRxs6p+S6+uJUMq1EktoYCC70Gj0/sUO6DIGVChlOBnklxWqVVyYXlLmSLP+iUGVV4xGKOZOuTAJYyYYUXbAy
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2571;6:cnMch5okBNMhiFa9+fjegr27rK9c+0HM0GZVcB9n1615CL1dxXlZrDlfy/Go6r4HbSg5ERJQrrM3QkL+FKqX/OxtdKxK5W28dSOpXnI0SwwkAwwz00/1JzbEwVSE6OyAlLthAjI2R2rx3jcB8kzaRTYpzdHpoYVxey10By80lu2N/VSBZimMG88zqyMvEbYd32Vq5fbhJoEdEMicdR6RTVekoNP1JNl7WVa4cn8H9k8FwMmDmj7kbTciF7ebs4qBQnIYZPMdKI6cUXJEsFl6zIM8T3IWLkDXzP68YQjKsMohnSWkwQsroZat17O8FtqSzfdki8L58eWwHCEzEmcrP+Eyf45/ljpZKK4xAlaW8RDXzh3rGM5LW++eVBONkayCrMfbDG9oWSAk3yPTuRezKBEkhrBD/ohjfRNwkERELlESIVbiWZ5Uu3ki+lXQEFO1mFFYpkVxB/7zdedRTMNljQ==;5:+8JwYQ/iWp66FfMMP9knNJXZzaoBQdkN8Y0Gjn/hCt5T/+5sJ8NokaMLQRv4PqnoM/CI4Z48ATVx4XjskjJDy0BsgGGTa393KxCdFqTPFWXXYAi8w81x1rjAKCj2YRX7S3x3V40/zefosKqcjNX5NegItaqssz69jcJT7zXZ7s8=;24:6g7tJextoP0s3dAH8M8cA9cNjU6lVOw5nOpU7rkTO8P5ll19cZeXIUgfozkcpu5BGJPgXjukS7kEB5XNtsd2aSHv29N7gcqRnwJEZQY61jA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2571;7:GsrYwCyG37035ZW7TVe0MnK/upsnp/Mdo8W5qC1bo873bnEnBBzzt/tz7EmLwEfi80gF90YmcqUm92aXwbRKGHZLd8lbjlclubaPRZt5ylRYHZQiRSMBRTJMsW9PDTtyv1eAQgtXkq4A+buXwFZzzmfSLaZfTZe3GKjmstWMT8aDzdwxCIRke0NTwKU6bKFtbVLGZ709EDAvdD43xxMWId0NpA1AvrY3+IDFPApPlr0CDvLKkLYFgE9kVtQWVtCh;20:8Pw6oVY5zJzgt+hrvt+dDVnUoeEx++/yenPk4gPy/TNxlh7lPepgfPM92OVKkYA2YzpIB0HCacBdg2Ol4d9HVVDIhNQyoM5k4TY/6Ny2+hqMlO8bnKxlhlD591TECmYxH60CS+FxZLtK1dYLfDL5UFmSIKctfauw2vWsCk2WrjKefRDuDlhlQZanPODGsY+TDxVW/OEtne2FdHGl7wKz5jutD0l4UCuUMARniBG/jDUt9CRiOXfHWOnp086npiLH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 05:20:14.3119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab38ecb-5663-4c38-f808-08d5946b9779
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2571
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 3/26/2018 2:42 PM, Linus Walleij wrote:
> On Mon, Mar 12, 2018 at 5:45 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> 
>> In certain cases interrupt enablement will be delayed relative to when
>> the InterruptEnable bits are written.  One example of this is when
>> a GPIO's "debounce" logice is first enabled.  After enabling debounce,
>> there is a 900 us "warm up" period during which InterruptEnable[0]
>> (bit 11) will read as 0 despite being written 1.  During this time
>> InterruptSts will not be updated, nor will interrupts be delivered, even
>> if the GPIO's interrupt configuration has been written to the register.
>>
>> To work around this delay, poll the InterruptEnable bits after setting
>> them to ensure interrupts have truly been enabled in hardware before
>> returning from the irq_enable handler.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> 
> Patch applied.
> 
> I see the AMD people were not on CC so adding them here so they can
> say if there is any problem with the approach.
> 
> Daniel: maybe you should consider listing yourself as comaintainer of this
> driver?
> 
> Yours,
> Linus Walleij
> 

Looks good. 

Regards
Nehal Shah
