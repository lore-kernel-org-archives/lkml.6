Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754749AbeD3Psg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:48:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33867 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753981AbeD3Psd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:48:33 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180430154831euoutp02d52b139c1e9e4490c84740fc62b62ce2~qQWGtpmad1829518295euoutp02H
X-AuditID: cbfec7f5-b45ff700000028a9-5e-5ae73ace86b6
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] thermal: exynos: fix trips limit checking in
 get_th_reg()
Date: Mon, 30 Apr 2018 17:48:29 +0200
Message-id: <26762578.lZtk787caq@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <20180430153431.GB27619@mai>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djP87rnrJ5HGbSvU7GY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvjy/cWtoIZ/BXXfx9hamCcz9PFyMkhIWAise73RKYuRi4OIYEVjBKTt51ihXA+M0ps
        2zaLDabqa+cxRojEMkaJ26/OsUM4vxklvn+dxwJSxSZgJTGxfRUjiC0ioCfR+L4NbC6zwCpG
        if5P75hAEsICYRInVnwEG8sioCrx89MFMJtXQEui5+IrZhBbVMBLYsu+drB6TgFNiYc9O6Bq
        BCV+TL4HtoxZQF5i3/6prBC2jsTZY+vAzpMQWMMmsef2UyaIu10kTr6axgphC0u8Or6FHcKW
        kejsOMgE0dDMKPFtxx5miMQERok964UgbGuJw8cvQm3gk5i0bTpQDQdQnFeiow2qxENiWe8N
        qPmOErfebIaG0S9Gic4J89gmMMrOQnL4LCSHz0Jy+AJG5lWM4qmlxbnpqcXGeanlesWJucWl
        eel6yfm5mxiBaeH0v+NfdzDu+5N0iFGAg1GJh5dD/nmUEGtiWXFl7iFGCQ5mJRHelR3PooR4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzxmnURQkJpCeWpGanphakFsFkmTg4pRoY9yZbNCSEtBnd
        4bN5+jrsUQ/HXwuTM5fCd5rp36wWabZa5vjafmf96Q+vnMV2Juoaxp3n62NQX+j7ecKPM2dk
        XCMqDOwNhI6/9rmSasl27CX3+1uPXObNYjibGtqtrP65ITaNU/7dpLpNbte8t3JfuS3Wevjf
        ftdpYjOM0wNuttg+iW/4b7tKiaU4I9FQi7moOBEAfMYq9gcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t/xy7pnrZ5HGXSvsrGY91nWYv6Va6wW
        l3fNYbP43HuE0WLG+X1MFk8e9rE5sHnsnHWX3WPxnpdMHneu7WHz+LxJLoAlissmJTUnsyy1
        SN8ugSvjy/cWtoIZ/BXXfx9hamCcz9PFyMkhIWAi8bXzGGMXIxeHkMASRont91tZIZy/jBJX
        ji5lA6liE7CSmNi+ihHEFhHQk2h838YEUsQssIpRYmVrLzNIQlggTOLEio9gDSwCqhI/P10A
        s3kFtCR6Lr4CqxEV8JLYsq+dCcTmFNCUeNizgw1i2zJGidf/7zBDNAhK/Jh8jwXEZhaQl9i3
        fyorhK0lsX7ncaYJjPyzkJTNQlI2C0nZAkbmVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIGh
        u+3Yz807GC9tDD7EKMDBqMTDyyH/PEqINbGsuDL3EKMEB7OSCO/KjmdRQrwpiZVVqUX58UWl
        OanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhjd/n8tz1d6OmdZE9u9TeWZd5ce
        8/7wsv1i8NsrSe0GOzNWe2o+kj7DkbGVKSdC7l38vIDIf0b39I/LHFnKL7enLvmbIXP1opKk
        oN1avT8eff3vMDNz4dyQtbvtYv6kl/5NZXgqIiW1K+uyWcGul5N+PepzvaV54Gthct6RoDWm
        Mtr7Iu3X6nAosRRnJBpqMRcVJwIASTRezFkCAAA=
X-CMS-MailID: 20180430154830eucas1p20a5d8e1d4d50c60f8072ce022b6afb1d
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180430154830eucas1p20a5d8e1d4d50c60f8072ce022b6afb1d
X-RootMTR: 20180430154830eucas1p20a5d8e1d4d50c60f8072ce022b6afb1d
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-7-git-send-email-b.zolnierkie@samsung.com>
        <20180430153431.GB27619@mai>
        <CGME20180430154830eucas1p20a5d8e1d4d50c60f8072ce022b6afb1d@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 30, 2018 05:34:31 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > of_thermal_get_ntrips() may return value bigger than supported
> > by a given SoC (i.e. on Exynos5422/5800) 
> 
> Can you elaborate a bit ?

Odroid-XU3 DTS file [1] define 6 thermal trip points (2 passive ones)
while data->ntrip is 4, the current code works fine by accident as
the threshold values for trip points 5 & 6 don't fit into 32-bits
threshold value (however since they are passive ones this is okay).

Of course the code for handling passive trip points still needs to
be fixed to properly handle all odd cases (which are not present in
current DTS files).

[1] arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi

> > so fix the code to not
> > iterate the loop for i values >= data->ntrip.
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 5a64879..58cd68e 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -311,9 +311,9 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
> >  	const struct thermal_trip * const trips =
> >  		of_thermal_get_trip_points(tz);
> >  	unsigned long temp;
> > -	int i;
> > +	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
> >  
> > -	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
> > +	for (i = 0; i < ntrips; i++) {
> >  		if (trips[i].type == THERMAL_TRIP_CRITICAL)
> >  			continue;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
