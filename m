Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeBBMxm convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:53:42 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55167 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeBBMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:53:08 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w12Cr1oV007943, This message is accepted by code: ctloc85258
From: Hau <hau@realtek.com>
To: Francois Romieu <romieu@fr.zoreil.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd <nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] r8169: add module param for control of ASPM disable
Thread-Topic: [PATCH net-next] r8169: add module param for control of ASPM
 disable
Thread-Index: AQHTm3VptCaa3TYsykSp40X/dNZxG6OPq0AAgAFjuKA=
Date: Fri, 2 Feb 2018 12:52:59 +0000
Message-ID: <80377ECBC5453840BA8C7155328B5377D3410C47@RTITMBSV06.realtek.com.tw>
References: <1517500663-24052-1-git-send-email-hau@realtek.com>
 <20180201232652.GA19190@electric-eye.fr.zoreil.com>
In-Reply-To: <20180201232652.GA19190@electric-eye.fr.zoreil.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.177.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Francois Romieu [mailto:romieu@fr.zoreil.com]
> Sent: Friday, February 2, 2018 7:27 AM
> To: Hau <hau@realtek.com>
> Cc: netdev@vger.kernel.org; nic_swsd <nic_swsd@realtek.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] r8169: add module param for control of ASPM
> disable
> 
> Chunhao Lin <hau@realtek.com> :
> [...]
> > @@ -5878,6 +5881,20 @@ static void rtl_pcie_state_l2l3_enable(struct
> rtl8169_private *tp, bool enable)
> >  	RTL_W8(Config3, data);
> >  }
> >
> > +static void rtl_hw_internal_aspm_clkreq_enable(struct rtl8169_private
> *tp,
> > +				bool enable)
> > +{
> > +	void __iomem *ioaddr = tp->mmio_addr;
> > +
> > +	if (enable) {
> > +		RTL_W8(Config2, RTL_R8(Config2) | ClkReqEn);
> > +		RTL_W8(Config5, RTL_R8(Config5) | ASPM_en);
> > +	} else {
> > +		RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
> > +		RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en);
> > +	}
> > +}
> 
> s/enable(..., false)/disable()/
> 
> static void rtl_hw_internal_aspm_clkreq_enable(truct rtl8169_private *tp) {
> 	void __iomem *ioaddr = tp->mmio_addr;
> 
> 	RTL_W8(Config2, RTL_R8(Config2) | ClkReqEn);
> 	RTL_W8(Config5, RTL_R8(Config5) | ASPM_en); }
> 
> static void rtl_hw_internal_aspm_clkreq_disable(truct rtl8169_private *tp) {
> 	void __iomem *ioaddr = tp->mmio_addr;
> 
> 	RTL_W8(Config2, RTL_R8(Config2) & ~ClkReqEn);
> 	RTL_W8(Config5, RTL_R8(Config5) & ~ASPM_en); }
> 
> If you really want to factor something out, you may use helpers that set or
> clear bits according to the 3-uple (tp, register, bits) but foo_enable(..., false)
> is pointlessly convoluted.
> 
> --
> Ueimor
> 
> ------Please consider the environment before printing this e-mail.

This two bits are related to hardware ASPM function, so I put them together into one function.
I could use helper to set these bits, if doing this can make the patch more readable for kernel team.

Thanks for inform me that net-next is closed. I will resubmit this patch when net-next open.

Thanks.

------Please consider the environment before printing this e-mail.
