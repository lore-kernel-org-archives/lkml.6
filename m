Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeEBJhS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:37:18 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46394 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBJhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:37:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180502093711euoutp02504abb8144170a24e29f16f4b1e3d4ce~qykdpdx5H1521415214euoutp02v
X-AuditID: cbfec7f4-6f9ff700000043e4-18-5ae986c64871
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] thermal: exynos: set trips in ascending order in
 exynos7_tmu_initialize()
Date: Wed, 02 May 2018 11:37:08 +0200
Message-id: <3681690.4QzPMdFsyU@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180501100242.GJ27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsWy7djPc7rH2l5GGbz5xmkx77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAldG3xW5gvfcFeu/9LE0MN7i7GLk5JAQMJHomjqbrYuRi0NIYAWjxLx/e6Ccz4wSzYva
        WWCqzk+8yghiCwksY5RYtSQVoug3o8SMXxvBitgErCQmtq8CKxIR0JNofN/GBFLELLCKUaL/
        0zsmkISwQJrEnP8H2UFsFgFVibZf/5m7GDk4eAU0JdadCgIJiwp4SWzZ1w5WzgkUPnB1DSuI
        zSsgKPFj8j2wXcwC8hL79k9lhbB1JM4eW8cIsktCYA2bxOO9v6CudpHY2n8GyhaWeHV8CzuE
        LSNxeXI3C0RDM6PEtx17mCESExgl9qwXgrCtJQ4fvwi1gU9i0rbpYIdKCPBKdLRBlXhILG05
        wgIRdpRouscDD5SN+9YwTmCUnYXk7llI7p6F5O4FjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS
        9ZLzczcxAtPB6X/Hv+xg3PUn6RCjAAejEg+vQd6LKCHWxLLiytxDjBIczEoivCs7nkUJ8aYk
        VlalFuXHF5XmpBYfYpTmYFES543TqIsSEkhPLEnNTk0tSC2CyTJxcEo1MPa/s/xZUPAl7323
        xGlJRZGuS4Yc0xZJiPgvWFoVnulW/2yn/grRy113Atq5nuyWWf5k1cvemFij77xshYHGYatd
        g+NXWEddWig989j1T7wntn3QYXuzwbrvdZ+AbVzK+SdyCqd4/ywLerrmW+I8kfVe/13/TZWt
        9K0/t6lhoWLJTqGAKXvvtCuxFGckGmoxFxUnAgCdcV8aAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xa7pH215GGRw8w2cx77Osxfwr11gt
        Lu+aw2bxufcIo8WM8/uYLJ487GNzYPPYOesuu8fiPS+ZPO5c28Pm8XmTXABLFJdNSmpOZllq
        kb5dAldG3xW5gvfcFeu/9LE0MN7i7GLk5JAQMJE4P/EqI4gtJLCEUeJ2a1QXIxeQ/ZdR4tjJ
        32AJNgEriYntq8BsEQE9icb3bUwgRcwCqxglVrb2MoMkhAXSJOb8P8gOYrMIqEq0/foPFOfg
        4BXQlFh3KggkLCrgJbFlXzsTiM0JFD5wdQ0rxLLljBKbf99gA0nwCghK/Jh8jwXEZhaQl9i3
        fyorhK0lsX7ncaYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFB
        u+3Yzy07GLveBR9iFOBgVOLhNch7ESXEmlhWXJl7iFGCg1lJhHdlx7MoId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYzTnb7O2lbLuP/JtW06zb3f54oe
        U9hYPDf60Y7cLD+Rirl611/tkldsFPPJ2VYq/TNi3nHxZyt0LP2jCkvORvNscljj4DY5LfyE
        8ubr9fEM5/888LvQI/W4UH9TzarawOOBmh51R5k1LnPMWtjdd+HUocI1szKzNv0U1Z56xemF
        yJyQDw3L0i2UWIozEg21mIuKEwHv0KZOVgIAAA==
X-CMS-MailID: 20180502093709eucas1p177dd30efffed16e763fcad10686af159
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180502093709eucas1p177dd30efffed16e763fcad10686af159
X-RootMTR: 20180502093709eucas1p177dd30efffed16e763fcad10686af159
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-14-git-send-email-b.zolnierkie@samsung.com>
        <20180501100242.GJ27619@mai>
        <CGME20180502093709eucas1p177dd30efffed16e763fcad10686af159@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 01, 2018 12:02:42 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:28PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Set trips in ascending order in exynos7_tmu_initialize() (it should
> > make no difference in driver operation). This prepares the driver
> > code to moving trips setting from ->tmu_initialize method to
> > exynos_tmu_initialize().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 12b60e2..571511f 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -618,7 +618,7 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
> >  	sanitize_temp_error(data, trim_info);
> >  
> >  	/* Write temperature code for rising and falling threshold */
> > -	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
> > +	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
> 
> Capped with data->ntrip ?

No need to, the code in question is removed in patch #14 (also Exynos7
DTS doesn't define more trip points than data->ntrip).

> >  		tz->ops->get_trip_temp(tz, i, &temp);
> >  		temp /= MCELSIUS;
> >  		exynos7_tmu_set_trip_temp(data, i, temp);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
