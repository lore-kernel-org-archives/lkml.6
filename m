Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeCNPor (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:44:47 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:6441
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750998AbeCNPok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:44:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 11/13] dma-direct: handle the memory encryption bit in
 common code
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180305174655.9878-1-hch@lst.de>
 <20180305174655.9878-12-hch@lst.de>
 <114e27be-5814-4258-4985-af08763c8a74@amd.com>
 <0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com> <20180313131005.GA6260@lst.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <69e98163-beca-fb8a-a26b-66dfeef2f689@amd.com>
Date: Wed, 14 Mar 2018 10:44:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180313131005.GA6260@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:404:121::30) To DM5PR12MB1145.namprd12.prod.outlook.com
 (2603:10b6:3:73::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a89d119c-582f-469b-30e4-08d589c27f19
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1145;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;3:9kVBCWsCnYDn6CS9f/Paz+qmVC4O4aj9Q8eqj0xzngq9wkggSY5Y0iygZVTMtIuk/47NQydAtd0q4T0VUrJVEW6peOAAfcIY61w1zmi+qtDj0ecJqTG0u2iYFy7L7W9pa21HFyOoSYvgrNrQQkPu/Ah5oSGpgb8IkyMa/q8LDT1Fk5MWLG8ZFpqRYXP6apPZpW3teiEfd0R5npAmGzLrNfKy1MlJ2BqfLmj2U+yBDrvWthA3FWrdlzVvknpQBzqb;25:6ASc4uwDv1HDlE2nW6Ms6KI2ER/teTv9yq0vN7b6UTkQB/GLxsoC/zZ/xFkFzASwZKMIw4agHVhZN3MlEcdrdJgNXIB6OrLQcFar6eKxcchrqV1RYEDorTprilF8MSiqXtFoWp45wVJfOCIDIBAzfk+WwLhiACm+w4KcQ0Aho0wgGejNElTZY0CibMEBCaR9+5vU1tI5FarBzkctx7nCMv1a369ZFvMSGzgmcI5SQad9jS/zl+R3AheT0wKu8CkO1mlVzJ/pqYpE8rom0IXR0CxC2O5+C9S1102VeTHNDNQ3TP9Lcms9ItsFeBk81nUAJ+DIBgzXn5dQ0elIwokhNw==;31:7Q+f8b6HQDVscxz/Lc0GorJv+AI0Qhbt45UgmbZDTMkwD3MdWsQNwttRoLH2c3ug2Oj9tAH4b6/4YdTBG1jayWUA0G6n2SSCIp6BQi+5PFyduVimAqmvlrcLWWHrKwNucMHk3qXUvGnBI+KnwHfDGgNWuMUB5ZWWKSIjtx6HrYYVtyYAS05aahGschzd+5DKrMolkKcWNC+GiDEG0d4DX/fr7Gg74+vwglnVnHX0wnU=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;20:aHYh3362lsWc7nYYhlGAoOgbjIK4/xX+Rb7Fa4Hhj4o5NMzhH3F9J70wctFjXlvCgAzkYboRzIuDk5Xjut2R5NU+ncvqsKKwLkPiYOAgbqvJ45HguUg1TMTDc1zhGt32ITz4dA+QcuYjOS/uRi+xcwlShJDb3L8eSR1BD82COdyIAYbnmnpU+65B7pc6wdR11PLA9DDT04V5aSY9lEhIU0aogRZwaAjua/m24zLljrCkd5mwLVEzLE0wz74OAoRVGcsmiIx3Wqa/0kDhQC68gHm97tZ+ruEVplSe8r4oGvZvI75DB3EZPjDPmk7q4Z24xIlUA+pgpqq0gEqxB2wYGVqUPKUq7MIeJY1NR4nxq2eTpXZpCZvSylN1BBAARLyZg0qTbdjIbYJfmVDmmZid4kxC2GCkjw2fgNg6tsMrDRJpGJMhit4WQ9yZzZI638Diyatkj4bogdfYfG5aY+wmbCvVHEJ2aKW6ak/6iNXsN+XJIwGCJUv2zLzDrAe87ySj;4:l77LgJCzEeNj5N1Vb/pwJ0nN5owHMcBKWkXKxj0PU06nVbPfVoPHk1UZRoItjr6cWe98cfpOTdoxjq/VIrvN6KC3SHTSCi5f1BSW5FbfQ0NnO+NTDoa/mZvPIPwjHEj4AgppZmyLOmDN04N29DTeVUZjyX/bkeijPba08mwjgyZRxVNkdXyiRPCg1BPQ5ZI/DT1lYm1lpQWwocSomM5QbBsxdLUOEZ5es3dHkoCG4eJUVVD4/Q7M7j0R8bC3WqCHIhHT+3CV1EniRErQOr5HRw==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1145157833FA4B04B33DCAC5ECD10@DM5PR12MB1145.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1145;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1145;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(376002)(39860400002)(39380400002)(51914003)(76104003)(199004)(189003)(386003)(6666003)(2950100002)(97736004)(6916009)(65826007)(305945005)(81166006)(81156014)(5660300001)(59450400001)(8676002)(36756003)(53936002)(186003)(16526019)(316002)(575784001)(31696002)(16576012)(8936002)(54906003)(53546011)(7736002)(2906002)(86362001)(93886005)(105586002)(58126008)(68736007)(31686004)(64126003)(106356001)(50466002)(6306002)(25786009)(229853002)(76176011)(72206003)(26005)(478600001)(4326008)(6246003)(6486002)(77096007)(6116002)(230700001)(47776003)(3846002)(52116002)(966005)(65806001)(66066001)(52146003)(2486003)(23676004)(65956001)(562404015);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1145;H:[10.236.18.82];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMTQ1OzIzOk5JT2xMWTlWRytyTXVPRmtZYjlOejJ2V1Av?=
 =?utf-8?B?am8vVFVnSE9mUS93enVPbFptYTdxb2QrbU52dDl3MlRSODFZd2ZCTzRwVDN4?=
 =?utf-8?B?bjlUMTJTcW1jekpPSzRHWGJyWldnamROdFFnSGwyUVdLQUVTQ1FaRGlFV2hL?=
 =?utf-8?B?Vk4rY1dwTmNNa2l2dGwrSVdlOThvTDFDNnNaMzE2SDhEWllDQ0ZVZWl2bEVr?=
 =?utf-8?B?UTE0dTRqc3BuNUExaExZb240YTluRU91bHpnaFdmSWxVa3dzWHhsTFZRUjhr?=
 =?utf-8?B?cWF4emU4S20wUU5Vam9qRytxcTdzSndBbXZPVU5Ialhua09XSUZkTUFZTGJO?=
 =?utf-8?B?a3Q1c1pyaHBQT3krb0g1OGdjV3hpYjIrZjdud1ZtUlpWc3VnNGRqOUVkdlZt?=
 =?utf-8?B?QkRnemVISXA4M2dGNitDSU85dUxMa3puQWF6Wk9ReGpiZXVPY1VWMkhVck5Y?=
 =?utf-8?B?Y0pzMng2UWZtTnBLZHpyTVZES3RVaWhVb0h3dXEyVXRzSUhwYXp5MlFXdFZu?=
 =?utf-8?B?SGtRbVdPd3ZXeGZ2RFp6bE5NbzRDM2NmNDZabWlWSEJ1MHBVSzRYK0lZQlNL?=
 =?utf-8?B?bjRWTnhlL2VJSUxKTkJBMTlEZmpaUzQ0RmJTWnoybmwzWkw1VXUxdDJJTzhY?=
 =?utf-8?B?YWg2Ung5M0dPT1VENTNPeFhOblM3YTh3MXUyQVpMZUJEWWNBeVdoQmM4cHMx?=
 =?utf-8?B?QlcxZ1JxcW0xblZ6ZCtCNVM1MWIrZGZFUW01ZmZ0Y0grdnBHTjlFVjErSU53?=
 =?utf-8?B?dVovc2pBYjN5dnhYa0xRZ1J4SVRMSHQ4TlptVExHVHkzaHhsdjhJQU9xZXAz?=
 =?utf-8?B?Zng4SUpBWUdUVmxCRGtNbkUxVU9RYjI4ZU9hYm9WdEI0YnhtRUJrbGlMeFRQ?=
 =?utf-8?B?Wjlja0lIOVNzSTFSRGRUVDc4VWpNOWttZFJoYk1xbi9TTXV5K0QyYTBaRzVj?=
 =?utf-8?B?QU5mWkp1cG05UkdWeHd5b1hQaFlHdUdSd25CMW8rdjJoaFBWa044SzBZYmhy?=
 =?utf-8?B?Kzd6Tk1IeUU4bms3NFI5aFM3R1FYVnpVcHVUYVQ5YTBaZUUwNllKTWIxaVJZ?=
 =?utf-8?B?RFd6bFl1REJIVWhRSExPd2RCdnU4bDBYczdlZEFHVTV2by8zK0IxcDVjNHQ1?=
 =?utf-8?B?LzZVR3JydzdhU0ZSM21hY0xia2lWYVV6Q0NGeDVaQ0ZwL2lrMmdDYjhNQUda?=
 =?utf-8?B?KzdJaXNNbmZ5Zm1WVmZJa21FcXRCaG1yWDdFekpWMVlyYXYvRXJBZmJHUVht?=
 =?utf-8?B?YVFuTkVFTU1KV2lvQ2I1UzRNcGxYMkc0NUwrSW5ZUjVpWUoweVdOWm90ZTZ6?=
 =?utf-8?B?UTM1ajdYRGMvNHp1L2xqWVRqS3NFMFF2UDNjaTczTDJtNFpNWFZUdHZISnlo?=
 =?utf-8?B?V29XblVuZGh4YTcrUlBkYkd4OTVwdFFZQlBUTkIxbEt3U1IyNlhVTWpHRWRa?=
 =?utf-8?B?c0VxNkh5Z3d6dEY2RDQrQmJGejl5M2x1WmQ2YjF4eElTTEpkaFhXc1Bza0U0?=
 =?utf-8?B?N0V5M2hzQVRFRnhsbVpnMUtCVVlhOTlNZGhyTENGMmd2V0ZlN0RuQnVraU9t?=
 =?utf-8?B?OXFNZEdSdm5rbk9LYVF6K3ltaTZYaXVLekU2TmF3R2ZDTCtYc0g1RjRBMWYw?=
 =?utf-8?B?M1dDNG4ralFIbUdPSXFZOFdud0g1blpIa2NrN3dHMkltaXcyY3VFVlBHdnNP?=
 =?utf-8?B?K1QvN2hBRGhEb2xST0k0K0VoYU42V0xYYUpwWlpqNHVOdVA1Yy9vNE8yVFdr?=
 =?utf-8?B?emxXNU9hNjB1UEVrMjJjRUJQajM3ekZLNzZJeTBwZmdMRU5hcXpLZWcrMlBT?=
 =?utf-8?B?TXg3YzVvN0VPaDhRWXh1SUYzRStBV0YyZXB3MWZsRGt6WnNEYThvMTNjeElT?=
 =?utf-8?B?WWJ4djE4NlBBOGo5b2t2aUsrWVRRMFFaTktwbURLUlh0M1o5VkZqOExXR01L?=
 =?utf-8?B?Q0t0UVE2MklVSlAvWWpoY0t0UUltYkVTRzJpak1BbXd0U1BmOVByQ0gzUHRs?=
 =?utf-8?B?VjN5QnhaN0d1UEtiWVpQbitueElRU01tRk05NmlFZFhrYVJFa0tKc2l0eGxD?=
 =?utf-8?B?TldZUHMvL0tnRkNPd1JoNm5DWVFSeVRQMjlQWEl2MlZqbm00OXdPbzJyMzhQ?=
 =?utf-8?B?L1E9PQ==?=
X-Microsoft-Antispam-Message-Info: 8ahgim6MRIiUsFViVAjPD8Kzl0yLKtC64LhuBchte0sdQL45zGgd94+2b3WEhY7VM9YL09Hcdek7rC07EUeLOVJWnvbrFG8oNyS6lZlr/aBZNo3P1xKIKmor/AVJpwqZ/jYebT5n9VS6Mog3GMLfGXDewyeaDEa94AZy4TAI86wMTsRIEgrAcfJJ5jK6nzjR
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;6:PoGGDApflaiNf3HO3zl2pUVGi7czPpspxR+1kM7giIpuu+cxEvEyu06tAvF0HwJw0/dIVWE4fxNENkxQW3FSSm5PyEyb96NlO2TobwTizRkdewS52c3zDHpfwTZM4gFUVYq3Ne7O141m5iP8GJk1R58E6m+1yQZzgmNdvfc4sALs7dAH/YXIyljIazZxtdIE31Q/d1ApTEl8BoUQFVFTxl9quuBuM8+VMbIKi2Yr8zcrdLAN1sC5lUoFdwS1m+1K1meHoSHiAL5H8pIv92wHm7ZOmgrPRegtmOrxXTaLWEY2UESQgjIvQsi84t9/LQp8skhrzv6sWQGn83XmtUYe9MMsb0WFlKvs3u45aJXKEug=;5:jfEMmwobRAPDOutPkWxX67DSY7KeBxpMS1jmlTcSla13XtHw9uWeuAYFLrdro10vvVPylHEfr06p0BCw9J5AqY0pZdKV6ikx0DBu219noWp7C2IGAikE2Vhw/fRraJgnNv0k5tiTghUA0foWiLGOm47vZ3Psy2ueSuxjNITnl9Y=;24:Y1WVHDfw0pchLYFQsl+fIUDyh6GssIlG9UKScKt98UY9m6N0o1WmXeVWhOQjuAeBRflOKGISA/G292mlW1c0rTOkys4wbWDI2dU4wvejoS0=;7:ea+oD/U98k0Bi+Ru4C7kQi6Gy6igVCmdilzExkCPrfBYAivhQv5lQ0pN0esO/l+xbygYUQpikaEbbG/ss5YBBzG+vgAtaVibWR0tKDLVDYIpFJAL8E3vEXWr/ZzZdZL9raowvPcYYVVROT5qFa3DOhO+uBN0gqrVFQ8qblgfT26JBjKhFrINEMbUt+7W2krc57zV5iaxEk/bfl4X8dSb5ePH6ts0Gb2u1P3un125wwGrM+Auw5luWiLhTzNROmU0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1145;20:/Hr4d56yDsd+rHeSUuPdV9AY3ckgYBAmudkUNt+5DyWSh5TEdyL4IZjw0kMLn3kftooY3t9jEBk0YZzGDh5xUbwP00z/3UAeG76XhllRBudzReRuImu6dFBKYa5+Sw0fKnVTvt51ewmWnl+O0ixb4MINwC/YRCrDAAjPbZwqEyxwmu3X6ZQRui3Oyybbuh3twv+YQYXGCSVdmX1IFDWG20tc5K7bbcAmDz36h8ea7fOS+xTcYepwJGtEpaw34qAH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:44:38.2748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89d119c-582f-469b-30e4-08d589c27f19
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 08:10 AM, Christoph Hellwig wrote:
> On Mon, Mar 12, 2018 at 02:48:51PM -0500, Tom Lendacky wrote:
>> Ok, I found one issue that allows this to work when the IOMMU isn't
>> enabled (see below).
> 
> Thanks, folded!
> 
>> But the bigger issue is when the IOMMU is enabled.  The IOMMU code uses
>> a common mapping routine to create the I/O page tables.  This routine
>> assumes that all memory being mapped is encrypted and therefore sets the
>> encryption bit in the I/O page tables.  With this patch, the call to
>> dma_alloc_direct() now returns un-encrypted memory which results in an
>> encryption mis-match.  I think keeping dma_alloc_direct() as it was prior
>> to this patch is the way to go.  It allows SME DMA allocations to remain
>> encrypted and avoids added complexity in the amd_iommu.c file.  This
>> would mean that SEV would still have special DMA operations (so that the
>> alloc/free can change the memory to un-encrypted).
>>
>> What do you think?
> 
> In terms of logic you are right.  I still don't like keeping a just
> slightly tweaked version of dma_alloc_direct around just for this, it
> will be perpetually out of sync in terms of features and bug fixes.
> 
> What do you think about this version that does the decision at runtime:
> 
> 	http://git.infradead.org/users/hch/misc.git/commitdiff/b89f24dc856595dc7610d672bf077195ab0dabf4
> 
> The full tree is available here for testing:
> 
> 	git://git.infradead.org/users/hch/misc.git dma-direct-x86
> 

Thanks for the pointer to the tree.  I did find one bug in the
allocation routine, that once fixed (see below), worked with SME
for IOMMU on and off and worked with an SEV guest.

I understand the comment about using sev_active() in the dma-direct
code, maybe we can up with something later to address that.

Thanks,
Tom

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 856e140..988a3d8 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -82,10 +82,12 @@ void *dma_direct_alloc(struct device *dev, size_t
size, dma_addr_t *dma_handle,

 	if (!page)
 		return NULL;
-	*dma_handle = __phys_to_dma(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma(dev, page_to_phys(page));
 	ret = page_address(page);
-	if (sev_active())
+	if (sev_active()) {
+		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
 		set_memory_decrypted((unsigned long)ret, 1 << page_order);
+	}
 	memset(ret, 0, size);
 	return ret;
 }
