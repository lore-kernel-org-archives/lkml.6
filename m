Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeBHBHC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:07:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60923 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:07:00 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w1816ia1023067, This message is accepted by code: ctloc85258
From: Pkshih <pkshih@realtek.com>
To: "mka@chromium.org" <mka@chromium.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "craigb@chromium.org" <craigb@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "teravest@chromium.org" <teravest@chromium.org>
Subject: Re: [PATCH] rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c
Thread-Topic: [PATCH] rtlwifi: rtl8192cu: Remove variable self-assignment in
 rf.c
Thread-Index: AQHToFIAyOqZfQSgjU+gONMUw6fzrKOY38WAgAAEXQCAAEdIgA==
Date: Thu, 8 Feb 2018 01:06:43 +0000
Message-ID: <1518052003.2680.1.camel@realtek.com>
References: <20180207202634.98937-1-mka@chromium.org>
         <947198f5-23eb-afbc-7979-fbc38b6a1a37@lwfinger.net>
         <20180207205136.GB116483@google.com>
In-Reply-To: <20180207205136.GB116483@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.107]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E73D6A31959094D9E2C3CB2EC626385@realtek.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w18178Pj030930

On Wed, 2018-02-07 at 12:51 -0800, Matthias Kaehlcke wrote:
> El Wed, Feb 07, 2018 at 02:35:59PM -0600 Larry Finger ha dit:
> 
> > On 02/07/2018 02:26 PM, Matthias Kaehlcke wrote:
> > > In _rtl92c_get_txpower_writeval_by_regulatory() the variable writeVal
> > > is assigned to itself in an if ... else statement, apparently only to
> > > document that the branch condition is handled and that a previously read
> > > value should be returned unmodified. The self-assignment causes clang to
> > > raise the following warning:
> > > 
> > > drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c:304:13:
> > >    error: explicitly assigning value of variable of type 'u32'
> > >      (aka 'unsigned int') to itself [-Werror,-Wself-assign]
> > >    writeVal = writeVal;
> > > 
> > > Replace the self-assignment with a semicolon, which still serves to
> > > document the 'handling' of the branch condition.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > >   drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c
> > > index 9cff6bc4049c..4db92496c122 100644
> > > --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c
> > > +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c
> > > @@ -301,7 +301,7 @@ static void _rtl92c_get_txpower_writeval_by_regulatory(struct ieee80211_hw
> *hw,
> > >   			writeVal = writeVal - 0x06060606;
> > >   		else if (rtlpriv->dm.dynamic_txhighpower_lvl ==
> > >   			 TXHIGHPWRLEVEL_BT2)
> > > -			writeVal = writeVal;
> > > +			;
> > >   		*(p_outwriteval + rf) = writeVal;
> > >   	}
> > >   }
> > > 
> > 
> > As the branch condition does nothing, why not remove it and save the
> > compiler's optimizer a bit of work? The code looks strange, but it matches
> > the rest of Realtek's USB drivers.

Agree Larry's comment.

> 
> Sure, I am happy to change it to whatever the authors/maintainers prefer.
> 
> I'll wait a bit before respinning for if others feel strongly about
> keeping the branch.
> 
> ------Please consider the environment before printing this e-mail.
