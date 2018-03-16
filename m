Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeCPK6R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:58:17 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35907 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753179AbeCPK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:58:15 -0400
X-Google-Smtp-Source: AG47ELuH+0eHTsgQEcLE2hmJOPh1XbsPskGRev+SJ9J8qSF3j3s3jNtcg+CtWQniLlOsp/SUmFp60Q==
Date: Fri, 16 Mar 2018 11:58:11 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization for v3
 and v6 protocols
Message-ID: <20180316105811.t2nkwowqs66f6ji6@pali>
References: <20180312230915.26050-1-pali.rohar@gmail.com>
 <20180312231335.fnfxgenu22utr3z6@pali>
 <TYXPR01MB0719092EDE164BA6C576A1C7C7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20180314225816.634w64kggycj67ec@pali>
 <TYXPR01MB07191C487C66BA03E5D9AB3DC7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYXPR01MB07191C487C66BA03E5D9AB3DC7D10@TYXPR01MB0719.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2GAwNio021563

Great, thank you. Enabling that RAW/extended/SP4 mode is done by
sequence E6, E6, E6, F3, C8, F3, 14 (written in page 35) and it matches
what function alps_trackstick_enter_extended_mode_v3_v6() in my patch is
doing. So is correct.

On page 36 I see that there is described Method 1 for reporting stick
data which prevents cursor jumps. Seems that kernel uses Method 2.
Method 1 depends on some prioritization.

Do you have some information how to activate Method 1? Sometimes I
observe that problem with "cursor jumps" and from Method 1 could prevent
it. So I would like to try experimenting...

On Wednesday 14 March 2018 23:56:46 Masaki Ota wrote:
> Hi, Pali,
> 
> I have added Appendix.
> According to this spec documents, SP raw mode is SP 4 byte mode.
> I think Extended mode meaning is almost all the same as Raw mode.
> The description of how to set is written in Page 35.
> 
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Rohár [mailto:pali.rohar@gmail.com] 
> Sent: Thursday, March 15, 2018 7:58 AM
> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization for v3 and v6 protocols
> 
> Hi! Thank you for information.
> 
> Your PS/2 Aux Port Control description seems to really matches. Just there is reverse order of bits. Bit 0 in description is highest, therefore matches BIT(7) macro.
> 
> Bit 6 in description (BIT(1) in code) describes SP Extended Mode which alps.c enabled. And in that description is written:
> 
> "If 1 SP is extended packet format (driver must set SP raw mode and GP absolute mode)."
> 
> Do you have any idea what "SP raw mode" is? How to set it? For me it looks like it could be that extended mode of trackstick itself.
> 
> "GP absolute mode" I guess is GlidePoint absolute mode, therefore enable
> 6 byte absolute mode for touchpad.
> 
> And for Bit 7 (BIT(0)) is written:
> 
> This bit is used with the PS/2 Aux port to use the Pass-Thru mode ( see appendix A ). Do you have some information about this appendix A?
> 
> On Wednesday 14 March 2018 10:21:43 Masaki Ota wrote:
> > Hi, Pali,
> > 
> > I just picked up the spec which relates with trackstic.
> > 
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> > Sent: Tuesday, March 13, 2018 8:14 AM
> > To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Dmitry Torokhov 
> > <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Input: alps - Demystify trackstick initialization 
> > for v3 and v6 protocols
> > 
> > Masaki, if you have access to the internal ALPS v3 / Rushmore 
> > documentation, I would like to have a review of this patch or 
> > confirmation of those information :-)
> 
> --
> Pali Rohár
> pali.rohar@gmail.com

-- 
Pali Rohár
pali.rohar@gmail.com
