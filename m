Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeDDVX7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:23:59 -0400
Received: from mail-eopbgr00115.outbound.protection.outlook.com ([40.107.0.115]:28046
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752236AbeDDVX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:23:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com;
Date: Wed, 4 Apr 2018 14:23:41 -0700
From: Andrei Vagin <avagin@virtuozzo.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        david@fromorbit.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        snitzer@redhat.com
Subject: Re: [v8, 11/18] mm, dax: enable filesystems to trigger dev_pagemap
 ->page_free callbacks
Message-ID: <20180404212340.GA12737@outlook.office365.com>
References: <152246898837.36038.26895928842345061.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <152246898837.36038.26895928842345061.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: HE1PR05CA0170.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::18) To AM4PR08MB0740.eurprd08.prod.outlook.com
 (2a01:111:e400:59ed::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 079761df-6fc2-4dab-0416-08d59a725d38
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR08MB0740;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;3:RFM5Z/sxRdQKhast1NujZcdcvTtp+i8uAwau4S5gT2X8Si4rr1PIGDdrlgB0+mRQE3I86vguQExj5WPEY2IJWLtTCabHxJH6quHst/oG0l08VzYPiuiJj49Nk5Ujgs5uZ32vs9D8ohvsm8srARF8tb2uujXO9aFnpHOCmNYuuXtlWiP7WAqZAvzi7P5nPgYliHfqzRAB9+Hb6ZZiOV1IgqeuUebv7ieeWNAh/NqI7UhJbidecD92NS9uHLuakXSd;25:hrLAJmi7BjbFmoMfOqjN1jzviq8QNYvPkTJ36Z87k0nYnI7tkvA/1m50+VBsnijXfv01A6oKuzIxh+asvKFk5aa7BjIAx5BOTNkdcwB3CUcTZQAXVRgzgQK65IGYFXJufmeBsoqf00l2fHqOvws0/4adRBhmGoi8uCABncJfmq+aJ6FqLn1u6Phekj8mR+iG3YjrtwKl5+IS7goSQnVjko2MRurWJdYUno3flHG/k7huRrbOtwiQRAts5gjcye61R5BH5glTzOHsw0rnIKHcMk+mA8xDVlMA6QYfY0kCaQpiWnzgU1v4jFlxvPoA+zMsl6CEwfE/E1RFHrJkQA6B5Q==;31:H4ZTrYIwiz62rpfnGUO2oxX737oxeSIfdv64pSG74bFTycZ5JGc/Qn6iGWE39pj5Ez2tgO9CJQcAtS7MOTWAeiGTJJt6/ux3o3n6NMQ7wKZVi8f4BYuecDleNqzakDyn15TM3MSv2S9Q6TdawfpzsRoX37Un1CURxjXa7fteReHubKcY/lUZfjV2Z3/OkiqGyb+bAZdr9FdgkOtue9OuD9J/PICSG7APCnFf+Edo5aQ=
X-MS-TrafficTypeDiagnostic: AM4PR08MB0740:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;20:7vwoYzaMilqeJ9a/vzzSWgTJ+NsSpPzBEFEOYt+TD6DEIjGW3WflQu7TCsYI9t+U4V0OwhiQzffeqmKXNPEwJgnjjevuoTO1OdhBVgNI6bHQJl3hzU56lirWI25sDCuzti06SEirXCT1d3RKPSbgp6XgSMrFc4jxNMbB0oBSa/zCrYMyCCKXrqiResSamitn1it21mXil3wam2r0Vvhj/DoMR6dvTi8oFDwnqQjGA/r0xAATyp7FtvYjSuxnRNDN/XOWKxrmUVx+1GJaF19+Z5KIKvOKoIbnHCziIqDY/SmVVoTwTZu6oRW5fZ5TRhHd9rmnZBbti/Mvo9nI3tX3IHInR1iIbkDuQwGHl4ixdI9g8KdyqM52kgK6COpgNeUHnWFBtAQmPpb1qrQxRdRH+qqdeM3BiYxgdJ6J7uIV/wQeeZOWjzIRJmz7HQCfqOnnWnLJr2krWM/xe9m4LX7f5uxEQA+h4gRide8NS/I5dDG76ZmWY/qhPcX27jTuhm3l;4:qf5cF9GVjnwZRJ6rnXdqqO2XQ6PCblkJfArOX9VxKTYgIBL7HdPqGHDwfZcmt7lCFqjGgSFPYoGj8iHekoZJga7jn0HATxBbJr7/HiCKAwtdLHTchx9FwAVUmaaOtGWS4ZTUzJIQA6Uqg2qvZBVzbb30MzZMkMwOuwEuTdfOvdKNSTQ6uMVg/SNxNjyh8a0tTkt1VB0OoO+noEYAa8Bksvs8BKdff0V/oz4/t/gwu2Q9NxddenOMdLSYHLTa6EVLiR/oWVMTTvfLH7S7LtKC8ZjA1E432Dm5tiC6n96X+g8roDbuEGfEm4YsjWZ+jbdw
X-Microsoft-Antispam-PRVS: <AM4PR08MB07401CD7F527816572D549ACCFA40@AM4PR08MB0740.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM4PR08MB0740;BCL:0;PCL:0;RULEID:;SRVR:AM4PR08MB0740;
X-Forefront-PRVS: 0632519F33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39850400004)(346002)(396003)(376002)(189003)(199004)(59450400001)(4326008)(446003)(1076002)(478600001)(8676002)(86362001)(53416004)(2870700001)(6116002)(575784001)(53936002)(229853002)(106356001)(3846002)(6666003)(105586002)(6916009)(81156014)(81166006)(6246003)(5890100001)(97736004)(45080400002)(68736007)(54906003)(16526019)(186003)(26005)(8936002)(69596002)(316002)(47776003)(6506007)(66066001)(58126008)(956004)(9686003)(76176011)(7416002)(33656002)(7696005)(305945005)(52146003)(2486003)(476003)(23676004)(50466002)(11346002)(52116002)(386003)(486006)(2906002)(7736002)(55016002)(37156001)(5660300001)(25786009)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR08MB0740;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA4TUIwNzQwOzIzOlZWMzI0cVdaemtVU1VyM0hJd1pBN2x6N1lj?=
 =?utf-8?B?Wjh0ZTNUN21yOTl2RGlsOGNjMXk4ai91b25od2wyZTFkNjd3c0VVVU1PR3JQ?=
 =?utf-8?B?Rml0TC9tT2JHT3RGa1I0K29sQWdmMWpmYStYQnFoaEdBNGtQRE5PYkJ6eGJn?=
 =?utf-8?B?aHpEZnNHZ1ZKNFdkaGYreW9DNklianE4SlgxdEg2TUY0TENrSW9OQ2N6OUl1?=
 =?utf-8?B?RnRyV0JQV3A1QSt5a3p5d0NLS01RaFJEK2lyMnN2bHVVdzJVeTJ4UExnSVo4?=
 =?utf-8?B?TjJmL3J4TktMMmtyR2VXdk9aTGY4UEJsN0Nia0pLY21zb2wyOXhpL0lYbXRG?=
 =?utf-8?B?SU5HMVk3TXV6ZWJyelFrVDlHYUNIY3lwWmN4d3dYSnNWamZ0RVp6WS9mV3JW?=
 =?utf-8?B?Zm5iNGxGZ1pzOG1tOFJqT0tvMStWdWI2WjlMY3RMakFoR0pVYyt0Y1hKdUlk?=
 =?utf-8?B?NElSUVBxdDJxSVdHRmRFNTNleUtUdkc3ZDFoNzVQeUhNWVRNanRGY3lkdlJ5?=
 =?utf-8?B?OGd5TUg0U0V3d21JdzZla0h4Q1VYcmZ6RGl5WjI2aWZLZ0Z3QTJaWlppNVhz?=
 =?utf-8?B?dWtWZlhsMy81czhrZzYrWWRsemRrdzZUOXpaYytRY1BPTFJKa05MOXhyVW0z?=
 =?utf-8?B?WWoyU0svN0ZpT1Roa29uRzdSeWZSU215QU9NR1NRaE96bmx3RzFKL2diZnZw?=
 =?utf-8?B?SG1JVDNQZ1dqeHZaRUZObGQwaG1OdDUvRjloNDFzZzYxOWxwMEdqQ0lNM3JM?=
 =?utf-8?B?cUFkeGk1YUVsOVIwUytYc1U5ZkYxTFJaOE9PNjRydXJFRy80eTNZaG8vMGds?=
 =?utf-8?B?TUtwRnBKN2VNWFUvOGYxMnRZdFIvMUQ1dEZrQXZaN3V6WWFGcWJsdnVGVlBm?=
 =?utf-8?B?djFBaDdXWlJpMS95VUkvN2xadDIzYVlNUk1Bc3Nhd2pFNlhYN0JYbjB4WHFI?=
 =?utf-8?B?dnlGVHdUN05kR0tiSzFnK1NMTU5aQmxsTWF6Q3dnbzhMSkJzUW9mc0s4aDNu?=
 =?utf-8?B?T2h6K3ZCQU56OGUra28rQkJWMVZoSTNwSDdKNDlTL1BEZnBvVVRLc0hObC8r?=
 =?utf-8?B?T24weS80czY0aG5xdVp2QzhCbEZJck9jSXR3TzZmSy9rYXNRNXFyeHpmanVP?=
 =?utf-8?B?dTRqeUZNRlFHUnZxSWdyTjNaUkJKOGsyaGo2cXhtdHRMdkl6d3lGa2tiVklZ?=
 =?utf-8?B?eGJNZGVKZGpiMVRlY0E2Vkh4NWdpcGhldENveXZkMjZaWXdVMzZTczhUaWRM?=
 =?utf-8?B?akhtRmtvT3d1OHpkc3pQMXNTLzZSVnBqMEwyblpOMzJRMXVwdVlGOUhKMmo5?=
 =?utf-8?B?UFBBZUxOdXVIcFIveVpkS2l6THhQeE90NElmUkZmSHZJM1Y2Z0JwUmxIVHpy?=
 =?utf-8?B?SHdmNjNUMjBGTlYrNFVNbWFud3RyNnRWeW0vUVkvV08yREwrQkgzME9BUEQ5?=
 =?utf-8?B?cWMzaTJrV3M1YWUyTC9FRXp1OXhWeFFQSjJrSS9SYkNEVW5kNnFHVStFMWl5?=
 =?utf-8?B?cnpkK284c0NWbHIyMFJvbkplK2xGdGNUMjFYWHBwb091cTR1b014ei9WNWxG?=
 =?utf-8?B?YXlpTjVvK3Y1VElmK05sbEhOSWticGJIV2FsTlJMZXJ3c3BsSXphTjRUNWhR?=
 =?utf-8?B?RXI1TjBNbHhOZDEySjlubVBnSnNhK1ZFcUl4UFFVa3BVc2NEY3lYNmZjNjNL?=
 =?utf-8?B?WVVZYVorR0gwNitJUDVBZ1EwTGFEZE9RRXF6YWx0Y1pNdjRwUUovUk15dVlw?=
 =?utf-8?B?c0licXRvb3lxVURGejdJeXhab2crUllGbDhYTUFiakdDLzR3aUpZajQ3UVE0?=
 =?utf-8?B?MWE5MW9HNy96TFlsTzdXUHpvakg4THRUaVQ5Y1BieWt4N3Bka3RFOEdMbzdn?=
 =?utf-8?B?Z1k1bm83VFp5ekV5R0Q4RkltVmlHdldHR09ZZzBKc000OTNwSmpBKzV2bWZ6?=
 =?utf-8?B?WEIvWXpoQ2Z4ZWIvdE5zMkd4dFlHWTdMdFl4NUZmTFVjd1RiMEpWZDNoVGNK?=
 =?utf-8?B?WjNXZk1YRXJHOWU1dHNieW1DRVlsYXc5N2ljYXJGM1JUM2Z6RC8xaGFPOXZL?=
 =?utf-8?Q?shRs=3D?=
X-Microsoft-Antispam-Message-Info: S2E27+KpSN2YZ2M8T9HlGo+81jISELyZ1BFlXUhAVqaCHabABoj0rhAAAuDHk3VZIVvvRbkGrF3eHzs3dgWe8mNhGN7BCJOB3gqlUE9l22Eanch9mIZay5oFabKzQ+t7ePXzTRWQp95J08+hLdEe/HFcnqCRXmMpZm9a2hkydc2tmDnUqrfpJfygI62gVPo9
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;6:6SBIq69Dudyfs8/sKB+hBglL7fVfAa0+cIgdK/+utcdOjJwzgPG8xTdfR+4uDO4qbP1y2O57TVMzdxT9Fs398jhKcwIYe2xyXIXmcTdUfoXbA4Jl5fAAFqNE7SxTo7RfkjjGd/EggZrPB/ONbRAYOVzpnzqh5RtdTEW9WJ1I+pxEWdmaCXLd10qYO6B1pMLTgDNsC0j9FQIE3QCKtEA3AZmzvxuMoCjwFfFE2uRKEHd6YcKL3c2km4/uEnArCils1IEbqWPT7divMtDCXssYAQaQO8txhHRnvPMvVvs16Uwh9zsQLJKzDpp2Z+KpqLxRJUZJXN4wJ5X1QL8xxb1wf3qNF5TSyrHJeCkjVVsQ/K4hBKLLorn3QKyQ/JfkcyOtjQ1lzmBF1yAKgG/05n+9wvzAZheP3OIgJmUlMWBGMNvulG3dIyesb7mqRWhAQOXftm/4Gzr/ne0+FGRSpCDhJQ==;5:useM0OLkwligjbmqCelKyqnaCixEYuPlCLBwzcQekIbxZmP3Zvjfywt40lyxb5trxEO1QZw1UO/VgDo11gwp9w3racr3WpEi6y56iTcLwtcnbOCrz8Qux6l4T++K9h/uFEKmYPEcZd6qAZU89Ks+KdLzDB61HocKQ66hPldYMTA=;24:16om+OvuR5l2lRFvj0T4nKBkRhBZFDuPcHadFOMXL+hcLqpTr2f5hGYD6wOQ1MkGMcCVvxO8yYwEAX3b1Zl8PRbC11daJNSuSiz8n1VGMsQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR08MB0740;7:Yb3D861MxC9I75oUTvatWhgW4+l/bQWxBaEnSr3tI8RC6X7QZE/tgwQqkcHp8N5TDvD1W8AMweW/VXA9T9ZTsszb4bGEA57mCP99iV+invbcvhxuEuRWGinEoehU38U4nhBwKZd1aXV57u8lQVUtXjUPgoCHK9ZHyukW/S+7ZKzVAx9P1WcLC3esxEPvQ+HxnkhRUKLuTJNGo+Sf7YGRkBOrfNkQ4rOP/wX8MMHX0J10MaY8D07PLP7qCMDcbfQZ;20:dzM+THfPsvRplmx5s0Szl+/ZnaTunfC7WdbkZqD/pqluA7/d5qmr1DU2F7xbxYht/8wVmYWnYrDh1IAPfIxMNH/vcbAXQIlXnKuwtunstUz4D9L5kYWTrnCyTr3u4zaf4P3G3D0Vg6xFRR42G7IHsSOspSk4zbB2oxmqpeZ/3R8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 21:23:49.4000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079761df-6fc2-4dab-0416-08d59a725d38
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB0740
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I catch the following bug on the linux-next 20180404. git bisect brought me to this commit:

commit 8e4d1ccc5286d2c3da6515b92323a3529aa64496 (HEAD, refs/bisect/bad)
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Sat Oct 21 14:41:13 2017 -0700

    mm, dax: enable filesystems to trigger dev_pagemap ->page_free callbacks


[   11.278768] BUG: unable to handle kernel NULL pointer dereference at 0000000000000440
[   11.279999] IP: fs_dax_release+0x5/0x90
[   11.280587] PGD 0 P4D 0 
[   11.280973] Oops: 0000 [#1] SMP PTI
[   11.281500] Modules linked in:
[   11.281968] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc4-00193-g8e4d1ccc5286 #7
[   11.283163] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
[   11.284418] RIP: 0010:fs_dax_release+0x5/0x90
[   11.285068] RSP: 0000:ffffb1480062fbd8 EFLAGS: 00010287
[   11.285845] RAX: 0000000000000001 RBX: ffff9e2cb823c088 RCX: 0000000000000003
[   11.286896] RDX: 0000000000000000 RSI: ffff9e2cb823c088 RDI: 0000000000000000
[   11.287980] RBP: ffffb1480062fcd8 R08: 0000000000000001 R09: 0000000000000000
[   11.289147] R10: ffffb1480062fb20 R11: 0000000000000000 R12: 00000000ffffffea
[   11.290576] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9e2cb823a048
[   11.291630] FS:  0000000000000000(0000) GS:ffff9e2cbfd00000(0000) knlGS:0000000000000000
[   11.292781] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.293602] CR2: 0000000000000440 CR3: 000000007d21e001 CR4: 00000000003606e0
[   11.294817] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   11.296827] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   11.298293] Call Trace:
[   11.298728]  ext4_fill_super+0x31b/0x39d0
[   11.299441]  ? sget_userns+0x155/0x500
[   11.300144]  ? vsnprintf+0x253/0x4b0
[   11.301223]  ? ext4_calculate_overhead+0x4a0/0x4a0
[   11.301801]  ? snprintf+0x45/0x70
[   11.302214]  ? ext4_calculate_overhead+0x4a0/0x4a0
[   11.302822]  mount_bdev+0x17b/0x1b0
[   11.303332]  mount_fs+0x35/0x150
[   11.303803]  vfs_kern_mount.part.25+0x54/0x150
[   11.304443]  do_mount+0x620/0xd60
[   11.304935]  ? memdup_user+0x3e/0x70
[   11.305458]  SyS_mount+0x80/0xd0
[   11.305931]  mount_block_root+0x105/0x2b7
[   11.306512]  ? SyS_mknod+0x16b/0x1f0
[   11.307035]  ? set_debug_rodata+0x11/0x11
[   11.307616]  prepare_namespace+0x135/0x16b
[   11.308215]  kernel_init_freeable+0x271/0x297
[   11.308838]  ? rest_init+0xd0/0xd0
[   11.309322]  kernel_init+0xa/0x110
[   11.309821]  ret_from_fork+0x3a/0x50
[   11.310347] Code: a5 45 31 ed e8 5d 5e 36 00 eb d7 48 c7 c7 20 48 2f a5 e8 4f 5e 36 00 eb c9 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <48> 8b 87 40 04 00 00 48 8b 40 18 48 85 c0 74 05 e9 c6 7e 60 00 
[   11.313168] RIP: fs_dax_release+0x5/0x90 RSP: ffffb1480062fbd8
[   11.313991] CR2: 0000000000000440
[   11.314475] ---[ end trace 8acbb19b74409665 ]---


On Fri, Mar 30, 2018 at 09:03:08PM -0700, Dan Williams wrote:
> In order to resolve collisions between filesystem operations and DMA to
> DAX mapped pages we need a callback when DMA completes. With a callback
> we can hold off filesystem operations while DMA is in-flight and then
> resume those operations when the last put_page() occurs on a DMA page.
> 
> Recall that the 'struct page' entries for DAX memory are created with
> devm_memremap_pages(). That routine arranges for the pages to be
> allocated, but never onlined, so a DAX page is DMA-idle when its
> reference count reaches one.
> 
> Also recall that the HMM sub-system added infrastructure to trap the
> page-idle (2-to-1 reference count) transition of the pages allocated by
> devm_memremap_pages() and trigger a callback via the 'struct
> dev_pagemap' associated with the page range. Whereas the HMM callbacks
> are going to a device driver to manage bounce pages in device-memory in
> the filesystem-dax case we will call back to filesystem specified
> callback.
> 
> Since the callback is not known at devm_memremap_pages() time we arrange
> for the filesystem to install it at mount time. No functional changes
> are expected as this only registers a nop handler for the ->page_free()
> event for device-mapped pages.
> 
> Cc: Michal Hocko <mhocko@suse.com>
> Reviewed-by: "Jérôme Glisse" <jglisse@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dax/super.c   |   21 +++++++++++----------
>  drivers/nvdimm/pmem.c |    3 ++-
>  fs/ext2/super.c       |    6 +++---
>  fs/ext4/super.c       |    6 +++---
>  fs/xfs/xfs_super.c    |   20 ++++++++++----------
>  include/linux/dax.h   |   23 ++++++++++++++---------
>  6 files changed, 43 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c4cf284dfe1c..7d260f118a39 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -63,16 +63,6 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  }
>  EXPORT_SYMBOL(bdev_dax_pgoff);
>  
> -#if IS_ENABLED(CONFIG_FS_DAX)
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> -{
> -	if (!blk_queue_dax(bdev->bd_queue))
> -		return NULL;
> -	return fs_dax_get_by_host(bdev->bd_disk->disk_name);
> -}
> -EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
> -#endif
> -
>  /**
>   * __bdev_dax_supported() - Check if the device supports dax for filesystem
>   * @sb: The superblock of the device
> @@ -579,6 +569,17 @@ struct dax_device *alloc_dax(void *private, const char *__host,
>  }
>  EXPORT_SYMBOL_GPL(alloc_dax);
>  
> +struct dax_device *alloc_dax_devmap(void *private, const char *host,
> +		const struct dax_operations *ops, struct dev_pagemap *pgmap)
> +{
> +	struct dax_device *dax_dev = alloc_dax(private, host, ops);
> +
> +	if (dax_dev)
> +		dax_dev->pgmap = pgmap;
> +	return dax_dev;
> +}
> +EXPORT_SYMBOL_GPL(alloc_dax_devmap);
> +
>  void put_dax(struct dax_device *dax_dev)
>  {
>  	if (!dax_dev)
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 06f8dcc52ca6..e6d7351f3379 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -408,7 +408,8 @@ static int pmem_attach_disk(struct device *dev,
>  	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_res);
>  	disk->bb = &pmem->bb;
>  
> -	dax_dev = alloc_dax(pmem, disk->disk_name, &pmem_dax_ops);
> +	dax_dev = alloc_dax_devmap(pmem, disk->disk_name, &pmem_dax_ops,
> +			&pmem->pgmap);
>  	if (!dax_dev) {
>  		put_disk(disk);
>  		return -ENOMEM;
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 7666c065b96f..6ae20e319bc4 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -172,7 +172,7 @@ static void ext2_put_super (struct super_block * sb)
>  	brelse (sbi->s_sbh);
>  	sb->s_fs_info = NULL;
>  	kfree(sbi->s_blockgroup_lock);
> -	fs_put_dax(sbi->s_daxdev);
> +	fs_dax_release(sbi->s_daxdev, sb);
>  	kfree(sbi);
>  }
>  
> @@ -817,7 +817,7 @@ static unsigned long descriptor_loc(struct super_block *sb,
>  
>  static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  {
> -	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
> +	struct dax_device *dax_dev = fs_dax_claim_bdev(sb->s_bdev, sb);
>  	struct buffer_head * bh;
>  	struct ext2_sb_info * sbi;
>  	struct ext2_super_block * es;
> @@ -1213,7 +1213,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	kfree(sbi->s_blockgroup_lock);
>  	kfree(sbi);
>  failed:
> -	fs_put_dax(dax_dev);
> +	fs_dax_release(dax_dev, sb);
>  	return ret;
>  }
>  
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 39bf464c35f1..315a323729e3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -952,7 +952,7 @@ static void ext4_put_super(struct super_block *sb)
>  	if (sbi->s_chksum_driver)
>  		crypto_free_shash(sbi->s_chksum_driver);
>  	kfree(sbi->s_blockgroup_lock);
> -	fs_put_dax(sbi->s_daxdev);
> +	fs_dax_release(sbi->s_daxdev, sb);
>  	kfree(sbi);
>  }
>  
> @@ -3398,7 +3398,7 @@ static void ext4_set_resv_clusters(struct super_block *sb)
>  
>  static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  {
> -	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
> +	struct dax_device *dax_dev = fs_dax_claim_bdev(sb->s_bdev, sb);
>  	char *orig_data = kstrdup(data, GFP_KERNEL);
>  	struct buffer_head *bh;
>  	struct ext4_super_block *es = NULL;
> @@ -4408,7 +4408,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  out_free_base:
>  	kfree(sbi);
>  	kfree(orig_data);
> -	fs_put_dax(dax_dev);
> +	fs_dax_release(dax_dev, sb);
>  	return err ? err : ret;
>  }
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 93588ea3d3d2..ef7dd7148c0b 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -724,7 +724,7 @@ xfs_close_devices(
>  
>  		xfs_free_buftarg(mp, mp->m_logdev_targp);
>  		xfs_blkdev_put(logdev);
> -		fs_put_dax(dax_logdev);
> +		fs_dax_release(dax_logdev, mp);
>  	}
>  	if (mp->m_rtdev_targp) {
>  		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
> @@ -732,10 +732,10 @@ xfs_close_devices(
>  
>  		xfs_free_buftarg(mp, mp->m_rtdev_targp);
>  		xfs_blkdev_put(rtdev);
> -		fs_put_dax(dax_rtdev);
> +		fs_dax_release(dax_rtdev, mp);
>  	}
>  	xfs_free_buftarg(mp, mp->m_ddev_targp);
> -	fs_put_dax(dax_ddev);
> +	fs_dax_release(dax_ddev, mp);
>  }
>  
>  /*
> @@ -753,9 +753,9 @@ xfs_open_devices(
>  	struct xfs_mount	*mp)
>  {
>  	struct block_device	*ddev = mp->m_super->s_bdev;
> -	struct dax_device	*dax_ddev = fs_dax_get_by_bdev(ddev);
> -	struct dax_device	*dax_logdev = NULL, *dax_rtdev = NULL;
> +	struct dax_device	*dax_ddev = fs_dax_claim_bdev(ddev, mp);
>  	struct block_device	*logdev = NULL, *rtdev = NULL;
> +	struct dax_device	*dax_logdev = NULL, *dax_rtdev = NULL;
>  	int			error;
>  
>  	/*
> @@ -765,7 +765,7 @@ xfs_open_devices(
>  		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
>  		if (error)
>  			goto out;
> -		dax_logdev = fs_dax_get_by_bdev(logdev);
> +		dax_logdev = fs_dax_claim_bdev(logdev, mp);
>  	}
>  
>  	if (mp->m_rtname) {
> @@ -779,7 +779,7 @@ xfs_open_devices(
>  			error = -EINVAL;
>  			goto out_close_rtdev;
>  		}
> -		dax_rtdev = fs_dax_get_by_bdev(rtdev);
> +		dax_rtdev = fs_dax_claim_bdev(rtdev, mp);
>  	}
>  
>  	/*
> @@ -813,14 +813,14 @@ xfs_open_devices(
>  	xfs_free_buftarg(mp, mp->m_ddev_targp);
>   out_close_rtdev:
>  	xfs_blkdev_put(rtdev);
> -	fs_put_dax(dax_rtdev);
> +	fs_dax_release(dax_rtdev, mp);
>   out_close_logdev:
>  	if (logdev && logdev != ddev) {
>  		xfs_blkdev_put(logdev);
> -		fs_put_dax(dax_logdev);
> +		fs_dax_release(dax_logdev, mp);
>  	}
>   out:
> -	fs_put_dax(dax_ddev);
> +	fs_dax_release(dax_ddev, mp);
>  	return error;
>  }
>  
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index e9d59a6b06e1..a88ff009e2a1 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -32,6 +32,8 @@ extern struct attribute_group dax_attribute_group;
>  struct dax_device *dax_get_by_host(const char *host);
>  struct dax_device *alloc_dax(void *private, const char *host,
>  		const struct dax_operations *ops);
> +struct dax_device *alloc_dax_devmap(void *private, const char *host,
> +		const struct dax_operations *ops, struct dev_pagemap *pgmap);
>  void put_dax(struct dax_device *dax_dev);
>  void kill_dax(struct dax_device *dax_dev);
>  void dax_write_cache(struct dax_device *dax_dev, bool wc);
> @@ -50,6 +52,12 @@ static inline struct dax_device *alloc_dax(void *private, const char *host,
>  	 */
>  	return NULL;
>  }
> +static inline struct dax_device *alloc_dax_devmap(void *private,
> +		const char *host, const struct dax_operations *ops,
> +		struct dev_pagemap *pgmap)
> +{
> +	return NULL;
> +}
>  static inline void put_dax(struct dax_device *dax_dev)
>  {
>  }
> @@ -79,12 +87,8 @@ static inline struct dax_device *fs_dax_get_by_host(const char *host)
>  	return dax_get_by_host(host);
>  }
>  
> -static inline void fs_put_dax(struct dax_device *dax_dev)
> -{
> -	put_dax(dax_dev);
> -}
> -
> -struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
> +struct dax_device *fs_dax_claim_bdev(struct block_device *bdev, void *owner);
> +void fs_dax_release(struct dax_device *dax_dev, void *owner);
>  int dax_writeback_mapping_range(struct address_space *mapping,
>  		struct block_device *bdev, struct writeback_control *wbc);
>  struct dax_device *fs_dax_claim(struct dax_device *dax_dev, void *owner);
> @@ -100,13 +104,14 @@ static inline struct dax_device *fs_dax_get_by_host(const char *host)
>  	return NULL;
>  }
>  
> -static inline void fs_put_dax(struct dax_device *dax_dev)
> +static inline struct dax_device *fs_dax_claim_bdev(struct block_device *bdev,
> +		void *owner)
>  {
> +	return NULL;
>  }
>  
> -static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
> +static inline void fs_dax_release(struct dax_device *dax_dev, void *owner)
>  {
> -	return NULL;
>  }
>  
>  static inline int dax_writeback_mapping_range(struct address_space *mapping,
