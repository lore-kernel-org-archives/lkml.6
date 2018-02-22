Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933158AbeBVP5J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:57:09 -0500
Received: from mail-by2nam01on0087.outbound.protection.outlook.com ([104.47.34.87]:26624
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932952AbeBVP5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:57:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
Cc: brijesh.singh@amd.com, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: SVM: Fix sparse: incorrect type in argument 1
 (different base types)
To: Al Viro <viro@ZenIV.linux.org.uk>
References: <20180219161228.46931-1-brijesh.singh@amd.com>
 <20180221174910.GI30522@ZenIV.linux.org.uk>
 <f55f25f6-559d-bb93-5605-af66678438c2@amd.com>
 <20180221201839.GK30522@ZenIV.linux.org.uk>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f8b22e16-73b4-340a-7387-c8c7270e9432@amd.com>
Date: Thu, 22 Feb 2018 09:56:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180221201839.GK30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR14CA0040.namprd14.prod.outlook.com
 (2603:10b6:404:13f::26) To SN1PR12MB0158.namprd12.prod.outlook.com
 (2a01:111:e400:5144::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76253cba-e198-432a-eb67-08d57a0ce9fc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR12MB0158;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;3:yo0mF5VGd1WLeJsNwACJpdKgiyXawsPjTGVcpDKP6YJvuJYHqy+/q8vPja3OkCCpa0VECVwtSp5ssMRpbwHDTIyU+aNJ3LPETGluczA16DHWDsDbyliSK+vH6geQX6YeWSpcMmX3m8mOhHTFfXQK3ILOagQVFrz6wSki6zysYb5EOG1mrhH7TPYLQHLekvolTnWYQ4RBMZTFBtpRKRzeQRzLGpsECUU+6c9PO4ES6XXx9dHPXK5shnkj2q2KHzT4;25:1Zb6/XDJJdoC7BN64sTRa4f25rrZsO5j3rrHSqyWeUqkFmMn3eNR7ZGP3YPu6xcSNdC/0Kd0A8laTKqbIOZ5lzwX1G7z77+hopZ8rbFy+wAK+3UG15LI4/QvgXSSy7cVAePia9DC49+1jXFccYClvt478vI/igkEuBxSLVoON69Qx/4k14GHxqAB2b2liPUXO77YZ6UbNf/0YjhHCnUewIFcXI4Qdaet2weIk6rFo0cEx8jVVJud3ijC6ym0lHi8hCKcpVI+l6TGon2h8Qo74a/h3hpMv6/nYAd7TSYdK/1BPa5VjZYgLNmA9CJRq8xkEUyD/rRHiAstkDWq+VwWyg==;31:6K1msHV3/qOwLa4FaZZ0JyTsQcH5OTeUvwGPW/Z3jXuPudCCtxNtDSGShIGR3y9v3YrHjTJccMTT6XYEHNDQ3xS0CY9syrAj+Rp2xVNfysa/cW3UKLaOrjw5zjntwpaBbmtO1726iOh5A33h6q4bv2jg9zD+0SiS09WlANLCmfoAgJ9gqJaL0H70J/xdldagoxadTVQUVRjJdhWo4Xf0FEOrnDFJTetp75CcpyUvpe8=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0158:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;20:p/QZU2A5Wouqnq4Yh3LdT6vW7pptYvlKY/QXcwdS+uSZefTRRvhyXk/Q7OkpQqqKk0yrZkH3AhLu0jNkovSnbVTiTom8Bbr+uwMcs8zhzvZqP2s05aTz/BJaeXfZZdaMlFm+ObRkZXcizGzBBz16SmPRI+zG4T9tivJwE1CwBPDOmaA9W3GYghIyn3qCKLClbuf/H1cNMBFebc+mw4l1D/lPi+IpUsP6r96C9vF2bmirWhRJIuOjCs6DM5tL1OkDR7gzWGOyJ82CcZoPm6njF+rrdhplad5cYDnjDt2/mGkbb7w3cxlhKIXpuR8vyJIzbCsGdxUyiOevpISw/jcUYTYHz0yn/Qsms2emHtZf8aPVf/89gz3vfvJ9dTPOqUdPKwduqKDEIrIXEAXzTRfEqNVohlM+WcqvH7Ct/qssUmYgvzA/gu60htH8V2buA5bfOcF6+vLhw7uqzBxwrLMBN5TQsE4kA+2Hux0gtVTVMTOX2mVSlYFwTrKQsaR0RCVD;4:GlhT9SYE6gzkTO/uPdCuRu2gVY1rpXlLoyKQqVDDUu6hmx0YKpsYvtTX4OUWQXehcmiAHwiEakBayErxGZpvcKjzI7I6JQ6Q271KNZdRUpjth6r9H45vb3ZlennRqCR7D1WgPgvPMwQJbMqLqZOkd8xvTfpbGvNEwuLyK5j0xdLQ+8WoOO0LH9ZtEyRIN7CBUMsMbcl8r7kdRfXFOHutyh27Q91ROx3n1nP3XfvRry2BWrQGOtN3ZC3zfHLPTRn0ifQCQP8shcBn/NHvm4gm/w==
X-Microsoft-Antispam-PRVS: <SN1PR12MB015833EB9A2C380516165E4EE5CD0@SN1PR12MB0158.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001080)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(944501161)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0158;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0158;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(39860400002)(366004)(376002)(39380400002)(199004)(189003)(186003)(36756003)(6116002)(386003)(3846002)(2906002)(53936002)(50466002)(31686004)(86362001)(478600001)(59450400001)(53546011)(5660300001)(97736004)(2486003)(68736007)(52146003)(81156014)(23676004)(67846002)(81166006)(76176011)(54906003)(305945005)(4326008)(25786009)(316002)(2870700001)(105586002)(7736002)(8676002)(16526019)(16576012)(58126008)(106356001)(64126003)(229853002)(93886005)(47776003)(26005)(77096007)(52116002)(66066001)(65806001)(31696002)(8936002)(65956001)(6666003)(6916009)(2950100002)(65826007)(6246003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0158;H:[10.236.136.62];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTU4OzIzOmtiUjZ6clgyVTVGMzVGUDlVaFNwNExzb3gv?=
 =?utf-8?B?MDRJK084QnhkRml5bjdkQzYwc0dYcERZZ2lwRWY3M21KK25xcW5yTWdHNmlO?=
 =?utf-8?B?K3o2SXJ6SGZVZzdUMzJlMTV4aU11am5LdVNVVGZ4WHE1WHNLMGJKaW41MHFa?=
 =?utf-8?B?YkQrWmNGUWZJM2hwOUJTb0ZNQVVQV29QR1c2ZXZST2FIMFViSGZkaHc2Q3Vl?=
 =?utf-8?B?c0NDQlBIcFh5NTUvb0F6V015dENQTy8vUUdob1h6M0dGZkZyYndCV1duK21l?=
 =?utf-8?B?NHkyU0MraEViZmhPTC84bTVYdGZlaTluZmZReW9ieERSc2lFZHNTUEVialdi?=
 =?utf-8?B?U2trSU5LNEpqQnJOYkZYeUpyUmt6RklFeWpDbFhFUldOQnJaSlNiZXZpZ1c4?=
 =?utf-8?B?ZWZaRitmZ0xIbzdXc0lmRzIxNzQ4aUdZYnpTRFNIcDdCQkhRb21UNzZIMXN4?=
 =?utf-8?B?VWdzRjNHMUhEVUtmMFV2UGwxWHd4MGEwK3NiWFpKRjY5S3ZXZzB0dVVRVmJx?=
 =?utf-8?B?emc4RHBHR1liTkJoMC9ob0VtZnpuTGFBTW00MzZ6bWZ0UmtvZFQvSUttcGs1?=
 =?utf-8?B?a0tmYXJ3S3hvQVRNaU1VNkc2THkxVmNCMG1kZTF1WUR1ajFZYzh2MHV6Wmp3?=
 =?utf-8?B?ZGJabnhyTFJzUFZXbHhoT0ZIZk53Mzh3c1ZmSkwzeEJRSklGS2RJN1hOSk5N?=
 =?utf-8?B?K3MyOXJYSWV0OSt0MU4rZkVKNlFLTHFZU01RSVF2bEFtU0srbEY0RXBSM21r?=
 =?utf-8?B?aEU3b1V3bDE5UU85SFFndW96SmFIK1E5aW5vWnNqTElzV1pqcmQ1ck05bDRy?=
 =?utf-8?B?bm44RzN3TlAzbE5OWjZnSTVoTEVFbisreWZLSEpwck1YOUhIVkVZUFljSjhW?=
 =?utf-8?B?M3dkMVF4NkJmQW9OYzBWZ0ZUREVxQk9aZUdXeUl6UjE4aWFmSHhjMmdnOTJM?=
 =?utf-8?B?ZVRDam9MMDdDTlB0cjNWMmE3Zm91eEVRUmZDTmEzakNjQUtKU3NwbU9mcGVY?=
 =?utf-8?B?NU1iMElWMnJxM3NnOWMyd0ZmL3BXYUJFZEw3TEk1ZElabndpN3VnZnVCVVFN?=
 =?utf-8?B?Y3EvMFRadVRIcGV0N2ViTisrNGlNZDk4RW5BZzJnd2wzbmR0QTRFcDVhRVNF?=
 =?utf-8?B?MU1IcDNwdS9ZTHdRWmhYd0FKeWVBRDJjQlBDRTNoMG82dzkrNFhvamlaMDN3?=
 =?utf-8?B?bDJpNzJzRjBkcEdVZ0szVWJUeEtWeHFhN1NXeG5IV2lrNk14MnIwSlEzbGRW?=
 =?utf-8?B?ZnNKZk1TQ3F0WmczYU5GOXB2R0V2ZHNlbEZBcXlyVFRWS0s0WnlySlZlL2d5?=
 =?utf-8?B?akh0K3dyY2IrMVJuYW1UTW5ObDFqK3JxSnBlaWxiV3BqWkl4TDNFcWY3K3Vn?=
 =?utf-8?B?aVZuNnh5NlAxTnZMTXBpVk1CSENoektodzZ6dmJlRXVudm5LRk45YS82dlBz?=
 =?utf-8?B?VEo3TWhkbUhoWW03cDQyc0tncC9wL3V0OUF0V0Z5VFdnWmJKMEJFdXpSdlhO?=
 =?utf-8?B?RWVvTXVKWVhlQmIra0I5UzQ2WUtrdC9OWjBZd0dIL05PQ3d6aWZ3QUNqeUdJ?=
 =?utf-8?B?UWtuYldPV0ZnellxQW1nK3l0WnBJTUhUV0RUUXlaM0g3T05xKzVzd2tWeEtC?=
 =?utf-8?B?bG5rUGxXcFlTVk9NTTh6WXVvaGsxeC9YdkppYldxcnBHNnpLdXJuSzhaWE9T?=
 =?utf-8?B?NDEyT1gzd1NKTHZ0MW5jdlRSVU9lTnc1Yk1NY1RxN2phakZObXZPd3ZDT2JJ?=
 =?utf-8?B?L2l1K25vaElZalNhMGsvN2xZN2lQdmJPTks4WXppM1hpLzZiUzA4dDdtWS9G?=
 =?utf-8?B?alRJdzFybzlQS0xJTUozMlc4OEtReTJNRG03ZExpYng2QTh2T3k1OFhTM2RT?=
 =?utf-8?B?dlNzcjNCcXIyVmZaekxURmp1bkZLRW9vQ1ZmejE3dmVDK3NycEc5QUJBUCtT?=
 =?utf-8?B?VlBIcVZRcW9RPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;6:DxCa/X0TRHT5MZIO49PNvjJyDDmL9w/vb23IqbL7/v/ibvbIF2JyAYvyU7FYH8w0QSsVVO2oMcThdlTfVA8Ow8NmWU2peXKJQ1hEMHqKJLcIil/1YUq8bG40NquzzAheX22jSWROJefTgdbQ9CKJZt1JXVuiQd7R6ABJaDND9TiuNjCkyfqHPmrt5l3yrkYY3ERr/bZgiOYg96XrBvVGLfUZBy7NfFnyHqlWgk+TTPc3Vu17SuWjc+cZRGVqw3LHApvMpK2f75DBQCBJo4yqCLTJKpi6wRirf+yBWiYjtFlQoXd4WhZeK0h7xaV5HJZAT4OkoAuvL9hYYzazaOIFO5g8Dp6CU4BLkq4UkFMj/vE=;5:cbgr/kMD9lxENb2V1imO3EEdH2bhXsJXboU9n5e518mLSjtKlRB6JYNObo4SWS1coJi9keoUIIGcbPAU9Cggt3mYbf+lcbCANTmJzUpLaFK6Sh74p5R0I8ErlfOmcnoiMC5Lb18+8yR2pLEw1i973sRijd7RG0wEADzUL3Uy87M=;24:Vxudj1PbSmDL7t6XHi9DBBzkjHFqFfCaz7paiSM6Nbk0HJAyObDhOB3nRxYvnb5grclTiGgZosWILtAqUNcU9Pmt8VGqT/gEkxE+buS4DRE=;7:s99tFo+Q3fvPTQNxSs0zZdVSdxEdpcKNzkk7Qq+RyHUqKzo2N5QBjcUMWoHBn7pi4xdF3AuREMz9FPCUNk7d9e0vervT/s6CskJ+wOQGmWMcK7ZYWhobnATfBKAWS6iNKqlR/zqlJV1cir0uua4JdouL4CKAS8YO5w64cd1Cf47ZfTszaC3Hio2k55W3RFQjiHi8MvpfONGx3OydWk/hBCd5P9hkrFzCzm2DC5HjlqkzyFaCZCFDb4HQFNNQiBee
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;20:lUehJPShmCzilhk9LvASZorM7penEaRVmAWKYwfpt5SjzVCZr9udNb8RI3UnTkM5gSayZTOAYLxqwquXN70hufVA0nd7FevF3bGT0wjx9exVUiutfpeC6nq2+vMaTCxA3CbtTO00w4wVtgnkx9y5Ly/dwIL0peBIZqfW7XsrbHj21PgaeUJrSIZFdCSgEL2QKBglGNtR5YFlPA9Lg/BgCRGGvQTAC3boGpxX8U+kjA6Uw18cJZvT3iebxj7oBurv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 15:57:01.9156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76253cba-e198-432a-eb67-08d57a0ce9fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/21/2018 02:18 PM, Al Viro wrote:
> On Wed, Feb 21, 2018 at 01:59:55PM -0600, Brijesh Singh wrote:
> 
>> Sure, checking access_ok() does not guarantee that later
>> copy_from_user() will not fail. But it does eliminate one possible
>> reason for the failure. We are trying to validate most of the user
>> inputs before we invoke  SEV command.
> 
> That makes no sense whatsoever.  If user is deliberately fuzzing
> your code or trying to DoS it, that "validation" doesn't buy you
> anything - they can just as well feed you NULL, after all.
> 


Currently, we let user query the blob length with params.len == 0 || 
param.uaddr == NULL. We could limit it to just params.len == 0.


> What is the rationale for that?  "Userland is accidentally feeding
> us garbage pointers" is the case where slowness is the least of your
> concerns...
> 

My intent was to do some obvious failure checks on user inputs before 
invoking the HW. I do see your point that if userspace is feeding us 
garbage then slowness is least of our concern. If you think that we 
should not be using access_ok() in this particular case then I am okay 
with it.
