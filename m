Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeCTHxY convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:53:24 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:57954
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751527AbeCTHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:53:20 -0400
X-ASG-Debug-ID: 1521532396-093b7e71c10b440001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>
Subject: Re: [PATCH] vfio-mdev/samples: change RDI interrupt condition
Thread-Topic: [PATCH] vfio-mdev/samples: change RDI interrupt condition
X-ASG-Orig-Subj: Re: [PATCH] vfio-mdev/samples: change RDI interrupt condition
Thread-Index: AQHTtqxIeQWcfzn4sEm0fTEOSeK4O6PG5fWAgBFnhwA=
Date: Tue, 20 Mar 2018 07:53:02 +0000
Message-ID: <1521532382.3326.5.camel@hxt-semitech.com>
References: <1520492887-8021-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <c14684a6-9388-e38a-c99a-a393c5bcf2a4@nvidia.com>
In-Reply-To: <c14684a6-9388-e38a-c99a-a393c5bcf2a4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.61]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <249E22043C8DB740A09610F1D3810DAB@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1521532396
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4945 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49123
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alex,

Gentle ping. Could you please help to pull this patch?
It's a small fix and Kirti has reviewed.

Thanks.
Shunyong.


On Fri, 2018-03-09 at 11:36 +0530, Kirti Wankhede wrote:
> Thanks for fixing it.
> Patch looks good to me.
> +Alex to pull this patch.
> 
> Reviewed by: Kirti Wankhede <kwankhede@nvidia.com>
> 
> Thanks,
> Kirti
> 
> On 3/8/2018 12:38 PM, Shunyong Yang wrote:
> > 
> > When FIFO mode is enabled, the receive data available interrupt
> > (UART_IIR_RDI in code) should be triggered when the number of data
> > in FIFO is equal or larger than interrupt trigger level.
> > 
> > This patch changes the trigger level check to ensure multiple bytes
> > received from upper layer can trigger RDI interrupt correctly.
> > 
> > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > ---
> >  samples/vfio-mdev/mtty.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> > index 09f255bdf3ac..7abb79d8313d 100644
> > --- a/samples/vfio-mdev/mtty.c
> > +++ b/samples/vfio-mdev/mtty.c
> > @@ -534,7 +534,7 @@ static void handle_bar_read(unsigned int index,
> > struct mdev_state *mdev_state,
> >  
> >  		/* Interrupt priority 2: Fifo trigger level
> > reached */
> >  		if ((ier & UART_IER_RDI) &&
> > -		    (mdev_state->s[index].rxtx.count ==
> > +		    (mdev_state->s[index].rxtx.count >=
> >  		      mdev_state->s[index].intr_trigger_level))
> >  			*buf |= UART_IIR_RDI;
> >  
> > 
