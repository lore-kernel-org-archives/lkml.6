Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeDDV4Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:56:16 -0400
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:51264
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752171AbeDDV4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:56:14 -0400
Authentication-Results: spf=pass (sender IP is 208.19.100.23)
 smtp.mailfrom=microsemi.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=microsemi.com;
From: Dave Carroll <david.carroll@microsemi.com>
To: Hans de Goede <hdegoede@redhat.com>,
        dl-esc-Aacraid Linux Driver <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI development list <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: aacraid code passes GFP_DMA32 to kmalloc this will not work
Thread-Topic: aacraid code passes GFP_DMA32 to kmalloc this will not work
Thread-Index: AQHTx21v4JMXSjkfM06+r2E5a5BPbKPxL6FQ
Date: Wed, 4 Apr 2018 21:56:08 +0000
Message-ID: <905a71ae9a5049c7994cedfdc6d64ef1@microsemi.com>
References: <258be5fa-f930-bc5e-d8a0-3d6b5bee0a8b@redhat.com>
In-Reply-To: <258be5fa-f930-bc5e-d8a0-3d6b5bee0a8b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.201.34.7]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:208.19.100.23;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(376002)(396003)(2980300002)(438002)(199004)(189003)(13464003)(53754006)(6246003)(108616005)(102836004)(316002)(476003)(2906002)(53416004)(356003)(229853002)(186003)(26005)(47776003)(446003)(77096007)(50466002)(68736007)(2616005)(126002)(11346002)(2900100001)(436003)(8676002)(14454004)(81156014)(23676004)(305945005)(53936002)(36756003)(110136005)(81166006)(5660300001)(336012)(6116002)(86362001)(7736002)(53546011)(106002)(97736004)(76176011)(24736004)(106466001)(486006)(478600001)(69596002)(2486003)(59450400001)(3846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0201MB1029;H:AVMBX3.microsemi.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD019;1:2ing4y0g0yEcyhQEYa+edu6X+CpQJiGcFUsV/8NUe0i9FnnryJtZRaIeESMLpKnMGw/aot5YmR3/82JoQSUWVUKARoYuhM50ONtO2B1M4Fjahl/FzFs6k1WV01BXIUN0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd766e3-c3b4-46b8-a02c-08d59a76e140
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY1PR0201MB1029;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB1029;3:6gYZ098kl/S/P3EE0xmN7/4Om9Vvtx6I75jZ+/Feui8qRTq5OSFJD3QNKIgDiRSAruvIvOPXQ5VsS3aiLZBrC3czEObjWTBbb9btWFDRaJOi7jX/E/aw/PdwEeywAlaa+LZtFlXwrEFtxFOW/uMr6Rv+2BDZWxUH1GchljpauZlTiDCTo7KN1qhypEJeSC7CuTsR0L6BRJ72guh8lPjITubxq0lJ8jGDRHR0EXxmqcdAi3na5s9GlyGLJ3LH67aZ3imie09uEFy+XVGWa59NEkyg4Sy4w2/5YN/tuuYMuahwLhjkRGTOBIHHAv7M00aE6HcR96yb4v8KIofjtE3bKlGqbcvIjOR0ERNQe6cJtgE=;25:1Jlsybl8AIY/mYA70wsbMQwF02QUKqMlLDzMZTJ6+dlGqrAW/j7HnRVYlhe/Y2IFNl5BC9DkPeaedV/HRsmH/B7Qu04coxNuG1trN9CxC+gkRTuO1XsO3K76jAoSLskFUhZWY/Ve500iA7ZKstcjQtIgGVOFC3R9yHBMepmFPCW9TUygFgZCVRYi/g9xY1OON3CzqOUQQC+St6Gm4EfENBDY/uisteEM5hU82XYvavvOp4ezUWXvB4yC/o0vVzeChGgor66mZsLofNYL8CcYgyx4mY/9e5IkI7trLGDVMHKeEoRxo5Cead5oXW4T4JtRCiNLZESvi7jLquoZ5BYGcw==
X-MS-TrafficTypeDiagnostic: BY1PR0201MB1029:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB1029;31:GyfWqz5br1meBXvuFRxdYYDdCiGMW7jZyVQElzfJGepL9VN0xSTVkZ5er2Cy4I+awhZb/ncbA8gO2N5JynM1xVX3IF4JjFgzLqoYhGyDUkhsByeZcadJsLKICmrPLZJtU6OHKCUr7lJ2T/eT3Br+xhA0IhA2RhYUZUMrQheNc9rxcRFxy9AX2JkjRJdp6FU5HLeuJzbMJspje5fwvxPF6apGH+/9dmU4M/p+JMrPBI8=;20:k/wkI5tYR2hhzLoIiIwmdA/dAkszl/Qfi37fRaiVJ3HjQ3XS0Lin75+sCfynH4ibscqrRwN27BTF0F5OLY4ON4AP5gUUbwKKzaiDk+XMkNEE8R79kiWbl9p3w6+CAfUmGCrlWipabQap7+ajD6uQ+SiWGFSqxbG1XfQqEa4+lfTE4fEVaAPMFMYFt8dc2HjUZzBIDMn5Ivdydxq/xHD7SonJJEYWIGjpwwdlyF+H+uo906syuXTdf4Yi4eb7Iwm36TyyFLFII8kB/pxwlxxZrzw03s5QLIgmbsUSUt+IusQir3Bf10lOiTL8WVgbaX+5uEgT1uiIVD49+ol7rwheSmubjTmynZ5mtGKzyRtAzdqO4h4kKwxpMfKYH0Uwf3dn5fh9tk5iV9OtGyKaFeuATz/BCgewkmQ0LYHgoup+FzHM46KFyy6qFJaXnr+wA2G77e0JcKmn+ad1Vvp7cVA9jS6YRpB6kiiN76cD1xt3Yc6iT3+rbQsb1ja/rcHXAuXb8XpKlWlWYHLNUy3qkQI/xnLMVuXae6+o9ru4KaGsxIvo/pwDnqZyNiW6jeNYI4RzhCV99DIdh6Q535sPuAYU66ymopZKhGeOw9yJzBrRbZU=
X-Microsoft-Antispam-PRVS: <BY1PR0201MB102933FBDD4B7E0671700BB0E0A40@BY1PR0201MB1029.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(72170198267865)(104084551191319)(146099531331640);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:BY1PR0201MB1029;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0201MB1029;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB1029;4:Unkk8KZncj7N2yBMXyd4C7fX+uDUTKvWwup4w6fJiv763fSMPL3wiBc2pBtN7cCyxrTFEYvPjAkNN727srWsoJGJi9s7JwsvFDXur9vUjQVeP7j2K5CPzPxDzFQzB/QDaBydGGSRt5dKXCy61D6algwlTPq2FyFrtEpaGk0eY0sst4dWmozp7cTdpOsYj1w4/f5xkgmHegtRgLeJ3OlXBx9qf+PEsxBe788nEM1InBXFKeHmMu5Fpiy4JD6cepE5QbwP7rwCiM386vU5YyKJwtVwlvAn+pZpfhUeXJnqXh72FyEoYVjjnSGa6uMGXovwPFDUDeL50XrH9IzfILb5lZ+Qr2Yvqoja66Ew1PnSmpoibwoegsoBDRzMIAuvNIE7e2WGJ3pFWOPX1wwSdhy0lfIT8fX7nkWEOPmS4juvJXk=
X-Forefront-PRVS: 0632519F33
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjAyMDFNQjEwMjk7MjM6ZUFTblpsUUxkUGF4Sm1hOUo1ZFRKZHlU?=
 =?utf-8?B?NjRxUFg0K0h4bG13WEhCYTZaVDJ5ZXZ0Q1ltSVhYQ1ZKanRKV0xFaHJEczZ5?=
 =?utf-8?B?MjVlM0VZUWN3bkJQcmJTSFd1NEhhVTlneXQrcncwZ0kzZDJCOGtMQkh3YlFL?=
 =?utf-8?B?NXhSSThLckJhVkZKZkJOZDJtNlJwWXBFUjNuaGJDYkZsZkgzUUI4YVBOa0Rw?=
 =?utf-8?B?Rm8xbUI1RDROQ3BaeG1PQk9jM1k4bkpmM3dWdXd2aDVWYnF6OHJEOXRnRTJT?=
 =?utf-8?B?c2I5WUp6MEk5VVNPMWl4MWwwSmMrMkxuZDhkREQ2dzZ5cDJ3R3pWNnFEVmt1?=
 =?utf-8?B?TDlPQSt4WkhiS1BhZldXK1lnWmtRUHUzajBHeHdNK01oQ29OV2pZdFJLY1hV?=
 =?utf-8?B?M0ZBM05QU2pyQUFtTHFiZlFiUWFZRjAwVHFsb1FZZ0dKTVE1QWVKMFJGVEFa?=
 =?utf-8?B?ZGxOSkpiVnZHWjhmWEM0dHNyRFBFRnZwL0JodkJ1VHM4dEViMFhMYWRRYXFq?=
 =?utf-8?B?WnJ1VjZucXBrUTRWMGtSTmlnRFdrTVZSVVNiQjFsR2VWRWFaWUtmSDJJTk95?=
 =?utf-8?B?YitKQm1DSkhoWkVRb3BnS1dFSi8yRlcxaW9hZHhiV09BR3BqWVZKYVNpbDN3?=
 =?utf-8?B?NFloNVpWMVY0bDZmcUJZR0VzelVtaVB0V2VzQzM3QUFqUE1Kc0VqczVBSW84?=
 =?utf-8?B?SnpRWGpsRWg5djRlM1dWWkRoakM1WWJKQWZ4OUR3N3g2R2RSZzBJc3VzUFNo?=
 =?utf-8?B?UGR6NmE3bWRVcm1iS1FuSlE5TkNlQ0MwRUoydFI3Vk1wcEhYYVkreWNBbHBp?=
 =?utf-8?B?Z1VSVFFPQnptRWU4VS93U1lvU29leDBzVmVnblF0enZkVFVFVUlFUFFzYnkr?=
 =?utf-8?B?TVE0SVJlYWJTQlVqK0trbWltTzI2YnZZcXp6WFR3Nm5GT2tmVHZVaGZXMDBV?=
 =?utf-8?B?Qkg4UXYzdCs1VmpWNno4SENwcUp0ZjlFcHAxNVFrdnNUR3NnSGE2cFBuUnZR?=
 =?utf-8?B?VGNGT2owMHhrYnUrL2JpVHJ1VTZQWG1PeWg2VThQVXgyZmV5R0kwaG9IU0RY?=
 =?utf-8?B?Y1BQeFZqT25aYng2R0g3WFZBNHlablkwaUJCQjZqRm1HakVzZzZnYVduSG1h?=
 =?utf-8?B?M3dkQkFWTGIrWDBtTEVISmozWlRCblY3bXdvRjFvK2QzQUNwQ0R3MHRkS2s5?=
 =?utf-8?B?YVBpUFRkYnFIMThNcERSdmg0Ym9RNVZMdnJmWlhUK000MC9EZ0w0Q0xoSXVq?=
 =?utf-8?B?KzFqYzJ6Q0s4WmUxVEQ1ODZTVzRHWllhd0tHOWdIMVl3eXppd1NUMngxSm9a?=
 =?utf-8?B?SHNGbjZOd3hJL2pFRzdYNG1naXp1WXplWFVTeFV0VktmZDcrMnB4UmRhOTRm?=
 =?utf-8?B?M1NSK1B6dkFsZlVPUVNXQ21yWm12NXJYU2lYNHFncGhCNFUvQ0FRb2h4R3Uv?=
 =?utf-8?B?M1ZMdng5TSswU3Jyc2V6REFlN3gxbUYvY1k5TU03M3QyZ3VDTHZ3TkIxbVZw?=
 =?utf-8?B?VTdDdDlqSVpyWnhVdG1TdUdaSHFuNlp5TDZTOFJTOGJUOThiMm5aVW9NTTVD?=
 =?utf-8?B?R1RKWkpqbVR1Ulc3OE9SY3liSHpSRHBZWGMwV3E0QW5IWStQYnZxTE83UFJR?=
 =?utf-8?B?UlNoSmh2MnZrSzAyQnA5bGkrSitaRVJNSTFmcE5zd2RNdCtXZGdYa3RQYmEy?=
 =?utf-8?B?UzRUSlJtQXdVS2lqTnU5V2VMWTlHcHA5SnF0dEJJbFJxMUpMckwwY3BWZXVO?=
 =?utf-8?Q?lQnN1iLWWMQ7ufV3Pg+0Amt0RUO/VgKI1xRc7Do=3D?=
X-Microsoft-Antispam-Message-Info: CTqAXgpTHYe//HX5+H3YuVbXcEFKOY78oIRjyW2+HBev4GYjcj+C17gA3ErB2Y2cxIO3YWRQ7BCb2PqllAat/omvFvbtXFm6r8eeBtqSs/2QFJohgvAfjs9I8BlivB0sy/VCX1NdTNh/+SI/owwMHRFvrq73+0nz2iH+7MNRonxOw/Hg8fpyKHWgMzxv+9hA
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB1029;6:nQvJ2sOTDO5Ciu1BPz9X+zKXfCdLYGzxnng9VDG809LU3YHZMGuFzKKMO7dr9BpT1alYor3mLANwvOCGZ4HJFUm0ntu0GZsw/1jqil7hkDEWkZkzZsneis4cC6pOWuArNIWlQBhyFwnuxggG1gph01q2Zq82DQwnVH4qVghCQJls6KnJ26PbK1JuHaf8H507vQBC4Ntcr/pqfs7uXgukyFF8QKI+XKeT+3L/PIKaV991gGzxql60MF+MSmRMT3BbwUGCsj69wJ52kZr5IOv2a9vZUBbxn6wtNKCOoZYbBRpHrNduxPC5wXRtyFY+XS6Shs5+2nvBwwSiv2nP7jenLkT2cO1oCJA9OlgQtzQhqH/9cNDixSZxXiVpkq8oiQhuSL4o5aINgh6/IkWQgT7UEs1dT3Tya3EGNab9LtCpTF/m47TpQu3w2gmnH9fp601LJ8VoZWqCEp35GcWT+rtdyQ==;5:goqnuzAIXVEIfqbB9hfds8JXBKoY578DJvlZUVQLjA+ofD7sGMKhlNNstQqgX247uO8WovdamRwtQJuaG9sizDTun5GigJrHti5MH5kooSlQUPRtBJ/ZC4JSHrsXg5Ol1qhocjTVtUiZZbKcUE+Rc2J3ezbZvN1IYzFHvkUv0xE=;24:naDm69RpFyp0b4axxE2Uv0jVeWsYYsKpeUO1OSxvsr5u81uDJCNTtOdoKVSWN0OeeT9SwY+rXEcErupVu4znlGfKJoEEdaxNavmCfTM8+rs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0201MB1029;7:M5X/pDN85o/6gNS545QS5t8Qb5NOWv/irMRpkymb7dPvMNBna/zsDt5wDHWDtJbV7G3ZI2MU8rMUeTQke1fnSz3pevcM3Tm48n21PebscPyPR5WZFH9X+t4WV8iPQgDotkDBcnxQ9X/U1KjmJscpaHgryxnjzfBP+qzrSNNMEUX1At/smcMqLTsRSkpymxT0Hy2ha4jrcQEE1aT3uwBrDzESzfIdJ7olVNKiYVZaufJDdtR6zbasEnQXKdkowqTR
X-OriginatorOrg: microsemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2018 21:56:11.6692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd766e3-c3b4-46b8-a02c-08d59a76e140
X-MS-Exchange-CrossTenant-Id: f267a5c8-86d8-4cc9-af71-1fd2c67c8fad
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f267a5c8-86d8-4cc9-af71-1fd2c67c8fad;Ip=[208.19.100.23];Helo=[AVMBX3.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0201MB1029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w34LuLdn024261

> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Sent: Thursday, March 29, 2018 8:51 AM
> To: dl-esc-Aacraid Linux Driver <aacraid@microsemi.com>; James E.J.
> Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen
> <martin.petersen@oracle.com>; SCSI development list <linux-
> scsi@vger.kernel.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: aacraid code passes GFP_DMA32 to kmalloc this will not work
> 
> 
> Hi All,
> 
> Since I made the same mistake myself I've done a quick grep for
> GFP_DMA32 in the kernel and drivers/scsi/aacraid/commctrl.c came up as a
> result of this grep, it does:
> 
>                                  p = kmalloc(sg_count[i], GFP_KERNEL|GFP_DMA32);
> 
> But kmalloc always returns memory from the normal memory-zone, if you need
> memory from a specific memory-zone like the
> DMA32 zone, you must use the dma allocation functions (which from a quick
> glance at the code seems appropriate here) or directly call alloc_page or
> __get_free_page.

Hi Hans,

I did run into this issue myself recently ... Thanks for a reminder to send in a patch to
correct this.

-Dave
> 
> Regards,
> 
> Hans
