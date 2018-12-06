Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F23C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7E620850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bdmd3Tb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7E620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLFPD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:03:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37983 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:03:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181206150357euoutp0106bf4ac743b9e5c5396d4d2ef4ff0378~txp-0YCft1893918939euoutp010
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 15:03:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181206150357euoutp0106bf4ac743b9e5c5396d4d2ef4ff0378~txp-0YCft1893918939euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544108637;
        bh=aXSgiE8pezYxgz3hGqGhU+IzCAFRQ+R1cdl/SbmfsqM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Bdmd3Tb+a5/rC3NlrRnmn7mhTL4kfHDft99XitWiNgnqpJVCgA1+9JnQZbGHbsVHA
         MgyYBB9wQF8GRUptQAkrFvZcY0/Q7Ez1fuAUUD6WSQfXoeGJVtGBP0x6tZruWd4gX4
         EBnp4iYeG9TONWPbG6qfekEkbi7ISBw4kx62DeB8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181206150356eucas1p1f933ea35c5609191ca60b714b77d7a36~txp_8fLxz2522325223eucas1p1c;
        Thu,  6 Dec 2018 15:03:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7E.54.04806.C5A390C5; Thu,  6
        Dec 2018 15:03:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181206150355eucas1p28adea828445745719da51765153d59b3~txp9zo7150619406194eucas1p2k;
        Thu,  6 Dec 2018 15:03:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181206150355eusmtrp21a4f434c4a36ec23badbc4e9c9159c72~txp9lIug52678826788eusmtrp20;
        Thu,  6 Dec 2018 15:03:55 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-0a-5c093a5c3830
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.5F.04128.B5A390C5; Thu,  6
        Dec 2018 15:03:55 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181206150354eusmtip119e9d259874c98aaeae0201f15c92fad~txp9E5oth3040030400eusmtip1C;
        Thu,  6 Dec 2018 15:03:54 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: Revert
 "usb: dwc2: Disable all EP's on disconnect"
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2b48a7b5-f806-d761-97f6-885ae6c69a7e@samsung.com>
Date:   Thu, 6 Dec 2018 16:03:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUcRj3vfe9u/ess6+jeZKybtakkFJ7lzJt/nhX/VHG2nRbne4Nccfu
        UNLMGHFkUqEjjIUURuKo/DjVpbaSbH6tYgmp0xrapJ28vZT/Pp/n+Tz7fJ5nD0XIuoTOVKQm
        jtVqlNFykS3Z8nzxtafigESx2zqI6caiBiH91VpI0mXDYfTkyBMBnVbZIKLftZeI6IqqdILu
        yh0W0rM3RokACWPqyURMae8JpvP2fTHz4/MIybwYkjK5zbWIae6cQ8xc09bjVKjtQRUbHZnA
        ar39z9hGdNwNjx2TX6zrqSFSUBboEUUB9oWstCA9sqVkuAbBtNkg5sk8guqBNqRHkhUyt9Ix
        nuMwN1A+fofkRdUI0ixLq+Q7gtQaE8mpHHAwTI/VC7mGI76OYGE8G3GEwN0CmB9oFXAqEfYB
        vUUv4rAU+4Nx8jHBYRK7QdGHLDEXcCNWQPvUZV5iD723Jv4aSHAoVD1IEXKYwK7QaikheOwE
        IxNlAs4LcL8Yeiu+CPjcgVD06J6Qxw4wY24W89gFltvWBtIQXCniLwA4B8HDEqOIV/lBj/mt
        kEtE4B3Q0O7Nlw/DfGMxwV/SDoYs9nwIO8hvKVwtSyEzQ8art4PBXP/Ptruvn8hDcsO61Qzr
        1jGsW8fw37cckbXIiY3XqcNZ3V4Ne8FLp1Tr4jXhXmdj1E1o5a9eWc0LRtTxO8yEMIXkG6TT
        Y2KFTKhM0CWqTQgoQu4otfGiFDKpSpl4idXGnNbGR7M6E9pMkXInaZLN2CkZDlfGsVEsG8tq
        17oCSuKcgopNMdsWFkZVMjSjyjJFVW4xyILyjZPSQ4N1OR72n47kXnsZkhR8/icZe9WhtDc9
        71ef7/Jid+nN1klrap6r5uhshWfOmykX5ukx6x6Vv7vbzsCyipAlv/dRAdmjyeby8a7kkKpv
        fol+pqCCuKBNXXMZ+ztyc1S7lAWWZ+4n96k/ykldhNLHg9DqlH8AO4oCXVMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7rRVpwxBis7OSw2zljPavH633QW
        i/k3kyye3drLZNG8eD2bxeVdc9gsFi1rZbY40HeT1eLdlNvMDpwehw53MHrMOxnosX/uGnaP
        j09vsXicuMHr0bdlFaPHlv2fGT0+b5IL4IjSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQy9i3Mr3ggVLF2sMrmBsYOyW6GDk5JARMJBY8XMoCYgsJ
        LGWUaN2bDRGXkTg5rYEVwhaW+HOti62LkQuo5i2jxKUH58ESwgIhEjsXzWICSYgITGWU2NDz
        gAXEYRY4zCTx/cUuqJYbTBLXrs5jB2lhEzCU6HoLMouTg1fATmLHsz3MIDaLgIrEjHudYDWi
        AjESUy6/ZoWoEZQ4OfMJ2H2cAlESyzZD3MQsoC7xZ94lZghbXmL72zlQtrjErSfzmSYwCs1C
        0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERij24793LKDsetd8CFG
        AQ5GJR7eFw/YY4RYE8uKK3MPMUpwMCuJ8DLoccQI8aYkVlalFuXHF5XmpBYfYjQFem4is5Ro
        cj4wfeSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDMN4sseVen
        XerlLSTodMiMsXTeEk2x/7M6jn5xjNQ7eSA1wuPxhxSllWrNc09VdaxYeTtb2/jlt11Ov118
        rF/lLqxLny7GKvVml33IlkPnJ984dKVn/ps963d8rV0olGFSuKemKVqPbUnwJSeeH2yFv5e+
        3u1knKL4+XjMQj2pdrFG+6nNuxWUWIozEg21mIuKEwEEJoIz5wIAAA==
X-CMS-MailID: 20181206150355eucas1p28adea828445745719da51765153d59b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
        <20181121154504.13052-1-m.szyprowski@samsung.com>
        <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
        <20181123144307.GC2970@unbuntlaptop>
        <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Minas,

On 2018-12-04 13:34, Minas Harutyunyan wrote:
> On 11/23/2018 6:43 PM, Dan Carpenter wrote:
>> Ugh...  We also had a long thread about the v2 patch but it turns out
>> the list was not CC'd.  I should have checked for that.
>>
>> You have to pass a flag to say if the caller holds the lock or not...
>>
>> regards,
>> dan carpenter
>>
> Hi Dan, Marek, Maynard,
>
> Could you please apply bellow patch over follow patches:
>
> dccf1bad4be7 usb: dwc2: Disable all EP's on disconnect
> 6f774b501928 usb: dwc2: Fix ep disable spinlock flow.
>
> Please review and test. Feedback is appreciated :-)

Okay, I finally managed to find some time to check this. Your diff is
mangled, so I had to manually apply it. Frankly, it is very similar to
the revert I proposed. I've checked it on my test machines and it fixes
the issues. I'm not very happy about the unlock/lock design, but it
should be safe in this case and doesn't make the code even more complex.
Feel free to add a following tag to the final patch:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index 8eb25e3597b0..db438d13c36a 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -3165,8 +3165,6 @@ static void kill_all_requests(struct dwc2_hsotg 
> *hsotg,
>                  dwc2_hsotg_txfifo_flush(hsotg, ep->fifo_index);
>   }
>
> -static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
> -
>   /**
>    * dwc2_hsotg_disconnect - disconnect service
>    * @hsotg: The device state.
> @@ -3185,12 +3183,13 @@ void dwc2_hsotg_disconnect(struct dwc2_hsotg *hsotg)
>          hsotg->connected = 0;
>          hsotg->test_mode = 0;
>
> -       /* all endpoints should be shutdown */
>          for (ep = 0; ep < hsotg->num_of_eps; ep++) {
>                  if (hsotg->eps_in[ep])
> -                       dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
> +                       kill_all_requests(hsotg, hsotg->eps_in[ep],
> +                                                         -ESHUTDOWN);
>                  if (hsotg->eps_out[ep])
> -                       dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
> +                       kill_all_requests(hsotg, hsotg->eps_out[ep],
> +                                                         -ESHUTDOWN);
>          }
>
>          call_gadget(hsotg, disconnect);
> @@ -3234,6 +3233,8 @@ static void dwc2_hsotg_irq_fifoempty(struct 
> dwc2_hsotg *hsotg, bool periodic)
>                          GINTSTS_PTXFEMP |  \
>                          GINTSTS_RXFLVL)
>
> +static int dwc2_hsotg_ep_disable(struct usb_ep *ep);
> +
>   /**
>    * dwc2_hsotg_core_init - issue softreset to the core
>    * @hsotg: The device state
> @@ -3258,12 +3259,14 @@ void dwc2_hsotg_core_init_disconnected(struct 
> dwc2_hsotg *hsotg,
>                          return;
>          } else {
>                  /* all endpoints should be shutdown */
> +               spin_unlock(&hsotg->lock);
>                  for (ep = 1; ep < hsotg->num_of_eps; ep++) {
>                          if (hsotg->eps_in[ep])
>  
> dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
>                          if (hsotg->eps_out[ep])
>  
> dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
>                  }
> +               spin_lock(&hsotg->lock);
>          }
>
>          /*
> @@ -4072,7 +4075,6 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>          unsigned long flags;
>          u32 epctrl_reg;
>          u32 ctrl;
> -       int locked;
>
>          dev_dbg(hsotg->dev, "%s(ep %p)\n", __func__, ep);
>
> @@ -4088,7 +4090,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>
>          epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
>
> -       locked = spin_trylock_irqsave(&hsotg->lock, flags);
> +       spin_lock_irqsave(&hsotg->lock, flags);
>
>          ctrl = dwc2_readl(hsotg, epctrl_reg);
>
> @@ -4112,8 +4114,7 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
>          hs_ep->fifo_index = 0;
>          hs_ep->fifo_size = 0;
>
> -       if (locked)
> -               spin_unlock_irqrestore(&hsotg->lock, flags);
> +       spin_unlock_irqrestore(&hsotg->lock, flags);
>
>          return 0;
>   }
>
> Thanks,
> Minas
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

