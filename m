Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeEWMob (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:44:31 -0400
Received: from mail-he1eur01on0127.outbound.protection.outlook.com ([104.47.0.127]:6303
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932070AbeEWMo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:44:29 -0400
Subject: Re: Expected result when racing listen(2) on two sockets bound to the
 same address
To: Alexander Kurtz <alexander@kurtz.be>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <a3ecf04de4fded7c71284a9695b7146d284d1f22.camel@kurtz.be>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4887534b-cac3-65b5-8c9f-f736c1e56ba3@virtuozzo.com>
Date: Wed, 23 May 2018 15:44:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <a3ecf04de4fded7c71284a9695b7146d284d1f22.camel@kurtz.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:206:1::34) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:ikCR7RQXoG06NhwhIOZ7bjVcA3zMYmOknVeOTyk8ixh5fgSv/nJkecQSVjW7Cr2BulUUspSJRLLMShrLYJ+jLeftqHr2Zy8DSH+JujhWZj8IzdH+HGjX2LczRfUk/ijaLZLSZ9+gGQ1oikH7O4a/C6JvdNxBXMRcpneiERkJsXGYYB+Ol7RqCGIUoJQX7g8RSCivV/guqN90xAF0opeA6HQP2cFysIPOm58O+SQ5tmxmDNVGIUGAvBGyquxG0eeq;25:XwkFOPcJU4dZFXTncW6demY4vO5sL7i8cfT5Utzz8X5HTqSPzyk8F7DBgWdOvnD7w265rKz2ljgZB7F6qVP6CGYo33ZgJ2ZTX/eO8DZQOkG6kVJ9YvtAo5pZKJn1rGaMdjWMEn0/qu6e0He/pqcEDv2o06tWO+saI1JtgG2HXwQg6n4FeKrmayNRYRyq8CAKzSvCyW02d6lNMpU0GbdCv1XWccKTie5OGJ+WoqNu5GYFU8tn2tSFSNI6XsZxIp/n6k1sSDt5p9HV1PAPW77cdqcLzqqnKIbHsG9/4RvhAKJWDqVnvw1CDM/Gy5k3DXjkBjhPNnvCNAI7InDk8pXlrA==;31:uxSoQKMZ6tmrTebS+CN1QmRfQzNq9ZagRBD8jMCdy97KhReI1jkAufw86hphdDtYwdjjYNHvgGE7GfpnkUhocfaYjV5kCcFn99XUqgMcL8IQ8uezEvXsGXqX4Wa7CgM9a6W/QkIVWoF6LsaH7SpAhf3UnLJFBNIVt23vliFkVJCTiT4vqpe4/CZ2EV/dfvz1nCw7cUGnVeVN0Tbes6Ht1kgylV5JJKkCxS/8Nsa1dhA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:SlErrXG8VkqfL5LnKr+GDvfrVUQK1r571AwySrIlCNd18ZwFB/DgieqOiuGhi25jxP0+n8fSnNDjTv13/pMev8NE8HyJ+JLEpIOWaYKETtOKIJFSR/GE5kCny75WFh1INWZN5DPhT1R3heMhBkrKXA+j7tSc1b+onpdOcqEpmBbWwKaZt/vNAHX2YM8RJsIM5IHxjbUMsO7EDF5XB7ykbba2DYeAbv3OR0QRuWABPfdZIXgqDutoWvueQhArU6PUzUirAQoIb7VoOnsTsAZBF2r0aMqXt2Ecf4RI/2HyCHPz0Zg2QTgqsZQTNxg+EN5izbChgTiolpPJmleR2y80GXRw+1XLOTVpFFcYki2hyh17Hv8BTB3m32DDt/yrmMLwYge/6P1zp5KshRE88tCoYANVj5xJqNL0pWyjUlIet+rNps0Mn+Xlv8daLgkToEqqzdJWX/wE9I/w3Ck6nt76DYBgiTAo7yJLJ/SSUeNN6lQu3/ymrYz1QeuO4WlR08ch;4:jVzgEdXPkLEFOU+tEdKqyCsVlhWFvCpgc+YKL+3mC+zNogURs8jdtP8upaV11xaT3/unj6tm/zyJO9Iam0tHNSXM6fRDgGcHRuKMt5IJxs0LtMlcwVwgW69AjKlG0ViWpgiASK2WOCAtdttNYZFli7w86YfyhkTEPtEpwsN0q0IIlcGuzWtMk8scjF7ooR0+GONpBsT0N6IJ0xb6fFQYCStcny0CioS8DhB+b7SXoJQKOghncOg0FFaFJv6g7Mz8mvzFlqVeF4RHYqxxNCkyLA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340D8C916C58BAAFC28F761CD6B0@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(39850400004)(376002)(366004)(346002)(189003)(199004)(377424004)(65826007)(68736007)(5660300001)(8676002)(105586002)(106356001)(6116002)(6486002)(81166006)(2906002)(478600001)(6246003)(81156014)(31686004)(53936002)(65956001)(58126008)(50466002)(3846002)(65806001)(6666003)(25786009)(66066001)(230700001)(47776003)(86362001)(52116002)(52146003)(36756003)(229853002)(305945005)(446003)(97736004)(186003)(23676004)(16576012)(2486003)(53546011)(316002)(64126003)(59450400001)(956004)(7736002)(55236004)(8936002)(476003)(26005)(76176011)(11346002)(77096007)(16526019)(386003)(2616005)(31696002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6aERZSkZsblppczZXNVFYcGdwNW5UWkI4?=
 =?utf-8?B?NmNTTU9iMEpsN0FJNUJ4U2d1aUNwenpkTWFaRXEzbzdqMjQ2bC9IOGp5b25Z?=
 =?utf-8?B?RmJKOTgxMWV2djExWXFSRFdNKzVUV3JIS25WQmVpZnBIV2xUa3E2WU9LRGZH?=
 =?utf-8?B?bk5lQTQ3K28vaE42WUpSdzlQeERwa0tqNEZUN1hiQmdIY3NpdExtcEdaVzlo?=
 =?utf-8?B?MXJNOEtxWnhlYWdsSmIvakZLWTUwZkF2VGFCa3l5eFpuSWVHdVNVS0JyRVR3?=
 =?utf-8?B?MVdGQnJsV0ErM1JXNUxPWkxybzVjRG4zTUxOTnp2T0VEdEgvS1ZkQnBDcytF?=
 =?utf-8?B?Smcza2tpV0MzZW02L3JiQmpLejZxTy93SnNPdzJnaVgzSm1QanJQRURHM0g4?=
 =?utf-8?B?cHZiV0l2K0hnNXJIa05sTzBGNVpoaXdJS0NFaFVOV0VyRXBGQ2huU3cvRWV3?=
 =?utf-8?B?c0poM0p3M0xyUTdLa0hubkM4R1YvNncxbDVZL3hzbXU3dUMrWW5iRDNqQUZ1?=
 =?utf-8?B?cDVEaDhMRkw0Q1I0Z3ZvbUtVVjY3bFNoMjZEcnQ2NjdQZTJzRGNhUjRqTUZy?=
 =?utf-8?B?QU1GR3VmdmJmVWhmd2loZ3BXb1V1L3FLWG9XTWVCcmRrSmtwRm5nTGw2eHd3?=
 =?utf-8?B?VjlrazFQUzNUK0pMSklQQnVMa0I4NStBYzlPdG4rL1AxRlVjQm5MNHp1ODNw?=
 =?utf-8?B?WDcwOVRVWlY4N3IzTDVJN2xFbHJyVU9ONlpGNnlLa1pZZUdJU05IQ3BlMWZB?=
 =?utf-8?B?WG84QnBFTTBUNVR5b3FNUkhGUG1FbDlzZTJ5QUxCNmppYzlGVEhSdGJvUnhC?=
 =?utf-8?B?ckFTdERsdHNMWTByczdhb3FWN2pKSnB4RmJGVEhkVnJhMnZaYWV5dUQ4MGcy?=
 =?utf-8?B?Wk1JY0FrTGR2MHppeWVmKzdqQmI3eXpMTkJjbjR6K1lsemcxUjlkN0F5bi9a?=
 =?utf-8?B?QjhwalJnc3hOTk4remNrWHlQblZ5ZFNaRVE0Q2pOd1FTU1hERFphVjhaZVVm?=
 =?utf-8?B?U3ZIS2NFWUl3V1puMEQrNnIxZGJlYTQvMVV0QWs1ZWxvdm1IdzFVYVZYdkRV?=
 =?utf-8?B?c1J4YXR0U2twcE5URnJ4cXp5QWIyeTlRdVBQVW5OTVBsbmVMa3hxaXdRYy9W?=
 =?utf-8?B?Sy9yMnJOVXJ1czBuVHZ2aDZzTjN4M0ZuVkR5TUZXaWJYQ09vV2tsM0s2MjRs?=
 =?utf-8?B?MFdVQ2hFWW5TZ0o4SDdGNWo2aTcvWUZiNDBmY0JtU1FVZThjY2tXSTdrcWUw?=
 =?utf-8?B?RVFTMnFiT0hrOEUzaElSSnY5RmZTNmJ2cVN2OGF6a2xzYytnSnJKbXh3bEl3?=
 =?utf-8?B?clZjc21KN2RNa1BnM0dSdCtNMWhJbzE5Sm51NEVMKzNqWGh5QXBnL2YyMnRV?=
 =?utf-8?B?dmpFT254cTAzZWxSQTQ4eWZESFdXU1ZoY1BqL0xJNVVIdk90ZkJUWFFkZEI1?=
 =?utf-8?B?ckxiQktQYWU4d3NhT3poZ25ZVkVSZVlRUmFIM3UzSFFERUNzZmRNUHo4SXVy?=
 =?utf-8?B?eE82WGZUV3kvMVJzKzlkeEIrejRWdFM4Q0JRTWxtamNzWExGY0F0L1dERnVn?=
 =?utf-8?B?OTBneThGa3ZrbExMYkNJTi9RbWhKbEVncDBETk85RE9EemQvUXYvSldRYWRQ?=
 =?utf-8?B?dDBJb3BhV3V4K0YrT2VoU0ZWZW01UUNQRDZvM0JOZHlMWTdreWp4MzdQbDZQ?=
 =?utf-8?B?QTJiemcraW80VmJVcFo0WTd2bnpnSjMyMy83dG56QWF0dk1xdUJ4elhEd1NH?=
 =?utf-8?B?OVVkcnBlSkVKbkVYYmczL0c1bEZ1czMrQm02T3czS1lzOFpPMUVOMDdWQXNw?=
 =?utf-8?B?Zk5zcjAwczRDc2xvV0s3ejZJOWJ2Nld0cENVNDl4MWltTVh0YjJhMGJpUVZV?=
 =?utf-8?B?ek9yaUhWU3R4NWluM0c1Q0VHeGJwLzM2eW1LZGZLempNdGR6d3NxcHVUbzU3?=
 =?utf-8?Q?mK1DWU9lyXFRoyXwfO7sQ80IXEvy4fWE=3D?=
X-Microsoft-Antispam-Message-Info: i18f1YIZ/M8a/TgsXwQPbHHdSQ7xD02I3sTVwcH37dtxolCxlJghmJ7nXAsgL0fE9Qx47V60rmGnCTRxUMAhyq3SZsy1OoAbuNaXpetH+JdU7cC5TSptVhHUtC8Wy1DN0yVGUBCrcYELFP2h6FAnguugODDeS9PkS8C6Jp7RP8LGUzBpvLmxbp2AgZ3Sj1EO
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:VPNZYwwawCRs0XMoYDmXhCdEDIOzO1WFuvfkBE8y/IpiwEbirkFLUcFDhrYvFr1NzbOaD0jHnOjVRFzSejyd4i3mwXPvIIHPJD9VgsoEOJgErxEApQdwJExO4P3vx1hJvkiHn/wZUI3dxwPBx8kHz3+PVo+6Qzo4k54ODkheu4nGTYwDQnBpjntKG1iWD5LIaSEd13c8fVCEBSf8UPb6nk+Pyw5S6UXzZ44GQqdqRO355L6RsCKcpvHgNZijysFX2tgKV4RS0u/RkuHFZUVnqduxG7Zz6e3A7NEMw30e/k1Fr/ThjPcpkFFRfg8JA4ddzldxiVagsxJm2tuA6XHHDhcH5ZbyJSvLIjthw7gef3v15fJAWuw4WCeq3txExY77CW4ch0/9/cH3YYbEgLYrRlC/lNNYxUK0O5HjMi8ZwgIPwFNCIhNPwEq9dompgHbT27iRxqt2ZENrS1j/0VcGbw==;5:Np2ZkzUaX6xzZk3w83xR259eq1OP9hjRztH0tfxoEClSz7w+TZClkcuVZCyjZCUrgE+AbvUCosZuLyFbx53gCExXbFLC6dVRsc2vHMB3YH6flmYyNO+a2hxhcRmO1POhua6P5ZpQJE0wK/QpWCwUh1Ft2umerOI8BXw+S2J/J5o=;24:wS1S2FqFj6Nrh1bkUulwTCedOgSzCMAqAZ2o8YD+E8Yxt67oOL3kKhO9wFkv+NGv9Oiz6QKIMCqx9raBy4ZEsMpAiAfgDEcb+LBF0t7S1RM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:zLAT4lzOvwVcvxt+7V6pZVOQfId77lYPxVXdgpFYAXyvbx/1AOqmb5uXv1/q5KYG2sjxu0LPU679FFd+QmKsbWQJXcPvfcjOYJ2J4GPrpHZirGAoGZrYRaKF5PNuCuuzdOZNMRg7/0OisacKzYTiW3LDUV6bamllFqhUIMKpQY9inVYpGO367zhm4mdMHCiAGaIPV+3tBmLS1NPqW1EWFgZ8IBxLNR2rMx8QMDqpRmWlDBaVi5FNMfWgrj1hen8D;20:Qyh8xgoc1a4yl3pUoOlobIuwizj3+BrnGDMIu60MHsY1HbKhyhwpqm6tq+tl2CcT7+/OVt5CS6SOcHY9j6vQjG/pSXefTuXRNeIl7sq8dkUNE83E2c5KlLIpOuUYRzcuOk5FQZ25fK3NgdluLO8SGTEPfvr2Byn3YiYcHKaxZxM=
X-MS-Office365-Filtering-Correlation-Id: b84b66cb-7f6c-44f0-8235-08d5c0aaeb07
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 12:44:25.9154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b84b66cb-7f6c-44f0-8235-08d5c0aaeb07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23.05.2018 14:15, Alexander Kurtz wrote:
> [Please keep me CC'ed; I'm not subscribed to the list]
> 
> Hi!
> 
> The program shown below (also available at [0]) does the following:
> 
>  * Create two sockets
>  * Enable SO_REUSEADDR on both
>  * Bind both sockets to [::1]:12345
>  * Spawn two threads which both call listen(2) on one socket each
>  * Check that at least one thread succeeded
> 
> Unfortunately, when running this program on Linux 4.16, it is sometimes
> possible that neither thread succeeds in calling listen(2):
> 
>     $ uname -a
>     Linux shepard 4.16.0-1-amd64 #1 SMP Debian 4.16.5-1 (2018-04-29) x86_64 GNU/Linux
>     $ time make
>     cc -Wall -Wextra -pedantic -Werror -O3    listenrace.c  -lpthread -o listenrace
>     for i in `seq 10000`; do ./listenrace; done
>     listenrace: listenrace.c:58: main: Assertion `result1 == 0 || result2 == 0' failed.
>     Aborted
>     listenrace: listenrace.c:58: main: Assertion `result1 == 0 || result2 == 0' failed.
>     Aborted
>     listenrace: listenrace.c:58: main: Assertion `result1 == 0 || result2 == 0' failed.
>     Aborted
> 
>     real	0m8.201s
>     user	0m6.801s
>     sys	0m2.141s
>     $ 
> 
> As can be seen, on 3 runs (out of 10000) calling listen(2) failed in
> *both* threads. Is this to be expected (i.e. "don't do this then") or
> could this be some race condition in the Linux kernel?

At the first sight, it is in kernel and is expected:

inet_csk_listen_start()
{
	/* There is race window here: we announce ourselves listening,
	 * but this transition is still not validated by get_port().
	 * It is OK, because this socket enters to hash table only
	 * after validation is complete.
	 */
        inet_sk_state_store(sk, TCP_LISTEN);
        if (!sk->sk_prot->get_port(sk, inet->inet_num)) {

}

CC netdev.

Kirill
