Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753914AbeDJOHD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:07:03 -0400
Received: from mail-co1nam03on0043.outbound.protection.outlook.com ([104.47.40.43]:64199
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753334AbeDJOG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:06:59 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: x86-tip.today (4cdf573) early instaboot
To: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <1523347959.4724.2.camel@gmx.de>
 <20180410085917.bo526ueprf7zfare@gmail.com> <1523363877.4942.2.camel@gmx.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <430ee27a-fbef-9717-792b-bbd06b04996f@amd.com>
Date: Tue, 10 Apr 2018 09:06:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1523363877.4942.2.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:300:ef::27) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 09476b02-2a4f-45b8-4028-08d59eec514c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;3:VYYEwFd2tfjbFdbQHvF5LY2zu58g86rkRN1g0X2rXanMc8s7cKgkUs/Ls5fp7pJrAeGfJsTaPe+fVTFaA7809oFbQkbJjdyB7LB1vqpUkXua3dhjWFqzzxccwJcz1TEggIu8UcR+/zRL/UHveJj5ssUbn/jbxpAFZ8/TFwVQ/AyROznp3wQ7cLP9IvgCDaVph4C32awcd7z0AC9nDZsv4CoZVfMNYeAfEQuzv18sQLRKYwepsop8e0acx41jnN42;25:FG+uqPUMAc/qG4O2Zjy9gbhlPzq3SqqxQiRVh9OncZES+nHU+Fgb6CPwpGenKzlK1XhPoBP7O2Mm4lh/1zTAowIk9oENLDk3Qh1q62rcJx9/mqfoP+j3toYgyK4xs8ZHC4OEQhof5rg6Q4DMV8j9pKid/DH46XmFVspJN8tLv7p7GDEhhDlzaiiW9QSgdQvGCY2oIbjyAK0+BWaTd+ZLclkj6Gpa1sEt7rk0jjZmoVKVIv/K3MqlBTokS80ociFvl807x3cHF2XzLFeXRQrMXh7OVkH/QRWeBzDhIqMpNTvVPrVYq6buZE98q+q6fWRcAv59fHTxe05W8EcYPHveOA==;31:QKDO3aw4MF1OtNLoOzHBkie5D5sgaBDaA6ykCcmAzB57OmVGhFKw2OZ42i/Uylc03BYFubaiM+4M8/pTZbQ5UoNK/Z3VgaTVXMSavKszjzrVxgq7nRr5Cx/8PUsVMxLMdwl46ttjceMyntO+T+awK8bBmdL0iRSi2grBEZpuibukr3JOlV3NySccdx4Tx7GGwRenhDmyoHSDoiC1qNCHs9ppsH16hbnU0CsjtA2QMAk=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;20:vlz2ZizcfV2C6cCswWbMtDqR40NlAMTsaWpBvnbqvqy2IRqQBTszQdmPLYTjdHEaTMVUglioq2OU9sHTUpsUz/KErAWmN00ESKY9qiPdw3ZMWX3lZmQw2lCOwSl5KkJLyS2Ni1nzIkV6f/CSTk03Pn4A6ZUvlhteG/m+NjwjhXYLYUvZ/pvHvT1RFXtQRc91kboCsq1Ww/jqyPoQFe57w6OlgHHaEsirt6d7bJ8mfgmo7jzZ+S0VWHBA1kV3QmXSzl4jFsUz/qfU47adBnSM+7SC/B5zGnIrUCg5WExPg93vSgLSy4xywv+ZweXdw597Yju+JE5f3LMNXH7kHfBcRsrFXyFTjJHIje/5T0e2glgWstYPQ7javyRFlC6eudGAeOr4j1vhW7N2LY8PGyQvg+MTJ2DzRR0MOrRFvGwpuVdO72Quw/Cvhm8j2d/HRBDZjxA+i0KV3Rn09j20S1yUIi/+qHwYR81v1fI++CK4SpcuA13kh545bJm3kCBt+9Dx;4:BtSYBhrZT8GGblhX1F1jsO7AdztiHiW/KZ1tdCDBkXx+/s3/sG4VuaFyq8owNCUCj4lnB5BfagLRd65Az2HlGCLo0cASnqZ6jOsW4+2S2dO5VNogMxCLmLoQ0PiTllizY4Og0bA5TqfCFcGSPnv2OoyXpyrPiHolsL4Bqq77ITeHPZsAwlq29fmj+YB+Qm+HZ1eaZx6yzETqMeAvol49hmQCai4ATvVWclwMD7FpNXiz2SBbGnaIgqxjVklkEhksNu1n02GLjvOg90UAxtp+9oYlOo0sIci61+guGvjSVhlJ0thi6ywry05Fp/xQRoIw
X-Microsoft-Antispam-PRVS: <SN1PR12MB0175976E9E46E9AB0A007292ECBE0@SN1PR12MB0175.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(26323138287068);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0175;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(376002)(366004)(346002)(396003)(377424004)(199004)(189003)(69234005)(316002)(8936002)(65826007)(6116002)(97736004)(31696002)(81166006)(8676002)(4326008)(54906003)(110136005)(575784001)(86362001)(81156014)(3846002)(58126008)(72206003)(16576012)(230700001)(5660300001)(7736002)(105586002)(229853002)(106356001)(478600001)(52116002)(6486002)(486006)(53936002)(476003)(64126003)(50466002)(11346002)(956004)(31686004)(47776003)(66066001)(6666003)(2616005)(76176011)(65806001)(53546011)(386003)(305945005)(59450400001)(6246003)(446003)(23756003)(68736007)(2906002)(77096007)(25786009)(186003)(65956001)(26005)(8666007)(36756003)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0175;H:[10.236.18.82];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?iso-8859-15?Q?1;SN1PR12MB0175;23:BxtqkmBjkwQSGxofQ+kuiMCKImnbap4oFLyRBb?=
 =?iso-8859-15?Q?r7X6sf7fROgNPiO6OaGzf+gGx+xzUUtku8aCIe5ZyGkJ5E9Hy9IkaWM6N?=
 =?iso-8859-15?Q?FRHn+7J8oqChzYLxhidkZpk+01j5ZnvX/C8Ys0f8GC6rO1+RCTok17CBo?=
 =?iso-8859-15?Q?pqVyhbG+bshHsSEHqK0xxYR/VVgeqiTZDxhtlGi+z72jdH/fkopCEPP7z?=
 =?iso-8859-15?Q?U3YXSIU8PBEotQ3MtqbuJR8j4W5BinywuOJdy1lMTB1KwYRbfzi8jEg/x?=
 =?iso-8859-15?Q?xFxisJDQKk9ViFLH6qx9UhGR7c/OTzkqffjaoBmjOzU0Vxgt38z6M4YeD?=
 =?iso-8859-15?Q?RQ5SEigQT5hmzEcjxEdVhjFU0zIDcVpP3+UT7b4RCQGnCTYqNQzy9Ilem?=
 =?iso-8859-15?Q?N/PeUHCpcphD9HJMG4guGc1OL2e8PZMte8rfLj2GdfwjLCOLIR/7JVUCh?=
 =?iso-8859-15?Q?boV+oOX7aivzsrVohkj09mYbukTq1gsTF4YhEZexvMkHLmRJpqzM/sxq5?=
 =?iso-8859-15?Q?9HJWvNcY7GdrPEvIdbEn9kj/9q5wzhvP8vkaMF0I8hVOxz/Orc0zNaoqp?=
 =?iso-8859-15?Q?lKprNKVph4rZzBo7ZCA7XNqhBVzxDIOvbF0wvjtWncDTKpba+UdEQWQM0?=
 =?iso-8859-15?Q?cZRtuuTKgWxoezpf8zfd/5g8veyFSyDWaGIOwnm4SwATli9lIeYJ14T7+?=
 =?iso-8859-15?Q?FuS3mvfJkofa5YUaqFtRXEbqQ209taQGfraswiX8OwhHsF/iagIPD1jI7?=
 =?iso-8859-15?Q?IsMV+/CwY2lcr0r7WcauQXXq1gVqcwQ8HYTIZ4Uj+9DbzVuPLJoPw+a01?=
 =?iso-8859-15?Q?SlO24a7ZLhLmHsKD3wbaKd1kT+0GJhVXr3jTCI2qm1mK2L6mffAX792Ah?=
 =?iso-8859-15?Q?7ZIGEazllGc4mprwOH9wCKAmGcIxs6sfZlLxXCwLEgIiCv0Y9t/JcE/yI?=
 =?iso-8859-15?Q?o+dU3SbKFvXNqb6PplFmoLEO0fxQ7MzMtodL2O7lVHjSDHlYCj4sxwDrG?=
 =?iso-8859-15?Q?tQC4osIz3ZPsuv7ZGXwP1E+J0lyvhVaoA2ZHzegXs2uWfVzyRFcDhv/h/?=
 =?iso-8859-15?Q?6vFOs7FAwwgzA9LgQr7OueRpw7/RnhjibO4xIDjqyUNo6DRJhgye9Wyu+?=
 =?iso-8859-15?Q?+QqRf89ZaLfoDKb17IlGKoCggTAlNx2R/1W4eDFowaoR/2HZOnzmdvkrJ?=
 =?iso-8859-15?Q?+DNybDZRSccvuUqx00A3QleKOSvc2L36mAxv8K32tT7OFUj99WUzFKQ2c?=
 =?iso-8859-15?Q?w1aYCYOvfSobtHzCYrd9UEOQJoMjZFCjGjgNCT2Uik2IOFCm40SuGKPv2?=
 =?iso-8859-15?Q?/LMz2A0a/RV9ZTPj+8z7Y2ujqqQ5Xc5mL2psopTAbBtANukDnM/FcuDtV?=
 =?iso-8859-15?Q?YSh3RC5ayUXjtksEq2gT3+Vh9IdDeDCcy0FJ8arP5f7l8Lf+3yQbCYmdX?=
 =?iso-8859-15?Q?ZAAXDhnomI/fKCVPPM3XEBFcr75H9te7cFJcblAFYWha1twoN1x7xiH23?=
 =?iso-8859-15?Q?nTrmcRvkCrq6Mo5IvssU3W5WcCvGeL/+CozhzEWlafdZnL68vkbUiUs+I?=
 =?iso-8859-15?Q?/PljdE260P0TdmLC+rIRnCZX0XzjpEOgEsP0HOEzNIxuyQPuZai0EzW2B?=
 =?iso-8859-15?Q?vGa4SM3Yc2lgQ+GS?=
X-Microsoft-Antispam-Message-Info: 6ZyFqU5lPCjRq9AaDbTwX3iHZLwpP8onkxxr+BJI2+KW3J4iN0H5ovx/M2VMSPaGsU5mp99GZ9XGdLIZihD76f51us0ANm33Y3UO56kPGKYbBq4M7VU12WiIo+c4y6+2482muxZJ1bLxQpq5FboVlPLQA1VcD5o1Das5kSYA9KIzaHsKk40tZ9FUTi8P1LDK
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;6:CKJManX/5pPQARWXmodVTUtnHCBGElSoNWHlke6VgjxTxkJpeNiimnOUneLvcHP+PueiTo4P+u+IruA07VIWUh9/7gpmqHC0Xhae08SSqdHIjyvdAkFaC2nb92XnX682vA8OfaKJBzHZS7/LFpRUJIxegW6Gz5fnfojIAe83k8QHZcTT/eH5CG7LLopNzvIxlpIB6OHZXi/bmePLgRi111kEYKUesP6Ba/CJo2BukHXpGx1SiuAP6+Y0f9/En6YKr+bma79FVjeUki8wM2Ca8zsX96XgBTm22+NpwwBYskXKNzBhueJBABe6MJXjFaNSvPLCJvgB0LVweV+dLFK5Xs9nyiWKVv6AWLbOy2yxJQVS1jy3i6fHuxF7h22MSpwdFHA+xaz+NCAkSMjkfH+T5WgIX6mHgM/flEHS84hw2A7652xSQeDSxU7wb9yRlR4T+DiAUPGix6x41RSU6r31aQ==;5:ddROD4t4k2zdsWoVfjOJkbdnFOmwro300Rd7wefxGI/M3un6GhZ9WyuPCnXCjF/bfpJhBOEdTHnKYryJljiKb5tVX77KohCE3qOwNeBgkIMpnDf6qw6Wau9Qqw/VoT2Xx45syuaP0zFlGneFdxFbo2HmPhXFSEwLAm+gcYN+Kow=;24:s9OEq4vjNvekoDLidQwtl4HaUV4Z63yyaZ0T4bcAm9E6+oYq+tEu52QKe/YbRtwIch5+5PklY36Jf6FJimOdIrofHH5w6ApeWRPfboNjy+o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;7:fnevH5et/R0M/f3QYl7WOA6fnaEin50YUCYFpLvse87ypbM6wL3u63HwxfV43NUylD1vphaCyXrmv2waqO5H1H/+/jFu6pC/BKjFKXT4DqT47YWz3QgiDikeQAAqBhsx47/4ss2v69Zl1IynhNyWDkthDypkvCCMKlMxaxjxVboi4bxdE5v5zPxcLJsLATiQgxVKWhO4RFLdAGBEfeEfNsMraukWhy3sp62T92zLBbWtv4ztK4t/QJtIkQQRRL5p;20:pCcpftGFrQgzSo1Kh1BCJMRiXgB2nDzXJ0ew2RLemfz6/eu0KqDFv5WRRpgjAm4iTUIeSd9hQS+BRWpyKzs6nIrH7z89s4mF6E9qlraUVZSHXfuwNofM2I2MZ+r57QJziq084lyg2xazMIKtEhNyAH4cD323XTCjekpzQl2EIy1dM6Ej3rtc3ZyQHoLa+gvHMimuAlnWtUmleq0Cph/foh1zUrsA/CZRiIzOSgThBp1Vv3wSWmwKFKd1odUe8OQO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 14:06:54.5746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09476b02-2a4f-45b8-4028-08d59eec514c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0175
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 07:37 AM, Mike Galbraith wrote:
> On Tue, 2018-04-10 at 10:59 +0200, Ingo Molnar wrote:
>> * Mike Galbraith <efault@gmx.de> wrote:
>>
>>> Hi Ingo,
>>>
>>> FYI, my i4790 box reboots immediately.. or close enough to it that you
>>> see nothing at all before again meeting the bios splash.  Master with
>>> the ~same config works fine.  I haven't poked around yet (work).
>>
>> Hm, so there's been a few 'dangerous' pieces of work merged yesterday-ish.
>>
>> Prime suspects would be:
>>
>>  triton:~/tip> gll linus..x86/pti
>>
>>  0564258fb2cf: x86/pti: Leave kernel text global for !PCID
>>  a5df4f1f0d78: x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image
>>  e0bb456e3250: x86/pti: Enable global pages for shared areas
>>  efad2b415152: x86/mm: Do not forbid _PAGE_RW before init for __ro_after_init
>>  4ddee6efdcd0: x86/mm: Comment _PAGE_GLOBAL mystery
>>  e71e836f463d: x86/mm: Remove extra filtering in pageattr code
>>  64c80759408f: x86/mm: Do not auto-massage page protections  <== WOOF
>>  6baf4bec02db: x86/espfix: Document use of _PAGE_GLOBAL
>>  8a57f4849f4f: x86/mm: Introduce "default" kernel PTE mask
>>  606c7193d5fb: x86/mm: Undo double _PAGE_PSE clearing
>>  d1440b23c922: x86/mm: Factor out pageattr _PAGE_GLOBAL setting
>>  ee1400dda318: Merge branch 'linus' into x86/pti to pick up upstream changes
>>  071ccc966ba5: x86/entry/64: Drop idtentry's manual stack switch for user entries
>>  9820e1c3376c: x86/uapi: Fix asm/bootparam.h userspace compilation errors
>>
>> ... which you could test via 0564258fb2cf: if that insta-reboots too then 
>> 9820e1c3376c^1 is expected to work and 4 bisection steps should pinpoint the 
>> guilty commit ...
> 
> Thanks.  I already had a full bisect running, so ended up doing more
> than 4 steps, but ended up at the above.

Just out of curiosity, can you try the following patch and see if it
fixes your reboot issue:

diff --git a/arch/x86/boot/compressed/kaslr.c
b/arch/x86/boot/compressed/kaslr.c
index c5196d2..a0a50b9 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -55,7 +55,7 @@
 extern unsigned long get_cmd_line_ptr(void);

 /* Used by PAGE_KERN* macros: */
-pteval_t __default_kernel_pte_mask __read_mostly;
+pteval_t __default_kernel_pte_mask __read_mostly = ~0;

 /* Simplified build-specific string for starting entropy. */
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"

Thanks,
Tom

> 
> 	-Mike
> 
