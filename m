Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeB1MRa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:17:30 -0500
Received: from mout.gmx.net ([212.227.17.21]:59595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeB1MR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:17:28 -0500
MIME-Version: 1.0
Message-ID: <trinity-0b7e3226-baf0-4d8e-a290-f774450957fc-1519820236087@3c-app-gmx-bs19>
From: "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
To: "Arvind Yadav" <arvind.yadav.cs@gmail.com>
Cc: "Cornelia Huck" <cohuck@redhat.com>, jwi@linux.vnet.ibm.com,
        ubraun@linux.vnet.ibm.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Aw: Re: [PATCH] net: iucv: Free memory obtained by kzalloc
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2018 13:17:16 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <78058d34-7cbb-a3e6-6471-e001b93a0523@gmail.com>
References: <6fbfc0b8aa75852c4eed4d05e4c165a493304ced.1519811528.git.arvind.yadav.cs@gmail.com>
 <20180228113042.6a2f5177.cohuck@redhat.com>
 <e4784c9b-380f-4dad-6883-b6350a9e0614@gmail.com>
 <20180228125629.3062ac1d.cohuck@redhat.com>
 <78058d34-7cbb-a3e6-6471-e001b93a0523@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:uDY7uw3S+00zx3x0mBpASWpoGsm2Zo6YlGOoi2khI2a
 xoWz+x3QTZAd5wbSHirXJD5BmOjwTGRxJSAy1sOMJNdTWMsyR/
 ahspvo3pbZTiaY/leRP8wfHmH1VFxx3Rtdxa+oMpLguME0JWSs
 EvlhB2mXwt5/UxDEzkEWwouefcEPGmjbQL1RwBDcvJ4TFzSj7Q
 UWU8LEtccbUIxigJ9yGvscmzIoQpD5Gp4+088T580iOPiFQhpL
 DbIzGY1raaFiIrzZYEgxb/ZDhLeTqlHXkr8t8tFCCYtEDsZLzV oFz2ZY=
X-UI-Out-Filterresults: notjunk:1;V01:K0:S66t7Y5aESY=:sl62EUd2bHcGiSwq7aOzaB
 CIdJIhxGyp4nevlJIxIRo7rrJGd9qtDZHPyhZqaxO3/UjUtL2naxn6pFQR7wbAIQyT3AuxGrb
 Meci2JCgBk8xs2XECs7UDBME1KJyAewo4Q6GPpLY3HYrRWlAOqiz6PsXX6rxt4YRgVkvGy2qs
 jyUkPbOBwGxACN7ogfNOiA4oRxYzP6mfSTxkt8H5loYMzSXNI7FZKSC8Es+hEV99mojiuc0Ui
 htuGsRPtqRPYqCrb/WR5IVUxtB1NGZXzexnu+rec4EAcPc3YBQOUAdTGQqvXNA51D6dJ/O/Aa
 /gfQs8ygEf0rIYi3JrCFNfgylsIu97/nKlxWc3AUaNRapR8qrlOWy+YuEnqV0wJBLF8c63FsT
 9ktb/pZ6Z5bPQVkbMOmme79ElteYtO1vXmDtMFk7xCuePSSG6zSV1elJysNx/v0IMwgPLl0/l
 79b7m1KHDfeSGHD3d/6QVvKOzuCDCEeWMEE0u98vLbgumji01AX8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> On Wednesday 28 February 2018 05:26 PM, Cornelia Huck wrote:
> > On Wed, 28 Feb 2018 17:14:55 +0530
> > Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> >
> >> On Wednesday 28 February 2018 04:00 PM, Cornelia Huck wrote:
> >>> On Wed, 28 Feb 2018 15:24:16 +0530
> >>> Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> >>>   
> >>>> Free memory, if afiucv_iucv_init is not successful and
> >>>> removing a IUCV driver.
> >>>>
> >>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> >>>> ---
> >>>>    net/iucv/af_iucv.c | 5 ++++-
> >>>>    1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> >>>> index 1e8cc7b..eb0995a 100644
> >>>> --- a/net/iucv/af_iucv.c
> >>>> +++ b/net/iucv/af_iucv.c
> >>>> @@ -2433,9 +2433,11 @@ static int afiucv_iucv_init(void)
> >>>>    	af_iucv_dev->driver = &af_iucv_driver;
> >>>>    	err = device_register(af_iucv_dev);
> >>>>    	if (err)
> >>>> -		goto out_driver;
> >>>> +		goto out_iucv_dev;
> >>>>    	return 0;
> >>>>    
> >>>> +out_iucv_dev:
> >>>> +	kfree(af_iucv_dev);
> >>>>    out_driver:
> >>>>    	driver_unregister(&af_iucv_driver);
> >>>>    out_iucv:
> >>>> @@ -2496,6 +2498,7 @@ static void __exit afiucv_exit(void)
> >>>>    {
> >>>>    	if (pr_iucv) {
> >>>>    		device_unregister(af_iucv_dev);
> >>>> +		kfree(af_iucv_dev);
> >>>>    		driver_unregister(&af_iucv_driver);
> >>>>    		pr_iucv->iucv_unregister(&af_iucv_handler, 0);
> >>>>    		symbol_put(iucv_if);
> >>> No, you must not use kfree() after you called device_register() (even
> >>> if it was not successful!) -- see the comment for device_register().
> >> Yes, Your are right. First we need to call put_device() then kfree().
> >> I will send updated patch.
> > No, that's not correct, either. device_register() will give up any
> > reference it obtained, and the caller did not obtain any additional
> > reference, so a put_device() would be wrong. A kfree() on a refcounted
> > structure is wrong as well.
> If you will see the comment for device_register() (drivers/base/core.c)
> there is mentioned that
> 'NOTE: _Never_ directly free @dev after calling this function, even
> if it returned an error! Always use put_device() to give up the
> reference initialized in this function instead.'
> But as per you comment. we should not use.
> Thanks,
> 

In case that device_register() fails simply call device_put(). This will decrement
the last reference and then free the memory.

Regards,
Lino
