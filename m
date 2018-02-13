Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754218AbeBMFzR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 00:55:17 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:37897
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754149AbeBMFzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 00:55:15 -0500
X-ASG-Debug-ID: 1518501308-093b7e4b503e1a0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "wen.he_1@nxp.com" <wen.he_1@nxp.com>,
        "awallis@codeaurora.org" <awallis@codeaurora.org>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "graham.moore@linux.intel.com" <graham.moore@linux.intel.com>
Subject: Re: [PATCH] dmaengine: dmatest: fix container_of member in
 dmatest_callback
Thread-Topic: [PATCH] dmaengine: dmatest: fix container_of member in
 dmatest_callback
X-ASG-Orig-Subj: Re: [PATCH] dmaengine: dmatest: fix container_of member in
 dmatest_callback
Thread-Index: AQHTk1K7crr1vDON6EG8IuLHBXXE16OBAR2AgB2HfgCAAuj7gA==
Date: Tue, 13 Feb 2018 05:54:55 +0000
Message-ID: <1518501295.2660.9.camel@hxt-semitech.com>
References: <1516606108-40562-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <65509b03-7efb-c4ae-0965-8f2f659ddf1a@codeaurora.org>
         <DB6PR0401MB250319E17A025A8E03E84C72E2F00@DB6PR0401MB2503.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0401MB250319E17A025A8E03E84C72E2F00@DB6PR0401MB2503.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.28]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1CD22C8AFCF05429841FFF9ABD845A7@hxt-semitech.com>
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1518501308
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4949 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=HTTP_ESCAPED_HOST
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47864
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 HTTP_ESCAPED_HOST      URI: Uses %-escapes inside a URL's hostname
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1D5tKFW021541

Hi, Wen

You're welcome. That's why call this COMMUNITY! :-)

Shunyong.
Thanks.

On Sun, 2018-02-11 at 09:28 +0000, Wen He wrote:
> Thanks for you, Shunyong.
> 
> Best Regards,
> Wen He
> 
> > 
> > -----Original Message-----
> > From: dmaengine-owner@vger.kernel.org
> > [mailto:dmaengine-owner@vger.kernel.org] On Behalf Of Adam Wallis
> > Sent: 2018年1月23日 22:32
> > To: Yang Shunyong <shunyong.yang@hxt-semitech.com>;
> > vinod.koul@intel.com
> > Cc: dan.j.williams@intel.com; yu.zheng@hxt-semitech.com;
> > dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; Graham
> > Moore
> > <graham.moore@linux.intel.com>; okaya@codeaurora.org >> Sinan Kaya
> > <okaya@codeaurora.org>
> > Subject: Re: [PATCH] dmaengine: dmatest: fix container_of member in
> > dmatest_callback
> > 
> > On 1/22/2018 2:28 AM, Yang Shunyong wrote:
> > > 
> > > The type of arg passed to dmatest_callback is struct
> > > dmatest_done.
> > > It refers to test_done in struct dmatest_thread, not done_wait.
> > > 
> > > Fixes: 6f6a23a213be ("dmaengine: dmatest: move callback wait
> > > ...")
> > > Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> > > ---
> > >  drivers/dma/dmatest.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c index
> > > ec5f9d2bc820..906e85d6dedc 100644
> > > --- a/drivers/dma/dmatest.c
> > > +++ b/drivers/dma/dmatest.c
> > > @@ -355,7 +355,7 @@ static void dmatest_callback(void *arg)  {
> > >  	struct dmatest_done *done = arg;
> > >  	struct dmatest_thread *thread =
> > > -		container_of(arg, struct dmatest_thread,
> > > done_wait);
> > > +		container_of(arg, struct dmatest_thread,
> > > test_done);
> > >  	if (!thread->done) {
> > >  		done->done = true;
> > >  		wake_up_all(done->wait);
> > > 
> > Thanks for the catch
> > 
> > Acked-by: Adam Wallis <awallis@codeaurora.org>
> > --
> > Adam Wallis
> > Qualcomm Datacenter Technologies as an affiliate of Qualcomm
> > Technologies,
> > Inc.
> > Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a
> > Linux
> > Foundation Collaborative Project.
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > dmaengine" in the
> > body of a message to majordomo@vger.kernel.org More majordomo info
> > at
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fv
> > ger.
> > kernel.org%2Fmajordomo-info.html&data=02%7C01%7Cwen.he_1%40nxp.co
> > m%7C88161568a7fd4349149b08d5626e1661%7C686ea1d3bc2b4c6fa92cd9
> > 9c5c301635%7C0%7C0%7C636523147354196622&sdata=txItgvD3P%2FrQq
> > MSmpZlTY1rA1yUeWxMHTlELO5vwy84%3D&reserved=0
