Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753361AbeDSTFg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:05:36 -0400
Received: from mail-db5eur01on0075.outbound.protection.outlook.com ([104.47.2.75]:4832
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753132AbeDSTFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:05:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
Message-ID: <1524164724.17017.35.camel@nxp.com>
Subject: Re: [PATCH 4.9 181/310] net: phy: micrel: Restore led_mode and
 clk_sel on resume
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>, chris.ruehl@gtsys.com.hk,
        Lars Persson <lars.persson@axis.com>
Date: Thu, 19 Apr 2018 22:05:24 +0300
In-Reply-To: <223ffd4d-567e-6c5c-9581-5304494dd0b3@gmail.com>
References: <20180411183622.305902791@linuxfoundation.org>
         <20180411183630.390575424@linuxfoundation.org>
         <CA+G9fYtR_3AXKvhrkE3WEZhVOX6XwJ1r38PLav1XKkz4L4eQZQ@mail.gmail.com>
         <1524154267.17017.15.camel@nxp.com>
         <CA+G9fYs00cOVxuWYkfUxkdYZX5NGeTgBpwimCJ7tJbANbZwGEA@mail.gmail.com>
         <223ffd4d-567e-6c5c-9581-5304494dd0b3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::20)
 To VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4303;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;3:ZwP+ucXqblGE3enjilwY58CJY4VuvDSxaR9dKcDw6z/q02NInapOQyP9TUZx3+wL91Oywg6TBqMdY/VBpDXWbl0xh476CWADYhncvHLwb7enBvWSdiKboU/JRKJKGMpqrI46fIwFZbYwvsaO2xHLmECc1tfb9QuLhROUUpV9tQKu/nDsB+hzS2tD+8FiuHUhkKQsI2Cm3i6cNy9I3kRAUd2/ypS2DNth65mhel5AApN3TupNXPjM7GmA5XFp243V;25:Wr5GRQyhrQFkb6nEN6W6PAy0oF+aiOyrErtxLV5sk363oD6+QBbBumcIHXRc0tE6V3m3Lh1q9xZkPsvIBUu4Y0ucP60hyJYlzIBgkpQ6XwiY/ESEXGmGoWGdgfRkx+YhBomGL42Xbe9jn5SAXVZso432OcyQku+Z7RJafcX/XVf+TMC7vx75W6CYSTL6kiBB0Srh4OyoWtVg5gqsebvdGIRszqcAnqLsoQmQZkUp5upIRkVVhP1TkwR39DLRxHezTfSH9xyupAltql5q7EgwUh57cYlZIaLsw6dGoPEthRq3OhFsoz6Fylrld6kB5mxhvEDOFIgEMvwb1iv3QJie8w==;31:0H+tyK9/sNEy4FFV4mHkJmYtct9yOIMlJBT7uE1c32em8ck/pPvQDc5wiya40RE/hTx6SZLW3g/iClIvv6+akZao7pPKaXM3nvPEbKllmmS8nxRO+6cLJxfOLbkF7tJ1KATsjH989kesJ3XhBvoD/a1Q2IMlt1sK6WY4uOTGPiluqw/05ArfLezepbxnd7chh8pp/nSO3lI94XN1zJsCRJJotwslCq6uRZlTSVmU008=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;20:vYQh5qDrGEb2VlF8Jex+jPNf23+RvJ1T1RhS5NtDCzf/tQD6J1wisEM2tWJ1hb7EPncSPswF6tVKDk6LaotNw1qFpr/KledFCYQTimj80vMoTrP64GQiTTlGWOmLacGjsYSscezAWG49f/pktS7LqjbCsk5mGbZ1swNtMorWc3CVBgxa2FWaGgiC6epNkbkfalRKpUqxZaVnhXQLi+IPXjYBY5NwlEjiwL+Jq+YyBMGQXC/1eBhOUj7GJ+udmYLE4Ish145+AONkkkN5av8rP7/UJkTDboIvRXwzXd2mW6KiU/9Gj48kVuIusx1tXL6mbUhiirW45SSbrUF0xqp/OHshtemjgTpuMFZSO48RLVCGd635MKC10/R5bt5RnoJyf2O6RxA8Fgnhi3lcpzp5n6p5V8TAsyHcsvdHExyM5ipj8rynU1gI7etBgK3U2d1oPUBk/CSR08jJKxn5UsucMtJhhgNqfdgiJqbBr7FAJi/23NiDvkR89hIrQ7ukDhb2;4:wGmRBQziENO8yg+hOs+53pj1NBnT8A4l/sA36gFobZ6uBoXSETBz05pt/cclF1tXcLYqntywgvWyfKt8CbDgWAmHobUvZZUKp6dzlf/CYAiORhflXVdGH5u+QM4Tv/Q0NRiypCd2KDB/OVzSREs8tOt8DMirnLEAL9kwasbnu0PWC6vZk5poWCYuEOltvDLSxi7jErreIOnGFlZT0k51lKE3f0Pg+iRcVXaEMU9xeMeMIrm2n5vPMPITXyN+c+wX6J70L2pTLE1ZeQdyV7Ij0vHBmHQGx+kjsIMsEJQsgTZ5sdgG99Dsrfbjj1LAtsLo
X-Microsoft-Antispam-PRVS: <VI1PR04MB43033F2BDDE8E238991C43EDEEB50@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB4303;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4303;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(346002)(39380400002)(377424004)(39060400002)(8936002)(446003)(6486002)(50466002)(81166006)(3846002)(6666003)(44832011)(86362001)(7416002)(6116002)(305945005)(229853002)(478600001)(11346002)(2616005)(8666007)(6246003)(2870700001)(2906002)(25786009)(956004)(50226002)(476003)(186003)(103116003)(54906003)(7736002)(53936002)(47776003)(16526019)(36756003)(93886005)(386003)(26005)(23676004)(110136005)(5820100001)(5660300001)(52116002)(8676002)(76176011)(4326008)(53546011)(6496006)(66066001)(316002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4303;H:fsr-ub1664-115;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0MzAzOzIzOkR5NkE0ZndvRE0vOUlITTJScElRU0hnSHNM?=
 =?utf-8?B?MlZ5Ulpxam0wWmduQ25pWDcwTGhWWDdDRy9taHJwbzFLYXV4NEczU1NKU2kr?=
 =?utf-8?B?Sm1WUzIxdXE5cHJjdE82ek1tNjlpNmxQT2tkSzVwd1pwMHpmWlNpSTRkcWlB?=
 =?utf-8?B?MlE3K3FSVVhHZzNsbThzNUdHdWE1cHpJV1Awa3JUdmlNSkRuQmhWbnN2bUQx?=
 =?utf-8?B?dHREbHQzaTJtYitMVmRzQTlybnc3S3pGaGkzZnpUMlo5UTVWMTl0bURhQ2li?=
 =?utf-8?B?L1VxTkVaZHh2M2lIUTdQZDlVNkNxUEhFYTlMeVI1OTZHd0dGUEtvVzUrMEM2?=
 =?utf-8?B?SmtJeTJiWS8ySjFDaERVQmp6endpSWg1YVZVQktsVWVUM0FreGFYTlNOeUZC?=
 =?utf-8?B?cHBOSGtNTjdDbm00Nm9hR1NLcXVFaDU2M09rbEV5RWIwWVgyZ0ExWU1hM05H?=
 =?utf-8?B?cmJxa2tDREVLN2NvZG1pQkhOMVdPcnJORy9RL3gyYXAwRnoyR01BWEVqd2U1?=
 =?utf-8?B?eDlyVXgvbTBWSlpwdHBqVVRGTXEweTdOd2diUkN4VFArcUN2ZHJrV2VPYW9K?=
 =?utf-8?B?TFE1RlJIbGpydG1YSjBxRHI5ZjBQVHUwUUJTZUR4ejk2Y0ZlMndVNHkySjhr?=
 =?utf-8?B?U2tpeW9RSGpkS0xqRTFyWXE1eElsdkNubkRsOWJrRXVJMEdDd2FlOG4vaS9R?=
 =?utf-8?B?L1Ewa0NsTGROSmVCUmNqdUdPZGNVM0pkMEM2a1dxd1VwYkZONzJOOHgvak1i?=
 =?utf-8?B?WDlvQVp6QURsUFJ6N29NSFY1eUJVamtZVFZXRW5Gd1JLM2pKblNPUW1FcTNk?=
 =?utf-8?B?aisvdVlxZGY1U0MwOURpclVjNUxpaXNUN2VuNFJSRkxLZFh4Qit2VGI1MTFF?=
 =?utf-8?B?ZU1hMElFeVV3ZlVsTEE0cFczRzhKSk52OEVLOFF1U2MzM2dycCtaM1hQMmhN?=
 =?utf-8?B?RCtKWFVORExvT3BiOHBJREpuRUg2SjZUcWxoQ3FhamF1T1UraG9MZ1FPUHRx?=
 =?utf-8?B?dDJRZVoyUnVVb2s5STVQa01LL25FL3I3MXkzaXpGUzVwRWc2eEllRWFDZWVk?=
 =?utf-8?B?dWVINWlxYXB3NXdTcVR6bEIreGtGd3YrRXVXU1VqZlFWTDB0dHJnclZ1WnpT?=
 =?utf-8?B?ZjNXTmU5b2Y2aEltbWJ6bW50SytSL3BxV0F6UWhDRVphWC9NdlBkMXlQSmFm?=
 =?utf-8?B?Q2FSMjBVMlB1NmxBazM2Rm5CN3JGTHgvazlhak9YaFQra2ZXMmI0b0JOcE5E?=
 =?utf-8?B?dDRUUmVPMytSblh2ZHhXcyt6RE90MUlpaHVaaEJ4SmsrbE83cWsvRzBTZEYx?=
 =?utf-8?B?M2lyQjVpSnBVSStDS2pBVXBRMnpiWW1BSGtlUTBmYWtFc2hma2UvNzA3ZVlR?=
 =?utf-8?B?UVBkanpuL0FHTjJKM2xtSGlFS2F2NkNET21Qam5mRVQ3ZVdpWjQ2Qjhid3Np?=
 =?utf-8?B?aEp4MjdweXVXYVg1cEZxbnpuMG9wR3ZQVUszdSs5L3N1WHRMNXZ3ZDBUSUFx?=
 =?utf-8?B?eUl4YU1Zc0MyckgwM1gxWnNna1ZTS3N1azNab1dPdFJ0OXFFMGJtYUc4Sklu?=
 =?utf-8?B?blc0and6SlFwRXZrR3BuQS83ZUI2U05Fc0lrUytzZDBJUzAzU2tyL0QrTm5B?=
 =?utf-8?B?VVdrdEV0ZUJGaWo0Y3RsYVN6aDcvaXhCRkY3bUdTM2kvNXo2UFE4R21uanN3?=
 =?utf-8?Q?KRfO+Gvx0bzezj01Q5798ZHZMCF/M5a93+xfbWq?=
X-Microsoft-Antispam-Message-Info: cUpYIqbG0WPxvZ5hYuic5i86gGcA1HUiNo3rI+2QkvDnmfNnMUy3F3gwxE/gARo89Td/XZBNqfOsB3ubW2jUiKcrQOQcvdHnlWpmSGI3OVEidjUCfxVSWel0SxU4n5mRHyYE0TrIE2O2pzLuxiEdlydAwWDwHhJWGQ4N5uM/ixn3Y/SbIKfbqnBXd29wz9dD
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;6:FfEr3/MxhB6qRJvR2XSi1sfbq9YsGiSwKXTencZ3hES3vqg+oy9OJHq3B9lJaEoVOY3pHRM3cEzc02GKaPlgNM56Zo3xPiDmazHr/9Cr4++1cuyLFZSZ50S8Wubrj8IpDmqOjErybCoXtXoWaEKzwcKUyESaJlaNQWS4YhIclqJx39B4Uo+j3oeomzcJxyOvL3lTuotKxQGpCXkEdsP3KeFFI3H9puVbCUu3zDKRFBgZ7PC0km/4yYrLECCEFAdzAZlDe+Wc6xvXb1dgFlRO92OvLxCuDVN3eCf0MH8xk2OViySypE6uQmgXMCMc4TSK4jqpdjeeBM+fFFgn0nC//xlrzwIHPtnaQ7XKpT5iYo8begSlREsEp6Fe0q3SXmzZpvOnbplrvh0L1qkGbsX6ND0vMmBDUg9lAv8V926INvODfOp+xgpb9kn9fmrn9RaJ8nH3NA++kv4SfF/zJ0nSbg==;5:c7qr36N6v3ga95QXS49m0DUrc3lDBKXdn3XsfhTmXy2XRm6LTiAQlpXyg8ptLkj9kbrGSoTuBX5N1K/IpEiNIODDhc/qYGNiGqRlBWh0m52ex0bELZ+FmjvIec5B7x9QQ6cBYYphesja/H6JQU8YXPzFVAKAsEdjSH1n42dPioA=;24:SPYUB6cf1QU2JxD6BK0H1I+lp8rScXIVz8FFrcdolNq5VdjtYCOFQ8glvOQ/0NchwPFudJxAzQWSixOHW7dR5MrSMb6ppWy7WIio5lGLi9M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;7:HRvmKjQLeMV2M5zOSGWSuBrudc0TcFayjG4hmdBF5x6l2G9KhPGJZA93EePB2FOyMW+UikB4+MJj3Bk4f4ULVruqTkENKe6f4hNEt4rnVYVK6LnmJ0DmmvKF1eexiUQuitOOlCEwYTjQAzm51+ZejIScwyDfPqXwHIc9jruD38MHglo35/cSSAG6CY806p5UDlhbljWBg0mkUaNLui7zoq2gui79uMez/WBR75Go7P6YT+EyW/ipfXpNM7Qoa+91
X-MS-Office365-Filtering-Correlation-Id: 9b63bff7-136b-40e4-ea6d-08d5a62884f3
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 19:05:28.8054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b63bff7-136b-40e4-ea6d-08d5a62884f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-19 at 11:32 -0700, Florian Fainelli wrote:
> +Others who reported the same problem
> On 04/19/2018 11:24 AM, Naresh Kamboju wrote:
> > On 19 April 2018 at 21:41, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> > > 
> > > Looking at this dump I'm guessing that phydev->priv is NULL at the
> > > start of kszphy_config_reset and this really shouldn't be happening.
> > > 
> > > The phydev->priv field is initialized by kszphy_probe but your
> > > particular phy (KSZ9031) in linux-4.9.y does not seem to have .probe =
> > > kszphy_probe assigned in the struct phy_driver ksphy_driver array.
> > > 
> > > In upstream this was added by commit bfe72442578b ("net: phy: micrel:
> > > fix crash when statistic requested for KSZ9031 phy"). The message for
> > > that patch claims to fix a kernel crash on this command:
> > > 
> > >     ethtool --phy-statistics eth0
> > > 
> > > Looking at the code this issue should affect linux-4.9.y on your board.
> > > Naresh: can you please check?
> > After reverting the patch i have run this command and kernel oops
> > showed up.
> > ethtool --phy-statistics eth0
> > 
> > PC is at kszphy_get_stats+0x74/0xa8
> > 
> > ethtool --phy-statistics eth0 crashed on x15
> > 
> Chris proposed the following patch, which has not been formally
> submitted yet:
> 
> Meanwhile, Greg seems to have reverted the offending patch, so we should
> be good with 4.9.95.

I don't object to reverting my patch from linux-4.14.y but it seems all
the affected hardware would also be affected by the crash from ethtool
--phy-statistics eth0. Adding bfe72442578b to stable would be great
because it fixes more than the patch in the title.

In the other thread there is a mention that "Micrel KSZ8795",
"Micrel KSZ886X Switch", "Micrel KSZ8061", and "Micrel KS8737" might
still have problems after bfe72442578b. Is this because they have
kszphy_config_init but not kszphy_probe? All versions of
kszphy_config_init seem to check for a NULL priv.

--
Regards,
Leonard
