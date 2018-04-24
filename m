Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932500AbeDXKOn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:14:43 -0400
Received: from mail-db5eur01on0043.outbound.protection.outlook.com ([104.47.2.43]:11040
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932332AbeDXKOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:14:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [Xen-devel] [PATCH 0/1] drm/xen-zcopy: Add Xen zero-copy helper
 DRM driver
To: Wei Liu <wei.liu2@citrix.com>, Juergen Gross <jgross@suse.com>,
        Dongwon Kim <dongwon.kim@intel.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Artem Mygaiev <Artem_Mygaiev@epam.com>, konrad.wilk@oracle.com,
        airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Potrola, MateuszX" <mateuszx.potrola@intel.com>,
        xen-devel@lists.xenproject.org, daniel.vetter@intel.com,
        Ian Jackson <Ian.Jackson@eu.citrix.com>
References: <76cdc65a-7bb1-9377-7bc5-6164e32f7b5d@gmail.com>
 <20180423115242.ywdwqblj2aseu3fr@citrix.com>
 <61105351-8896-072b-abf0-757c7f6c0edf@gmail.com>
 <ce2ebb5b-fa13-0475-b0fd-6c330277d151@oracle.com>
 <30ddb005-96c8-f47c-2e23-4e0d354e5842@gmail.com>
 <a25a394c-ecf8-d8cf-15b8-eb8cb71d0a02@suse.com>
 <c4c426eb-5a35-1f8f-59f3-350d6e97d89e@gmail.com>
 <6089d701-5221-75b4-38eb-b23bc5dc30cd@suse.com>
 <85fc8f82-6d4d-9343-2737-85b7d7391168@gmail.com>
 <0657bbb5-5cb7-4c63-5490-fbfc7dec1e59@suse.com>
 <20180424100132.5573sg2hhbhpkr7c@citrix.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <b14fd51e-02f2-6039-228e-7dd8be2aebfa@epam.com>
Date: Tue, 24 Apr 2018 13:14:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424100132.5573sg2hhbhpkr7c@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.52]
X-ClientProxiedBy: PR2P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::32)
 To DB5PR0301MB1944.eurprd03.prod.outlook.com (2603:10a6:0:35::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR0301MB1944;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1944;3:gvAQJwmXe+L/E2BeDrG1JoJCsR/IDyocjDqnSPXRbb2HWPM1WO6RuHMluvtU4P8NxyXn0FKzE8oqUVaWzqpwamtjO9AK+A7WsYBSpHsRa9i8SzQI9gp/I5OWjk9p5YrXZBaDcMcIXSnqrkZjykaSGvbnVzpqc/fjkN1VeBEPRkO7pSZhc7OF81YXBVbYxo+f7R6beAUAClMWihQKy0jBazI+EWJCqqxItcV/UyYGMpgWfOpNnPVeH8XMRoW2Kzxq;25:2cqngllW5+CJttRjWhHn145ZZxsMcr7zQ0qgZBd/lH9o4aaZL9upKqVrPVH94z50wWOdIMcRWMtvsxHIHxykfuFZJQiqs9p8vAsGnLJkWPBZ1tmZSPBJohgfEv1xGvJ3z0ObSDnnRIbrf0v2VsAGKyjo5O3GlbzrdWK5EJD6yUyOhKb5Wbhj+8qrC+PciE57rSBhGQsD2dbh1Ylko77X1WeZGVwS/9wQocwHmFtyQ+WU2Qa+cSV+pQu5Yt8y0bRRnmUikkXhy+rZ+ek74U9P9QFEgIXEtkpSR9/P84EtRhRk44UweMSfT9ngJQUTt+au07C1ENbT9o/1QUue8dntOA==;31:fVLBTSZTkfCZszorOmCZgruXxk+sjp0ivrfbUQ4pU9e95Df5V9PI+KvNUzger9ZCYAZ9UyPsyPAx/4Ksh3Dba+JuTmhsSFBY0SPW/XGHWgL2YP/ykWA0bP33SgF8SelQAuOBZpqzsNdXAD+8ZscZI4QQSHsMlkNq+6jv2V2hqy9KWfyJnU39GeYBTs3/uoG4WBScoRPpxQoDGlAi2mnE1nUB621AhmxLMRPNucdGfAw=
X-MS-TrafficTypeDiagnostic: DB5PR0301MB1944:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1944;20:RigA+YxBahvkNI7Sxu0vcRe+UVeUf5sKUqqjvPFuj0upI0RO9cO1SR6uWF2f0EmFEXFH/H5TwQjTslEJqL2JSs6qutGkhecX6NGYYl5ktzLr5ZABfHgO5zY5vHWcfamYPlptrw8yaGNne0sdhp4xGBEN7zKR9EiQx47wp6lwj34UYH8xOHQjWGSAyNqYL8p3T1lBsQfqTe0QfjHMdCDNxXXxUvzlms37m9ML0UmsVelxVWb5lcyHA+obwZAHTBqvMIP8joOAz7hAH48aPP34yPeis5tBC+f+TLtz+0g6yYLbfSAycZD6m3fjwoYGIjkK7C8f37Z8Ipoyih8ENNagXcUEZiorqjby4vALwBalFh5b50ZSI7J5shPOEFPw6GftlfxJHZwJdwFV9Is42Jc7kIXMGe8EzERR676CjfqNtIdTLw60Rkezm9DF1GndzCm2YuG6l8gveGP2sNOuLRnTKve00Bb0rs+wlbwKLQBau2CtZ8t4KDRI6bJkSA0gvSuj;4:5dosc8F7/Wibp2KcWOL199rDDOMRTa0vdJLqtb8xBhejtoEiJ/Lxmibz/x50DN6qwA3aWXCCAacVOgm29SsoU480pWrgy0AyiTVFp3iKgefvZl9z/zVdpzLZZBM1ITZKAxBtE9Es2belulVZOoWygXzgus8ZVc3OUZpOxpcctXBO1HtWbO6XTM0o/6DM7i3k7pcDXBdBdkNNKBqokc9VJVZi2BVAwp/7xR8AIb/E//5f7gWVpXhtlM3jIFjPtH6mNExg+tmwX93Y4Q77lgaqKw==
X-Microsoft-Antispam-PRVS: <DB5PR0301MB194424C1CAED0ECB02CC8DBCE7880@DB5PR0301MB1944.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR0301MB1944;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0301MB1944;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(366004)(376002)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(64126003)(305945005)(16576012)(50466002)(55236004)(6116002)(31686004)(8666007)(956004)(36756003)(316002)(446003)(11346002)(86362001)(2616005)(77096007)(26005)(16526019)(186003)(54906003)(7736002)(58126008)(476003)(31696002)(110136005)(486006)(8936002)(93886005)(5660300001)(65806001)(65956001)(7416002)(66066001)(2486003)(52146003)(23676004)(47776003)(8676002)(81156014)(478600001)(76176011)(52116002)(81166006)(68736007)(2870700001)(2906002)(105586002)(53936002)(6666003)(80792005)(25786009)(72206003)(53546011)(6486002)(3846002)(6246003)(97736004)(229853002)(39060400002)(65826007)(59450400001)(4326008)(67846002)(386003)(106356001)(21314002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR0301MB1944;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjVQUjAzMDFNQjE5NDQ7MjM6TWZ3WnBXSDh0WDFyT3Z3ZUhLakk0ODhO?=
 =?utf-8?B?ZlhJNGwvUk40R3ZPZzNNNWFoMTVIU0JYL29meVdQY0IyNnZ1ZGVpbzZ2OWYw?=
 =?utf-8?B?cXZJNnRVL0dPOGRTTWFlYnFvTHBja2dmc0ZMd1IzQ2JmRUJHSUtTRDMxS3J2?=
 =?utf-8?B?S3gwdGRUZ0pEL1dJaEZkWGYvY1FKaXdHWTNtTEw3WTN4eXFCUGRhaEJoNlV3?=
 =?utf-8?B?cnZlSXhnSGJGZDBCakN3czVMS3pHY1Y0aFJWUnIwVzBxS1JpRHduWEJndGxi?=
 =?utf-8?B?MkFNLzBjcHFORmtXM2Z2ZzV4UHJlMExPQnlQcW1Pam9YK3BwNWxEYnZQMVQv?=
 =?utf-8?B?Yk1ERUVPNEVHY1phWDJkZmt2QzZNcXRRekFuRUN0YmZtcmJRQmJBZmRZdzZR?=
 =?utf-8?B?dlVQN3FMZW5WMHNpMFBuSnFnYnh4RHdyZmJhL3IvNmEzTnUySVFaOVYzQ1dR?=
 =?utf-8?B?Mk00d3ZjdW5DLzUrczlja0l2RlJ1OEVMVytmdDJHTUl2aFZFY0MrODN2TFFa?=
 =?utf-8?B?SWZWVDFjMFdoQlpHUEQxVHNoekw3U1A1QXNZREkxT1BQdlZzWnFlS0JhOTBD?=
 =?utf-8?B?Z1I3cFY0ZTU2aE5DMWkwVUVmbmprWFZoTFVJa3hGWjJ5WDdKTi9GZ0o0VUdX?=
 =?utf-8?B?TVJ1VUNGdEhYNi81cGlDMm9pQWhwc3hUS3ptWTJFZFBYcHk1a3FVWTAzNG5U?=
 =?utf-8?B?Y0d6RXprWDFvQm5oVFdHOU9ITnk4VEZLbFRFU2k1V3lRSFNNV1BaV2puWnRT?=
 =?utf-8?B?S293MHJYc0tGSy8rV1JySXBlVTQrWk8xK2ZMWEhtUXI3VlJuM2lzc1grR3Fk?=
 =?utf-8?B?elEybGtoaGphODlTMDArYVBWdDZkOWRaRGV6eTlJa1IrcjcwQ3kweDFhb1gv?=
 =?utf-8?B?NlVYWWJ3eFRXRlNiTWRRNDlPL0g5R3VXdHJpK3NKRXd6VXl6c3Q2c0NMZ2tk?=
 =?utf-8?B?dmNlUHZLM0xQY2N4cmQxbTYzVDJiVU5WK05vc1RkK0ROdkV1Vi9hY0hEU09r?=
 =?utf-8?B?UCtoQWlleThRa3I0QTEzZGlzbGpmSVVPb0lLM1VBdzVic0UrbHcvcXIvekNQ?=
 =?utf-8?B?VmxldUVJNjhVYXFmTklWcWdiMVpnYlJkZVE1L2tzV1FYemt4ZzUvNTdFWHkw?=
 =?utf-8?B?TDdVTEM0UEFDUy84a0JsY1hQb0FUNnNVcnM0NWM4TFhmZk1FbnhTWDN6Tk1v?=
 =?utf-8?B?SVVKUWI5d2F4VnRpalBtUkVETnZRYmNncHhtcjhwcm43VmtTSFR6emp3b3JN?=
 =?utf-8?B?cUNEczVERERVUzFKeEZkZTFWZVZ4VS9EZjQzVVp0U2E3L1NEd2dwdVNTTTQy?=
 =?utf-8?B?NHRMc2dhZ0RDOVkxL2p5bFZrN1hCWllEK01STHZqTVBEbHp5NnpNUC9nSDJ6?=
 =?utf-8?B?VFcwdDE1QlpRNlFJby80MWlTbXcrSVR4YWdPeHFzNlB3SjBpNG5OTk9US0hp?=
 =?utf-8?B?dmF0dm9KOEY5SXl0VWNYeFNVQzlXN1cxR0tjaWtmQm1qV1c1WWZnOVVEenVX?=
 =?utf-8?B?QVBTeEgwYThuQTRuMlpScUh2d1dWR1RyL2ljdk5MY1IxZGs1T1RudlhkWmlT?=
 =?utf-8?B?ZlVzN2ZydW54MVVzMzQvN1VqYlZxRXB3eVd0VUtXRHF2QXhQRDhIMksySzJ4?=
 =?utf-8?B?dmo4eWtOS0xtWHJ0a2dkRlRPSjhCZHZBaVdLdWkxRnNnMTZLbnpra1RFUG5O?=
 =?utf-8?B?QVZOcENxekRoYWthYnJ6RDFHUExDS0pBQlBrNW9nN2pPNVhkcDlxdDRDR3cx?=
 =?utf-8?B?bkUrajJXTTdFMFVlNFJzd1lLMXlkRFNkOXRoRU5lQUhCdnJydTZISUgvTlJG?=
 =?utf-8?B?K0RqYTlHMHprMmhtUHZqbTVZN3daSlFUSjA0b1VKVHRGZ2UxOHpNWU9Zc1BN?=
 =?utf-8?B?OS9iR0J1S2wvNXNsTU1tSm02ZVUrWlc3NjRzNWdoOWtjM3VhRWZ6Z00yMDJO?=
 =?utf-8?B?SUNKWk9KTzRTNllkVXpQZUZPSlkxcVllUVFkSld3clVIWXRXZCtjemwrWjd2?=
 =?utf-8?B?c05JcEhQM2E3MnJwdGxnODU3R2lLTWVZRElKWllIY3M5QU5iWmIvTWdLc3Ix?=
 =?utf-8?B?YmtXRkNYUHJobXJ2dmd4dGZpY1BTOGJTbkdvTlowdEM1ZWc5QXBBTno3Slph?=
 =?utf-8?B?Q05Va2UrUkxpclh2TFhlUGlSdVZjNWhldnZid0RzcU5Ic2V5L3F3RDdwbkt6?=
 =?utf-8?B?NU5SdHo5ajFvRllKaE1yTURyZjdSTGt4VHpIWHMvdUZscTZwNEtOQzV0Nm45?=
 =?utf-8?B?MVdsd3VWVUFSUXdYbi9BUnpPSTVxYSszdjkvVlRVNDBBdzFQZHl3SUlETzlW?=
 =?utf-8?B?TkdoZTdnYVVtakdoUGFmZ1RGbFRVR0YyaWRERUIrVGtudVdLajhibGFnbVpK?=
 =?utf-8?Q?3RJoH9fY8kyrEFUOnijE3Fxsces2UO+UVoqkE=3D?=
X-Microsoft-Antispam-Message-Info: L3fN8A6y0QZTFBUt26VDWzKCkOIaGBNWxMHC56pd4yyZXuTnAw/uOlf+tspdQzOFpp0dixNHRUvWmI6+A5W+IBvl9j40/7QXG38AhK4nwRE2VOXbSQ3UhgUL2TNzFA57oShCw5TYv+54+MQ+9/FYHSHdtIbZWtgidz/hOx95177eRXiz3m4bHvD06xEmqRcr
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1944;6:kw5qvUnt1Uux63X2pq62ph3XQa2t4BpQ++J8kEf1YifAQYEe5UbJQ1podkd560i1LbRZUNDoPY/lEfx8L8RFcQv8ZNlRN5ojaHYkqRZh2GYMVvr3FIHs1+yjFzrNtTA6NU7sOiV9gTn/+8RL697nNq/8b9xmyrpdfJu4A4x26h8/2BWsPgwab6akCmzvmmIAeMjEUGlkEBI6owkOMWA2LQDgnGNJ5oJwUTYya7VQn7PHzrXHm4LTVoN501NfIGxtK948e0KaNrVWQlUIVMrqdlZ2I1rcCXKZHrKyXcSNtLysuu/2wSe3L8S7mJwT6pnMoFlg9aGpA5ujBKuXMohaTUzqcElIauOQbOXv5CGQKnaC4WeGE2uc3y9g4R+jxZCbRWfTB1PxbaNAibB/bEIp8eIySO0abTvyWswNzm79XrutU7Puv8H2oYtnJUuSAATJqoi/MeZc7eXA1ZWmSoR4sQ==;5:Z+Py7uKyrAPUfNBGhjw4Y3mvPRDCeRFjd7OImkHTtHzmeHp/t1hD/fw4y8zOdUXi2ctEeadaCHWscD6w1F762nJeQ5ah8eYNADVZVQOwaUBjE9jiC8fSD3AQyBx0xYQouMEvalEVkpQUYvXUZxFpuOAQHBkViN8kS48yblyF5jI=;24:ssJ3/D4xkOfiguOpe1fEUwgbXN6IpJSsgAQ1Bw42SmxooFTbqUYvOZ125IYtnbt/PYb93HczSJSCPYcwaJR5W84ka/qhOyHHnz8F+CJWg2M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR0301MB1944;7:XWZrtapVksqY6lyj3XHyxnXa5Pcwc2aa7x1y/KaSnZcAw5RwUvIBaBsAzfkGijv2PzEMSENKhA54MzGdVNAlRxEdA/2KYubY4Mh0/zwX1f5Jl+ceT/Hi427B1ZAJaPHHPSDyBkT0QW0HFs3vMiBsr2kU17MBPoe9v/0rWjCHwuM6VjmsE5YEGyt5jZvJn6o10szsLwD4xnzYVM3yBMrdH2yfUjjDLjf9ZHKIP68+rnxD8J62Qzug+hvojTtzXfFT
X-MS-Office365-Filtering-Correlation-Id: a356fa62-9a8a-4295-03be-08d5a9cc2f81
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 10:14:36.6011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a356fa62-9a8a-4295-03be-08d5a9cc2f81
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0301MB1944
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/2018 01:01 PM, Wei Liu wrote:
> On Tue, Apr 24, 2018 at 11:08:41AM +0200, Juergen Gross wrote:
>> On 24/04/18 11:03, Oleksandr Andrushchenko wrote:
>>> On 04/24/2018 11:40 AM, Juergen Gross wrote:
>>>> On 24/04/18 10:07, Oleksandr Andrushchenko wrote:
>>>>> On 04/24/2018 10:51 AM, Juergen Gross wrote:
>>>>>> On 24/04/18 07:43, Oleksandr Andrushchenko wrote:
>>>>>>> On 04/24/2018 01:41 AM, Boris Ostrovsky wrote:
>>>>>>>> On 04/23/2018 08:10 AM, Oleksandr Andrushchenko wrote:
>>>>>>>>> On 04/23/2018 02:52 PM, Wei Liu wrote:
>>>>>>>>>> On Fri, Apr 20, 2018 at 02:25:20PM +0300, Oleksandr Andrushchenko
>>>>>>>>>> wrote:
>>>>>>>>>>>>>          the gntdev.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I think this is generic enough that it could be implemented by a
>>>>>>>>>>>>> device not tied to Xen. AFAICT the hyper_dma guys also wanted
>>>>>>>>>>>>> something similar to this.
>>>>>>>>>>>> You can't just wrap random userspace memory into a dma-buf. We've
>>>>>>>>>>>> just had
>>>>>>>>>>>> this discussion with kvm/qemu folks, who proposed just that, and
>>>>>>>>>>>> after a
>>>>>>>>>>>> bit of discussion they'll now try to have a driver which just
>>>>>>>>>>>> wraps a
>>>>>>>>>>>> memfd into a dma-buf.
>>>>>>>>>>> So, we have to decide either we introduce a new driver
>>>>>>>>>>> (say, under drivers/xen/xen-dma-buf) or extend the existing
>>>>>>>>>>> gntdev/balloon to support dma-buf use-cases.
>>>>>>>>>>>
>>>>>>>>>>> Can anybody from Xen community express their preference here?
>>>>>>>>>>>
>>>>>>>>>> Oleksandr talked to me on IRC about this, he said a few IOCTLs
>>>>>>>>>> need to
>>>>>>>>>> be added to either existing drivers or a new driver.
>>>>>>>>>>
>>>>>>>>>> I went through this thread twice and skimmed through the relevant
>>>>>>>>>> documents, but I couldn't see any obvious pros and cons for either
>>>>>>>>>> approach. So I don't really have an opinion on this.
>>>>>>>>>>
>>>>>>>>>> But, assuming if implemented in existing drivers, those IOCTLs
>>>>>>>>>> need to
>>>>>>>>>> be added to different drivers, which means userspace program
>>>>>>>>>> needs to
>>>>>>>>>> write more code and get more handles, it would be slightly
>>>>>>>>>> better to
>>>>>>>>>> implement a new driver from that perspective.
>>>>>>>>> If gntdev/balloon extension is still considered:
>>>>>>>>>
>>>>>>>>> All the IOCTLs will be in gntdev driver (in current xen-zcopy
>>>>>>>>> terminology):
>>>>>>>>>      - DRM_ICOTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>>>>>>>      - DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>>>>>>>      - DRM_IOCTL_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>>>>>
>>>>>>>>> Balloon driver extension, which is needed for contiguous/DMA
>>>>>>>>> buffers, will be to provide new *kernel API*, no UAPI is needed.
>>>>>>>>>
>>>>>>>> So I am obviously a bit late to this thread, but why do you need
>>>>>>>> to add
>>>>>>>> new ioctls to gntdev and balloon? Doesn't this driver manage to do
>>>>>>>> what
>>>>>>>> you want without any extensions?
>>>>>>> 1. I only (may) need to add IOCTLs to gntdev
>>>>>>> 2. balloon driver needs to be extended, so it can allocate
>>>>>>> contiguous (DMA) memory, not IOCTLs/UAPI here, all lives
>>>>>>> in the kernel.
>>>>>>> 3. The reason I need to extend gnttab with new IOCTLs is to
>>>>>>> provide new functionality to create a dma-buf from grant references
>>>>>>> and to produce grant references for a dma-buf. This is what I have as
>>>>>>> UAPI
>>>>>>> description for xen-zcopy driver:
>>>>>>>
>>>>>>> 1. DRM_IOCTL_XEN_ZCOPY_DUMB_FROM_REFS
>>>>>>> This will create a DRM dumb buffer from grant references provided
>>>>>>> by the frontend. The intended usage is:
>>>>>>>      - Frontend
>>>>>>>        - creates a dumb/display buffer and allocates memory
>>>>>>>        - grants foreign access to the buffer pages
>>>>>>>        - passes granted references to the backend
>>>>>>>      - Backend
>>>>>>>        - issues DRM_XEN_ZCOPY_DUMB_FROM_REFS ioctl to map
>>>>>>>          granted references and create a dumb buffer
>>>>>>>        - requests handle to fd conversion via
>>>>>>> DRM_IOCTL_PRIME_HANDLE_TO_FD
>>>>>>>        - requests real HW driver/consumer to import the PRIME buffer
>>>>>>> with
>>>>>>>          DRM_IOCTL_PRIME_FD_TO_HANDLE
>>>>>>>        - uses handle returned by the real HW driver
>>>>>>>      - at the end:
>>>>>>>        o closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>        o closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>        o closes file descriptor of the exported buffer
>>>>>>>
>>>>>>> 2. DRM_IOCTL_XEN_ZCOPY_DUMB_TO_REFS
>>>>>>> This will grant references to a dumb/display buffer's memory
>>>>>>> provided by
>>>>>>> the
>>>>>>> backend. The intended usage is:
>>>>>>>      - Frontend
>>>>>>>        - requests backend to allocate dumb/display buffer and grant
>>>>>>> references
>>>>>>>          to its pages
>>>>>>>      - Backend
>>>>>>>        - requests real HW driver to create a dumb with
>>>>>>> DRM_IOCTL_MODE_CREATE_DUMB
>>>>>>>        - requests handle to fd conversion via
>>>>>>> DRM_IOCTL_PRIME_HANDLE_TO_FD
>>>>>>>        - requests zero-copy driver to import the PRIME buffer with
>>>>>>>          DRM_IOCTL_PRIME_FD_TO_HANDLE
>>>>>>>        - issues DRM_XEN_ZCOPY_DUMB_TO_REFS ioctl to
>>>>>>>          grant references to the buffer's memory.
>>>>>>>        - passes grant references to the frontend
>>>>>>>     - at the end:
>>>>>>>        - closes zero-copy driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>        - closes real HW driver's handle with DRM_IOCTL_GEM_CLOSE
>>>>>>>        - closes file descriptor of the imported buffer
>>>>>>>
>>>>>>> 3. DRM_XEN_ZCOPY_DUMB_WAIT_FREE
>>>>>>> This will block until the dumb buffer with the wait handle provided be
>>>>>>> freed:
>>>>>>> this is needed for synchronization between frontend and backend in
>>>>>>> case
>>>>>>> frontend provides grant references of the buffer via
>>>>>>> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL and which must be released before
>>>>>>> backend replies with XENDISPL_OP_DBUF_DESTROY response.
>>>>>>> wait_handle must be the same value returned while calling
>>>>>>> DRM_XEN_ZCOPY_DUMB_FROM_REFS IOCTL.
>>>>>>>
>>>>>>> So, as you can see the above functionality is not covered by the
>>>>>>> existing UAPI
>>>>>>> of the gntdev driver.
>>>>>>> Now, if we change dumb -> dma-buf and remove DRM code (which is only a
>>>>>>> wrapper
>>>>>>> here on top of dma-buf) we get new driver for dma-buf for Xen.
>>>>>>>
>>>>>>> This is why I have 2 options here: either create a dedicated driver
>>>>>>> for
>>>>>>> this
>>>>>>> (e.g. re-work xen-zcopy to be DRM independent and put it under
>>>>>>> drivers/xen/xen-dma-buf, for example) or extend the existing gntdev
>>>>>>> driver
>>>>>>> with the above UAPI + make changes to the balloon driver to provide
>>>>>>> kernel
>>>>>>> API for DMA buffer allocations.
>>>>>> Which user component would use the new ioctls?
>>>>> It is currently used by the display backend [1] and will
>>>>> probably be used by the hyper-dmabuf frontend/backend
>>>>> (Dongwon from Intel can provide more info on this).
>>>>>> I'm asking because I'm not very fond of adding more linux specific
>>>>>> functions to libgnttab which are not related to a specific Xen version,
>>>>>> but to a kernel version.
>>>>> Hm, I was not thinking about this UAPI to be added to libgnttab.
>>>>> It seems it can be used directly w/o wrappers in user-space
>>>> Would this program use libgnttab in parallel?
>>> In case of the display backend - yes, for shared rings,
>>> extracting grefs from displif protocol it uses gntdev via
>>> helper library [1]
>>>>    If yes how would the two
>>>> usage paths be combined (same applies to the separate driver, btw)? The
>>>> gntdev driver manages resources per file descriptor and libgnttab is
>>>> hiding the file descriptor it is using for a connection.
>>> Ah, at the moment the UAPI was not used in parallel as there were
>>> 2 drivers for that: gntdev + xen-zcopy with different UAPIs.
>>> But now, if we extend gntdev with the new API then you are rigth:
>>> either libgnttab needs to be extended or that new part of the
>>> gntdev UAPI needs to be open-coded by the backend
>>>>    Or would the
>>>> user program use only the new driver for communicating with the gntdev
>>>> driver? In this case it might be an option to extend the gntdev driver
>>>> to present a new device (e.g. "gntdmadev") for that purpose.
>>> No, it seems that libgnttab and this new driver's UAPI will be used
>>> in parallel
>>>>>> So doing this in a separate driver seems to be the better option in
>>>>>> this regard.
>>>>> Well, from maintenance POV it is easier for me to have it all in
>>>>> a separate driver as all dma-buf related functionality will
>>>>> reside at one place. This also means that no changes to existing
>>>>> drivers will be needed (if it is ok to have ballooning in/out
>>>>> code for DMA buffers (allocated with dma_alloc_xxx) not in the balloon
>>>>> driver)
>>>> I think in the end this really depends on how the complete solution
>>>> will look like. gntdev is a special wrapper for the gnttab driver.
>>>> In case the new dma-buf driver needs to use parts of gntdev I'd rather
>>>> have a new driver above gnttab ("gntuser"?) used by gntdev and dma-buf.
>>> The new driver doesn't use gntdev's existing API, but extends it,
>>> e.g. by adding new ways to export/import grefs for a dma-buf and
>>> manage dma-buf's kernel ops. Thus, gntdev, which already provides
>>> UAPI, seems to be a good candidate for such an extension
>> So this would mean you need a modification of libgnttab, right? This is
>> something the Xen tools maintainers need to decide. In case they don't
>> object extending the gntdev driver would be the natural thing to do.
>>
> That should be fine. Most of libgnttab does is to wrap existing kernel
> interfaces and expose them sensibly to user space programs. If gnttab
> device is extended, libgnttab should be extended accordingly. If a new
> device is created, a new library should be added. Either way there will
> be new toolstack code involved, which is not a problem in general.
Great, so finally I see the following approach to have generic
dma-buf use-cases support for Xen (which can be used for many purposes,
e.g. GPU/DRM buffer sharing, V4L, hyper-dmabuf etc.):

1. Extend Linux gntdev driver to support 3 new IOCTLs discussed previously
2. Extend libgnttab to provide UAPI for those - Linux only as dma-buf
is a Linux thing
3. Extend kernel API of the Linux balloon driver to allow dma_alloc_xxx way
of memory allocations

If the above looks ok, then I can start prototyping, so we can discuss
implementation details

Dongwong - could you please comment on all this if it fits your use-cases
(I do believe it does)?
> Wei.
>
>> Juergen
Thank you,
Oleksandr
