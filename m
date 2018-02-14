Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031143AbeBNPAH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:00:07 -0500
Received: from mail-by2nam03on0088.outbound.protection.outlook.com ([104.47.42.88]:6592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030737AbeBNPAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:00:03 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH] iommu/amd - Use dev_err to send events to the system log
To: Joerg Roedel <joro@8bytes.org>
Cc: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <151736066756.21649.4739957712713863861.stgit@sosam4>
 <20180213132216.gyhndywyu23cdzbv@8bytes.org>
 <325d7406-e01b-f7a1-3da6-390b0cf9bc94@amd.com>
 <20180213160018.fg7baclgu5o5rgxc@8bytes.org>
 <f7e7e2c2-c83d-9c4a-f3ac-5c351576b567@amd.com>
 <20180214114957.GI16484@8bytes.org>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <0c024682-2621-44a3-3988-787c00aee1c1@amd.com>
Date: Wed, 14 Feb 2018 09:58:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214114957.GI16484@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [66.187.233.206]
X-ClientProxiedBy: BN6PR13CA0001.namprd13.prod.outlook.com (10.175.123.11) To
 BY2PR12MB0693.namprd12.prod.outlook.com (10.163.113.158)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3812fb2-7a69-47ad-4990-08d573bb9f37
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:/ABenG7ZAoFty4CJYc6ygNAlWjNTyIkZOs/7zHiN98xTzFcAF2Kv1THNoaMRI7Yg5chfAO14+63LHE/pgR28Wao5GxxdWJj8YTJvpEqtOzqQvWQf3ZCLKR+zGAa2I7eO4KtkfY6ngA6v8RyhdNZ3KMhWItRsnnYtdnHJjvhIf+d0jgVzpX+cT8NgVox+HtNmQSJuQnr/nstOlP1tj6T8vN8ekTbv04q27XtYVf8U+2/WP0Pw8sH10IhtPirlqtdZ;25:kuv/jflVuEE7/UMMQRg3q9u+HIqiXQVT1BXfYqtHOifzrrXMikzoM1wRdMP4YfWakhd7krivOk2kof7+cYbybIF6M4DAgO9eXzCSQX5qxSvBZP0bYzhPuAZaos0s3DmK0E9T5iGvsA8ulZ6o2p5DI1FNJD3Rejyu0h3sGVxplaFcjS4K8VJqFfVwfKeJx9dPOzBtsAho9Y6apZY0QFjQn3cSH58/F6Z9Fsbe1bXm2j2tl09bBXO5n0JQffoJP9Eq/zuqoQluSBAnvkZowCP1cWU6oCPcOYFD/uhM+DHFcmT1sDdZWQndzjYkI6Bbn8fppuQpjmswyu+vO55ZDXXjjA==;31:jZJKWOSpIMmnK472Hb3YFQunUv7Pm5VmkMvERMq5ZTIyBWNcbmGW3f8yVlL70MyWBHf3uZYQwSsWPspPwOiBu8SmqNVvzBNg6WqojiLhxIEIwxLn8b2QuOrU6/ymR3gbhDxnYWcFSCXRmTDI+on1sXA3ihiYDu/VRAe1YmwZnBFtykQDR4mBAGaryEm9kVo+THEwSmbX3r/+Ii7UCyq6erYNMVjHfvUx2KwZoTmJD6M=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:rc61U6+QuE1YOG5mgyS3GI8jq1d2dcoWgDHSTg6XNyfr/tMSTqEQI/zbT4M/gw1A4BNn78XBZJl9AGDeWKXbA6g/xNYXr/ueHCfXyn31PJXwnG0+6iUQLutpRSiUqULU86g3JuTd0vJUii3JKQJAV5pfEsBlES+JjRe9C5lk5C35UZ8eA83t9liV+hhxMwd0R1W6tDQ575rjK6SJ2qHEre90hT/Bd5+Jj7Y8sXHjsUSA/paYQgkSdSWeiG3eZz2l06Zf57ug3mudTD5t+fCj2szdv3/ivQmCusJMkFvRuk/2Ymw0J+U/HZTxAkXNLr+BvNuYYqT9VJgtP76Fi20c/QoxL/cbz8PLNzQ3g6j1Hzi3juQ+kjK+Rc/ZSBjgYNGMdXXS8/1DRiCQOrC1wIctbRGTUCBLesfFq4bd1mBt8fZbxsi99zPZZTa/TssCTht2Lm7n/mhgpqjVn04rfEzhxRMfZE8J+TNInsFfN+yN1qZj9IL8sb2Hv+xG5ZRfXlum;4:aun95Pk+PwaDWxNr8nznO7UDIIBcdE4HCrk41llrbVsMsHNsxA/HJ+NL3CqbT47/BcHH1gjQK/0SQtggxQHi/fEREeBds/ARDE8gFOm00eM4NwZttTxpKYyZ9dvIvaqulHbkK/bQKxnlZ7V/EQSRgl+6xfX5eu/GRKmmFhx7cp403KOpQgdpwTBbtkkov8RShm4t/4IeUeoqjOTE+5poRiHdQBtza8bgwe1JpVp16vfBT9ZAKgnYJtZzv0Ps4C2OMc856YW5Kj6icn48IVb1Cw==
X-Microsoft-Antispam-PRVS: <BY2PR12MB0693F610A47FF7F1AE157303FDF50@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(944501161)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(39380400002)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(52116002)(478600001)(47776003)(26005)(77096007)(97736004)(65806001)(16526019)(186003)(66066001)(230700001)(53546011)(386003)(2950100002)(6666003)(6916009)(305945005)(31686004)(50466002)(52146003)(76176011)(53936002)(81166006)(8936002)(6246003)(2906002)(65956001)(68736007)(31696002)(67846002)(3846002)(106356001)(6116002)(36756003)(93886005)(4326008)(316002)(25786009)(72206003)(7736002)(23676004)(81156014)(105586002)(3260700006)(65826007)(83506002)(8676002)(64126003)(229853002)(2486003)(16576012)(90366009)(58126008)(5660300001)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:[10.18.17.154];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjkzOzIzOjUzVHQ3Y0tBTHQ1UUhoQmplcTdISVlRS2x5?=
 =?utf-8?B?a0Y3amZDcXgyZngrbDNSYVJRVXZzOEJhN1hLdXhxdk9jdzAvdUNIWmEwL3Mx?=
 =?utf-8?B?VFFaMWRVY3VQMmQyckN3aFlQK3pGa3NCb0VRaEdVOVViS1FUc2xQRkVwdjZs?=
 =?utf-8?B?RjMxajRML2FkZCs4V0NUZC9OZkRlTEh2NGp4RW5uQVdEbGdZNXdIWlI4YmFQ?=
 =?utf-8?B?YmduSDdpQ2RPK08xdktXR3Z1NGR5V01aQ3NCWFBvWk5LYmxDWldXWUJINTdT?=
 =?utf-8?B?RTBkWWoya0k1bkdNc0hJYlVYVVcxNmJXbkF0bnJldGFCNjJna3BsS1JQakVh?=
 =?utf-8?B?SHI0UURCUXBTdGkzajBlT3VPY2ljM0dzZk5OTFNTMFVNOWUxdnJjWEE5ajB3?=
 =?utf-8?B?bjgvMWJhNVNlblFMRnJpdWxRNGRyZlhqNW1BQS9uTjVZOVJNR21vbWJSSmJI?=
 =?utf-8?B?WXorWFhFWW8yUEp1K1ZqNytmUGowQ0ovOVAzQkYvd2NsR1FxNmo2b3lra3Z6?=
 =?utf-8?B?UU5mTEZ6VnJwVU9VeWpoQXRJa1grWXFFRmV6M3g5a3ltLzVPNjFidzQ4ZXZp?=
 =?utf-8?B?aTlNdnBJTitSekxaZStzWC9wU0ZVOTY2YTBIbTZjSTMvUThCRDBLY0Y3d1Rr?=
 =?utf-8?B?SDYzeENuUkk5NUJMZjFVNHErWm1mMnJZNHNEZWJBcHk5aDhZa0Jva0VIa1BK?=
 =?utf-8?B?SkJIRnhNckdFSUtwVUR2R1NXMXJwV2NRcGtwc0k4WHAyL0Jkc2N5NUtKa2Yw?=
 =?utf-8?B?NUlRd3FYbU9VbnhjbURqSkdTMEhpdnh6SDQ4ZDd0L0h3VElZMDRBU2FIWkJu?=
 =?utf-8?B?SWZrM3pncWxGZWJ2VFFvK0FwRHd2TjcyL0VDZFRNdnJraGd5QzgxUWRwMW0w?=
 =?utf-8?B?bm1kSk9PeFlhN05OMXVtaE55N0VrMlYycmhLMXFFRGtJVFhMcndtcnhaUktu?=
 =?utf-8?B?YjVQcnBKSlZITGZoVFRUSWRxZm5kV0NqMmdBaGRDRzI3SGVReDBxNitMcWY5?=
 =?utf-8?B?OCt3bmExTnhCM2h0enYrRTRPYnFGdjY4ZCtsU1RucG5YWm9peGRvclh5L2Fh?=
 =?utf-8?B?MWpBeGxtNmk5UmY4SU90RTlzLzZ5VnZzZk5sL0lWVk05R3JjMktGN0RiZmpG?=
 =?utf-8?B?eVR2WVpQb1BQdktqRHNiOGhYZFlCTGU5KzR1b2hCNEswUkxLdWVIVEdQR2tt?=
 =?utf-8?B?NTV5RUNkdlJZNE9jR0NrWCttZm9FZ3l4SHp2U2wybTBxTUl5T1RrYVp4eGtO?=
 =?utf-8?B?YmtlMzcybHc4cE4rb0pWd09lVFp6bi8rTkNsNlA2SXRqTWt4WU5ZdGp1Vnhr?=
 =?utf-8?B?U3I5U3BHcUZOTEZrb3B6V0dobFVOWFhVQVNIdmhWY21qY281eDdiNjQwamdH?=
 =?utf-8?B?SmgxNTJYQnhOWXZ5dEdmYXNkTlJqY2tPTFRjbHZtTFR4ckYyNFZ1MTlLNnNk?=
 =?utf-8?B?VHFmOHRJQ1o4U2t2RkYveXpQMktpWmxYaVBTYm1zcDc1M0Q1VEthb1NQYUt6?=
 =?utf-8?B?eExHSzRuWjczSUR0S0F4b1hYNkc4R3g4Q2IvcnVxYngwTGQ3V0RWalZWcFNQ?=
 =?utf-8?B?TGplT21NRGcvTFlPVVRoZ0w1MUtQbnFUQlRKV1JDbXk3Sy9CM1YyTzBCV0ln?=
 =?utf-8?B?YmJWRVRCb3NkZjdPaElQY1JKRWl1UXpCSnB2N05BdndsZEJRNUx1L2g1UDli?=
 =?utf-8?B?cEJ6dFU4V29jaDJqWm5qcjRnSXVVWTNaK01hOXM5SUl5N0ZraTNHRWhQOFZH?=
 =?utf-8?B?em5YUkRMV1NzdnRDRXlXbFpWV3F6OXFjaUJyR0p2ZUgyY3E0QXE3TEVSVkZj?=
 =?utf-8?B?R21kMVZtb3lvYkE4SzBFMFBIU1QwbWdkVUxRVElSZW91bWhTR2k5RkNJeFZG?=
 =?utf-8?B?eVFKU2xuVks4aGx4OUZZSFA4c2NLa0xWbmtWVHpPcWtqVG1OcUdtcmRTdDht?=
 =?utf-8?B?aVg3K2UrdllxNXE4enl1eGg4QTI1T3dmazdCRHhmcHp0VTI0Rk9tcnhOcU5N?=
 =?utf-8?B?SHUrU28wMEp3RGxVMEtTckhDb2E4VEZTeWd3aHR1ZUxTd2QvaE9raWttK3Az?=
 =?utf-8?B?cldVWnJJblBVeTk1dmY0cElmZHB2WXAvVU5Ga2pLUUxaVG0xRGdYeHRPL2h6?=
 =?utf-8?B?MHc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:7UoxAdhBLnLf5yYR2ExynkZWxJgeVerF5TKzHDgDD46nEqYIMsISfS+nwHZCKp0Hr9AoHzzI3KiuH4x0Oir+Gm0kQfvYCtJUOCUfdZHIc3cO0z1rOhLS2PHj5FYkM8JlNSJbMVmn5eYrsNgTNzeNFOeug8Iw/Gn6HGe5QpJ0DM55wAvZS+WC/qAP/NzWkeGv4sTbJYbmATAfVA6NYH7Nrnen1S3M6tvnOI9Yj00gxAxvnMB5W9bI5th1LWnduQKR2dhfFIsdLiERASBq5pkB56JdeBhC9JdKyPYwZ0u086tP5Y/xy+80WxwjtDKj2KE2sn51roHLJCdJ8SXeBsjhE759xDcRwWmsMq650RriKIc=;5:1QXp0YGzYIunQhNpqc3L60u9LLq4rhm47QQtF4yGDA+tTTTFEbMzGgsFtefzmBCRD08MBXukS0wG+h7D66gWOKlvzRgIDv9PkpPQ9/wWvv5XshYL6LAly22aO7yYJqDHkS1lBejalstvVYbsk/SXP3gJCL5MNv8RBebVb6GBbrU=;24:yvZOZM7LGTFzh7gR8KWjwfnmczHN152ztETKZUbHOfRmWftUeB6Y9IiKhYE7c/JE4YAFl1GvckKNALeMVhQuv1T0LFMzP50J1y00qJz8rZU=;7:b7ALDEdV6QC9yCLYwoXozHAhjOOzgHZHlpHfWJ1RM5lZzKVIpJoVReYGGtoBkt1IyOPiTr+6ZprPSw/N+G5IaLJq4YzRxuZUkWdO7voOTYks6Q/KIRof9H0SVPXdt6STqa/oTDW+P/W7Jf1J2GsdrgSlZVFTf0xHzhNy8lFfAHVdOLalXui0IwdeizpQYaOt4fi/qOo18L9N0YqEkkQUGNQ6vSkWmTF+HjKhvVCIRiK9+p25A86xc1cWIecNTge9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:UNcZr8+19/a1G/uluaJz65TXEubM4aGeLjHsDCE6e57XsVfBfLJtPsvvYiuGWVCIUEtVTM0PUbzPpm8qkEFV97+8W9kiOXUOgOXBkyz7obmJufA9h9Bs4P3YGUj9chwRlgiLzhEmvKn+c5pufQaIl/eEmTlfvL5EW+oo1nlxSVzhIsBZjBbjLCSqDqCEpjeSOMM4TrVXeLBJgKbR3noHHx9Bpy8PRD9aPrgAZYKCILdPpF7KgQmTP1CUSfaC8VvG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 15:00:00.1322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3812fb2-7a69-47ad-4990-08d573bb9f37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2018 6:49 AM, Joerg Roedel wrote:
> On Tue, Feb 13, 2018 at 02:24:56PM -0500, Hook, Gary wrote:
>> Without actually running a driver and getting some debug info, I'll just
>> say that my example compiled, the amd_iommu structure points to a pci_dev
>> which contains a device, and the two possibilities are likely equivalent.
>>
>> I'll vet that, of course, but working under the assumption that they are
>> equivalent, the question becomes, do you have a preference?
> 
> They are not equivalent, your version points to the pci_dev containing
> the IOMMU, my version points to the (virtual) iommu-device for that
> particular iommu in the kernel.
> 
> So the difference in the prefix is:
> 
> 	your version: '0000:00:00.2:'
> 
> 	vs. my version: 'ivhd0:'
> 
> The latter is the better prefix, because it points to the iommu. A
> pci_dev can contain more than one iommu, so that prefix is not specific
> enough. I know that there is currently no hardware implementing multiple
> iommus on one pci_dev, but it is allowed according to the spec.

Excellent; specificity is good. I'll crank a new version using that
device.

Thank you!
