Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDEIwE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 04:52:04 -0400
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com ([104.47.32.55]:5312
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751097AbeDEIwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 04:52:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
Subject: Re: [RFC 2/3] drm: Add helper iterator functions to iterate over
 plane damage.
To: Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-3-git-send-email-drawat@vmware.com>
 <20180405075205.GQ3881@phenom.ffwll.local>
From: Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <bdf67c61-3f4f-f321-9125-dc608c05c9b3@vmware.com>
Date: Thu, 5 Apr 2018 10:51:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405075205.GQ3881@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CWXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::26) To DM2PR05MB768.namprd05.prod.outlook.com
 (2a01:111:e400:244d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84b34ba4-420b-4737-b201-08d59ad27d11
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR05MB768;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;3:Vkdma1DtF5uGFlZecj5Wo+o4Dv235e+kikRhiLbaz4ix8KNGl8TYL6m3zDrvzePZDuc5jRcuFMcnBkMWscZHZQUK1APwdl+nfCDWffAIyeAitkjXGQuZGsv0l5OxckKLLPH0TQC3BkVhTNh25czxog/4FkX4/sOtJ7YPv/deKfIke2I+b75F0seOWY6YV1aPOb0yrcmJ+Gb3Hr6Op3vDkgX9YTkP+yaBTGxbqIzsQV/uRjOxxj5NYaxIp26n2ucl;25:p0EUgQQulN/DUoLQZyWUrLLnmMGDVbLU4YdTG4qfDDdzCHW7BaDT4wf6Vqlfq7/hrOebqs54lMqU5xmUsFyTiQKqLr0sAPKS4vzWo3uAgod31YBmebpCXHEGRIaYD2NbboHD/q720HjOU13nNykh5jPwf0/OGqyoBORZlyW5DpxZ/0nciB9tt9u/YqQTHXBtAO3RXF4sBR7xiK/9tcn6FzGT3QmC8rZfuefNF4NjnarNG21+5a4FG2T4cRyd4tRR93Zs8ApS+Ksw/oM4lTjtbDHaeaqKK1r+zXDU7K7Er9+6LStvISmLD6/lvspgFhFSjDsC4XuCZay1pC3cGT/raQ==;31:Hs3B46Psw5Ebdv9rIo6OPABnvtQUTkeQNyauIaJRrUV+bwKvtiSzq79OU5WtJdhGxGLjZ/ruCL8nwadQLuEU/lTAHiF31e464EEsDOMwzwzAo9yOkMbOoo7mJr3POSD05xD6YKSIWDobszPnF07g/+wMH2SNcSvGSbrJQaDuK5iGPkyX7iCNTcsSOO23YnDP9h25TxoBQT1qmco40an7UreFvncRqMqftwvSQ2XmLcY=
X-MS-TrafficTypeDiagnostic: DM2PR05MB768:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;20:i5MoO+W48WDOYO5La5LTbTpAlKRfBHeuh+oG8iSQlclI328l8WOgpVw7q8y5FJC/jGG5JjTDVRG/P8MY433eVrnWQcm1VkJzwXyXMwgfYL52wnH3FDwEkrn7UFCGzE2cIm4DsJSn9I9EQaWUq6lC2TQS+S518OobPBx9gOmVFidlpGcaw0xAV7dZx5Tgpp7jvDgcfL3TH0v+LKwN3rLcICg8bhCMYrdk8j7Zmfn+mdNPyxbu4zdJgIAMwqbXm7TzsHbHSOcpSp6W4qn7sK8wxN7iI3/zCorw4lz9bibOmt0yIZgUu/r2uG3fuJ1c7AekW2bBFS2r+T1Rt87Y38ybXsGLzPwBtsObrQJCW1MZylhYjjxcCJd3gWeUOmQ+8narcMdelLGF0eEebuYLAOOCn4QGE4INZbiENOwX1gbilGy1dXPYaH79OmVA0NtTTSX45maKkZ6CHXVFWKp0MU10UrE4UaMrcifzLD4tfys/5jYXIjp/6QDNjrUKs04DycsK;4:96rHleCm4yBxaMmFj70qgVhumWMmF64mooJ3aQ5PFB/zHW7059REndJ+UiovPkFakbDIYiuhcF8WCiFezBnBYnJ/FSLWcvF0hkIHZH8AXcsy2Hb32El9TbGEHXreW6CuCRZbmFigvH5Rs51bDUAvmjJwPemQGUUq53PEHaIQbW3bVpLXqrsIYOJ/QcUJq6mdhuImLJzqHcb5XxGrJQSkXnk4Uafmdr2kc4xflh2MjlxVdJyJsKAkW5C5etvfZIsrhJd8cQw1ALP6Txt0vcx5yw==
X-Microsoft-Antispam-PRVS: <DM2PR05MB768CD466F2B668BC3EC7887A1BB0@DM2PR05MB768.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM2PR05MB768;BCL:0;PCL:0;RULEID:;SRVR:DM2PR05MB768;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(396003)(346002)(366004)(39380400002)(376002)(189003)(199004)(7416002)(476003)(6116002)(446003)(305945005)(3846002)(105586002)(2616005)(8936002)(52116002)(2486003)(52146003)(23676004)(2906002)(67846002)(65826007)(316002)(6246003)(558084003)(229853002)(81156014)(39060400002)(81166006)(478600001)(11346002)(230700001)(6486002)(8676002)(31686004)(7736002)(956004)(16526019)(36756003)(53936002)(97736004)(186003)(6666003)(106356001)(386003)(31696002)(86362001)(6512007)(53546011)(6506007)(76176011)(50466002)(47776003)(58126008)(68736007)(25786009)(64126003)(486006)(26005)(66066001)(65806001)(65956001)(5660300001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR05MB768;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjA1TUI3Njg7MjM6L2p5bjQ0UWRKOHdqVmpMcThaUXVvaHA3eERI?=
 =?utf-8?B?aEJRZ0RFMlFFd0Z2bFBRYUg5aE92bjdtOVIwTkNyTVdqQU5oeWw2UG94M0RZ?=
 =?utf-8?B?VGFIWTNuSUZVb2JybnpNL2F6eXVMY2xUMGlCeGE1Q283Qkw1amZyY1U2VThu?=
 =?utf-8?B?eUdTOXVkcCtWWGdNd1gxNDZTckgzYVVWTHRNdFNndEQ3dElvTGZiaW1RakU0?=
 =?utf-8?B?dXdXSVNCN0c0VmhkbEUvSTRIREVGQ05pQTFjZXdoOEZpY1pCZ3Q5NDdreDUw?=
 =?utf-8?B?SzQzNmdnMVZkR0FPekI5RUNWMG9lS24wQ3F0alAyZ2o3RmRKdy9WU09Ic2hM?=
 =?utf-8?B?RVhaU2FGSXBvYVpKVDA5VmJJRGhFMjFMUzJpcUlqd3J3bnBIQk5NdVptK0JW?=
 =?utf-8?B?VW5QT3k3U29zR3p3Q0NSdlp5OHNueFFBYTRKY3g2M01QNHowbnpyWlpLVFJt?=
 =?utf-8?B?bEpHbDF3RXIxQjVqT1FFUWhxd1E3ZmRFNnRSSHBNNlovUXJveDJNZ2ZJS3dz?=
 =?utf-8?B?ZitSRVdiUTlpWGJlVWJrYmFkem1idTlSMjFOL2o0UlY5K3lZdDVMZFpqVU43?=
 =?utf-8?B?L1dTU2wxUTkyd3RJamgzd2dsU3Bja0xnRlZoWVA0QWlMUnI0dWdtUUdRZnFM?=
 =?utf-8?B?azNFMU1xM24rZ2FPcEpHTTkrNy9pYmRqM2IwNXp1N05vU3RpRFpUeVEwQ1JB?=
 =?utf-8?B?TUZhaGMwZmRESjhtczMwSGZSZ0YyOHZkZFdIcW02dU5QL0ZBVC9LQ0xkSkJY?=
 =?utf-8?B?bUVQS2tCUDg0YXd0MWNDZ3dVNlEzR0FrUGRlNTBEbE1MR0g5Z1YzWUtJZzU2?=
 =?utf-8?B?WWRHU2t2bjJ4VXBTdUErd0pUYzhKMjBxbUJCVEVHVGlaNmNiKzlRRUtSblRt?=
 =?utf-8?B?OWNEZm5URy9WTENmc0lDNVZiSEl0a0twTitxSUpMSHFLQ215ZituVDlpOGt4?=
 =?utf-8?B?WnF2eEJGSWpMdW5YUzB5Qk1XRWFBdmE0UW1nNmF3eURwZVdoWHZ3djlIREVS?=
 =?utf-8?B?OE1CakNLYnNPbm02dHErSHVwZUVUVXREMkFiUzhLUSswNVF2QTAwTmVEYlAz?=
 =?utf-8?B?a1FJdVB3Tkx2Wk5sWTBnSTlmZ05yQ2k1VmpEb1pvanVSd3FZZmp0OW9YT1Rx?=
 =?utf-8?B?bkJLV1hlYmZZNjJEQlVsN0pRYWpOeXROK2pZME4rWHJTTXhHTG1rb3YzWGph?=
 =?utf-8?B?V0hLR2xWM2hZMmRLUHdDTlNjdDRRdDBMRjhtaXlVcnZSdUpoaGZyQWNVckdB?=
 =?utf-8?B?RS9wZnM1U1dwMW94ZTNseE1DR3k4NEVBMFo2QUlnSzhOdkdGaHJpellVd3ox?=
 =?utf-8?B?MXRXNFM5RTBZOHJpa3dOUTdOY3cvOTBUNjVhbVJLTitvNGM5SlNLc2dNRVh6?=
 =?utf-8?B?S2tudXhBdUcwUTZ0SEtrRUdFZm1BS2Z0REg4anRvbVBwZXFUYmsxWUdGVWxJ?=
 =?utf-8?B?cTgxZmtmL1hMY0lqUVpSekQyOHNqVnQzYmxHbXlaenQ3Y3c5bFJzMS9qbW1M?=
 =?utf-8?B?UDZ0VE5Md2RXVkVHTWR1SlEyQjZkQTJXVCtHeGo5M2RvM25LZEJlNDhmc2FZ?=
 =?utf-8?B?VEVBYytabHlBVnRHK2txYmFkM3djcEZxZ3FOWUJIMWdJVk5kZzBTb3B4QkRL?=
 =?utf-8?B?R1JhL0NrWUFlMHRwMXNDYWNRZzBUMHBqRU9JZFRLQzFjM01XdFg1Sk16WWg2?=
 =?utf-8?B?ampsT2FwbDdoUEw0b1Y1ZVZRZkt3NC9LaXg4M3JYZXhocFRXN3VRQnJJdDha?=
 =?utf-8?B?TlZXcy9RTFlTSlFEQ2gxd2VKV3V2SlpZU0xyby84RzhNakZJTm40R05ZMXhr?=
 =?utf-8?B?ME04ZjZhR001NDBwTHhUQW5OeWxkVmUyMDJ5MjVhWkhYbHFtSVpxYXJkMXdy?=
 =?utf-8?B?NUxZeUhXTXZzU1NSdTRZc21MeW5aU213ZGJLV09sZzRNVXc1c2dER3p1UUM4?=
 =?utf-8?B?RS96K3JOdmdOQWlseEc4eW5nYlk4bHdHK0JmTUJaQzlaSGRrQkl1QWdxZUVi?=
 =?utf-8?B?QTVjVzVqNzNocm5YWDBOTkpXb3ptNGh5SytjSHBpa3dlV0FYZlBxdUpqYUFX?=
 =?utf-8?Q?kec=3D?=
X-Microsoft-Antispam-Message-Info: ATqXkVn0nxfrFjgMsVNmfVgzrkmpVMw99Pykp2IVa0zCmBEL6DmfoQEZ/yXGM4jrv6LvLzCin+Z8JT5t+PAujTWegwVMErtEdDNvNxJj8o4teRsd3Qos+jDf1WYrGIHjZwuCg9M2kH2hZTaGxmzKCTu17FuHKg4ZrdrwaH9QZcgw7346FUfdptipsuVdRqvr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;6:OoJo9ullkEgWizGITVbnm6Ysv+du5gM79WhpsVfrAhuPRZkVem/jr9vL0Rphq5BT90fTCvYOJkquU9B9kpllCRTQyQ0jKjzONO4zHkDCa1bXfno0+oiR7zWV66O1nxe+NUW/pnFvqHcPMj1Z+O5nyUbTUZHv9Tz37oW9hhig4fb7cFw/ihaqotmn/b8N9RrgB9Bob7jQyUt5p5sHN7DXWJI2w7EiJS1gPiRet+dXQgvll1DO8o6muiY6ILS5VOx6KAnTtXfIrvxedGhHZhQwTpg7FOm1od3VIghACU2jCvxy+JgEh4bFgqJvErzZtudpqgeAxOsNGFdxyFKoszbyo6tucsQpP3yB3xAqbNVHUy6oV8XuQ2yZ6WO9+wGTyN5OjUdHA4j56fAozmhyrPf75oNqa0qpeg3EyoZBOhJ2mA4vVBIuU1gDAMEuFZksMWTcDYCMcv6sggN4y2FFtc+pAw==;5:bPcSC5bjoUXYY9oCCs/Zd5OLmRiNs5g6Vb6MNKFCRTD4CtfO3peFYkP3sTXzM7angAPgJai9zuqUp7VrydaFTUM4TlPsaCBkaAQ+hZycPwtDG8V8+QJBYVyfjr5XQBG6eZyXYpvPakHiZ+yPRkvK70aQbZvU3IlAar01VKYzR+I=;24:1WYpJWx0oNEDyPsndAUEZSozLIhpM4etWWH6vRJV7blCUSKo2Pfzy4dWm+Ko2CMEu9YvwJ/LSj6A74jOs+0S7JKgPJSn01B9ec3HFutnAZw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR05MB768;7:Fhq4ZfXX1zErQRy3gCBOSxqgLjlI+zMhNgQKXRKi+XRkYbhBasGvli9ZlfioIj9xLrHY9CYEjQ0LwPCtMHHQ5iYcWa63d4KCsMhW8V3ZwRqsDpd/EG8f9E9bnt/6TI/F8QdDDx5ydGrT2KI4LlexHguKRB0CKqgEFh4HMqbEve1mtJFcsVuiKjvADzOpgmwcM3tzWBcQJtFnPt1w7sDPJl6UpsHla4f/aCjS1zsl275hWTaOHkDrzcdQJ4Rs/KUt;20:Ir73x8yK2zN/xYIwFuEQgMgDjbXCjLRr3iD1NDq0yyGqDVnuzE9td2M0xfSd8LJiLfUEMi8n6HHuVuB1yEPyNgPLjY21ulODyfwxGEcXtHktldTfMZZqAVzdP3YTuyZTgluTipI4Fk+0S77TbOynFwh0UeLtSLFCDHaDxjxfgZ0=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 08:51:55.2411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b34ba4-420b-4737-b201-08d59ad27d11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR05MB768
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 09:52 AM, Daniel Vetter wrote:
>
> TYPE_PLANE I have no idea who needs that. I suggest we just drop it.

I'm assuming CRTC plane coordinates here. They are used for uploading 
contents of hardware planes. Like, in the simplest case, cursor images.

/Thomas
