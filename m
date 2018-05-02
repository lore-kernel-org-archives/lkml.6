Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeEBF7A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 01:59:00 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55726 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBF65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 01:58:57 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w425whK8019245, This message is accepted by code: ctloc85258
From: Pkshih <pkshih@realtek.com>
To: "jprvita@gmail.com" <jprvita@gmail.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jprvita@endlessm.com" <jprvita@endlessm.com>,
        Birming Chiu <birming@realtek.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        Chaoming_Li <chaoming_li@realsil.com.cn>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        =?utf-8?B?6I6K5b2l5a6j?= <yhchuang@realtek.com>,
        "derosier@gmail.com" <derosier@gmail.com>,
        Steven Ting <steventing@realtek.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>, Shaofu <shaofu@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: RTL8723BE performance regression
Thread-Topic: RTL8723BE performance regression
Thread-Index: AQHTy7eSN578mCBr2kKVBzf45sjLwaPvW7kAgAACkICAAAPHAIAru2GAgADJ6dD//7BOgA==
Date: Wed, 2 May 2018 05:58:42 +0000
Message-ID: <1525240713.3735.3.camel@realtek.com>
References: <CA+A7VXX+z8FrDhzW2BQ6AGMJ=_j_53wkUL_YNgkreEbWSh+jCw@mail.gmail.com>
         <afdf0498-c0a9-936c-0c9b-1b6da6eb5957@lwfinger.net>
         <CA+A7VXWjWaSSUiX3h_rpFXrSwtUkynKR9tpvnsSe=DZrC+mF-Q@mail.gmail.com>
         <059b40f0-b8e2-b55f-92d5-a859ba4204a4@lwfinger.net>
         <CA+A7VXUUsZHD2gr9TBcV6jZBOPGZv7_vK-wWZ0MvGgiCnAiUgQ@mail.gmail.com>
         <5B2DA6FDDF928F4E855344EE0A5C39D13BEC14C0@RTITMBSV07.realtek.com.tw>
In-Reply-To: <5B2DA6FDDF928F4E855344EE0A5C39D13BEC14C0@RTITMBSV07.realtek.com.tw>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AA9C64DC3ABDC4BA362C66A1F4524D6@realtek.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w425x7J1003497

On Wed, 2018-05-02 at 05:44 +0000, Pkshih wrote:
> 
> > -----Original Message-----
> > From: João Paulo Rechi Vita [mailto:jprvita@gmail.com]
> > Sent: Wednesday, May 02, 2018 6:41 AM
> > To: Larry Finger
> > Cc: Steve deRosier; 莊彥宣; Pkshih; Birming Chiu; Shaofu; Steven Ting; Chaoming_Li; Kalle Valo;
> > linux-wireless; Network Development; LKML; Daniel Drake; João Paulo Rechi Vita; linux@endlessm.c
> om
> > Subject: Re: RTL8723BE performance regression
> > 
> > On Tue, Apr 3, 2018 at 7:51 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> > > On 04/03/2018 09:37 PM, João Paulo Rechi Vita wrote:
> > >>
> > >> On Tue, Apr 3, 2018 at 7:28 PM, Larry Finger <Larry.Finger@lwfinger.net>
> > >> wrote:
> > >>
> > >> (...)
> > >>
> > >>> As the antenna selection code changes affected your first bisection, do
> > >>> you
> > >>> have one of those HP laptops with only one antenna and the incorrect
> > >>> coding
> > >>> in the FUSE?
> > >>
> > >>
> > >> Yes, that is why I've been passing ant_sel=1 during my tests -- this
> > >> was needed to achieve a good performance in the past, before this
> > >> regression. I've also opened the laptop chassis and confirmed the
> > >> antenna cable is plugged to the connector labeled with "1" on the
> > >> card.
> > >>
> > >>> If so, please make sure that you still have the same signal
> > >>> strength for good and bad cases. I have tried to keep the driver and the
> > >>> btcoex code in sync, but there may be some combinations of antenna
> > >>> configuration and FUSE contents that cause the code to fail.
> > >>>
> > >>
> > >> What is the recommended way to monitor the signal strength?
> > >
> > >
> > > The btcoex code is developed for multiple platforms by a different group
> > > than the Linux driver. I think they made a change that caused ant_sel to
> > > switch from 1 to 2. At least numerous comments at
> > > github.com/lwfinger/rtlwifi_new claimed they needed to make that change.
> > >
> > > Mhy recommended method is to verify the wifi device name with "iw dev". Then
> > > using that device
> > >
> > > sudo iw dev <dev_name> scan | egrep "SSID|signal"
> > >
> > 
> > I have confirmed that the performance regression is indeed tied to
> > signal strength: on the good cases signal was between -16 and -8 dBm,
> > whereas in bad cases signal was always between -50 to - 40 dBm. I've
> > also switched to testing bandwidth in controlled LAN environment using
> > iperf3, as suggested by Steve deRosier, with the DUT being the only
> > machine connected to the 2.4 GHz radio and the machine running the
> > iperf3 server connected via ethernet.
> > 
> 
> We have new experimental results in commit af8a41cccf8f46 ("rtlwifi: cleanup 
> 8723be ant_sel definition"). You can use the above commit and do the same 
> experiments (with ant_sel=0, 1 and 2) in your side, and then share your results.
> Since performance is tied to signal strength, you can only share signal strength.
> 

Please pay attention to cold reboot once ant_sel is changed.
