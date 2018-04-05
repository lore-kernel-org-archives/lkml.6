Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDECHZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 22:07:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40632 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbeDECHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 22:07:24 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w3526vMl005533, This message is accepted by code: ctloc85258
From: Pkshih <pkshih@realtek.com>
To: =?utf-8?B?6I6K5b2l5a6j?= <yhchuang@realtek.com>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [rtlwifi-btcoex] Suspicious code in halbtc8821a1ant driver
Thread-Topic: [rtlwifi-btcoex] Suspicious code in halbtc8821a1ant driver
Thread-Index: AQHTzH0FBMUd+sG1L0SdpD1aR0w/0KPw5nUA
Date: Thu, 5 Apr 2018 02:06:56 +0000
Message-ID: <1522894016.1824.2.camel@realtek.com>
References: <20180405012540.GA24241@embeddedor.com>
In-Reply-To: <20180405012540.GA24241@embeddedor.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.41.250.117]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E72E70EE6E7344B8BE4596BEBB70DCD@realtek.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3527UjW006560

On Thu, 2018-04-05 at 01:25 +0000, Gustavo A. R. Silva wrote:
> Hi all,
> 
> While doing some static analysis I came across the following piece of code at
> drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c:1581:
> 
> 1581 static void btc8821a1ant_act_bt_sco_hid_only_busy(struct btc_coexist *btcoexist,
> 1582                                                   u8 wifi_status)
> 1583 {
> 1584         /* tdma and coex table */
> 1585         btc8821a1ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 5);
> 1586 
> 1587         if (BT_8821A_1ANT_WIFI_STATUS_NON_CONNECTED_ASSO_AUTH_SCAN ==
> 1588             wifi_status)
> 1589                 btc8821a1ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 1);
> 1590         else
> 1591                 btc8821a1ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 1);
> 1592 }
> 
> The issue here is that the code for both branches of the if-else statement is identical.
> 
> The if-else was introduced a year ago in this commit c6821613e653
> 
> I wonder if an argument should be changed in any of the calls to
> btc8821a1ant_coex_table_with_type?
> 
> 

It looks weird. Since we're in spring vacation, I'll check my colleague next Monday.

PK
