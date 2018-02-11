Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbeBKJ2i (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:28:38 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:54880
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752273AbeBKJ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:28:35 -0500
From: Wen He <wen.he_1@nxp.com>
To: Adam Wallis <awallis@codeaurora.org>,
        Yang Shunyong <shunyong.yang@hxt-semitech.com>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "yu.zheng@hxt-semitech.com" <yu.zheng@hxt-semitech.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Graham Moore <graham.moore@linux.intel.com>,
        "okaya@codeaurora.org >> Sinan Kaya" <okaya@codeaurora.org>
Subject: RE: [PATCH] dmaengine: dmatest: fix container_of member in
 dmatest_callback
Thread-Topic: [PATCH] dmaengine: dmatest: fix container_of member in
 dmatest_callback
Thread-Index: AQHTk1VjC+EzSxjOrkqW9j62mCVEWqOBhzSAgB2F1QA=
Date: Sun, 11 Feb 2018 09:28:32 +0000
Message-ID: <DB6PR0401MB250319E17A025A8E03E84C72E2F00@DB6PR0401MB2503.eurprd04.prod.outlook.com>
References: <1516606108-40562-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <65509b03-7efb-c4ae-0965-8f2f659ddf1a@codeaurora.org>
In-Reply-To: <65509b03-7efb-c4ae-0965-8f2f659ddf1a@codeaurora.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com;
x-originating-ip: [192.158.241.86]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2295;7:PmKl+Y6ehDBGrR8o4d9GaHWLx76FwmX+nPdByqnLq3Ar49utiAhPmySHSBrSDZXR5pF+v+wrtCpJah0gHH6aUG59DBBwf9Md/D2T/FHPr6WIau6Jl1ITCQA/KleBO5PuIjWZpRr9GC9P8lQRzuBX+mwcsSrakvJHqd8g1X4jx/WGurDTrtG9rQfg8uW3J1ad2lFXPSmvrVtfbraPwvD6FIu5iEU8jMMjKXkK5Z/BoYvHQ+tTAQCrjJQXlmhS8//j
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 700795e8-4ea6-4f10-020e-08d57131d16a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0401MB2295;
x-ms-traffictypediagnostic: DB6PR0401MB2295:
x-microsoft-antispam-prvs: <DB6PR0401MB22955F1896A0F0D4CC04E0DAE2F00@DB6PR0401MB2295.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(45079756050767)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0401MB2295;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2295;
x-forefront-prvs: 058043A388
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(51914003)(13464003)(199004)(189003)(6306002)(99286004)(55016002)(81156014)(81166006)(316002)(2950100002)(2501003)(53936002)(5250100002)(54906003)(9686003)(33656002)(966005)(68736007)(110136005)(8676002)(229853002)(3660700001)(305945005)(7736002)(74316002)(478600001)(3280700002)(66066001)(6246003)(106356001)(6436002)(45080400002)(76176011)(14454004)(186003)(2900100001)(3846002)(6116002)(5660300001)(97736004)(86362001)(7696005)(105586002)(26005)(53546011)(6506007)(4326008)(25786009)(102836004)(8936002)(2906002)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2295;H:DB6PR0401MB2503.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Tqf0DgevsHWvbqzjtrvod95YePlxDP9AkonNqnSnbzqzYdLW776+ysadxkUivstP1Qh/lihuu2g8qMresHEhJA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700795e8-4ea6-4f10-020e-08d57131d16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2018 09:28:32.2733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2295
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1B9Si0s030028


Thanks for you, Shunyong.

Best Regards,
Wen He

> -----Original Message-----
> From: dmaengine-owner@vger.kernel.org
> [mailto:dmaengine-owner@vger.kernel.org] On Behalf Of Adam Wallis
> Sent: 2018年1月23日 22:32
> To: Yang Shunyong <shunyong.yang@hxt-semitech.com>;
> vinod.koul@intel.com
> Cc: dan.j.williams@intel.com; yu.zheng@hxt-semitech.com;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; Graham Moore
> <graham.moore@linux.intel.com>; okaya@codeaurora.org >> Sinan Kaya
> <okaya@codeaurora.org>
> Subject: Re: [PATCH] dmaengine: dmatest: fix container_of member in
> dmatest_callback
> 
> On 1/22/2018 2:28 AM, Yang Shunyong wrote:
> > The type of arg passed to dmatest_callback is struct dmatest_done.
> > It refers to test_done in struct dmatest_thread, not done_wait.
> >
> > Fixes: 6f6a23a213be ("dmaengine: dmatest: move callback wait ...")
> > Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> > ---
> >  drivers/dma/dmatest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c index
> > ec5f9d2bc820..906e85d6dedc 100644
> > --- a/drivers/dma/dmatest.c
> > +++ b/drivers/dma/dmatest.c
> > @@ -355,7 +355,7 @@ static void dmatest_callback(void *arg)  {
> >  	struct dmatest_done *done = arg;
> >  	struct dmatest_thread *thread =
> > -		container_of(arg, struct dmatest_thread, done_wait);
> > +		container_of(arg, struct dmatest_thread, test_done);
> >  	if (!thread->done) {
> >  		done->done = true;
> >  		wake_up_all(done->wait);
> >
> Thanks for the catch
> 
> Acked-by: Adam Wallis <awallis@codeaurora.org>
> --
> Adam Wallis
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies,
> Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
> Foundation Collaborative Project.
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger.
> kernel.org%2Fmajordomo-info.html&data=02%7C01%7Cwen.he_1%40nxp.co
> m%7C88161568a7fd4349149b08d5626e1661%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C636523147354196622&sdata=txItgvD3P%2FrQq
> MSmpZlTY1rA1yUeWxMHTlELO5vwy84%3D&reserved=0
