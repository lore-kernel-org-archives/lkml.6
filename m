Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeCSOVc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 10:21:32 -0400
Received: from mail-cys01nam02on0069.outbound.protection.outlook.com ([104.47.37.69]:60032
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932708AbeCSOV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 10:21:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 10/14] set_memory.h: provide set_memory_{en,de}crypted
 stubs
To: Christoph Hellwig <hch@lst.de>, x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180319103826.12853-1-hch@lst.de>
 <20180319103826.12853-11-hch@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <cedbd051-cc59-1f80-4143-975342fc5e0c@amd.com>
Date: Mon, 19 Mar 2018 09:21:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319103826.12853-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0014.namprd05.prod.outlook.com (10.174.92.155) To
 BN6PR12MB1137.namprd12.prod.outlook.com (10.168.226.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 395af5f8-c077-4c96-a5bd-08d58da4b350
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1137;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1137;3:+/mZt0X95nBOOto/HM4HYS6hLJibgy29u5pXSmiakOhC0DY1srGnB+CTP/V+w1IE3ypKYOet4r47Y8Lw7V3QuzWdSSREkpZaWFXdAANteN7s0mcHzqwjOANRS2ejBbYj9AcMkskIfJLVUpbBREhBs7QizoAGlc6BZvMZhBOWpkQ0sTMMEkjllxsE4ALeAXmAiuvokVII4JUQ5nz9plNg4qbTKmOLdQZ4s8e94n9LZHqrPhw6lFKeDrWGRN7JcVIA;25:XlMvdX9jY04DM7r5AoXYQGlddN22t7fm6xt7tnu+aGr0hk764zks+rjx1ZD1YVVVSC+IM3mjmAKF7bzkf1Z/lM/GztGT6MwDhiTqeaaVTJPCSvaRK4ChA/ktaUQvnuW9BUpNGXsPsEpjxtwXIMNAio5tHIIPn5kuBmT36Zz/knjlEjqvYAprzuoKdskZbd1i4QKN1cKLZr03327xeNCijTRd6t/GCfXF9DDDGWaP0Tmqjb9eBhg68UnybvCSAU9rwdqyme1mjW657NUyKNycK5+3o7rpaw/aKAyImlmi3IIYz9ZagiQ3s25qSj0BCAy51sLirsUkaaraj4GIxc7MyA==;31:ZBW0v4of5DvkXdsWE3H2FffX8bP9YQJ0aN25eHYZMWkXBFanOaJI01xB0rDyV1UwNad43xR+kWYGAU4IJa2Lq7CySu8h/HSNJnytZ9M7LnLRb3Fe4//s0NJLEnvjz2Alc8EHxkyfiYscbNC7u2K80LKv8gaoGPklwSRakQEfeiKr1JqAIEule6/RGfarCWwSXAu+vjEmUYQVB0I8jkgwyZfpT4wzQHZ2KA2TCF7IO98=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1137:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1137;20:JS/9owOvAMZy8iaElENe+pODzUPfNf3QJsKmzrPtuv5eoe/cBzl80cCi85dMuJgW3xRAeYx+bp5vFB19wAEqzTYOKO1YqryCEFgLPY36ACKV47e67tjO4iZTr1EQxP6yQBXkn/Wm/pLvfXN1TQfCiDG78P0MAMBTj8f1fReR/SNYsuf7rrT9a8WxDo+WklFFjLLblfTvo/5af4CZEGadj7c4IACV5nG0b4gK1F1UGKUCI8/MX82pubqR1hgRfFAnm2Qrn/etVuZFVGAcsbZBqMT286hbBNhJPOwQ3uasbR3yWApfH4Lkv2Tu5nlNbTe0v8kvYJbuCUbcDlPuWyUtghLp/JV2JS2BN2lmUnmYi8dJ1mnj9ePXwvk8JcrQ/aIA07pqlr2ufipy9gVJ1Ux2GV+S79h6UH/vHQlWTm94svOEsjtcBcKLpzyfEeGSMJv6m0igaBXsiPvvswIEv63aw5YIs0cchJQBAWQrdW8A7PIs8JsDwkXjl+pqo/6SDaIt;4:myD/edwmAt2sMqDXJ5yuCqEnhP1R3SJoib9MSTJS/lmsFXGt1A6yR0FOwRhb042x4KXKCLk1fBy+/PKoJn1ynD+eL8ZFidgY97S7GPgNYvbJqyzozEQMB7nuUsFwWXfsMQvEPLeRQEDGmkYfCcMAhhoHqeaBZSryaUIu6AK+s9QkOwFtIaoEmyHeyxVnELoEErf1pUF4Tic8bjxJvfa9qSDe34Tlhb6Eq0bgYojp0FjQPRgxU3UlQvemWkBHAtgu3sajSAbBsza2+JrXtECPijnANIcc4XoNpQ5uiw5jVFjKhPU85p806SopUytJw2bCOSuY/n51oY4RcVLHJOIWqyz+kNW4CKjZxw/eQeRobUA=
X-Microsoft-Antispam-PRVS: <BN6PR12MB113742B9BC780D8C0A2B85CEECD40@BN6PR12MB1137.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1137;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1137;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(186003)(53936002)(316002)(86362001)(50466002)(53546011)(3846002)(6116002)(54906003)(386003)(16576012)(16526019)(5660300001)(106356001)(64126003)(4326008)(58126008)(305945005)(31686004)(7736002)(6246003)(105586002)(230700001)(229853002)(36756003)(65826007)(6666003)(97736004)(81166006)(478600001)(31696002)(8676002)(81156014)(90366009)(47776003)(26005)(6486002)(77096007)(25786009)(66066001)(3260700006)(65956001)(65806001)(2906002)(52146003)(72206003)(76176011)(8936002)(52116002)(23676004)(2486003)(68736007)(2950100002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1137;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMTM3OzIzOkVPaVlGeWZaWVNXVVhCYnZ0THdWaFpvaHZu?=
 =?utf-8?B?QWt0UndLTUVhQWtMWnVqa3EvbWlVdTNXRlRyOWVHOXVnMXNnMEMreFZCU2h3?=
 =?utf-8?B?dmJWTEtNTGFpTkNUcHZPL1lDZ1Zhc3pDajFwZVlhNUM5VDlKMHlQY2ZVRDEx?=
 =?utf-8?B?U21rVG1jQXZRZmljZ3ZlVEJCL1lCZ0VITVY0UFNEVVViVitIbzlTdWw0UkJq?=
 =?utf-8?B?MDQ5dllRdCtHTG40TUlNbUlhMUI2RDk2TkpvdmVqcEluakJyZHZmMUZIcFlN?=
 =?utf-8?B?STJlbkJUZEF5dHhiT2E0c29wckRiRC9EeXRvVnMzYWF4Q3NuQTh3bDVYa0tL?=
 =?utf-8?B?empwUDRnM3lNSTRHdWdYL3hZMUJ0WDJZWEhlMGVqU2MvMEZGc3doeUVXdUNM?=
 =?utf-8?B?WGQvOW5zVEViTklpYUZnTGxWdFpOQ1p4cWoyaGZGNzF6MzV4K3ArSlRKdmxx?=
 =?utf-8?B?TVd5N1FXd1FwOEoxSTN0Vm04bUFvZnBqM2hCbUtVaXVTYXh4T3Y0UUtpbVJE?=
 =?utf-8?B?TVkvYUsxV3JPQzUrVmRIZnk0aDU4ZEtYTUNUQkZJaWl2TXhnbDhranBvSHMr?=
 =?utf-8?B?dC9tdkwrM1hDUlc3SFZCYUk3R3ZZN0ZDUUlXcTFGT2JuMEZiM2Y0b1IzVjJ5?=
 =?utf-8?B?M01RUFVUemVBT1FpVXZxMDNqbC9oTW5TYXdKTVJhZU9QUXoxRGpncnZZcGI3?=
 =?utf-8?B?Sk5PaDdDejFvc20yKzloUGJyc2ovOXVqWUgrTkFXWUhVaHNRTkxBdDA1TWpa?=
 =?utf-8?B?ZHREKzN0SkpwaXdGYWhXNzIyNmRHZWRrdzRsNTZxcmtxK3MrZnhnMXRyYmVs?=
 =?utf-8?B?RjhuWnhybXNtUFhJQW5PUlFGZHhYWDRhbGdjMy9xOEVISUxhUU5rZ3h4d2hY?=
 =?utf-8?B?eGt4Rm4xK0tYYXlBUGxqTUNKTUJKV2d5RStoSGEzZ1Z2SjNYR2U1NE13bjJ6?=
 =?utf-8?B?aTcvTFRXYkRPTHNOVGg5ekhFVlZFOE10a09OazBsbG13emFQUzk1QjRTQmtH?=
 =?utf-8?B?NzVxQ21icXBpVVF3QzM1TmJPTk9ZT2t5emhXNlhkdXpvYktSNTRHZ29La09F?=
 =?utf-8?B?ZDdudDF3cFU0US9JWnhWREd3MnFPOFpqRXZmT3doT3ZLckh5MEhFa3k3NzNJ?=
 =?utf-8?B?YW5BZjdneHVCSDdXRlB2M0lxUVgwU0hlQ1ptRlZISVY0TlI0OUlKdmpIVGFW?=
 =?utf-8?B?UCtnMzlEZjQybG1oQnV6a3BRMjh3UG9XWElITExQeUZpL2d0UnhXWlNmUjh4?=
 =?utf-8?B?eUFxL0xoTllkWjNUZk12RUI0Ujd1azc0cmVJemI2b3hHSGhWV250UUZFQlp1?=
 =?utf-8?B?NzdxenpoN21Sa0hPN25mNUtKOSswSzkzdGFaNm10aWRXaEpZTzlpZnd4Ykk4?=
 =?utf-8?B?MVVNUi9iM05hVHB6L0w1aERxYXNNWE1ldStLbWIwdnRXSWw0S1I0b1VPTXZV?=
 =?utf-8?B?MEU4RUQvdjF1MjROR2Z2N0llcHZXQW1nK0QrVnp5N0c5R3FCUWRZRnM3QUJX?=
 =?utf-8?B?R1JuckVML2lIUUhWUzhEekZGU28zZXhHOXV1WXNMS21BdGtVTmc0U1FKWkhm?=
 =?utf-8?B?SGJkOUdCaXF4SW93VEhpbWk3Y0xiWEovNTdRTnlqUDZ4a09WNTJhcjhaSEth?=
 =?utf-8?B?c0wwQ3JWajN1LzBSQkVGRVEvMjc3dGtnL0FHRENVWWJXSlpKSVN2cFkvL2RP?=
 =?utf-8?B?SjgyWTZCbWRmMG5GRmFTTzhvaU9icE5yZzk2UDVpcnFWamNGY2IrZ3RNaEwr?=
 =?utf-8?B?R09xTEtobmRQV2s4V2ZpckJWaG4zL3gvd0h3Q1cyei91UWVzL0E5QXpTeC94?=
 =?utf-8?B?WlM3SGEwRE1LV2xqSGcyaEUrWWxPVUZQeVlmNEtaVUJYTFF3Z3dRVG1nS2o4?=
 =?utf-8?B?aW53TVdGdGRNRmtPSVZEczRwWXNoc1VTVnJSWU02Z2xyTGVURVBmbDJEeDN4?=
 =?utf-8?B?NkNZQVQxS3dBPT0=?=
X-Microsoft-Antispam-Message-Info: ImZNIShzJ6BSCkMfs86CWyNcndwLAf6GjW1ZcvFUCBrplNIyauYm1FLGjar7T2dlNo/wW/KmDoDkTx6hhd8qM+G9QgSgdFMVTS3ERFPW83puvliuHmOVNaC66W8zhIFXB9oZXzH4yVzQbW+44ShebgC6G0sYr8ZbXPkaFIzjQH99NVkcgsJViDvKipD4958D
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1137;6:TMLAk68xvIh4USnaqVNYSipfPtKO29j3x/e2ITwlTU+IkWUbmHLTwt/Ut9nVMxSGiUIb2ACYOGvUBZ6fiC4g3grHAReGjD+O1Iw5KQ+tKLpXakTtZ12VRSBoP7ly673F9UyfpUWp46GqYA3R/dYxY/295sU9AyvjVLfpTecz2bxGEHjJHm/GGx/w/ME0k7WIBH8ITN+naJBQJqXhY9yfXqEIkitWda9IJjk1+TABaZUCjR186JXoz+C4/4HYkQylgJvxVBC+mRGeCZd4lvQWunv/MvTKTvzOvg3f90tVVRoLI41QPLD2d3zz+ceeOkBN+D1CzEM5QiwEg1+AUUtXvNUILbDURnpvznxzzhmOD3Q=;5:kS5E1fxQY6wRRJB5ggybFhyKDM4KJQsHvGM3ZwlVHGirY+wAewKcRbL52JMHKQpWUOmlFUaYanSyw3fX/5tVD99DpuoN0lazqnmEU5KgXufDcY0twScphkeAWj6+t510r+xobBOeqmvSjyCJMXB1equnElbsHoeRcrmN7C3dZok=;24:gkBtFeHtlktlrfvhvsZU1Q3H6noSCyCMwItpD4L4dJ7KbVdzT2bxlV2lnztrlL9GWgxxprgFB3yfnofrL56xJ/SbglS1Pisw285DRxDI3eY=;7:PN8s8M5iFdjX+E+cKu8kVyGCHC0n/KEAjAUy1djMA1aPXS8kiWZONmup6gqa4iKb3fpZ1oCEyqtqVA1dmW/CdRoQswn1ifucFVnb6BaRcm/8tA9tPCN0cyFG7Z/NWvPZu+mEzZLGtMSPfzq/genUTLcJ6GILsYqx7kliZUAUF62nlDoXIF0/h2ItzDzW8+B1z9Lng/eBbQGhQJennNpITkbnY311M6fs8LYZA7M8elnniNnhQme2B2R4gjWQaGcc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1137;20:yWVdvedGWgYi2Vgs2OXrH8n0mFwWn9YB4p4igE+3f/F2449+x28OjrP9uy+ozHpTqcSd1hCAvednnooYJe+UfmPxxN7IBub0COApMiMRYnWW4PYvqZw8DnaZhLLZroScv3F/TPb9rIV0OwlsSzD+hdswS7OiBlRwUmWJdBXWxmsw36uRqUB53lCsTJSDkcoURHji8oBgNWa/0YI7PltwOIlP1qSIlbQlMuayZFpnjcneyczqNWh6Sj3XaosktBlo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 14:21:24.5746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395af5f8-c077-4c96-a5bd-08d58da4b350
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/2018 5:38 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  include/linux/set_memory.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index e5140648f638..da5178216da5 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -17,4 +17,16 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  #endif
>  
> +#ifndef CONFIG_ARCH_HAS_MEM_ENCRYPT
> +static inline int set_memory_encrypted(unsigned long addr, int numpages)
> +{
> +	return 0;
> +}
> +
> +static inline int set_memory_decrypted(unsigned long addr, int numpages)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_ARCH_HAS_MEM_ENCRYPT */
> +
>  #endif /* _LINUX_SET_MEMORY_H_ */
> 
